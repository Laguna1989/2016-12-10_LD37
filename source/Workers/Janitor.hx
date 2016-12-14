package;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Janitor extends Worker
{

	var _job : JobCleaning;
	
	public function new(s : PlayState) 
	{
		super(s);
		//this.makeGraphic(GP.GuestSizeInPixel, GP.GuestSizeInPixel, FlxColor.GREEN);
		this.movefactor = GP.JanitorMoveFactor;
		this.animation.play("janitor", true);
		minRoomSize = -1;
	}
	
	public override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		if (waitingForJob)
		{
			_job = _state.JobList.getMostUrgentCleaningJob();
			if (_job != null)
			{	
				_roomName = _job.roomName;
				trace("cleaning: Roomname " +_job.roomName);
				var c1 : GuestActionClean = new GuestActionClean(this);
				c1.target = _roomName;
				AddAction(c1);
			}
		}
	}
}