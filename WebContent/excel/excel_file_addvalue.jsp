<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.excel.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String my_id = (String) session.getAttribute("ID");
	
	ExcelDAO excel_DAO = new ExcelDAO(); 
	if(excel_DAO.insertAsset(my_id)){
%>
<script>
	alert("�ڻ��� ��� �Է� �Ǿ����ϴ�.");
</script>
<%
	}else{
%>
<script>
	alert("�ڻ��� �Էµ��� �ʾҽ��ϴ�. ÷�������� Ȯ���ϼ���.");
</script>
<%
	}
%>
<script>
	location.href="masterpage.jsp?bo_table=C001_excel";
</script>
</body>
</html>