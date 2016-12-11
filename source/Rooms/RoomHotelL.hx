package;

class RoomHotelL extends Room
{
    public function new()
    {
        super();
		Cost = GP.MoneyHotelRoomCostL;
		WidthInTiles = 5;
		this.loadGraphic(AssetPaths.room_hotel_large__png, false, 240, 48);
    }
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
		_infoText.text += "size: L\n";
		var ls: String = "";
		if (Luxus == 0) ls = "low";
		else if (Luxus == 1) ls = "med";
		else if (Luxus == 2) ls = "high";
		_infoText.text += "luxus: " + ls + "\n";
		_infoText.text += "dirt: " + Std.string(Std.int(DirtLevel*100)) + "\n";
		_infoText.text += "noise: " + Std.string(Std.int(Props.NoiseFactor * 100)) + "\n";
	}
	
	public override function getXPos() 
	{
		return this.x + 64;
	}
}