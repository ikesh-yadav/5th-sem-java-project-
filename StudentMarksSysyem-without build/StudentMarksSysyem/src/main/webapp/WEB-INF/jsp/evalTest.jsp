<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
            <%@ page import="java.util.*" %>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Test Result</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
</head>
<body>
<table class="answers-list">
<tr><th>question</th><th>your answer</th><th>key</th></tr>

<%
	try{
	ResultSetMetaData md;
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_marks_system?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
	Statement stmt = con.createStatement();
	con.setAutoCommit(false);
	String testName=request.getParameter("test_name");
	String sql="INSERT INTO "+testName+"_answers VALUES ('"+session.getAttribute("loginUser")+"',";
	
   	String sql_to_select="select * FROM "+testName+"_answers where name='key'";
   	ResultSet rs = stmt.executeQuery(sql_to_select);
   	md = rs.getMetaData();
   	int marks=0;
   	int count = md.getColumnCount();
   	HashMap<String,Integer> hm = new HashMap<>();
   	while(rs.next()){
	   	for (int i=2; i<count; i++) {
	   		hm.put(md.getColumnName(i),rs.getInt(i));
	   	}
   	}
    HashMap<String,Integer> question_answer=new HashMap<>();
    for (Map.Entry<String, Integer> entry : hm.entrySet()) {
    		int ans=(request.getParameter(entry.getKey())!=null)?Integer.parseInt(request.getParameter(entry.getKey())):0;
			if(ans==entry.getValue()){
				marks+=1;
			}
			out.print("<tr><td>"+entry.getKey()+"</td><td>"+(request.getParameter(entry.getKey())!=null?request.getParameter(entry.getKey()):0)+"</td><td>"+
			entry.getValue()+"</td></tr>");
    		sql+=((request.getParameter(entry.getKey())!=null)?request.getParameter(entry.getKey()):0)+",";
	}
    
    sql+=marks+");";
    stmt.executeUpdate(sql);
    con.commit();
    out.print("<tr><td colspan='3'>You scored "+marks+" marks</td></tr>");
	}catch(Exception e){}
	%>
	</table>
	<form action='homepage'><input type='submit' class='submitbtn' value='Go Back'/></form>
	<form action='logout'><input type='submit' class="submitbtn" value='Log Out'/></form>
</body>
</html>