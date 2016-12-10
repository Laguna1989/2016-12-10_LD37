package ;

/**
 * ...
 * @author 
 */
class GuestAction
{
	var _guest : Guest;

	public function IsFinished () : Bool
	{
		return true;
	}
	
	public function new( g : Guest) 
	{
		_guest = g;
	}
	
	public function update(elapsed:Float) 
	{
		
	}
	
}