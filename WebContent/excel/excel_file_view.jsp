<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="kr.co.mycom.excel.*"%>
<%@ page import="java.util.*"%>
<%@page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@page import="org.apache.poi.hssf.record.*"%>
<%@page import="org.apache.poi.hssf.model.*"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@page import="org.apache.poi.hssf.util.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.*,java.io.*"%>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.mycom.security.CheckSecurity"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String savePath = request.getRealPath("/") + "upload"; // ������ ���丮   
	String my_id = (String) session.getAttribute("ID");
	
	
	ArrayList<String> errData = new ArrayList<String>();
	
	int sizeLimit = 30 * 1024 * 1024; // �뷮����   
	String formName = "";
	String fileName = "";
	String[] aFileName = null;
	String[] aFileSize = null;
	long fileSize = 0;
	String encoding = "EUC-KR";

	Connection conn = null;
	PreparedStatement pstmt = null;

	ResultSet rs = null;
	Statement stmt = null;

	String url = "jdbc:mysql://localhost/s-lite";
	String user = "root";
	String password = "0000";

	MultipartRequest multi = new MultipartRequest(request, savePath,
			sizeLimit, encoding, new DefaultFileRenamePolicy());

	Enumeration<String> formNames = multi.getFileNames();
	
	
	while (formNames.hasMoreElements()) {
		formName = (String) formNames.nextElement();
		fileName = multi.getFilesystemName(formName);
		
		if (fileName != null) // ������ ���ε� �Ǹ�
		{
			fileSize = multi.getFile(formName).length();
		}

	}
	
		
%>
<%
		CheckSecurity checkSecurity = new CheckSecurity();
		ExcelDAO dao = new ExcelDAO();

	%>

<%
if(fileName.endsWith(".xls")){
	POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(
			savePath + "/" + fileName));

	//��ũ���� ����!                
	HSSFWorkbook workbook = new HSSFWorkbook(fs);
	int sheetNum = workbook.getNumberOfSheets();

	HSSFSheet sheet = workbook.getSheetAt(0);

	int rows = sheet.getPhysicalNumberOfRows();

	//���� ���� �б�
		String[][] content = new String[rows-1][15];
		DecimalFormat df = new DecimalFormat("#");
		try {
		for (int i = 0; i < rows-1; i++) {
			HSSFRow row = sheet.getRow(i+1);
			int cells = row.getPhysicalNumberOfCells();
			
			for (int j = 0; j < cells; j++) {
				HSSFCell cell = row.getCell(j);
				switch (cell.getCellType()) {
	
				case HSSFCell.CELL_TYPE_NUMERIC:
					if (HSSFDateUtil.isCellDateFormatted(cell)){
				          SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
				          content[i][j] = formatter.format(cell.getDateCellValue());
				     } else{
				    	//content[i][j] = String.valueOf(df.format(cell.getNumericCellValue()));
				    	 content[i][j] = String.valueOf(checkSecurity.replaceTagToText(df.format(cell.getNumericCellValue())));
				     }
					break;
	
				case HSSFCell.CELL_TYPE_STRING:
					content[i][j] = checkSecurity.replaceTagToText(cell.getStringCellValue());
					break;
				default:
				}
			}
		}
	} catch (Exception e) {
		%>
		<script type="text/javascript">
		    alert('ó���� ������ �߻��Ͽ����ϴ�\n�ùٸ� ��� ������ ����ϼ���!!');
			history.back();
		</script>
		<%
		e.printStackTrace();
	}
		dao.tempDel(my_id);
		errData = dao.insertTemp(content, my_id);//���������� �迭�� �����Ų �� �迭�� id�� DAO�� �ѱ�
}else{%>
	<script type="text/javascript">
    alert('ó���� ������ �߻��Ͽ����ϴ�\n�ùٸ� ��� ������ ����ϼ���!!');
	history.back();
	</script>
<%}%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>read Excel</title>
</head>
<body>
<div align="left">�� �ڻ�������� �� �ڻ���(Excel)</div>
<br><br><br>
<form action = ".\masterpage.jsp?bo_table=C001_excel_addvalue" method=post>
<table width="95%" border="0" cellspacing="1">
	<tr>
		<td align="right"><input type = "submit" value = "����" style="width: 100px;height: 30px; font-family: Gothic; font-size: 9pt"><br><br></td>
	</tr>
</table>
</form>	


	<%
		List<ExcelDTO> result_lists = dao.readDB(my_id);
	%>

<table>
	<%if(errData.size()>0){%>
		<tr><td>���� <%=errData.size()/19%>���� �ڷᰡ ���Ŀ� ���� �ʾ� ��ϵ��� �ʾҽ��ϴ�.</td></tr>
		
		</table>
	<table width="95%" align="center" border="0" cellspacing="1"
		bgcolor="000000">
<tr>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">���ȣ</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������ȣ</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ڻ걸��</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ڻ�����</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ڻ�����</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ǰ��</font></td>
	<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Model</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������</font></td>
	<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ȸ��</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�μ�</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ġ</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�̸�</font></td>
	<td width="6%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����</font></td>
</tr>
		<%for(int i = 0; i<errData.size(); i=i+20){%>
<tr>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i)%></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+1)%></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+10)%></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+11)%></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+12)%></td>
	
	<%if(errData.get(i+13).length()>5){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+13).substring(0,4)%>...</td>
	<%}else{ %>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+13)%></td>
	<%} %>
	
	<%if(errData.get(i+14).length()>5){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+14).substring(0,4)%>...</td>
	<%}else{ %>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+14)%></td>
	<%} %>
	
	<%if(errData.get(i+15).length()>5){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+15).substring(0,4)%>...</td>
	<%}else{ %>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+15)%></td>
	<%} %>
	
	
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+2)%></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+3)%></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+4)%></td>
	
	<%if(errData.get(i+5).length()>5){%>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+5).substring(0,4)%>...</td>
	<%}else{ %>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+5)%></td>
	<%} %>
	
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+7)%></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=errData.get(i+8)%></td>
</tr>
<%} %>
</table>
	<%}else{ %>
	<tr><td><%=result_lists.size()%>���� �ڷᰡ ��ϵǾ����ϴ�.</td></tr>
	</table>
	<table width="95%" align="center" border="0" cellspacing="1"
		bgcolor="000000">
<tr>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������ȣ</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ڻ걸��</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ڻ�����</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�ڻ�����</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ǰ��</font></td>
	<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">Model</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">������</font></td>
	<td width="7%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">ȸ��</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�μ�</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">��ġ</font></td>
	<td width="5%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�̸�</font></td>
	<td width="6%" align="center" valign="middle" class="01black_bold" bgcolor="#A7A9AC"><font color="white">�����</font></td>
</tr>
			<%
				for (ExcelDTO result_obj : result_lists) {
			%>
<tr>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_gnum() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_code1() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_code2() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_code3() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_aname() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_amodel() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_vendorname() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_company() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_place() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_dept() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_locate() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_name() %></td>
	<td align="center" valign="middle" class="01black_bold" bgcolor="ffffff"><%=result_obj.getA_getdate() %></td>
</tr>
		<%
				}
		%>
	</table>
	<%} %>

</body>
</html>