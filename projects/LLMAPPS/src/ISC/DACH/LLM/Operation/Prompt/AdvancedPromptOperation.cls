Class ISC.DACH.LLM.Operation.Prompt.AdvancedPromptOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

/// These are the production settings for this object
Parameter SETTINGS = {"PromptHeader:Prompt Settings,SampleTemplate:Prompt Settings,InputTemplate:Prompt Settings"_
                      ",InputPlaceholder:Advanced Prompt Settings,SampleTextPlaceholder:Advanced Prompt Settings"_
                      ",SampleLabelPlaceholder:Advanced Prompt Settings"_
                      ",SampleClass:Sample Settings:selector?context={Ens.ContextSearch/SubclassOf?class=ISC.DACH.LLM.PromptSample&abstract=0}"_
                      ",SampleTextProperty:Sample Settings,SampleLabelProperty:Sample Settings,SampleIDs:Sample Settings"};

/// Frist part of the prompt.
Property PromptHeader As %String(MAXLEN = 200);

/// Template of a single sample line in the prompt. The samples will be inserted into the prompt after the header. Use "\n" as a placeholder for a new line.
Property SampleTemplate As %String(MAXLEN = 200) [ InitialExpression = "<#SAMPLE#>:<#LABEL#>" ];

/// Template of the part where the input will be inserted int the pronmpt. This is the last part of the prompt after the samples.
Property InputTemplate As %String(MAXLEN = 200) [ InitialExpression = "<#INPUT#>:" ];

/// Placeholder used in InputTemplate which will be replaced by the input sequence.
Property InputPlaceholder As %String(MAXLEN = 50) [ InitialExpression = "<#INPUT#>" ];

/// Placeholder used in SampleTemplate which will be replaced by the sample.
Property SampleTextPlaceholder As %String(MAXLEN = 50) [ InitialExpression = "<#SAMPLE#>" ];

/// Placeholder used in SampleTemplate will be replaced by the label of the sample.
Property SampleLabelPlaceholder As %String(MAXLEN = 50) [ InitialExpression = "<#LABEL#>" ];

/// Persistent class from which the samples are taken.
Property SampleClass As %String(MAXLEN = 500);

/// Name of the property which contains the sample text.
Property SampleTextProperty As %String(MAXLEN = 100);

/// Name of the property which contains the sample label.
Property SampleLabelProperty As %String(MAXLEN = 100);

/// ID of samples which shall be used in the prompt. Seperate with ",", used "-" for ranges (e.g. "1, 3-5, 10").
Property SampleIDs As %String(MAXLEN = 200) [ InitialExpression = "1-10" ];

XData MessageMap
{
<MapItems>
  <MapItem MessageType="ISC.DACH.LLM.Operation.Prompt.PromptRequest">
    <Method>OnPromptRequest</Method>
  </MapItem>
</MapItems>
}

Method OnInit() As %Status
{
   #dim sc As %Status = $$$OK
   quit sc
}

Method GenerateSampleLine(pSampleID As %String) As %String
{
    Try {
        Set tSampleObj = $CLASSMETHOD(..SampleClass, "%OpenId", pSampleID)
        Set tText = $PROPERTY(tSampleObj, ..SampleTextProperty)
        Set tLabel = $PROPERTY(tSampleObj, ..SampleLabelProperty)

        Set tSampleLine = $REPLACE(..SampleTemplate, ..SampleTextPlaceholder, tText)
        Set tSampleLine = $REPLACE(tSampleLine, ..SampleLabelPlaceholder, tLabel)
    }
    Catch ex{
        $$$LOGWARNING(ex.AsStatus())
        Set tSampleLine = ""
    }

    Return tSampleLine
}

Method OnPromptRequest(pRequest As ISC.DACH.LLM.Operation.Prompt.PromptRequest, Output pResponse As ISC.DACH.LLM.Operation.Prompt.PromptResponse) As %Status
{
    #dim tSC As %Status = $$$OK
    Set tPrompt = ..PromptHeader

    For i=1:1:$L(..SampleIDs,",") {
        Set tSampleID=$ZStrip($PIECE(..SampleIDs,",",i),"<>W")  
        Continue:""=tSampleID

        If ($FIND(tSampleID, "-", 2) = 0) {
            Set tSampleLine = ..GenerateSampleLine(tSampleID)
            Continue:tSampleLine=""
            Set tPrompt = tPrompt_$CHAR(10)_tSampleLine
        } Else {
            Set tStart = $ZStrip($PIECE(tSampleID,"-",1),"<>W")
            Set tEnd = $ZStrip($PIECE(tSampleID,"-",2),"<>W")
            For j=tStart:1:tEnd {
                Set tSampleLine = ..GenerateSampleLine(j)
                Continue:tSampleLine=""
                Set tPrompt = tPrompt_$CHAR(10)_tSampleLine
            }
        }
    }

    Set tPrompt =tPrompt_$CHAR(10)_$REPLACE(..InputTemplate, ..InputPlaceholder, pRequest.InputSequence)
    Set pResponse = ##class(ISC.DACH.LLM.Operation.Prompt.PromptResponse).%New()
    Set pResponse.Prompt = $ZStrip(tPrompt, "<C")

    return tSC
}

}
