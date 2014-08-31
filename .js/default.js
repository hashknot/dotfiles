console.log("Dotjs is working");

addCSSRule = function(rules){
    var sheet = (function() {
        var styleTag = document.createElement("style");
        var head = document.getElementsByTagName("head")[0];
        head.appendChild(styleTag);

        return styleTag.sheet ? styleTag.sheet : styleTag.styleSheet;
    })();

    sheet.insertRule(rules, 0)
}
