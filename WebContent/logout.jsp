<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<script type ="text/javascript">
if(confirm("�α׾ƿ� �Ͻðڽ��ϱ�?") != true){
	history.back();
}else
	{
	alert("�α׾ƿ� �Ͽ����ϴ�.");
	<%
	session.removeAttribute("ID");
	session.removeAttribute("NAME");
	%>
	location.href="index.jsp";
	}
</script>