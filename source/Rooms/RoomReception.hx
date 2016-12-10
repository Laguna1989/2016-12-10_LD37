package;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class RoomReception extends Room
{

	public function new() 
	{
		super();
		name = "reception";
		WidthInTiles = 2;
		this.makeGraphic(WidthInTiles * GP.RoomSizeInPixel-1, 1 * GP.RoomSizeInPixel -1, FlxColor.CYAN);
	}
	
}