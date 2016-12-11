package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.FlxState;
import flixel.text.FlxText;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	public static var HighScore : Int = 0;
	public static var LastScore : Int = 0;
	
	public static function setNewScore (s: Int)
	{
		LastScore = s;
		if (s > HighScore)
		{
			HighScore = s;
		}
	}

	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		//Palette.reset(197);
		var backgroundSprite : FlxSprite = new FlxSprite();
		backgroundSprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(backgroundSprite);
		var title : FlxText = new FlxText(100, 45, 0, "One Room Apartments", 20);
		title.screenCenter();
		title.y = 45;
		title.alignment = "CENTER";
		var t1 : FlxText = new FlxText (10, 100, FlxG.width - 20, "Manage your hotel from a one level building to the biggest skyscraper in town!\nRemember to put a service room on every floor.\n\nPlay with mouse\nScroll with [WASD]\nCancel with [ESC]\nPress [SPACE] to start" , 8);
		var t2 : FlxText = new FlxText (10, 300, FlxG.width - 20, "created by @Thunraz, @xXBloodyOrangeXx and @Laguna_999 for #LDJam 37\n2016-12-11\nvisit us at https://runvs.io", 8);
		t2.y = FlxG.height - t2.height - 20;
		add(title);
		add(t1);
		add(t2);		
	}
	
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed : Float):Void
	{	
		super.update(elapsed );
		if (FlxG.keys.pressed.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
	}	
}