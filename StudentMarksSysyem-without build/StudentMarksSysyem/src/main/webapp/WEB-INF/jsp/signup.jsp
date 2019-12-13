 <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" type="text/css" href="style2.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="UTF-8">
</head>
<body>
<%
	if(request.getParameter("username")!=null){
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_marks_system?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
		Statement stmt = con.createStatement();
		String testName=request.getParameter("test_name");
	   	String sql="INSERT INTO `user` VALUES('"+request.getParameter("username")+"','"+request.getParameter("password")+"','"+request.getParameter("sem")+"','"+request.getParameter("sec")+"')";
	   	if(stmt.executeUpdate(sql)!=0){
	   		out.print("Signup succesful!,You will be redirected to login page");
	   		response.sendRedirect("login");
	   	}else{
	   		out.print("Signup unsuccesful!,Try again");
	   	}
	}

%>
		
		<form class="modal-content" method="post">
			<h2 style="text-align:center">Signup</h2>
					<input type="text" placeholder="Enter Username" name="username" required>
					<input type="password" placeholder="Enter Password" name="password" required>
					<input type="text" placeholder="Enter your Semester" name="sem" required>
					<input type="text" placeholder="Enter your Section" name="sec" required>

					<button type="submit">Signup</button>
					<a href="login">Login</a>
		</form>
	</div>
</body>
</html>