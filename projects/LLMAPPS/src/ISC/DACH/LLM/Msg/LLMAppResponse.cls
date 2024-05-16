Class ISC.DACH.LLM.Msg.LLMAppResponse Extends (Ens.Response, %JSON.Adaptor)
{

/// Model that created the responses
Property Model As %String(%JSONFIELDNAME = "response", MAXLEN = 200);

/// Single app responses
Property AppResponse As %String(%JSONFIELDNAME = "response", MAXLEN = "");

/// Array of additional information
Property AdditionalResponses As array Of %String(%JSONFIELDNAME = "additional_responses", MAXLEN = "");

Storage Default
{
<Data name="AdditionalInfo">
<Attribute>AdditionalInfo</Attribute>
<Structure>subnode</Structure>
<Subscript>"ISC.DACH.LLM.Msg.LLMAppResponse.AdditionalInfo"</Subscript>
</Data>
<Data name="AdditionalInformation">
<Attribute>AdditionalInformation</Attribute>
<Structure>subnode</Structure>
<Subscript>"ISC.DACH.LLM.Msg.LLMAppResponse.AdditionalInformation"</Subscript>
</Data>
<Data name="AdditionalResponses">
<Attribute>AdditionalResponses</Attribute>
<Structure>subnode</Structure>
<Subscript>"ISC.DACH.LLM.Msg.LLMAppResponse.AdditionalResponses"</Subscript>
</Data>
<Data name="AppResponseArray">
<Attribute>AppResponseArray</Attribute>
<Structure>subnode</Structure>
<Subscript>"ISC.DACH.LLM.Msg.LLMAppResponse.AppResponseArray"</Subscript>
</Data>
<Data name="LLMAppResponseDefaultData">
<Subscript>"LLMAppResponse"</Subscript>
<Value name="1">
<Value>AppResponse</Value>
</Value>
<Value name="2">
<Value>Responses</Value>
</Value>
<Value name="3">
<Value>Response</Value>
</Value>
<Value name="4">
<Value>Model</Value>
</Value>
</Data>
<Data name="ResponseArray">
<Attribute>ResponseArray</Attribute>
<Structure>subnode</Structure>
<Subscript>"ISC.DACH.LLM.Msg.LLMAppResponse.ResponseArray"</Subscript>
</Data>
<DefaultData>LLMAppResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
