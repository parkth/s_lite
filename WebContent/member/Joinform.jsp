<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.net.InetAddress"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.mycom.asset.*"%>

<%
String my_id = (String) session.getAttribute("ID");

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("�α������� ������ ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
	
	String master = (String) session.getAttribute("Master");

	if(!master.equals("1")){
		%>
			<script type = "text/javascript">
			alert("�����ڰ� �ƴϸ� ������ �� �����ϴ�.");
			history.back();
			</script>
		<%
	}
}
AssetDAO dao = new AssetDAO();
List<AssetDTO> m_code1_lists = dao.search_mcode1();
List<AssetDTO> m_code2_lists = dao.search_mcode2();

List<AssetDTO> m_code3_lists = dao.search_mcode3();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<script type="text/javascript">

function m_master_flase()
{
		document.join_form.m_master.checked = false;
}

function m_engineer_flase()
{
		document.join_form.m_engineer.checked = false;
}

function select_mcode2(){
    var selectValue = document.getElementById("m_place");
    join_form.m_place.options.length = 0;  //��λ���
    join_form.m_dept.options.length = 0;  //��λ���
    var i=0;
	var option;
    var value_mcode1 = document.getElementById("m_company");
	var mcode1 = value_mcode1.options(value_mcode1.selectedIndex).value;	
	
		<%	for(AssetDTO m_code2_obj : m_code2_lists) {
			%>if(mcode1 == '<%=m_code2_obj.getM_code1()%>'){
				var option=new Option('<%=m_code2_obj.getM_name()%>', '<%=m_code2_obj.getM_code2()%>');
				selectValue.options[i] = option;
				i++;
			}	
		<%}		%>
		select_mcode3();
}

