Class ISC.DACH.LLM.Msg.LLMAppError Extends ISC.DACH.LLM.Msg.LLMAppResponse
{

Property ErrorMsg As %String(MAXLEN = 400);

Storage Default
{
<Data name="LLMAppErrorDefaultData">
<Subscript>"LLMAppError"</Subscript>
<Value name="1">
<Value>ErrorMsg</Value>
</Value>
</Data>
<DefaultData>LLMAppErrorDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
