package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _state : PlayState;

	private var _sprBG     : FlxSprite;
	private var _moneyText : FlxText;

	private var _btnBulldozer : FlxSprite;

	private var _btnSRoom : FlxSprite;
	private var _btnMRoom : FlxSprite;
	private var _btnLRoom : FlxSprite;

	private var _btnGenerator   : FlxSprite;
	private var _btnElevator    : FlxSprite;
	private var _btnServiceRoom : FlxSprite;

	private var _btnJanitor : FlxSprite;
	private var _btnMaid    : FlxSprite;

	public function new(state : PlayState)
	{
		super();

		_state = state;

		var numButtons = 9;

		var backgroundColor = FlxColor.fromRGB(200, 200, 200, 220);

		_sprBG = new FlxSprite().makeGraphic(FlxG.width, 20, backgroundColor);
		_sprBG.scrollFactor.set();
		add(_sprBG);

		_moneyText  = new FlxText(2, 0, 100, '$', 15);
		_moneyText.color = FlxColor.BLACK;
		_moneyText.addFormat(new FlxTextFormat(FlxColor.GREEN), 0, 1);
		_moneyText.scrollFactor.set();
		add(_moneyText);

		// Bulldozer
		_btnBulldozer = new FlxSprite(FlxG.width - 157, 2);
		_btnBulldozer.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnBulldozer.animation.add('default', [8], 1, false);
		_btnBulldozer.animation.add('down', [8 + numButtons], 1, false);
		_btnBulldozer.animation.play('default');
		_btnBulldozer.scrollFactor.set();
		add(_btnBulldozer);

		// Small room
		_btnSRoom = new FlxSprite(FlxG.width - 137, 2);
		_btnSRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnSRoom.animation.add('default', [0], 1, false);
		_btnSRoom.animation.add('down', [0 + numButtons], 1, false);
		_btnSRoom.animation.play('default');
		_btnSRoom.scrollFactor.set();
		add(_btnSRoom);

		// Medium room
		_btnMRoom = new FlxSprite(FlxG.width - 121, 2);
		_btnMRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnMRoom.animation.add('default', [1], 1, false);
		_btnMRoom.animation.add('down', [1 + numButtons], 1, false);
		_btnMRoom.animation.play('default');
		_btnMRoom.scrollFactor.set();
		add(_btnMRoom);

		// Large room
		_btnLRoom = new FlxSprite(FlxG.width - 105, 2);
		_btnLRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnLRoom.animation.add('default', [2], 1, false);
		_btnLRoom.animation.add('down', [2 + numButtons], 1, false);
		_btnLRoom.animation.play('default');
		_btnLRoom.scrollFactor.set();
		add(_btnLRoom);

		// ##################

		// Generator
		_btnGenerator = new FlxSprite(FlxG.width - 85, 2);
		_btnGenerator.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnGenerator.animation.add('default', [3], 1, false);
		_btnGenerator.animation.add('down', [3 + numButtons], 1, false);
		_btnGenerator.animation.play('default');
		_btnGenerator.scrollFactor.set();
		add(_btnGenerator);

		// Elevator
		_btnElevator = new FlxSprite(FlxG.width - 69, 2);
		_btnElevator.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnElevator.animation.add('default', [4], 1, false);
		_btnElevator.animation.add('down', [4 + numButtons], 1, false);
		_btnElevator.animation.play('default');
		_btnElevator.scrollFactor.set();
		add(_btnElevator);

		// Service room
		_btnServiceRoom = new FlxSprite(FlxG.width - 53, 2);
		_btnServiceRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnServiceRoom.animation.add('default', [5], 1, false);
		_btnServiceRoom.animation.add('down', [5 + numButtons], 1, false);
		_btnServiceRoom.animation.play('default');
		_btnServiceRoom.scrollFactor.set();
		add(_btnServiceRoom);

		// ##################

		// Maid
		_btnMaid = new FlxSprite(FlxG.width - 33, 2);
		_btnMaid.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnMaid.animation.add('default', [6], 1, false);
		_btnMaid.animation.add('down', [6 + numButtons], 1, false);
		_btnMaid.animation.play('default');
		_btnMaid.scrollFactor.set();
		add(_btnMaid);

		// Janitor
		_btnJanitor = new FlxSprite(FlxG.width - 17, 2);
		_btnJanitor.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnJanitor.animation.add('default', [7], 1, false);
		_btnJanitor.animation.add('down', [7 + numButtons], 1, false);
		_btnJanitor.animation.play('default');
		_btnJanitor.scrollFactor.set();
		add(_btnJanitor);
	}

	public override function update(elapsed : Float)
	{
		super.update(elapsed);

		handleButton(_btnBulldozer, _state.SwitchToBulldozer);

		handleButton(_btnSRoom, _state.SwitchToBuildModeS);
		handleButton(_btnMRoom, _state.SwitchToBuildModeM);
		handleButton(_btnLRoom, _state.SwitchToBuildModeL);

		handleButton(_btnGenerator, _state.SwitchToGeneratorMode);
		handleButton(_btnElevator, _state.SwitchToElevatorMode);
		handleButton(_btnServiceRoom, _state.SwitchToServiceRoom);

		handleButton(_btnMaid, _state.SpawnJanitor);
		handleButton(_btnJanitor, null);

		_moneyText.text = '$$${_state.getMoney()}';
	}

	private function handleButton(btn : FlxSprite, callback : Void -> Void)
	{
		var mouseOver = false;
		var justPressed = false;

		if(FlxG.mouse.screenX >= btn.x && FlxG.mouse.screenX < btn.x + btn.width)
		{
			if(FlxG.mouse.screenY >= btn.y && FlxG.mouse.screenY < btn.y + btn.height)
			{
				mouseOver = true;
				justPressed = FlxG.mouse.justPressed;
			}
		}

		if(mouseOver)
		{
			btn.animation.play('down');
			if(justPressed)
			{
				if(callback != null)
				{
					callback();
				}
			}
		}
		else
		{
			btn.animation.play('default');
		}
	}
}