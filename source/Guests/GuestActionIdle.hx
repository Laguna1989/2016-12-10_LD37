package;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class GuestActionIdle extends GuestAction
{
	public var waitingTime : Float = 0;

	public function new(g:Guest) 
	{
		super(g);
		name = "idle";
	}
	
	public override function IsFinished () : Bool
	{
		return (_age >= waitingTime);
	}
	
	public override function DoFinish() : Void 
	{
		trace("Finish Idle Action");
		_guest.alpha = 1.0;
		var l1  : GuestActionLeave = new GuestActionLeave(_guest);
		_guest.AddAction(l1);
	}
	
	public override function Activate()
	{
		super.Activate();
		waitingTime = FlxG.random.floatNormal(20, 3);
		trace("Activate Idle Action: " + waitingTime);
		
	}
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		_guest.alpha = 0.1;
	}
	
}