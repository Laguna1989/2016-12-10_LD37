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
		WidthInTiles = 3;
		//this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel - 1, 1 * GP.RoomSizeInPixel -1, FlxColor.CYAN);
		this.loadGraphic(AssetPaths.room_reception__png, false, 144, 48);
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