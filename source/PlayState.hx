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
	
	override public function create():Void
	{
		super.create();
		Ground = new FlxSprite(0, GP.GroundLevel);
		Ground.makeGraphic(Std.int(GP.WorldSizeXInPixel), 600, FlxColor.BROWN);
		_roomList = new FlxTypedGroup<Room>();
		_guestList = new FlxTypedGroup<Guest>();
		
		var g : Guest = new Guest();
		//g.setPosition(FlxG.random.float(0, 800), FlxG.random.float(0, 500));
		_guestList.add(g);
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
		if (Std.int((GP.GroundLevel  - _room2Place.y) / 48) > _maxLevel) return false;
		
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
}
