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
	private var _actions : Array<GuestAction>;
	
	private var _state :PlayState;
	
	public function new(state:PlayState) 
	{
		super( -10, GP.GroundLevel);
		_state = state;
		this.offset.set(0, GP.GuestSizeInPixel);
		this.makeGraphic(GP.GuestSizeInPixel, GP.GuestSizeInPixel, FlxColor.BLUE);
		this.velocity.set(32);
		_actions = new Array<GuestAction>();
		var w1 : GuestActionWalk = new GuestActionWalk(this);
		w1.targetRoom = "reception";
		_actions.push(w1);
	}
	
	public override function update(elapsed:Float) : Void 
	{
		super.update(elapsed);
		if (_actions.length > 0)
		{
			_actions[0].update(elapsed);
		}
		
	}
	
	
	
}