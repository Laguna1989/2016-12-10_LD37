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
		this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel - 1, 1 * GP.RoomSizeInPixel -1, FlxColor.RED);
		Cost = GP.MoneyGeneratorCost;
	}
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
	}
	
	public override function BuildMe()
	{
		super.BuildMe();
		name = "generator_" + Std.string(Level) + "_" + Std.string(TilePosX);
	}
	
}