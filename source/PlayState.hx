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
	
	override public function create():Void
	{
		super.create();
		Ground = new FlxSprite(0, 500);
		Ground.makeGraphic(Std.int(GP.WorldSizeXInPixel), 600, FlxColor.BROWN);
		_roomList = new FlxTypedGroup<Room>();
		_guestList = new FlxTypedGroup<Guest>();
		
		var r : Room = new Room();
		_roomList.add(r);
		
		var g : Guest = new Guest();
		g.setPosition(FlxG.random.float(0, 800), FlxG.random.float(0, 500));
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
			_room2Place.setPosition(FlxG.mouse.x, FlxG.mouse.y);
			
			if (FlxG.mouse.justPressed)
			{
				BuildRoom();
			}
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
		_roomList.add(_room2Place);
		//_room2Place = new Room();
		Mode = PlayerMode.Normal;
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
