<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.sql.*" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %> 

<!DOCTYPE html>
<html lang="en">
  <head>
      <meta charset="utf-8">
      <title>Log in with your account</title>
      <link rel="stylesheet" type="text/css" href="css/common.css">
  </head>
	
  <body>

    <div class="modal-content">
      <form method="POST" action="/loginAutenticate" class="form-signin">
        <h2 class="form-heading">Log in</h2>

        <div class="form-group">
            <input name="username" type="text" class="form-control" placeholder="Username"
                   autofocus="true"/>
            <input name="password" type="password" class="form-control" placeholder="Password"/>
            <label>
		        <input type="checkbox" name="faculty" unchecked> Faculty
		    </label>

            <button class="submit-btn" type="submit">Log In</button>
            <h4 class="text-center"><a href="/signup">Signup</a></h4>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </div>
        <font color="red"><c:if test="${not empty param.errMsg}">
            <c:out value="${param.errMsg}" />
            </c:if></font>
      </form>
    </div>

  </body>
</html>