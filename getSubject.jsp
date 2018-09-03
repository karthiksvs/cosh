<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,com.ResultsApp.*"%>

<%!Connection conn;
	String s;
	PreparedStatement pst;
	ResultSet rs;
	int tm = 0;%>

<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/re", "root", "jo");

	String str=request.getParameter("year");
	
 	s = "select htno from res"+str+"d where branch='"+request.getParameter("branch")+"'";
	System.out.println("branch is "+request.getParameter("branch"));
	PreparedStatement ps=conn.prepareStatement(s);
	rs=ps.executeQuery();
	rs.next();
	System.out.println(str+"next line");
	s = "select subject_code, subject_name from res"+str+" where htno='"+rs.getString(1)+"' group by subject_code";
	pst = conn.prepareStatement(s);
	rs = pst.executeQuery();
	while (rs.next()) {
%>
<option value=<%=rs.getString(1) %>><%=rs.getString(1)+"-"+rs.getString(2)%></option>
<%
	}
%>