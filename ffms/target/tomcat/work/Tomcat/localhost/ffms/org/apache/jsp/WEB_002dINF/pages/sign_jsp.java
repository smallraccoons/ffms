/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2019-04-23 04:42:01 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.pages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class sign_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/common/Head.jsp", Long.valueOf(1499241501534L));
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      out.write('\r');
      out.write('\n');

	String path = request.getContextPath();
	String basePath ="";
	if(request.getServerPort()==80){
		basePath=request.getScheme()+"://"+request.getServerName()+path+"/";
	}else{
		basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	}
	pageContext.setAttribute("basePath", basePath);

      out.write('\r');
      out.write('\n');

	String themeName = "default";
	Cookie cookies[] = request.getCookies();
	if(cookies != null && cookies.length > 0){
		for(int i = 0; i < cookies.length; i++){
			if("themeName".equals(cookies[i].getName())){
				themeName = cookies[i].getValue();
				break;
			}
		}
	}

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("\t<title>家庭理财管理系统登录</title>\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("bootstrap/css/bootstrap.min.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("bootstrap/css/bootstrap-reset.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("bootstrap/css/jquery-ui-1.10.3.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("bootstrap/css/font-awesome.css\">\r\n");
      out.write("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("resource/css/style.css\" />\r\n");
      out.write("</head>\r\n");
      out.write("<body class=\"login-body\">\r\n");
      out.write("    <div class=\"container\">\r\n");
      out.write("\t\t<form class=\"form-signin\">\r\n");
      out.write("\t\t    <div class=\"form-signin-heading text-center\">\r\n");
      out.write("<!-- \t\t        <h1 class=\"sign-title\">注册</h1> -->\r\n");
      out.write("\t\t        <h2 style=\"color:#008CBA;\">家庭理财收支系统</h2>\r\n");
      out.write("\t\t    </div>\r\n");
      out.write("\t\t    <div class=\"login-wrap\">\r\n");
      out.write("\t\t        <input type=\"text\" name=\"username\" id=\"inputUsername\" class=\"form-control\" placeholder=\"请输入用户名\" autofocus>\r\n");
      out.write("           \t\t<input type=\"password\" name=\"password\" id=\"inputPassword\" class=\"form-control\" placeholder=\"请输入密码\">\r\n");
      out.write("\t\t        <input type=\"password\" id=\"surePassword\" class=\"form-control\" placeholder=\"请再次输入密码\">\r\n");
      out.write("\t\t        <button id=\"submitbtn\" class=\"btn btn-lg btn-login btn-block\" type=\"button\">\r\n");
      out.write("\t\t            <i class=\"fa fa-check\"></i> <span style=\"font-size:25px;\">注册</span>\r\n");
      out.write("\t\t        </button>\r\n");
      out.write("\t\t        <h4 style=\"text-align:center;line-height:40px;\">已有账号？<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("index.do\">返回登录</a></h4>\r\n");
      out.write("\t\t    </div>\r\n");
      out.write("\t\t</form>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t<!-- Modal -->\r\n");
      out.write("        <div aria-hidden=\"true\" aria-labelledby=\"myModalLabel\" role=\"dialog\" tabindex=\"-1\" id=\"myModal\" class=\"modal fade\">\r\n");
      out.write("            <div class=\"modal-dialog\">\r\n");
      out.write("                <div class=\"modal-content\">\r\n");
      out.write("                    <div class=\"modal-header\">\r\n");
      out.write("                        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\r\n");
      out.write("                        <h4 class=\"modal-title\">提示您</h4>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"modal-body\">\r\n");
      out.write("                        <h4 id=\"messageshow\"></h4>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"modal-footer\">\r\n");
      out.write("                        <button data-dismiss=\"modal\" class=\"btn btn-success\" type=\"button\">确定</button>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    <!-- modal -->\r\n");
      out.write("\t\t\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("jquery-easyui-1.3.3/jquery.min.js\"></script>\r\n");
      out.write("\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("bootstrap/js/bootstrap.min.js\"></script>\r\n");
      out.write("\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("bootstrap/js/modernizr.min.js\"></script>\r\n");
      out.write("\t\t<script>\r\n");
      out.write("\t\t\t$(function(){\r\n");
      out.write("\t\t\t\t$(\"#submitbtn\").click(function(){\r\n");
      out.write("\t\t    \t\tvar inputUsername = $(\"#inputUsername\").val();\r\n");
      out.write("\t\t    \t\tvar inputPassword = $(\"#inputPassword\").val();\r\n");
      out.write("\t\t    \t\tvar surePassword = $(\"#surePassword\").val();\r\n");
      out.write("\t\t\t\t\tif(inputUsername==null||inputUsername==\"\"){\r\n");
      out.write("\t\t    \t\t\t$(\"#messageshow\").html(\"请输入用户名！\");\r\n");
      out.write("\t\t    \t\t\t$(\"#myModal\").modal(\"show\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#myModal\").on(\"hidden.bs.modal\", function (e) {\r\n");
      out.write("\t\t\t\t\t\t  \t$(\"#inputUsername\").focus();\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\treturn false;\r\n");
      out.write("\t\t    \t\t}else if(inputPassword==null||inputPassword==\"\"){\r\n");
      out.write("\t\t    \t\t\t$(\"#messageshow\").html(\"请输入密码！\");\r\n");
      out.write("\t\t    \t\t\t$(\"#myModal\").modal(\"show\");\r\n");
      out.write("\t\t\t\t\t\t$('#myModal').on(\"hidden.bs.modal\", function (e) {\r\n");
      out.write("\t\t\t\t\t\t  \t$(\"#inputPassword\").focus();\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\treturn false;\r\n");
      out.write("\t\t    \t\t}else if(surePassword!=inputPassword){\r\n");
      out.write("\t\t    \t\t\t$(\"#messageshow\").html(\"两次密码输入不一致！\");\r\n");
      out.write("\t\t    \t\t\t$(\"#myModal\").modal(\"show\");\r\n");
      out.write("\t\t\t\t\t\t$('#myModal').on(\"hidden.bs.modal\", function (e) {\r\n");
      out.write("\t\t\t\t\t\t  \t$(\"#surePassword\").focus();\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\treturn false;\r\n");
      out.write("\t\t    \t\t}else{\r\n");
      out.write("\t\t    \t\t\t$.ajax({\r\n");
      out.write("\t\t\t\t\t\t\turl:\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("gosign.do\",\r\n");
      out.write("\t\t\t\t\t\t\ttype:\"post\",\r\n");
      out.write("\t\t\t\t\t\t\tdataType:\"text\",\r\n");
      out.write("\t\t\t\t\t\t\tdata:{\"username\":inputUsername,\"password\":inputPassword,\"roleid\":2},\r\n");
      out.write("\t\t\t\t\t\t\tsuccess:function(data){\r\n");
      out.write("\t\t\t\t\t\t\t\tvar result=eval('('+data+')');\r\n");
      out.write("\t\t\t\t\t\t\t\tif(result.errres){\r\n");
      out.write("\t\t\t\t\t\t\t\t\t$(\"#messageshow\").html(result.errmsg);\r\n");
      out.write("\t\t\t\t\t    \t\t\t$(\"#myModal\").modal(\"show\");\r\n");
      out.write("\t\t\t\t\t    \t\t\t$(\"#myModal\").on(\"hidden.bs.modal\", function (e) {\r\n");
      out.write("\t\t\t\t\t    \t\t\t\twindow.location.href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("index.do\";\r\n");
      out.write("\t\t\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t            \t\t$(\"#messageshow\").html(result.errmsg);\r\n");
      out.write("\t\t\t\t\t    \t\t\t$(\"#myModal\").modal(\"show\");\r\n");
      out.write("\t\t\t\t\t    \t\t\t$(\"#myModal\").on(\"hidden.bs.modal\", function (e) {\r\n");
      out.write("\t\t\t\t\t\t\t\t\t  \t$(\"#\"+result.inputfocus).focus();\r\n");
      out.write("\t\t\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t    \t\t\t});\r\n");
      out.write("\t\t\t\t    }\r\n");
      out.write("\t\t    \t});\r\n");
      out.write("\t\t    \t\r\n");
      out.write("\t\t\t\t$(document).keydown(function(event){ \r\n");
      out.write("\t\t\t\t\tif(event.keyCode == 13){\r\n");
      out.write("\t\t\t\t\t\tevent.preventDefault();\r\n");
      out.write("\t\t\t\t\t\t$(\"#submitbtn\").click();\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t});\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t    </script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
