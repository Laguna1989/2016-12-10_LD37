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
		name = "exit";
	}
	
	public override function IsFinished () : Bool
	{
		return (_age >= waitingTime);
	}
	
	public override function DoFinish() : Void 
	{
		//bbtrace("Finish Exit Action");
		_guest.CanLeave = true;
		var r : Room = _guest._state.getRoomByName(_guest._roomName);
		if (r != null)
		{
			r.unlock();
		}
		else
		{
			//trace("cannot unlock room");
		}
	}
	
	public override function Activate()
	{
		super.Activate();
		//trace("Activate Exit Action" );
		waitingTime = 2;
	}
	
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		_guest.velocity.x = - 20;
		var v : Float = 1 - (_age / waitingTime);
		if (v > 1 ) v = 1;
		if (v < 0) v = 0;
		v = v * v;
		_guest.alpha = v;
	}
	
}