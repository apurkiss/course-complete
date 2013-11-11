public with sharing class CourseComplete extends FlowFactory.FlowParent 
{
	public FlowFactory.FlowState executeFlow(Boolean inUSRegistry, Boolean inRewardsProgram, Boolean inIntlRegistry)
	{
		CourseCompleteState state = new CourseCompleteState();
		state.inUSRegistry = inUSRegistry;
		state.inRewardsProgram = inRewardsProgram;
		state.inIntlRegistry = inIntlRegistry;
		
		FlowFactory.Step step = new UpdateSalesforce();
		step.stepName = UpdateSalesforce.class.toString();
		processSteps(step, state);

		return state;
	}

	public class CourseCompleteState extends FlowFactory.FlowState
	{
		public Boolean inUSRegistry {get; set;}
		public Boolean inRewardsProgram {get; set;}
		public Boolean inIntlRegistry {get; set;}
	}
	
	public class UpdateSalesforce extends FlowFactory.Step 
	{
		public override FlowFactory.Step processStep(FlowFactory.FlowState fs)
		{
			CourseCompleteState ccs = (CourseCompleteState) fs;
			ccs.steps.add(this);
			if(ccs.inUSRegistry != true)
				this.nextStep = createInstance(CreateUSProfile.class.toString());
			else
				this.nextStep = createInstance(UpdateUSProfile.class.toString());

			return this.nextStep;
		}
		
		public override void finish()
		{
			// Update Salesforce (DML)
		}
	}

	public class CreateUSProfile extends FlowFactory.Step 
	{
		public override FlowFactory.Step processStep(FlowFactory.FlowState fs)
		{
			CourseCompleteState ccs = (CourseCompleteState) fs;
			ccs.steps.add(this);
			// Callout: create profile

			if(ccs.inRewardsProgram == true)
				this.nextStep = createInstance(AddRewardsPoints.class.toString());
			else
				if(ccs.inIntlRegistry == true)
					this.nextStep = createInstance(UpdateIntlProfile.class.toString());

			return this.nextStep;
		}

		public override void finish()
		{
			// Save callout results
			// Send welcome email
		}
	}

	public class UpdateUSProfile extends FlowFactory.Step
	{
		public override FlowFactory.Step processStep(FlowFactory.FlowState fs)
		{
			CourseCompleteState ccs = (CourseCompleteState) fs;
			ccs.steps.add(this);
			// Callout: update profile

			if(ccs.inRewardsProgram == true)
				this.nextStep = createInstance(AddRewardsPoints.class.toString());
			else
				if(ccs.inIntlRegistry == true)
					this.nextStep = createInstance(UpdateIntlProfile.class.toString());

			return this.nextStep;
		}

		public override void finish()
		{
			// Save callout results
		}
	}

	public class AddRewardsPoints extends FlowFactory.Step 
	{
		public override FlowFactory.Step processStep(FlowFactory.FlowState fs)
		{
			CourseCompleteState ccs = (CourseCompleteState) fs;
			ccs.steps.add(this);
			// Callout: add rewards points

			if(ccs.inIntlRegistry == true)
				this.nextStep = createInstance(UpdateIntlProfile.class.toString());

			return this.nextStep;
		}

		public override void finish()
		{
			// Save callout results
			// Send rewards email
		}
	}

	public class UpdateIntlProfile extends FlowFactory.Step 
	{
		public override FlowFactory.Step processStep(FlowFactory.FlowState fs)
		{
			CourseCompleteState ccs = (CourseCompleteState) fs;
			ccs.steps.add(this);
			// Callout: update international profile

			return null;
		}

		public override void finish()
		{
			// Save callout results
		}
	}
}