package com.ResultsApp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ResultServlet")
public class ResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");

		ResultBean r = new ResultBean();
		r.setHtnum(req.getParameter("htn"));
		r.setDob(req.getParameter("dob"));
		String s=r.getDob();
		String[] sa=s.split("-");
		s=sa[2]+"-"+sa[1]+"-"+sa[0];
		System.out.println(s);
		r.setDob(s);
		r.setYear(req.getParameter("year"));
			try {
			if (ResultsDAO.ResultData(r)) {
				req.getRequestDispatcher("Success.jsp").include(req, res);
			} else {
				res.getWriter().println("May be");
				req.getRequestDispatcher("Failure.html").include(req, res);
				res.getWriter().println(s);
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
