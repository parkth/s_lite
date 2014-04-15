<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.csr.CSRDAO"%>
<%@ page import="kr.co.mycom.csr.CSRDTO"%>
<%@page import="kr.co.mycom.security.CheckSecurity"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<%
	String my_id = (String) session.getAttribute("ID");
	String my_name = (String) session.getAttribute("NAME");
	String master=(String) session.getAttribute("Master");
	
	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("�α������� ������ ������ �� �����ϴ�.");
			history.back();
			</script>
		<%
	}

	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat(
			"yyyy-MM-dd-HH-mm-ss");
	String time_in = dayTime.format(new Date(time)); //�ð����� ��� ���
	String[] arrTime_in = time_in.split("-");
	int curYear = Integer.parseInt(arrTime_in[0]);
	int curMonth = Integer.parseInt(arrTime_in[1]);
	int curDay = Integer.parseInt(arrTime_in[2]);
	int curHour = Integer.parseInt(arrTime_in[3]);
	int curMinute = Integer.parseInt(arrTime_in[4]);

	String csr_rnum = request.getParameter("csr_rnum");

	CheckSecurity checkSecurity = new CheckSecurity(); 
	CSRDAO csrDao = new CSRDAO(); //DAO�ʱ�ȭ
	CSRDTO csrSearch = csrDao.getData(csr_rnum);

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
	String checked = "checked = 'checked'";
%>

<script type="text/javascript">
function check() {

//	alert(""+document.csr_detail_form.getElementById("csr_state").value);
	//var csr_state = document.csr_detail_form.getElementById("csr_state").value;

//	alert("if ���� ��");
	var i = 0;
	var master=<%=master%>
	if(document.csr_detail_form.csr_state.value == '0' && master.value !='0') {
		var radioCheck = false;
		var radioValue = -1;
		
		for(i = 0; i < document.csr_detail_form.c_dependentsystem_flag.length; i++) {
			if(document.csr_detail_form.c_dependentsystem_flag[i].checked) {
				radioCheck = true;
				radioValue = document.csr_detail_form.c_dependentsystem_flag[i].value;
				break;
			}
		}
		if(document.csr_detail_form.c_previewer.value == "") {
			alert("���������ڸ� �Է��ϼ���.");
			document.csr_detail_form.c_previewer.focus();
			return false;
		}
		if(document.csr_detail_form.c_preview_result.value == "") {
			alert("������������ �Է��ϼ���.");
			document.csr_detail_form.c_preview_result.focus();
			return false;
		}
		if(!radioCheck) {
			alert("���� �޴� �ý��� ���翩�θ� �������ּ���.");
			return false;
		}
		
		if(radioValue == 0 && document.csr_detail_form.c_dependentsystem.value == "") {
			alert("���� �޴� �ý����� �Է��ϼ���.");
			document.csr_detail_form.c_dependentsystem.focus();
			return false;
		}
		if(document.csr_detail_form.c_previewer.value.length > 60) {
			alert("���������ڴ� 30�� �̻� �Է��� �� �����ϴ�.");
			document.csr_detail_form.c_previewer.focus();
			return false;
		}
		if(document.csr_detail_form.c_preview_result.value.length > 100) {
			alert("������������ 50�� �̻� �Է��� �� �����ϴ�.");
			document.csr_detail_form.c_preview_result.focus();
			return false;
		}
		if(radioValue == 0 && document.csr_detail_form.c_dependentsystem.value.length > 200) {
			alert("���� �޴� �ý����� 200�� �̻� �Է��� �� �����ϴ�.");
			document.csr_detail_form.c_dependentsystem.focus();
			return false;
		}
		
		
	} else if(document.csr_detail_form.csr_state.value == '1' && master.value !='0') {
/* 		if (document.csr_detail_form.csr_reason.value == "") {
			alert("CSR������ �Է��ϼ���.");
			document.csr_detail_form.csr_reason.focus();
			return false;
		} */
		if (document.csr_detail_form.csr_processing_contents.value == "") {
			alert("CSRó�������� �����ϼ���.");
			document.csr_detail_form.csr_processing_contents.focus();
			return false;
		}
		
		if (document.csr_detail_form.csr_estimate_md.value == "") {
			alert("��������� �����ϼ���.");
			document.csr_detail_form.csr_estimate_md.focus();
			return false;
		}
		if (document.csr_detail_form.csr_complete_md.value == "") {
			alert("�Ϸ������ �����ϼ���.");
			document.csr_detail_form.csr_complete_md.focus();
			return false;
		}
		
		/* if (document.csr_detail_form.csr_reason.value.length > 200) {
			alert("CSR������ 100�� �̻� �Է��� �� �����ϴ�.");
			document.csr_detail_form.csr_reason.focus();
			return false;
		} */
		if (document.csr_detail_form.csr_processing_contents.value.length > 1000) {
			alert("CSRó�������� 500�� �̻� �Է��� �� �����ϴ�.");
			document.csr_detail_form.csr_processing_contents.focus();
			return false;
		}
		
	} else if(document.csr_detail_form.csr_state.value == '2' && master.value !='0') {
		if (document.csr_detail_form.csr_client_comment.value == "") {
			alert("���ǰ��� �����ϼ���. ");
			document.csr_detail_form.csr_client_comment.focus();
			return false;
		}
		
		if (document.csr_detail_form.csr_client_comment.value.length > 200) {
			alert("���ǰ��� 100�� �̻� �Է��� �� �����ϴ�.");
			document.csr_detail_form.csr_client_comment.focus();
			return false;
		}
	}
	
	return true;
}
function checkDecimal(el){
	 var ex = /^[0-9]+\.?[0-9]*$/;
	 if(ex.test(el.value)==false){
	   el.value = el.value.substring(0,el.value.length - 1);
	  }
	}

