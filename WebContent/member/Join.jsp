<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.member.*"%>

<%
	request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="member" class="kr.co.mycom.member.MemberDTO" />
<jsp:setProperty property="*" name="member" />
<%
String my_id = (String) session.getAttribute("ID");

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("�α������� ������ ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
}
	MemberDAO dao = new MemberDAO();
	boolean ok = dao.insertMember(member);
	if (ok) { // insert ����
%>
<script type="text/javascript">
alert("����ڰ� ���������� ��ϵǾ����ϴ�. ");
self.close();
window.opener.location.href="../masterpage.jsp?bo_table=member_admin";
</script>
<%
	} else { // ����
%>
<script type="text/javascript">
alert("�����Ͽ����ϴ�. �����ڿ��� �����ϼ���.");
history.back();
</script>
<%
	
	}
%>
