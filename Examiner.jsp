<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Examiner</title>
<link href="result.css" rel="stylesheet" type="text/css">
<style>
.loader {
    border: 16px solid #f3f3f3; /* Light grey */
    border-top: 16px solid #3498db; /* Blue */
    border-radius: 50%;
    width: 80px;
    height: 80px;
    animation: spin 2s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.loader {
 border-top: 16px solid blue;
 border-bottom: 16px solid blue;
}

</style>
<script type="text/javascript">
function b(){
	if(document.f.file.value==""){
		alert('Please upload File');
		return false;
	}
	else{
		document.f.submit();
		document.getElementById("loader1").innerHTML="<div class='main2'><div class='loader main3'></div><div class='main3' style='font-size:2em;vertical-align:middle'>Processing</div>";
		return true;
	}
}
</script>
</head>
<body>
	<div class="header">
		<div class="h00">
			<div class="h01">
				<h2>B. Tech Results</h2>
			</div>
			<div class="h02"><h2>
				<a href="subjectwise.jsp">Subject Wise</a>|
				<a href="examiner.html">Log out</a></h2>
			</div>
		</div>

	</div>
	<br>
	<div class="main0">
		<fieldset>
			<legend class="l1">Examiner</legend>
			<form name="f" action="uploadFile" method="post" enctype="multipart/form-data">
				<div class="main1" id="loader1">

					<div class="main2">
						<div class="main3">File:</div>
						<div class="main3">
							<input type="file" title="file" name="file" accept=".xlsx,.xls">
						</div>
					</div>
					<div class="main2">
						<div class="main3">Year/Sem:</div>
						<div class="main3">
							<select name="year" id="year" title="year">
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
						<div class="main4">
							<input type="submit" value="Upload" onclick="return b()">
						</div>
					</div>
				</div>
			</form>
		</fieldset>
	</div>
</body>
</html>