function check_radio(num) {
    if(num == "0") {
  	  csr_detail_form.c_dependentsystem.disabled = false;
   } else {
  	 csr_detail_form.c_dependentsystem.disabled = true;
  }
}

function changeSolving(){ //1 3 5 781012 ��¥�� ��������
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("solving_year");
	selectedMonth = document.getElementById("solving_month");
	selectObject=document.getElementById("solving_day");

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //��¥ �ʱ�ȭ
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();

	for (var i=1; i<=lastDay; i++) {
		if(i<10){
			var option=new Option(i,"0"+(i));}
		else 
			var option=new Option(i,i);
		
		// ���� ��,��,���� ��ġ�ϴ� ��쿡�� ��¥�� ���� �Ϸ� ����. ���̳� �� �ٲٸ� 1���� �⺻ ��.
		if(i == <%=curDay%> && selectedMonthValue==<%=curMonth%> && selectedYearValue==<%=curYear%>){		
			option.selected=true;
		}
		selectObject.options[i-1] = option; // index�� 0���� ����.
	}
}

function changeSolved(){ //1 3 5 781012 ��¥�� ��������
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("solved_year");
	selectedMonth = document.getElementById("solved_month");
	selectObject=document.getElementById("solved_day");

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //��¥ �ʱ�ȭ
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();

	for (var i=1; i<=lastDay; i++) {
		if(i<10){
			var option=new Option(i,"0"+(i));}
		else 
			var option=new Option(i,i);
		
		// ���� ��,��,���� ��ġ�ϴ� ��쿡�� ��¥�� ���� �Ϸ� ����. ���̳� �� �ٲٸ� 1���� �⺻ ��.
		if(i == <%=curDay%> && selectedMonthValue==<%=curMonth%> && selectedYearValue==<%=curYear%>){		
			option.selected=true;
		}
		selectObject.options[i-1] = option; // index�� 0���� ����.
	}
}

function changeFinish(){ //1 3 5 781012 ��¥�� ��������
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("finish_year");
	selectedMonth = document.getElementById("finish_month");
	selectObject=document.getElementById("finish_day");

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //��¥ �ʱ�ȭ
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();

	for (var i=1; i<=lastDay; i++) {
		if(i<10){
			var option=new Option(i,"0"+(i));}
		else 
			var option=new Option(i,i);
		
		// ���� ��,��,���� ��ġ�ϴ� ��쿡�� ��¥�� ���� �Ϸ� ����. ���̳� �� �ٲٸ� 1���� �⺻ ��.
		if(i == <%=curDay%> && selectedMonthValue==<%=curMonth%> && selectedYearValue==<%=curYear%>){		
			option.selected=true;
		}
		selectObject.options[i-1] = option; // index�� 0���� ����.
	}
}
 
