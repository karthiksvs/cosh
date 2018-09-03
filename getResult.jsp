<%@page language="java" contentType="text/html"%>
<%@page import="java.sql.*,com.ResultsApp.*"%>
<%
	response.setDateHeader("Expires", -1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Results</title>
<link href="result.css" rel="stylesheet" type="text/css">
<style type="text/css">


table{
	background-color: white;
}
</style>
</head>
<body>
	<%!Connection conn;
	String s;
	PreparedStatement pst;
	ResultBean r = new ResultBean();
	ResultSet rs;
	int tm = 0,tc=0;
	%>
	<%
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    	conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/re","root","jo");
			r.setHtnum(request.getParameter("htn"));
		r.setYear(request.getParameter("year"));
		s = "select * from res"+r.getYear()+"d where htno=? ";
		pst = conn.prepareStatement(s);
		pst.setString(1, r.getHtnum());
		rs = pst.executeQuery();
		if (rs.next()) {
	%>
		<%
			tm=rs.getInt(2);
		tc=rs.getInt(3);
			 %>
	<br>
	<br>
	<table border="2" align="center">
		<tr>
			<th>Subject Code</th>
			<th>Subject Name</th>
			<th>Internal Marks</th>
			<th>External Marks</th>
			<th>Total Marks</th>
			<th>Credits</th>
			<th>Pass/Fail</th>
		</tr>
		<%
			s = "select * from res" + r.getYear() + " where htno=?";
				pst = conn.prepareStatement(s);
				pst.setString(1, r.getHtnum());
			rs = pst.executeQuery();
				while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getInt(4)%></td>
			<td><%=rs.getInt(5)%></td>
			<td><%=rs.getInt(6)%></td>
			<td><%=rs.getInt(7)%></td>
			<%if(rs.getInt(7)==0){%>
			<td style="color:red;"><b>Fail</b></td>
			<%}
			else { %>
			<td><b>Pass</b></td>
			<%} %>
		</tr>
		<%} %>
		<tr>
		
			<td  align="center" colspan="4">Total Marks</td>
		
			<td  align="center"><%= tm%></td>
			<td><%= tc %>
		</tr>
	</table>
	<%
				} else {
	%>
	<h1 class="not" style="text-align: center; color: red;">Not Found!</h1>
	<%
		}
	%>
</body>
</html>