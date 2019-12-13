<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd">
 
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Authentication page</title>
  </head>
  <body>
    <c:if test="${ empty param.username or empty param.password}">
      <c:redirect url="login" >
              <c:param name="errMsg" value="Please Enter UserName and Password" />
      </c:redirect>
       
    </c:if>
     
    <c:if test="${not empty param.username and not empty param.password}">
      <s:setDataSource var="ds" driver="com.mysql.cj.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/student_marks_system?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                       user="root" password=""/>
 	<c:choose>
  <c:when test="${empty paramValues.faculty}">
  <s:query dataSource="${ds}" var="selectQ">
        select count(*) as kount from user
        where name='${param.username}'
        and password='${param.password}'
      </s:query>
  	</c:when>
 	<c:otherwise>
 	<s:query dataSource="${ds}" var="selectQ">
        select count(*) as kount from faculty
        where name='${param.username}'
        and password='${param.password}'
      </s:query>
  	</c:otherwise>
	</c:choose>
 
      <c:forEach items="${selectQ.rows}" var="r">
        <c:choose>
          <c:when test="${r.kount gt 0}">
            <c:set scope="session"
                   var="loginUser"
                   value="${param.username}"/>
            <c:set scope="session"
                   var="faculty"
                   value="${not empty paramValues.faculty}"/>
            <c:redirect url="homepage"/>
          </c:when>
          <c:otherwise>
            <c:redirect url="login" >
              <c:param name="errMsg" value="Username/password does not match" />
            </c:redirect>
          </c:otherwise>
        </c:choose>
 
      </c:forEach>
 	<c:otherwise>
  </c:otherwise>
    </c:if>
 
  </body>
</html>>