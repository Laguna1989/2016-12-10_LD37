package;

/**
 * ...
 * @author 
 */
class GuestActionElevator extends GuestAction
{
	public var TargetLevel : Int = 0;
	public var elevatorTime : Float = 0;
	private var goingUp : Bool = false;
	
	public function new(g:Guest) 
	{
		super(g);
		name = "elevator";
	}
	
	public override function IsFinished () : Bool
	{
		return (_age >= elevatorTime);
	}
	
	public override function DoFinish() : Void 
	{
		trace("Finish Elevator Action");
		_guest.setPosition(_guest.x, (TargetLevel +1) * GP.RoomSizeInPixel);
		_guest.Level = Std.int((_guest.y - GP.GuestSizeInPixel) / GP.RoomSizeInPixel) ;
		_guest.alpha = 1.0;
		_guest.velocity.y = 0;
	}
	
	public override function Activate()
	{
		super.Activate();
		trace("Activate Elevator Action");
		var d : Float = TargetLevel - _guest.Level ;
		goingUp = (d > 0);
		elevatorTime = Math.abs(d) * 5;
		
	}
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		_guest.alpha = 0.5;
		_guest.velocity.y = 48 / 5 * ((goingUp)? 1 : -1);
	}
}