function changeEstimate(){ //1 3 5 781012 ��¥�� ��������
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	selectedYear = document.getElementById("estimate_year");
	selectedMonth = document.getElementById("estimate_month");
	selectObject=document.getElementById("estimate_day");

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //��¥ �ʱ�ȭ
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();

	for (var i=1; i<=lastDay; i++) {
		if(i<10){
			var option=new Option(i,"0"+(i));}
		else 
			var option=new Option(i,i);
		
		// ���� ��,��,���� ��ġ�ϴ� ��쿡�� ��¥�� ���� �Ϸ� ����. ���̳� �� �ٲٸ� 1���� �⺻ ��.
		if(i == <%=curDay%> && selectedMonthValue==<%=curMonth%> && selectedYearValue==<%=curYear%>){		
			option.selected=true;
		}
		selectObject.options[i-1] = option; // index�� 0���� ����.
	}
}
 
<%-- function change(isRequest){ //1 3 5 781012 ��¥�� ��������
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;
	
	if (isRequest == 0) {
		selectedYear = document.getElementById("solving_year");	
		selectedMonth = document.getElementById("solving_month");	
		selectObject=document.getElementById("solving_day");
	} else if (isRequest == 1){
		selectedYear = document.getElementById("solved_year");	
		selectedMonth = document.getElementById("solved_month");	
		selectObject=document.getElementById("solved_day");
	} else {
		selectedYear = document.getElementById("finish_year");	
		selectedMonth = document.getElementById("finish_month");	
		selectObject=document.getElementById("finish_day");
	}

	selectedYearValue = selectedYear.options[selectedYear.selectedIndex].value;
	selectedMonthValue = selectedMonth.options[selectedMonth.selectedIndex].value;
	selectObject.length=0; //��¥ �ʱ�ȭ
	
	lastDay = new Date(selectedYearValue, selectedMonthValue, 0).getDate();
	logger.info("����  : " + isRequest);
	
	for (var i=1; i<=lastDay; i++) {
		if(i<10){
			var option=new Option(i,"0"+(i));}
		else 
			var option=new Option(i,i);
		
		// ���� ��,��,���� ��ġ�ϴ� ��쿡�� ��¥�� ���� �Ϸ� ����. ���̳� �� �ٲٸ� 1���� �⺻ ��.
		if(i == <%=curDay%> && selectedMonthValue==<%=curMonth%> && selectedYearValue==<%=curYear%>){		
			option.selected=true;
		}
		selectObject.options[i-1] = option; // index�� 0���� ����.
	}
} --%>
 
<%-- function changeDeptOptionsDetail(){
    var selectValue = document.getElementById("select_o_detail_dept");
    selectValue.length = 0;  //��λ���
	
    var o_code1 = document.getElementById("select_o_detail_member_company");
	var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

	var i=0;
	<%for (CSRDTO obj : mCode3List) {%>
	    if(selected_o_code1 == '<%=obj.getM_code1()%>'') {
		    if ('<%=obj.getM_code3()%>'' == '<%=csrSearch.getM_code3()%>'') {
				var option=new Option('<%=obj.getM_code3_m_name()%>'', '<%=obj.getM_code3()%>'', true, true);
		    }
		    else {
				var option=new Option('<%=obj.getM_code3_m_name()%>'', '<%=obj.getM_code3()%>'' );
		    }
		selectValue.options[i] = option;
		i++;
	    }
	<%}%>
}
 --%>

