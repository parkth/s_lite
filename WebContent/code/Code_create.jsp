<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="kr.co.mycom.code.*"%>
<%@ page import="java.util.*"%>
    <%
    	request.setCharacterEncoding("EUC-KR");
    %>
<jsp:useBean id ="code" class="kr.co.mycom.code.CodeDTO"/>
<jsp:setProperty property="*" name="code"/>
<%
String my_id = (String) session.getAttribute("ID");
String master = (String) session.getAttribute("Master");

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("�α������� ������ ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
}

if(master.equals("0")){
	%>
		<script type = "text/javascript">
		alert("�����ڰ� �ƴϸ� ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
}

	CodeDAO dao = new CodeDAO();

	String check_code1 = code.getCboCode2().substring(3, 7);
	String check_code2 = code.getCboCode3().substring(3, 7);
	
	boolean check = false;
	if(check_code1.equals("0000")){
		check = dao.insertCode1(code);		
	} else if(check_code2.equals("0000")){
		check = dao.insertCode2(code);
	} else if(code.getCboCode3().startsWith("O")){
		%>
		<script type="text/javascript">
			alert("��ְ��� �ڵ�� �Һз��� �߰��� �� �����ϴ�.");
			self.close();
		</script>
		<%
	} else check = dao.insertCode3(code);
	
	if (check) { // insert ����
		%>
		<script type="text/javascript">
			alert("�ڵ尡 ���������� ��ϵǾ����ϴ�. ");
			self.close();
			window.opener.location.href="../masterpage.jsp?bo_table=code&cboCode1=<%=code.getCboCode1()%>&cboCode2=ALL";
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