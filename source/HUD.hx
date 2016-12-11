package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.display.FlxExtendedSprite;
import openfl.Assets;

class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _state : PlayState;

	private var _sprBG     : FlxSprite;
	private var _moneyText : FlxText;
	//private var _modeText  : FlxText;

	private var _btnSRoom : FlxExtendedSprite;
	private var _btnMRoom : FlxExtendedSprite;
	private var _btnLRoom : FlxExtendedSprite;

	private var _btnGenerator   : FlxExtendedSprite;
	private var _btnElevator    : FlxExtendedSprite;
	private var _btnServiceRoom : FlxExtendedSprite;

	private var _btnJanitor : FlxExtendedSprite;
	private var _btnMaid    : FlxExtendedSprite;

	public function new(state : PlayState)
	{
		super();

		_state = state;

		var backgroundColor = FlxColor.fromRGB(200, 200, 200, 200);
		var borderColor     = FlxColor.fromRGB(255, 255, 255, 200);

		_sprBG = new FlxSprite().makeGraphic(FlxG.width, 32, backgroundColor);
		_sprBG.scrollFactor.set();
		add(_sprBG);

		_moneyText  = new FlxText(5, 5, 100, '$', 15);
		_moneyText.color = FlxColor.BLACK;
		_moneyText.addFormat(new FlxTextFormat(FlxColor.GREEN), 0, 1);
		_moneyText.scrollFactor.set();
		add(_moneyText);

		// Small room
		_btnSRoom = new FlxExtendedSprite(FlxG.width - 88, 0);
		_btnSRoom.makeGraphic(16, 16, FlxColor.fromRGB(100, 255, 100, 255));
		_btnSRoom.scrollFactor.set();
		add(_btnSRoom);

		// Medium room
		_btnMRoom = new FlxExtendedSprite(FlxG.width - 88, 16);
		_btnMRoom.makeGraphic(16, 16, FlxColor.fromRGB(100, 255, 100, 255));
		_btnMRoom.scrollFactor.set();
		add(_btnMRoom);

		// Large room
		_btnLRoom = new FlxExtendedSprite(FlxG.width - 72, 0);
		_btnLRoom.makeGraphic(16, 16, FlxColor.fromRGB(100, 255, 100, 255));
		_btnLRoom.scrollFactor.set();
		add(_btnLRoom);

		// ##################

		// Generator
		_btnGenerator = new FlxExtendedSprite(FlxG.width - 52, 0);
		_btnGenerator.makeGraphic(16, 16, FlxColor.fromRGB(128, 0, 255, 255));
		_btnGenerator.scrollFactor.set();
		add(_btnGenerator);

		// Elevator
		_btnElevator = new FlxExtendedSprite(FlxG.width - 52, 16);
		_btnElevator.makeGraphic(16, 16, FlxColor.fromRGB(128, 0, 255, 255));
		_btnElevator.scrollFactor.set();
		add(_btnElevator);

		// Service room
		_btnServiceRoom = new FlxExtendedSprite(FlxG.width - 36, 0);
		_btnServiceRoom.makeGraphic(16, 16, FlxColor.fromRGB(128, 0, 255, 255));
		_btnServiceRoom.scrollFactor.set();
		add(_btnServiceRoom);

		// ##################

		// Janitor
		_btnJanitor = new FlxExtendedSprite(FlxG.width - 16, 0);
		_btnJanitor.makeGraphic(16, 16, FlxColor.fromRGB(255, 0, 128, 255));
		_btnJanitor.scrollFactor.set();
		add(_btnJanitor);

		// Maid
		_btnMaid = new FlxExtendedSprite(FlxG.width - 16, 16);
		_btnMaid.makeGraphic(16, 16, FlxColor.fromRGB(255, 0, 128, 255));
		_btnMaid.scrollFactor.set();
		add(_btnMaid);
	}

	public override function update(elapsed : Float)
	{
		super.update(elapsed);

		_moneyText.text = '$$${_state.getMoney()}';
	}
}