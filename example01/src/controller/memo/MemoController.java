package controller.memo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.MemoDAO;
import model.dto.MemoDTO;


@WebServlet("/memo_servlet/*")
public class MemoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}
	
	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		String path = request.getContextPath();
		String url = request.getRequestURL().toString();
		String page = "/main/main.jsp";
		String pageNumber_;
		String temp ;
		PrintWriter out = response.getWriter();
		MemoDAO dao = new MemoDAO();
		
		pageNumber_ = request.getParameter("pageNumber");
		if(pageNumber_ == null || pageNumber_.trim().equals("")) {
			pageNumber_ = "1";
		}
		
		int pageNumber = Integer.parseInt(pageNumber_);
		
		
		if(url.indexOf("list.do") != -1) {
			
			int pageSize = 10;//한 페이지에 보여질 갯수
			int blockSize = 10;//하단 페이지 번호
			int totalRecord = dao.getTotalRecord();
			int jj = totalRecord - pageSize * (pageNumber - 1);
			int startRecord = pageSize * (pageNumber-1) +1;
			int lastRecord = pageSize * pageNumber;
			
			int totalPage = 0;
			int startPage = 1;
			int lastPage = 1;
			if(totalRecord > 0) {
				totalPage = totalRecord/pageSize + (totalRecord % pageSize == 0 ? 0 : 1);
				startPage = (pageNumber / blockSize - (pageNumber % blockSize != 0 ? 0 : 1)) * blockSize + 1;
				lastPage = startPage + blockSize - 1;
				if(lastPage > totalPage) {
					lastPage = totalPage;
				}
			}
			ArrayList<MemoDTO> list = dao.getList(startRecord, lastRecord);
			request.setAttribute("pageNumber", pageNumber);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("totalRecord", totalRecord);
			request.setAttribute("jj", jj);
			request.setAttribute("startRecord", startRecord);
			request.setAttribute("lastRecord", lastRecord);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("lastPage", lastPage);
			request.setAttribute("list", list);
			
			request.setAttribute("menu_gubun", "memo_list");
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
			
		}else if (url.indexOf("memoProc.do")!= -1) {
			String name = request.getParameter("name");
			String content = request.getParameter("content");
			
			MemoDTO dto = new MemoDTO();
			dto.setName(name);
			dto.setContent(content);
			temp = path + "/memo_servlet/list.do";
			int result = dao.setWrite(dto);
			if(result > 0) {
				
				out.println("<script>");
				out.println("alert('등록성공');");
				out.println("location.href = '" + temp+"'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('등록실패');");
				out.println("location.href = '" + temp+"'");
				out.println("</script>");
			}
		}
	}

}
