package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Guest extends FlxSprite
{

	public function new() 
	{
		super();
		this.makeGraphic(GP.GuestSizeInPixel, GP.GuestSizeInPixel, FlxColor.BLUE);
		
	}
	
}