component extends="org.lucee.cfml.Task" {

    property name="concurrentThreadCount" type="numeric" default=1;
    property name="howLongToSleepBeforeTheCall" type="numeric" default=1000;
    property name="howLongToSleepAfterTheCall" type="numeric" default=2000;
    property name="howLongToSleepAfterTheCallWhenError" type="numeric" default=5000;
    property name="howLongToWaitForTaskOnStop" type="numeric" default=10000;
    property name="forceStop" type="boolean" default=true;


    function init() {
        systemOutput('----- Started the task runner -----', true, true);
    }

    public void function invoke(
        required string id,
        required numeric iterations,
        required numeric errors,
        numeric lastExecutionTime,
        date lastExecutionDate,
        struct lastError = {}
    ) {
        // systemOutput("----- DEMO Task Runner [#arguments.iterations#] -----", true, false);

        if (!isEmpty(lastError)) {
            systemOutput('Last Error: #lastError.message#', true, true);
        }


        result = redisCommand(arguments: [['LPOP', 'queue']], cacheName: 'redisqueue');
        results = result.filter((e) => {
            return !isNull(e);
        });


        var items = results;

        if (items.len()) {
            for (var item in items) {
                
                systemOutput('Starting the work [#arguments.iterations#]', true, true);
                var result = '';
                // Now run the script so that it produces high load
                try {
                    cfexecute(name = 'bash', arguments = '-c /var/www/taskrunners/high_cpu.sh', variable = 'result');
                    // systemOutput("Result: #result#", true, true);
                } catch (any e) {
                    systemOutput('Error: #e.message#', true, true);
                }

                systemOutput('Finished doing the work! [#arguments.iterations#]', true, true);
            }
        }
    }

}
