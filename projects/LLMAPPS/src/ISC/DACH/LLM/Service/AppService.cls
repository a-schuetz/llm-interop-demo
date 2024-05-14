/// Passthrough Business Service for LLM APP Rest requests
Class ISC.DACH.LLM.Service.AppService Extends Ens.BusinessService
{

Parameter ADAPTER;

/// Configuration item(s) to which to send file stream messages
Property TargetConfigName As %String(MAXLEN = 1000);

Parameter SETTINGS = "TargetConfigName:Basic:selector?context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId}";

Method OnProcessInput(pInput As ISC.DACH.LLM.Msg.LLMAppRequest, Output pOutput As ISC.DACH.LLM.Msg.LLMAppResponse) As %Status
{
	#dim tSC as %Status = $$$OK

    $$$TRACE("App: "_pInput.App_", Input: '"_pInput.InputSequence_"'.")
	
	set tSC = ..SendRequestSync(..TargetConfigName, pInput, .tResponse)
	
	set pOutput = tResponse
	return tSC
}

/// Return an array of connections for drawing lines on the config diagram
ClassMethod OnGetConnections(Output pArray As %String, pItem As Ens.Config.Item)
{
    Do ##super(.pArray,pItem)
    If pItem.GetModifiedSetting("TargetConfigName",.tValue) {
        For i=1:1:$L(tValue,",") { 
            Set tOne=$ZStrip($P(tValue,",",i),"<>W")  
            Continue:""=tOne  Set pArray(tOne)="" }
    }
}

}
