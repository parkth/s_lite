<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="kr.co.mycom.asset.*"%>
<%@ page import="java.util.*"%>
    <%
    	request.setCharacterEncoding("EUC-KR");
    %>
<jsp:useBean id ="asset" class="kr.co.mycom.asset.AssetDTO"/>
<jsp:setProperty property="*" name="asset"/>
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

if(!master.equals("1")){
	%>
		<script type = "text/javascript">
		alert("�����ڰ� �ƴϸ� ������ �� �����ϴ�.");
		history.back();
		</script>
	<%
}

	AssetDAO dao = new AssetDAO();
	boolean check;
	boolean insert_check;
	
	if(insert_check = dao.insertA_history(asset))
	{
	
	
	if (check = dao.updateAsset(asset)) { // insert ����
		%>
		<script type="text/javascript">
			alert("�ڻ��� ���������� �����Ǿ����ϴ�. ");
			self.close();
			window.opener.location.href="../masterpage.jsp?bo_table=C002";
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
	}else
	{
		%>
		<script type="text/javascript">
			alert("������� �����Ͽ� �Է¿� �����Ͽ����ϴ�.");
			history.back();
		</script>
		<%
	}
		%>