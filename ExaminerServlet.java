package com.ResultsApp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ExaminerServlet")
public class ExaminerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");

		ExaminerBean d = new ExaminerBean();
		d.setLoginid(req.getParameter("loginid"));
		d.setPassword(req.getParameter("password"));
		try {
			if (ExaminerDAO.ExaminerData(d)) {
				req.getRequestDispatcher("Examiner.jsp").forward(req, res);
			} else {
				res.getWriter().println("May be");
				req.getRequestDispatcher("Failure.html").include(req, res);
				//res.getWriter().println(s);
				res.getWriter().println("May be");
				System.out.println("OK");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
