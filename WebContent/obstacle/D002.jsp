<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.obstacle.*"%>
<%@ page import="kr.co.mycom.member.MemberDTO"%>
<%@ page import="kr.co.mycom.member.MemberDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.mycom.asset.*"%>
<%@ page import="kr.co.mycom.code.*"%>


<%
	//response.setContentType("text/html; charset=EUC-KR");

	String my_id = (String) session.getAttribute("ID");
	String my_name = (String) session.getAttribute("NAME");
	String master=(String) session.getAttribute("Master");
	String bgcolor="";
	MemberDAO memDao = new MemberDAO();
	MemberDTO memberInfo = memDao.searchMember(my_id);

	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("�α������� ������ ������ �� �����ϴ�.");
			history.back();
			</script>
		<%
	}
	//���翬���� ���� ���ϴ� �κ�
	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
	String time_in = dayTime.format(new Date(time)); //�ð����� ��� ���
	String[] arrTime_in = time_in.split("-");
	int year = Integer.parseInt(arrTime_in[0]);
	int month = Integer.parseInt(arrTime_in[1]);

	int day = Integer.parseInt(arrTime_in[2]);
	String selected = "selected = 'selected'";
	String checked = "checked = 'checked'";
	String disabled = "disabled = 'disabled'";
	/////////////////////////////////////////////////////////////////////////////////////////
	//�μ� DB���� �ҷ��ͼ� �ѷ��ִ� �κ� DTO,DAO���

	String a_company = request.getParameter("a_company");
	String a_place = request.getParameter("a_place");
	String a_dept = request.getParameter("a_dept");
	
	if (a_company == null) {
		a_company = memberInfo.getM_company();
	}
	if (a_place == null) {
		a_place = memberInfo.getM_place();
	}
	if (a_dept == null) {
		a_dept = memberInfo.getM_dept();
	}
	
	// �����
	if (master.equals("0") == true) {
		a_company = memberInfo.getM_company();
		a_place = memberInfo.getM_place();
		a_dept = memberInfo.getM_dept();
	}
	// Engineer
	else if (master.equals("2") == true) {
		a_company = memberInfo.getM_company();
	}
	
	ObstacleDAO dao = new ObstacleDAO(); //DAO�ʱ�ȭ
	AssetDAO Adao = new AssetDAO(); //DAO�ʱ�ȭ
	List<ObstacleDTO> deptList = dao.searchCode(); //�μ���ȸ
	List<ObstacleDTO> O_List = dao.searchO_Code(); //��з� ��ȸ
	//����� DAO,DTO �μ���ȸ, ��з� ��ȸ 
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	//�˻��� ��¥ �κ� 
	String StartYear = request.getParameter("ComboStartyear");
	String EndYear = request.getParameter("ComboEndyear");
	String StartMonth = request.getParameter("ComboStartmonth");
	String EndMonth = request.getParameter("ComboEndmonth");
	if (StartYear == null){
		if(year<10) StartYear = "0"+Integer.toString(year);
		else StartYear = Integer.toString(year);
	}
	if (EndYear == null){
		if(year<10) EndYear = "0"+Integer.toString(year);
		else EndYear = Integer.toString(year);
	}
	if (StartMonth == null){
		if(month<10) StartMonth = "0"+Integer.toString(month);
		else StartMonth = Integer.toString(month);
	}
	if (EndMonth == null){
		if(month<10) EndMonth = "0"+Integer.toString(month);
		else EndMonth = Integer.toString(month);
	}
	String SearchStartDay = StartYear + StartMonth;
	String SearchEndDay = EndYear + EndMonth;
	//�˻���ȸ�� ����//����Ⱓ ���ϱ� 
	//���� ��ֵ��/��ֻ��� ����Ʈ ��ȸ 
	String ComboGrade = request.getParameter("ComboGrade");
	String Radiostatus = request.getParameter("Radiostatus");
	if (ComboGrade == null)
		ComboGrade = "L1_000";
	
	if (Radiostatus == null)
		Radiostatus = "S_00000";
	String O_rnum = request.getParameter("O_rnum"); //�Ϸù�ȣ 
	if (O_rnum == null)
		O_rnum = "";

	String O_name = request.getParameter("O_name"); //��û��
	//String toEUCKR = new String(Encoding.getBytes(),"euc-kr");

	//String O_name = new String(request.getParameter("O_name").getBytes(), "EUC-KR");
	// ������� ��츸 �̸� �޾ƿ�
	if (O_name == null) {
		if (master.equals("0") == true) O_name = my_name;
		else O_name = "";
	}

	////////////////////////////////////////////////////////////////////////////////////////
	String SelectedO_List = request.getParameter("comboO_List");
	if (SelectedO_List == null)
		SelectedO_List = "O1_0000";

	ObstacleDAO O_dao = new ObstacleDAO(); //DAO�ʱ�ȭ
	List<ObstacleDTO> O_Search = O_dao.getSearch(SearchStartDay,
			SearchEndDay, ComboGrade, Radiostatus, a_company, a_place,
			a_dept, SelectedO_List, O_rnum, O_name); //��з� ��ȸ

	
	List<AssetDTO> m_code1_lists = Adao.search_mcode1();
	List<AssetDTO> m_code2_lists = Adao.search_mcode2();
	List<AssetDTO> m_code3_lists = Adao.search_mcode3();
	
	CodeDAO codeDao = new CodeDAO();
	List<CodeDTO> lCode1List = codeDao.getLCode1List();

	String readOnly = "readOnly = 'readOnly'";
