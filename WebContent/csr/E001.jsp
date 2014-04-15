<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%-- <%@ page import="org.apache.log4j.*" %> --%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.member.*"%>
<%@ page import="kr.co.mycom.code.*"%>
<%@ page import="kr.co.mycom.csr.CSRDAO"%>
<%@ page import="kr.co.mycom.csr.CSRDTO"%>

<%
    	String my_id = (String) session.getAttribute("ID");
		String my_name = (String) session.getAttribute("NAME");
		String master = (String) session.getAttribute("Master");
		
	      
		if(my_id == null || my_id.equals("null")){
			%>
				<script type = "text/javascript">
				alert("�α������� ������ ������ �� �����ϴ�.");
				history.back();
				</script>
			<%
		}


        MemberDAO memDao = new MemberDAO();
        MemberDTO memberInfo = memDao.searchMember(my_id);
//        String engineer_company = "";
        
/*         if (master.equals("2") == true) { // Engineer
        	engineer_company = memberInfo.getM_company();
    	} */

     	String selected_company = "";
    	
    	// ������ �ƴ� ��� ������ ȸ�� �⺻ ����.
     	if (master.equals("1") == false) {
     		selected_company = memberInfo.getM_company();
     	}
    	
        long time = System.currentTimeMillis(); 
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String time_in = dayTime.format(new Date(time)); //�ð����� ��� ���
        String[] arrTime_in = time_in.split("-");	
        int curYear = Integer.parseInt(arrTime_in[0]);
        int curMonth = Integer.parseInt(arrTime_in[1]);
        int curDay = Integer.parseInt(arrTime_in[2]);
        int curHour = Integer.parseInt(arrTime_in[3]);
        int curMinute = Integer.parseInt(arrTime_in[4]);
        String str_Date = "  " + curYear + "�� " + curMonth + "�� " + curDay + "��";
        String str_Linenum = memberInfo.getM_linenum();

        CSRDAO csrDao = new CSRDAO();
        List<CSRDTO> csrCode1List = csrDao.getCSRCode1List();
        List<CSRDTO> csrSystemCategoryList = csrDao.getCSRSystemCategoryList();
        

//        Logger logger = Logger.getLogger( this.getClass() ); 
       
        List<CSRDTO> mCode1List = csrDao.getMCode1List();
/*         for(int i = 0 ; i < mCode1List.size(); i++)
        	logger.info(i + "�� ȸ��  : " + mCode1List.get(i).getM_code1_m_name()); */
       
        List<CSRDTO> mCode2List = csrDao.getMCode2List();
/*         for(int i = 0 ; i < mCode2List.size(); i++)
        	logger.info(i + "����� ȸ��  : " + mCode2List.get(i).getM_code2_m_name()); */
       
        List<CSRDTO> mCode3List = csrDao.getMCode3List();
/*         for(int i = 0 ; i < mCode3List.size(); i++)
        	logger.info(i + "�μ�  : " + mCode3List.get(i).getM_code3_m_name()); */
        
        String selected = "selected = 'selected'";
        String readOnly = "readOnly = 'readOnly'";
    	String disabled = "disabled = 'disabled'";
        
        CodeDAO codeDao = new CodeDAO();
    	List<CodeDTO> lCode1List = codeDao.getLCode1List();
    %>

