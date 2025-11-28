package LapTrinhWeb.SpringBoot.Config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import LapTrinhWeb.SpringBoot.Entity.User;

@Component
public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// Cho phép truy cập các path công khai
		String path = request.getRequestURI();
		
		// Bỏ qua các static resources và error pages
		if (path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/") 
				|| path.startsWith("/static/") || path.startsWith("/error") 
				|| path.startsWith("/favicon.ico") || path.startsWith("/webjars/")) {
			return true;
		}
		
		// Cho phép truy cập các trang công khai
		if (path.equals("/") || path.equals("/login") || path.equals("/register") 
				|| path.equals("/register/save") || path.equals("/home") || path.equals("/logout")
				|| path.equals("/profile") || path.equals("/profile/update")) {
			return true;
		}
		
		// Kiểm tra session cho các path admin
		if (path.startsWith("/admin")) {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("user") == null) {
				response.sendRedirect("/login");
				return false;
			}
			
			User user = (User) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect("/login");
				return false;
			}
			
			// Chỉ admin mới được vào trang admin
			if (user.getAdmin() == null || !user.getAdmin()) {
				response.sendRedirect("/home");
				return false;
			}
		}
		
		return true;
	}
}

