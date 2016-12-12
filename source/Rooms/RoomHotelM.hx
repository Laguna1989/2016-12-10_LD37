package;

class RoomHotelM extends Room
{
    public function new()
    {
        super();
		Cost = GP.MoneyHotelRoomCostM;
		WidthInTiles = 3;
		this.loadGraphic(AssetPaths.room_hotel_med__png, false, 144, 48);
    }
	
	public override function update(elapsed : Float )
	{
		super.update(elapsed);
		
		_infoText.text += "size: M\n";
		var ls: String = "";
		if (Luxus == 0) ls = "low";
		else if (Luxus == 1) ls = "med";
		else if (Luxus == 2) ls = "high";
		_infoText.text += "luxury: " + ls + "\n";
		_infoText.text += "dirt: " + Std.string(Std.int(DirtLevel*100)) + "\n";
		_infoText.text += "noise: " + Std.string(Std.int(Props.NoiseFactor * 100)) + "\n";
	}

	public override function draw()
	{
		super.draw();
		
		_sprLuxury1.draw();
		if(Luxus > 0)
		{
			_sprLuxury2.draw();
			if(Luxus > 1)
			{
				_sprLuxury3.draw();
			}
		}
	}
	
	public override function getXPos() 
	{
		return this.x + 64;
	}
}