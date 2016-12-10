package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup.FlxTypedGroup;

class UpgradeMenu extends FlxTypedGroup<FlxSprite>
{
	public var IsOpen : Bool = false;

	private var _sprBack : FlxSprite;
	
	private var _txtAC      : FlxText;
	private var _sprAC      : FlxSprite;
	private var _btnACPlus  : FlxButton;
	private var _btnACMinus : FlxButton;

	private var _txtTV      : FlxText;
	private var _sprTV      : FlxSprite;
	private var _btnTVPlus  : FlxButton;
	private var _btnTVMinus : FlxButton;

	private var _txtWindow      : FlxText;
	private var _sprWindow      : FlxSprite;
	private var _btnWindowPlus  : FlxButton;
	private var _btnWindowMinus : FlxButton;

	private var _txtWiFi      : FlxText;
	private var _sprWiFi      : FlxSprite;
	private var _btnWiFiPlus  : FlxButton;
	private var _btnWiFiMinus : FlxButton;

	private var _txtBed      : FlxText;
	private var _sprBed      : FlxSprite;
	private var _btnBedPlus  : FlxButton;
	private var _btnBedMinus : FlxButton;

	private var _txtPlants      : FlxText;
	private var _sprPlants      : FlxSprite;
	private var _btnPlantsPlus  : FlxButton;
	private var _btnPlantsMinus : FlxButton;

	private var _txtMinibar      : FlxText;
	private var _sprMinibar      : FlxSprite;
	private var _btnMinibarPlus  : FlxButton;
	private var _btnMinibarMinus : FlxButton;

	private var _txtBathroom      : FlxText;
	private var _sprBathroom      : FlxSprite;
	private var _btnBathroomPlus  : FlxButton;
	private var _btnBathroomMinus : FlxButton;

	public function new()
	{
		super();

		var dialogWidth = Std.int(FlxG.width * 0.75);
		var dialogHeight = Std.int(FlxG.height * 0.9);
		var posX = Std.int((FlxG.width  - dialogWidth)  / 2);
		var posY = Std.int((FlxG.height - dialogHeight) / 2);
		var fontSize = 12;
		var rowSize  = 64;
		var padding  = 5;
		var leftColumnWidth = 150;
		var level    = 0;

		_sprBack = new FlxSprite().makeGraphic(dialogWidth, dialogHeight, FlxColor.fromRGB(255, 255, 240, 220));
		_sprBack.setPosition(posX, posY);
		add(_sprBack);

		var currentPosY = function() return posY + padding + level * rowSize;

		// Air conditioning
		_txtAC = new FlxText(posX + padding, currentPosY(), 'Air conditioning', fontSize);
		_txtAC.color = FlxColor.BLACK;
		add(_txtAC);
		
		_sprAC = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 255, 0));
		_sprAC.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprAC);

		_btnACMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnACPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnACMinus.width + padding, currentPosY(), '+');

		add(_btnACMinus);
		add(_btnACPlus);
		level++;
		

		// TV
		_txtTV = new FlxText(posX + padding, currentPosY(), 'TV', fontSize);
		_txtTV.color = FlxColor.BLACK;
		add(_txtTV);
		
		_sprTV = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 0, 255));
		_sprTV.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprTV);

		_btnTVMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnTVPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnTVMinus.width + padding, currentPosY(), '+');

		add(_btnTVMinus);
		add(_btnTVPlus);
		level++;
		

		// Windows
		_txtWindow = new FlxText(posX + padding, currentPosY(), 'Windows', fontSize);
		_txtWindow.color = FlxColor.BLACK;
		add(_txtWindow);
		
		_sprWindow = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 255, 0));
		_sprWindow.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprWindow);

		_btnWindowMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnWindowPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnWindowMinus.width + padding, currentPosY(), '+');

		add(_btnWindowMinus);
		add(_btnWindowPlus);
		level++;
		

		// WiFi
		_txtWiFi = new FlxText(posX + padding, currentPosY(), 'WiFi', fontSize);
		_txtWiFi.color = FlxColor.BLACK;
		add(_txtWiFi);
		
		_sprWiFi = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 0, 255));
		_sprWiFi.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprWiFi);

		_btnWiFiMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnWiFiPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnWiFiMinus.width + padding, currentPosY(), '+');

		add(_btnWiFiMinus);
		add(_btnWiFiPlus);
		level++;
		

		// Bed
		_txtBed = new FlxText(posX + padding, currentPosY(), 'Bed', fontSize);
		_txtBed.color = FlxColor.BLACK;
		add(_txtBed);
		
		_sprBed = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 255, 0));
		_sprBed.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprBed);

		_btnBedMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnBedPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnBedMinus.width + padding, currentPosY(), '+');

		add(_btnBedMinus);
		add(_btnBedPlus);
		level++;
		

		// Plants
		_txtPlants = new FlxText(posX + padding, currentPosY(), 'Plants', fontSize);
		_txtPlants.color = FlxColor.BLACK;
		add(_txtPlants);
		
		_sprPlants = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 0, 255));
		_sprPlants.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprPlants);

		_btnPlantsMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnPlantsPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnPlantsMinus.width + padding, currentPosY(), '+');

		add(_btnPlantsMinus);
		add(_btnPlantsPlus);
		level++;
		

		// Minibar
		_txtMinibar = new FlxText(posX + padding, currentPosY(), 'Minibar', fontSize);
		_txtMinibar.color = FlxColor.BLACK;
		add(_txtMinibar);
		
		_sprMinibar = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 255, 0));
		_sprMinibar.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprMinibar);

		_btnMinibarMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnMinibarPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnMinibarMinus.width + padding, currentPosY(), '+');

		add(_btnMinibarMinus);
		add(_btnMinibarPlus);
		level++;
		

		// Bathroom
		_txtBathroom = new FlxText(posX + padding, currentPosY(), 'Bathroom', fontSize);
		_txtBathroom.color = FlxColor.BLACK;
		add(_txtBathroom);
		
		_sprBathroom = new FlxSprite().makeGraphic(64, 64, FlxColor.fromRGB(255, 0, 255));
		_sprBathroom.setPosition(posX + leftColumnWidth, currentPosY());
		add(_sprBathroom);

		_btnBathroomMinus = new FlxButton(posX + leftColumnWidth + 64 + padding, currentPosY(), '-');
		_btnBathroomPlus  = new FlxButton(posX + leftColumnWidth + 64 + _btnBathroomMinus.width + padding, currentPosY(), '+');

		add(_btnBathroomMinus);
		add(_btnBathroomPlus);
		level++;
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