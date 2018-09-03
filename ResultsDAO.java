package com.ResultsApp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ResultsDAO {
	public static boolean ResultData(ResultBean r) throws Exception {
		Connection conn = Connectionmanager.getConnection();
		String s = "select * from res where htno=? and dob=?";
		PreparedStatement pst = conn.prepareStatement(s);
		pst.setString(1, r.getHtnum());
		pst.setString(2, r.getDob());
		try {
			ResultSet rs = pst.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
