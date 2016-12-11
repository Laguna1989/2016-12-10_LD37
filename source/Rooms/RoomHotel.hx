package;

class RoomHotel extends Room
{
    public function new()
    {
        super();
		Cost = GP.MoneyHotelRoomCost;
		WidthInTiles = 3;
		this.loadGraphic(AssetPaths.room_hotel_med__png, false, 144, 48);
    }
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
	}
	
	public override function getXPos() 
	{
		return this.x + 64;
	}
}