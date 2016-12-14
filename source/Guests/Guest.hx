package;

import flash.net.FileFilter;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.FlxPointer;
import flixel.math.FlxVector;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
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
	
	public var minRoomSize : Int;
	public var minLuxus : Int;
	
	private var _leavesound : FlxSound;
	
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
		this.animation.add("guest6", [7]);
		this.animation.add("guest7", [8]);
		this.animation.add("guest8", [9]);
		this.animation.add("guest9", [10]);
		this.animation.add("guest10", [11]);
		this.animation.add("guest11", [12]);
		this.animation.add("guest12", [13]);
		this.animation.add("guest13", [14]);
		
		this.setFacingFlip(FlxObject.LEFT, false, false);
		this.setFacingFlip(FlxObject.RIGHT, true, false);
		
		var i : Int = FlxG.random.int(1, 13);
		if (i == 1)
		{
			minRoomSize = 0;
			minLuxus = 0;
		}
		else if (i == 2)
		{
			minRoomSize = 1;
			minLuxus = 0;
		}
		else if (i == 3)
		{
			minRoomSize = 1;
			minLuxus = 1;
		}
		else if (i == 4)
		{
			minRoomSize = 0;
			minLuxus = 0;
		}
		else if (i == 5)
		{
			minRoomSize = 1;
			minLuxus = 2;
		}
		else if (i == 6)
		{
			minRoomSize = 1;
			minLuxus = 1;
		}
		else if (i == 7)
		{
			minRoomSize = 1;
			minLuxus = 0;
		} 
		
		
		else if (i == 8)
		{
			minRoomSize = 1;
			minLuxus = 0;
		}
		else if (i == 9)
		{
			minRoomSize = 1;
			minLuxus = 0;
		}
		else if (i == 10)
		{
			minRoomSize = 0;
			minLuxus = 1;
		}
		else if (i == 11)
		{
			minRoomSize = 2;
			minLuxus = 0;
		} 
		
		else if (i == 12)
		{
			minRoomSize = 2;
			minLuxus = 1;
		}
		else if (i == 13)
		{
			minRoomSize = 2;
			minLuxus = 2;
		}
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
		_infoBG.makeGraphic(100, 48, FlxColor.GRAY);
		_infoBG.alpha = 0.5;
		
		movefactor = FlxG.random.floatNormal(1, 0.5);
		movefactor = (movefactor < 0.5) ? 0.5 : movefactor;
		
		_dirtlevel = FlxG.random.floatNormal(0.25, 0.25);
		_dirtlevel = (_dirtlevel < 0) ? 0.1:  _dirtlevel;
		
		AcceptedWaitingTime = FlxG.random.floatNormal(25, 3.5);
		AcceptedWaitingTime = (AcceptedWaitingTime < 0)?  0.1 : AcceptedWaitingTime;
		
		_leavesound = new FlxSound();
		_leavesound = FlxG.sound.load(AssetPaths.hor_ohno__ogg, 0.5);
	}
	
	public override function update(elapsed:Float) : Void 
	{
		super.update(elapsed);
		if (velocity.x < 0) this.facing = FlxObject.LEFT;
		else this.facing = FlxObject.RIGHT;
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
				_leavesound.play();
				_forceLeave = true;
				SatisfactionFactor = 0.01;
				
				_actions = new Array<GuestAction>();
				var e1 : GuestActionExit = new GuestActionExit(this);
				AddActionToBegin(e1);
				e1.Activate();
				var r : RoomReception = Std.instance(_state.getRoomByName("reception"), RoomReception);
				if (r != null)
				{
					r.WaitingDecrease();
				}
			}
		}
		_infoBG.setPosition(this.x + GP.GuestSizeInPixel, this.y - GP.GuestSizeInPixel);
		_infoText.setPosition(this.x + GP.GuestSizeInPixel, this.y - GP.GuestSizeInPixel);
		_infoText.text = "L: " + Std.string(Level) + " ";
		_infoText.text += "Sat: " + Std.string(Std.int(SatisfactionFactor * 100));
		//_infoText.text += "\nAct[" + _actions.length + "] = " + ((_actions.length != 0)?  _actions[0].name : "--" );
		_infoText.text += "\nAnnoyed: " + Std.int(AccumulatedWaitingTime/AcceptedWaitingTime*100.0) ;
		
		
		if (minRoomSize != -1)
		{
			var SML : String = "";
			if (minRoomSize == 0)
				SML = "S, M, L";
			else if (minRoomSize == 1)
				SML = "M, L";
			else if (minRoomSize == 2)
				SML = "L";
				
			_infoText.text += "\nroomSize: " +  SML ;
			var Lux : String = "";
			if (minLuxus == 0)
				Lux = "low";
			else if (minLuxus == 1)
				Lux = "med";
			else if (minLuxus == 2)
				Lux = "high";
				
			_infoText.text += "\nLuxus: "  + Lux;
		}
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

	public function CheckAndLeave(r : Room)
	{
		// If guest is doing something with the room
		// while it gets deleted, leave.
		if(r.name == _roomName)
		{
			_actions = _actions.filter(function(a : GuestAction) { return a.name == "elevator"; });
			alpha = 1.0;
			
			SatisfactionFactor = 0.0;
			_actions.push(new GuestActionLeave(this));
		}
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