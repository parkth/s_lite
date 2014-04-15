<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@page import="javax.security.auth.Subject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<!-- for Enumeration -->
<%@page import="kr.co.mycom.csr.*"%>
<%@page import="kr.co.mycom.security.CheckSecurity"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
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

    long time = System.currentTimeMillis();//����ð� 
	 SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
	 String requestTime = dayTime.format(new Date(time)); //�ð����� ��� ���
	
	 String saveDir=application.getRealPath("/upload"); //���� ���� ������ ��������...
      //"C:/Users/LDCC/workspace/S-LITE v0.1/WebContent/upload"; // ������
      
      int maxSize= 1024*1024*100;//100M(����÷�� �ִ�뷮)
      String encoding = "euc-kr";//���ڵ� ���
      
      MultipartRequest m =
      new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy()); //new DefaultFileRenamePolicy() ������ ���� �ڵ� ���� ���Ⱑ �ȴ�.

      Enumeration<String> fileEnums = m.getFileNames();
		String filePath = "";
		File file = null;
		String fileName = null;

		while (fileEnums.hasMoreElements()) {
			String fileElement = (String)fileEnums.nextElement();
			file = m.getFile(fileElement);
			if (file != null) {
				fileName = file.getName();
				filePath += "|"+file;
			}
		}

	// ���� �Ѱ��ֱ� ���� ����
	CSRDTO csrDto = new CSRDTO();
	CheckSecurity checkSecurity = new CheckSecurity(); 

	String csr_title = m.getParameter("csr_title");
	csrDto.setCSR_title(checkSecurity.replaceTagToText(csr_title));
	
	String csr_detail = m.getParameter("csr_detail");
	csrDto.setCSR_detail(checkSecurity.replaceTagToText(csr_detail));


	csrDto.setCSR_code1(m.getParameter("select_csr_code1"));
	csrDto.setCSR_system_category(m.getParameter("select_csr_system_category"));
	
	csrDto.setCSR_requesttime(requestTime);
	csrDto.setCSR_id(m.getParameter("my_id"));
	csrDto.setMember_name(m.getParameter("csr_member_name"));
	csrDto.setM_code1(m.getParameter("my_company"));
	csrDto.setM_code2(m.getParameter("my_place"));
	csrDto.setM_code3(m.getParameter("my_dept"));
	csrDto.setCSR_linenum(m.getParameter("csr_linenum"));

	if(fileName != null){
		if(fileName.endsWith(".doc") || fileName.endsWith(".hwp") || fileName.endsWith(".pdf") || 
				fileName.endsWith(".txt") || fileName.endsWith(".xls") 
				|| fileName.endsWith(".xlsx"))
		{
	 		csrDto.setCSR_attachment(filePath);
		}
		else
		{
			%>
	        <script>
	 			alert("������ ���� ����� �÷��ּ���.");
	 			history.back();
	 		</script>
	 		<%
		}
	}
	
	CSRDAO csrDao = new CSRDAO();
	boolean insertResult = csrDao.insertUserCSR(csrDto);
	if (insertResult) { %>
	<script>
		alert("CSR����� �����Ͽ����ϴ�.");
		
		if(confirm('�߰�����Ͻðڽ��ϱ�?')==true){

		    location.href ="./masterpage.jsp?bo_table=E001";
		}
		else{
			location.href ="./masterpage.jsp";
		}
	</script>
<% }
 		else { %>
<script>
 			alert("CSR����� �����Ͽ����ϴ�.");
 			history.back();
 		</script>
<% } %>


