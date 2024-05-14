Class ISC.DACH.LLM.Operation.Prompt.PromptRequest Extends Ens.Request
{

/// Input for the LLM
Property InputSequence As %String(MAXLEN = "");

Storage Default
{
<Data name="PromptRequestDefaultData">
<Subscript>"PromptRequest"</Subscript>
<Value name="1">
<Value>Input</Value>
</Value>
<Value name="2">
<Value>InputSequence</Value>
</Value>
</Data>
<DefaultData>PromptRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
