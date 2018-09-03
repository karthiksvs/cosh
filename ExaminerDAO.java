package com.ResultsApp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ExaminerDAO {
	public static boolean ExaminerData(ExaminerBean r) throws Exception {
		Connection conn = Connectionmanager.getConnection();
		String s = "select * from examiner_login where loginid=? and password=?";
		PreparedStatement pst = conn.prepareStatement(s);
		pst.setString(1, r.getLoginid());
		pst.setString(2, r.getPassword());
		try {
			ResultSet rs = pst.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
