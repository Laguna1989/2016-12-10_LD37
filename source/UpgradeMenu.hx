package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class UpgradeMenu extends FlxTypedGroup<FlxSprite>
{
	public var IsOpen : Bool = false;

	private var _sprBack : FlxSprite;

	public function new()
	{
		super();

		_sprBack = new FlxSprite().makeGraphic(Std.int(FlxG.width * 0.75), 20, FlxColor.BLUE);

		add(_sprBack);
	}

	public function open(r : Room)
	{
		if(IsOpen) return;

		IsOpen = true;
		trace('Upgrading room at x=${r.x}, y=${r.y}');
	}

	public function close()
	{
		IsOpen = false;
	}
}