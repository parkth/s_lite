<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.member.*"%>
    
<%
	String id = request.getParameter("m_id");
	MemberDAO dao = new MemberDAO();
	boolean ok = dao.idcheck(id);
	String my_id = (String) session.getAttribute("ID");

	if(my_id == null || my_id.equals("null")){
		%>
			<script type = "text/javascript">
			alert("�α������� ������ ������ �� �����ϴ�.");
			history.back();
			</script>
		<%
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ID �ߺ� üũ</title>
<link rel="stylesheet" type="text/css" href="../common.css" />

<script type="text/javascript">
	
	function choice_id(id) {
		opener.join_form.m_id.value = id;  
		self.close(); 
	}
</script>
</head>
<body>
<table width="95%" align="center">
<tr>
<td align="left">�� ����ڰ��� �� ID üũ Ȯ��</td>
<td align="right">
</tr>
</table>
<table>
		<tr>
			<td style="height: 30px"></td>
		</tr>
	</table>
	<%
		if (ok) {//email�ߺ�
	%>
	<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
	<tr><td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID �ߺ�üũ</font></td>
	</tr>
	<tr><td align="center" valign="middle" class="01black_bold" bgcolor="ffffff">
	<%=id%>�� �̹� �����ϴ� ���̵��Դϴ�. <br>�ٽ� �˻����ּ���.
	<a href="javascript:history.back();"><font color="#DA291C">�ڷΰ���</font></a>
	<br></td>
	</tr>
	</table>
	<%
		} else {
	%>
	<table width="95%" align="center" border="0" cellspacing="1" bgcolor="000000">
	<tr><td align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ID �ߺ�üũ</font></td>
	</tr>
	<tr><td align="center" valign="middle" class="01black_bold" bgcolor=ffffff>
	<%=id%>
	�� ��� �����մϴ�.
	<br>
	<a href="javascript:choice_id('<%=id%>')"><font color="#DA291C"><%=id%></font></a> �� ���
	</td></tr>
	</table>
	<%
		}
	%>
	

</body>
</html>