package LapTrinhWeb.SpringBoot.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Autowired
	private AdminInterceptor adminInterceptor;

	// Tắt SitemeshConfig vĩnh viễn - gây lỗi mapping
	// @Bean
	// public FilterRegistrationBean<SitemeshConfig> siteMeshFilter() {
	// 	FilterRegistrationBean<SitemeshConfig> filterRegistrationBean = new FilterRegistrationBean<>();
	// 	filterRegistrationBean.setFilter(new SitemeshConfig());
	// 	filterRegistrationBean.addUrlPatterns("/*");
	// 	filterRegistrationBean.setOrder(2);
	// 	return filterRegistrationBean;
	// }

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(adminInterceptor);
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// Cấu hình để serve ảnh từ thư mục uploads
		registry.addResourceHandler("/images/**")
				.addResourceLocations("classpath:/static/images/", "file:src/main/resources/static/images/");
	}
}
