Class ISC.DACH.LLM.Operation.Ollama.ModelPullOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

/// These are the production settings for this object
Parameter SETTINGS = "OllamaHost:Ollama";

/// Address of Ollama instance
Property OllamaHost As %String [ InitialExpression = "http://localhost:11434" ];

/// Ollama client
Property Client As %SYS.Python [ Private ];

/// json.dumps reference
Property Tojson As %SYS.Python [ Private ];

XData MessageMap
{
<MapItems>
  <MapItem MessageType="ISC.DACH.LLM.Operation.Ollama.ModelPullRequest">
    <Method>OnPullRequest</Method>
  </MapItem>
</MapItems>
}

Method OnPullRequest(pRequest As ISC.DACH.LLM.Operation.Ollama.ModelPullRequest, Output pResponse As Ens.StringResponse) As %Status
{
    #dim sc As %Status = $$$OK
    Set pResponse = ##class(Ens.StringResponse).%New()
    try {
        Set pResponse.StringValue = ..PullModel(pRequest)
    } catch ex {
        set sc = ex.AsStatus()
    }

    quit sc
}

Method PullModel(pRequest As ISC.DACH.LLM.Operation.Ollama.ModelPullRequest) [ Language = python ]
{
    model = pRequest.CustomModel if pRequest.CustomModel else pRequest.Model
    self.Trace("Pull model reuqest: " + model)
    result = self.Client.pull(model)
    return self.Tojson(result)
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
   self.Tojson = dumps
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
