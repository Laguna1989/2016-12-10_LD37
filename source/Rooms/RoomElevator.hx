package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class RoomElevator extends Room
{
	public static var NumberOfElevatorsBuilt : Int = 0;
	public function new() 
	{
		super();
		WidthInTiles = 1;
		this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel - 1, 1 * GP.RoomSizeInPixel -1, FlxColor.ORANGE);
		Cost = GP.MoneyElevatorBaseCost * NumberOfElevatorsBuilt;
	}
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
	}
	
	public override function BuildMe()
	{
		super.BuildMe();
		name = "elevator_" + Std.string(Level);
		trace("elevator Name: " + name);
		NumberOfElevatorsBuilt++;
	}
}
