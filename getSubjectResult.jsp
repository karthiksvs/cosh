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
body {
	
}

table:nth-child(2n) {
	background-color: white;
}
</style>
</head>
<body>
	<%!Connection conn;
	String s;
	PreparedStatement pst;
	ResultSet rs;
	int tm = 0;

	int pf;
	String cond="";
	%>
	<%
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    	conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/re","root","jo");
    	pf=Integer.parseInt(request.getParameter("pf"));
    	if(pf==0) cond=" and credits <> 0";
    	else if(pf==1) cond=" and credits=0";
    	else cond="";
		s = "select * from res"+request.getParameter("year")+" where subject_code= ?"+cond;
		pst = conn.prepareStatement(s);
		pst.setString(1, request.getParameter("sc"));
		pf=Integer.parseInt(request.getParameter("pf"));
		rs = pst.executeQuery();
		if (rs.next()) {
	%>
	<br>
	<br>
	<table border="2" align="center">
		<tr>
			<th>Hall Ticket</th>
			<th>Subject Code</th>
			<th>Subject Name</th>
			<th>Internal Marks</th>
			<th>External Marks</th>
			<th>Total Marks</th>
			<th>Credits</th>
			<th>Pass/Fail</th>
		</tr>
		<%
			s = "select * from res"+request.getParameter("year")+" where subject_code= ?"+cond;
				pst = conn.prepareStatement(s);
				pst.setString(1, request.getParameter("sc"));
				//pst.setString(2, r.getDob());
				rs = pst.executeQuery();
				while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString(1) %></td>
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
	</table>
	
	<%} %>
	<br>
	<br>
		<%
		pst=conn.prepareStatement("select count(*) from res"+request.getParameter("year")+" where subject_code=?");
		pst.setString(1, request.getParameter("sc"));
		rs=pst.executeQuery();
		rs.next();
		int total=rs.getInt(1);
		System.out.println(total);
		pst=conn.prepareStatement("select count(*) from res"+request.getParameter("year")+" where subject_code=? and credits<>0");
		pst.setString(1, request.getParameter("sc"));
		rs=pst.executeQuery();
		rs.next();
	    int pass=rs.getInt(1);
	    System.out.println(pass);
	    out.println("<h1 style='text-align:center'> The pass percentage is "+(pass*100)/total+"%</h1>");
	    %>
</body>
</html>