<!DOCTYPE html>
<html>
<head>
    <title>Facebook Login</title>
    <link rel="stylesheet" href="/css/main.css">
</head>
<body>
<% String user_name=(String)request.getAttribute("username");
    String user_email=(String)request.getAttribute("email"); %>

<%=user_name %>
<br><br>
<%=user_email %>
</body>
</html>
