/// 
Class ISC.DACH.LLM.Process.AppRouter Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="ISC.DACH.LLM.Process.App Router" context="EnsLib.MsgRouter.RoutingEngine" production="ISC.DACH.LLM.SampleProduction">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="Route by App">
<constraint name="source" value=""></constraint>
<constraint name="msgClass" value="ISC.DACH.LLM.Msg.LLMAppRequest"></constraint>
<when condition="(ToLower(Document.App))=&quot;translate&quot;" comment="">
<send transform="" target=",Translate To English"></send>
</when>
<when condition="(ToLower(Document.App))=&quot;sentiment&quot;" comment="">
<send transform="" target=",Sentiment Analysis"></send>
</when>
<when condition="(ToLower(Document.App))=&quot;chat&quot;" comment="">
<send transform="" target=",Chatbot"></send>
</when>
<otherwise>
<send transform="" target=",Unknown App Hanlder"></send>
</otherwise>
</rule>
</ruleSet>
</ruleDefinition>
}

}