<script type="text/javascript">
function changePlaceOptions() {
	 var selectValue = document.getElementById("select_csr_place");
	 selectValue.length = 0;  //��λ���
		
	    var csr_code1 = document.getElementById("select_csr_member_company");
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
		<% for(CSRDTO obj : mCode2List) { %>
		    if(selected_csr_code1 == '<%=obj.getM_code1()%>') {
			var option=new Option('<%=obj.getM_code2_m_name()%>', '<%=obj.getM_code2()%>');
			if('<%=obj.getM_code2()%>' == '<%=memberInfo.getM_place()%>') {
				option.selected = true;
			}

			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
		changeDeptOptions();
}

function changeDeptOptions(){
   var selectValue = document.getElementById("select_csr_dept");
   selectValue.length = 0;  //��λ���
	
   var csr_code2 = document.getElementById("select_csr_place");
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
	<% for(CSRDTO obj : mCode3List) { %>
	    if(selected_csr_code2 == '<%=obj.getM_code2()%>') {
		var option=new Option('<%=obj.getM_code3_m_name()%>', '<%=obj.getM_code3()%>');
		if('<%=obj.getM_code3()%>' == '<%=memberInfo.getM_dept()%>') {
			option.selected = true;
		}

		selectValue.options[i] = option;		
		i++;
	    }
	<% }%>
}

function check() {	

	if (document.add_csr_form.csr_title.value == "") {
		alert("������ �Է��ϼ���");
		document.add_csr_form.csr_title.focus();
		return false;
	}
	if (document.add_csr_form.select_csr_member_company.value == "C_00000") {
		alert("ȸ�縦 �����ϼ���");
		document.add_csr_form.select_csr_member_company.focus();
		return false;
	}
	if (document.add_csr_form.select_csr_place.value == "P_00000") {
		alert("������� �����ϼ��� ");
		document.add_csr_form.select_csr_place.focus();
		return false;
	}
	if (document.add_csr_form.select_csr_dept.value == "D_00000") {
		alert("�μ��� �����ϼ���");
		document.add_csr_form.select_csr_dept.focus();
		return false;
	}
	if (document.add_csr_form.csr_member_name.value == "") {
		alert("��û������ �Է��ϼ���");
		document.add_csr_form.csr_member_name.focus();
		return false;
	}
	if (document.add_csr_form.csr_detail.value == "") {
		alert("������ �Է��ϼ���");
		document.add_csr_form.csr_detail.focus();
		return false;
	}
	
	if (document.add_csr_form.csr_title.value.length > 100) {
		alert("������ 50�� �̻� �Է��� �� �����ϴ�.");
		document.add_csr_form.csr_title.focus();
		return false;
	}
	if (document.add_csr_form.csr_detail.value.length > 1000) {
		alert("������ 500�� �̻� �Է��� �� �����ϴ�.");
		document.add_csr_form.csr_detail.focus();
		return false;
	}
	if (document.add_csr_form.csr_member_name.value.length > 10) {
		alert("��û������ 5���� �̻� �Է��� �� �����ϴ�.");
		document.add_csr_form.csr_member_name.focus();
		return false;
	}
	
	return true;
}


function goBack() {
	location.href ="./csr/E001.jsp";
}

var count = 0;
var addCount;

// ÷������
function addInputBox() {
	for(var i=1; i<=count; i++) {
		if(!document.getElementsByName("test"+i)[0]) {
			addCount = i;
			break;
		}
	  	else addCount = count;
	}

	var addStr = "<tr><td><input type=checkbox name=checkList value="+addCount+" size='10%'></td><td><input type=file name=test"+addCount+" size='120%'></td></tr>";
	var table = document.getElementById("dynamic_file_table");
	var newRow = table.insertRow();
	var newCell = newRow.insertCell();
	newCell.innerHTML = addStr;

	count++;
}
	 	 
	 
//�����	 
function subtractInputBox() {
	var table = document.getElementById("dynamic_file_table");
	var rows = dynamic_file_table.rows.length;
	var chk = 0;

	if(rows > 0){
		
		// ó���� �� �� ������ٰ� �����Ϸ��� �� �� length undefined.	
		if (document.add_obstacle_form.checkList.length == undefined) {
			if (document.add_obstacle_form.checkList.checked == true) {
				table.deleteRow(0);
				count--;
				chk++;	
			}
		}
		for (var i=0; i<document.add_obstacle_form.checkList.length; i++) {
			if (document.add_obstacle_form.checkList[i].checked == true) {
				table.deleteRow(i);
				i--;
				count--;
				chk++;
			}
		}
		if(chk <= 0){
			alert("������ ���� üũ�� �ּ���.");
		}
	}
	else {
		alert("���̻� ������ �� �����ϴ�.");
	}
}


</script>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="common.css" />
</head>
<body>
<form name="add_csr_form" action="./masterpage.jsp?bo_table=E001_add_user" method="post" enctype="multipart/form-data" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">�� CSR �� CSR���</td>
<td align="right">
<input type="submit" id="btnView" value="���" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt" />
</td></tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
</table>

<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��û��ID</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="csr_member_id" id="csr_member_id" value='<%=my_id %>' style="width: 98%; font-family: Gothic; font-size: 9pt" 
	<%=memberInfo.getM_master().equals("0") == true ? readOnly : "" %>></input>
 
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">ȸ��</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="40%">
<select name="select_csr_member_company" id="select_csr_member_company" onchange="changePlaceOptions();" style="width: 98%; font-family: Gothic; font-size: 9pt"
<%=(master.equals("1") == false ? disabled : "")%>> 
		<option value="C_00000">��ü����</option>
<%
  for (CSRDTO m_code1_obj : mCode1List) { %>
      <option value=<%=m_code1_obj.getM_code1() %> <%=(memberInfo.getM_company().equals(m_code1_obj.getM_code1()) == true ? selected : "") %>><%=m_code1_obj.getM_code1_m_name()%></option>
	<%}%>
</select></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">����</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="40%">
<input type="text" name="csr_title"  style="width: 98%; font-family: Gothic; font-size: 9pt"></input>
</td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_csr_place" id="select_csr_place" onchange="changeDeptOptions();" style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=(master.equals("1") == false ? disabled : "")%>> 
	<option value="P_00000">��ü����</option>
<%	for(CSRDTO m_code2_obj : mCode2List) {%>
		<option value=<%=m_code2_obj.getM_code2() %> <%=(memberInfo.getM_place().equals(m_code2_obj.getM_code2()) == true ? selected : "") %>><%=m_code2_obj.getM_code2_m_name()%></option>
<%}%>
</select>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">CSR����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_csr_code1" id="select_csr_code1" style="width: 98%; font-family: Gothic; font-size: 9pt">
<%
  for (CSRDTO obj : csrCode1List) { %>
      <option value=<%=obj.getCSR_code1() %>><%=obj.getCSR_code1_m_name()%></option>
<%}%>
</select></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�μ�</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select id="select_csr_dept" name="select_csr_dept" style="width: 98%; font-family: Gothic; font-size: 9pt" 
<%=(master.equals("1") == false ? disabled : "")%>> 
	<option value="D_00000">��ü����</option>
<%	for(CSRDTO m_code3_obj : mCode3List) {%>
		<option value=<%=m_code3_obj.getM_code3() %> <%=(memberInfo.getM_dept().equals(m_code3_obj.getM_code3()) == true ? selected : "") %>><%=m_code3_obj.getM_code3_m_name()%></option>
<%}%>
</select>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ý��� ����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_csr_system_category" id="select_csr_system_category" style="width: 98%; font-family: Gothic; font-size: 9pt">
<%
  for (CSRDTO obj : csrSystemCategoryList) { %>
      <option value=<%=obj.getCSR_system_category() %>><%=obj.getCSR_system_category_m_name()%></option>
<%}%>
</select></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��û����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="csr_member_name" id="csr_member_name" value='<%=my_name %>' style="width: 98%; font-family: Gothic; font-size: 9pt" 
	<%=memberInfo.getM_master().equals("0") == true ? readOnly : "" %>></input>
 
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��������</font></td>
<td align="left" valign="middle" bgcolor="ffffff" font-family: Gothic; font-size: 9pt">
<%=str_Date%>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������ó</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="csr_linenum" id="csr_linenum" style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readOnly"
value=<%=str_Linenum%>></input>

</td>

</tr>
<tr height="100px">
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">����</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff">
<textarea id="csr_detail" name="csr_detail" cols="1" rows="3" style="width:98%; height:100px; overflow:auto"></textarea>
</td>
</tr>
<tr>
<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">÷������</font></td>
<td width="90%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold" colspan="3">

<table width="100%" cellpadding=0 cellspacing=0 id="" border="0">
<tr>
 <td width="5%">üũ</td>
 <td width="75%">����</td>
 <td width="10%"><input type="button" value="���� �߰�" onclick="javascript:addInputBox();"></td>
 <td width="10%"><input type="button" value="���� ����" onclick="javascript:subtractInputBox();"></td>
</tr>
<tr>
<table cellpadding=0 cellspacing=0 id="dynamic_file_table" border="0">
</table>
</tr>
</table>
<table>
<tr>
<input type="hidden" name="my_id" id="my_id" value="<%=my_id %>"></input>
<input type="hidden" name="my_company" id="my_company" value="<%=memberInfo.getM_company() %>"></input>
<input type="hidden" name="my_place" id="my_place" value="<%=memberInfo.getM_place() %>"></input>
<input type="hidden" name="my_dept" id="my_dept" value="<%=memberInfo.getM_dept() %>"></input>
<script>
changePlaceOptions();
</script>
</tr>
</table>
<% if (master.equals("2") == true) { // Engineer %>
<input type="hidden" id="select_csr_member_company" name="select_csr_member_company" value="<%=memberInfo.getM_company() %>" />
<% } %>
</form>
</body>
</html>