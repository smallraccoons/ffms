/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2019-04-23 13:01:32 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.pages;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class tradeManage_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/common/Head.jsp", Long.valueOf(1499241501534L));
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
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
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body style=\"margin: 1px;\">\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("scripts/boot.js\"></script>\r\n");
      out.write("\t<div class=\"mini-toolbar\" style=\"border-bottom: 0; padding: 0px;\">\r\n");
      out.write("\t\t<table>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td style=\"width: 15%;\"><a class=\"mini-button\"\r\n");
      out.write("\t\t\t\t\ticonCls=\"icon-add\" onclick=\"openTradeAddDialog()\" plain=\"true\">添加</a>\r\n");
      out.write("\t\t\t\t\t<a class=\"mini-button\" iconCls=\"icon-edit\"\r\n");
      out.write("\t\t\t\t\tonclick=\"openTradeModifyDialog()\" plain=\"true\">修改</a> <a\r\n");
      out.write("\t\t\t\t\tclass=\"mini-button\" iconCls=\"icon-remove\" onclick=\"removeRow()\"\r\n");
      out.write("\t\t\t\t\tplain=\"true\">删除</a></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td style=\"width: 85%;\" style=\"white-space: nowrap;\">\r\n");
      out.write("\t\t\t\t\t<div id=\"form\">\r\n");
      out.write("\t\t\t\t\t\t股票名称： <select id=\"sharesname_search\" name=\"sharesname_search\"\r\n");
      out.write("\t\t\t\t\t\temptyText=\"请选择\" class=\"mini-combobox\" value=''>\r\n");
      out.write("\t\t\t\t\t\t\t<option value=\"\"></option>\r\n");
      out.write("\t\t\t\t\t\t\t");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</select> 交易类型：<input showNullItem=\"true\" class=\"mini-combobox\"\r\n");
      out.write("\t\t\t\t\t\t\temptyText=\"请选择\" url=\"data/tradeType.txt\" textField=\"text\"\r\n");
      out.write("\t\t\t\t\t\t\tvalueField=\"id\" id=\"dataid_search\" />交易起止时间：<input\r\n");
      out.write("\t\t\t\t\t\t\tid=\"starttime_search\" class=\"mini-datepicker\"\r\n");
      out.write("\t\t\t\t\t\t\tdateformat=\" yyyy-MM-dd HH:mm:ss\" /> ~<input id=\"endtime_search\"\r\n");
      out.write("\t\t\t\t\t\t\tclass=\"mini-datepicker\" dateformat=\"yyyy-MM-dd HH:mm:ss\" /> <a\r\n");
      out.write("\t\t\t\t\t\t\tclass=\"mini-button\" onclick=\"search()\">搜索</a>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div id=\"datagrid\" class=\"mini-datagrid\"\r\n");
      out.write("\t\turl=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("tradelist.do?roleid=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${currentUser.roleid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("&userid=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${currentUser.id}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\"\r\n");
      out.write("\t\tpageSize=40 sizeList=[10,20,30,40] idField=\"id\" multiSelect=\"true\">\r\n");
      out.write("\t\t<div property=\"columns\">\r\n");
      out.write("\t\t\t<div type=\"checkcolumn\"></div>\r\n");
      out.write("\t\t\t<div field=\"id\" width=\"50\" align=\"center\" sortable=\"true\">编号</div>\r\n");
      out.write("\t\t\t<div field=\"username\" width=\"100\" align=\"center\" sortable=\"true\">记录人</div>\r\n");
      out.write("\t\t\t<div field=\"sharesname\" width=\"100\" align=\"center\" sortable=\"true\">股票名称</div>\r\n");
      out.write("\t\t\t<div field=\"price\" width=\"100\" align=\"center\" sortable=\"true\">单价</div>\r\n");
      out.write("\t\t\t<div field=\"number\" width=\"100\" align=\"center\" sortable=\"true\">数量</div>\r\n");
      out.write("\t\t\t<div field=\"money\" width=\"100\" align=\"center\" sortable=\"true\">金额</div>\r\n");
      out.write("\t\t\t<div field=\"datadicvalue\" width=\"100\" align=\"center\" sortable=\"true\">交易类型</div>\r\n");
      out.write("\t\t\t<div field=\"content\" width=\"100\" align=\"center\" sortable=\"true\">备注</div>\r\n");
      out.write("\t\t\t<div field=\"time\" width=\"100\" align=\"center\" sortable=\"true\">交易时间</div>\r\n");
      out.write("\t\t\t<!-- <th field=\"createtime\" width=\"100\" align=\"center\" sortable=\"true\">创建时间</th>\r\n");
      out.write("\t\t\t\t<th field=\"updatetime\" width=\"100\" align=\"center\" sortable=\"true\">修改时间</th> -->\r\n");
      out.write("\t\t\t<!-- \t\t\t\t<div name=\"action\" headerAlign=\"center\">查看</div> -->\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tmini.parse();\r\n");
      out.write("\t\tvar grid = mini.get(\"datagrid\");\r\n");
      out.write("\t\tgrid.load({\r\n");
      out.write("\t\t\t\"sharesname\" : mini.get(\"sharesname_search\").value,\r\n");
      out.write("\t\t\t\"dataid\" : mini.get(\"dataid_search\").value,\r\n");
      out.write("\t\t\t\"starttime\" : mini.get(\"starttime_search\").getFormValue(),\r\n");
      out.write("\t\t\t\"endtime\" : mini.get(\"endtime_search\").getFormValue()\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\tgrid\r\n");
      out.write("\t\t\t\t.on(\r\n");
      out.write("\t\t\t\t\t\t\"drawcell\",\r\n");
      out.write("\t\t\t\t\t\tfunction(e) {\r\n");
      out.write("\t\t\t\t\t\t\tvar record = e.record, column = e.column, field = e.field, value = e.value;\r\n");
      out.write("\t\t\t\t\t\t\tif (column.name == \"action\") {\r\n");
      out.write("\t\t\t\t\t\t\t\te.cellStyle = \"text-align:center\";\r\n");
      out.write("\t\t\t\t\t\t\t\te.cellHtml = '<a  href=\"javascript:openIncomeFindDialog(\\''\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t+ record.id + '\\')\">查看</a>&nbsp; '\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t\tfunction search() {\r\n");
      out.write("\t\t\tvar s_starttime = mini.get(\"starttime_search\").getFormValue();\r\n");
      out.write("\t\t\tvar s_endtime = mini.get(\"endtime_search\").getFormValue();\r\n");
      out.write("\t\t\tif ((s_starttime != \"\") && (s_endtime != \"\")\r\n");
      out.write("\t\t\t\t\t&& (s_starttime > s_endtime)) {\r\n");
      out.write("\t\t\t\tmini.alert(\"起始时间不能大于截止时间！\");\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tgrid.load({\r\n");
      out.write("\t\t\t\t\"sharesname\" : mini.get(\"sharesname_search\").value,\r\n");
      out.write("\t\t\t\t\"dataid\" : mini.get(\"dataid_search\").value,\r\n");
      out.write("\t\t\t\t\"starttime\" : mini.get(\"starttime_search\").getFormValue(),\r\n");
      out.write("\t\t\t\t\"endtime\" : mini.get(\"endtime_search\").getFormValue()\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tfunction removeRow() {\r\n");
      out.write("\t\t\tvar rows = mini.get(\"datagrid\").getSelecteds();\r\n");
      out.write("\t\t\tif (rows.length > 0) {\r\n");
      out.write("\t\t\t\tif (confirm(\"确定删除选中记录？\")) {\r\n");
      out.write("\t\t\t\t\tvar strIds = [];\r\n");
      out.write("\t\t\t\t\tfor (var i = 0; i < rows.length; i++) {\r\n");
      out.write("\t\t\t\t\t\tstrIds.push(rows[i].id);\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\tvar ids = strIds.join(',');\r\n");
      out.write("\t\t\t\t\tgrid.loading(\"操作中，请稍后......\");\r\n");
      out.write("\t\t\t\t\t$\r\n");
      out.write("\t\t\t\t\t\t\t.ajax({\r\n");
      out.write("\t\t\t\t\t\t\t\ttype : 'post',\r\n");
      out.write("\t\t\t\t\t\t\t\turl : 'tradedelete.do',\r\n");
      out.write("\t\t\t\t\t\t\t\tdataType : 'json',\r\n");
      out.write("\t\t\t\t\t\t\t\tdata : {\r\n");
      out.write("\t\t\t\t\t\t\t\t\tids : ids\r\n");
      out.write("\t\t\t\t\t\t\t\t},\r\n");
      out.write("\t\t\t\t\t\t\t\tsuccess : function(text) {\r\n");
      out.write("\t\t\t\t\t\t\t\t\tgrid\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t.reload({\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\"sharesname\" : mini\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t.get(\"sharesname_search\").value,\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\"dataid\" : mini\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t.get(\"dataid_search\").value,\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\"starttime\" : mini.get(\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\"starttime_search\")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t.getFormValue(),\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\"endtime\" : mini.get(\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\"endtime_search\")\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t.getFormValue()\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\t\t\t},\r\n");
      out.write("\t\t\t\t\t\t\t\terror : function() {\r\n");
      out.write("\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t} else {\r\n");
      out.write("\t\t\t\talert(\"请选中一条记录\");\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tfunction openTradeAddDialog() {\r\n");
      out.write("\t\t\tmini.open({\r\n");
      out.write("\t\t\t\ttargetWindow : window,\r\n");
      out.write("\t\t\t\turl : \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("tradeadd.do\",\r\n");
      out.write("\t\t\t\ttitle : \"新增记录\",\r\n");
      out.write("\t\t\t\twidth : 600,\r\n");
      out.write("\t\t\t\theight : 450,\r\n");
      out.write("\t\t\t\tshowMaxButton : false,\r\n");
      out.write("\t\t\t\tshowCloseButton : true,\r\n");
      out.write("\t\t\t\tloadOnRefresh : false,\r\n");
      out.write("\t\t\t\tonload : function() {\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\tondestroy : function(action) {\r\n");
      out.write("\t\t\t\t\tgrid.reload();\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\tfunction openTradeModifyDialog() {\r\n");
      out.write("\t\t\tvar rows = mini.get(\"datagrid\").getSelecteds();\r\n");
      out.write("\t\t\tif (rows.length != 1) {\r\n");
      out.write("\t\t\t\tmini.alert(\"请选择一条要编辑的数据！\");\r\n");
      out.write("\t\t\t\treturn;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tvar row = rows[0];\r\n");
      out.write("\t\t\tmini.open({\r\n");
      out.write("\t\t\t\ttargetWindow : window,\r\n");
      out.write("\t\t\t\turl : \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("tradeedit.do\",\r\n");
      out.write("\t\t\t\ttitle : \"修改记录\",\r\n");
      out.write("\t\t\t\twidth : 600,\r\n");
      out.write("\t\t\t\theight : 450,\r\n");
      out.write("\t\t\t\tshowMaxButton : false,\r\n");
      out.write("\t\t\t\tshowCloseButton : true,\r\n");
      out.write("\t\t\t\tloadOnRefresh : false,\r\n");
      out.write("\t\t\t\tonload : function() {\r\n");
      out.write("\t\t\t\t\tvar iframe = this.getIFrameEl();\r\n");
      out.write("\t\t\t\t\tvar data = {\r\n");
      out.write("\t\t\t\t\t\taction : \"edit\",\r\n");
      out.write("\t\t\t\t\t\tsharesid : row.sharesid,\r\n");
      out.write("\t\t\t\t\t\tdataid : row.dataid,\r\n");
      out.write("\t\t\t\t\t\tprice : row.price,\r\n");
      out.write("\t\t\t\t\t\tsecuritypassward : row.securitypassward,\r\n");
      out.write("\t\t\t\t\t\tnumber : row.number,\r\n");
      out.write("\t\t\t\t\t\ttime : row.time,\r\n");
      out.write("\t\t\t\t\t\tcontent : row.content,\r\n");
      out.write("\t\t\t\t\t\tid : row.id\r\n");
      out.write("\t\t\t\t\t};\r\n");
      out.write("\t\t\t\t\tiframe.contentWindow.SetData(data);\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\tondestroy : function(action) {\r\n");
      out.write("\t\t\t\t\tgrid.reload();\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t}\r\n");
      out.write("\t</script>\r\n");
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

  private boolean _jspx_meth_c_005fforEach_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f0.setParent(null);
    // /WEB-INF/pages/tradeManage.jsp(29,7) name = items type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setItems(new org.apache.jasper.el.JspValueExpression("/WEB-INF/pages/tradeManage.jsp(29,7) '${allShares }'",_el_expressionfactory.createValueExpression(_jspx_page_context.getELContext(),"${allShares }",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
    // /WEB-INF/pages/tradeManage.jsp(29,7) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setVar("allShare");
    int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
      if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t\t\t\t\t<option value=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${allShare.sharesname }", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write('"');
          out.write('>');
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${allShare.sharesname}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
          out.write("</option>\r\n");
          out.write("\t\t\t\t\t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f0.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f0);
    }
    return false;
  }
}
