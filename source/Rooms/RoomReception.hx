package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class RoomReception extends Room
{
	
	public var GuestsWaiting : Int = 0;
	public function new() 
	{
		super();
		WidthInTiles = 2;
		this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel - 1, 1 * GP.RoomSizeInPixel -1, FlxColor.CYAN);
	}
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
	}
	
	public override function BuildMe()
	{
		super.BuildMe();
		name = "reception";
	}
	
	
	
	public function getWaitingTime() : Float
	{
		return 5;
	}
}