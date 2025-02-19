javascript:(function(){
    var scripts = document.getElementsByTagName("script"),
        regex = /(?<=("|'))[a-zA-Z0-9_\-&=?\/#\.]*(?=("|'|\)))/g,
        results = new Set();
    
    for (var i = 0; i < scripts.length; i++) {
        var t = scripts[i].src;
        if (t) {
            fetch(t).then(function(response) {
                return response.text();
            }).then(function(text) {
                var matches = text.matchAll(regex);
                for (let match of matches) results.add(match[0]);
            }).catch(function(error) {
                console.log("An error occurred: ", error);
            });
        }
    }

    var pageContent = document.documentElement.outerHTML,
        matches = pageContent.matchAll(regex);
    for (const match of matches) results.add(match[0]);

    function writeResults() {
        results.forEach(function(result) {
            document.write(result + "<br>");
        });
    }
    setTimeout(writeResults, 3000);
})();