%>
<script type="text/javascript">

function excel_post()
{
	var frm=D002;
	frm.action = 'obstacle/D002_excel.jsp';
	frm.submit();
	frm.action = './masterpage.jsp?bo_table=D002';
}

function select_mcode2(){
	var selectValue = document.getElementById("a_place");
	 selectValue.length = 0;  //��λ���
		
	    var csr_code1 = document.getElementById("a_company");
		var selected_csr_code1 = csr_code1.options(csr_code1.selectedIndex).value;

	
		var i=0;
		var option;
		if(csr_code1.value=="C_00000"||csr_code1.value==null){
			 option=new Option('��ü����', 'P_00000');
			option.selected = true;
		}
		else{
			 option=new Option('��ü����', 'P_00000');
		}
		  selectValue.options[i] = option;
		  i++;
		<%for (AssetDTO m_code2_obj : m_code2_lists) {%>
			if(selected_csr_code1 == '<%=m_code2_obj.getM_code1()%>'){
			var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
			if('<%=m_code2_obj.getM_code2()%>' == '<%=a_place%>'){
				option.selected = true;
			}
				selectValue.options[i] = option;
				i++;
			}	
		<%}%>
		select_mcode3();
}

function select_mcode3(){
	 var selectValue = document.getElementById("a_dept");
	   selectValue.length = 0;  //��λ���
		
	   var csr_code2 = document.getElementById("a_place");
		var selected_csr_code2 = csr_code2.options(csr_code2.selectedIndex).value;

		var i=0;
		var option;
		if(selectValue=="P_00000"||selectValue==null){
			option=new Option('��ü����', 'D_00000');
			option.selected = true;
		}
		else{
			option=new Option('��ü����', 'D_00000');
		}
		  selectValue.options[i] = option;
		  i++;
		<%for (AssetDTO m_code3_obj : m_code3_lists) {%>
		if(selected_csr_code2 == '<%=m_code3_obj.getM_code1()%>'){
				var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				if('<%=m_code3_obj.getM_code2()%>' == '<%=a_dept%>'){
					option.selected = true;
				} 
				selectValue.options[i] = option;
				  i++;
			}
		<%}%>
	}

