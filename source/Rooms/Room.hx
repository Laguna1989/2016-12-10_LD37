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
	
	public function new() 
	{
		super();
		WidthInTiles = 3;
		this.makeGraphic(GP.RoomSizeInPixel * WidthInTiles -1, GP.RoomSizeInPixel * 1 - 1, FlxColor.WHITE);
		Props = new RoomProperties();
		this.alpha = 0.5;
		
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
		
		name = "room_" + lstring + "_" +xstring;
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