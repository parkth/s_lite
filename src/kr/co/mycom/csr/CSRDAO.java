package kr.co.mycom.csr;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CSRDAO {
	public Connection getCon() {
		Connection con = null;
		Context initContext = null;
		DataSource ds = null;

		try {
			initContext = new InitialContext();
			ds = (DataSource) initContext.lookup("java:comp/env/jdbc/s-lite");
			con = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	} // getCon
	
public CSRDTO getData(String csr_rnum){
		
		String sql="SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_detail, csr.csr_system_category, csr.csr_code1, csr.csr_requesttime ";
		sql += ", csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, csr.csr_dept, csr.csr_linenum, csr.csr_enable ";
		
		sql += ", csr_code1.csr_name, csr_code1.csr_code1 ";
		sql += ", csr_system_category.csr_system_category_name, csr_system_category.csr_system_category "; 
		sql += ", m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2 ";
		sql += ", m_code3.m_name, m_code3.m_code3 ";
		
		sql += ", csr.csr_previewer, csr.csr_solvingtime, csr.csr_estimate_solvetime, csr.csr_preview_result, csr.csr_dependentsystem_flag, csr.csr_dependentsystem ";
		
		sql += ", csr.csr_solvedtime, csr.csr_reason, csr.csr_processing_contents, csr.csr_estimate_md, csr.csr_complete_md, csr.csr_client_comment, csr.csr_finishtime ";
		sql += ", csr.csr_attachment ";
		
		sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1 LEFT JOIN csr_system_category ON csr_system_category.csr_system_category=csr.csr_system_category )) ";	
		sql += "WHERE csr_rnum=?";
		
/*		String sql="SELECT csr.csr_rnum, csr.csr_title, csr.csr_ograde, ";
		sql += "csr_code1.csr_name, csr_code1.csr_code1, csr_code2.csr_name, csr_code2.csr_code2, ";
		sql += "csr.csr_opath, csr.csr_vendorname, csr.csr_a_name, csr.csr_a_namecode, ";
		sql += "csr.csr_occurrencetime, csr.csr_requesttime, ";
		sql += "m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2, ";
		sql += "m_code3.m_name, m_code3.m_code3, csr.csr_linenum, csr.csr_name, ";
		sql += "csr.csr_detail, csr.csr_attachment, csr.csr_state, ";
		sql += "csr.csr_reason, csr.csr_resolvedetail, csr.csr_engineer, ";
		sql += "csr.csr_requestdetail, csr.csr_attachment_engineer, ";
		sql += "csr.a_name, csr.a_linenum, csr.a_anum ";
		
		sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1) LEFT JOIN csr_code2 ON csr.csr_code2=csr_code2.csr_code2 ) ";	
		sql += "WHERE csr_rnum=?";*/
		
		CSRDTO dto = new CSRDTO();
		String State="";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			ps.setString(1, csr_rnum);
			rs = ps.executeQuery();
			

			if (rs.next()) { // ����� ������
				dto.setCSR_rnum(rs.getString("csr.csr_rnum"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setCSR_title(rs.getString("csr.csr_title"));
				
				if((rs.getString("csr_code1.csr_name")==null)) {
					dto.setCSR_code1_m_name("");
					dto.setCSR_code1("");
				}
				else{
					dto.setCSR_code1_m_name(rs.getString("csr_code1.csr_name"));
					dto.setCSR_code1(rs.getString("csr_code1.csr_code1"));
				}
				
				if((rs.getString("csr_system_category.csr_system_category_name")==null)) {
					dto.setCSR_system_category_m_name("");
					dto.setCSR_system_category("");
				}
				else{
					dto.setCSR_system_category_m_name(rs.getString("csr_system_category.csr_system_category_name"));
					dto.setCSR_system_category(rs.getString("csr_system_category.csr_system_category"));
				}
				
				dto.setCSR_requesttime(rs.getString("csr.csr_requesttime"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code1(rs.getString("m_code1.m_code1"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code2(rs.getString("m_code2.m_code2"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setM_code3(rs.getString("m_code3.m_code3"));
				dto.setCSR_linenum(rs.getString("csr.csr_linenum"));
				dto.setCSR_name(rs.getString("csr.csr_name"));
				dto.setMember_name(rs.getString("csr.csr_name"));
				dto.setCSR_detail(rs.getString("csr.csr_detail"));
				String digit_state = rs.getString("csr_state");
				if(digit_state.equals("0")) State="��û";
				else if(digit_state.equals("1")) State="�ذ���";
				else if(digit_state.equals("2")) State="�ذ�";
				else if(digit_state.equals("3")) State="����";
				dto.setCSR_state(State);
				dto.setCSR_digit_state(digit_state);
				
				dto.setCSR_previewer(rs.getString("csr_previewer"));
				dto.setCSR_solvingtime(rs.getString("csr_solvingtime"));
				dto.setCSR_estimate_solvetime(rs.getString("csr_estimate_solvetime"));
				dto.setCSR_preview_result(rs.getString("csr_preview_result"));
				

				dto.setCSR_dependentsystem_flag(rs.getString("csr_dependentsystem_flag"));
				dto.setCSR_dependentsystem(rs.getString("csr_dependentsystem"));
				

				dto.setCSR_solvedtime(rs.getString("csr_solvedtime"));
				dto.setCSR_reason(rs.getString("csr_reason"));
				dto.setCSR_processing_contents(rs.getString("csr_processing_contents"));
				dto.setCSR_estimate_md(rs.getString("csr_estimate_md"));
				dto.setCSR_complete_md(rs.getString("csr_complete_md"));

				dto.setCSR_client_comment(rs.getString("csr_client_comment"));
				dto.setCSR_finishtime(rs.getString("csr_finishtime"));
				
				// null�̸� ����� ����
				dto.setCSR_reason((rs.getString("csr.csr_reason") == null) ? "" : rs.getString("csr.csr_reason"));
				dto.setCSR_attachment(rs.getString("csr.csr_attachment"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}

		return dto;
	}
	
	public List<CSRDTO> searchCode() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT * FROM M_CODE3";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		//String deptCheck = code + "%";
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			//ps.setString(1, deptCheck);
			rs = ps.executeQuery();
			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setDept(rs.getString("m_code3"));
				dto.setDept_name(rs.getString("m_name"));
				dto.setEnable(rs.getString("m_enable"));
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	public List<CSRDTO> searchCSR_Code() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();
		String sql = "SELECT * FROM CSR_CODE1 where csr_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		//String deptCheck = code + "%";
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setCSR_code1(rs.getString("CSR_code1"));
				dto.setCSR_name(rs.getString("CSR_name"));
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
		
	// Jinyoung
	
	public List<CSRDTO> getCSRCode1List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT * FROM csr_code1 WHERE `csr_code1` LIKE 'C1%' AND csr_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setCSR_code1(rs.getString("csr_code1"));
				dto.setCSR_code1_m_name(rs.getString("csr_name"));
				
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<CSRDTO> getCSRSystemCategoryList() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT * FROM csr_system_category WHERE `csr_system_category` LIKE 'C2%' AND csr_system_category_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setCSR_system_category(rs.getString("csr_system_category"));
				dto.setCSR_system_category_m_name(rs.getString("csr_system_category_name"));
				
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	
	
	public List<CSRDTO> getMCode1List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT m_code1, m_name FROM m_code1 WHERE m_enable='1'";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setM_code1(rs.getString("m_code1"));
				dto.setM_code1_m_name(rs.getString("m_name"));
				
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
		
	public List<CSRDTO> getMCode2List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT m_code1.m_code1, m_code1.m_name, m_code2.m_code2, m_code2.m_name FROM m_code1 INNER JOIN m_code2 ON m_code1.m_code1 = m_code2.m_code1;";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setM_code1(rs.getString("m_code1.m_code1"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code2(rs.getString("m_code2.m_code2"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	public List<CSRDTO> getMCode3List() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT m_code1.m_code1, m_code1.m_name, m_code2.m_code2, m_code2.m_name, m_code3.m_code3, m_code3.m_name FROM m_code1 INNER JOIN (m_code2 INNER JOIN m_code3 ON m_code2.m_code2 = m_code3.m_code2) ON m_code1.m_code1 = m_code2.m_code1;";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setM_code1(rs.getString("m_code1.m_code1"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code2(rs.getString("m_code2.m_code2"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code3(rs.getString("m_code3.m_code3"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	
	// �����ڰ� CSR �ۼ�
	public boolean insertCSR(CSRDTO dto) {
		boolean result = false;
	
		/*
		 * csr_rnum ����, csr_state = 0, csr_id�� ���� �α����� ����� ���̵�,  
		 */
		
		String sql = "INSERT INTO csr(csr_rnum, csr_state, csr_title, csr_detail, ";
		sql += "csr_system_category, csr_code1, csr_requesttime, ";
		sql += "csr_id, csr_name, csr_company, csr_place, csr_dept, csr_linenum, csr_enable) ";
		sql += "VALUES (?, '0', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '1');"; 

		String sql_rnum = "SELECT csr_rnum FROM csr ORDER BY csr_rnum DESC;";
		String csr_rnum = null;
		
		Connection con = null;
		PreparedStatement ps = null; // �غ�� ��� ������? ���� ??���� ä��ڴ�.
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql_rnum);
			rs = ps.executeQuery();
			if (rs.next()) { // ����� ������
				
				csr_rnum = rs.getString("csr_rnum");
				String[] split_code = csr_rnum.split("_");
				int temp = Integer.parseInt(split_code[1]);
				temp++;
				csr_rnum = split_code[0] +"_"+ String.format("%08d", temp);
			}
			
			/* ? ���� : �� 12��
			   csr��ȣ, ����, ����, �ý��۱���, CSR����, ��û�ð�, 
			   ��id, ����, ����, �����, �μ�, ������ó
			 */			
			ps = con.prepareStatement(sql);
			ps.setString(1, csr_rnum);
			ps.setString(2, dto.getCSR_title());
			ps.setString(3, dto.getCSR_detail());
			ps.setString(4, dto.getCSR_system_category());
			ps.setString(5, dto.getCSR_code1());
			ps.setString(6, dto.getCSR_requesttime());
			ps.setString(7, dto.getCSR_id());
			ps.setString(8, dto.getMember_name());
			ps.setString(9, dto.getM_code1());
			ps.setString(10, dto.getM_code2());
			ps.setString(11, dto.getM_code3());
			ps.setString(12, dto.getCSR_linenum());
			
			
			int cnt = ps.executeUpdate();
			if (cnt == 1)
				result = true; // executeUpdate �� �����ϸ� 1�� ��ȯ�Ѵ�.
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		
		return result;
	}
	
	public boolean updateCSR(CSRDTO dto) {
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_title=?, csr_detail=?, csr_system_category=?, csr_code1=?, csr_company=?, csr_dept=?, csr_name=?, csr_linenum=?, ";
		
		
		if (dto.getCSR_state().equals("�ذ���")) {
			//	4�� : ��������������, ����������, ���� �޴� �ý��� �÷���, ����޴½ý���,
			sql += "csr_previewer=?, csr_estimate_solvetime=?, csr_preview_result=?, csr_dependentsystem_flag=?, csr_dependentsystem=?, " ;
			sql += ", csr_state=?";
			sql += ", csr_solvingtime=? ";
		}
		else if (dto.getCSR_state().equals("�ذ�")) {
			//	4�� : CSR����, ó������, �������, �Ϸ���� 
			sql += "csr_reason=?, csr_processing_contents=?, csr_estimate_md=?, csr_complete_md=? ";
			sql += ", csr_state=?";
			sql += ", csr_solvedtime=? ";
		}
		else if (dto.getCSR_state().equals("����")) {
			sql += ", csr_state=?";
			sql += ", csr_finishtime=? ";
		}
		
		sql += "WHERE csr_rnum=?"; 
		
		Connection con = null;
		PreparedStatement ps = null;
		
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			/* parameter ����. ����κ� 8��
			 ����, ��û����, �ý��۱���, csr����, ����, �μ�, ��û����, ������ó,
			 
			 */

			/* state ��ȭ�� ���� �߰��κ�. 2��
			 �������, {solvingtime | solvedtime | finishtime } *?

			/* ������ parameter ������ȣ */
		
			ps.setString(1, dto.getCSR_title());
			ps.setString(2, dto.getCSR_detail());
			ps.setString(3, dto.getCSR_system_category());
			ps.setString(4, dto.getCSR_code1());
			ps.setString(5, dto.getM_code1());
			ps.setString(6, dto.getM_code3());
			ps.setString(7, dto.getMember_name());
			ps.setString(8, dto.getCSR_linenum());
			
			
			int state = 0;
			
			if (dto.getCSR_state().equals("��û")) {
				ps.setString(9, dto.getCSR_rnum());
			}
			if (dto.getCSR_state().equals("�ذ���")) {
//				4�� : ��������������, ����������, ���� �޴� �ý��� �÷���, ����޴½ý���,
				state = 1;
				ps.setString(9, dto.getCSR_previewer());
				ps.setString(10, dto.getCSR_preview_result());
				ps.setString(11, dto.getCSR_dependentsystem_flag());
				ps.setString(12, dto.getCSR_dependentsystem());
				
				ps.setString(13, String.valueOf(state));
				ps.setString(14, dto.getCSR_solvingtime());
				ps.setString(15, dto.getCSR_rnum());
			}
			if (dto.getCSR_state().equals("�ذ�")) {
//				4�� : CSR����, ó������, �������, �Ϸ���� 
				state = 2;
				ps.setString(9, dto.getCSR_reason());
				ps.setString(10, dto.getCSR_processing_contents());
				ps.setString(11, dto.getCSR_estimate_md());
				ps.setString(12, dto.getCSR_complete_md());
				
				ps.setString(13, String.valueOf(state));
				ps.setString(14, dto.getCSR_solvedtime());
				ps.setString(15, dto.getCSR_rnum());
			}	
			if (dto.getCSR_state().equals("����")) {
				state = 3;
				ps.setString(9, String.valueOf(state));
				ps.setString(10, dto.getCSR_finishtime());
				ps.setString(11, dto.getCSR_rnum());
			}
			
			int cnt =ps.executeUpdate();	
			if(cnt==1) result = true; // ���� ok
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
	
		return result;
	}

	public ArrayList<String> getCSR_Code() {
		ArrayList<String> A_search = new ArrayList<String>();
		String sql = "SELECT csr_code1 from csr_code1 where csr_enable='1'";
		Connection con = null;
		PreparedStatement ps = null; // �غ�� ��� ������? ���� ??���� ä��ڴ�.
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) { // ����� ������
				A_search.add(rs.getString("csr_code1"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return A_search;
	}

	// �Ϲ� ���� CSR �ۼ�
	public boolean insertUserCSR(CSRDTO dto) {
		boolean result = false;
	
		/*
		 * csr_rnum ����, csr_state = 0, csr_id�� ���� �α����� ����� ���̵�,  
		 */
		
		String sql = "INSERT INTO csr(csr_rnum, csr_state, csr_title, csr_detail, ";
		sql += "csr_system_category, csr_code1, csr_requesttime, ";
		sql += "csr_id, csr_name, csr_company, csr_place, csr_dept, csr_linenum, csr_enable, csr_attachment) ";
		sql += "VALUES (?, '0', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, '1', ?);"; 

		String sql_rnum = "SELECT csr_rnum FROM csr ORDER BY csr_rnum DESC;";
		String csr_rnum = null;
		
		Connection con = null;
		PreparedStatement ps = null; // �غ�� ��� ������? ���� ??���� ä��ڴ�.
		ResultSet rs = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql_rnum);
			rs = ps.executeQuery();
			if (rs.next()) { // ����� ������
				
				csr_rnum = rs.getString("csr_rnum");
				if(csr_rnum == null)
					csr_rnum = "C_00000001";
				String[] split_code = csr_rnum.split("_");
				int temp = Integer.parseInt(split_code[1]);
				temp++;
				csr_rnum = split_code[0] +"_"+ String.format("%08d", temp);
			}
			
			/* ? ���� : �� 12��
			   csr��ȣ, ����, ����, �ý��۱���, CSR����, ��û�ð�, 
			   ��id, ����, ����, �����, �μ�, ������ó
			 */			
			ps = con.prepareStatement(sql);
			ps.setString(1, csr_rnum);
			ps.setString(2, dto.getCSR_title());
			ps.setString(3, dto.getCSR_detail());
			ps.setString(4, dto.getCSR_system_category());
			ps.setString(5, dto.getCSR_code1());
			ps.setString(6, dto.getCSR_requesttime());
			ps.setString(7, dto.getCSR_id());
			ps.setString(8, dto.getMember_name());
			ps.setString(9, dto.getM_code1());
			ps.setString(10, dto.getM_code2());
			ps.setString(11, dto.getM_code3());
			ps.setString(12, dto.getCSR_linenum());
			ps.setString(13, dto.getCSR_attachment());
			
			int cnt = ps.executeUpdate();
			if (cnt == 1)
				result = true; // executeUpdate �� �����ϸ� 1�� ��ȯ�Ѵ�.
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		
		return result;
	}
	
	///�ŴϰŴϰŴ�
	public boolean updateCustomer_CSR(String FilePath,String CSR_rnum) {
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_attachment=? WHERE csr_rnum=?";
	
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			/* parameter ����. ����κ� 23��
			 ����, ��з�, �ߺз�, ��ֵ��, �������,
			 ����, ������, ����, �μ�, ��û����, 
			 ������ó, ��ֹ߻��ð�, �������, ���������, ��ֿ���, 
			 �����ġ����, ������û����, ������÷������, ����code, �����id,
			 ������̸�, �������ȭ��ȣ, �ڻ��ȣ */

			/* state ��ȭ�� ���� �߰��κ�. 2��
			 �������, {solvingtime | solvedtime | finishtime } *?

			/* ������ parameter ������ȣ */
		
			ps.setString(1,FilePath);
			ps.setString(2, CSR_rnum);
			
			int cnt =ps.executeUpdate();	
			if(cnt==1) result = true; // ���� ok
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
	
		return result;
	}
	public boolean updateAdmin_CSR(String FilePath,String CSR_rnum) {
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_attachment_engineer=? WHERE csr_rnum=?";
	
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			
			/* parameter ����. ����κ� 23��
			 ����, ��з�, �ߺз�, ��ֵ��, �������,
			 ����, ������, ����, �μ�, ��û����, 
			 ������ó, ��ֹ߻��ð�, �������, ���������, ��ֿ���, 
			 �����ġ����, ������û����, ������÷������, ����code, �����id,
			 ������̸�, �������ȭ��ȣ, �ڻ��ȣ */

			/* state ��ȭ�� ���� �߰��κ�. 2��
			 �������, {solvingtime | solvedtime | finishtime } *?

			/* ������ parameter ������ȣ */
		
			ps.setString(1,FilePath);
			ps.setString(2, CSR_rnum);
			
			int cnt =ps.executeUpdate();	
			if(cnt==1) result = true; // ���� ok
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
	
		return result;
	}
	
	//csr��� �����ֱ�_����
	public List<CSRDTO> showCSR(String csr_rnum, String SearchStartDay, String SearchEndDay, String SearchStartDay2, 
			String SearchEndDay2, String csr_category, String csr_place, String csr_dept,
			String code1, String state, String csr_company, String csr_name, String csr_title) {
		String sql = "SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_previewer, csr.csr_detail, csr.csr_system_category, csr.csr_code1, csr.csr_requesttime ";
		sql += ", csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, csr.csr_dept, csr.csr_linenum, csr.csr_enable, csr.csr_solvingtime, csr.csr_preview_result, csr.csr_dependentsystem, csr.csr_solvedtime, csr.csr_finishtime, csr.csr_reason, csr.csr_processing_contents, csr.csr_estimate_md, csr.csr_complete_md, csr.csr_client_comment ";
		
		sql += ", csr_code1.csr_name, csr_code1.csr_code1 ";
		sql += ", csr_system_category.csr_system_category_name, csr_system_category.csr_system_category "; 
		sql += ", m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2 ";
		sql += ", m_code3.m_name, m_code3.m_code3, csr.csr_estimate_solvetime ";
		sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) " +
				"LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1 " +
				"LEFT JOIN csr_system_category ON csr_system_category.csr_system_category=csr.csr_system_category )) WHERE csr.csr_rnum = ";
		
		List<CSRDTO> lists = new ArrayList<CSRDTO>();			
		
		if(csr_rnum !=""){
			sql=sql+"'"+csr_rnum+"'";
		}
		else if(csr_rnum=="" && SearchStartDay!=""){
			
			/*sql = "SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_detail, csr.csr_system_category, csr.csr_code1, csr.csr_requesttime ";
			sql += ", csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, csr.csr_dept, csr.csr_linenum, csr.csr_enable ";
			
			sql += ", csr_code1.csr_name, csr_code1.csr_code1 ";
			sql += ", csr_system_category.csr_system_category_name, csr_system_category.csr_system_category "; */
			
			sql = "SELECT csr.csr_rnum, csr.csr_state, csr.csr_title, csr.csr_detail, csr.csr_system_category, " +
					"csr.csr_code1, csr.csr_requesttime, csr.csr_id, csr.csr_name, csr.csr_company, csr.csr_place, " +
					"csr.csr_dept, csr.csr_linenum, csr.csr_enable, csr.csr_previewer, csr.csr_solvingtime, " +
					"csr.csr_estimate_solvetime, csr.csr_preview_result, csr.csr_dependentsystem_flag, csr.csr_dependentsystem, " +
					"csr.csr_solvedtime, csr.csr_finishtime, csr.csr_reason, csr.csr_processing_contents, " +
					"csr.csr_estimate_md, csr.csr_complete_md, csr.csr_client_comment";
			sql += ", m_code1.m_name, m_code1.m_code1, m_code2.m_name, m_code2.m_code2 ";
			sql += ", m_code3.m_name, m_code3.m_code3, csr.csr_estimate_solvetime ";
			sql += ", csr_system_category.csr_system_category_name, csr_code1.csr_name ";
			
			sql += "FROM (((((m_code3 INNER JOIN csr ON m_code3.m_code3=csr.csr_dept) JOIN m_code1 ON csr.csr_company=m_code1.m_code1) JOIN m_code2 ON csr.csr_place = m_code2.m_code2) " +
					"LEFT JOIN csr_code1 ON csr_code1.csr_code1=csr.csr_code1 " +
					"LEFT JOIN csr_system_category ON csr_system_category.csr_system_category=csr.csr_system_category )) WHERE ";
		
			if(SearchStartDay!="" && SearchEndDay!=""){
				sql+=" DATE_FORMAT(csr.csr_requesttime,'%Y%m%d') BETWEEN "+SearchStartDay+"01" + " AND " + SearchEndDay+"31";
				
			}
			/*if(SearchStartDay2!="" && SearchEndDay2!="")
				sql+=" AND DATE_FORMAT(csr.csr_estimate_solvetime,'%Y%m%d') BETWEEN "+SearchStartDay+"01" + " AND " + SearchEndDay+"31";*/
			
			if(state!=""){
				sql+= " AND csr.csr_state="+"'"+state+"'";
				if(!state.equals("0")){
					if(SearchStartDay2!="" && SearchEndDay2!=""){
						sql+=" AND DATE_FORMAT(csr.csr_estimate_solvetime,'%Y%m%d') BETWEEN "+SearchStartDay+"01" + " AND " + SearchEndDay+"31";
					}
				}
				
			}
			if(!code1.equals("C1_0000"))
				sql+=" AND csr.csr_code1="+"'"+code1+"'";
			
			System.out.println(csr_rnum);
			
			if(csr_rnum !="")
				sql+=" AND csr.csr_rnum="+"'"+ csr_rnum +"'";
			
			if(!csr_category.equals("E_00000"))
				sql+=" AND csr.csr_system_category="+"'"+csr_category+"'";
			
			if(csr_title!=(""))
				sql+=" AND csr.csr_title like "+"'%"+csr_title+"%'";
			
			if (csr_company.equals("C_00000") && csr_place.equals("P_00000")
					&& csr_dept.equals("D_00000")) {
				
			} else if ((!csr_company.equals("C_00000")) && csr_place.equals("P_00000")) {
				sql += " AND csr.csr_company= " + "'" + csr_company + "'";
			} else if ((!csr_company.equals("C_00000"))
					&& (!csr_place.equals("P_00000")) && (csr_dept.equals("D_00000"))) {
				sql += " AND csr.csr_company= " + "'" + csr_company + "'" + "AND csr.csr_place= "
						+ "'" + csr_place + "'";
			} else {
				sql += " AND csr.csr_company= " + "'" + csr_company + "'"+" AND csr.csr_place= "
				+ "'" + csr_place + "'" + " AND csr.csr_dept= "
						+ "'" + csr_dept + "'"  ;
			}
			if(csr_name!="") 
				sql+= " AND csr.csr_name="+"'"+csr_name+"'";
			sql += " order by csr.csr_requesttime desc";
			
		}
		
		System.out.println(sql);
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			//ps.setString(1, deptCheck);
			rs = ps.executeQuery();
			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				
	
				/*dto.setCSR_rnum(rs.getString("csr_rnum"));
				dto.setCSR_state(rs.getString("csr_state"));
				dto.setCSR_title(rs.getString("csr_title"));
				dto.setCSR_title(rs.getString("csr_detail"));
				dto.setCSR_system_category(rs.getString("csr_system_category"));
				dto.setCSR_system_category_m_name(rs.getString("csr_system_category.csr_system_category_name"));
				dto.setCSR_code1(rs.getString("csr_code1"));
				dto.setCSR_code1_m_name(rs.getString("csr_code1.csr_name"));
				dto.setCSR_requesttime(rs.getString("csr_requesttime"));
				dto.setMember_name(rs.getString("csr_id"));
				dto.setMember_name(rs.getString("csr_name"));
				dto.setM_code3_m_name(rs.getString("csr_company"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setCSR_estimate_solvetime(rs.getString("csr_estimate_solvetime"));*/
				
				dto.setCSR_rnum(rs.getString("csr_rnum"));
				dto.setCSR_state(rs.getString("csr_state"));
				dto.setCSR_title(rs.getString("csr_title"));
				dto.setCSR_detail(rs.getString("csr_detail"));
				dto.setCSR_system_category(rs.getString("csr_system_category"));
				dto.setCSR_system_category_m_name(rs.getString("csr_system_category.csr_system_category_name"));
				dto.setCSR_code1(rs.getString("csr_code1"));
				dto.setCSR_code1_m_name(rs.getString("csr_code1.csr_name"));
				dto.setCSR_requesttime(rs.getString("csr_requesttime"));
				dto.setCSR_id(rs.getString("csr_id")); 
				dto.setMember_name(rs.getString("csr_name"));
				dto.setM_code1_m_name(rs.getString("m_code1.m_name"));
				dto.setM_code2_m_name(rs.getString("m_code2.m_name"));
				dto.setM_code3_m_name(rs.getString("m_code3.m_name"));
				dto.setCSR_linenum(rs.getString("csr_linenum"));
				  
				dto.setCSR_previewer(rs.getString("csr_previewer")); 
				dto.setCSR_solvingtime(rs.getString("csr_solvingtime"));
				dto.setCSR_estimate_solvetime(rs.getString("csr_estimate_solvetime")); 
				dto.setCSR_preview_result(rs.getString("csr_preview_result"));
				 
				dto.setCSR_dependentsystem(rs.getString("csr_dependentsystem"));
				  
				dto.setCSR_solvedtime(rs.getString("csr_solvedtime")); 
				dto.setCSR_finishtime(rs.getString("csr_finishtime"));
				dto.setCSR_reason(rs.getString("csr_reason")); 
				dto.setCSR_processing_contents(rs.getString("csr_processing_contents")); 
				dto.setCSR_estimate_md(rs.getString("csr_estimate_md")); 
				dto.setCSR_complete_md(rs.getString("csr_complete_md"));
				dto.setCSR_client_comment(rs.getString("csr_client_comment"));
							
			
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	//CSR��û�� �ϴܿ� ������ ��_����
	public boolean receiveCSR(CSRDTO dto) { // ���� ������ true ���н� false (�̰�		

		boolean ok = false;
		String sql = "UPDATE csr SET csr_previewer = ?, " +
				"csr_solvingtime = ? ," +
				"csr_estimate_solvetime = ? ," +
				"csr_preview_result = ?, " +
				"csr_dependentsystem_flag = ?," +
				"csr_dependentsystem = ?, " +
				"csr_state = ? " +
				"where csr_rnum = ?";
		
		Connection con = null;
		PreparedStatement ps = null; // �غ�� ��� ������? ���� ??���� ä��ڴ�.

		try {
			con = getCon();
			ps = con.prepareStatement(sql);

/*			Logger logger = Logger.getLogger( this.getClass() );
			logger.info("getCSR_previewer  : " + dto.getCSR_previewer());
			logger.info("solvingTime  : " + dto.getCSR_solvingtime());
			logger.info("estimate_solvetime  : " + dto.getCSR_estimate_solvetime());
			logger.info("getCSR_preview_result  : " +dto.getCSR_preview_result());
			logger.info("getCSR_dependentsystem_flag  : " +dto.getCSR_dependentsystem_flag());
			logger.info("getCSR_dependentsystem  : " +dto.getCSR_dependentsystem());
			logger.info("getCSR_rnum  : " +dto.getCSR_rnum());*/
			
			ps.setString(1, dto.getCSR_previewer());
			ps.setString(2, dto.getCSR_solvingtime());
			ps.setString(3, dto.getCSR_estimate_solvetime());
			ps.setString(4, dto.getCSR_preview_result());
			ps.setString(5, dto.getCSR_dependentsystem_flag());			
			
			if(dto.getCSR_dependentsystem_flag().equals("0")){
				ps.setString(6, dto.getCSR_dependentsystem());
			}else{
				ps.setString(6, "No");
			}
			ps.setString(7, "1"); // csr ���°��� 1�� �ذ��� ���·� ����!
			ps.setString(8, dto.getCSR_rnum());
			int cnt = ps.executeUpdate(); // insert, update, delete, select :
			// executeQuery() �޼ҵ� ���
			if (cnt == 1)
				ok = true; // executeUpdate �� �����ϸ� 1�� ��ȯ�Ѵ�.
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return ok; // �����ϸ� true, �����ϸ� false ����
	}
	
	// CSR_rnum�� 1�� ��� (1: �ذ���  =>  2: �ذ�Ϸ�) => �� �Լ� ȣ�� �� �ذ�Ϸ�� ���� ����
	public boolean SolveCSR(CSRDTO dto)
	{
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_solvedtime=?, csr_reason=?, csr_processing_contents=?," +
				"csr_estimate_md=?, csr_complete_md=?, csr_state=? WHERE csr_rnum=?";
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = getCon();
			ps = con.prepareStatement(sql);
			
			ps.setString(1, dto.getCSR_solvedtime()); // �ذ�Ϸ�ð�
			ps.setString(2, dto.getCSR_reason()); // ����			
			ps.setString(3, dto.getCSR_processing_contents()); // ó������
			ps.setString(4, dto.getCSR_estimate_md()); // �������
			ps.setString(5, dto.getCSR_complete_md()); // �Ϸ����
			ps.setString(6, "2"); // csr ���°��� 2�� �ذ�Ϸ� ���·� ����!
			ps.setString(7, dto.getCSR_rnum()); // csr ���°� => 1�� ��츸 ó���ϱ� ����..
			
			
			int cnt = ps.executeUpdate();
			
			if(cnt == 1) // ���� OK
			{
				result = true;
			}
			else
			{
				result = false;
			}
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		
		return result;
	}

	// CSR_rnum�� 2�� ��� (2: �ذ�Ϸ� =>  3: ����) => �� �Լ� ȣ�� �� ����� ���� ����
	public boolean finishCSR(String csr_rnum, String csr_client_comment, String csr_finishtime)
	{
		boolean result = false;
		
		String sql = "UPDATE csr SET csr_client_comment=?, csr_finishtime=?, csr_state=?" +
				"WHERE csr_rnum=?";
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = getCon();
			ps = con.prepareStatement(sql);
			
			ps.setString(1, csr_client_comment); // ��û�� �ǰ�
			ps.setString(2, csr_finishtime); // ����ð�
			ps.setString(3, "3"); // csr ���°� ����(3)�� ����
			ps.setString(4, csr_rnum); // csr ��ȣ
			
			int cnt = ps.executeUpdate();
			
			if(cnt == 1) // ���� OK
			{
				result = true;
			}
			else
			{
				result = false;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		
		return result;
	}

	
	//ó�� ���� �������� �޼ҵ�_����
	public List<CSRDTO> getStateList() {
		List<CSRDTO> lists = new ArrayList<CSRDTO>();

		String sql = "SELECT DISTINCT csr_state FROM csr ORDER BY csr.csr_state ASC";
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) { // ����� ������
				CSRDTO dto = new CSRDTO();
				dto.setCSR_state(rs.getString("csr_state"));
							
				lists.add(dto);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (Exception e) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		return lists;
	}
	
	

}
