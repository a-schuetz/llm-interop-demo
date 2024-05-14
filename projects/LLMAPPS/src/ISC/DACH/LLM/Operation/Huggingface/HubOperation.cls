Class ISC.DACH.LLM.Operation.Huggingface.HubOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

/// These are the production settings for this object
Parameter SETTINGS = "Model:Huggingface,CustomModel:Huggingface,APICredentials:Huggingface:credentialsSelector";

/// Model used in operation.
Property Model As %String(VALUELIST = ",meta-llama/Meta-Llama-3-70B-Instruct,meta-llama/Meta-Llama-3-8B-instruct,bigscience/bloom,mistralai/Mixtral-8x7B-Instruct-v0.1,NousResearch/Nous-Hermes-2-Mixtral-8x7B-DPO");

/// Custom model (Use for models not in list. Property 'Model' will be ignored. See https://huggingface.co/models).
Property CustomModel As %String;

/// This is the ID of the credentials containing the token
Property APICredentials As %String [ InitialExpression = "None" ];

/// Huggingface InferenceClient client
Property Client As %SYS.Python [ Private ];

/// json.dumps reference
Property ToJson As %SYS.Python [ Private ];

Property ActualModel As %String [ Private ];

/// This is the credentials object containing the values to be used to access the datasouce
Property %CredentialsObj As Ens.Config.Credentials [ Private ];

XData MessageMap
{
<MapItems>
  <MapItem MessageType="ISC.DACH.LLM.Operation.GenerateRequest">
    <Method>OnGenerateRequest</Method>
  </MapItem>
</MapItems>
}

Method OnGenerateRequest(pRequest As ISC.DACH.LLM.Operation.GenerateRequest, Output pResponse As ISC.DACH.LLM.Operation.GenerateResponse) As %Status
{
    #dim sc As %Status = $$$OK
    Set pResponse = ##class(ISC.DACH.LLM.Operation.GenerateResponse).%New()
    try {
        If (..CustomModel '= "") {
            Set tModel = ..CustomModel
        } Else {
            Set tModel = ..Model
        }
        Set pResponse.Response = ..GenerateRequest(pRequest, tModel)
        Set pResponse.Model = tModel
    } catch ex {
        set sc = ex.AsStatus()
    }

    quit sc
}

Method GenerateRequest(pRequest As ISC.DACH.LLM.Operation.GenerateRequest, pModel As %String) As %String [ Language = python ]
{
    params = {
        "max_new_tokens": pRequest.MaxNewTokens,
        "do_sample": pRequest.TopK != 1,
        "top_k": pRequest.TopK,
        "top_p": pRequest.TopP,        
    }

    self.Trace("HuggingfaceHub request - Model:" + pModel + " - Params: " + self.ToJson(params))
    output = self.Client.text_generation(prompt=pRequest.Prompt, 
                                         max_new_tokens = pRequest.MaxNewTokens,
                                         do_sample=pRequest.TopK != 1,                                          
                                         top_k = pRequest.TopK,
                                         top_p = pRequest.TopP)
    self.Trace("API Response: " + output)
    return output
}

Method CredentialsSet(pInVal As %String) As %Status [ Private ]
{
	#; (Re)Set the Credentials object; do it always because we never know if the source row fields might have been updated
	#; make sure to instantiate even if re-setting to the InitialExpression string
	Set ..%CredentialsObj=$$$NULLOREF

	Set tClassname=$zobjmethod($this,"%ClassName",1) ; call subclass
	Set tClass = $$$comMemberKeyGet(tClassname,$$$cCLASSproperty,"%CredentialsObj",$$$cPROPtype)
	If ""'=tClass {
		Set tSC=##Class(Ens.Config.Credentials).GetCredentialsObj(.tObj,tClassname,tClass,pInVal)
		If $$$ISOK(tSC) { Set ..%CredentialsObj=tObj }
		ElseIf '$$$StatusEquals(tSC,$$$EnsErrNoCallerCredentials) {
			$$$LOGSTATUS(tSC)
		}
	}
	Quit $$$OK
}

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK

   /// Get APIKey and Secret from credentials id
    If '$IsObject(..%CredentialsObj) {
        Do ..CredentialsSet(..APICredentials) 
    }

    // Validate if credentials were obtained successfully
    If '$IsObject(..%CredentialsObj) { 
        Set tSC=$$$EnsError($$$EnsErrNoCredentials,..APICredentials) 
        Quit tSC
    }

    try {
        do ..PyInit()
    } catch ex {
        set sc = ex.AsStatus()
    }
    quit sc
}

Method PyInit() [ Language = python ]
{
    from huggingface_hub import InferenceClient
    from json import dumps

    self.ActualModel = self.CustomModel if self.CustomModel else self.Model
    self.Client = InferenceClient(model=self.ActualModel, token=self._CredentialsObj.Password)
    self.ToJson = dumps
    self.Trace("Huggingface Hub Model: "+ self.ActualModel)
}

ClassMethod LogInfo(Msg As %String)
{
    $$$LOGINFO(Msg)
}

ClassMethod Trace(Msg As %String)
{
    $$$TRACE(Msg)
}

}
