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

if(my_id == null || my_id.equals("null")){
	%>
		<script type = "text/javascript">
		alert("�α������� ������ ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
}

String master = (String) session.getAttribute("Master");

if(master.equals("0")){
	%>
		<script type = "text/javascript">
		alert("�����ڰ� �ƴϸ� ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
}

	CodeDAO dao = new CodeDAO();

	String check_code1 = code.getCboCode2().substring(6, 7);
	
	String send_cboCode = code.getL_code1();

	boolean check = false;
    if(check_code1.equals("1")){
    	check = dao.updateCode1(code);
    }else if(check_code1.equals("2")){
    	if(code.getCboCode1().equals("l_code")){
    		check = dao.updateCode1(code);
    	} else check = dao.updateCode2(code);
    }else check = dao.updateCode3(code);

	if (check) { // insert ����
		%>
		<script type="text/javascript">
			alert("�ڵ尡 ���������� �����Ǿ����ϴ�. ");
			self.close();
			window.opener.location.href="../masterpage.jsp?bo_table=code&cboCode1=<%=code.getCboCode1()%>&cboCode2=<%=send_cboCode%>&cboCode3=<%=code.getCboCode3()%>";
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