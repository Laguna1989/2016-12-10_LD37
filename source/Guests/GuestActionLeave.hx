package;

/**
 * ...
 * @author 
 */
class GuestActionLeave extends GuestAction
{
	
	private var hasCheckedOut : Bool = false;
	private var waitingTime : Float = 0;

	public function new(g:Guest) 
	{
		super(g);
		name = "leave";
	}
	
	public override function IsFinished () : Bool
	{
		return (_age >= waitingTime);
	}
	
	public override function DoFinish() : Void 
	{
		trace("Finish Leave Action");
		
		// TODO Pay Tip
		
		_guest._state.ChangeMoney(Std.int(GP.MoneyTipAmount * _guest.SatisfactionFactor));
		
		var rec : RoomReception = cast _guest._state.getRoomByName("reception");
		rec.GuestsWaiting -= 1;
		var r : Room = _guest._state.getRoomByName(_guest._roomName);
		if (r != null)
		{
			r.unlock();
		}
		else
		{
			trace("cannot unlock room");
		}
		
		var e1 : GuestActionExit = new GuestActionExit(_guest);
		_guest.AddAction(e1);
	}
	
	public override function Activate()
	{
		super.Activate();
		trace("Activate Leave Action" );
		
		if (!hasCheckedOut)
		{
			trace("go to reception");
			// goto reception
			var w1 : GuestActionWalk = new GuestActionWalk(_guest);			
			w1.targetRoom = "reception";
			_guest.AddActionToBegin(w1);
			hasCheckedOut = true;
		}
		else
		{
			var rec : RoomReception = cast _guest._state.getRoomByName("reception");
			rec.GuestsWaiting += 1;
			waitingTime = rec.getWaitingTime();
		}
	}
	
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
	}
}