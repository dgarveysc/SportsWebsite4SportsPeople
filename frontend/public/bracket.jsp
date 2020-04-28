<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tournament bracket!</title>
	<link rel="stylesheet" href="bracket.css">
	<script>
	function change(curr, next){
		//IF NEXT VALUE IS "TBD" REPLACE WITH VALUE OF CURR
		var c = document.getElementById(curr);//current
		var n = document.getElementById(next);//next
		if(n.value=="TBD") n.value=c.value;
	}
	
	function submitWinner(){
		
	}
	
	</script>
</head>
<body>
<%
String playerOne="A";
String playerTwo="B";
String playerThree="C";
String playerFour="D";
String playerFive="E";
String playerSix="F";
String playerSeven="G";
String playerEight="H";
String roundTwoOne="TBD";//first winner of round two
String roundTwoTwo="TBD";
String roundTwoThree="TBD";
String roundTwoFour="TBD";
String roundThreeOne="TBD";//first winner of round three
String roundThreeTwo="TBD";
String finalWinner="TBD";//final winner
//UPDATE THESE VARIABLES

%>
<div class="wrapper">
  <div class="item">
    <div class="item-winner">
      <p>
      <input onclick="submitWinner()" type="button" value=<%=finalWinner%> id="r4p1">
      </p>
    </div>
    <div class="item-players">
      <div class="item-player">
        <div class="item">
          <div class="item-winner">
            <p><input onclick="change('r3p1','r4p1')" type="button" value=<%=roundThreeOne%> id="r3p1"></p>
          </div>
          <div class="item-players">
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><input onclick="change('r2p1','r3p1')" type="button" value=<%=roundTwoOne%> id="r2p1"></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><input onclick="change('r1p1','r2p1')" type="button" value=<%=playerOne%> id="r1p1"></p>
                  </div>
                  <div class="item-player">
                    <p><input onclick="change('r1p2','r2p1')" type="button" value=<%=playerTwo%> id="r1p2"></p>
                  </div>
                </div>
              </div>
            </div>
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><input onclick="change('r2p2','r3p1')" type="button" value=<%=roundTwoTwo%> id="r2p2"></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><input onclick="change('r1p3','r2p2')" type="button" value=<%=playerThree%> id="r1p3"></p>
                  </div>
                  <div class="item-player">
                    <p><input onclick="change('r1p4','r2p2')" type="button" value=<%=playerFour%> id="r1p4"></p>
                  </div>
                </div>
              </div>
            </div> 	
          </div>
        </div>
      </div>
      
      <div class="item-player">
        <div class="item">
          <div class="item-winner">
            <p><input onclick="change('r3p2','r4p1')" type="button" value=<%=roundThreeTwo%> id="r3p2"></p>
          </div>
          <div class="item-players">
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><input onclick="change('r2p3','r3p2')" type="button" value=<%=roundTwoThree%> id="r2p3"></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><input onclick="change('r1p5','r2p3')" type="button" value=<%=playerFive%> id="r1p5"></p>
                  </div>
                  <div class="item-player">
                    <p><input onclick="change('r1p6','r2p3')" type="button" value=<%=playerSix%> id="r1p6"></p>
                  </div>
                </div>
              </div>
            </div>
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><input onclick="change('r2p4','r3p2')" type="button" value=<%=roundTwoFour%> id="r2p4"></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><input onclick="change('r1p7','r2p4')" type="button" value=<%=playerSeven%> id="r1p7"></p>
                  </div>
                  <div class="item-player">
                    <p><input onclick="change('r1p8','r2p4')" type="button" value=<%=playerEight%> id="r1p8"></p>
                  </div>
                </div>
              </div>
            </div> 	
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>