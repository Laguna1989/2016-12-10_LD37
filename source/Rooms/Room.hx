package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */

class Room extends FlxSprite
{
	public var Props:RoomProperties;
	
	public function new() 
	{
		super();
		this.makeGraphic(GP.RoomSizeInPixel * 3, GP.RoomSizeInPixel * 1, FlxColor.WHITE);
		Props = new RoomProperties();
		
	}
	
}