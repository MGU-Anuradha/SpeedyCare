<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NavBar</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
<link href="https://fonts.googleapis.com/css2?family=Merriweather:wght@900&family=Noto+Sans:wght@100&family=Roboto+Slab:wght@300;500&display=swap" rel="stylesheet">
</head>
<body>
	<!-- Navbar -->
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
	        	<button class="btn btn-dark" id="logoutButton">Logout</button>
	        </div>
	
	    	
	        <!-- Profile Modal -->
	        <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
	            <div class="modal-dialog modal-dialog-centered">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title" id="profileModalLabel">User Profile</h5>
	                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
	                    <div class="modal-body">
	                        <!-- User Profile Details will be displayed here -->
	                        <img class="round" src="https://randomuser.me/api/portraits/women/79.jpg" alt="user" />
	                        <h3>@<span id="modalUsername"></span></h3>
	                        <h6><span id="modalEmail"></span></h6>
	                        <p>Phone: <span id="modalPhone"></span><br/>Location: Sri Lanka</p>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</nav>
	
	<!-- Custom JavaScript code for Popup profile and Logout -->
	<script type="text/javascript">
	    // Assuming you have retrieved user details in these variables
	    var modalUsername = "john_doe";
	    var modalEmail = "john@example.com";
	    var modalPhone = "123-456-7890";
	
	    document.getElementById('profileDropdown').addEventListener('click', function () {
	        // Set user details in the modal
	        document.getElementById('modalUsername').textContent = modalUsername;
	        document.getElementById('modalEmail').textContent = modalEmail;
	        document.getElementById('modalPhone').textContent = modalPhone;
	    });
	
	    // Logout functionality
	    document.getElementById('logoutButton').addEventListener('click', function () {
	        // Perform logout operation here, for example redirect to logout page or clear user session
	        // window.location.href = 'logout.jsp';
	        alert('Logged out successfully!');
	    });
	</script>
	<!-- NavBar End -->

</body>
</html>