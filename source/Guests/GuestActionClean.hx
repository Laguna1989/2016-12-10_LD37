package;

/**
 * ...
 * @author 
 */
class GuestActionClean extends GuestAction
{
	
	private var cleaningTime : Float = 0;

	private var gotStuff : Bool = false;
	public var target : String = "";
	public function new(g:Guest) 
	{
		super(g);
	}
	
	
	public override function IsFinished () : Bool
	{
		if (!activated) return false;
		return (_age >= cleaningTime);
	}
	
	public override function DoFinish() : Void 
	{
		//trace("Finish Clean Action");
		var r : Room = _guest._state.getRoomByName(_guest._roomName);
		if (r != null)
		{
			r.DirtLevel = 0;
			_guest._state.JobList.finishJob(r.name);
		}
		_guest.alpha = 1;
	}
	
	public override function Activate()
	{
		super.Activate();
		//trace("Activate Clean Action");
		
		if (!gotStuff)
		{
			gotStuff = true;
			var serviceRoomName : String = "service_" + Std.string(_guest.Level);
			var sr : Room = _guest._state.getRoomByName(serviceRoomName);
			if (sr != null)
			{
				
				var w2 : GuestActionWalk = new GuestActionWalk(_guest);
				w2.targetRoom = _guest._roomName;
				_guest.AddActionToBegin(w2);
				
				var w1 : GuestActionWalk = new GuestActionWalk(_guest);
				w1.targetRoom = "service_" + Std.string(_guest.Level);
				_guest.AddActionToBegin(w1);
				w1.Activate();
			}
			else
			{
				activated = false;
				gotStuff = false;
			}			
		}
		cleaningTime = 5.0;
		
	}
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		_guest.alpha = 0.5;
	}
	
}