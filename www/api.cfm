<cfscript>

    
        
        


    ret = {
        "size":0,
        "runners":0,
        "messages" : []
    }
    if(CGI.REQUEST_METHOD EQ "POST"){
        body = getHttpRequestData().content;
        body = deserializeJSON(body);
        ret.body = body;
        param name="body.numberOfItems" default="1" type="numeric";
        for (i = 1; i <= body.numberOfItems; i++){
            id = CreateUUID();
            ret.messages.append("Adding [#id#] to queue [#i#/#body.numberOfItems#]");
            redisCommand(
                arguments: [ "RPUSH", "queue", id ], 
                cacheName: "redisqueue"
            );
        }
    }

    

    size = redisCommand(
        arguments: [ "LLEN", "queue" ], 
        cacheName: "redisqueue"
    );
    
    ret["size"] = size;
    ret["runners"] =  cacheGetAllIds(filter:"taskrunners.*", cacheName:"redisqueue").len();
    
    
    
    
    header name="content-type" value="application/json";
    echo(serializeJSON(ret));
</cfscript>