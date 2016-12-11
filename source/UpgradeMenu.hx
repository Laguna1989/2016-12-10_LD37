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

	private var _sprBG : FlxSprite;
	
	private var _txtQuality : FlxText;
	private var _sprQuality : FlxSprite;
	private var _btnQuality : FlxButton;
	private var _btnClose   : FlxButton;
	
	private var _room  : Room = null; 
	private var _state : PlayState = null;
	
	private var _buttonCoolDown : Float = 0;
	
	public function new(s : PlayState)
	{
		super();

		_state = s;
		var dialogWidth = 300;
		var dialogHeight = 100;
		var posX = Std.int((FlxG.width  - dialogWidth)  / 2);
		var posY = Std.int((FlxG.height - dialogHeight) / 2);
		var padding  = 5;
		var iconSize = 32;

		_sprBG = new FlxSprite().makeGraphic(dialogWidth, dialogHeight, FlxColor.fromRGB(255, 255, 240, 220));
		_sprBG.setPosition(posX, posY);
		_sprBG.scrollFactor.set();
		add(_sprBG);

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
		_txtQuality.color = FlxColor.BLACK;
		_txtQuality.scrollFactor.set();
		add(_txtQuality);

		_btnQuality = new FlxButton(0, 0, 'Upgrade', upgradeRoom);
		_btnQuality.setPosition(
			posX + padding,
			posY + dialogHeight - _btnQuality.height - padding
		);
		add(_btnQuality);
		_btnQuality.active = true;

		_btnClose = new FlxButton(0, 0, 'Close', close);
		_btnClose.setPosition(
			posX + dialogWidth - _btnClose.width - padding,
			posY + dialogHeight - _btnClose.height - padding
		);
		add(_btnClose);
	}

	public function upgradeRoom()
	{
		if (_buttonCoolDown <= 0)
		{
			_buttonCoolDown = 0.25;
			if (_room != null)
			{
				if (_state.getMoney() >= (_room.Luxus +1) * GP.MoneyLuxusUpgrade)
				{
					if (_room.Luxus <= 1)
					{
						_room.Luxus += 1;
						_state.ChangeMoney(-_room.Luxus * GP.MoneyLuxusUpgrade);
					}
				}
			}
		}
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		_buttonCoolDown -= elapsed;
	}
	
	public function open(r : Room) : Void
	{
		if(IsOpen) return;
		_room = r;
		IsOpen = true;
		trace('Upgrading room at x=${r.x}, y=${r.y}');
	}

	public function close() : Void
	{
		IsOpen = false;
		_room = null;
		_state.Mode = PlayerMode.Normal;
	}
}