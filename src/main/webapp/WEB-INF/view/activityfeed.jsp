<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Event" %>


<%
List <Event> events = (List<Event>) request.getAttribute("events");
%>

<!DOCTYPE html>
<html>
<head>
	<title>Activity Feed</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/main.css">
	<style>
		#activityfeed {
      background-color: white;
			height: 500px;
			overflow-y:scroll;
		}
	</style>
  <script>
    // scroll the chat div to the bottom
    function scrollEvents() {
      var eventDiv = document.getElementById('event');
      eventDiv.scrollTop = eventtDiv.scrollHeight;
    };
  </script>
</head>
<body onload="scrollEvents()">
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
  		<h1>Activity Feed</h1>
      <hr/>
  		<div id="activityfeed">
  			<ul>
  				<%
  				for (Event event : events) {
  					String message = event.toString();
  				%>
  				<li>
  					<strong><%= message%> </strong>
  				</li>
  				<%
  			}
  			%>
  		</ul>
  	</div>
	<% if(request.getSession().getAttribute("user") != null){ %>
	<form action="/privateactivityfeed" method="POST">
		<button type="submit">Private Activity Feed</button>
	</form>
	<% } %>

	</div>
</body>
</html>




