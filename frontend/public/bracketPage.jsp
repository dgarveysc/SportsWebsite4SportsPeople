<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tournament Bracket</title>
	<link rel="stylesheet" href="bracketPage.css">
</head>
<body>
<%
String playerOne="TBD";
String playerTwo="TBD";
String playerThree="TBD";
String playerFour="TBD";
String playerFive="TBD";
String playerSix="TBD";
String playerSeven="TBD";
String playerEight="TBD";
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
  <div class="item">2
    <div class="item-winner">
      <p><%=finalWinner%></p>
    </div>
    <div class="item-players">
      <div class="item-player">
        <div class="item">
          <div class="item-winner">
            <p><%=roundThreeOne %></p>
          </div>
          <div class="item-players">
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><%=roundTwoOne %></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><%=playerOne %></p>
                  </div>
                  <div class="item-player">
                    <p><%=playerTwo %></p>
                  </div>
                </div>
              </div>
            </div>
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><%=roundTwoTwo %></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><%=playerThree %></p>
                  </div>
                  <div class="item-player">
                    <p><%=playerFour %></p>
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
            <p><%=roundThreeTwo%></p>
          </div>
          <div class="item-players">
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><%=roundTwoThree %></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><%=playerFive %></p>
                  </div>
                  <div class="item-player">
                    <p><%=playerSix %></p>
                  </div>
                </div>
              </div>
            </div>
            <div class="item-player">
              <div class="item">
                <div class="item-winner">
                  <p><%=roundTwoFour %></p>
                </div>
                <div class="item-players">
                  <div class="item-player">
                    <p><%=playerSeven %></p>
                  </div>
                  <div class="item-player">
                    <p><%=playerEight %></p>
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