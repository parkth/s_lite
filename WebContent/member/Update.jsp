<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="kr.co.mycom.member.*"%>
<%@ page import="java.util.*"%>
    <%
    request.setCharacterEncoding("euc-kr");
    %>
<jsp:useBean id ="member" class="kr.co.mycom.member.MemberDTO"/>
<jsp:setProperty property="*" name="member"/>
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
	String changepwd = (String) request.getParameter("m_pwd_confirm");

	MemberDAO dao = new MemberDAO();
	boolean ok = dao.updateMember(member, changepwd);
	if(ok) { 
		session.setAttribute("NAME", member.getM_name());
		session.setMaxInactiveInterval(3600);
%>

<!-- �����Ҷ� ��й�ȣ�� �´��� Ʋ���� Ȯ���Ѵ�! -->
<script type ="text/javascript">
alert("����� ���� ������ �Ϸ� �Ǿ����ϴ�.");
location.href="./masterpage.jsp?bo_table=C001";
</script>
<%
} else {
%>
<script type="text/javascript">
alert("�����Ͽ����ϴ�. �����ڿ��� �����ϼ���.");
history.back();	// �ڷ� ���ư���
</script>	
<%	}
%>