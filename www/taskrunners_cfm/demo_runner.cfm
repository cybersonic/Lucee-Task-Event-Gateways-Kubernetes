<!---
@task "Example CFM runner"
@description "This CFML Dummy Task is just to show the functionality"
@concurrentThreadCount 1
@howLongToSleepBeforeTheCall 10000
@howLongToSleepAfterTheCall 10000
@howLongToSleepAfterTheCallWhenError 10000
@howLongToWaitForTaskOnStop 10000
@forceStop true
--->
<!--- Task variables in the url --->
<cfparam name="url.errors" default="">
<cfparam name="url.lastError" default="">
<cfparam name="url.lastExecutionTime" default="">
<cfparam name="url.lastExecutionDate" default="">
<cfparam name="url.id" default="">
<cfparam name="url.iterations" default="">


<cfscript>
    // systemOutput("----------", true, false);
    // systemOutput("----- CFML Task Runner [#url.iterations#] -----", true, false);
    // systemOutput(" - errors : #url.errors#", true, false);
    // systemOutput(" - lastError : #url.lastError#", true, false);
    // systemOutput(" - lastExecutionTime : #url.lastExecutionTime#", true, false);
    // systemOutput(" - lastExecutionDate : #url.lastExecutionDate#", true, false);
    // systemOutput(" - id : #url.id#", true, false);
    // systemOutput(" - iterations : #url.iterations#", true, false);
    // systemOutput("----------", true, false);
</cfscript>