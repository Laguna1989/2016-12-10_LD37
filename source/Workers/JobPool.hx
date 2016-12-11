package;

/**
 * ...
 * @author 
 */
class JobPool
{

	private var _jobsCleaning: Array<JobCleaning>;
	public function new() 
	{
		_jobsCleaning = new Array<JobCleaning>();
		
	}
	
	public function addCleaningJob(n : String, d : Float)
	{
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
		
		_jobsCleaning.remove(ret);
		return ret;
	}
	
}