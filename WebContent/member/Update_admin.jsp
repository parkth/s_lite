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

String member_company = (String) request.getParameter("member_company");
String member_place = (String) request.getParameter("member_place");
String member_dept = (String) request.getParameter("member_dept");

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
%>

<!-- �����Ҷ� ��й�ȣ�� �´��� Ʋ���� Ȯ���Ѵ�! -->
<script type ="text/javascript">
alert("����� ���� ������ �Ϸ� �Ǿ����ϴ�.");
window.opener.location.href="../masterpage.jsp?bo_table=member_admin&member_company=<%=member_company %>&member_place=<%=member_place %>&member_dept=<%=member_dept %>";
self.close();
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