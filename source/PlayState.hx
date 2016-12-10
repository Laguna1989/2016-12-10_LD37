package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import haxe.rtti.CType.TypeRoot;

class PlayState extends FlxState
{
	
	private var _roomList: FlxTypedGroup<Room>;
	
	private var Ground : FlxSprite;
	
	private var Mode :PlayerMode = PlayerMode.Normal;
	
	private var _room2Place : Room;
	
	private var _guestList : FlxTypedGroup<Guest>;
	private var _maxLevel : Int = 2;	// currently the level at which the highest room can be build (can be increased by the elevator)
	private var _minTilePosX : Int = 3;
	private var _maxTilePosX : Int = 10;
	override public function create():Void
	{
		super.create();
		Ground = new FlxSprite(0, GP.GroundLevel);
		Ground.makeGraphic(Std.int(GP.WorldSizeXInPixel), 600, FlxColor.BROWN);
		_roomList = new FlxTypedGroup<Room>();
		_guestList = new FlxTypedGroup<Guest>();
		
		var reception : RoomReception = new RoomReception();
		reception.setPosition(GP.RoomSizeInPixel*3, GP.GroundLevel - GP.RoomSizeInPixel);
		reception.BuildMe();
		_roomList.add(reception);
		
		var elevator : RoomElevator = new RoomElevator();
		elevator.setPosition(GP.RoomSizeInPixel * 5, GP.GroundLevel - GP.RoomSizeInPixel);
		elevator.BuildMe();
		_roomList.add(elevator);
		elevator  = new RoomElevator();
		elevator.setPosition(GP.RoomSizeInPixel * 5, GP.GroundLevel - GP.RoomSizeInPixel - GP.RoomSizeInPixel);
		elevator.BuildMe();
		_roomList.add(elevator);
		
		var g : Guest = new Guest(this);
		_guestList.add(g);
		//g.setPosition(FlxG.random.float(0, 800), FlxG.random.float(0, 500));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		_roomList.update(elapsed);
		_guestList.update(elapsed);
		
		if (Mode == PlayerMode.Normal)
		{
			if (FlxG.keys.pressed.B)
			{
				SwitchToBuildMode();
			}
			if (FlxG.mouse.justPressed)
			{
				for (r in _roomList)
				{
					
					if (FlxG.mouse.overlaps(r, FlxG.camera))
					{
						Mode = PlayerMode.Upgrade;
					}
				}
			}
		}
		
		else if (Mode == PlayerMode.Build)
		{
			var rx : Int = Std.int(FlxG.mouse.x / GP.RoomSizeInPixel);
			var ry : Int = Std.int(FlxG.mouse.y / GP.RoomSizeInPixel);
			
			
			if (FlxG.mouse.justPressed)
			{
				BuildRoom();
			}
			_room2Place.setPosition(rx*GP.RoomSizeInPixel, ry*GP.RoomSizeInPixel);
			if (FlxG.keys.pressed.ESCAPE)
			{
				Mode = PlayerMode.Normal;
			}
		}
		if (Mode == PlayerMode.Upgrade)
		{
			if (FlxG.keys.pressed.ESCAPE)
			{
				Mode = PlayerMode.Normal;
			}
		}
	}
	
	function BuildRoom() 
	{
		if (CanBuildRoom())
		{
			_room2Place.BuildMe();
			_roomList.add(_room2Place);
			Mode = PlayerMode.Normal;
		}
	}
	
	function CanBuildRoom() : Bool
	{
		// Check if room can be built on this level
		if (Std.int((GP.GroundLevel  - _room2Place.y) / GP.RoomSizeInPixel) > _maxLevel) return false;
		//if (Std.int(_room2Place.x / GP.RoomSizeInPixel) < _minTilePosX) return false;
		//if (Std.int(_room2Place.x + _room2Place.WidthInTiles / GP.RoomSizeInPixel) > _maxTilePosX) return false;
		// Check if room can be built on this position (no overlap with other rooms)
		for (r in _roomList)
		{
			if (_room2Place.overlapsOtherRoom(r))
			{
				return false;
			}
		}
		
		//if (FlxG.overlap(_room2Place, _roomList))
		//{
			//return false;
		//}
		// TODO Check if there is enough money
		
		return true;
	}
	
	function SwitchToBuildMode() 
	{
		Mode = PlayerMode.Build;
		_room2Place = new Room();
	}
	
	override public function draw() : Void 
	{
		super.draw();
		Ground.draw();
		_roomList.draw();
		_guestList.draw();
		
		if (Mode == PlayerMode.Build)
		{
			_room2Place.draw();
		}
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
					return r;
				}
			}
		}
		
		return null;
	}
}
