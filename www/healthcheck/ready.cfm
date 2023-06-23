<cfscript>
    param name="SERVER.RUNNERREADY" default="false";

    if(!SERVER.RUNNERREADY){
        throw("Server not ready");
    }
    echo ("Server is ready");

</cfscript>