@isTest
private class FlowFactoryDemoControllerTest 
{
    static testMethod void testDemo1() 
    {
    	// Here you might add system.asserts to verify the flow path and/or the 
    	// results of the executed step logic. 

    	FlowFactoryDemoController dc = new FlowFactoryDemoController();
    	dc.executeFlow();
    	dc.inUSRegistry = true;
    	dc.executeFlow();
    	dc.inRewardsProgram = true;
    	dc.executeFlow();
    	dc.inIntlRegistry = true;
    	dc.executeFlow();
    }
}