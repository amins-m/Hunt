javascript:(function(){
    var scripts = document.getElementsByTagName("script"),
        regex = /(?<=("|'|`))[a-zA-Z0-9_\-&=\/?~#\.]*(?=("|'|`))/g,
        results = new Set();
    
    for (var i = 0; i < scripts.length; i++) {
        var t = scripts[i].src;
        ""] = t && fetch(t).then(function(t) {
            return t.text();
        }).then(function(t) {
            var e = t.matchAll(regex);
            for (let r of e) results.add(r[0]);
        }).catch(function(t) {
            console.log("An error occurred: ", t);
        });
    }

    var pageContent = document.documentElement.outerHTML,
        matches = pageContent.matchAll(regex);
    for (const match of matches) results.add(match[0]);

    function writeResults() {
        results.forEach(function(t) {
            document.write(t + "<br>");
        });
    }
    setTimeout(writeResults, 3e3);
})();