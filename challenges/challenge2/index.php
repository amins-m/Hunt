<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Encoding Examples</title>
</head>
<body>
    <h2>Send Data</h2>
    <form action="index.php" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name">
        <button type="submit">Send (urlencoded)</button>
    </form>
    
    <form action="index.php" method="post" enctype="multipart/form-data">
        <label for="name.multipart">Name:</label>
        <input type="text" id="name.multipart" name="name">
        <button type="submit">Send (multipart)</button>
    </form>
    
    <h2>Send JSON Data (JavaScript)</h2>
    <label for="name.json">Name:</label>
    <input type="text" id="name.json">
    <button onclick="sendJSON()">Send (JSON)</button>

    <div id="responseMessage"></div>

    <script>
        function sendJSON() {
            var name = document.getElementById('name.json').value;
            var data = { 'name': name };

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "index.php", true);
            xhr.setRequestHeader("Content-Type", "application/json");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText);
                        document.getElementById('responseMessage').innerText = response.message || "No message received.";
                    } catch (error) {
                        document.getElementById('responseMessage').innerText = "Error parsing response.";
                    }
                }
            };
            xhr.send(JSON.stringify(data));
        }

        // Function to parse URL parameters
        function getParameterByName(name, url = window.location.href) {
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)");
            var results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        // Redirect if 'redirect' parameter exists and is safe
        var redirectParam = getParameterByName('redirect');
        if (redirectParam && !redirectParam.startsWith("javascript:") && /^https?:\/\//.test(redirectParam)) {
            window.location = redirectParam;
        }

        // Message event listener
        window.addEventListener("message", function (e) {
            if (e.origin && e.data) {
                try {
                    var t = JSON.parse(e.data);
                    if (t && typeof t === "object" && t.goto) {
                        window.location = t.goto;
                    }
                } catch (error) {
                    console.error("Invalid message data", error);
                }
            }
        });
    </script>
</body>
</html>