function select_lcode1() {
	var selectValue = document.getElementById("ComboGrade");

	    var o_code1 = document.getElementById("a_company");
		var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

		var i=0;
		var option;
		if(o_code1=="C_00000" || o_code1==null){
			 option=new Option('��ü����', 'L1_000');
			option.selected = true;
		}
		else{
			 option=new Option('��ü����', 'L1_000');
		}
		 selectValue.options[i] = option;
		 i++;
		<% for(CodeDTO obj : lCode1List) { %>
		    if(selected_o_code1 == '<%=obj.getL_company()%>') {
			var option=new Option('<%=obj.getL_name()%>', '<%=obj.getL_code1()%>');
			
			<%
			if(ComboGrade.equals(obj.getL_code1()))
			{
			%>
			
			option.selected = true;
			
			<%
			}
			%>
			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
}
function DayCheck(){
	if (document.D002.ComboStartyear.value > document.D002.ComboEndyear.value) { // �˻�������
		alert("��ȸ �Ⱓ�� �ٽ� �����Ͽ� �ֽʽÿ� ");
		return false;
	}else if((document.D002.ComboStartyear.value == document.D002.ComboEndyear.value) && (document.D002.ComboStartmonth.value > document.D002.ComboEndmonth.value)){
		alert("��ȸ �Ⱓ�� �ٽ� �����Ͽ� �ֽʽÿ� ");
		return false;
	}
	else{
		return true;
	}
}
function showDetail(o_rnum){ //�˾�â ���°�
	var address = null;
	
	if ('<%=memberInfo.getM_master()%>' == "0") {
		address = './obstacle/D003.jsp?o_rnum=';
	}
	else {
		address = './obstacle/D003_admin.jsp?o_rnum=';
	}
	
	window.open(address+o_rnum, "pop", "width=1000,height=700,history=no,status=no,scrollbars=yes,menubar=no");
}
function initialize(){
	location.href ="./masterpage.jsp?bo_table=D002";
}

</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="common.css" />
</head>
<body onload="select_mcode2(); select_lcode1();">
<form name="D002" action="./masterpage.jsp?bo_table=D002" method="post"
	onsubmit="return DayCheck()">
<table width="95%" align="center">
	<tr>
		<td align="left">�� ��ְ������� �� �����ġ��Ȳ</td>
		<td align="right">
		<input type="button" value="�ʱ�ȭ" onclick=initialize();	style="width: 100px; height: 30px; font-family: Gothic; font-size: 9pt"></input>
		<input type="submit" value="��ȸ" style="width: 100px; height: 30px; font-family: Gothic; font-size: 9pt"></input>
		<input type="button" value="�ٿ�ε�" style="width: 100px; height: 30px; font-family: Gothic; font-size: 9pt;" onclick="javascript:excel_post()"></input></td>
	</tr>
</table>
<table>
	<tr>
		<td style="height: 30px"></td>
	</tr>
</table>
<table width="95%" align="center" border="0" cellspacing="1"
	bgcolor="000000">
	<tr>
		<td align="center" valign="middle" class="01black_bold"
			bgcolor="#A7A9AC" width="10%"><font color="white">�߻�����</font></td>
		<td align="center" colspan="3" valign="middle" bgcolor="#ffffff" width="40%">
		<!-- ////////////////////////////////////�߻����� �޺��ڽ� ���� 0128///////////////////////////// -->
		<select id="ComboStartyear" name="ComboStartyear"
			style="width: 15%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = year - 5; i <= year + 5; i++) {
					if (StartYear == "") {
			%>
			<option value=<%=i%> <%=((year == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%>
			<option value=<%=i%>
				<%=((Integer.parseInt(StartYear) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}
			%>
			<%
				}
			%>
		</select>�� &nbsp; <select id="ComboStartmonth" name="ComboStartmonth"
			style="width: 10%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = 1; i <= 12; i++) {
						if (i < 10) {
			%>
			<option value=<%="0" + i%> <%=((Integer.parseInt(StartMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%><option value=<%=i%> <%=((Integer.parseInt(StartMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}
				}
			%>
		</select>�� &nbsp; ~ &nbsp; <select id="ComboEndyear" name="ComboEndyear"
			onchange=yearChange()
			style="width: 15%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = year - 5; i <= year + 5; i++) {
					if (EndYear == "") {
			%>
			<option value=<%=i%> <%=((year == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%>
			<option value=<%=i%>
				<%=((Integer.parseInt(EndYear) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}
			%>
			<%
				}
			%>
		</select>�� &nbsp; <select id="ComboEndmonth" name="ComboEndmonth"
			style="width: 10%; font-family: Gothic; font-size: 9pt">
			<%
				for (int i = 1; i <= 12; i++) {
						if (i < 10) {
			%>
			<option value=<%="0" + i%> <%=((Integer.parseInt(EndMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				} else {
			%><option value=<%=i%> <%=((Integer.parseInt(EndMonth) == i) == true ? selected : "")%>><%=i%></option>
			<%
				}}
			%>
		</select>��</td>
		
	</tr>
	<tr>
		<!-- ////////////////////////////////////��ֻ��� ������ư0128///////////////////////////// -->
		<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ֻ���</font></td>
		<td align="center" valign="middle" bgcolor="ffffff">
		<select id="Radiostatus" name="Radiostatus" style="width: 99%; font-family: Gothic; font-size: 9pt">
		<option value="S_00000" <%=((Radiostatus.equals("S_00000")) == true ? selected : "")%>>��ü����</option>
		<option value="0" <%=((Radiostatus.equals("0")) == true ? selected : "")%>>��û</option>
		<option value="1" <%=((Radiostatus.equals("1")) == true ? selected : "")%>>�ذ���</option>
		<option value="2" <%=((Radiostatus.equals("2")) == true ? selected : "")%>>�ذ�</option>
		<option value="3" <%=((Radiostatus.equals("3")) == true ? selected : "")%>>����</option>
		</select></td>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ȸ��</font></td>
		<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
		<select id="a_company" name="a_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2(); select_lcode1();" 
			<%=(master.equals("1") == false ? disabled : "")%>>
			<option value="C_00000">��ü����</option>
			<%
				for (AssetDTO m_code1_obj : m_code1_lists) {
			%>
			<option value=<%=m_code1_obj.getM_code1() %> <%=( a_company.equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_name()%></option>
			<%
				}
			%>
		</select></td>
	</tr>
	<tr>
		<td align="center" valign="middle" class="01black_bold"
			bgcolor="#A7A9AC" width="10%"><font color="white">��ֵ��</font></td>
		<td align="center" valign="middle" bgcolor="ffffff" width="40%">
	 	<select name="ComboGrade" id="ComboGrade" style="width: 99%; font-family: Gothic; font-size: 9pt">
		</select></td>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����</font></td>
		<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
		<select id="a_place" name="a_place" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3();" 
			<%=(master.equals("1") == false ? disabled : "")%>>
			<option value="P_00000">��ü����</option>
			<%
				for (AssetDTO m_code2_obj : m_code2_lists) {
			%>
			<option value=<%=m_code2_obj.getM_code2() %> <%=( a_place.equals(m_code2_obj.getM_code2()) == true ? selected : "") %>><%=m_code2_obj.getM_name()%></option>
			<%
				}
			%>
		</select></td>
	</tr>
	<tr>
		<!-- ////////////////////////////////////��з� �޺��ڽ�0128///////////////////////////// -->
		<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��з�</font></td>
		<td align="center" valign="middle" bgcolor="ffffff"><select id="comboO_List" name="comboO_List"
			style="width: 99%; font-family: Gothic; font-size: 9pt">
			<option value="O1_0000" selected>��ü����</option>
			<%
				for (ObstacleDTO obj : O_List) {
					if (obj.getO_code1().equals("O1_0000") == false) {
			%>
			<option value=<%=obj.getO_code1()%> <%=(SelectedO_List.equals(obj.getO_code1()) == true ? selected : "")%>><%=obj.getO_name()%></option>
			<%
				}
				}
			%>
		</select></td>
		<td width="10%" align="center" valign="middle" class="01black_bold"
			bgcolor="#A7A9AC"><font color="white">�μ�</font></td>
		<td align="center" valign="middle" bgcolor="ffffff" class="01black_bold"><select id="a_dept" name="a_dept"
			style="width: 100%; font-family: Gothic; font-size: 9pt" 
			<%=(master.equals("1") == false ? disabled : "")%>>
			<option value="D_00000">��ü����</option>
			<%
				for (AssetDTO m_code3_obj : m_code3_lists) {
			%>
			<option value=<%=m_code3_obj.getM_code1() %> <%=( a_dept.equals(m_code3_obj.getM_code1()) == true ? selected : "") %>><%=m_code3_obj.getM_name()%></option>
			<%
				}
			%>
		</select></td>
		
	</tr>
	<tr>
		<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ֽ�û��</font></td>
		<td align="center" valign="middle" bgcolor="ffffff">
		<input type="text" name="O_name" value='<%=O_name %>'style="width: 98%; font-family: Gothic; font-size: 9pt" <%=(master.equals("0") == true ? readOnly : "")%>></td>
		<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">������ȣ</font></td>
		<td align="center" valign="middle" bgcolor="ffffff" font-family: Gothic>
		<input type="text" name="O_rnum" value='<%=O_rnum %>'style="width: 98%; font-family: Gothic; font-size: 9pt"></td>
	</tr>
</table>
<table>
	<tr>
		<td style="height: 30px"></td>
	<tr><td><%= O_Search.size()%>���� �ڷᰡ �˻��Ǿ����ϴ�.</td></tr>
	</tr>
</table>
<table width="95%" align="center" border="0" cellspacing="1"
	bgcolor="000000">
	<tr height="24" bgcolor="#A7A9AC">
		<td align="center" class="01black_bold"><font color="white">������ȣ</font></td>
		<td align="center" class="01black_bold"><font color="white">����</font></td>
		<td align="center" class="01black_bold"><font color="white">�μ�</font></td>
		<td align="center" class="01black_bold"><font color="white">�ڻ��ȣ(���)</font></td>
		<td align="center" class="01black_bold"><font color="white">�߻���/�ð�</font></td>
		<td align="center" class="01black_bold"><font color="white">��û�ð�</font></td>
		<td align="center" class="01black_bold"><font color="white">�����</font></td>
		<td align="center" class="01black_bold"><font color="white">����ڿ���ó</font></td>
		<td align="center" class="01black_bold"><font color="white">�����ð�</font></td>
		<td align="center" class="01black_bold"><font color="white">�ذ�ð�</font></td>
		<td align="center" class="01black_bold"><font color="white">����ð�</font></td>
		<td align="center" class="01black_bold"><font color="white">���</font></td>
		<td align="center" class="01black_bold"><font color="white">�������</font></td>
	</tr>
	<%
		for (ObstacleDTO obj : O_Search) {
			if(obj.getO_state().equals("��û")){ bgcolor ="#da291c";} 
			else if(obj.getO_state().equals("�ذ���")){ bgcolor ="#daa520";}
			else if(obj.getO_state().equals("�ذ�")){ bgcolor ="#800080";} //
			else{ bgcolor ="#483d8b";}
	%>
	<tr height="24" bgcolor="ffffff"> <!-- �ղٶ� 0213 �߰��Ϸ� -->
		<td align="center" onclick="showDetail('<%=obj.getO_rnum()%>');" class="black"><a href=# class=no-uline><font color="black"><b><%=obj.getO_rnum()%></b></font></a></td>
		<% if((obj.getO_title().length())>5){ %>
		<td align="center" class="black"><%=(obj.getO_title()).substring(0,6)%>..</td>
		<%}else{ %>
		<td align="center" class="black"><%=(obj.getO_title())%></td>
		<%} %>
		<td align="center" class="black"><%=obj.getM_code3_m_name()%></td>
		
		<td align="center" class="black">
		<% 
		if (obj.getA_anum() != null) {
		String[] anumList = obj.getA_anum().split(",");
		String oneAssetStr = null;
		AssetDTO aDto = null;

		for (int i=0; i<anumList.length; i++) {
			oneAssetStr = anumList[i] + "(" + Adao.getAssetName(anumList[i]) + ")"; %>
			<%=oneAssetStr%><br>
		<% } 
		} %>
		</td>

		<%String[] s1 = (obj.getO_occurrencetime()).split(" "); %>
		<td align="center" class="black"><%=s1[0]%><br><%=s1[1]%></td>
		<%String[] s2 = (obj.getO_requesttime()).split(" "); %>
		<td align="center" class="black"><%=s2[0]%><br><%=s2[1]%></td>
		<td align="center" class="black"><%=obj.getA_name()%></td>
		<td align="center" class="black"><%=obj.getA_linenum()%></td>
		<% if(!obj.getO_solvingtime().equals("")){
		  String[] s3 = (obj.getO_solvingtime()).split(" "); %>
		<td align="center" class="black"><%=s3[0]%><br><%=s3[1]%></td>
		<%}else{ %>
		<td align="center" class="black"><%=obj.getO_solvingtime()%></td>
		<%} %>
		<% if(!obj.getO_solvedtime().equals("")){
		  String[] s4 = (obj.getO_solvedtime()).split(" "); %>
		<td align="center" class="black"><%=s4[0]%><br><%=s4[1]%></td>
		<%}else{ %>
		<td align="center" class="black"><%=obj.getO_solvedtime()%></td>
		<%} %>
		
		<% if(!obj.getO_finishtime().equals("")){
		  String[] s5 = (obj.getO_finishtime()).split(" "); %>
		<td align="center" class="black"><%=s5[0]%><br><%=s5[1]%></td>
		<%}else{ %>
		<td align="center" class="black"><%=obj.getO_finishtime()%></td>
		<%} 
		String lcodeName = "";
		for (CodeDTO lcodeObj : lCode1List) {
			if (obj.getO_ograde().equals(lcodeObj.getL_code1())) {
				lcodeName = lcodeObj.getL_name();
				break;
			}
		}
		%>
		<td align="center" class="black"><%=lcodeName%></td>
		<td align="center" class="black" ><font color="<%=bgcolor %>"><b><%=obj.getO_state()%></b></font></td>
	</tr>
	<%
		}
	%>
</table>
<script>
select_mcode2(); select_lcode1();
</script>
</form>
<% if (master.equals("0") == true) { // ����� %>
<input type="hidden" id="a_company" name="a_company" value="<%=memberInfo.getM_company() %>" />
<input type="hidden" id="a_place" name="a_place" value="<%=memberInfo.getM_place() %>" />
<input type="hidden" id="a_dept" name="a_dept" value="<%=memberInfo.getM_dept() %>" />
<% }
	else if (master.equals("2") == true) { // Engineer %>
<input type="hidden" id="a_company" name="a_company" value="<%=memberInfo.getM_company() %>" />
<% } %>
</body>
</html>