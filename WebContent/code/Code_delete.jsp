<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="kr.co.mycom.code.*"%>
<%@ page import="java.util.*"%>
    <%
    	request.setCharacterEncoding("EUC-KR");
    String my_id = (String) session.getAttribute("ID");

    if(my_id == null || my_id.equals("null")){
    	%>
    		<script type = "text/javascript">
    		alert("�α������� ������ ������ �� �����ϴ�.");
    		history.back();
    		</script>
    	<%
    }
    CodeDTO code = new CodeDTO();
    
    code.setM_code(request.getParameter("update_code"));
	code.setCboCode1(request.getParameter("cboCode1"));
	code.setCboCode2(request.getParameter("cboCode2"));
	code.setCboCode3(request.getParameter("cboCode3"));
	
	String send_cboCode = request.getParameter("send_cboCode");

	CodeDAO dao = new CodeDAO();

	String check_code = code.getM_code().substring(1, 2);
	
	boolean check = false;
    if(check_code.equals("1")){
    	check = dao.deleteCode1(code);
    }else if(check_code.equals("2")){
    	check = dao.deleteCode2(code);
    }else check = dao.deleteCode3(code);

    
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
			self.close();
			history.back();
		</script>
		<%		
		}
		%>