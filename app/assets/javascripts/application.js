// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function focuscheckValidation(_this,checkvalue,e) {
	if (!e)
		var e = window.event;
	if(e.type == "focus") {
		if(_this.value == checkvalue)
			_this.value = '';
	} else {
		if(_this.value=='')
			_this.value=checkvalue;
	}
}

function forgotpassword(email){

    if(email==''){
	alert('Please Enter the Email Address');
        document.getElementById('for_email').focus();
        return false;
    }
    if(isValidEmail(email,'for_email')==true){  
        document.getElementById('forgot_submit').disabled= true;
          document.getElementById('spinner').show();
        new Ajax.Updater('forgot', '/users/updatepassWithEmail',
 {
            asynchronous:1,
            evalScripts:true,
            method: 'post',
            parameters: '?email=' + email,
            onFailure: updatepassWithEmailError,
            onSuccess: updatepassWithEmailSuccess
          });
     }
}



function getPopup(type,page,params){
	if(type=='forgotpassword'){

		  new Ajax.Updater('popup', '/users/forgot_password', {
		    asynchronous:1,
		    evalScripts:true,
		    method: 'post',
		    parameters: '?a=1',
		    onFailure: getPopupError,
		    onSuccess: getPopupSuccess
		  });
	}
}

function getPopupError(request)
{
alert('Please Select Role')
}

function getPopupSuccess(request)
{

  var myWidth = 0, myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    myWidth = window.innerWidth;
    myHeight = window.innerHeight;
  } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;
  }
  var iebody=(document.compatMode && document.compatMode != "BackCompat")? document.documentElement : document.body
  var dsocleft=document.all? iebody.scrollLeft : pageXOffset;
  var dsoctop=document.all? iebody.scrollTop : pageYOffset;
  var top=parseInt(myHeight)/2+parseInt(dsoctop)-200;
  var left=parseInt(myWidth)/2+parseInt(dsocleft)+100;

  document.getElementById('light').style.top=top+"px";
  document.getElementById('light').style.left=left+"px";
  document.getElementById('light').style.display='block';
  
  //alert(request.responseText);
  document.getElementById("light").innerHTML=request.responseText
  document.getElementById('fade').style.display='block';
}


function forgotpassword(email) {
	if(email=='') {
		alert('Please Enter the Email Address');
		document.getElementById('for_email').focus();
		return false;
	}
	if(isValidEmail(email,'for_email')==true) {
		document.getElementById('forgot_submit').disabled= true;
		document.getElementById('spinner').show();
		new Ajax.Updater('forgot', '/users/updatepassWithEmail', {
			asynchronous:1,
			evalScripts:true,
			method: 'post',
			parameters: '?email=' + email,
			onFailure: updatepassWithEmailError,
			onSuccess: updatepassWithEmailSuccess
		});
	}
}

function updatepassWithEmailError(request) {
	//Error Message
}

function updatepassWithEmailSuccess(request) {
	alert(request.responseText);
   document.getElementById('spinner').hide();
}
function isValidEmail(emailStr,emailid) {

	if (emailStr=='' || emailStr==undefined) {
		alert("Please enter email address");
		document.getElementById(emailid).focus();
		return false;
	}

	var checkTLD=1;
	var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
	var emailPat=/^(.+)@(.+)$/;
	var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
	var validChars="\[^\\s" + specialChars + "\]";
	var quotedUser="(\"[^\"]*\")";
	var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
	var atom=validChars + '+';
	var word="(" + atom + "|" + quotedUser + ")";
	var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
	var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
	var matchArray=emailStr.match(emailPat);
	if (matchArray==null) {
		//return "Email address seems incorrect (check @ and .'s)";
		alert("Please enter valid email adrress (check @ and .'s)");
		document.getElementById(emailid).focus();
		return false;
	}
	var user=matchArray[1];
	var domain=matchArray[2];
	// Start by checking that only basic ASCII characters are in the strings (0-127).
	for (i=0; i<user.length; i++) {
		if (user.charCodeAt(i)>127) {
			alert("Ths username contains invalid characters.");
			document.getElementById(emailid).focus();
			return false;
		}
	}
	for (i=0; i<domain.length; i++) {
		if (domain.charCodeAt(i)>127) {
			alert("Ths domain name contains invalid characters.");
			document.getElementById(emailid).focus();
			return false;
		}
	}
	if (user.match(userPat)==null) {
		alert("The username doesn't seem to be valid.");
		document.getElementById(emailid).focus();
		return false;
	}
	var IPArray=domain.match(ipDomainPat);
	if (IPArray!=null) {
		for (var i=1;i<=4;i++) {
			if (IPArray[i]>255) {
				alert("Destination IP address is invalid!");
				document.getElementById(emailid).focus();
				return false;
			}
		}
		return true;
	}
	var atomPat=new RegExp("^" + atom + "$");
	var domArr=domain.split(".");
	var len=domArr.length;
	for (i=0;i<len;i++) {
		if (domArr[i].search(atomPat)==-1) {
			alert("The domain name does not seem to be valid.");
			document.getElementById(emailid).focus();
			return false;
		}
	}
	if (checkTLD && domArr[domArr.length-1].length!=2 &&
	domArr[domArr.length-1].search(knownDomsPat)==-1) {
		alert("Please enter valid email address");
		document.getElementById(emailid).focus();
		return false;
	}

	// Make sure there's a host name preceding the domain.

	if (len<2) {
		alert("This address is missing a hostname!");
		document.getElementById(emailid).focus();
		return false;
	}
	return true;
}



function checkemaildata(value) {
	document.getElementById('register_spinner').show();
	new Ajax.Updater('home', '/home/checkemaildata', {
		asynchronous:1,
		evalScripts:true,
		method: 'post',
		parameters: '?email='+value,
		onFailure: checkemaildataError,
		onSuccess: checkemaildataSuccess
	});
}

function checkemaildataError(request) {
	document.getElementById('register_spinner').hide();
}

function checkemaildataSuccess(request) {
	document.getElementById('register_spinner').hide();
	var assign = "";
	if(request.responseText=="not present") {

	} else {
		alert("Email already exist");

		//document.getElementById('user_email').value="";
		document.getElementById('user_email').focus();
		return false;
	}

}

