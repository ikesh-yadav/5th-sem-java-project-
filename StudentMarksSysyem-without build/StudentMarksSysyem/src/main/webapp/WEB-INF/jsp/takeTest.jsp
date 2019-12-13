<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.*" %>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/common.css">
<title>Take test</title>

</head>
<body>
<div style ="background-color: rgb(0, 0, 51);font-size:0px;">
 	  <div style="font-size: 30px;width: 100%;text-align: center;color:white"><b>Exam</b></div>
 	  <br>
 	  <div style="display:block;width:100%;background-color: rgb(0, 0, 51);visibility: visible;" >
 	    <div id="topNavigation" class="tab" style="width:100%; display: inline-block;background-color:rgba(204, 0, 102, 0.63);color:white">
 	    <div class="test-name" style="display:inline-block;font-size:18px;float:left;">
 	    
<%
	int dur=0;
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_marks_system?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
	Statement stmt = con.createStatement();
	String testName=request.getParameter("test_name");
   	String sql="SELECT * FROM test where test_name='"+testName+"'";
   	ResultSet rs = stmt.executeQuery(sql);
   	while(rs.next()) {
		out.println("TestName:" + rs.getString(1));
		dur=rs.getInt(3);
   	}

%>
		</div>
		<div style="display:inline-block;font-size:18px;float:right;" id="timeRemaining"></div>    
 	    </div>
 	  </div>
 	</div>
   	<script>
   		var t = <%=dur%>*60000; 
	   	var x = setInterval(function() { 
	   	var hours = Math.floor((t%(1000 * 60 * 60 * 24))/(1000 * 60 * 60)); 
	   	var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60)); 
	   	var seconds = Math.floor((t % (1000 * 60)) / 1000); 
	   	document.getElementById("timeRemaining").innerHTML ="Time Remaining:"+ hours + "h " + minutes + "m " + seconds + "s "; 
	   	    if (t < 0) { 
	   	        clearInterval(x); 
	   	        document.getElementById("timeRemaining").innerHTML = "EXPIRED"; 
	   	    }
	   	t-=1000; 
	   	}, 1000); 
		window.onload=function(){ 
			var duration=<%=dur%>
	    	window.setTimeout(function() { document.answersForm.submit(); }, duration*60000 );
		};
	</script>
<%
    sql="SELECT * FROM "+testName+"";
 	rs = stmt.executeQuery(sql);
%>
 	
 	<form action ="evalTest?test_name=<%=testName %>" method = "POST" name="answersForm" id="answersForm">
 		<div class="content" style="border:2px;border-block-color: black">
 		<div id="a" class="tabcontent" style="display: block;">
	      <ol class="questions">  
	  	
 		 <%
			while(rs.next()) {
				String q_name=rs.getString(1);
				out.println("<li><textarea class='questions_ta' rows='4' style='width:100%;border:none;'>" + rs.getString(2)+"</textarea>");
				for(int i=1;i<=4;i++){
					out.print("<label><br><input type='radio' name='"+q_name+"' value="+i+"><textarea class='options' style='width: 70%;'>"+ rs.getString(3)+"</textarea></label>");
				}
				out.print("<br></li>");
			}
		    
		%>
		</ol>
		</div>
 		</div>
 		  <input type="submit" attr="subbtn" onclick="shareData()" value="Submit" />
 		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
 	</form>
</body>
</html>