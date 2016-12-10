package ;

/**
 * ...
 * @author 
 */
class GuestAction
{
	var _guest : Guest;
	var _age : Float = 0;
	public var activated: Bool = false;
	
	public function IsFinished () : Bool
	{
		return true;
	}
	
	public function DoFinish() : Void 
	{
		
	}
	
	
	public function new( g : Guest) 
	{
		_guest = g;
	}
	
	public function Activate()
	{
		activated = true;
	}
	
	public function update(elapsed:Float) 
	{
		_age += elapsed;
		if (!activated)
		{
			Activate();
		}
	}
	
}