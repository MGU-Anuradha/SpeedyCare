package com.services.jsp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class ServiceDAO {
	
	String dbUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
	String dbUser = "isec";
	String dbPassword = "EUHHaYAmtzbv";
   
	public int addReservation (String preferredLocation,String currentMileage,String vehicleRegistrationNumber,String message,String userName,String reservationDate,String preferredTime) throws ParseException, ClassNotFoundException{
		 
		// Convert mileage to an integer
		int mileage = Integer.parseInt(currentMileage); 
		
		//Parse a date string into a Date object 
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = dateFormat.parse(reservationDate);
	        
	    //Handle time format
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
			  return -1;
		  }
		 
	    } catch (IllegalArgumentException e) {
		      return -2;
		}
	    
	    
	    //Insert data to the database--------------------
	    try{
	     	// Load the MySQL JDBC driver
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        
	        // Establish a database connection
	        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	        
	     	// Create a SQL INSERT statement
	        String insertSql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message,username) VALUES (?, ?, ?, ?, ?, ?, ?)";
	       
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
	        int rowsAdded = preparedStatement.executeUpdate();
	        
	        // Close the database connection
	        conn.close(); 
	     		             
	        // Check if the insertion was successful
	        return rowsAdded;
	    	
       }catch (SQLException e) {
           e.printStackTrace();
           
           return -1;
       }
	}
}