//0: ��������, 1: ����, 2: �ذ�, 3: ����
function buttonCheck(clickedButton) {
	var detailButton = document.getElementById("o_detail_button");
	
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
function addInputBox() {
	for(var i=1; i<=count; i++) {
		if(!document.getElementsByName("test"+i)[0]) {
			addCount = i;
			break;
		}
	  	else addCount = count;
	}

	var addStr = "<tr><td><input type=checkbox name=checkList value="+addCount+" size='5%'></td><td><input type=file name=test"+addCount+" size='80%'></td></tr>";
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
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body onload="check_radio();">
	<form name="csr_detail_form" action="update_csr.jsp" method="post"
		enctype="multipart/form-data" onsubmit="return check()">
		<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) < 3 && !master.equals("0")) {%>
		<table width="95%" align="center">
			<tr>
				<td align="left">�� CSR�������� �� CSR����Ȳ</td>
				<td align="right">
					<input type="submit" id="btnView" name="btnView" value="����" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt" />
					<input type="button" value="�ݱ�" 	style="width: 120px; height: 30px; font-family: Gothic; font-size: 9pt"onclick="javascript:self.close();" /></td>
			</tr>
		</table>
		<%} %>
		<table>
			<tr>
				<td style="height: 15px"></td>
			</tr>
		</table>
		<table width="95%" align="center" border="0" cellspacing="1"
			bgcolor="000000">
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">����</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_title" name="csr_title" value='<%=csrSearch.getCSR_title()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" />
				</td>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">ȸ��</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_member_company" name="csr_member_company" value='<%=csrSearch.getM_code1_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">CSR��ȣ</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_rnum" name="csr_rnum" value='<%=csrSearch.getCSR_rnum()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white" width="15%">�����</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_place" name="csr_place" value='<%=csrSearch.getM_code2_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">CSR����</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_code1" name="csr_code1" value='<%=csrSearch.getCSR_code1_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">�μ�</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_dept" name="csr_dept" value='<%=csrSearch.getM_code3_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly" /></td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">�ý��� ����</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" id="csr_system_category" name="csr_system_category" value='<%=csrSearch.getCSR_system_category_m_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt"readonly="readonly" /></td>
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">��û����</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input	type="text" id="csr_member_name" name="csr_member_name"	value='<%=csrSearch.getCSR_name()%>' style="width: 98%; font-family: Gothic; font-size: 9pt"readonly="readonly" /></td>
			</tr>
			<tr>
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">��������</font></td>
				<td align="left" valign="middle" class="01black_bold" bgcolor="ffffff" width="35%">&nbsp;&nbsp;<%=csrSearch.getCSR_requesttime()%></td>
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">������ó</font></td>
				<td align="center" valign="middle" bgcolor="ffffff" width="35%">
				<input type="text" name="csr_linenum" id="csr_linenum" style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readOnly" value='<%=csrSearch.getCSR_linenum()%>'></input>	</td>

			</tr>
			<tr height="100px">
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white" width="15%">����</font></td>
				<td align="center" colspan="3" valign="middle" bgcolor="ffffff" width="85%">
				<% String detail = checkSecurity.getText(csrSearch.getCSR_detail()); %>
				<textarea id="csr_detail" name="csr_detail" cols="1" rows="3" style="width: 98%; height: 100px; overflow: auto; resize:none" readonly="readOnly"><%=detail %></textarea></td>
			</tr>
			<tr>
			<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">÷������(��)</font></td>
			<td align="center" valign="middle" colspan="3" bgcolor="ffffff">
			<% if (csrSearch.getCSR_attachment() != null && !(csrSearch.getCSR_attachment().equals("")) && !(csrSearch.getCSR_attachment().equals("NULL"))) {
			 
			 String filePath = csrSearch.getCSR_attachment();
			 
			 StringTokenizer tokens = new StringTokenizer(filePath, "|");
			 File tempFile = null;
			 String fileName = null;
			 String oneFilePath = null;
			 
			 while (tokens.hasMoreElements()) {
				 oneFilePath = tokens.nextToken();
				 tempFile = new File(oneFilePath);
				 fileName = tempFile.getName(); %>
			<a href="../file_download.jsp?fileName=<%=fileName%>&filePath=<%=oneFilePath%>"><font color="blue"><%=fileName %></font></a>&nbsp;&nbsp;
			<a href="../file_delete.jsp?filePath=<%=oneFilePath%>&O_rnum=<%=csr_rnum%>&fileFullPath=<%=filePath%>"><font color="blue">����</font></a>&nbsp;&nbsp;
			 <% }
			 } %>
			</td>
			</tr>
						
		</table>
 		<table>
			<tr>
				<input type="hidden" name="csr_state" id="csr_state" value="<%=csrSearch.getCSR_digit_state() %>"></input>
				<%-- <input type="hidden" name="my_id" id="my_id" value="<%=my_id %>"></input>
				<input type="hidden" name="my_company" id="my_company" value="<%=memberInfo.getM_company() %>"></input>
				<input type="hidden" name="my_place" id="my_place" value="<%=memberInfo.getM_place() %>"></input>
				<input jtype="hidden" name="my_dept" id="my_dept" value="<%=memberInfo.getM_dept() %>"></input> --%>
			</tr>
		</table>
		
		<!-- 1. ��û : ���°� 0���� ũ�� �б⸸-->
		<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) > 0) {%>
		<table>
			<tr>
				<td style="height: 3px"></td>
			</tr>
		</table>
		<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� ������</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_previewer"	 value='<%=csrSearch.getCSR_previewer()%>' name="c_previewer"style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� ���� �Ͻ�</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_solvingtime"	name="c_solvingtime"style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_solvingtime()%>' readonly="readonly"/></td>	
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">��ġ ������</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="csr_estimate_solvetime"	name="csr_estimate_solvetime"style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_estimate_solvetime()%>' readonly="readonly"/></td>	
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� ���� ���</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_preview_result" name="c_preview_result" value='<%=csrSearch.getCSR_preview_result()%>' style="width: 98%; font-family: Gothic; font-size: 9pt" readonly="readonly"/></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� �޴� �ý���</font></td>
				<td width="85%" align="left" valign="middle" bgcolor="ffffff">
				<% if(csrSearch.getCSR_dependentsystem_flag().equals("0")){ %>
					<input type="radio" id="c_dependentsystem_flag"	name="c_dependentsystem_flag" onClick="check_radio(0)" name="Radiostatus" value="0" checked disabled="disabled">Yes 
					<input type="radio"	id="c_dependentsystem_flag" name="c_dependentsystem_flag" onClick="check_radio(1)" name="Radiostatus" value="1" disabled="disabled">No 
					<input type="text" id="c_dependentsystem" name="c_dependentsystem" style="width: 100%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_dependentsystem()%>' readonly="readonly"/></td>
				<%}else{ %>
					<input type="radio" id="c_dependentsystem_flag"	name="c_dependentsystem_flag" onClick="check_radio(0)" name="Radiostatus" value="0"  disabled="disabled">Yes 
					<input type="radio"	id="c_dependentsystem_flag" name="c_dependentsystem_flag" onClick="check_radio(1)" name="Radiostatus" value="1" checked disabled="disabled">No 
					<input type="text" id="c_dependentsystem" name="c_dependentsystem" style="width: 100%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_dependentsystem()%>' readonly="readonly"/></td>
				<%} %>
				
			</tr>
		</table>
			<!-- -2. �ذ� ��  : ���°� 1���� ũ�� �б⸸ -->
			<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) > 1) {%>
			<table>
				<tr>
					<td style="height: 3px"></td>
				</tr>
			</table>
			<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
				<tr>
					<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�Ϸ� �Ͻ�</font></td>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<input type="text" id="csr_solvedtime" name="csr_solvedtime" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_solvedtime()%>' readonly="readonly"></input></td>
				</tr>
				<tr>
					<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ó������</font></td>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<input type="text" id="csr_processing_contents" name="csr_processing_contents" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_processing_contents()%>' readonly="readonly"></input></td>
				</tr>
				<%-- <tr>
					<td rowspan="4" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">ó�����</font></td>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">����</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_reason" name="csr_reason" cols="1" rows="3" style="width: 98%; height: 30px; overflow: hidden; resize:none" readonly="readOnly"><%=csrSearch.getCSR_reason()%></textarea></td>
				</tr>
	
				<tr>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">ó������</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_processing_contents" name="csr_processing_contents" cols="1" rows="3" style="width: 98%; height: 50px; overflow: hidden; resize:none" readonly="readOnly"><%=csrSearch.getCSR_processing_contents()%></textarea></td>
				</tr> --%>
				<tr>
					<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">�������(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_estimate_md" name="csr_estimate_md" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_estimate_md()%>' readonly="readonly"/></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">�Ϸ����(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_complete_md" name="csr_complete_md" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_complete_md()%>'  readonly="readonly"/></td>
				</tr>
				<tr>
			<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">÷������(������)</font></td>
			<td align="center" valign="middle" colspan="3" bgcolor="ffffff">
			<% if (csrSearch.getCsr_attachment_engineer() != null && !(csrSearch.getCsr_attachment_engineer().equals("")) && !(csrSearch.getCsr_attachment_engineer().equals("NULL"))) {
			 
			 String filePath = csrSearch.getCsr_attachment_engineer();
			 
			 StringTokenizer tokens = new StringTokenizer(filePath, "|");
			 File tempFile = null;
			 String fileName = null;
			 String oneFilePath = null;
			 
			 while (tokens.hasMoreElements()) {
				 oneFilePath = tokens.nextToken();
				 tempFile = new File(oneFilePath);
				 fileName = tempFile.getName(); %>
			<a href="../file_download.jsp?fileName=<%=fileName%>&filePath=<%=oneFilePath%>"><font color="blue"><%=fileName %></font></a>&nbsp;&nbsp;
			<a href="../file_delete.jsp?filePath=<%=oneFilePath%>&O_rnum=<%=csr_rnum%>&fileFullPath=<%=filePath%>"><font color="blue">����</font></a>&nbsp;&nbsp;
			 <% }
			 } %>
			</td>
			</tr>
				
				
			</table>
				<!-- -3. �ذ�   : ���°� 2���� ũ�� �б⸸-->
				<%if (Integer.parseInt(csrSearch.getCSR_digit_state()) > 2) {%>
				<table>
					<tr>
						<td style="height: 3px"></td>
					</tr>
				</table>
				<table width="95%" align="center" border="0" cellspacing="1"
					bgcolor="000000">
					<tr>
						<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">���� �Ͻ�</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="85%">
						<input type="text" id="c_finishtime" name="c_finishtime" style="width: 98%; font-family: Gothic; font-size: 9pt" value='<%=csrSearch.getCSR_finishtime()%>' readonly="readonly"/></td>
					</tr>
					<tr>
						<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">�� �ǰ�</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="85%">
						<textarea id="csr_client_comment" name="csr_client_comment" cols="1" rows="3" style="width: 98%; height: 50px; overflow: hidden; resize:none" readonly="readOnly"><%=csrSearch.getCSR_client_comment()%></textarea>
						</td>
					</tr>
				</table>
				<%} else if(!master.equals("0")) {%>
				<table>
					<tr>
						<td style="height: 3px"></td>
					</tr>
				</table>
				<table width="95%" align="center" border="0" cellspacing="1"
					bgcolor="000000">
					<tr>
						<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">���� �Ͻ�</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="35%">
						<select id="finish_year" name="finish_year"	onchange=changeFinish()	style="width: 20%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = curYear - 10; i <= curYear + 10; i++) {
								%>
								<option value=<%=i%>
								<%=((curYear == i) == true ? selected : "")%>><%=i%></option>
								<%
									}
								%>
						</select>��
						<select id="finish_month" name="finish_month" onchange=changeFinish() style="width: 15%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = 1; i <= 12; i++) {
										if (i < 10) {
								%>
								<option value=<%="0" + i%>
									<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
									<%
										} else {
									%>
									<option value=<%=i%>
										<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
									<%
										}
									}
								%>
						</select>�� 
						<select id="finish_day" name="finish_day" style="width: 15%; font-family: Gothic; font-size: 9pt">
						</select>�� 
						<select id="finish_hour" name="finish_hour" style="width: 15%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = 1; i <= 24; i++) {
											if (i < 10) {
									%>
									<option value=<%="0" + i%>
										<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
									<%
										} else {
									%>
									<option value=<%=i%>
									<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
									<%
										}
									}
									%>
						</select>��
						<select id="finish_minute" name="finish_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
								<%
									for (int i = 0; i < 60; i += 10) {
											if (i < 10) {
										%>
										<option value=<%="0" + i%>
											<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
												: "")%>><%="0" + i%></option>
										<%
											} else {
										%>
										<option value=<%=i%>
											<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
												: "")%>><%=i%></option>
										<%
											}
										}
								%>
						</select>��
						<script>
							changeFinish();
						</script></td>
					</tr>
					<tr>
						<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">�� �ǰ�</font></td>
						<td align="center" valign="middle" bgcolor="ffffff"	width="85%">
						<textarea id="csr_client_comment" name="csr_client_comment" cols="1" rows="3" style="width: 98%; height: 30px; overflow: hidden; resize:none"></textarea></td>
					</tr>
				</table>
				<%}%>
			
			<%} else if(!master.equals("0")) {%>
			<table>
				<tr>
					<td style="height: 3px"></td>
				</tr>
			</table>
			<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">�Ϸ� �Ͻ�</font></td>
					<td colspan="3"  align="center" valign="middle" bgcolor="ffffff" width="85%">
					<select id="solved_year" name="solved_year"	onchange=changeSolved() style="width: 20%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = curYear - 10; i <= curYear + 10; i++) {
							%>
							<option value=<%=i%>
							<%=((curYear == i) == true ? selected : "")%> ><%=i%></option>
							<%
								}
							%>
					</select>��
					<select id="solved_month" name="solved_month" onchange=changeSolved() style="width: 15%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = 1; i <= 12; i++) {
										if (i < 10) {
							%>
								<option value=<%="0" + i%>
									<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
								<%
									} else {
								%>
								<option value=<%=i%>
									<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
								<%
									}
								}
							%>
					</select>��
					<select id="solved_day" name="solved_day" style="width: 15%; font-family: Gothic; font-size: 9pt">
					</select>��
					<select id="solved_hour" name="solved_hour" style="width: 15%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = 1; i <= 24; i++) {
										if (i < 10) {
							%>
							<option value=<%="0" + i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
								<%
									} else {
								%>
								<option value=<%=i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
								<%
									}
								}
							%>
					</select>��
					<select id="solved_minute" name="solved_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
							<%
								for (int i = 0; i < 60; i += 10) {
										if (i < 10) {
							%>
							<option value=<%="0" + i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected	: "")%>><%="0" + i%></option>
								<%
									} else {
								%>
								<option value=<%=i%>
									<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected	: "")%>><%=i%></option>
								<%
									}
								}
							%>
					</select>�� 
					<script>
						changeSolved();
					</script>
				</td>
				</tr>
				<!-- <tr>
					<td rowspan="4" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">ó�����</font></td>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">����</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_reason" name="csr_reason" cols="1" rows="3" style="width: 98%; height: 30px; overflow: hidden; resize:none"></textarea></td>
				</tr>
	
				<tr>
					<td colspan="3" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="85%"><font color="white">ó������</font></td>
				</tr>
				<tr>
					<td colspan="3" align="center" valign="middle" bgcolor="ffffff" width="85%">
					<textarea id="csr_processing_contents" name="csr_processing_contents" cols="1" rows="3" style="width: 98%; height: 50px; overflow: hidden; resize:none"></textarea></td>
				</tr> -->
				<tr height="300px">
				<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white" width="15%">ó�� ����</font></td>
				<td align="center" colspan="3" valign="middle" bgcolor="ffffff" width="85%">
				<textarea id="csr_processing_contents" name="csr_processing_contents" cols="1" rows="3" style="width: 98%; height: 300px; overflow: hidden; resize:none"></textarea></td>
				</tr>		
				<tr>
					<td align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC" width="15%"><font color="white">�������(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_estimate_md" name="csr_estimate_md" style="width: 98%; font-family: Gothic; font-size: 9pt" onkeyup="checkDecimal(this);"/></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">�Ϸ����(M/D)</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" width="35%">
					<input type="text" id="csr_complete_md" name="csr_complete_md" style="width: 98%; font-family: Gothic; font-size: 9pt" onkeyup="checkDecimal(this);"/></td>
				</tr>
