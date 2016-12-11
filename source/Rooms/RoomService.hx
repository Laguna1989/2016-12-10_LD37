package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class RoomService extends Room
{

	public function new() 
	{
		super();
		WidthInTiles = 1;
		//this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel - 1, 1 * GP.RoomSizeInPixel -1, FlxColor.RED);
		this.loadGraphic(AssetPaths.room_clean__png, false, 48, 48);
		Cost = GP.MoneyServiceRoomCost;
	}
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
	}
	
	public override function BuildMe()
	{
		super.BuildMe();
		name = "service_" + Std.string(Level);
	}
	
}