package;

import flash.net.FileFilter;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.FlxPointer;
import flixel.math.FlxVector;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Guest extends FlxSprite
{
	private var _actions : Array<GuestAction>;
	
	public var _state :PlayState;
	public var Level : Int = 0;
	
	public var CanLeave : Bool = false;
	
	public var _roomName : String = "";
	
	public var SatisfactionFactor : Float = 1.0;
	
	public var movefactor : Float = 1.0;
	
	public var _dirtlevel : Float = 0.0;
	
	private var _infoBG : FlxSprite;
	private var _infoText : FlxText;
	
	public var AccumulatedWaitingTime  : Float = 0;	// in seconds
	public var AcceptedWaitingTime : Float = 15;
	
	private var _forceLeave : Bool = false;
	
	public function new(state:PlayState) 
	{
		super( -10, GP.GroundLevel);
		_state = state;
		this.offset.set(0, GP.GuestSizeInPixel);
		//this.makeGraphic(GP.GuestSizeInPixel, GP.GuestSizeInPixel, FlxColor.BLUE);
		this.loadGraphic(AssetPaths.people__png, true, 16, 32, false);
		this.animation.add("janitor", [0]);
		this.animation.add("mechanic", [1]);
		this.animation.add("guest1", [2]);
		this.animation.add("guest2", [3]);
		this.animation.add("guest3", [4]);
		this.animation.add("guest4", [5]);
		this.animation.add("guest5", [6]);
		
		var i : Int = FlxG.random.int(1, 5);
		
		
		this.animation.play("guest"+Std.string(i));
		//this.velocity.set(32);
		_actions = new Array<GuestAction>();
		
		var w1 : GuestActionWalk = new GuestActionWalk(this);
		w1.targetRoom = "reception";
		_actions.push(w1);
		
		var a1 : GuestActionAssignRoom = new GuestActionAssignRoom(this);
		_actions.push(a1);
		
		_infoText = new FlxText(0, 0, 100, "");
		_infoBG = new FlxSprite(0, 0);
		_infoBG.makeGraphic(100, 32, FlxColor.GRAY);
		_infoBG.alpha = 0.5;
		
		movefactor = FlxG.random.floatNormal(1, 0.5);
		movefactor = (movefactor < 0.5) ? 0.5 : movefactor;
		
		_dirtlevel = FlxG.random.floatNormal(0.5, 0.5);
		_dirtlevel = (_dirtlevel < 0) ? 0.1:  _dirtlevel;
		
		AcceptedWaitingTime = FlxG.random.floatNormal(25, 3.5);
		AcceptedWaitingTime = (AcceptedWaitingTime < 0)?  0.1 : AcceptedWaitingTime;
	}
	
	public override function update(elapsed:Float) : Void 
	{
		super.update(elapsed);
		if (SatisfactionFactor <= 0.1) SatisfactionFactor = 0.1;
		
		Level = Std.int((this.y-GP.GuestSizeInPixel) / GP.RoomSizeInPixel) ;
		//trace(_actions.length);
		if (_actions.length > 0)
		{
			_actions[0].update(elapsed);
			if (_actions[0].IsFinished())
			{
				NextAction();
			}
		}
		if (AccumulatedWaitingTime >= AcceptedWaitingTime)
		{
			if (!_forceLeave)
			{
				_forceLeave = true;
				SatisfactionFactor = 0.01;
				
				var e1 : GuestActionExit = new GuestActionExit(this);
				AddActionToBegin(e1);
				e1.Activate();
			}
		}
		_infoBG.setPosition(this.x + GP.GuestSizeInPixel, this.y - GP.GuestSizeInPixel);
		_infoText.setPosition(this.x + GP.GuestSizeInPixel, this.y - GP.GuestSizeInPixel);
		_infoText.text = "L: " + Std.string(Level) + " ";
		_infoText.text += "Sat: " + Std.string(Std.int(SatisfactionFactor * 100));
		_infoText.text += "\nAct[" + _actions.length + "] = " + ((_actions.length != 0)?  _actions[0].name : "--" );
		_infoText.text += "\nWait: " + Std.int(AccumulatedWaitingTime) + " / " + Std.int(AcceptedWaitingTime);
	}
	
	function NextAction():Void 
	{
		var a : GuestAction = _actions[0];
		_actions.remove(a);
		a.DoFinish();
		if (_actions.length > 0)
			_actions[0].Activate();
	}

	public function AddActionToBegin(a:GuestAction) 
	{
		//trace("AddBegin " + _actions.length );
		if (a == null) return;
		
		if (_actions.length > 0)
		{
			_actions[0].activated = false;
		}
		
		//a.Activate();
		var _newActions : Array<GuestAction> = new Array<GuestAction>();
		_newActions.push(a);
		//trace("AddBegin newactions " + _newActions.length );
		_actions = _newActions.concat(_actions);
		//_actions = _newActions;
		//trace("AddBegin End " + _actions.length );
	}
	
	public function AddAction(a:GuestAction) : Void
	{
		_actions.push(a);
	}
	
	public override function draw()
	{
		super.draw();
		
		var obj : FlxObject = new FlxObject(FlxG.mouse.getWorldPosition(FlxG.camera).x, FlxG.mouse.getWorldPosition(FlxG.camera).y+32, 10, 10);
		if (this.overlaps(obj))
		{
			_infoBG.draw();
			_infoText.draw();
		}
	}
	
}