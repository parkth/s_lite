<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.obstacle.*"%>
<%@page import="kr.co.mycom.security.CheckSecurity"%>
<%@ page import="kr.co.mycom.code.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File "%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String master = (String) session.getAttribute("Master");

if(master.equals("0")){
	%>
		<script type = "text/javascript">
		alert("�����ڰ� �ƴϸ� ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
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

	String O_rnum=request.getParameter("o_rnum");
	CheckSecurity checkSecurity = new CheckSecurity(); 
	ObstacleDAO O_dao=new ObstacleDAO(); //DAO�ʱ�ȭ
	ObstacleDTO O_Search = O_dao.getData(O_rnum);
	ObstacleDTO personInChargeInfo = O_dao.getPersonInChargeInfo(O_rnum);
	String ALineNum = personInChargeInfo.getA_linenum();
	String[] arrLineNum = null;
	
	String allAssetStr = "";
	String [] assetNumberList = O_Search.getA_anum().split(",");
	String [] assetNameList = O_Search.getO_a_name().split(",");
	String delimiter = ",";
	
	for (int i=0; i<assetNumberList.length; i++) {
		
		if (allAssetStr == "") delimiter = "";
		else delimiter = ",";
		
		if (!assetNumberList[i].equals("")) {
			allAssetStr += delimiter + assetNameList[i] + "/" + assetNumberList[i] ;
		}
	}
	
	List<ObstacleDTO> obsCode1List = O_dao.getOCode1List();
	List<ObstacleDTO> obsCode2List = O_dao.getOCode2List();
	List<ObstacleDTO> mCode1List = O_dao.getMCode1List();
	List<ObstacleDTO> mCode2List = O_dao.getMCode2List();
	List<ObstacleDTO> mCode3List = O_dao.getMCode3List();
	List<ObstacleDTO> aNameList = O_dao.getANameList();
	
	CodeDAO codeDao = new CodeDAO();
	List<CodeDTO> lCode1List = codeDao.getLCode1List();
	
	String occur_time = O_Search.getO_occurrencetime();
	int occurYear = Integer.parseInt(occur_time.substring(0, 4));
	int occurMonth = Integer.parseInt(occur_time.substring(5, 7));
	int occurDay = Integer.parseInt(occur_time.substring(8, 10));
	int occurHour = Integer.parseInt(occur_time.substring(11, 13));
	int occurMinute = Integer.parseInt(occur_time.substring(14, 16));
	
	String selected = "selected = 'selected'";
	String checked = "checked = 'checked'";
%>

<script type="text/javascript">


function change(isRequest){
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	if (isRequest == 1) {
		selectedYear = document.getElementById("req_year_detail");
		selectedMonth = document.getElementById("req_month_detail");
		selectObject=document.getElementById("req_day_detail");
	}
	else {
		selectedYear = document.getElementById("occur_year_detail");	
		selectedMonth = document.getElementById("occur_month_detail");	
		selectObject=document.getElementById("occur_day_detail");
	}

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //��¥ �ʱ�ȭ
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();

	var compYear;
	var compMonth;
	var compDay;

	if (isRequest) {
		compYear = <%=curYear%>;
		compMonth = <%=curMonth%>;
		compDay = <%=curDay%>;
	}
	else {
		compYear = <%=occurYear%>;
		compMonth = <%=occurMonth%>;
		compDay = <%=occurDay%>;
	}

	for (var i=1; i<=lastDay; i++) {
		if(i<10){
			var option=new Option(i,"0"+(i));}
		else 
			var option=new Option(i,i);
		
		// ���� ��,��,���� ��ġ�ϴ� ��쿡�� ��¥�� ���� �Ϸ� ����. ���̳� �� �ٲٸ� 1���� �⺻ ��.
		if((i==compDay) && (selectedMonthValue==compMonth) && (selectedYearValue==compYear)){		
			option.selected=true;
		 }
		selectObject.options[i-1] = option; // index�� 0���� ����.
	}
}

function changeCode2OptionsDetail(){
    var selectValue = document.getElementById("select_o_detail_code2");
    selectValue.length = 0;  //��λ���
	
    var o_code1 = document.getElementById("select_o_detail_code1");
	var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

	var i=0;
	<% for(ObstacleDTO obj : obsCode2List) { %>
	    if(selected_o_code1 == '<%=obj.getO_code1()%>') {
		    if ('<%=obj.getO_code2()%>' == '<%=O_Search.getO_code2() %>') {
		var option=new Option('<%=obj.getCode2_m_name()%>', '<%=obj.getO_code2()%>', true, true);
		    }
		    else {
		var option=new Option('<%=obj.getCode2_m_name()%>', '<%=obj.getO_code2()%>');
		    }
		selectValue.options[i] = option;
		i++;
	    }
	<% }%>
}

function changePlaceOptionsDetail(isUser){
	var selectValue = null;
	var o_code1 = null;
	var compCode2 = null;

	if (isUser) {
		selectValue = document.getElementById("select_o_detail_place");
		o_code1 = document.getElementById("select_o_detail_member_company");
		compCode2 = '<%=O_Search.getM_code2() %>';
	}
	else {
		selectValue = document.getElementById("select_o_detail_place_in_charge");
		o_code1 = document.getElementById("select_o_detail_member_company_in_charge");
		compCode2 = '<%=personInChargeInfo.getM_code2() %>';
	}

    selectValue.length = 0;  //��λ���
	
	var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

	var i=0;
	<% for(ObstacleDTO obj : mCode2List) { %>
	    if(selected_o_code1 == '<%=obj.getM_code1()%>') {
	    	var option=new Option('<%=obj.getM_code2_m_name()%>', '<%=obj.getM_code2()%>');
			if('<%=obj.getM_code2()%>' == compCode2) {
				option.selected = true;
			}
			
			selectValue.options[i] = option;
			i++;
	    }
	<% }%>

	if (isUser) changeDeptOptionsDetail(1);
	else changeDeptOptionsDetail(0);
}

function changeDeptOptionsDetail(isUser){
	var selectValue = null;
	var o_code2 = null;
	var compCode3 = null;

	if (isUser) {
		selectValue = document.getElementById("select_o_detail_dept");
		o_code2 = document.getElementById("select_o_detail_place");
		compCode3 = '<%=O_Search.getM_code3() %>';
	}
	else {
		selectValue = document.getElementById("select_o_detail_dept_in_charge");
		o_code2 = document.getElementById("select_o_detail_place_in_charge");
		compCode3 = '<%=personInChargeInfo.getM_code3() %>';
	}
    
    selectValue.length = 0;  //��λ���
	var selected_o_code2 = o_code2.options(o_code2.selectedIndex).value;

	var i=0;
	<% for(ObstacleDTO obj : mCode3List) { %>
	    if(selected_o_code2 == '<%=obj.getM_code2()%>') {
		    if ('<%=obj.getM_code3()%>' == compCode3) {
		var option=new Option('<%=obj.getM_code3_m_name()%>', '<%=obj.getM_code3()%>', true, true);
		    }
		    else {
		var option=new Option('<%=obj.getM_code3_m_name()%>', '<%=obj.getM_code3()%>');
		    }
		selectValue.options[i] = option;
		i++;
	    }
	<% }%>

	if (isUser == 0) changeANameOptionsDetail();
}

function changeGradeOptionsDetail() {
	 var selectValue = document.getElementById("select_o_detail_grade");
	 selectValue.length = 0;  //��λ���
		
	    var o_code1 = document.getElementById("select_o_detail_member_company");
		var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

		var i=0;

		var i=0;
		<% for(CodeDTO obj : lCode1List) { %>
		    if(selected_o_code1 == '<%=obj.getL_company()%>') {
			var option=new Option('<%=obj.getL_name()%>', '<%=obj.getL_code1()%>');

			selectValue.options[i] = option;		
			i++;
		    }
		<% }%>
}

function changeANameOptionsDetail(){
	
	var selectValue = document.getElementById("select_o_detail_a_id");
	var o_code3 = document.getElementById("select_o_detail_dept_in_charge");

    selectValue.length = 0;  //��λ���
	var selected_o_code3 = o_code3.options(o_code3.selectedIndex).value;

	var option=new Option('������', '������', true, true);
	selectValue.options[0] = option;
	
	var i=1;
	<% for(ObstacleDTO obj : aNameList) { %>
	    if(selected_o_code3 == '<%=obj.getM_code3()%>') {
		    if ('<%=obj.getA_id()%>' == '<%=personInChargeInfo.getA_id()%>') {
		var option=new Option('<%=obj.getA_name()%>', '<%=obj.getA_id()%>', true, true);
		    }
		    else {
		var option=new Option('<%=obj.getA_name()%>', '<%=obj.getA_id()%>');
		    }
		selectValue.options[i] = option;
		i++;
	    }
	<% }%>

	changeALinenum();
}

function changeALinenum() {
	
	var selectValue = document.getElementById("select_o_detail_a_id");
	var o_code3 = document.getElementById("select_o_detail_dept_in_charge");

	var selectPhone1 = document.getElementById("o_detail_member_phone1_in_charge");
	var inputPhone2 = document.getElementById("o_detail_member_phone2_in_charge");
	var inputPhone3 = document.getElementById("o_detail_member_phone3_in_charge");

	// ����� ����ó, �̸� �ʱ�ȭ
	selectPhone1[0].selected = true;
	inputPhone2.value = "";
    inputPhone3.value = "";
    document.getElementById("select_o_detail_a_name").value = "";

	var selected_a_id = selectValue.options(selectValue.selectedIndex).value;
	var selected_o_code3 = o_code3.options(o_code3.selectedIndex).value;
	
	<% for(ObstacleDTO obj : aNameList) { %>
	    if(selected_o_code3 == '<%=obj.getM_code3()%>') {
		    if ('<%=obj.getA_id()%>' == selected_a_id) {
			    <% ALineNum = obj.getA_linenum(); 
			    arrLineNum = ALineNum.split("-");
			    %>
			    for (var i=0; i<selectPhone1.length; i++) {
				    if (selectPhone1[i].value == '<%=arrLineNum[0]%>') {
				    	selectPhone1[i].selected = true;
				    }
			    }
			    inputPhone2.value = '<%=arrLineNum[1]%>';
			    inputPhone3.value = '<%=arrLineNum[2]%>';
		    }
	    }
	<% }%>

	// �̸��� ����
	document.getElementById("select_o_detail_a_name").value = selectValue.options(selectValue.selectedIndex).text;
}

function showAssetList(member_name) {
	var value = document.getElementById("o_detail_asset").value;
	
	window.open("./asset_list.jsp?assetValue="+value, "pop2", "width=800,height=800,history=no,status=no,scrollbars=yes,menubar=no")
}

//0: ��������, 1: ����, 2: �ذ�, 3: ����
function buttonCheck(clickedButton) {
	var detailButton = document.getElementById("o_detail_button");

	if ((clickedButton != 0) && (document.obstacle_detail_form.select_o_detail_a_id.value == '������')) {
		alert("��ִ���ڸ� ������ �ֽʽÿ�.");
		return false;
	}
	
	switch(clickedButton) {
	case 0: // ��������
		detailButton.value = 0;
		break;
	case 1: // ����
		detailButton.value = 1;
		break;
	case 2: // �ذ�
		detailButton.value = 2;
		break;
	case 3: // ����
		detailButton.value = 3;
		break;
	}

	document.obstacle_detail_form.submit();
}

	
var count = 0;
var addCount;

// ÷������
function addInputBoxAdmin() {
	for(var i=1; i<=count; i++) {
		if(!document.getElementsByName("testAdmin"+i)[0]) {
			addCount = i;
			break;
		}
	  	else addCount = count;
	}

	var addStr = "<tr><td><input type=checkbox name=checkListAdmin value="+addCount+" size='10%'></td><td><input type=file name=testAdmin"+addCount+" size='70%'></td></tr>";
	var table = document.getElementById("dynamic_file_table_admin");
	var newRow = table.insertRow();
	var newCell = newRow.insertCell();
	newCell.innerHTML = addStr;

	count++;
}
	 	 
	 
//�����	 
function subtractInputBoxAdmin() {
	var table = document.getElementById("dynamic_file_table_admin");
	var rows = dynamic_file_table_admin.rows.length;
	var chk = 0;
	 
	if(rows > 0){

		// ó���� �� �� ������ٰ� �����Ϸ��� �� �� length undefined.	
		if (document.obstacle_detail_form.checkListAdmin.length == undefined) {
			if (document.obstacle_detail_form.checkListAdmin.checked == true) {
				table.deleteRow(0);
				count--;
				chk++;	
			}
		}
		
		for (var i=0; i<document.obstacle_detail_form.checkListAdmin.length; i++) {
			if (document.obstacle_detail_form.checkListAdmin[i].checked == true) {
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
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body>
	<table>
		<tr>
			<td style="height: 5px"></td>
		</tr>
	</table>
<form name="obstacle_detail_form" action="update_obstacle_detail.jsp" method="post" enctype="multipart/form-data">
<table width="95%" align="center" >
<tr>
<td align="left">�� ��ְ������� �� ��ֻ���Ȳ</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">��Ͻð� �Է�</font></td>
<td align="right" valign="middle" bgcolor="ffffff" width="45%">

<select id="req_year_detail" name="req_year_detail" onchange=change(1) style="width: 20%; font-family: Gothic; font-size: 9pt">
<% for(int i=curYear-10; i<=curYear+10;i++){ %>
<option value=<%=i%> <%=((curYear == i) == true ? selected : "")%>"><%=i%></option>
<%}%></select>��

<select id="req_month_detail" name="req_month_detail" onchange=change(1) style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=12;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
else {%>
<option value=<%=i%> <%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>��

<select id="req_day_detail" name="req_day_detail" style="width: 15%; font-family: Gothic; font-size: 9pt">
</select>��

<select id="req_hour_detail" name="req_hour_detail" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=24;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((curHour == i) == true ? selected : "")%>><%=i%></option>
<% } else { %>
<option value=<%=i%> <%=((curHour == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>��

<select id="req_minute_detail" name="req_minute_detail" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=0; i<60;i+=10){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=(((curMinute >= i) && (curMinute < (i+10))) == true ? selected : "")%>><%="0"+i%></option>
<% } else { %>
<option value=<%=i%> <%=(((curMinute >= i) && (curMinute < (i+10))) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>��

</td>
</tr>
<tr>
<td align="right" colspan="3"><input type="button" value="��������" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="buttonCheck(0)"></input>
				<input type="button" value="����" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="buttonCheck(1)"></input>
				<input type="button" value="�ذ�" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="buttonCheck(2)"></input>
				<input type="button" value="����" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="buttonCheck(3)"></input></td>
</tr>
</table>
	<table>
		<tr>
			<td style="height: 15px"></td>
		</tr>
	</table>
	
<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">����</font></td>
<td align="center" valign="middle" colspan="3" bgcolor="ffffff">
<input type="text" name="o_detail_title" id="o_detail_title" value="<%=checkSecurity.getText(O_Search.getO_title()) %>" style="width: 99%; font-family: Gothic; font-size: 9pt;"></input>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">������ȣ</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="35%">
<input type="text" name="o_detail_rnum" id="o_detail_rnum" value="<%=O_rnum %>" style="width: 99%; font-family: Gothic; font-size: 9pt;" readOnly></input>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">ȸ��</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="35%">
<select name="select_o_detail_member_company" id="select_o_detail_member_company" onchange="changePlaceOptionsDetail(1); changeGradeOptionsDetail();" style="width: 99%; font-family: Gothic; font-size: 9pt"> 
<%
  for (ObstacleDTO obj : mCode1List) { %>
      <option value=<%=obj.getM_code1() %> <%=(obj.getM_code1().equals(O_Search.getM_code1()) == true ? selected : "")%>><%=obj.getM_code1_m_name()%></option>
<%}%>
</select>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��з�</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_detail_code1" id="select_o_detail_code1" onchange=changeCode2OptionsDetail() style="width: 99%; font-family: Gothic; font-size: 9pt">
<%
  for (ObstacleDTO obj : obsCode1List) { %>
      <option value=<%=obj.getO_code1() %> <%=(obj.getO_code1().equals(O_Search.getO_code1()) == true ? selected : "")%>><%=obj.getCode1_m_name()%></option>
<%}%>
</td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_detail_place" id="select_o_detail_place" onchange=changeDeptOptionsDetail(1) style="width: 99%; font-family: Gothic; font-size: 9pt"></select>

</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ߺз�(��������)</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_detail_code2" id="select_o_detail_code2" style="width: 99%; font-family: Gothic; font-size: 9pt"></select></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�μ�</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_detail_dept" id="select_o_detail_dept" style="width: 99%; font-family: Gothic; font-size: 9pt"></select></td>
</tr>
<tr>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">��ֵ��</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="35%">
<select name="select_o_detail_grade" id="select_o_detail_grade" style="width: 99%; font-family: Gothic; font-size: 9pt">
</select>
</td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��û����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_detail_member_name" id="o_detail_member_name" value="<%=O_Search.getMember_name() %>" style="width: 99%; font-family: Gothic; font-size: 9pt;"></input>
</td>
</tr>
<tr>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�������</font></td>
<td align="center" valign="middle" bgcolor="ffffff" >
<input name="o_detail_request_path" id="o_detail_request_path" type="radio" value="��ȭ����" <%=("��ȭ����".equals(O_Search.getO_opath()) == true ? checked : "")%>>��ȭ����
<input name="o_detail_request_path" id="o_detail_request_path" type="radio" value="�¶�������" <%=("�¶�������".equals(O_Search.getO_opath()) == true ? checked : "")%>>�¶�������
<input name="o_detail_request_path" id="o_detail_request_path" type="radio" value="�̸�������" <%=("�̸�������".equals(O_Search.getO_opath()) == true ? checked : "")%>>�̸�������
<input name="o_detail_request_path" id="o_detail_request_path" type="radio" value="����͸�" <%=("����͸�".equals(O_Search.getO_opath()) == true ? checked : "")%>>����͸�</td>
</td>


<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������ó</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<%
String lineNum = O_Search.getO_linenum();
arrLineNum = lineNum.split("-");
%>
<select name="o_detail_member_phone1" id="o_detail_member_phone1" style="width: 45px; font-family: Gothic; font-size: 8pt">
							<option value="010" <%=("010".equals(arrLineNum[0]) == true ? selected : "")%>>010
							<option value="011" <%=("011".equals(arrLineNum[0]) == true ? selected : "")%>>011
							<option value="016" <%=("016".equals(arrLineNum[0]) == true ? selected : "")%>>016
							<option value="017" <%=("017".equals(arrLineNum[0]) == true ? selected : "")%>>017
							<option value="018" <%=("018".equals(arrLineNum[0]) == true ? selected : "")%>>018
							<option value="019" <%=("019".equals(arrLineNum[0]) == true ? selected : "")%>>019
</select>
-<input type="text" name="o_detail_member_phone2" id="o_detail_member_phone2" maxlength="4" value="<%=arrLineNum[1]%>" style="width: 40px; font-family: Gothic; font-size: 9pt;"></input>
-<input type="text" name="o_detail_member_phone3" id="o_detail_member_phone3" maxlength="4" value="<%=arrLineNum[2]%>" style="width: 40px; font-family: Gothic; font-size: 9pt;"></input>
</td>

</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ǰ��</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_detail_asset" id="o_detail_asset" value="<%=allAssetStr %>" style="width: 80%; font-family: Gothic; font-size: 9pt;" readOnly></input>
<input type="button" name="search_asset_button" id="search_asset_button" value="ã��" onclick="showAssetList('<%=O_Search.getMember_name()%>')"></input>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_detail_vendor" id="o_detail_vendor" value="<%=checkSecurity.getText(O_Search.getO_vendorname()) %>" style="width: 99%; font-family: Gothic; font-size: 9pt;"></input>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����ð�</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_detail_req_time" id="o_detail_req_time" value="<%=O_Search.getO_requesttime() %>" style="width: 99%; font-family: Gothic; font-size: 9pt;" readOnly></input>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ֹ߻��ð�</font></td>
<td align="center" valign="middle" bgcolor="ffffff">

<select id="occur_year_detail" name="occur_year_detail" onchange=change(0) style="width: 20%; font-family: Gothic; font-size: 9pt">
<% for(int i=curYear-10; i<=curYear+10;i++){ %>
<option value=<%=i%> <%=((occurYear == i) == true ? selected : "")%>"><%=i%></option>
<%}%></select>��

<select id="occur_month_detail" name="occur_month_detail" onchange=change(0) style="width: 12%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=12;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((occurMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
else {%>
<option value=<%=i%> <%=((occurMonth == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>��

<select id="occur_day_detail" name="occur_day_detail" style="width: 12%; font-family: Gothic; font-size: 9pt">
</select>��

<select id="occur_hour_detail" name="occur_hour_detail" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=1; i<=24;i++){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((occurHour == i) == true ? selected : "")%>><%=i%></option>
<% } else { %>
<option value=<%=i%> <%=((occurHour == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>��

<select id="occur_minute_detail" name="occur_minute_detail" style="width: 15%; font-family: Gothic; font-size: 9pt">
<% for(int i=0; i<60;i+=10){ 
if (i<10) { %>
<option value=<%="0"+i%> <%=((occurMinute == i) == true ? selected : "")%>><%="0"+i%></option>
<% } else { %>
<option value=<%=i%> <%=((occurMinute == i) == true ? selected : "")%>><%=i%></option>
<% }
  }%>
</select>��

</td>
</tr>

<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">÷������(��)</font></td>
<td align="center" valign="middle" colspan="3" bgcolor="ffffff">
<% if (O_Search.getO_attachment() != null && !(O_Search.getO_attachment().equals("")) && !(O_Search.getO_attachment().equals("NULL"))) {
 
 String filePath = O_Search.getO_attachment();
 
 StringTokenizer tokens = new StringTokenizer(filePath, "|");
 File tempFile = null;
 String fileName = null;
 String oneFilePath = null;
 
 while (tokens.hasMoreElements()) {
	 oneFilePath = tokens.nextToken();
	 tempFile = new File(oneFilePath);
	 fileName = tempFile.getName(); %>
<a href="../file_download.jsp?fileName=<%=fileName%>&filePath=<%=oneFilePath%>"><font color="blue"><%=fileName %></font></a>&nbsp;&nbsp;
<a href="../file_delete.jsp?filePath=<%=oneFilePath%>&O_rnum=<%=O_rnum%>&fileFullPath=<%=filePath%>"><font color="blue">����</font></a>&nbsp;&nbsp;
 <% }
 } %>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�������</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff">
<textarea id="o_detail_detail" name="o_detail_detail" cols="1" rows="3" style="width:99%; overflow:auto"><%=checkSecurity.getText(O_Search.getO_detail()) %></textarea>
</td>
</tr>

<tr>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������Ȳ</font></td>
<td align="center" valign="middle" bgcolor="ffffff" colspan="3"><b><%=O_Search.getO_state() %></b></td>
</tr>

<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">����� ȸ��</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="35%">
<select name="select_o_detail_member_company_in_charge" id="select_o_detail_member_company_in_charge" onchange=changePlaceOptionsDetail(0) style="width: 99%; font-family: Gothic; font-size: 9pt"> 
<%
  for (ObstacleDTO obj : mCode1List) { %>
      <option value=<%=obj.getM_code1() %> <%=(obj.getM_code1().equals(personInChargeInfo.getM_code1()) == true ? selected : "")%>><%=obj.getM_code1_m_name()%></option>
<%}%>
</select>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">���������</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<input type="text" name="o_detail_engineer" id="o_detail_engineer" value="<%=O_Search.getO_engineer() %>" style="width: 99%; font-family: Gothic; font-size: 9pt;"></input>
</td>
</tr>

<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">����� �����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_detail_place_in_charge" id="select_o_detail_place_in_charge" onchange=changeDeptOptionsDetail(0) style="width: 99%; font-family: Gothic; font-size: 9pt"></select>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ִ����</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_detail_a_id" id="select_o_detail_a_id" onchange=changeALinenum() style="width: 99%; font-family: Gothic; font-size: 9pt">
</select>
</td>
</tr>

<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">����� �μ�</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<select name="select_o_detail_dept_in_charge" id="select_o_detail_dept_in_charge" onchange="changeANameOptionsDetail()" style="width: 99%; font-family: Gothic; font-size: 9pt"></select></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">����� ����ó</font></td>
<td align="center" valign="middle" bgcolor="ffffff">
<%
if (ALineNum == null || ALineNum.equals("NULL") || ALineNum.equals("")) {
	arrLineNum[0] = "";
	arrLineNum[1] = "";
	arrLineNum[2] = "";
}
else {
	arrLineNum = ALineNum.split("-");
}
%>
<select name="o_detail_member_phone1_in_charge" id="o_detail_member_phone1_in_charge" style="width: 45px; font-family: Gothic; font-size: 8pt">
							<option value="010" <%=("010".equals(arrLineNum[0]) == true ? selected : "")%>>010</option>
							<option value="011" <%=("011".equals(arrLineNum[0]) == true ? selected : "")%>>011</option>
							<option value="016" <%=("016".equals(arrLineNum[0]) == true ? selected : "")%>>016</option>
							<option value="017" <%=("017".equals(arrLineNum[0]) == true ? selected : "")%>>017</option>
							<option value="018" <%=("018".equals(arrLineNum[0]) == true ? selected : "")%>>018</option>
							<option value="019" <%=("019".equals(arrLineNum[0]) == true ? selected : "")%>>019</option>
</select>
-<input type="text" name="o_detail_member_phone2_in_charge" id="o_detail_member_phone2_in_charge" maxlength="4" value="<%=arrLineNum[1]%>" style="width: 40px; font-family: Gothic; font-size: 9pt;"></input>
-<input type="text" name="o_detail_member_phone3_in_charge" id="o_detail_member_phone3_in_charge" maxlength="4" value="<%=arrLineNum[2]%>" style="width: 40px; font-family: Gothic; font-size: 9pt;"></input>
</td>
</tr>

<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">��ֿ���</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff">
<textarea id="o_detail_reason" name="o_detail_reason" cols="1" rows="3" style="width:99%; overflow:auto"><%=checkSecurity.getText(O_Search.getO_reason()) %></textarea>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">�����ġ����</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff">
<textarea id="o_detail_resolvedetail" name="o_detail_resolvedetail" cols="1" rows="3" style="width: 99%; overflow:auto"><%=checkSecurity.getText(O_Search.getO_resolvedetail()) %></textarea>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">������û����</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff">
<textarea id="o_detail_requestdetail" name="o_detail_requestdetail" cols="1" rows="3" style="width: 99%; overflow:auto"><%=checkSecurity.getText(O_Search.getO_requestdetail()) %></textarea>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">÷������(������)</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff" style="width: 99%; font-family: Gothic; font-size: 9pt">

<% if ((O_Search.getO_attachment_engineer() != null) && !(O_Search.getO_attachment_engineer().equals("")) && !(O_Search.getO_attachment_engineer().equals("NULL"))) {

 String filePath = O_Search.getO_attachment_engineer();
 
 StringTokenizer tokens = new StringTokenizer(filePath, "|");
 File tempFile = null;
 String fileName = null;
 String oneFilePath = null;
 
 while (tokens.hasMoreElements()) {
	 oneFilePath = tokens.nextToken();
	 tempFile = new File(oneFilePath);
	 fileName = tempFile.getName(); %>
<a href="../file_download.jsp?fileName=<%=fileName%>&filePath=<%=oneFilePath%>"><font color="blue"><%=fileName %></font></a>&nbsp;&nbsp;
<a href="../file_delete_admin.jsp?filePath=<%=oneFilePath%>&O_rnum=<%=O_rnum%>&fileFullPath=<%=filePath%>"><font color="blue">����</font></a>&nbsp;&nbsp;
 <% }
 } %>
 
<table width="100%" cellpadding=0 cellspacing=0 id="" border="0">
<tr align="center">
 <td width="5%">üũ</td>
 <td width="75%">����</td>
 <td width="10%"><input type="button" value="�� �߰�" onclick="javascript:addInputBoxAdmin();"></td>
 <td width="10%"><input type="button" value="�� ����" onclick="javascript:subtractInputBoxAdmin();"></td>
</tr>
<tr>
<table cellpadding=0 cellspacing=0 id="dynamic_file_table_admin" border="0">
</table>
</tr>
</table> 

<table>
	<tr>
		<td style="height: 10px"></td>
	</tr>
</table>

<table width="95%" align="center">
	<tr>
		<td>
			<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
				<tr>
					<td align="left" colspan="6" bgcolor="ffffff">�� �ش� �ڻ��� �ٸ� ��� ���</td>
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">������ȣ</font></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">������Ȳ</font></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">����</font></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">����ڵ�</font></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">��ǰ��</font></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">��ֹ߻��ð�</font></td>
				</tr>
			</table>		
		</td>
		<td width="13"></td>
		
	</tr>
	<tr>
		<td colspan="3">
			<iframe align="center" id="obstacle_a_num" name="obstacle_a_num" src="D003_iframe.jsp?o_rnum=<%=O_rnum %>" 
			width="95%" height="200" frameborder="0" scrolling="yes"></iframe>
		</td>
	</tr>
</table>

<input type="hidden" id="o_detail_button" name="o_detail_button"></input>
<input type="hidden" id="o_detail_asset_code" name="o_detail_asset_code"></input>
<input type="hidden" id="select_o_detail_a_name" name="select_o_detail_a_name"></input>
<input type="hidden" id="admin_file_path" name="admin_file_path" value='<%=O_Search.getO_attachment_engineer()%>'></input>
<Script>
changeCode2OptionsDetail(); changePlaceOptionsDetail(1); changePlaceOptionsDetail(0); changeGradeOptionsDetail(); change(1); change(0);
</Script>

</form>
</body>
</html>