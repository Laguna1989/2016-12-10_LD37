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
		_btnSRoom = new FlxSprite(FlxG.width - 88, 0);
		_btnSRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnSRoom.animation.add('default', [0], 1, false);
		_btnSRoom.animation.add('down', [8], 1, false);
		_btnSRoom.animation.play('default');
		_btnSRoom.scrollFactor.set();
		add(_btnSRoom);

		// Medium room
		_btnMRoom = new FlxSprite(FlxG.width - 88, 16);
		_btnMRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnMRoom.animation.add('default', [1], 1, false);
		_btnMRoom.animation.add('down', [9], 1, false);
		_btnMRoom.animation.play('default');
		_btnMRoom.scrollFactor.set();
		add(_btnMRoom);

		// Large room
		_btnLRoom = new FlxSprite(FlxG.width - 72, 0);
		_btnLRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnLRoom.animation.add('default', [2], 1, false);
		_btnLRoom.animation.add('down', [10], 1, false);
		_btnLRoom.animation.play('default');
		_btnLRoom.scrollFactor.set();
		add(_btnLRoom);

		// ##################

		// Generator
		_btnGenerator = new FlxSprite(FlxG.width - 52, 0);
		_btnGenerator.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnGenerator.animation.add('default', [3], 1, false);
		_btnGenerator.animation.add('down', [11], 1, false);
		_btnGenerator.animation.play('default');
		_btnGenerator.scrollFactor.set();
		add(_btnGenerator);

		// Elevator
		_btnElevator = new FlxSprite(FlxG.width - 52, 16);
		_btnElevator.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnElevator.animation.add('default', [4], 1, false);
		_btnElevator.animation.add('down', [12], 1, false);
		_btnElevator.animation.play('default');
		_btnElevator.scrollFactor.set();
		add(_btnElevator);

		// Service room
		_btnServiceRoom = new FlxSprite(FlxG.width - 36, 0);
		_btnServiceRoom.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnServiceRoom.animation.add('default', [5], 1, false);
		_btnServiceRoom.animation.add('down', [13], 1, false);
		_btnServiceRoom.animation.play('default');
		_btnServiceRoom.scrollFactor.set();
		add(_btnServiceRoom);

		// ##################

		// Maid
		_btnMaid = new FlxSprite(FlxG.width - 16, 16);
		_btnMaid.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnMaid.animation.add('default', [6], 1, false);
		_btnMaid.animation.add('down', [14], 1, false);
		_btnMaid.animation.play('default');
		_btnMaid.scrollFactor.set();
		add(_btnMaid);

		// Janitor
		_btnJanitor = new FlxSprite(FlxG.width - 16, 0);
		_btnJanitor.loadGraphic(AssetPaths.Buttons__png, true, 16, 16);
		_btnJanitor.animation.add('default', [7], 1, false);
		_btnJanitor.animation.add('down', [15], 1, false);
		_btnJanitor.animation.play('default');
		_btnJanitor.scrollFactor.set();
		add(_btnJanitor);
	}

	public override function update(elapsed : Float)
	{
		super.update(elapsed);

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
					trace('Click on button x:${btn.x}, y:${btn.y}');
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