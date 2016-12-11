package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Worker extends Guest
{
	var waitingForJob : Bool = true;
	
	public function new(s : PlayState) 
	{
		super(s);
		_actions = new Array<GuestAction>();
	}
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		waitingForJob = (_actions.length == 0);
	}
	
}