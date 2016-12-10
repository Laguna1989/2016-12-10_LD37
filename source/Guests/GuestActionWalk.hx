package ;

/**
 * ...
 * @author 
 */
class GuestActionWalk extends GuestAction
{
	public var targetRoom : String = "";
	private var tr: Room = null;
	private var tx : Float = 0;
	private var walkRight : Bool = true;
	private var _walkingTime :Float = 0;
	
	public override function IsFinished() : Bool
	{
		return (_age >= _walkingTime);
	}
	
	public override function DoFinish() : Void 
	{
		_guest.velocity.x = 0;
	}
	
	public function new(g:Guest) 
	{
		super(g);
	}
	
	public override function Activate()
	{
		trace("activate Walk Action");
		tr = _guest._state.getRoomByName(targetRoom);
		if (tr != null)
		{
			if (tr.Level == _guest.Level -1)
			{
				trace("on same level");
				tx = tr.x;
				walkRight =  (tx - _guest.x > 0);
				_walkingTime = Math.abs(tx - _guest.x) / 20;
			}
			else
			{
				trace(tr.Level);
				trace(_guest.Level);
				// TODO WalkToElevator first
			}
		}
		else
		{
			trace("no room with name " + targetRoom + " found!");
		}
	}
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		if (walkRight)
			_guest.velocity.x = 20;
		else
			_guest.velocity.x = -20;
	}
	
}