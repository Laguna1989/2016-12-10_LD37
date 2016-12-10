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
		super( -10, GP.GroundLevel);
		this.offset.set(0, GP.GuestSizeInPixel);
		this.makeGraphic(GP.GuestSizeInPixel, GP.GuestSizeInPixel, FlxColor.BLUE);
		this.velocity.set(32);
	}
	
	public override function update(elapsed:Float) : Void 
	{
		super.update(elapsed);
		
		
	}
	
}