<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Event Gateways</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col">
                <cfoutput>
                <h1>Task Event Gateways <small>(#SERVER.OS.HOSTNAME#)</small></h1>
                </cfoutput>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <table>
                    <tr><td>Items in Queue:</td><td id="txtQueueCount">0</td></tr>
                    <tr><td>Running Tasks:</td><td id="txtTaskCount">0</td></tr>
                </table>

                
                    <div class="row">
                        <div class="col-auto">
                            <input type="numeric" value="1" id="numberOfItems">
                        </div>
                        <div class="col-auto">
                            <button class="btn btn-primary" id="btnAdd">Add Items to the queue</button
                        </div>
                    </div>
                
            </div>
            <div class="row">

            </div>
        </div>

    
    </div>

    
  
   

    
    <script>
        

        document.getElementById("btnAdd").addEventListener("click", function(){
            fetch("api.cfm", {
                method: "POST",
                body: JSON.stringify({
                    "numberOfItems": document.getElementById("numberOfItems").value
                })
            })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                document.getElementById("txtQueueCount").innerHTML = data.size;
            });
        });

        checkItems();
        setInterval(() => {
            checkItems();
        }, 5000 );

        function checkItems(){
            fetch("api.cfm", {
                method: "GET"
            })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                document.getElementById("txtQueueCount").innerHTML = data.size;
                document.getElementById("txtTaskCount").innerHTML = data.runners;
            });
        }

        function getPods(){
            fetch('http://127.0.0.1:50643/api/v1/pods', {
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer " + token
                }
            })
            .then(response => response.json())
            .then(data => {
                // Process the response data
                const pods = data.items;
                pods.forEach(pod => {
                console.log('Pod Name:', pod.metadata.name);
                });
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
