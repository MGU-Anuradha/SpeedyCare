<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SpeedyCare</title>
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="css/bootstrap.css">
</head>

<body>
	<div class="container">
		<h1><b>Welcome to SpeedyCareHub!</b></h1>
        <p>Seamless Reservations - Exceptional Rides</p><br/>
        <button type="button" class="btn btn-primary" onclick="window.location.href='https://api.asgardeo.io/t/ushanianu/oauth2/authorize?response_type=code&client_id=NNM4cwVMCF3J3nWBYNlV2YO2UW8a&scope=openid%20email%20phone%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2FSpeedyCare%2Fuserauthorize.jsp'">Sign In</button>
        <button type="button" class="btn btn-primary" onclick="window.location.href='https://console.asgardeo.io/'">Register</button>
	</div>
</body>
</html>
