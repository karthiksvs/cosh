<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.*,com.ResultsApp.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Subject wise Results</title>
<link href="result.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function call() {
		try {
			xmlHttp = new XMLHttpRequest();
		} catch (e1) {
			try {
				xmlHttp = new ActiveObject("Microsoft.XMLHTTP");
			} catch (e2) {
				try {
					xmlHttp = new ActiveObject("Msxm12.XMLHTTP");
				} catch (e3) {
					alert('AJAX not Supported!');
					return false;
				}
			}
		}
		var year = document.getElementById("year").value;

		var branch=document.getElementById("branch").value;
		xmlHttp.open("GET", "getSubject.jsp?year=" + year+"&branch="+branch,true);
		
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.status == 200) {
				document.getElementById("sc").innerHTML = xmlHttp.responseText;
							}
			
		};
		xmlHttp.send();
	}
	function check() {
		if (document.f.sc.value.length == 0) {
			alert("fill subject codes!");
			return false;
		}

		return true;
	}
	function fun() {
		if (check())
			subject();
	}
	function subject(){	try {
		xmlHttp = new XMLHttpRequest();
	} catch (e1) {
		try {
			xmlHttp = new ActiveObject("Microsoft.XMLHTTP");
		} catch (e2) {
			try {
				xmlHttp = new ActiveObject("Msxm12.XMLHTTP");
			} catch (e3) {
				alert('AJAX not Supported!');
				return false;
			}
		}
	}
	var year = document.getElementById("year").value;
	var sc = document.getElementById("sc").value;
	var pf = document.getElementById("pf").value;
	console.log(year);
	xmlHttp.open("GET", "getSubjectResult.jsp?year=" + year+"&sc="+sc+"&pf="+pf,true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.status == 200) {
			document.getElementById("res").innerHTML = xmlHttp.responseText;
			}
			};
	xmlHttp.send();
	}
</script>
<style type="text/css">
table {
	text-align: center;
}
</style>
</head>
<body>
	<div class="header">
		<div class="h00">
			<div class="h01">
				<h2>B. Tech Results</h2>
			</div>
			<div class="h02">
				<h2>
					<a href="result.html">Home</a>| <a href="result.html">Log out</a>
				</h2>
			</div>
		</div>
	</div>
	<br>
	<div class="main0">
		<fieldset>
			<legend class="l1">Subject Results</legend>
			<form name="f" action="ResultServlet">
				<div class="main1">
					<div class="main2">
						<div class="main3">Year/Sem:</div>
						<div class="main3">
							<select name="year" id="year" onchange="call()">
								<option value="11">1-1</option>
								<option value="12">1-2</option>
								<option value="21">2-1</option>
								<option value="22">2-2</option>
								<option value="31">3-1</option>
								<option value="32">3-2</option>
								<option value="41">4-1</option>
								<option value="42">4-2</option>
							</select>
						</div>
					</div>
					<div class="main2">
						<div class="main3">Branch:</div>
						<div class="main3">
							<select name="branch" id="branch" onchange="call()">
								<option value="CSE">CSE</option>
								<option value="IT">IT</option>
								<option value="ECE">ECE</option>
								<option value="EEE">EEE</option>
								<option value="MECH">MECH</option>
								<option value="OTHER">OTHER</option>
							</select>
						</div>
					</div>

					<div class="main2">
						<div class="main3">Subject Code:</div>
						<div class="main3">
							<select name="sc" id="sc">
								<%!Connection conn;
	String s;
	PreparedStatement pst;
	ResultSet rs;
	int tm = 0;%>

								<%
									Class.forName("com.mysql.jdbc.Driver").newInstance();
									conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/re", "root", "jo");
									s = "select subject_code, subject_name from res11 group by subject_code";
									pst = conn.prepareStatement(s);
									rs = pst.executeQuery();
									while (rs.next()) {
								%>
								<option><%=rs.getString(1) + "-" + rs.getString(2)%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<div class="main2">
						<div class="main3">Pass/Fail:</div>
						<div class="main3">
							<select name="y" id="pf" title="year">
								<option value="0">Pass</option>
								<option value="1">Fail</option>
								<option value="2">All</option>
							</select>
						</div>
					</div>
					<div class="main2">
						<div class="main4">
							<input type="button" value="Get Result" onclick="fun()">
						</div>
					</div>
				</div>
			</form>
		</fieldset>
	</div>
	<div name="res" id="res" class=""></div>
</body>
</html>