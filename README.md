# Vehicle Service Reservation Web Application

This web application is designed to facilitate vehicle service reservation while prioritizing security, authentication, and access control. 🚀🛡️

## Application Overview

*User Profile and Reservation:*

- Display authenticated user's profile information, including username, name, email, contact number, and country.
- Allow users to insert vehicle service reservation information, including authenticated user's details, date of reservation,
   preferred time, preferred location, vehicle registration number, current mileage, and a message.
- Provide an option to delete upcoming vehicle service reservation information.
- Enable users to view all vehicle service reservation information (both past and future reservations).

*Authentication and Logout:*

- Implement authentication and logout functionality using either OIDC protocols.
- Utilize a cloud-based Identity Provider (IDP) Asgardeo for user authentication.

*Security Measures:*

- Ensure the application is secure by avoiding OWASP Top 10 vulnerabilities, including SQL injection, XSS, CSRF, and authentication bypass.
- Test and mitigate these vulnerabilities during the development process.

*Access Control:*

- Implement strict access control policies to restrict users to their own reservation information.
- Access control should be based on the access token obtained from the IDP.

*Technology Stack:*

- Utilize the provided MySQL DB instance with a predefined table schema to store vehicle reservation records.
- Develop the web application using JSP (JavaServer Pages) and deploy it on Tomcat 9 server with HTTPS support.
- Ensure that any credentials and parameters that can be changed are configurable using configuration files such as application.properties or web.xml.

I have published a blog article ["Crafting Security into Web Applications — Safe Coding"](https://medium.com/@mguanuradha/crafting-security-into-web-applications-safe-coding-d8a72b4ad4d8), which includes security aspects considered, authentication protocols, implementation strategies, challenges faced, and the learning outcomes when developing the application. You can go through it for more details!


