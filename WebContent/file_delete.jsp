<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*"%>
 <%@ page import="kr.co.mycom.obstacle.*"%>
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
 ObstacleDAO dao=new ObstacleDAO();
 // �ѱ� ������ �� ����
 String filePath = new String(request.getParameter("filePath").getBytes("Cp1252"), "EUC-KR"); //������ ���ϰ��
 String fileFullPath = new String(request.getParameter("fileFullPath").getBytes("Cp1252"), "EUC-KR"); //��� ����� Ǯ���
 String O_rnum= new String(request.getParameter("O_rnum")); //����̳�
 StringTokenizer tokens = new StringTokenizer(fileFullPath, "|");
 
 
 File deleteFile=new File(filePath);
 if(deleteFile.exists()) deleteFile.delete();
 
 //updateCustomer_Obstacle
 String oneFilePath = null;
 String UpdateFilePath="";
 boolean result=false;
 while (tokens.hasMoreElements()) {
	 oneFilePath = tokens.nextToken();
	 if(oneFilePath.equals(filePath)){}
	 else{
		 UpdateFilePath+="|"+oneFilePath;
	 }
 }
 if(UpdateFilePath==null){
	 result=dao.updateCustomer_Obstacle("",O_rnum);
 }
 else {
	 System.out.println("������");
	result=dao.updateCustomer_Obstacle(UpdateFilePath,O_rnum);
 }
 
 if(result){
 	%>
	 <script type="text/javascript">
	 alert("�����Ǿ����ϴ�. ");
	 location.href="./obstacle/D003_admin.jsp?o_rnum="+'<%=O_rnum%>';
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