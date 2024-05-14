Class ISC.DACH.LLM.Operation.Ollama.GenerateOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

/// These are the production settings for this object
Parameter SETTINGS = "OllamaHost:Ollama,Model:Ollama,CustomModel:Ollama";

/// Ollama model used in operation.
Property Model As %String(VALUELIST = ",llama3:text,llama3:instruct,mistral:text,mistral:instruct,phi3");

/// Custom Ollama model (Use for models not in list. Property 'Model' will be ignored).
Property CustomModel As %String;

/// Address of Ollama instance
Property OllamaHost As %String [ InitialExpression = "http://localhost:11434" ];

/// Ollama client
Property Client As %SYS.Python [ Private ];

/// json.dumps reference
Property ToJson As %SYS.Python [ Private ];

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
    Set pResponse = ##class(ISC.DACH.LLM.Operation.Ollama.OllamaResponse).%New()
    try {
        Do pResponse.%JSONImport(..GenerateRequest(pRequest))
    } catch ex {
        set sc = ex.AsStatus()
    }

    quit sc
}

Method GenerateRequest(pRequest As ISC.DACH.LLM.Operation.GenerateRequest) As %String [ Language = python ]
{
    model = self.CustomModel if self.CustomModel else self.Model
    options = {"num_predict": pRequest.MaxNewTokens, "top_k": pRequest.TopK, "top_p": pRequest.TopP}
    self.Trace("GenerateRequest - Model:" + model + " - Options: " + self.ToJson(options))
    response = self.Client.generate(model=model, prompt=pRequest.Prompt, options=options)
    self.Trace(self.ToJson(response))
    return self.ToJson(response)
}

Method OnInit() As %Status
{
   #dim sc As %Status = $$$OK
   try {
      do ..PyInit()
   } catch ex {
      set sc = ex.AsStatus()
   }
   quit sc
}

Method PyInit() [ Language = python ]
{
   from ollama import Client
   from json import dumps

   self.Client = Client(host=self.OllamaHost)
   self.ToJson = dumps
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
