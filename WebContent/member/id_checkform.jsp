<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String my_id = (String) session.getAttribute("ID");

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("�α������� ������ ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
} %>
<html>
<script type="text/javascript">
	function check() {
		var idPs=/^[a-z0-9_]{4,20}$/;  //���̵� ��й�ȣ üũǥ����
		
		<!-- ID üũ -->
		var idNum=document.idcheck_form.m_id.value.search(/[^(0-9)]/);
		var idEng=document.idcheck_form.m_id.value.search(/[^(a-z)]/);
		
		if (document.idcheck_form.m_id.value == "") {
			alert("ID�� �Է��ϼ���");
			document.idcheck_form.m_id.focus();
			return false;
		}
		if(document.idcheck_form.m_id.value.length<=5){
			alert("���̵�� 6�� �̻� �Է��ϼž� �մϴ�.");
			document.idcheck_form.m_id.select();  //��μ��õ� ���¿��� focus
			return false;	
		}
		if(document.idcheck_form.m_id.value.length>12){
			alert("���̵�� 12�� �̻� �Է��� �� �����ϴ�.");
			document.idcheck_form.m_id.select();  //��μ��õ� ���¿��� focus
			return false;	
		}
		if(!idPs.test(document.idcheck_form.m_id.value)){
			alert("��ȿ�� ���̵� ������ �ƴմϴ�.");
			document.idcheck_form.m_id.value="";  //id�ۼ��ߴ� ���� �����
			document.idcheck_form.m_id.focus();  //id focus�̵�
			return false;
		}
		if(idNum<0||idEng<0){
			  alert("���̵�� ���ڿ� �����ڸ� ȥ���ϼž� �մϴ�.");
			  document.idcheck_form.m_id.select(); 
		  return false;
		}
		if(/(\w)\1\1\1/.test(document.idcheck_form.m_id.value)){
			  alert("���̵� ���� ���ڸ� 4�� �̻� ����Ҽ� �����ϴ�.");
			  document.idcheck_form.m_id.select();
		  return false;
		}
		
		return true;
	}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ID Ȯ�� üũ</title>
<link rel="stylesheet" type="text/css" href="../common.css" />
</head>
<body>
<form name="idcheck_form" action="id_check.jsp" method="post" onsubmit="return check()">
<table width="95%" align="center">
<tr>
<td align="left">�� ����ڰ��� �� ID üũ Ȯ��</td>
<td align="right"><input type="submit" value="üũ" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"></input>
<input type="button" value="���" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt" onclick="javascript:self.close();"></input></td>
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>
	<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
	<tr>
		<td width="10%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID üũ �Է�</font></td>
		<td width="40%" align="center" valign="middle" bgcolor="ffffff" class="01black_bold">
		<input type="text" id="m_id" name="m_id" style="width: 98%; font-family: Gothic; font-size: 9pt" maxlength="12"/>
	</td>
	</table>
	</form>
</body>
</html>