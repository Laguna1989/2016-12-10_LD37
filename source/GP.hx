package;

using MathExtender;
/**
 * ...
 * @author 
 */
class GP
{

	public static var RoomSizeInPixel   (default, null) : Int = 48;
	static public var WorldSizeXInPixel (default, null) : Float = 1500;
	static public var GuestSizeInPixel (default, null) : Int = 32;
	static public var GroundLevel (default, null) : Float = 528;
	
	static public var GuestMovementSpeed (default, null) : Float = 20;
	static public var GuestElevatorTimePerLevel (default, null) : Float = 3;
	static public var ReceptionWaitingTime (default, null) : Float  = 5;
	
	
	static public var MoneyGuestRecipeRoomCost (default, null) : Int = 300;
	static public var MoneyTipAmount (default, null) : Int = 600;
	
	static public var MoneyElevatorBaseCost (default, null) : Int = 300;
	static public var MoneyGeneratorCost (default, null) : Int = 800;
	static public var MoneyHotelRoomCost (default, null) : Int = 1100;
	
	static public var GeneratorNoiseReach (default, null) : Float = 6;
	static public var MoneyServiceRoomCost (default, null) : Int = 500;
	
	static public var JobListTimerMax (default, null) : Float = 2.5;
	static public var WorkerSalaryTimerMax (default, null) : Float = 25;
	static public var WorkerBaseSalary (default, null) : Int = 60;
	
	static public function CalcSatisfactionInRoom (g : Guest, r: Room) : Float
	{
		var baseLevel : Float = 0.25;
		var dirtLevel : Float = 0.35;
		var noiseLevel : Float = 0.25;
		var powerLevel : Float = 0.15;
		var noiseInRoom : Float = r.Props.NoiseFactor;
		noiseInRoom.Clamp();
		var ret : Float = baseLevel;
		ret += dirtLevel * (1.0 - r.DirtLevel);
		ret += noiseLevel * (1.0 - r.Props.NoiseFactor);
		ret += powerLevel * (r.Powered? 1.0 : 0.0);
	
		return ret;
	}
	
}