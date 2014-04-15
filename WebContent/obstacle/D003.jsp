<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.obstacle.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%
	long time = System.currentTimeMillis(); 
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
	String time_in = dayTime.format(new Date(time)); //�ð����� ��� ���
	String[] arrTime_in = time_in.split("-");	
	int curYear = Integer.parseInt(arrTime_in[0]);
	int curMonth = Integer.parseInt(arrTime_in[1]);
	int curDay = Integer.parseInt(arrTime_in[2]);
	int curHour = Integer.parseInt(arrTime_in[3]);

	String O_rnum=request.getParameter("o_rnum");
	ObstacleDAO O_dao=new ObstacleDAO(); //DAO�ʱ�ȭ
	ObstacleDTO O_Search = O_dao.getData(O_rnum);
	
	List<ObstacleDTO> obsCode1List = O_dao.getOCode1List();
	List<ObstacleDTO> obsCode2List = O_dao.getOCode2List();
	List<ObstacleDTO> mCode3List = O_dao.getMCode3List();
	
	String occur_time = O_Search.getO_occurrencetime();
	int occurYear = 0;
	int occurMonth = 0;
	int occurDay = 0;
	int occurHour = 0;
	if (occur_time != null && !occur_time.equals("null") && !occur_time.equals("")) {
		occurYear = Integer.parseInt(occur_time.substring(0, 4));
		occurMonth = Integer.parseInt(occur_time.substring(5, 7));
		occurDay = Integer.parseInt(occur_time.substring(8, 10));
		occurHour = Integer.parseInt(occur_time.substring(11, 13));
	}
	
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
	
		
	String selected = "selected = 'selected'";
	String checked = "checked = 'checked'";
%>

<script type="text/javascript">


function change(){
	var selectedYear = null;
	var selectedYearValue = null;
	var selectedMonth = null;
	var selectedMonthValue = null;
	var selectObject= null;
	var lastDay = null;

	selectedYear = document.getElementById("occur_year_detail");	
	selectedMonth = document.getElementById("occur_month_detail");	
	selectObject=document.getElementById("occur_day_detail");

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
		if(i == <%=occurDay%> && selectedMonthValue==<%=occurMonth%> && selectedYearValue==<%=occurYear%>){		
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

function changeDeptOptionsDetail(){
    var selectValue = document.getElementById("select_o_detail_dept");
    selectValue.length = 0;  //��λ���
	
    var o_code1 = document.getElementById("select_o_detail_member_company");
	var selected_o_code1 = o_code1.options(o_code1.selectedIndex).value;

	var i=0;
	<% for(ObstacleDTO obj : mCode3List) { %>
	    if(selected_o_code1 == '<%=obj.getM_code1()%>') {
		    if ('<%=obj.getM_code3()%>' == '<%=O_Search.getM_code3() %>') {
		var option=new Option('<%=obj.getM_code3_m_name()%>', '<%=obj.getM_code3()%>', true, true);
		    }
		    else {
		var option=new Option('<%=obj.getM_code3_m_name()%>', '<%=obj.getM_code3()%>');
		    }
		selectValue.options[i] = option;
		i++;
	    }
	<% }%>
}

function showAssetList() {
	window.open("./asset_list.jsp", "pop2", "width=400,height=800,history=no,status=no,scrollbars=yes,menubar=no")
}

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

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body>
<form name="obstacle_detail_form" action="update_obstacle_detail.jsp" method="post" enctype="multipart/form-data">
<table width="90%" align="center" >
<tr>
<td align="left">�� ��ְ������� �� ��ֻ���Ȳ</td>
</tr>
</table>
	<table>
		<tr>
			<td style="height: 15px"></td>
		</tr>
	</table>
	
<table width="90%" align="center" border="0" cellspacing="1" bgcolor="000000">
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">����</font></td>
<td align="center" valign="middle" colspan="3" bgcolor="ffffff" width="35%"><%=O_Search.getO_title() %>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">������ȣ</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="35%"><%=O_Search.getO_rnum() %>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">����</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="35%"><%=O_Search.getM_code1_m_name() %></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��з�</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getCode1_m_name() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ġ</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getM_code2_m_name() %></td>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ߺз�(��������)</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getCode2_m_name() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�μ�</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getM_code3_m_name() %></td>

</tr>
<tr>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="15%"><font color="white">��ֵ��</font></td>
<td align="center" valign="middle" bgcolor="ffffff" width="35%"><%=O_Search.getO_ograde() %>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��û����</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getMember_name() %></td>

</tr>
<tr>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�������</font></td>
<td align="center" valign="middle" bgcolor="ffffff" ><%=O_Search.getO_opath() %></td>

<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������ó</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getO_linenum() %></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ǰ��</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=allAssetStr %>
</td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getO_vendorname() %></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����ð�</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getO_requesttime() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ֹ߻��ð�</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getO_occurrencetime() %></td>
</tr>
<tr>


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
 <% }
 } %>
</td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">�������</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff"><%=O_Search.getO_detail() %></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">���������</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getO_engineer() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������Ȳ</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><b><%=O_Search.getO_state() %></b></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ִ����</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getA_name() %></td>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">����� ����ó</font></td>
<td align="center" valign="middle" bgcolor="ffffff"><%=O_Search.getA_linenum()%></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">��ֿ���</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff"><%=O_Search.getO_reason() %></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">�����ġ����</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff"><%=O_Search.getO_resolvedetail() %></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">������û����</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff"><%=O_Search.getO_requestdetail() %></td>
</tr>
<tr>
<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" ><font color="white">÷������(������)</font></td>
<td align="center" colspan="3" valign="middle" bgcolor="ffffff">

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
 <% }
 } %>
 </td>
</tr>
</table>

<table>
	<tr>
		<td style="height: 10px"></td>
	</tr>
</table>

<table width="95%" align="center">
	<tr>
		<td width="50%">
		</td>
		<td>
			<table width="100%" align="right" border="0" cellspacing="1" bgcolor="000000">
				<tr>
					<td align="left" colspan="3" bgcolor="ffffff">�� �ش� �ڻ��� �ٸ� ��� ���</td>
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="20%"><font color="white">������ȣ</font></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="20%"><font color="white">������Ȳ</font></td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="60%"><font color="white">����</font></td>
				</tr>
			</table>		
		</td>
		<td width="15">
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<iframe align="right" id="obstacle_a_num" name="obstacle_a_num" src="D003_iframe.jsp?o_rnum=<%=O_rnum %>" 
			width="50%" height="200" frameborder="0" scrolling="yes" style="overflow-x:scroll; overflow-y:auto;"></iframe>
		</td>
	</tr>
</table>

<input type="hidden" id="o_detail_button" name="o_detail_button">
<input type="hidden" id="o_detail_asset_code" name="o_detail_asset_code">
<Script>
changeCode2OptionsDetail(); changeDeptOptionsDetail(); change();
</Script>

</form>
</body>
</html>