function select_mcode3(){
    var selectValue = document.getElementById("m_dept");
    join_form.m_dept.options.length = 0;  //��λ���
    var i=0;
	var option;
	var value_mcode2 = document.getElementById("m_place");
	var mcode2 = value_mcode2.options(value_mcode2.selectedIndex).value;

		<%	for(AssetDTO m_code3_obj : m_code3_lists) {
			%>if(mcode2 == '<%=m_code3_obj.getM_code1()%>'){
				var option=new Option('<%=m_code3_obj.getM_name()%>', '<%=m_code3_obj.getM_code2()%>');
				selectValue.options[i] = option;
				  i++;
			}	
		<%}		%>
}

	function check() {
		document.join_form.m_linenum.value = document.join_form.phone1.value + "-"
		+ document.join_form.phone2.value + "-" + document.join_form.phone3.value;

		var idPs=/^[a-z0-9_]{4,20}$/;  //���̵� ��й�ȣ üũǥ����
		
		<!-- ID üũ -->
		var idNum=document.join_form.m_id.value.search(/[^(0-9)]/);
		var idEng=document.join_form.m_id.value.search(/[^(a-z)]/);
		
		if (document.join_form.m_id.value == "") {
			alert("ID�� �Է��ϼ���");
			document.join_form.m_id.focus();
			return false;
		}
		if(document.join_form.m_id.value.length<=5){
			alert("���̵�� 6�� �̻� �Է��ϼž� �մϴ�.");
			document.join_form.m_id.select();  //��μ��õ� ���¿��� focus
			return false;	
		}
		if(!idPs.test(document.join_form.m_id.value)){
			alert("��ȿ�� ���̵� ������ �ƴմϴ�.");
			document.join_form.m_id.value="";  //id�ۼ��ߴ� ���� �����
			document.join_form.m_id.focus();  //id focus�̵�
			return false;
		}
		if(idNum<0||idEng<0){
			  alert("���̵�� ���ڿ� �����ڸ� ȥ���ϼž� �մϴ�.");
			  document.join_form.m_id.select(); 
		  return false;
		}
		if(/(\w)\1\1\1/.test(document.join_form.m_id.value)){
			  alert("���̵� ���� ���ڸ� 4�� �̻� ����Ҽ� �����ϴ�.");
			  document.join_form.m_id.select();
		  return false;
		}


		<!-- �̸� üũ -->
		if (document.join_form.m_name.value == "") {
			alert("�̸��� �Է��ϼ���");
			document.join_form.m_name.focus();
			return false;
		}
		if (document.join_form.m_name.value.length <= 1 || document.join_form.m_name.value.length >= 6 ) {
			alert("�̸��� 2���� �̻� 5���� ���Ϸ� �Է��ϼ���");
			document.join_form.m_name.focus();
			return false;
		}
		if (document.join_form.phone2.value == "") {
			alert("��ȭ��ȣ �ι�°�� �Է��ϼ���");
			document.join_form.phone2.focus();
			return false;
		}
		if (isNaN(document.join_form.phone2.value)) {
			alert("��ȭ��ȣ �ι�°�� ���ڸ� �Է��ϼ���");
			document.join_form.phone2.focus();
			return false;
		}
		if (document.join_form.phone3.value == "") {
			alert("��ȭ��ȣ ����°�� �Է��ϼ���");
			document.join_form.phone3.focus();
			return false;
		}
		if (isNaN(document.join_form.phone3.value)) {
			alert("��ȭ��ȣ ����°�� ���ڸ� �Է��ϼ���");
			document.join_form.phone3.focus();
			return false;
		}
		
		if (document.join_form.m_pwd.value == "") {
			alert("��й�ȣ�� �Է��ϼ���");
			document.join_form.m_pwd.focus();
			return false;
		}
		if (document.join_form.m_pwd.value.length <= 5) {
			alert("��й�ȣ�� 6�ڸ� �̻� �Է��ϼ���");
			document.join_form.m_pwd.focus();
			return false;
		}
		 if(!idPs.test(document.join_form.m_pwd.value)){
			  alert("��ȿ�� ��й�ȣ ������ �ƴմϴ�.");
			  document.join_form.m_pwd.value="";  //id���� �����
			  document.join_form.m_pwd.focus();  //id focus�̵�
			  return false;
		}
		var psNum=document.join_form.m_pwd.value.search(/[^(0-9)]/);
		var psEng=document.join_form.m_pwd.value.search(/[^(a-z)]/);
		if(psNum<0||psEng<0){
			alert("��й�ȣ�� ���ڿ� �����ڸ� ȥ���Ͽ��� �մϴ�.");
			document.join_form.m_pwd.select();
			return false;
		}
		if(/(\w)\1\1\1/.test(document.join_form.m_pwd.value)){
			alert("��й�ȣ�� ���� ���ڸ� 4�� �̻� ����Ҽ� �����ϴ�.");
			document.join_form.m_pwd.select();
			return false;
		}
		if(document.join_form.m_id.value.search(document.join_form.m_pwd.value)>-1){
			alert("���̵� ���Ե� ��й�ȣ�� ����Ҽ� �����ϴ�.");
			document.join_form.m_pwd.select();
			return false;
		}
		if (document.join_form.m_pwd_confirm.value == "") {
			alert("��й�ȣ�� �ٽ� �Է��ϼ���");
			document.join_form.m_pwd_confirm.focus();
			return false;
		}
		if (document.join_form.m_pwd.value != document.join_form.m_pwd_confirm.value){
			alert("������ ��й�ȣ�� �Է��ϼ���");
			document.join_form.m_pwd_confirm.focus();
			return false;
		}
		if (document.join_form.m_company.value == "C_00000") {
			alert("ȸ�縦 �����ϼ���");
			document.join_form.m_company.focus();
			return false;
		}
		if (document.join_form.m_place.value == "P_00000") {
			alert("������� �����ϼ��� ");
			document.join_form.m_place.focus();
			return false;
		}
		if (document.join_form.m_dept.value == "D_00000") {
			alert("�μ��� �����ϼ���");
			document.join_form.m_dept.focus();
			return false;
		}
		
		if (document.update_form.m_pwd_confirm.value.length > 20 && document.update_form.m_pwd_confirm.value.length > 20 ) {
			alert("��й�ȣ�� 20�� �̻� �Է��� �� �����ϴ�.");
			document.update_form.m_pwd_confirm.focus();
			return false;
		}
		return true;
}
</script>
<head>

