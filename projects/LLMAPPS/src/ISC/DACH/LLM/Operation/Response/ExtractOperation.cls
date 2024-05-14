Class ISC.DACH.LLM.Response.Operation.ExtractOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
  <MapItem MessageType="ISC.DACH.LLM.Response.Operation.ExtractRequest">
    <Method>OnExtractRequest</Method>
  </MapItem>
</MapItems>
}

Method OnExtractRequest(pRequest As ISC.DACH.LLM.Response.Operation.ExtractRequest, Output pResponse As ISC.DACH.LLM.Response.Operation.ExtractResponse) As %Status
{
    #dim tSC As %Status = $$$OK
    Set pResponse = ##class(ISC.DACH.LLM.Response.Operation.ExtractResponse).%New()

    if (pRequest.SeperatorString = "\n") {
        Set tSeperator = $CHAR(10)
    } Else {
        Set tSeperator = pRequest.SeperatorString
    }

    Set tResponse = $ZSTRIP($PIECE(pRequest.ModelResponse, tSeperator, 1, 1), "<>W")
    Set pResponse.ExtractedResponse = tResponse


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
