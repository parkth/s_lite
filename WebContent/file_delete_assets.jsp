<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*"%>
 <%@ page import="kr.co.mycom.asset.*"%>
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
AssetDAO dao=new AssetDAO();
 // �ѱ� ������ �� ����
 String filePath = new String(request.getParameter("filePath").getBytes("Cp1252"), "EUC-KR");
 String fileFullPath = new String(request.getParameter("fileFullPath").getBytes("Cp1252"), "EUC-KR");
 String anum= new String(request.getParameter("anum")); //����̳�
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
	 result=dao.update_Asset("",anum);
 } else {
	 result=dao.update_Asset(UpdateFilePath,anum);
 }
 
 if(result){
 	%>
	 <script type="text/javascript">
	 alert("�����Ǿ����ϴ�. ");
	 location.href="./asset/C003_admin.jsp?anum="+'<%=anum%>';
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