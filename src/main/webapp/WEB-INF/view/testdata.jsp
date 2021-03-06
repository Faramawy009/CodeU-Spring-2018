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
  <title>Load Test Data</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/main.css" type="text/css">
</head>
<body>

<nav>
  <a id="navTitle" href="/">Abdo Chat App</a>
  <% if(request.getSession().getAttribute("user") != null){ %>
  <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
  <a href="/user/<%= request.getSession().getAttribute("user") %>">Profile</a>
  <a href="/following">Following</a>
  <% } else{ %>
  <a href="/register">Register</a>
  <a href="/login">Login</a>
  <% } %>
  <a href="/conversations">Conversations</a>
  <a href="/activityfeed">Activity Feed</a>
  <a href="/about.jsp">About</a>
    <% if (request.getSession().getAttribute("user") != null) {%>
    <a href="/logout">Logout</a>
    <%}%>
</nav>

  <div id="container">
    <h1>Load Test Data</h1>
    <p>This will load a number of users, conversations, and messages for testing
        purposes.</p>
    <form action="/testdata" method="POST">
      <button type="submit" value="confirm" name="confirm">Confirm</button>
      <button type="submit" value="cancel" name="cancel">Do Nothing</button>
    </form>
  </div>
</body>
</html>
