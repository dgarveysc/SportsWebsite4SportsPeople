function logout(){
    $.ajax({
                url: 'Logout',
                data: {
                    toUrl: "/index.jsp"
                },
                //Making the tournament ID code show up on screen
                success: function (result) {

                }

            });
            location.reload();
            return false;
}

function valLogin() {
    var good = true;
    good = !checkEmpty("lsiu", "Username");
    good = (!checkEmpty("lsip", "Password") && good);
    return good;
}

function valNewAcct() {
    
    var e = !checkEmpty("nsie", "Email");
    var u = !checkEmpty("nsiu", "Username");
    var p = !checkEmpty("nsip", "Password");
    var pp = !checkEmpty("nsipp", "Password");
    var same = true;
    if(p){
        same = samePasswords("nsip");
    }
    var t = checkedTerms("natAndc");

    return (e && u && p && pp && same && t);
}

function samePasswords(id){
    var p1 = document.getElementById(id).value;
    var p2 = document.getElementById(id +"p").value;
    if((p1 != p2) || (p2 == "")){
        document.getElementById(id+"pe").innerHTML += 
        "<font color=\"red\">Your passwords must match! </font><br />";
        return false;
    }
    return true;
}


function checkedTerms(id){
    var isChecked = document.getElementById(id).checked;
    if(isChecked == false){
        document.getElementById(id+"e").innerHTML = "<font color=\"red\">You MUST accept our terms and conditions before joining! </font>";
    }
    return isChecked;
}

function checkEmpty(toCheck, name) {
    var isEmpty = false;
    if (document.getElementById(toCheck).value.length == 0) {
        document.getElementById(toCheck + "e").innerHTML = "<font color=\"red\">" + name + " needs a value! </font><br />";
        isEmpty = true;
    }
    return isEmpty;
}

function valNT(){
    var g = !checkEmpty("gameType", "Your game of choice");
    var t = !checkEmpty("tName", "Your tournament name");
    return (g && t);
}

function valTCode(){
    var c = !checkEmpty("tCOde", "Tournament code");
    var t = checkedTerms("nttAndc");
    return (c && t);
}

function removeError(id) {
    if(id == "lsiu" || id == "nsie"){
        document.getElementById("loginTaken").innerHTML = "<div> </div>";
        document.getElementById("badLogin").innerHTML = "<div> </div>";
    }
    var name = id + "e";
    document.getElementById(name).innerHTML = "";
}