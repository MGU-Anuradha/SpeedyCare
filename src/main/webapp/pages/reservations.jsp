<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	//Database connection parameters
	String dbUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
	String dbUser = "isec";
	String dbPassword = "EUHHaYAmtzbv";
	ResultSet pastResultSet = null;
	ResultSet futureReservations = null;
	
	try{
		//Load MySQL JDBC driver
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		
		//Database connection
		Connection conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
		
		// Create a SQL SELECT query for future reservations
	    String futureRes = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) >= ? ORDER BY date, time";
				
	 	// Create PreparedStatements for both queries
	    PreparedStatement futurePreparedStatement = conn.prepareStatement(futureRes);
		
	    // Set the parameter value (username)
	    String username = "SpeedyCare";
	    futurePreparedStatement.setString(1, username);
	    
		// Set the parameter value (current date and time)
	    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String currentDateTime = dateTimeFormat.format(new Date());
	    futurePreparedStatement.setString(2, currentDateTime);
	    
	    // Execute the SELECT queries
	    futureReservations = futurePreparedStatement.executeQuery();
	 			
	 			
	}catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}

%> 
    
    
    
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservations | SpeedyCare</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Aref+Ruqaa+Ink:wght@700&family=Merriweather:wght@900&family=Noto+Sans:wght@100&family=Roboto+Condensed&family=Roboto+Slab:wght@300;500&family=Sofia+Sans+Condensed:wght@500&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Aref+Ruqaa+Ink:wght@700&family=Lato:wght@300&family=Merriweather:wght@900&family=Noto+Sans:wght@100&family=Open+Sans:wght@300&family=Roboto+Condensed&family=Roboto+Slab:wght@300;500&family=Sofia+Sans+Condensed:wght@100;500&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="css/reservations.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	
	<script type="text/javascript">
	
        const introspectUrl = 'https://api.asgardeo.io/t/ushanianu/oauth2/introspect';
        const accessToken = localStorage.getItem('access_token');
        const idToken = localStorage.getItem('id_token');
        
        //Indicating that the user is authenticated. 
        if(accessToken && idToken){
        	
        var settings = {
            "url": "https://api.asgardeo.io/t/ushanianu/oauth2/userinfo",
            "method": "GET",
            "timeout": 0,
            "headers": {
                "Authorization": "Bearer " + accessToken
            },
        };

        $.ajax(settings)
            .done(function (response) {
                console.log(response);
                var username =  response.username;
                var given_name = response.given_name;
                var phone = response.phone_number;
                var email = response.email;
                var parts = given_name.split(' ');
                var firstName = parts[0];
                document.getElementById('givenName').textContent = given_name;
                document.getElementById('name').textContent = firstName;
                document.getElementById('email').textContent = email;
                document.getElementById('phone').textContent = phone;
                
                document.getElementById('submit').addEventListener('click', function () {
                    // Set the username as a hidden field value in the form
                    document.getElementById('usernameField').value = username;
                });
                
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                // Handle any errors here
                console.error('Error:', errorThrown);
                alert("Error in the authorization. Login again!");
                window.location.href = "../index.jsp";
            });
        }
        else{
        	window.location.href = "../index.jsp";	
        }
    </script>
</head>

<body>
    <!-- Include the Navbar -->
    <jsp:include page="navbar.jsp" />
    
    <!-- View Reservations Modal -->
    <div class="container my-5 text-center">
        <h2>Discover Your Journey</h2>
        <table class="table">
		  <thead class="thead-dark">
		    <tr>
			    <th>Booking ID</th>
	            <th>Date</th>
	            <th>Time</th>
	            <th>Location</th>
	            <th>Mileage</th>
	            <th>Vehicle Number</th>
	            <th>Message</th>
		    </tr>

			<%
				Date currentDate = new Date(); 
			
				if (futureReservations != null) {
			           while (futureReservations.next()) {
			           	
			           		Date date = futureReservations.getDate("date");
			            	
			           		if(date.before(currentDate)){
			           		 	continue;
			           		}
			           		
			                int bookingId = futureReservations.getInt("booking_id");
			                Time time = futureReservations.getTime("time");
			                String location = futureReservations.getString("location");
			                int mileage = futureReservations.getInt("mileage");
			                String vehicleNo = futureReservations.getString("vehicle_no");
			                String message = futureReservations.getString("message");    
			%>
			
	       <tr>
	            <td><%= bookingId %></td>
	            <td><%= date %></td>
	            <td><%= time %></td>
	            <td><%= location %></td>
	            <td><%= mileage %></td>
	            <td><%= vehicleNo %></td>
	            <td><%= message %></td>
	        </tr>
       	    <% 
      			}}
    		%>
		   </thead>
		</table>
    </div>  



    <!-- Bootstrap JS from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>