<title>S-LITE</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body onload="select_mcode2();">
	<form name="join_form" action="Join.jsp" method="post" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">�� ����ڰ��� �� ����ڵ��</td>
<td align="right"><input type="submit" value="����" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"></input></td>
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>
	<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
			
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D</font></td>
					<td align="center" valign="middle" bgcolor="ffffff" colspan="3" width="40%">
						<input align="left" type="text" id="m_id" name="m_id" style="width: 85%; font-family: Gothic; font-size: 9pt" readonly="readonly" onclick="window.open('id_checkform.jsp','','width=400,height=200,scrollbars=no')"/>
						<input type="button" id="id_check" name="id_check" value="ID Check" onclick="window.open('id_checkform.jsp','','width=400,height=200,scrollbars=no')" />						
					</td>		
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</font>
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="text" id="m_name" name="m_name" style="width: 99%; font-family: Gothic; font-size: 9pt" maxlength="5"/>
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">ȸ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</font>
					<td align="center" valign="middle" bgcolor="ffffff" width="40%">
						<select id="m_company" name="m_company" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode2()">
							<%	for(AssetDTO m_code1_obj : m_code1_lists) {%>
							<option value=<%=m_code1_obj.getM_code1() %>><%=m_code1_obj.getM_name()%></option>
							<%	} %>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">��ȭ��ȣ</font>
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="hidden" name="m_linenum" id="m_linenum">
						<select name="phone1" id="phone1" style="width: 30%; font-family: Gothic; font-size: 8pt">
							<option value="010">010
							<option value="011">011
							<option value="016">016
							<option value="017">017
							<option value="018">018
							<option value="019">019
						</select>-
						<input type="text" name="phone2" id="phone2" maxlength="4" onkeyup="if (this.value.length >= 3) document.getElementById('ipaddress3').focus();" style="width: 30%; font-family: Gothic; font-size: 8pt">-
						<input type="text" name="phone3" id="phone3" maxlength="4" onkeyup="if (this.value.length >= 3) document.getElementById('ipaddress4').focus();" style="width: 30%; font-family: Gothic; font-size: 8pt">
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;</font>
					<td align="center" valign="middle" bgcolor="ffffff" width="40%">
						<select id="m_place" name="m_place" style="width: 100%; font-family: Gothic; font-size: 9pt" onchange="select_mcode3()">
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="padding-center: 10px;width: 50%;" bgcolor="ffffff">Master
					<input type="checkbox" name="m_master" id="m_master" size="12" style="font-family: Gothic; font-size: 9pt" onclick="m_engineer_flase()">
					Engineer
					<input type="checkbox" name="m_engineer" id="m_engineer" size="12" style="font-family: Gothic; font-size: 9pt" onclick="m_master_flase()">
					��뿩��
					<input type="checkbox" name="m_enable" id="m_enable" size="12" checked style="font-family: Gothic; font-size: 9pt">
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</font>
					<td align="center" valign="middle" bgcolor="ffffff" width="40%">
						<select id="m_dept" name="m_dept" style="width: 100%; font-family: Gothic; font-size: 9pt">
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">��й�ȣ</font> 
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="password" id="m_pwd" name="m_pwd" style="width: 99%; font-family: Gothic; font-size: 9pt" maxlength="12"/>
					</td>
					<td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC" width="10%"><font color="white">�ٽ��Է�</font>
					<td align="left" valign="middle" bgcolor="ffffff" width="40%">
						<input type="password" id="m_pwd_confirm" name="m_pwd_confirm" style="width: 99%; font-family: Gothic; font-size: 9pt" maxlength="12"/>
				</tr>
				</table>			
	</form>
</body>
</html>

