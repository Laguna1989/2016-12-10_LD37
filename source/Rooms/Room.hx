package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */

class Room extends FlxSprite
{
	public var Props:RoomProperties;
	
	public var Level : Int = 0;
	public var TilePosX : Int = 0;
	public var WidthInTiles : Int = 3;
	public var name : String = "";
	
	public var isFree : Bool = true;
	public var Cost : Int;
	
	public var Powered : Bool = false;
	private var _poweredSprite : FlxSprite;
	
	public var DirtLevel : Float = 0;	// this is a value between 0 and 1, 
									// where 0 means totally clean and 1 means totally messed up
	public function new() 
	{
		super();
		WidthInTiles = 3;
		Cost = 100;
		this.makeGraphic(GP.RoomSizeInPixel * WidthInTiles -1, GP.RoomSizeInPixel * 1 - 1, FlxColor.WHITE);
		Props = new RoomProperties();
		this.alpha = 0.5;
		
		_poweredSprite = new FlxSprite(0, 0);
		_poweredSprite.makeGraphic(16, 16, FlxColor.YELLOW);
		_poweredSprite.alpha = 0.5;
	}
	
	public function BuildMe()
	{
		Level = Std.int(this.y / GP.RoomSizeInPixel) ;
		TilePosX = Std.int(this.x / GP.RoomSizeInPixel);
		this.alpha = 1;
		
		var lstring : String = "";
		if (Level < 100) lstring += "0";
		if (Level < 10) lstring += "0";
		lstring += Std.string(Level);
		
		var xstring : String = "";
		if (TilePosX < 100) xstring += "0";
		if (TilePosX < 10) xstring += "0";
		xstring += Std.string(TilePosX);
		
		name = "room_" + lstring + "_" + xstring;
		
		_poweredSprite.setPosition(x, y);
	}
	
	public function overlapsOtherRoom(o : Room) : Bool
	{
		Level = Std.int(this.y / GP.RoomSizeInPixel);
		TilePosX = Std.int(this.x / GP.RoomSizeInPixel);
		if (o.Level != Level) return false;
		
		if (TilePosX + WidthInTiles <= o.TilePosX) return false;
		if (TilePosX  >= o.TilePosX + o.WidthInTiles) return false;
		
		return true;	
	}
	
	public override function update (elapsed : Float)
	{
		super.update(elapsed);
		
		// cap dirtlevel
		if (DirtLevel >= 1) DirtLevel = 1;
		
	}
	
	public override function draw()
	{
		super.draw();
		if (Powered)
		{
			_poweredSprite.draw();
		}
	}
	
	
	public function lock()
	{
		isFree = false;
		color = FlxColor.GRAY;
	}
	public function unlock()
	{
		isFree = true;
		color = FlxColor.WHITE;
	}
}