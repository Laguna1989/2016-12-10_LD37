package;

/**
 * ...
 * @author 
 */
class GuestActionAssignRoom extends GuestAction
{

	private var waitingTime : Float = 5;
	private var targetRoomName : String = "";
	
	public function new(g:Guest) 
	{
		super(g);
		name = "assign";
	}
	
	public override function IsFinished() : Bool
	{
		if (_age >= waitingTime)
		{
			var tr : Room = _guest._state.getFreeMatchingRoom(_guest);
			if (tr == null)
			{
				trace("no room found, searching continues");
				_age = 0;
				_guest.AccumulatedWaitingTime += waitingTime;
				_guest.SatisfactionFactor *= 0.95;
				return false;
			}
			else
			{
				//_guest.AccumulatedWaitingTime += waitingTime;
				targetRoomName = tr.name;
				return true;
			}
			
		}
		return false;
	}
	
	public override function Activate()
	{
		super.Activate();
		trace("activate Assign Room Action");
		var rec : RoomReception = cast _guest._state.getRoomByName("reception");
		if (rec != null)
		{
			rec.WaitingIncrease();
			waitingTime = rec.getWaitingTime();
			
		}
	}
	
	public override function DoFinish() : Void 
	{
		trace("Assign: Finish: " + targetRoomName);
		_guest._roomName = targetRoomName;
		var wa : GuestActionWalk = new GuestActionWalk(_guest);
		wa.targetRoom = targetRoomName;
		_guest.AddActionToBegin(wa);
		
		var id : GuestActionIdle = new GuestActionIdle(_guest);
		_guest.AddAction(id);
		
		var rec : RoomReception = cast _guest._state.getRoomByName("reception");
		rec.WaitingDecrease();
		
		_guest._state.ChangeMoney(GP.MoneyGuestRecipeRoomCost);
	}
}