/// This Operation creates a simple LLM prompt by replacing a placholder in a prompt template.
Class ISC.DACH.LLM.Operation.Prompt.SimplePromptOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

/// These are the production settings for this object
Parameter SETTINGS = "Template:Prompt Settings,Placeholder:Prompt Settings";

/// Placeholder will be replaced in prompt by the input sequence.
Property Placeholder As %String(MAXLEN = 50) [ InitialExpression = "<#INPUT#>" ];

/// Prompt template.
Property Template As %String(MAXLEN = "");

XData MessageMap
{
<MapItems>
  <MapItem MessageType="ISC.DACH.LLM.Operation.Prompt.PromptRequest">
    <Method>OnPromptRequest</Method>
  </MapItem>
</MapItems>
}

Method OnPromptRequest(pRequest As ISC.DACH.LLM.Operation.Prompt.PromptRequest, Output pResponse As ISC.DACH.LLM.Operation.Prompt.PromptResponse) As %Status
{
    #dim tSC as %Status = $$$OK

    Set pResponse = ##class(ISC.DACH.LLM.Operation.Prompt.PromptResponse).%New()
    Set pResponse.Prompt = $REPLACE(..Template, ..Placeholder, pRequest.InputSequence)

    return tSC
}

}
