Class ISC.DACH.LLM.Response.Operation.ExtractRequest Extends Ens.Request
{

/// Model response
Property ModelResponse As %String(MAXLEN = "");

/// Seperator String
Property SeperatorString As %String(MAXLEN = 50) [ InitialExpression = "\n" ];

/// Expected values (use , as seperator
Property ExpectedValues As %String(MAXLEN = "");

Storage Default
{
<Data name="ExtractRequestDefaultData">
<Subscript>"ExtractRequest"</Subscript>
<Value name="1">
<Value>Modelname</Value>
</Value>
<Value name="2">
<Value>ModelResponse</Value>
</Value>
<Value name="3">
<Value>SeperatorString</Value>
</Value>
<Value name="4">
<Value>UseNewLineSeperator</Value>
</Value>
<Value name="5">
<Value>ExpectedValues</Value>
</Value>
<Value name="6">
<Value>Model</Value>
</Value>
</Data>
<DefaultData>ExtractRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
