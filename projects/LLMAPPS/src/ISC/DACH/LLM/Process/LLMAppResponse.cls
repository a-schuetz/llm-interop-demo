Class ISC.DACH.LLM.Process.LLMAppResponse Extends (Ens.Response, %JSON.Adaptor)
{

/// App response
Property AppResponse As %String(MAXLEN = "");

Storage Default
{
<Data name="LLMAppResponseDefaultData">
<Subscript>"LLMAppResponse"</Subscript>
<Value name="1">
<Value>AppResponse</Value>
</Value>
</Data>
<DefaultData>LLMAppResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
