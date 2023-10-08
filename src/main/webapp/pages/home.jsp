<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.services.jsp.*" %>

<%
    ServiceDAO service = new ServiceDAO();
    // Database connection parameters
    String dbUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
    String dbUser = "isec";
    String dbPassword = "EUHHaYAmtzbv";
    ResultSet pastReservations = null;
    ResultSet futureReservations = null;

    try {
        // when Submit Reservation button clicked -----------------------------------------------------
        if (request.getParameter("submit") != null) {

            // Retrieve form data-----------------------
            String userName = request.getParameter("usernameField");
            String reservationDate = request.getParameter("pickupDate");
            String preferredTime = request.getParameter("preferredTime");
            String preferredLocation = request.getParameter("preferredLocation");
            String vehicleRegistrationNumber = request.getParameter("vehicleRegistrationNumber");
            String currentMileage = request.getParameter("currentMileage");
            String message = request.getParameter("message");
            
            System.out.println("Username: " + userName);
    	    System.out.println("location: " + preferredLocation);
    	    System.out.println("Mileage: " + currentMileage);
    	    System.out.println("Message: " + message);
    	    System.out.println("Vehicle No: " + vehicleRegistrationNumber);


            // Insert data to the database------------------------
            int rowsAdded = service.addReservation(preferredLocation, currentMileage, vehicleRegistrationNumber, message, userName, reservationDate, preferredTime);

            if (rowsAdded > 0) {
                out.println("Data inserted successfully.");
                response.sendRedirect(request.getRequestURI());
            } else if (rowsAdded == -1) {
                out.println("Invalid time format. Please enter time in hh:mm format.");
            } else if (rowsAdded == -2) {
                out.println("Error parsing time.");
            } else if (rowsAdded == -3) {
                out.println("Invalid mileage format. Convert mileage into an integer.");
            } else if (rowsAdded == -4) {
                out.println("Invalid date format. Please enter date in yyyy-MM-dd format.");
            } else {
                out.println("Failed to insert data.");
            }
        }

        // when View Future Reservations form submitted -----------------------------------------------------
        if (request.getParameter("futureReserve") != null) {
            String userName = request.getParameter("usernameField2");
            System.out.println("Hello");
            System.out.println(userName);
            futureReservations = service.displayFutureReservations (userName);
        }

        // when View Past Reservations form submitted -----------------------------------------------------
        if (request.getParameter("pastReserve") != null) {
            String userName = request.getParameter("usernameField3");
            System.out.println("Hello");
            System.out.println(userName);
            pastReservations = service.displayPastReservations(userName);
        }

        // When the delete button is clicked
        if (request.getParameter("delete") != null) {
            String bookingId = request.getParameter("bookingID");
            try {
                int id = Integer.parseInt(bookingId);
                // delete the row
                int rowsAffected = service.deleteReservations(id);

                if (rowsAffected > 0) {
                    // refresh the site
                    response.sendRedirect(request.getRequestURI());
                } else if (rowsAffected == -1) {
                    out.println("Error in the database. Try again later.");
                } else {
                    out.println("No data found for the given booking ID.");
                }
            } catch (NumberFormatException e) {
                out.println("Invalid booking ID format.");
            }
        }
    } catch (ClassNotFoundException e) {
        out.println("Error: Database driver class not found.");
        e.printStackTrace(); // Log the exception for debugging
    } catch (SQLException e) {
        out.println("Error: Database operation failed. Please try again later.");
        e.printStackTrace(); // Log the exception for debugging
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
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
	<link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@900&family=Noto+Sans:wght@100&family=Roboto+Slab:wght@300;500&display=swap" rel="stylesheet">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>	
	
	
	<script type="text/javascript">

		 const introspectUrl = 'https://api.asgardeo.io/t/ushanianu/oauth2/introspect';
		 const accessToken = localStorage.getItem('access_token');
		 const idToken = localStorage.getItem('id_token');
	
		 // Check if the user is authenticated
		 if (accessToken && idToken) {
		     var settings = {
		         // Make an AJAX request to fetch user information
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
		             var username = response.username;
			            
		 	         // Set user information in the form fields
		 	         document.getElementById('username').textContent = username;
		 	         document.getElementById('givenName').textContent = response.given_name;
		 	         document.getElementById('name').textContent = response.given_name.split(' ')[0];
		 	         document.getElementById('email').textContent = response.email;
		 	         document.getElementById('phone').textContent = response.phone_number;
		 	         document.getElementById('country').textContent = response.country;
		 			
		             document.getElementById('submit').addEventListener('click', function () {
		                 // Set the username as a hidden field value in the form
		                 document.getElementById('usernameField').value = username;
		             });
		             document.getElementById('futureReserve').addEventListener('click', function () {
		                 document.getElementById('usernameField2').value = username;
		             });
		             document.getElementById('pastReserve').addEventListener('click', function () {
		                 document.getElementById('usernameField3').value = username;
		             });
	
		             // Store the username in a session attribute
		             session.setAttribute("username", username);
		             console.log(session.getAttribute('username'));
	
		         })
		         .fail(function (jqXHR, textStatus, errorThrown) {
		             // Handle any errors here
		             console.error('Error:', errorThrown);
		             alert("Error in the authorization. Login again!");
		             window.location.href = "../index.jsp";
		         });
		 } else {
		     window.location.href = "../index.jsp";
		 }
		 
	</script>
