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
		//this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel - 1, 1 * GP.RoomSizeInPixel -1, FlxColor.ORANGE);
		this.loadGraphic(AssetPaths.room_elevator__png, false, 48, 48);
		Cost = GP.MoneyElevatorBaseCost + GP.MoneyElevatorBaseCost * Std.int( Math.pow((NumberOfElevatorsBuilt-1), 1.5));
	}
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
	}
	
	public override function BuildMe()
	{
		super.BuildMe();
		name = "elevator_" + Std.string(Level);
		//trace("elevator Name: " + name);
		NumberOfElevatorsBuilt++;
	}
	public override function getXPos() 
	{
		return this.x + 16;
	}
}
