package;

class RoomHotel extends Room
{
    public function new()
    {
        super();
		Cost = GP.MoneyHotelRoomCost;
    }
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
	}
}