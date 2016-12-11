package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.rtti.CType.TypeRoot;

using StringTools;

class PlayState extends FlxState
{
	
	private var _roomList: FlxTypedGroup<Room>;
	private var _guestList : FlxTypedGroup<Guest>;
	private var _workerList: FlxTypedGroup<Worker>;
	
	private var buildingArea : FlxSprite;
	private var Ground    : FlxSprite;
	private var _modeText : FlxText;
	private var _versionText : FlxText;
	private var _upgradeMenu : UpgradeMenu;

	private var Mode :PlayerMode = PlayerMode.Normal;
	
	private var _room2Place : Room;
	
	
	private var _maxLevel : Int = 2;	// currently the level at which the highest room can be build (can be increased by the elevator)
	private var _minTilePosX : Int = 3;
	private var _maxTilePosX : Int = 14;
	
	private var _GuestSpawnTimer : Float = - 7;
	
	private var _Money : Int = 5000;
	private var _MoneyText : FlxText;
	
	private var _elevatorPosX : Int = 6;
	private var BuildingCostText : FlxText;
	
	private var _camTarget : FlxSprite;

	public var JobList : JobPool;
	private var JobListTimer : Float = GP.JobListTimerMax;
	private var WorkersSalaryTimer : Float = GP.WorkerSalaryTimerMax;
	
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = FlxColor.fromRGB(191, 191, 250);
		FlxG.camera.pixelPerfectRender = true;
		//FlxG.camera.zoom = 1.5;
		FlxG.camera.setScrollBounds(-500, 1500-FlxG.camera.width, -50000, 50000);
		_camTarget = new FlxSprite(GP.RoomSizeInPixel * 3, GP.GroundLevel - GP.RoomSizeInPixel);
		FlxG.camera.follow(_camTarget);
		FlxG.worldBounds.set( -5000, -5000, 50000, 500000);
		Ground = new FlxSprite(-500, GP.GroundLevel);
		Ground.makeGraphic(Std.int(GP.WorldSizeXInPixel), 600, FlxColor.BROWN);

		_upgradeMenu = new UpgradeMenu();

		_modeText = new FlxText(0, FlxG.height-15, 'Current mode: ' + Mode);
		_modeText.scrollFactor.set();

		_versionText = new FlxText(FlxG.width-200, FlxG.height- 25, 200, "Built on: " + Version.getBuildDate() + "\n" + Version.getGitCommitMessage());
		_versionText.alignment = FlxTextAlign.RIGHT;
		_versionText.scrollFactor.set();
		
		_roomList = new FlxTypedGroup<Room>();
		_guestList = new FlxTypedGroup<Guest>();
		_workerList = new FlxTypedGroup<Worker>();
		
		var reception : RoomReception = new RoomReception();
		reception.setPosition(GP.RoomSizeInPixel*3, GP.GroundLevel - GP.RoomSizeInPixel);
		reception.BuildMe();
		_roomList.add(reception);
		
		var elevator : RoomElevator = new RoomElevator();
		elevator.setPosition(GP.RoomSizeInPixel * _elevatorPosX, GP.GroundLevel - GP.RoomSizeInPixel);
		elevator.BuildMe();
		_roomList.add(elevator);
		elevator  = new RoomElevator();
		elevator.setPosition(GP.RoomSizeInPixel * _elevatorPosX, GP.GroundLevel - GP.RoomSizeInPixel - GP.RoomSizeInPixel);
		elevator.BuildMe();
		_roomList.add(elevator);
		
		var g : Guest = new Guest(this);
		_guestList.add(g);
		//g.setPosition(FlxG.random.float(0, 800), FlxG.random.float(0, 500));
		
		
		_MoneyText  = new FlxText(10, 10, 100, "", 20);
		//_MoneyText.screenCenter(FlxAxes.X);
		//_MoneyText.alignment = FlxTextAlign.CENTER;
		_MoneyText.scrollFactor.set();
		
