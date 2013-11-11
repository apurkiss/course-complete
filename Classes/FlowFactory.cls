public with sharing class FlowFactory 
{
	public virtual class FlowState
	{
		public List<Step> steps {get; set;}
		public FlowState(){ this.steps = new List<Step>(); }
	}

	public virtual class FlowParent
	{
		protected void processSteps(Step step, FlowState state)
		{
			Boolean keepGoing = true;
			while(keepGoing)
			{
				step = step.processStep(state);
				if(step == null) 
					keepGoing = false;
			}
			
			for(Step s : state.steps) s.finish();
		}
	}
	
	public virtual class Step
	{
		protected Step nextStep {get; set;}
		public String stepName {get; set;}

		public virtual Step processStep(FlowState fs){return null;}
		public virtual void finish(){}

		protected Step createInstance(String className)
		{
	        Type t = Type.forName(className);
	        this.nextStep = (Step) t.newInstance();
	        this.nextStep.stepName = className;
	        return this.nextStep;
		}
	}
}