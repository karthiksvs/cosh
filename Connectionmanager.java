package com.ResultsApp;

	import java.sql.Connection;
	import java.sql.DriverManager;

	public class Connectionmanager {
	    public static Connection getConnection() throws Exception{
	        Class.forName("com.mysql.jdbc.Driver").newInstance();
	        return DriverManager.getConnection("jdbc:mysql://localhost:3306/resu","root","jo");
	    }
	}
	



