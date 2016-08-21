noSideBar = function(){
    if ($(".fixable_fixed").length >= 1){
        $(".fixable_fixed")[0].setAttribute("style", "position:absolute !important") // No side bar
    }
    else{
        window.setTimeout(noSideBar, 1000)
    }
}

$(".SiteHeader").css({"position": "absolute"}) //No useless fixed header please
noSideBar()
