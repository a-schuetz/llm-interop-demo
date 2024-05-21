Class ISC.DACH.LLM.Operation.Response.ExtractOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="ISC.DACH.LLM.Operation.Response.ExtractRequest">
    <Method>OnExtractRequest</Method>
  </MapItem>
</MapItems>
}

Method OnExtractRequest(pRequest As ISC.DACH.LLM.Operation.Response.ExtractRequest, Output pResponse As ISC.DACH.LLM.Operation.Response.ExtractResponse) As %Status
{
    #dim tSC As %Status = $$$OK
    Set pResponse = ##class(ISC.DACH.LLM.Operation.Response.ExtractResponse).%New()
    Set tSeperator = $REPLACE(pRequest.SeperatorString, "\n", $CHAR(10))
    Set tResponse = $ZSTRIP($PIECE(pRequest.ModelResponse, tSeperator, 1, 1), "<>W")

    if (pRequest.StripPunctuation) {
      Set tResponse = $ZSTRIP(tResponse, ">P")
    }
    if (pRequest.LowerOutput) {
      Set tResponse = $ZCONVERT(tResponse,"L")
    }

    Set pResponse.ExtractedResponse = tResponse

    // Validate response
    if (pRequest.ExpectedValues '= "") {
        Set tValid = 0

        For i=1:1:$LENGTH(pRequest.ExpectedValues, ",") {
            Set tValidValue=$ZSTRIP($PIECE(pRequest.ExpectedValues,",",i),"<>W")
            Continue:""=tValidValue
            if (tResponse = tValidValue) {
                Set tValid = 1
                Quit
            }
        }

        Set pResponse.Valid = tValid
   }

   return tSC
}

}
