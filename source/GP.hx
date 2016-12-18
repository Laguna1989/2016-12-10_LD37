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
	
	
	static public var MoneyGuestRecipeRoomCost (default, null) : Int = 375;
	static public var MoneyTipAmount (default, null) : Int = 550;
	static public var MoneyOverLuxusTip (default, null) : Float = 0.25;
	
	static public var MoneyElevatorBaseCost (default, null) : Int = 450;
	
	static public var MoneyGeneratorRunningCost (default, null) : Int = 75;
	static public var MoneyGeneratorCost (default, null) : Int = 500;
	
	static public var MoneyHotelRoomCostS (default, null) : Int = 400;
	static public var MoneyHotelRoomCostM (default, null) : Int = 1000;
	static public var MoneyHotelRoomCostL (default, null) : Int = 2750;
	
	static public var MoneyServiceRoomCost (default, null) : Int = 150;
	
	static public var GeneratorNoiseReach (default, null) : Float = 4;
	
	
	static public var JobListTimerMax (default, null) : Float = 2.5;
	static public var WorkerSalaryTimerMax (default, null) : Float = 20;
	static public var WorkerBaseSalary (default, null) : Int = 95;
	static public var JanitorMoveFactor (default, null) : Float = 1.75;
	static public var WorkerCleaningTime (default, null) : Float = 15;
	static public var MoneyLuxusUpgrade (default, null) : Int = 175;
	
	
	static public function CalcSatisfactionInRoom (g : Guest, r: Room) : Float
	{
		var baseLevel : Float = 0.15;
		var dirtLevel : Float = 0.35;
		var noiseLevel : Float = 0.15;
		var powerLevel : Float = 0.35;
		var noiseInRoom : Float = r.Props.NoiseFactor;
		noiseInRoom.Clamp();
		var ret : Float = baseLevel;
		ret += dirtLevel * (1.0 - r.DirtLevel);
		ret += noiseLevel * (1.0 - r.Props.NoiseFactor);
		ret += powerLevel * (r.Powered? 1.0 : 0.0);
		ret +=  (g.minLuxus < r.Luxus) ? GP.MoneyOverLuxusTip : 0;
	
		return ret;
	}
	
	public static function GetSpawnTime(g : Int, r : Int) : Float
	{
		var max : Float = 20;
		var exp : Float = 2.5;
		
		var ret : Float = (Math.pow(g / (r+1), exp)) * max;
		return ret;
	}
	
}