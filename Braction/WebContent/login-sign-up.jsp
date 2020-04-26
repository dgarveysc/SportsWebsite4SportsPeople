<%@ page language="Java" %>
<!DOCTYPE html>
<html>

<head>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Login/Sign-Up</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="sty.css">
    <script>
        function authenticateUser() {
            var v = valLogin();
            if (v == false) {
                return false;
            }
            // Using jQuery 
            $.ajax({
                url: 'Login',
                data: {
                    uname: document.localSI.Username.value,
                    pword: document.localSI.Password.value
                },
                //Making the tournament ID code show up on screen
                success: function (result) {
                    $("#lsipe").html(result);
                }

            });
            return false;
        }

        function createNewUser() {
            var v = valNewAcct();
            if (v == false) {
                return false;
            }
            // Using jQuery 
            $.ajax({
                url: 'NewAccount',
                data: {
                    email: document.localSU.email.value,
                    uname: document.localSU.username.value,
                    pword: document.localSU.password.value
                },
                //Making the tournament ID code show up on screen
                success: function (result) {
                    $("#nisee").html(result);
                }

            });
            return false;

        }


    </script>
</head>

<body>
    <% 
        String error = request.getParameter("loginError");
        if(error == null){
            error = "";
        }
        String emailTaken = request.getParameter("signUpError");
        if(emailTaken == null){
            emailTaken = "";
        }
    %>
    <div class="container">
        <div class="row">


            <div class="col">

                <div class="logo">
                    <a href="homepage.html">
                        <img src="logo.png" alt="logo">
                    </a>
                </div>
            </div>
            <div class="col">

                <div class="nav-area">
                    <a href="homepage.html">
                        <input type="submit" class="button home-button" value="Home" id="active">
                    </a>
                    <a href="createTournament.html">
                        <input type="submit" class="button create-button" value="Create Tournament">
                    </a>
                    <form method="GET" action="brackedIdServlet">
                        <!-- User ID -->
                        <input type="hidden" name="userID" value="1">
                        <a href="profile.jsp">
                            <input type="submit" class="button profile-button" value="Profile">
                        </a>
                    </form>
                    <a href="login-sign-up.jsp">
                        <input type="submit" class="button login-button" value="Login/Sign Up">
                    </a>
                </div>
            </div>
        </div>


        <hr width="100%" style="padding-bottom: 5%">
        <div class="row main">
            <div class="col text">
                <form onsubmit="return authenticateUser()" class="login" action="" method="POST" name="localSI">
                    <h1 class="header">
                        Login to existing account...
                    </h1>
                    <hr class="break">
                    <div class="loginError">
                        <%= error %>
                    </div>
                    <p class="item-text">
                        Username
                    </p>
                    <input onfocus="removeError(this.id)" class="text-inpt" type="text" id="lsiu" name="Username">
                    <div class="error" id="lsiue"></div>
                    <p class="item-text">
                        Password
                    </p>
                    <input onfocus="removeError(this.id)" class="text-inpt" type="password" id="lsip" name="Password">
                    <div class="error" id="lsipe"></div><br>
                    <input class="sub" type="submit" value="Sign In">
                </form>

            </div>
            <div class="col text">
                <form onsubmit="return createNewUser()" class="login" action="" method="POST" name="localSU">
                    <h1 class="header">
                        Sign up for a new account!
                    </h1>
                    <hr class="break" width="100%">
                    <p class="item-text">
                        Email
                    </p>
                    <input onfocus="removeError(this.id)" class="text-inpt" type="email" id="nsie" name="email">
                    <div class="error" id="nsiee"><%=  emailTaken %></div>
                    <p class="item-text">
                        Username
                    </p>
                    <input onfocus="removeError(this.id)" class="text-inpt" type="text" id="nsiu" name="username">
                    <div class="error" id="nsiue"></div>
                    <p class="item-text">
                        Password
                    </p>
                    <input onfocus="removeError(this.id)" class="text-inpt" type="password" id="nsip" name="password">
                    <div class="error" id="nsipe"></div>
                    <p class="item-text">
                        Confirm Password
                    </p>
                    <input onfocus="removeError(this.id)" class="text-inpt" type="password" id="nsipp"
                        name="confirmPass">
                    <div class="error" id="nsippe"></div>
                    <br>
                    <input onclick="removeError(this.id)" type="checkbox" id="natAndc" name="natAndc" value="true">
                    <label class="small-item-text" for="natAndc"> I have read and agree to all terms and conditions of
                        OUR NAME</label>
                    <div id="natAndce"></div>

                    <br>
                    <input class="sub" type="submit" value="Create Account">
                </form>
            </div>
        </div>


    </div>


    <script src="myScript.js"></script>
</body>

</html>
