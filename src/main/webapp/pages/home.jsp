<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	//Database connection parameters
	String dbUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
	String dbUser = "isec";
	String dbPassword = "EUHHaYAmtzbv";
	ResultSet pastResultSet = null;
	ResultSet futureResultSet = null;
	
	try{
		//Load MySQL JDBC driver
		Class.forName("com.mysql.cj.jdbc.Driver"); 
		
		//Database connection
		Connection conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
		
		// Set the parameter value (username)
	    String username = "SpeedyCare";
		 
	}catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}

	
	
	
	//Create Reservation-----------------------------------------------------
	if (request.getParameter("submit") != null){
		
		// Retrieve form data-----------------------
	    //String name = request.getParameter("name");
	    //String email = request.getParameter("email");
	    //String contactNumber = request.getParameter("contactNumber");
	    	
	    String userName = request.getParameter("usernameField");
	    String reservationDate = request.getParameter("pickupDate");
	    String preferredTime = request.getParameter("preferredTime");
	 	String preferredLocation = request.getParameter("preferredLocation");
	    String vehicleRegistrationNumber = request.getParameter("vehicleRegistrationNumber");
	    String currentMileage = request.getParameter("currentMileage");
	    String message = request.getParameter("message");
	    
	    // Convert mileage to an integer
        int mileage = Integer.parseInt(currentMileage);
	 	
	 	//Parse a date string into a Date object 
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = dateFormat.parse(reservationDate);
        
        Time time = null;
        try {
	        // Check if the preferredTime matches the expected format "hh:mm"
	        if (preferredTime.matches("^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$")) {
	            // If it matches, add ":00" to the end of the string to match SQL TIME format
	            preferredTime += ":00";
	            // Create a Time object
	            time = Time.valueOf(preferredTime);
	        } else {
	            // Handle invalid time format
	            out.println("Invalid time format. Please enter time in hh:mm format.");
	        }
	    } catch (IllegalArgumentException e) {
	        out.println("Error parsing time: " + e.getMessage());
	    }
        if (time != null) {
	        // Time object is valid, you can use it
	        out.println("Parsed Time: " + time);
	    }
        
        //Insert Data --------------------------------
       try{
	     	// Load the MySQL JDBC driver
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Establish a database connection
	        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	        
	     	// Create a SQL INSERT statement
	        String insertSql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message,username) VALUES (?, ?, ?, ?, ?, ?, )";
	       
	        // Create a PreparedStatement
	        PreparedStatement preparedStatement = conn.prepareStatement(insertSql);
	        
	     	// Set the parameter values
           	preparedStatement.setDate(1, new java.sql.Date(date.getTime())); // Current date
            preparedStatement.setTime(2, time); // Current time
            preparedStatement.setString(3, preferredLocation);
            preparedStatement.setInt(4, mileage);
            preparedStatement.setString(5, vehicleRegistrationNumber);
            preparedStatement.setString(6, message);
            preparedStatement.setString(7, userName);
	        
	        // Execute the INSERT statement
	        int AddedRows = preparedStatement.executeUpdate();
	        
	     	// Check if the insertion was successful
	        if (AddedRows > 0) {
	        	out.println("Data inserted successfully.");
	            response.sendRedirect(request.getRequestURI());  
	        } else {
	            out.println("Failed to insert data.");
	        }
	     	
	    	// Close the database connection
	        conn.close(); 
       }
       catch (ClassNotFoundException e) {
           e.printStackTrace();
       } catch (SQLException e) {
           e.printStackTrace();
       }
	}
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home | SpeedyCare</title>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Aref+Ruqaa+Ink:wght@700&family=Merriweather:wght@900&family=Noto+Sans:wght@100&family=Roboto+Condensed&family=Roboto+Slab:wght@300;500&family=Sofia+Sans+Condensed:wght@500&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
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

    <!-- Reservation form -->
    <div class="form-container">
        <div class="container my-5 d-flex flex-column align-items-center">
            <h2>Reserve Your Spot Now</h2>

            <!-- View Button -->
            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#viewReservationModal" id="viewReservationBtn">View Reservations</button>

            <!-- Reservation Form -->
            <form method="post" id="reserveForm" name="reserveForm">
                <div class="mb-3">
                    <label for="vehicleRegistrationNumber" class="form-label">Vehicle Number *</label>
                    <input type="text" class="form-control" id="vehicleRegistrationNumber" name="vehicleRegistrationNumber" placeholder="Enter Vehicle Registration Number" required>
                </div>
                <div class="mb-3">
                    <label for="pickupDate" class="form-label">Reservation Date *</label>
                    <input type="date" class="form-control" id="pickupDate" name="pickupDate" value="pickupDate" required>
                </div>
                <div class="mb-3">
                    <label for="preferredTime" class="form-label">Preferred Time *</label>
                    <select class="form-select" id="preferredTime" required>
                        <option value="10AM">10 AM</option>
                        <option value="11AM">11 AM</option>
                        <option value="12PM">12 PM</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="preferredLocation" class="form-label">Location *</label>
                    <input type="text" class="form-control" id="preferredLocation" name="preferredLocation" placeholder="Enter Preferred Location" required>
                </div>
                <div class="mb-3">
                    <label for="currentMileage" class="form-label">Mileage</label>
                    <input type="text" class="form-control" id="currentMileage" name="currentMileage" placeholder="Enter Current Mileage" required>
                </div>
                <div class="mb-3">
                    <label for="message" class="form-label">Message</label>
                    <textarea class="form-control" id="message" name="message" rows="3" placeholder="Enter Your Message"></textarea>
                </div>

                <input type="hidden" id="usernameField" name="usernameField" value="">

                <div class="button-container">
                    <button type="submit" class="btn btn-primary" value="Submit" id="submit" name="submit">Submit Reservation</button>
                </div>
            </form>
        </div>
    </div>

    <!-- View Button calling -->
    <script>
        // Get the button element by its id
        const viewReservationBtn = document.getElementById('viewReservationBtn');

        // Add a click event listener to the button
        viewReservationBtn.addEventListener('click', function () {
            // Navigate to the table.js page when the button is clicked
            window.location.href = 'reservations.jsp';
        });
    </script>
    

    <!-- Bootstrap JS from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
