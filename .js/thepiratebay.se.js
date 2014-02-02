
function removeAds(){
	console.log('removing ads');

	document.getElementById('sky-right').style.display = 'none';
	var searchRes = document.getElementById('SearchResults');
	if(searchRes != null){
	   document.getElementById('main-content').children[0].style.display = 'none';
	}
	document.getElementById('sky-banner').children[0].style.display = 'none';
	document.getElementById('foot').children[0].style.display = 'none';
	document.getElementById('header').children[0].style.display = 'none';
	


/*
 * 
 * 	iframe = window.document.getElementById('adsfrm');
 * 	if ( iframe != null)
 * 		idoc = window.document.getElementById('canvas_frame').contentDocument;
 * 	else
 * 		idoc = window.document;
 * 
 * 	ad = idoc.evaluate('/html/body/div//div[contains(@class,"mq")]',idoc,null,XPathResult.ANY_TYPE,null).iterateNext();
 * 	if(ad == null){
 * 		setTimeout(arguments.callee,counter * 50);
 * 		counter++;
 * 		if (counter > 1000000) 
 * 			counter = 100;
 * 		return;
 * 	}
 * 	else{
 * 		//idoc.documentElement.removeChild(ad);
 * 		ad.parentNode.removeChild(ad);
 * 	}
 */

	document.addEventListener("DOMNodeInserted",removeAds, false)
}


removeAds()
