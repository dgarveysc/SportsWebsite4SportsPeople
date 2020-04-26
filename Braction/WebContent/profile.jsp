<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!Doctype HTML>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="profile.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <title>Braction Home</title>

        <style>
            .profile-header .main-wrapper{
                padding-top: 12%;
                width: 70%;
                margin: auto;
            }

            .mt-2 {
                padding-top: 5%;
                color:rgb(150, 180, 206);
            }

            .radio-text {
                color: rgb(170, 193, 212);
            }

            #join-input {
                width: 40%;
                height: 50%;
                background: hsl(225, 20%, 12%);
            }

            .join-content {
                padding-top: 2%;
                display: flex;
            }
            
            #join-button {
                vertical-align: baseline;
                line-height: 1.1;
                margin-left: 2%;
            }

            #add-button {
                vertical-align: baseline;
                line-height: 1.1;
                margin-left: 5%;
                width: 70%;
            }

            /*.add-friend-content {
                padding-top: 2%;
                display: flex;
            }*/

            #friend-input {
                width: 40%;
                height: 50%;
                background: hsl(225, 20%, 12%);
            }
        </style>

        <script type="text/javascript">
        	/* Start Tab JS */
            $(document).ready(function(){
                $('a[data-toggle="tab"]').on('shown.bs.tab', function(e){
                    var activeTab = $(e.target).text(); // Get the name of active tab
                    var previousTab = $(e.relatedTarget).text(); // Get the name of previous tab
                    $(".active-tab span").html(activeTab);
                    $(".previous-tab span").html(previousTab);
                });
            });
        </script>

    </head>
    <body>
        <header class="profile-header">
                <div class="logo">
                    <a href="homepage.html">
                        <img src="logo.png" alt="logo">
                    </a>
                </div> <!-- end logo -->
                <div class="nav-area">
				<a href="homepage.html">
					<input type="submit" class="button home-button" value="Home">
				</a>
				<a href="createTournament.jsp" >
					<input type="submit" class="button create-button" value="Create Tournament">
				</a>
				<form method="GET" action="brackedIdServlet">
				<!-- User ID -->
					<input type="hidden" name="userID" value="1">
					<a href="profile.jsp">
						<input type="submit" class="button profile-button" value="Profile" id="active">
					</a>
				</form>
				<a href="login-sign-up.jsp">
					<input type="submit" class="button login-button" value="Login/Sign Up">
				</a>
				</div>
            	<!--Tabs-->
                <div class="main-wrapper">
                    <ul id="myTab" class="nav nav-tabs">
                        <li class="nav-item">
                            <a href="#tournaments" class="nav-link active" data-toggle="tab" style="color:rgb(149, 159, 180)">My Tournaments</a>
                        </li>
                        <li class="nav-item">
                            <a href="#friends" class="nav-link" data-toggle="tab" style="color:rgb(149, 159, 180)">Friends List</a>
                        </li>
                        <li class="nav-item">
                            <a href="#stats" class="nav-link" data-toggle="tab" style="color:rgb(149, 159, 180)">Statistics</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="tournaments">
                            <div class="tournament-table">
                                <div class="button-group">
                                    <a href="create.html" class="btn btn-light">Create Tournament</a>
                                </div>
                                <div class="join-content">
                                    <input class="form-control" type="text" id="join-input" placeholder="Enter existing tournament code">
                                    <button type="button" class="btn btn-light" id="join-button">Join</button>
                                </div>
                                <div class="table-content">
                                    <h4 class="mt-2">Active Tournaments</h4>
                                    <form action="" method="post" name="activeform">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th class="table-heading">Tournament</th>
                                            <th class="table-heading">Host</th>
                                            <th class="table-heading" colspan="2">Action</th>
                                            <th class="table-heading" colspan="2">Choose Winner</th>
                                            <th class="table-heading"></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                                int numGames = (int)request.getAttribute("numGames");
                                                for(int i = 0; i < numGames; i++)
                                                {
                                                    String bracketId = (String)request.getAttribute("gameName" + i);

                                                    if(bracketId == null) {
                                                        bracketId = "Bracket ";
                                                    }
                                            %>
                                        <tr>
                                                <td class="item-text"><%= bracketId %></td>
                                                <td class="item-text">user1234</td>
                                                <td><a href="#" class="edit">Edit</a></td>
                                                <td><a href="#" class="delete">Delete</a></td>
                                                <td>
                                                    <input type="radio" id="player1" name="choose-winner" value="player1">
                                                    <label for="player1" class="radio-text">Player 1</label></td>
                                                <td>
                                                    <input type="radio" id="player2" name="choose-winner" value="player2">
                                                    <label for="player2" class="radio-text">Player 2</label></td>
                                                <td><button type="button" class="btn btn-light">Update</button></td>
                                        </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    </form>
                                </div>
                                <h4 class="mt-2">Pending Tournaments</h4>
                                <form action="" method="post" name="pendingform">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th class="table-heading">Tournament</th>
                                            <th class="table-heading">Host</th>
                                            <th class="table-heading" colspan="2">Action</th>
                                            <th class="table-heading">Vacant Spots</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="item-text">Tournament2</td>
                                                <td class="item-text">user1234</td>
                                                <td><a href="#" class="edit">Edit</a></td>
                                                <td><a href="#" class="delete">Delete</a></td>
                                                <td class="item-text">5</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                                <h4 class="mt-2">Finished Tournaments</h4>
                                <form action="" method="post" name="finishedform">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th class="table-heading">Tournament</th>
                                            <th class="table-heading">Host</th>
                                            <th class="table-heading" colspan="2">Action</th>
                                            <th class="table-heading">Vacant Spots</th>
                                         </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="item-text">Tournament2</td>
                                                <td class="item-text">user1234</td>
                                                <td><a href="#" class="edit">Edit</a></td>
                                                <td><a href="#" class="delete">Delete</a></td>
                                                <td class="item-text">5</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="friends">
                            <div class="friends-table">
                            <!-- start form for adding friend -->
                                <div class="add-friend-content">
									<form method="post" action="AddFriendServlet" class="add-form">
										<input class="form-control" type="text" name="friend-input" placeholder="Enter username">
								    	<button type="button" class="btn btn-light" id="add-button">Add Friend</button>
									</form>          
								</div>
                                <!-- End form for adding friend -->
                                <div class="table-content">
                                    <h4 class="mt-2">Friends</h4>
                                    <!--Editable Table-->
                                    <form action="" method="post" name="friends-list-form">
                                        <table>
                                            <thead>
                                            <tr>
                                                <th class="table-heading">Username</th>
                                                <th class="table-heading">Action</th>
                                                <th class="table-heading">Ranking</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td class="item-text" id="friend-username">csci201</td>
                                                    <td><a href="#" class="delete" id="delete-friend">Delete</a></td>
                                                    <td class="item-text">1234</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- Start of Friend Requests-->
                                    <h4 class="mt-2">Friend Requests</h4>
                                    <!--Editable Table-->
                                    <form action="" method="post" name="friend-requests-form">
                                        <table>
                                            <thead>
                                            <tr>
                                                <th class="table-heading" id="friend-username">Username</th>
                                                <th class="table-heading" colspan="2">Action</th>
                                                <th class="table-heading">ELO</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td class="item-text" id="friend-username">csci201</td>
                                                    <td><a href="#" class="edit" id="accept-request">Accept</a></td>
                                                    <td><a href="#" class="delete" id="reject-request">Reject</a></td>
                                                    <td class="item-text">1234</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- End of Friend Requests-->
                                    <!-- Start of Pending Requests-->
                                    <h4 class="mt-2">Pending Requests</h4>
                                    <!--Editable Table-->
                                    <form action="" method="post" name="pending-requests-form">
                                        <table>
                                            <thead>
                                            <tr>
                                                <th class="table-heading">Username</th>
                                                <th class="table-heading">Action</th>
                                                <th class="table-heading"></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td class="item-text" id="friend-username">csci201</td>
                                                    <td><a href="#" class="delete" id="cancel-requst">Cancel Request</a></td>
                                                    <td class="item-text">Pending</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </form>
                                    <!-- End of Pending Requests-->
                                </div>
                            </div> <!-- End Friends Table -->
                        </div> <!--End Friends Tab-->
                        <div class="tab-pane fade" id="stats">
                            <div class="stats-table">
                                <h4 class="mt-2">Stats</h4>
                                <p class="stat-heading"><strong>ELO: </strong></p>
                                <p id="curElo" class="stat">123</p>
                                <!-- Start Images Row -->
	                                <div class="row" id="graph-row" align="center">
										<div class="col-4">
											<p class="graph-heading"><strong>Past 5 Games:</strong></p>
											<img src="graph.png" alt="Graph of last 5 games" class="graph">
										</div>
										<div class="col-4">
											<p class="graph-heading"><strong>Past 20 Games:</strong></p>
											<img src="graph.png" alt="Graph of last 20 games" class="graph">
										</div>
										<div class="col-4">
											<p class="graph-heading"><strong>All Games:</strong></p>
											<img src="graph.png" alt="Graph of all user games" class="graph">
										</div>
									</div>
								<!-- End Images Row -->
								<!-- Start Other Stats Row -->
									<div class="row" id="other-stats-row" align="center">
										<div class="col-4" id="winCol">
											<p class="stat-heading"><strong>Win Opponent Rank: </strong></p><br/>
                                			<p id="medWinOppRank" class="stat">Median: 12</p><br/>
                                			<p id="winOppRank25" class="stat">25th Percentile: 12</p><br/>
                                			<p id="winOppRank75" class="stat">75th Percentile: 12</p><br/> 			
										</div>
										<!-- Start Pie Chart -->
										<div class="col-4" id="pieChartCol">
											<div id="piechart"></div>
												<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
												<script type="text/javascript">
													// Load google charts
													google.charts.load('current', {'packages':['corechart']});
													google.charts.setOnLoadCallback(drawChart);
													
													// Draw the chart and set the chart values
													function drawChart() {
													  var data = google.visualization.arrayToDataTable([
													  ['Total', 'Percentage'],
													  ['Wins', 6], // win value
													  ['Losses', 2] // loss value
													]);
													
													  // Optional; add a title and set the width and height of the chart
													  var options = {'title':'% Wins', 'width':150, 'height':200, 
															  legend:
															  {
																  position: 'none', 
																  textStyle: {color: 'white', fontSize: 10}},
															  titleTextStyle: 
															  { 
																  color: '#ffffff',
																  fontSize: 14,
																  bold: true 
															  },
															  colors: ['#db0052', 'fe7c86'], backgroundColor: { fill:'transparent' }};
													 
													  // Display the chart inside the <div> element with id="piechart"
													  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
													  chart.draw(data, options);
													}
												</script>
										</div>
										<!-- End Pie Chart -->
										<div class="col-4" id="lossCol">
											<p class="stat-heading"><strong>Loss Opponent Rank: </strong></p><br/>
                                			<p id="medLossOppRank" class="stat">Median: 12</p><br/>
                                			<p id="lossOppRank25" class="stat">25th Percentile: 12</p><br/>
                                			<p id="lossOppRank75" class="stat">75th Percentile: 12</p><br/>
										</div>
									</div>
									<!-- End Other Stats Row -->
									<!-- Start Totals Stats Row-->
									<div class="row" id="totals-row" align="center">
										<div class="col-4" id="totalWinsCol">
											<p class="stat-heading"><strong>Total Wins: </strong></p>
                        					<p id="numWins" class="stat">12</p><br/>
										</div>
										<div class="col-4" id="totalLossCol">
											<p class="stat-heading"><strong>Total Losses: </strong></p>
                        					<p id="numLoss" class="stat">12</p><br/>
										</div>
										<div class="col-4" id="totalGamesCol">
											<p class="stat-heading"><strong>Total Games: </strong></p>
                        					<p id="numWins" class="stat">1234</p><br/>
										</div>
										
									</div>
									<!-- End Totals Stats Row -->
									<!-- Start Random Stats Row -->
									<div class="row" id="random-stats-row" align="center">
										<div class="col-4" id="avgRoundCol">
											<p class="stat-heading"><strong>Average Round: </strong></p>
                        					<p id="avgRound" class="stat">12</p><br/>
										</div>
										<div class="col-4" id="numEarnedCol">
											<p class="stat-heading"><strong>Earned: </strong></p>
                        					<p id="numEarned" class="stat">12</p><br/>
										</div>
										<div class="col-4" id="extra">
										</div>
									</div>
									<!--  End Random Stats Row -->
									
									
									<%
									
									/*<div class="col-6" id="totalCol">
									<p class="stat-heading"><strong>Total Wins: </strong></p>
                        			<p id="numWins" class="stat">12</p><br/>
                        			<p class="stat-heading"><strong>Total Losses: </strong></p>
                        			<p id="numLoss" class="stat">12</p><br/>
                        			<p class="stat-heading"><strong>Total Games: </strong></p>
                        			<p id="numWins" class="stat">1234</p><br/>
                        			<p class="stat-heading"><strong>Average Round: </strong></p>
                        			<p id="avgRound" class="stat">12</p><br/>
								</div>*/
									
									%>
                                <form action="" method="post" name="activeform">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th class="table-heading">Tournament</th>
                                            <th class="table-heading">Host</th>
                                            <th class="table-heading" colspan="2">Action</th>
                                            <th class="table-heading">Input Scores</th>
                                         </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="item-text">Tournament1</td>
                                                <td class="item-text">user1234</td>
                                                <td><a href="#" class="edit">Edit</a></td>
                                                <td><a href="#" class="delete">Delete</a></td>
                                                <td><input type="text" name="input-score" size="5"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                        </div>
                    </div> <!--tab content div-->
                    <hr>
                </div> <!--Main Wrapper-->                   
              <!--End Tabs-->          
        </header>
    </body>
</html>