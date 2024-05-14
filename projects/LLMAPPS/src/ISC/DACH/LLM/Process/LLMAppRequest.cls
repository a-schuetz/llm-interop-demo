Class ISC.DACH.LLM.Process.LLMAppRequest Extends (Ens.Request, %JSON.Adaptor)
{

/// App Reuqested
Property App As %String(MAXLEN = 80);

/// Input for the LLM App
Property InputSequence As %String(%JSONFIELDNAME = "input", MAXLEN = "");

Storage Default
{
<Data name="LLMAppRequestDefaultData">
<Subscript>"LLMAppRequest"</Subscript>
<Value name="1">
<Value>InputSequence</Value>
</Value>
<Value name="2">
<Value>App</Value>
</Value>
</Data>
<DefaultData>LLMAppRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
