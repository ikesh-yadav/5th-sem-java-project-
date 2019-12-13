<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %> 
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/common.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="css/common.css">
  <script>
  	function redirectToTest(t){
  		var test_name=t.firstElementChild.innerHTML;
  		window.location.href = "viewtest?test_name="+test_name;
  	}
  </script>
</head>
<body>
  <div style ="height: 5%;background-color: rgb(0, 0, 51);font-size:0px;">
    <div style="font-size: 30px;width: 100%;text-align: center;color:white"><b>HOMEPAGE</b></div>
    <div style="font-size: 20px;width: 100%;text-align: center;color:white">
  	Welcome,${sessionScope.loginUser }
  </div> 
   </div>
    <div class="test-view">
   		<sql:setDataSource
		    var="myDS"
		    driver="com.mysql.cj.jdbc.Driver"
		    url="jdbc:mysql://localhost:3306/student_marks_system?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
		    user="root" password=""
		/>
		<sql:query var="user" dataSource="${myDS}">
		    SELECT sem,sec FROM user where name='${sessionScope.loginUser}' ;
		</sql:query>
		<c:forEach items="${user.rows}" var="r">
            <c:set scope="session"
                   var="sem"
                   value="${r.sem}"/>
            <c:set scope="session"
                   var="sec"
                   value="${r.sec}"/>
      </c:forEach>
		<c:choose>
		
		<c:when test="${sessionScope.faculty==false}">
		<sql:query var="list_users" dataSource="${myDS}">
		    SELECT * FROM test where sem=${sessionScope.sem} and sec='${sessionScope.sec}' ;
		</sql:query>
		</c:when>
		<c:otherwise>
		<sql:query var="list_users" dataSource="${myDS}">
		    SELECT * FROM test where creator_name='${sessionScope.loginUser}' ;
		</sql:query>
		</c:otherwise>
		
		</c:choose>
    	<table class="test-view">
    	<tr><th colspan="5">Your tests</th></tr>    	
        <c:forEach var="user" items="${list_users.rows}">
	           <tr class="tr-links" onclick="redirectToTest(this)">
	                <td><c:out value="${user.test_name}" /></td>
	                <td><c:out value="${user.date}" /></td>
	                <td><c:out value="${user.duration}" /></td>
	                <td><c:out value="${user.start_date}" /></td>
	                <td><c:out value="${user.end_date}" /></td>
	            </tr>
        </c:forEach>
        </table>
    </div>
  <div>
  <c:if test="${sessionScope.faculty==true }">
  <div>
  	<a href="/createTest" class="linkbtn"> Create Test</a>
  </div>
  </c:if>
  <a class="linkbtn" href='logout' class="linkbtn">logout</a>
  </div>
</body>
</html>

