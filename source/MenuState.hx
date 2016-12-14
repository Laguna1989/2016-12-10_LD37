package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.FlxState;
import flixel.text.FlxText;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{

	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		var backgroundSprite : FlxSprite = new FlxSprite();

		//backgroundSprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		backgroundSprite.loadGraphic(AssetPaths.menu__png, false, 250, 156);
		backgroundSprite.screenCenter(FlxAxes.X);
		
		add(backgroundSprite);
		
		var t1 : FlxText = new FlxText (10, 156, (FlxG.width) - 20, 
		"Manage your hotel to the biggest skyscraper in town!" , 8);
		t1.alignment = FlxTextAlign.CENTER;
		
		var t2 : FlxText = new FlxText (10, 320, FlxG.width - 20, 
		"created by @Thunraz, @xXBloodyOrangeXx and @Laguna_999 for #LDJam 37\nMusic by Blue Dot Sessions from the Album TinyTinyTrio. Remixed version. Original from: http://freemusicarchive.org/music/Blue_Dot_Sessions/TinyTiny_Trio/", 8);
		t2.y = FlxG.height - t2.height - 10;
		t2.color = FlxColor.GRAY;
		
		var t3 : FlxText = new FlxText(FlxG.width - 10, 190, (FlxG.width / 2) - 20, "Press [Space] zo start", 8);
		t3.alignment = FlxTextAlign.CENTER;
		t3.screenCenter(FlxAxes.X);
		
		FlxTween.tween(t3.scale, { x:1.4, y: 1.4 }, 1, { ease: FlxEase.bounceOut,type:FlxTween.PINGPONG } );
		FlxTween.color(t3, 1, FlxColor.WHITE, FlxColor.fromRGB(85, 171, 171), { type : FlxTween.PINGPONG } );
		add(t1);
		add(t2);		
		add(t3);
		
		FlxG.sound.playMusic(AssetPaths.hor_ost__ogg, 1, true);
		
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