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
		alert("로그인하지 않으면 접근할 수 없습니다.");
		history.back();
		</script>
	<%
}
	String changepwd = (String) request.getParameter("m_pwd_confirm");

	MemberDAO dao = new MemberDAO();
	boolean ok = dao.updateMember(member, changepwd);
	if(ok) { 
%>

<!-- 수정할때 비밀번호가 맞는지 틀린지 확인한다! -->
<script type ="text/javascript">
alert("사용자 정보 수정이 완료 되었습니다.");
window.opener.location.href="../masterpage.jsp?bo_table=member_admin&member_company=<%=member_company %>&member_place=<%=member_place %>&member_dept=<%=member_dept %>";
self.close();
</script>
<%
} else {
%>
<script type="text/javascript">
alert("실패하였습니다. 관리자에게 문의하세요.");
history.back();	// 뒤로 돌아가기
</script>	
<%	}
%>