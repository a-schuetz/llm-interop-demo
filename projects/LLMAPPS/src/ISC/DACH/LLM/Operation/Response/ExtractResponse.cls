Class ISC.DACH.LLM.Operation.Response.ExtractResponse Extends Ens.Response
{

Property ExtractedResponse As %String(MAXLEN = "");

Property Valid As %Boolean;

Storage Default
{
<Data name="ExtractResponseDefaultData">
<Subscript>"ExtractResponse"</Subscript>
<Value name="1">
<Value>ExtractedResponse</Value>
</Value>
<Value name="2">
<Value>Modelname</Value>
</Value>
<Value name="3">
<Value>ValidOutcome</Value>
</Value>
<Value name="4">
<Value>Model</Value>
</Value>
<Value name="5">
<Value>Valid</Value>
</Value>
</Data>
<DefaultData>ExtractResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
