public with sharing class FlowFactoryDemoController 
{
	public Boolean inUSRegistry {get; set;}
	public Boolean inRewardsProgram {get; set;}
	public Boolean inIntlRegistry {get; set;}

	public List<ExecutedFlowStep> executedFlowSteps {get; private set;}
	public class ExecutedFlowStep
	{
		public Integer stepNumber {get; private set;}
		public String step {get; private set;}
		public String processStep {get; private set;}
		public String finish {get; private set;}
		
		public ExecutedFlowStep(Integer stepNumber, String step)
		{
			this.stepNumber = stepNumber;
			this.step = step;
			if(this.step == 'UpdateSalesforce')
			{
				this.finish = 'Update Salesforce';
			}
			else if(this.step == 'CreateUSProfile')
			{
				this.processStep = 'Callout: create profile';
				this.finish = 'Save callout results / send welcome email';
			}
			else if(this.step == 'UpdateUSProfile')
			{
				this.processStep = 'Callout: update profile';
				this.finish = 'Save callout results';
			}
			else if(this.step == 'AddRewardsPoints')
			{
				this.processStep = 'Callout: add rewards points';
				this.finish = 'Save callout results / send rewards email';
			}
			else if(this.step == 'UpdateIntlProfile')
			{
				this.processStep = 'Callout: update international profile';
				this.finish = 'Save callout results';
			}
		}
	}

	public FlowFactoryDemoController()
	{
		initVars();
	}
	
	private void initVars()
	{
		this.executedFlowSteps = new List<ExecutedFlowStep>();
	}
	
	public PageReference executeFlow()
	{
		CourseComplete cc = new CourseComplete();
		FlowFactory.FlowState fs = cc.executeFlow(this.inUSRegistry, this.inRewardsProgram, this.inIntlRegistry);

		this.executedFlowSteps.clear();
		for(Integer i=0; i<fs.steps.size(); i++)
			this.executedFlowSteps.add(new ExecutedFlowStep(i+1, fs.steps[i].stepName.replace('CourseComplete.', '')));

		return null;
	}
}