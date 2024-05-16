/// 
Class ISC.DACH.LLM.Process.UnknownAppHandler Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='ISC.DACH.LLM.Msg.LLMAppRequest' response='ISC.DACH.LLM.Msg.LLMAppError' height='2000' width='2000' >
<sequence xend='200' yend='350' >
<assign name="Set response to error" property="response.ErrorMsg" value="&quot;LLM app '&quot;_request.App_&quot;' not found.&quot;" action="set" languageOverride="" xpos='200' ypos='250' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