</head>




<body>
    <!-- NavBar -->
	<nav class="navbar navbar-light" style="background: linear-gradient(0deg, rgba(219,204,120,1) 0%, rgba(173,144,13,1) 99%);">
	    <div class="container">
	       <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" width="100" height="40">  
	       <b>SPEEDYCARE HUB</b>
	
	       <!-- Profile Dropdown -->
	        <div class="dropdown">
	            <button class="btn btn-secondary dropdown-toggle" type="button" id="profileDropdown" data-bs-toggle="modal" data-bs-target="#profileModal">
	                <i class="bi bi-person"></i> <!-- Bootstrap Icons: Person Icon -->
	            </button>
	            <!-- Logout Button -->
	        	<button class="btn btn-dark" id="logoutButton" onclick="window.location.href='../index.jsp'">Logout</button>
	        </div>
	
	    	
	        <!-- User Profile Modal -->
			<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-dialog-centered">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="profileModalLabel">User Profile</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body">
			                <h3>@<span id="username"></span></h3>
			                <h6>Name: <span id="name"></span></h6>
			                <h6>Email:<span id="email"></span></h6>
			                <p>Phone: <span id="phone"></span><br/>
			                Location: <span id="country"></span></p>
			            </div>
			        </div>
			    </div>
			</div>

	    </div>
	</nav>
	<!-- NavBar End -->
    

    <!-- Reservation form -->
    <div class="form-container">
        <div class="container my-5 d-flex flex-column align-items-center">
            <h2>Reserve Your Spot Now</h2>
            
            <!-- View Future Reservations Model -->            
            <form class="mb-5" method="post" id="myForm" action="?displayFuture=true" onclick="document.getElementById('future').style.display='block'"  >
				<input type="hidden" id="usernameField2" name="usernameField2" value="" >              
				<input type="submit" class="res" id="futureReserve" name="futureReserve" value= "Future Reservations" >
			</form> 
			
			
			<!-- View Past Reservations Model -->            
            <form class="mb-5" method="post" id="myForm"  action="?displayPast=true" onclick="document.getElementById('past').style.display='block'" >
				<input type="hidden" id="usernameField3" name="usernameField3" value="" >              
				<input type="submit" class="res" id="pastReserve" name= "pastReserve" value="Past Reservations" >
			</form> 
			
		
			<!-- Reservation form -->
            <form method="post" id="reserveForm" name="reserveForm">
                <div class="mb-3">
                    <label for="vehicleRegistrationNumber" class="form-label">Vehicle Number *</label>
                    <input type="text" class="form-control" id="vehicleRegistrationNumber" name="vehicleRegistrationNumber" placeholder="Enter Vehicle Registration Number" required>
                </div>
                <div class="mb-3">
                    <label for="pickupDate" class="form-label">Reservation Date *</label>
                    <input type="date" class="form-control" id="pickupDate" name="pickupDate"  required>
                </div>
                <div class="mb-3">
                    <label for="preferredTime" class="form-label">Preferred Time *</label>
                    <select class="form-select" id="preferredTime" name="preferredTime" required>
                    	<option selected>Choose...</option>
                        <option value="10">10 AM</option>
                        <option value="11">11 AM</option>
                        <option value="12">12 PM</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="preferredLocation" class="form-label">Location *</label>
                    <select class="form-select" id="preferredLocation" name="preferredLocation" required>
						    <option selected>Choose...</option>
						    <option value="Colombo">Colombo</option>
				            <option value="Gampaha">Gampaha</option>
				            <option value="Kalutara">Kalutara</option>
				            <option value="Kandy">Kandy</option>
				            <option value="Matale">Matale</option>
				            <option value="Nuwara Eliya">Nuwara Eliya</option>
				            <option value="Galle">Galle</option>
				            <option value="Matara">Matara</option>
				            <option value="Hambantota">Hambantota</option>
				            <option value="Jaffna">Jaffna</option>
				            <option value="Kilinochchi">Kilinochchi</option>
				            <option value="Mannar">Mannar</option>
				            <option value="Vavuniya">Vavuniya</option>
				            <option value="Mullaitivu">Mullaitivu</option>
				            <option value="Batticaloa">Batticaloa</option>
				            <option value="Ampara">Ampara</option>
				            <option value="Trincomalee">Trincomalee</option>
				            <option value="Kurunegala">Kurunegala</option>
				            <option value="Puttalam">Puttalam</option>
				            <option value="Anuradhapura">Anuradhapura</option>
				            <option value="Polonnaruwa">Polonnaruwa</option>
				            <option value="Badulla">Badulla</option>
				            <option value="Monaragala">Monaragala</option>
				            <option value="Ratnapura">Ratnapura</option>
				            <option value="Kegalle">Kegalle</option>
						  </select>
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

    

    
    
       
    <!-- View Future Reservations Modal --> 		
	<% if (request.getParameter("displayFuture") != null && request.getParameter("displayFuture").equals("true")) { %> 
		
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
		            <th>Action</th>
			    </tr>
		    
			    <%
			        Date currentDate = new Date();
			        
			        if (futureReservations != null) {
			            while (futureReservations.next()) {
			            	
			            	Date reservationDate = futureReservations.getDate("date");
			            	
			            	if(reservationDate.before(currentDate)){
			            		 continue;
			            	}
			                int bookingId = futureReservations.getInt("booking_id");
			                Time prefferedTime = futureReservations.getTime("time");
			                String prefferedLocation = futureReservations.getString("location");
			                int mileage = futureReservations.getInt("mileage");
			                String vehicleRegistrationNumber = futureReservations.getString("vehicle_no");
			                String message = futureReservations.getString("message");     
			     %>
		                <tr>
				            <td><%= bookingId %></td>
				            <td><%= reservationDate %></td>
				            <td><%= prefferedTime %></td>
				            <td><%= prefferedLocation %></td>
				            <td><%= mileage %></td>
				            <td><%= vehicleRegistrationNumber %></td>
				            <td><%= message %></td>
				            <td><button onclick="document.getElementById('delete').style.display='block';  document.getElementById('bookingID').value = <%= bookingId %>;" class="delete">Delete</button></td>
				        </tr>
        		<% 
           			 }}
            
   				 %>
			   </thead>
			</table>
	    </div> 
    <% } %>
    
	
	<!-- Delete Reservations Modal --> 
	<div id="delete" class="modal">
		<span onclick="document.getElementById('delete').style.display='none'" class="close" title="Close Modal">?</span>
	  	<form class="modal-content" method="post" >
	    	<div class="container2">
	      		<h1>Delete Reservation</h1>
	      		<p>Are you sure you want to delete your reservation?</p>
	    		<input type="hidden" id="bookingID" name="bookingID" value="" >
	     		
	     		<div class="clearfix">
	        		<button type="button" onclick="document.getElementById('delete').style.display='none'" class="cancelbtn">Cancel</button>
	        		<input type="submit" value="Delete" name="delete" onclick="document.getElementById('delete').style.display='none'" class="deletebtn">
	      		</div>
	    	</div>
	  	</form>
	</div>




	<!-- View Past Reservations Modal --> 		
	<% if (request.getParameter("displayPast") != null && request.getParameter("displayPast").equals("true")) { %> 
		
		<div class="container my-5 text-center">
        <h2>Discover Your Journey Past</h2>   
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
			        
			        if (pastReservations != null) {
			            while (pastReservations.next()) {
			            	
			            	Date reservationDate = pastReservations.getDate("date");
			            	
			            	if(!reservationDate.before(currentDate)){
			            		 continue;
			            	}
			                int bookingId = pastReservations.getInt("booking_id");
			                Time prefferedTime = pastReservations.getTime("time");
			                String prefferedLocation = pastReservations.getString("location");
			                int mileage = pastReservations.getInt("mileage");
			                String vehicleRegistrationNumber = pastReservations.getString("vehicle_no");
			                String message = pastReservations.getString("message");     
			     %>
		                <tr>
				            <td><%= bookingId %></td>
				            <td><%= reservationDate %></td>
				            <td><%= prefferedTime %></td>
				            <td><%= prefferedLocation %></td>
				            <td><%= mileage %></td>
				            <td><%= vehicleRegistrationNumber %></td>
				            <td><%= message %></td>
				        </tr>
        		<% 
           			 }}
            
   				 %>
			   </thead>
			</table>
	    </div> 
    <% } %>
    

    
    

    <!-- Bootstrap JS from CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
