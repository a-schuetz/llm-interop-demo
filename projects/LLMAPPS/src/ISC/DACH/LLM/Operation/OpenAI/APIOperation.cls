Class ISC.DACH.LLM.Operation.OpenAI.APIOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

/// These are the production settings for this object
Parameter SETTINGS = "Model:OpenAI,CustomModel:OpenAI,OrganizationCredentials:OpenAI:credentialsSelector,ProjectCredentials:OpenAI:credentialsSelector";

/// Model used in operation.
Property Model As %String(VALUELIST = ",gpt-4o,gpt-4-turbo,gpt-3.5-turbo");

/// Custom model (Use for models not in list. Property 'Model' will be ignored. See https://huggingface.co/models).
Property CustomModel As %String;

/// This is the ID of the credentials where the password is 
/// containing the OpenAI project Organization ID.
Property OrganizationCredentials As %String;

/// This is the ID of the credentials containing the OpenAI projectID and key where the 
/// username property contains the projectID and the password property the project API key.
/// Leave username (projectID) empty to use the default project.
Property ProjectCredentials As %String;

/// Huggingface InferenceClient client
Property Client As %SYS.Python [ Private ];

/// json.dumps reference
Property ToJson As %SYS.Python [ Private ];

Property ActualModel As %String [ Private ];

/// This is the credentials object containing the values to be used to access the datasouce
Property %OrganizationCredentislObj As Ens.Config.Credentials [ Private ];

/// This is the credentials object containing the values to be used to access the datasouce
Property %ProjectCredentialsObj As Ens.Config.Credentials [ Private ];

XData MessageMap
{
<MapItems>
  <MapItem MessageType="ISC.DACH.LLM.Operation.GenerateRequest">
    <Method>OnGenerateRequest</Method>
  </MapItem>
</MapItems>
}

Method OnGenerateRequest(pRequest As ISC.DACH.LLM.Operation.GenerateRequest, Output pResponse As ISC.DACH.LLM.Operation.OpenAI.OpenAIResponse) As %Status
{
    #dim sc As %Status = $$$OK
    Set pResponse = ##class(ISC.DACH.LLM.Operation.OpenAI.OpenAIResponse).%New()
    try {
        Do pResponse.%JSONImport(..GenerateRequest(pRequest))
    } catch ex {
        set sc = ex.AsStatus()
    }

    quit sc
}

Method GenerateRequest(pRequest As ISC.DACH.LLM.Operation.GenerateRequest) As %String [ Language = python ]
{
    params = {
        "max_tokens": pRequest.MaxNewTokens,
        "top_p": pRequest.TopP,        
    }
    self.Trace("OpenAI request - Model:" + self.ActualModel + " - max_tokens: " + str(pRequest.MaxNewTokens) + " - top_p: " + str(pRequest.TopP))

    response = self.Client.chat.completions.create(
        model=self.ActualModel,
        top_p=pRequest.TopP,
        max_tokens=pRequest.MaxNewTokens,
        messages=[{"role": "user", "content": pRequest.Prompt}]
    )
    responseObj = {
        "model": response.model,
        "created": response.created,
        "response": response.choices[0].message.content,
        "finish_reason": response.choices[0].finish_reason,
        "completion_tokens": response.usage.completion_tokens,
        "prompt_tokens": response.usage.prompt_tokens,
        "total_tokens": response.usage.total_tokens
    }
    
    output = self.ToJson(responseObj)
    self.Trace("API Response: " + output)
    return output
}

Method CredentialsSet(pInVal As %String, pCredendtialsObj As %String) As %Status [ Private ]
{
	#; (Re)Set the Credentials object; do it always because we never know if the source row fields might have been updated
	#; make sure to instantiate even if re-setting to the InitialExpression string
	Set $PROPERTY(, pCredendtialsObj)=$$$NULLOREF

	Set tClassname=$zobjmethod($this,"%ClassName",1) ; call subclass
	Set tClass = $$$comMemberKeyGet(tClassname,$$$cCLASSproperty,pCredendtialsObj,$$$cPROPtype)
	If ""'=tClass {
		Set tSC=##Class(Ens.Config.Credentials).GetCredentialsObj(.tObj,tClassname,tClass,pInVal)
		If $$$ISOK(tSC) { Set $PROPERTY(, pCredendtialsObj)=tObj }
		ElseIf '$$$StatusEquals(tSC,$$$EnsErrNoCallerCredentials) {
			$$$LOGSTATUS(tSC)
		}
	}
	Quit $$$OK
}

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK

    /// Get Organizazion ID from credentials id
    If '$IsObject(..%OrganizationCredentislObj) {
        Do ..CredentialsSet(..OrganizationCredentials, "%OrganizationCredentislObj") 
    }
    // Validate if credentials were obtained successfully
    If '$IsObject(..%OrganizationCredentislObj) { 
        Set tSC=$$$EnsError($$$EnsErrNoCredentials,..OrganizationCredentials) 
        Quit tSC
    }

    /// Get APIKey and Secret from credentials id
    If '$IsObject(..%ProjectCredentialsObj) {
        Do ..CredentialsSet(..ProjectCredentials, "%ProjectCredentialsObj") 
    }
    // Validate if credentials were obtained successfully
    If '$IsObject(..%ProjectCredentialsObj) { 
        Set tSC=$$$EnsError($$$EnsErrNoCredentials,..ProjectCredentials) 
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
    from openai import OpenAI
    from json import dumps

    self.ToJson = dumps
    self.ActualModel = self.CustomModel if self.CustomModel else self.Model
    self.Trace("OpenAI Model: "+ self.ActualModel)

    self.Client = OpenAI(
        organization=self._OrganizationCredentislObj.Password,
        project=self._ProjectCredentialsObj.Username,
        api_key=self._ProjectCredentialsObj.Password
    )
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
