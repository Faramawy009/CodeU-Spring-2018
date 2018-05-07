<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>
<script>
    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            // Logged into your app and Facebook.
            testAPI();
        } else if (response.status === 'not_authorized') {
            // The person is logged into Facebook, but not your app.
            document.getElementById('status').innerHTML = 'Login with Facebook ';
        } else {
            // The person is not logged into Facebook, so we're not sure if
            // they are logged into this app or not.
            document.getElementById('status').innerHTML = 'Login with Facebook ';
        }
    }
    // This function is called when someone finishes with the Login
    // Button. See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    }
    window.fbAsyncInit = function() {
        FB.init({
            appId : '2190021137693964',
            cookie : true, // enable cookies to allow the server to access
            // the session
            xfbml : true, // parse social plugins on this page
            version : 'v2.7' // use version 2.2
        });
        // Now that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus(). This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide. They can be:
        //
        // 1. Logged into your app ('connected')
        // 2. Logged into Facebook, but not your app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        // your app or not.
        //
        // These three cases are handled in the callback function.

        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    };
    // Load the SDK asynchronously
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    // Here we run a very simple test of the Graph API after login is
    // successful. See statusChangeCallback() for when this call is made.
    function testAPI() {
        console.log('Welcome! Fetching your information.... ');
        FB.api('/me?fields=name,email', function(response) {
            console.log('Successful login for: ' + response.name);
            var form = document.createElement("form");
            form.setAttribute("method", "POST");
            form.setAttribute("action", "/fblogin");

            var hiddenField1 = document.createElement("input");
            hiddenField1.setAttribute("type", "hidden");
            hiddenField1.setAttribute("name", "username");
            hiddenField1.setAttribute("value", response.name);
            form.appendChild(hiddenField1);
            var hiddenField2 = document.createElement("input");
            hiddenField2.setAttribute("type", "hidden");
            hiddenField2.setAttribute("name", "email");
            hiddenField2.setAttribute("value", response.email);
            form.appendChild(hiddenField2);

            document.body.appendChild(form);
            form.submit();
            // var xhttp = new XMLHttpRequest();
            // var url = '/fblogin';
            // var params = 'username='+response.name+'&email='+response.email;
            // xhttp.open("POST", url, false);
            // xhttp.send(params);
            // document.getElementById("status").innerHTML = '<p>Welcome '+response.name+' Your email is: ' + response.email +'</p><br>';
            // document.getElementById("status").innerHTML += '<p>Welcome '+response.name+'! <a href=fblogincontroller?user_name='+ response.name.replace(" ", "_") +'&user_email='+ response.email +'>Continue with facebook login</a></p>'
        });
    }
</script>
<!--
 Below we include the Login Button social plugin. This button uses
 the JavaScript SDK to present a graphical Login button that triggers
 the FB.login() function when clicked.
-->

<nav>
  <a id="navTitle" href="/">CodeU Chat App</a>
  <a href="/conversations">Conversations</a>
  <% if(request.getSession().getAttribute("user") != null){ %>
  <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
  <a href="/following">Following</a>
  <% } else{ %>
  <a href="/login">Login</a>
  <a href="/register">Register</a>
  <% } %>
  <a href="/about.jsp">About</a>
</nav>

<div id="container">
  <h1>Login</h1>

  <% if(request.getAttribute("error") != null){ %>
  <h2 style="color:red"><%= request.getAttribute("error") %></h2>
  <% } %>

  <form action="/login" method="POST">
    <label for="username">Username: </label>
    <input type="text" name="username" id="username">
    <br/>
    <label for="password">Password: </label>
    <input type="password" name="password" id="password">
    <br/><br/>
    <button type="submit">Login</button>
  </form>
  <br><br>
  <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
  </fb:login-button>
  <div id="status">
  </div>
  <script type="text/javascript">
  </script>
</div>
</body>
</html>