		BuildingCostText = new FlxText(100, 100, 200, "", 14);
		JobList = new JobPool();
	
		buildingArea = new FlxSprite (_minTilePosX * GP.RoomSizeInPixel, GP.GroundLevel - _maxLevel * GP.RoomSizeInPixel);
		buildingArea.makeGraphic((_maxTilePosX -_minTilePosX) * GP.RoomSizeInPixel, _maxLevel * GP.RoomSizeInPixel, FlxColor.LIME);
		buildingArea.alpha = 0.2;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		_roomList.update(elapsed);
		_guestList.update(elapsed);
		_workerList.update(elapsed);
		_MoneyText.text = Std.string(_Money);
		
	
		_GuestSpawnTimer += elapsed;
		var max : Float = GP.GetSpawnTime(_guestList.length, GetHotelRoomNumber());
		//trace(max);
		if (_GuestSpawnTimer >= max)
		{
			spawnGuest();
			_GuestSpawnTimer = 0;
		}
		
		WorkersSalaryTimer -= elapsed;
		if (WorkersSalaryTimer <= 0)
		{
			WorkersSalaryTimer = GP.WorkerSalaryTimerMax;
			PayWorkers();
		}
		JobListTimer -= elapsed;
		if (JobListTimer <= 0)
		{
			JobListTimer = GP.JobListTimerMax;
			RecheckJobjs();
		}
	
		
		CameraMovement(elapsed);
			
		
		if (Mode == PlayerMode.Normal)
		{
			CheckGuests();
			if (FlxG.keys.pressed.B)
			{
				SwitchToBuildMode();
			}
			else if (FlxG.keys.pressed.E)
			{
				SwitchToElevatorMode();
			}
			else if (FlxG.keys.pressed.G)
			{
				SwitchToGeneratorMode();
			}
			else if (FlxG.keys.justPressed.J)
			{
				var j : Janitor = new Janitor(this);
				j.setPosition(GP.RoomSizeInPixel * 3, GP.GroundLevel );
				_workerList.add(j);
			}
			else if (FlxG.keys.pressed.Q)
			{
				SwitchToServiceRoom();
			}
			if (FlxG.mouse.justPressed)
			{
				for (r in _roomList)
				{
					if (FlxG.mouse.overlaps(r, FlxG.camera))
					{
						if(Type.getClassName(Type.getClass(r)) == "RoomHotel")
						Mode = PlayerMode.Upgrade;
						_upgradeMenu.open(r);
					}
				}
			}
		}
		
		else if (Mode == PlayerMode.Build ||Mode == PlayerMode.BuildElevator)
		{
			BuildingCostText.text = Std.string(_room2Place.Cost);
			BuildingCostText.setPosition(FlxG.mouse.x + GP.RoomSizeInPixel, FlxG.mouse.y);
			
			if (_Money < _room2Place.Cost)
			{
				BuildingCostText.color = FlxColor.RED;
			}
			else
			{
				BuildingCostText.color = FlxColor.WHITE;
			}
			
			var rx : Int = Std.int(FlxG.mouse.x / GP.RoomSizeInPixel);
			var ry : Int = Std.int(FlxG.mouse.y / GP.RoomSizeInPixel);
			
			if (FlxG.mouse.justPressed)
			{
				if (Mode == PlayerMode.Build)
				{
					BuildRoom();
				}
				else if (Mode == PlayerMode.BuildElevator)
				{
					BuildElevator();
				}
			}
			_room2Place.setPosition(rx*GP.RoomSizeInPixel, ry*GP.RoomSizeInPixel);
			if (FlxG.keys.pressed.ESCAPE)
			{
				Mode = PlayerMode.Normal;
			}
		}
		else if (Mode == PlayerMode.Upgrade)
		{
			if (FlxG.keys.pressed.ESCAPE)
			{
				_upgradeMenu.close();
				Mode = PlayerMode.Normal;
			}
		}

