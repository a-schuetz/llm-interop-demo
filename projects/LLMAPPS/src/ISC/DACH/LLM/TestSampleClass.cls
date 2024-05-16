Class ISC.DACH.LLM.TestSampleClass Extends (%Persistent, ISC.DACH.LLM.PromptSample)
{

Property Text As %String(MAXLEN = "");

Property Lang As %String(MAXLEN = 50);

ClassMethod Setup()
{
    Do ##class(ISC.DACH.LLM.TestSampleClass).%KillExtent()
    Set sample =  ##class(ISC.DACH.LLM.TestSampleClass).%New()
    Set sample.Text = "Mała dziewczynka z rękami w powietrzu"
    Set sample.Lang = "pl"
    Do sample.%Save()

    Set sample =  ##class(ISC.DACH.LLM.TestSampleClass).%New()
    Set sample.Text = "The product looks just like the"
    Set sample.Lang = "en"
    Do sample.%Save()

    Set sample =  ##class(ISC.DACH.LLM.TestSampleClass).%New()
    Set sample.Text = "Да , я думаю , что=ru"
    Set sample.Lang = "ru"
    Do sample.%Save()

    Set sample =  ##class(ISC.DACH.LLM.TestSampleClass).%New()
    Set sample.Text = "Licha ya ukubwa wake , the"
    Set sample.Lang = "sw"
    Do sample.%Save()

    Set sample =  ##class(ISC.DACH.LLM.TestSampleClass).%New()
    Set sample.Text = "เลก็ ๆนอ้ ยๆนอ้ ยๆ"
    Set sample.Lang = "th"
    Do sample.%Save()

    Set sample =  ##class(ISC.DACH.LLM.TestSampleClass).%New()
    Set sample.Text = "I gazzani lanciano 2 razzi in"
    Set sample.Lang = "it"
    Do sample.%Save()
}

/*
Mała dziewczynka z rękami w powietrzu=pl 
The product looks just like the=en
Да , я думаю , что=ru
Licha ya ukubwa wake , the=sw
เลก็ ๆนอ้ ยๆนอ้ ยๆ=th
I gazzani lanciano 2 razzi in=it
*/
Storage Default
{
<Data name="TestSampleClassDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Text</Value>
</Value>
<Value name="3">
<Value>Label</Value>
</Value>
<Value name="4">
<Value>Language</Value>
</Value>
<Value name="5">
<Value>Lang</Value>
</Value>
</Data>
<DataLocation>^ISC.DACH.LLM.TestSampleClassD</DataLocation>
<DefaultData>TestSampleClassDefaultData</DefaultData>
<ExtentSize>6</ExtentSize>
<IdLocation>^ISC.DACH.LLM.TestSampleClassD</IdLocation>
<IndexLocation>^ISC.DACH.LLM.TestSampleClassI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Lang">
<AverageFieldSize>4</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<Property name="Text">
<AverageFieldSize>41.67</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^ISC.DACH.LLM.TestSampleClassS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