<tr>
<td width="15%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">÷������(������)</font></td>
<td width="85%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold" colspan="3">

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
</tr>
			</table>
			<%}%>
			
			
		<%} else if(!master.equals("0")) {%>
		<table>
			<tr>
				<td style="height: 3px"></td>
			</tr>
		</table>
		<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� ������</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_previewer"	name="c_previewer"style="width: 98%; font-family: Gothic; font-size: 9pt" /></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� ���� �Ͻ�</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
					<!-- <input type="text" id="c_solvingtime" name="c_solvingtime" style="width: 98%; font-family: Gothic; font-size: 9pt" /> -->

					<select id="solving_year" name="solving_year" onchange=changeSolving() style="width: 20%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = curYear - 10; i <= curYear + 10; i++) {
						%>
						<option value=<%=i%>
						<%=((curYear == i) == true ? selected : "")%>><%=i%></option>
						<%
							}
						%>
				</select>�� <select id="solving_month" name="solving_month" onchange=changeSolving() style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 12; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>�� <select id="solving_day" name="solving_day"style="width: 15%; font-family: Gothic; font-size: 9pt">
				</select>�� <select id="solving_hour" name="solving_hour"style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 24; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
							<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>�� <select id="solving_minute" name="solving_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 0; i < 60; i += 10) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%="0" + i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>�� 
				<script>
					changeSolving();
				</script>
				</td>
			</tr>
			
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">��ġ ������</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<select id="estimate_year" name="estimate_year" onchange=changeestimate() style="width: 20%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = curYear - 10; i <= curYear + 10; i++) {
						%>
						<option value=<%=i%>
						<%=((curYear == i) == true ? selected : "")%>><%=i%></option>
						<%
							}
						%>
				</select>�� <select id="estimate_month" name="estimate_month" onchange=changeestimate() style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 12; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=((curMonth == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>�� <select id="estimate_day" name="estimate_day"style="width: 15%; font-family: Gothic; font-size: 9pt">
				</select>�� <select id="estimate_hour" name="estimate_hour"style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 1; i <= 24; i++) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
							<%=((curHour == i) == true ? selected : "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>�� <select id="estimate_minute" name="estimate_minute" style="width: 15%; font-family: Gothic; font-size: 9pt">
						<%
							for (int i = 0; i < 60; i += 10) {
									if (i < 10) {
						%>
							<option value=<%="0" + i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%="0" + i%></option>
							<%
								} else {
							%>
							<option value=<%=i%>
								<%=(((curMinute >= i) && (curMinute < (i + 10))) == true ? selected
									: "")%>><%=i%></option>
							<%
								}
							}
						%>
				</select>�� 
				<script>
					changeEstimate();
				</script>
				</td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� ���� ���</font></td>
				<td width="85%" align="center" valign="middle" bgcolor="ffffff"	class="01black_bold">
				<input type="text" id="c_preview_result" name="c_preview_result"	style="width: 98%; font-family: Gothic; font-size: 9pt" /></td>
			</tr>
			<tr>
				<td width="15%" align="center" valign="middle" class="01black_bold"	bgcolor="#A7A9AC"><font color="white">���� �޴� �ý���</font></td>
				<td width="85%" align="left" valign="middle" bgcolor="ffffff">
				<input type="radio" id="c_dependentsystem_flag"	name="c_dependentsystem_flag" onClick="check_radio(0)" name="Radiostatus" value="0">Yes 
				<input type="radio"	id="c_dependentsystem_flag" name="c_dependentsystem_flag" onClick="check_radio(1)" name="Radiostatus" value="1">No 
				<input type="text" id="c_dependentsystem" name="c_dependentsystem" style="width: 91%; font-family: Gothic; font-size: 9pt" /></td>

			</tr>
		</table>
		<%}%>
		
	</form>
</body>
</html>