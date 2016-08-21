var counter = 1;

function removeAds(){
	console.log('removing ads');
	iframe = window.document.getElementById('canvas_frame');
	if ( iframe != null)
		idoc = window.document.getElementById('canvas_frame').contentDocument;
	else
		idoc = window.document;

	ad = idoc.evaluate('/html/body/div//div[contains(@class,"mq")]',idoc,null,XPathResult.ANY_TYPE,null).iterateNext();
	if(ad == null){
		setTimeout(arguments.callee,counter * 50);
		counter++;
		if (counter > 1000000) 
			counter = 100;
		return;
	}
	else{
		//idoc.documentElement.removeChild(ad);
		ad.parentNode.removeChild(ad);
	}

	idoc.addEventListener("DOMNodeInserted",removeAgain, false)
}

function removeAgain(){
	if(typeof timeoutID == "number") {
		window.clearTimeout(timeoutID);
		timeoutID = null;
	}
	timeoutID = window.setTimeout(removeAds, 700);
}

removeAds();
