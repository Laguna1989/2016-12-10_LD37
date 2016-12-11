package;
import flixel.util.FlxColor;
import flixel.util.FlxColorTransformUtil;

/**
 * ...
 * @author 
 */
class RoomGenerator extends Room
{

	public function new() 
	{
		super();
		WidthInTiles = 1;
		//this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel - 1, 1 * GP.RoomSizeInPixel -1, FlxColor.RED);
		this.loadGraphic(AssetPaths.room_generator__png, false, 48, 48);
		Cost = GP.MoneyGeneratorCost;
	}
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
		_infoText.text += "running costs: " + Std.string(GP.MoneyGeneratorRunningCost) + "\n";
	}
	
	public override function BuildMe()
	{
		super.BuildMe();
		name = "generator_" + Std.string(Level) + "_" + Std.string(TilePosX);
	}
	
}