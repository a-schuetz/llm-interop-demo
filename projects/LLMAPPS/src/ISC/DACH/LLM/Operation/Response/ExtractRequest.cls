Class ISC.DACH.LLM.Response.Operation.ExtractRequest Extends Ens.Request
{

/// Model response
Property ModelResponse As %String(MAXLEN = "");

/// Seperator String. Use "\n" as a placeholder for a new line.
Property SeperatorString As %String(MAXLEN = 50) [ InitialExpression = "\n" ];

/// Strip punctuation marks from the end of the answer
Property StripPunctuation As %Boolean [ InitialExpression = 0 ];

/// Convert the output to lower case
Property LowerOutput As %Boolean [ InitialExpression = 0 ];

/// Expected values (use , as seperator
Property ExpectedValues As %String(MAXLEN = "");

Storage Default
{
<Data name="ExtractRequestDefaultData">
<Subscript>"ExtractRequest"</Subscript>
<Value name="1">
<Value>ModelResponse</Value>
</Value>
<Value name="2">
<Value>SeperatorString</Value>
</Value>
<Value name="3">
<Value>StripPunctuation</Value>
</Value>
<Value name="4">
<Value>LowerOutput</Value>
</Value>
<Value name="5">
<Value>ExpectedValues</Value>
</Value>
</Data>
<DefaultData>ExtractRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
