
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
            document.getElementById('givenName').textContent = response.given_name;
            document.getElementById('name').textContent = response.given_name.split(' ')[0];
            document.getElementById('email').textContent = response.email;
            document.getElementById('phone').textContent = response.phone_number;

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
