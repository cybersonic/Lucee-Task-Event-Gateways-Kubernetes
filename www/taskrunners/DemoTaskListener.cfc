component extends="org.lucee.cfml.Listener" {

    property name="allow" type="string" default="*";
    property name="deny" type="string" default="";


    function init() {
        systemOutput('----- Starting the Reporter -----', 1, 1);
    }

    public void function onError(
        struct error,
        component instance,
        string task,
        required string id,
        required numeric iterations,
        required numeric errors,
        numeric lastExecutionTime,
        date lastExecutionDate,
        struct lastError
    ) {
        systemOutput('----- MyListener.onError -----', 1, 1);
        systemOutput(error.message, 1, 1);

        var cache_key = arguments.task & '_' & arguments.id;
        cacheDelete(id: cache_key, cache: 'redisqueue');
    }

    public void function onExecutionStart(
        component instance,
        string task,
        required string id,
        required numeric iterations,
        required numeric errors,
        numeric lastExecutionTime,
        date lastExecutionDate,
        struct lastError
    ) {
        // systemOutput("----- started #arguments.task# [#arguments.iterations#] -----", true, false);
        var cache_key = arguments.task & '_' & arguments.id;

        cachePut(id: cache_key, value: 'running', cache: 'redisqueue');
    }


    public void function onExecutionEnd(
        component instance,
        string task,
        required string id,
        required numeric iterations,
        required numeric errors,
        numeric lastExecutionTime,
        date lastExecutionDate,
        struct lastError lastError
    ) {
        var cache_key = arguments.task & '_' & arguments.id;
        cacheDelete(id: cache_key, cache: 'redisqueue');
    }

}
