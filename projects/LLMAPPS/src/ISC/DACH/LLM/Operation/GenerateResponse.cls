Class ISC.DACH.LLM.Operation.GenerateResponse Extends (Ens.Response, , %JSON.Adaptor)
{

Property Model As %String(MAXLEN = 200);

Property Response As %String(MAXLEN = "");

Storage Default
{
<Data name="GenerateResponseDefaultData">
<Subscript>"GenerateResponse"</Subscript>
<Value name="1">
<Value>Model</Value>
</Value>
<Value name="2">
<Value>Response</Value>
</Value>
</Data>
<DefaultData>GenerateResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
