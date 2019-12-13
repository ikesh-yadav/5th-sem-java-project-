<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="css/common.css">
  <script>
  	function redirectToTest(){
  		window.location.href = "takeTest?test_name="+'${param.test_name}';
  	}
  </script>
</head>
<body>


<div style ="height: 5%;background-color: rgb(0, 0, 51);font-size:0px;">
  <div style="font-size: 30px;width: 100%;text-align: center;color:white"><b>MARKS</b> </div>
  <div style="font-size: 20px;width: 100%;text-align: center;color:white">
  	Welcome,${sessionScope.loginUser }
  </div> 
</div>
<jsp:useBean id="date" class="java.util.Date" />
<fmt:formatDate pattern="yyyy-MM-dd" type="DATE" var="cur_date" value="${date}" />

	<sql:setDataSource
			    var="myDS"
			    driver="com.mysql.cj.jdbc.Driver"
			    url="jdbc:mysql://localhost:3306/student_marks_system?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
			    user="root" password=""
			/>
	    	<sql:query var="list_users" dataSource="${myDS}">
			    SELECT * FROM test 
			    where test_name='${param.test_name}';
			</sql:query>
	           <table class="test-view">
    				<tr><th>Test Details</th></tr>    	
        			<c:forEach var="user" items="${list_users.rows}">
		                <tr><td>Test Name:<c:out value="${user.test_name}" /></td></tr>
		                <tr><td>Date Created:<c:out value="${user.date}" /></td></tr>
		                <tr><td>Duration:<c:out value="${user.duration}" /></td></tr>
		                <tr><td>Start Date:<c:out value="${user.start_date}" /></td></tr>
		                <tr><td>End Date:<c:out value="${user.end_date}" /></td></tr>
		                <fmt:formatDate value="${user.start_date}" type="DATE" pattern="yyyy-MM-dd" var="start_date"/>
		                <fmt:formatDate value="${user.end_date}" type="DATE" pattern="yyyy-MM-dd" var="end_date"/>
		        	</c:forEach>
		       
		        
	           <c:if test="${sessionScope.faculty==true}">
	           		<sql:query var="marks" dataSource="${myDS}">
				    	SELECT * FROM `${param.test_name}_answers`;
					</sql:query>
	           		<table class="student-marks">
	           			<tr><th>student</th><th>marks</th></tr>
	           			<c:forEach var="usermarks" items="${marks.rows}">
			               <tr><td><label><c:out value="${usermarks.name}" /></label></td><td>
			                <label><c:out value="${usermarks.marks}" /></label></td></tr>
			           </c:forEach>
	           		</table>
	           </c:if>
	           <c:if test="${sessionScope.faculty==false}">
	           		<sql:query var="marks" dataSource="${myDS}">
				    	SELECT * FROM `${param.test_name}_answers` where name='${sessionScope.loginUser}';
					</sql:query>
					<c:choose>
        				<c:when test="${marks.rowCount == 0}">
        					<c:choose>
        						<c:when test="${cur_date<start_date }">
	            					<tr><td>The test has not started</td></tr>
	            				</c:when>
	            				<c:when test="${cur_date>end_date}">
	            					<tr><td>The Test deadline is over</td></tr>
		            				<tr><td>You have not taken this test</td></tr>
	            				</c:when>
	            				<c:otherwise>
	            					<tr><td><input type="button" value="Take Test" onclick="redirectToTest()" /></td></tr>
	            				</c:otherwise>
		            		</c:choose>
        				</c:when>
	        			<c:otherwise>
	    					<c:choose>
        						<c:when test="${cur_date<start_date }">
	            					<tr><td>The test has not started</td></tr>
	            				</c:when>
	            				<c:when test="${cur_date>end_date}">
	            					<tr><td>The Test deadline is over</td></tr>
	            					<c:forEach var="row" items="${marks.rows}">
		            					<tr><td>You have Scored ${row.marks} Marks in this test</td></tr>
		            				</c:forEach>
	            				</c:when>
	            				<c:otherwise>
	            					<c:forEach var="row" items="${marks.rows}">
		            					<tr><td>You have Scored ${row.marks} Marks in this test</td></tr>
		            				</c:forEach>
	            				</c:otherwise>
		            		</c:choose>
	        			</c:otherwise>
	    			</c:choose>
	           </c:if>
	       </table>
	 <a href='homepage' class="linkbtn">homepage</a>
	<a href='logout' class="linkbtn">logout</a>
</body>
</html> 