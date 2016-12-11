package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.Assets;

class UpgradeMenu extends FlxTypedGroup<FlxSprite>
{
	public var IsOpen : Bool = false;

	private var _sprBack : FlxSprite;
	
	private var _txtQuality : FlxText;
	private var _sprQuality : FlxSprite;
	private var _btnQuality : FlxButton;

	public function new()
	{
		super();

		var dialogWidth = 300;
		var dialogHeight = 100;
		var posX = Std.int((FlxG.width  - dialogWidth)  / 2);
		var posY = Std.int((FlxG.height - dialogHeight) / 2);
		var fontSize = 12;
		var padding  = 5;
		var iconSize = 32;

		_sprBack = new FlxSprite().makeGraphic(dialogWidth, dialogHeight, FlxColor.fromRGB(255, 255, 240, 220));
		_sprBack.setPosition(posX, posY);
		_sprBack.scrollFactor.set();
		add(_sprBack);

		_sprQuality = new FlxSprite().makeGraphic(iconSize, iconSize, FlxColor.BLUE);
		_sprQuality.setPosition(posX + padding, posY + padding);
		_sprQuality.scrollFactor.set();
		add(_sprQuality);

		_txtQuality = new FlxText(
			posX + padding + iconSize + padding,
			posY + padding,
			dialogWidth - 3 * padding - iconSize,
			Assets.getText("assets/data/room_upgrade_text.txt")
		);
		_txtQuality.scrollFactor.set();
		add(_txtQuality);

		_btnQuality = new FlxButton(0, 0, 'Upgrade');
		_btnQuality.setPosition(
			posX + dialogWidth / 2 - _btnQuality.width / 2,
			posY + dialogHeight - _btnQuality.height - padding
		);
		add(_btnQuality);
	}

	public function open(r : Room) : Void
	{
		if(IsOpen) return;

		IsOpen = true;
		trace('Upgrading room at x=${r.x}, y=${r.y}');
	}

	public function close() : Void
	{
		IsOpen = false;
	}
}