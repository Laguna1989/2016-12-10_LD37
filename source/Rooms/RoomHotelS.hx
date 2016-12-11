package;

class RoomHotelS extends Room
{
    public function new()
    {
        super();
		Cost = GP.MoneyHotelRoomCostS;
		WidthInTiles = 2;
		this.loadGraphic(AssetPaths.room_hotel_small__png, false, 96, 48);
    }
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
		_infoText.text += "dirt: " + Std.string(Std.int(DirtLevel*100)) + "\n";
		_infoText.text += "noise: " + Std.string(Std.int(Props.NoiseFactor * 100)) + "\n";
	}
	
	public override function getXPos() 
	{
		return this.x + 64;
	}
}