package;

/**
 * ...
 * @author 
 */
class GuestActionExit extends GuestAction
{
	private var waitingTime : Float = 0;

	public function new(g:Guest) 
	{
		super(g);
	}
	
	public override function IsFinished () : Bool
	{
		return (_age >= waitingTime);
	}
	
	public override function DoFinish() : Void 
	{
		trace("Finish Exit Action");
		_guest.CanLeave = true;
	}
	
	public override function Activate()
	{
		super.Activate();
		trace("Activate Exit Action" );
		waitingTime = 10;
	}
	
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		_guest.velocity.x = - 20;
		
	}
	
}