		_modeText.text = 'Current mode: ' + Mode;
	}
	
	function GetHotelRoomNumber() : Int
	{
		var ret : Int = 0;
		for (i in 0..._roomList.length)
		{
			if (_roomList.members[i].name.startsWith("room"))
			{
				ret += 1;
			}
		}
		return ret;	
	}
	
	
	function GetGeneratorRoomNumber() 
	{
		var ret : Int = 0;
		for (i in 0..._roomList.length)
		{
			if (_roomList.members[i].name.startsWith("generator"))
			{
				ret += 1;
			}
		}
		return ret;	
	}
	
	
	function RecheckJobjs() 
	{
		checkRoomsForCleaning();
	}
	
	function PayWorkers() 
	{
		trace("pay workers");
		var a : Int = _workerList.length * GP.WorkerBaseSalary;
		ChangeMoney( -a);
		
		trace("Pay generators");
		var gens : Int = GetGeneratorRoomNumber();
		a = Std.int(GP.MoneyGeneratorRunningCost * Math.pow(1.5, gens));
		ChangeMoney( -a);
	}
	
	
	
	
	
	function CheckGuests() 
	{
		var newlist : FlxTypedGroup<Guest> = new FlxTypedGroup<Guest> ();
		for (g in _guestList) 
		{
			if (!g.CanLeave)
			{
				newlist.add(g);
			}
		}
		_guestList = newlist;
	}
	
	function BuildRoom() 
	{
		if (CanBuildRoom())
		{
			_room2Place.BuildMe();
			_roomList.add(_room2Place);
			_Money -= _room2Place.Cost;
			Mode = PlayerMode.Normal;
			CheckPowerConnectivity();
		}
	}
	function BuildElevator() 
	{
		if (CanBuildRoom())
		{
			_room2Place.BuildMe();
			_roomList.add(_room2Place);
			_Money -= _room2Place.Cost;
			_maxLevel += 1;
			Mode = PlayerMode.Normal;
			CheckPowerConnectivity();
			buildingArea = new FlxSprite (_minTilePosX * GP.RoomSizeInPixel, GP.GroundLevel - _maxLevel * GP.RoomSizeInPixel);
			buildingArea.makeGraphic((_maxTilePosX -_minTilePosX) * GP.RoomSizeInPixel, _maxLevel * GP.RoomSizeInPixel, FlxColor.LIME);
			buildingArea.alpha = 0.2;
		}
	}
	
	
	function CanBuildRoom() : Bool
	{
		if (Mode == PlayerMode.Build)
		{
			// Check if room can be built on this level
			if (Std.int((GP.GroundLevel  - _room2Place.y) / GP.RoomSizeInPixel) > _maxLevel) return false;
		}
		else if (Mode == PlayerMode.BuildElevator)
		{
			trace(Std.int((GP.GroundLevel  - _room2Place.y) / GP.RoomSizeInPixel) + " " + (_maxLevel +1));
			trace(Std.int((_room2Place.x) / GP.RoomSizeInPixel) + " " + _elevatorPosX);
			if (Std.int((GP.GroundLevel  - _room2Place.y) / GP.RoomSizeInPixel) != _maxLevel +1) return false;
			if (Std.int((_room2Place.x) / GP.RoomSizeInPixel) != _elevatorPosX) return false;
		}
		if (Std.int(_room2Place.x / GP.RoomSizeInPixel) < _minTilePosX) return false;
		if (Std.int(_room2Place.x / GP.RoomSizeInPixel  + _room2Place.WidthInTiles) > _maxTilePosX) return false;
		
		// Check if room can be built on this position (no overlap with other rooms)
		for (r in _roomList)
		{
			if (_room2Place.overlapsOtherRoom(r))
			{
				return false;
			}
		}
		
		//TODO Check if there is enough money
		if (_Money < _room2Place.Cost)
		{
			return false;
		}
		
		return true;
	}
	
	function checkRoomsForCleaning()
	{
		for (i in 0..._roomList.length)
		{
			var r : Room = _roomList.members[i];
			var h : RoomHotel = Std.instance(r, RoomHotel);
			if (h != null)
			{
				JobList.addCleaningJob(h.name, h.DirtLevel);
			}
		}
	}
	
	
	function SwitchToBuildMode() 
	{
		Mode = PlayerMode.Build;
		_room2Place = new RoomHotel();
	}
	
	
	function SwitchToElevatorMode() 
	{
		Mode = PlayerMode.BuildElevator;
		_room2Place = new RoomElevator();
	}
	
	function SwitchToGeneratorMode() 
	{
		Mode = PlayerMode.Build;
		_room2Place = new RoomGenerator();
	}
	
	function SwitchToServiceRoom() 
	{
		Mode = PlayerMode.Build;
		_room2Place = new RoomService();
	}
	
	override public function draw() : Void 
	{
		super.draw();
		Ground.draw();
		buildingArea.draw();
		_roomList.draw();
		for (r in _roomList)
			r.DrawOverlay();
		_guestList.draw();
		_workerList.draw();
		_MoneyText.draw();		
		if (Mode == PlayerMode.Build || Mode == PlayerMode.BuildElevator )
		{
			_room2Place.draw();
			BuildingCostText.draw();
		}
		else if(Mode == PlayerMode.Upgrade)
		{
			_upgradeMenu.draw();
		}

		_modeText.draw();
		_versionText.draw();
	}
	
	
	public function getRoomByName (n : String ) : Room
	{
		for (r in _roomList)
		{
			//trace(r.name);
			if (r.name == n) return r;
		}
		return null;
	}
	
	public function getFreeMatchingRoom ( g : Guest) : Room
	{
		for (r in _roomList)
		{
			if (StringTools.startsWith(r.name, "room"))
			{
				if (r.isFree)
				{
					r.lock();
					return r;
				}
			}
		}
		
		return null;
	}
	
	public function ChangeMoney (amount : Int )
	{
		_Money += amount;
	}
	
	private function CheckPowerConnectivity() 
	{
		for (r1 in _roomList)
		{
			var g : RoomGenerator =  Std.instance(r1, RoomGenerator);
			
			if (g != null)
			{
				for (r2 in _roomList)
				{
					var ld : Int = Std.int(Math.abs(g.Level - r2.Level));
					if (ld <= 2) r2.Powered = true;
					
					var xd : Int = Std.int(Math.abs(g.TilePosX - r2.TilePosX));
					var dist : Float = Math.sqrt(xd * xd + ld * ld );
					if (dist < GP.GeneratorNoiseReach)
					{
						r2.Props.NoiseFactor = (GP.GeneratorNoiseReach- dist)/GP.GeneratorNoiseReach;
					}
				}
			}
		}
	}
	
	
	private function spawnGuest () 
	{ 
		var g :Guest = new Guest(this); 
		_guestList.add(g); 
	}

	function CameraMovement(elapsed:Float):Void 
	{
		var CamMovementSpeed : Float = -100;
		if (FlxG.keys.pressed.LEFT ||FlxG.keys.pressed.A)
		{
			_camTarget.x += CamMovementSpeed * elapsed;
		}
		else if (FlxG.keys.pressed.RIGHT||FlxG.keys.pressed.D)
		{
			_camTarget.x -= CamMovementSpeed * elapsed;
		}
		if (FlxG.keys.pressed.UP ||FlxG.keys.pressed.W)
		{
			_camTarget.y += CamMovementSpeed * elapsed;
		}
		else if (FlxG.keys.pressed.DOWN||FlxG.keys.pressed.S)
		{
			_camTarget.y -= CamMovementSpeed * elapsed;
		}
		if (_camTarget.x < FlxG.worldBounds.x) _camTarget.x = FlxG.worldBounds.x;
	}
}
