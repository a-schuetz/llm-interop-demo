Class ISC.DACH.LLM.Operation.Prompt.PromptResponse Extends Ens.Response
{

/// Prompt used as model input.
Property Prompt As %String(MAXLEN = "");

Storage Default
{
<Data name="PromptResponseDefaultData">
<Subscript>"PromptResponse"</Subscript>
<Value name="1">
<Value>Prompt</Value>
</Value>
</Data>
<DefaultData>PromptResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
