package com.finance.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finance.entity.Datadic;
import com.finance.entity.Income;
import com.finance.entity.PageBean;
import com.finance.entity.Role;
import com.finance.entity.User;
import com.finance.service.DatadicService;
import com.finance.service.IncomeService;
import com.finance.service.UserService;
import com.finance.util.Constants;
import com.finance.util.ResponseUtil;
import com.finance.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 收入Controller层
 * 
 * @author cc
 *
 */
@Controller
public class IncomeController
{
	@Resource
	private IncomeService incomeService;
	@Resource
	private DatadicService datadicService;
	@Resource
	private UserService userService;

	@InitBinder
	public void initBinder(WebDataBinder binder)
	{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); // true:允许输入空值，false:不能为空值
	}

	/**
	 * 收入信息管理页面
	 */
	@RequestMapping("/incomeManage.do")
	public String incomeManage(ModelMap map, HttpServletRequest request)
	{
		List<Datadic> list = datadicService.getDatadicIncome();
		map.addAttribute("incomes", list);

		HttpSession session = request.getSession();
		User curuser = (User) session.getAttribute(Constants.currentUserSessionKey);
		Map<String, Object> userMap = new HashMap<String, Object>();
		userMap.put("userid", curuser.getId());
		userMap.put("roleid", curuser.getRoleid());
		List<User> userlist = userService.getAllUser(userMap);
		map.addAttribute("allUsers", userlist);
		return "incomeManage";
	}

	/**
	 * 查询用户收入集合
	 * 
	 * @param page
	 * @param rows
	 * @param s_income
	 * @param response
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("/incomelist.do")
//	public String list(@RequestParam(value = "page", required = false) String page,
//			@RequestParam(value = "rows", required = false) String rows, Income s_income, HttpServletResponse response)
//			throws Exception
//	{
//		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("incomer", StringUtil.formatLike(s_income.getIncomer()));
//		map.put("source", StringUtil.formatLike(s_income.getSource()));
//		map.put("dataid", s_income.getDataid());
//		map.put("starttime", s_income.getStarttime());
//		map.put("endtime", s_income.getEndtime());
//		map.put("roleid", s_income.getRoleid());
//		map.put("userid", s_income.getUserid());
//		map.put("start", pageBean.getStart());
//		map.put("size", pageBean.getPageSize());
//		List<Income> incomeList = incomeService.findIncome(map);
//		Long total = incomeService.getTotalIncome(map);
//		JSONObject result = new JSONObject();
//		JSONArray jsonArray = JSONArray.fromObject(incomeList);
//		result.put("rows", jsonArray);
//		result.put("total", total);
//		ResponseUtil.write(response, result);
//		return null;
//	}

	@ResponseBody
	@RequestMapping("/incomelist.do")
	public String list2(@RequestParam(value = "pageIndex", required = false) String pageIndex,
			@RequestParam(value = "pageSize", required = false) String pageSize,
			@RequestParam(value = "sortField", required = false) String sortField,
			@RequestParam(value = "sortOrder", required = false) String sortOrder, Income s_income,
			HttpServletResponse response) throws Exception
	{
		int page = Integer.parseInt(pageIndex) + 1;
		PageBean pageBean = new PageBean(page, Integer.parseInt(pageSize));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("incomer", StringUtil.formatLike(s_income.getIncomer()));
		map.put("source", StringUtil.formatLike(s_income.getSource()));
		map.put("dataid", s_income.getDataid());
		map.put("starttime", s_income.getStarttime());
		map.put("endtime", s_income.getEndtime());
		map.put("roleid", s_income.getRoleid());
		map.put("userid", s_income.getUserid());
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Income> incomeList = incomeService.findIncome(map);
		int total = incomeService.getTotalIncome(map).intValue();
		// JSONArray jsonArray = JSONArray.fromObject(incomeList);
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("total", total);
		jsonobj.put("data", incomeList);
		response.setContentType("text/html;charset=UTF-8");
		ResponseUtil.write(response, jsonobj);
		return null;
	}

	/**
	 * 添加与修改用户
	 * 
	 * @param income
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/incomesave.do")
	public String save(Income income, HttpServletResponse response) throws Exception
	{
		int resultTotal = 0; // 操作的记录条数
		JSONObject result = new JSONObject();

		if (income.getId() == null)
		{
			resultTotal = incomeService.addIncome(income);
		} else
		{
			resultTotal = incomeService.updateIncome(income);
		}

		if (resultTotal > 0)
		{ // 执行成功
			result.put("errres", true);
			result.put("errmsg", "数据保存成功！");
		} else
		{
			result.put("errres", false);
			result.put("errmsg", "数据保存失败");
		}
		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * 删除用户
	 * 
	 * @param ids
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/incomedelete.do")
	public String delete(@RequestParam(value = "ids") String ids, HttpServletResponse response) throws Exception
	{
		JSONObject result = new JSONObject();
		String[] idsStr = ids.split(",");
		for (int i = 0; i < idsStr.length; i++)
		{
			incomeService.deleteIncome(Integer.parseInt(idsStr[i]));
		}
		result.put("errres", true);
		result.put("errmsg", "数据删除成功！");
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/incomeadd.do")
	public String incomeadd(ModelMap map, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User curuser = (User)session.getAttribute(Constants.currentUserSessionKey);
		Map<String, Object> userMap = new HashMap<String, Object>();
		userMap.put("userid", curuser.getId());
		userMap.put("roleid", curuser.getRoleid());
		List<User> userlist = userService.getAllUser(userMap);
		map.addAttribute("allUsers", userlist);
		return "incomeadd";
	}
	@RequestMapping("/incomeedit.do")
	public String incomeedit(ModelMap map, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User curuser = (User)session.getAttribute(Constants.currentUserSessionKey);
		Map<String, Object> userMap = new HashMap<String, Object>();
		userMap.put("userid", curuser.getId());
		userMap.put("roleid", curuser.getRoleid());
		List<User> userlist = userService.getAllUser(userMap);
		map.addAttribute("allUsers", userlist);
		return "incomeedit";
	}

}
