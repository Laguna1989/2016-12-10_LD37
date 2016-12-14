package;

/**
 * ...
 * @author 
 */
class JobPool
{
	private var _jobsCleaning: Array<JobCleaning>;
	private var _jobsInProgress : Array<String>;
	private var _state : PlayState;

	public function new(state : PlayState)
	{
		_state = state;

		_jobsCleaning = new Array<JobCleaning>();
		_jobsInProgress = new Array<String>();
	}
	
	public function addCleaningJob(n : String, d : Float)
	{
		// check if there is a job in progress
		for (r in _jobsInProgress)
		{
			if ( r == n) return ;
		}
		
		if (d == 0) return;
		for (i in 0..._jobsCleaning.length)
		{
			var j : JobCleaning = _jobsCleaning[i];
			
			if (j.roomName == n)
			{
				if (d > j.dirtyness)
					j.dirtyness = d;
				return;
			}
		}
		var j : JobCleaning = new JobCleaning();
		j.roomName = n;
		j.dirtyness = d;
		_jobsCleaning.push(j);
	}
	
	public function finishJob(n:String)
	{
		for (r in _jobsInProgress)
		{
			if (r == n)
			{
				_jobsInProgress.remove(r);
				return;
			}
		}
		trace("No Job found: " + n);
	}

	public function removeJobsForRoom(r : Room)
	{
		// Remove upcoming jobs
		for(j in _jobsCleaning)
		{
			if(j.roomName == r.name)
			{
				_jobsCleaning.remove(j);
			}
		}

		// Remove current jobs
		for(n in _jobsInProgress)
		{
			trace('Job in progress: $n');
			if(n == r.name)
			{
				_jobsInProgress.remove(n);
			}
		}

		for(w in _state.GetWorkers())
		{
			w.CancelRoomJobs(r);
		}

		for(g in _state.GetGuests())
		{
			g.CheckAndLeave(r);
		}
	}
	
	public function getMostUrgentCleaningJob () : JobCleaning
	{
		var ret : JobCleaning = null;
		var maxd : Float = -1;
		for (j in _jobsCleaning)
		{
			if (j.dirtyness > maxd)
			{
				maxd = j.dirtyness;
				ret = j;
			}
		}
		if (ret != null)
		{
			_jobsCleaning.remove(ret);
			_jobsInProgress.push(ret.roomName);
		}
		return ret;
	}
	
}