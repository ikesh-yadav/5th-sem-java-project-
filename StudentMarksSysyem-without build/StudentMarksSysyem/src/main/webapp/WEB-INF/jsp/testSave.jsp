<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="jquery.js"></script>
<link rel="stylesheet" type="text/css" href="css/common.css">
<title>Save test</title>
<%
try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_marks_system?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
	Statement stmt = con.createStatement();
	
	String testName=request.getParameter("testName");
	String testSDate=request.getParameter("testSDate");
	String testEDate=request.getParameter("testEDate");
	String testDuration=request.getParameter("testDuration");
	String testSem=request.getParameter("testSem");
	String testSec=request.getParameter("testSec");
	con.setAutoCommit(false);
	String sql="INSERT INTO test(`test_name`, `duration`, `start_date`, `end_date`, `creator_name`, `sem`, `sec`) VALUES('"+testName+"',"+testDuration+",'"+testSDate+"','"+testEDate+"','"+(String)session.getAttribute("loginUser")+"',"+testSem+",'"+testSec+"');";
	String sql_create_answers="create table "+testName+"_answers(name varchar(30) primary key,";
	String sql_insert_answers="Insert "+testName+"_answers values('key',";
	stmt.executeUpdate(sql);
	sql="create table "+testName+" (qname varchar(20),question varchar(100),o1 varchar(50),o2 varchar(50),o3 varchar(50),o4 varchar(50),Answer int);";
	stmt.executeUpdate(sql);
	PreparedStatement ps = con.prepareStatement("INSERT INTO "+testName+" VALUES (?, ?, ?, ?, ?,?,?)");
	/*taking the key which was set by the makeTest.php page*/
    String str = request.getParameter("elements");
    /*obtaing the question:key from the string that was sent from the makeTest page*/
    String values=str.substring(1,str.length()-1);

    String[] elements = values.split(",");
    HashMap<String,Integer> hm = new HashMap<>();
    for(int i=0;i<elements.length;i++){
        String[] list = elements[i].split(":");
        String key=list[0].substring(1,list[0].length()-1);
        String value=list[1];
        hm.put(key,Integer.parseInt(value));
    }
    HashMap<String,Integer> question_answer=new HashMap<>();
    for (Map.Entry<String, Integer> entry : hm.entrySet()) {
    	for(int i=1;i<=entry.getValue();i++){
    		ps.setString(1,entry.getKey()+"_q_"+i);
    		sql_create_answers+=entry.getKey()+"_q_"+i+" int,";
    		ps.setString(2,request.getParameter(entry.getKey()+"_qu_"+i));
    		for(int j=1;j<=4;j++){
    			ps.setString(j+2,request.getParameter(entry.getKey()+"_qo_"+i+j));
    		}
    		ps.setInt(7,Integer.parseInt(request.getParameter(entry.getKey()+"_q_"+i)));
    		sql_insert_answers+=request.getParameter(entry.getKey()+"_q_"+i)+",";
    		ps.executeUpdate();
    	}
	}
    sql_create_answers+="marks int)";
    sql_insert_answers+="0)";
	stmt.executeUpdate(sql_create_answers);
	stmt.executeUpdate(sql_insert_answers);
	out.print("<h2>Test created</h2>");
	con.commit();
}catch(Exception e){e.printStackTrace();}
%>
</head>
<body>
<br>
<a href='homepage' class="linkbtn">homepage</a>
<a href='logout' class="linkbtn">logout</a>

</body>
</html>