Class ISC.DACH.LLM.REST.Dispatcher Extends %CSP.REST
{

Parameter SERVICENAME = "LLM App Service";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/:app" Method="post" Call="AppHandler" Cors="true" />
</Routes>
}

ClassMethod AppHandler(pApp As %String) As %Status
{
	#dim tSC As %Status = $$$OK

	Try {
		Do ##class(%REST.Impl).%SetContentType("application/json")
		If '##class(%REST.Impl).%CheckAccepts("application/json"){
			Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
			Quit
		}
        If '$isobject(%request.Content) {
			Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) 
			Quit
		}

		Set tRequest = ##class(ISC.DACH.LLM.Msg.LLMAppRequest).%New()
		Do tRequest.%JSONImport(%request.Content)
		Set tRequest.App = pApp
		If (tRequest.InputSequence = "") {
			Set tSC = ..ReportHttpStatusCode(..#HTTP400BADREQUEST)
		} Else {
			set tSC  = ##class(Ens.Director).CreateBusinessService(..#SERVICENAME,.tBS)
			do tBS.OnProcessInput(tRequest, .tResponse)

			if $CLASSNAME(tResponse) = "ISC.DACH.LLM.Msg.LLMAppError" {
				Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR(5001, tResponse.ErrorMsg)) 
				Quit
			}
			do tResponse.%JSONExport()
			Set tSc = ..ReportHttpStatusCode(..#HTTP200OK)
	
		}

	} Catch ex{
		Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR, ex.AsStatus(), 1) 
	}
  

	Return tSC
}

}
