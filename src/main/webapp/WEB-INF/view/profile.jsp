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
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Profile" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>


<%
User user = (User) request.getAttribute("profileUser");
Profile profile = (Profile) request.getAttribute("profile");
%>

<!DOCTYPE html>
<html>
<head>
  <title>CodeU Chat App</title>
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

  <script language="javascript">
      function showEdit() {
          editProfile.style.display="block";
      }
  </script>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">
      <h1><%= request.getAttribute("username")%></h1>
      <% if(request.getAttribute("username").equals(request.getSession().getAttribute("user"))){%>
            <form onsubmit="return false;" name="show" action="/user/<%= request.getSession().getAttribute("user") %>" method="POST">
                <input type="submit" name = "edit" value = "Edit" onclick="showEdit()"</>
            </form>
            <h3>About</h3>
                  <p>
                    <%= (String) request.getAttribute("about")%>
                  </p>
            <form name="editProfile" style="display:none" action="/user/<%= request.getSession().getAttribute("user")%>" method="POST">
              About:<textarea rows="5" cols="80" name = "newAbout" id="newAbout"></textarea>
              <input type="submit" name = "update" value = "Update"</>
             </form>
        <% } else { %>
            <h3>About</h3>
                  <p>
                    <%= (String) request.getAttribute("about")%>
                  </p>
        <% } %>

    <h3>Message History</h3>

    <%
    List<Message> messages = (List<Message>) request.getAttribute("messages");
    if(messages == null || messages.isEmpty()){
    %>
      <h2 style="color:red">No messages yet!</h2>
    <%
    }
    else{
    %>
      <ul class="mdl-list">
    <%
      for(Message message : messages){
    %>
      <li><a href="/chat/<%= ConversationStore.getInstance().getConversation(message.getConversationId()).getTitle()%>">
        <%= ConversationStore.getInstance().getConversation(message.getConversationId()).getTitle() %></a>:
        <%= message.getContent() %></a></li>
    <%
      }
    %>
      </ul>
    <%
    }
    %>
    <hr/>
    </div>
  </div>
</body>
</html>
