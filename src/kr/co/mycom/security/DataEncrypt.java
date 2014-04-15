package kr.co.mycom.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * ����� ��й�ȣ�� MD5/SHA-224 ������� ��ȣȭ
 */
public class DataEncrypt {
	MessageDigest md;
	String strSRCData = "";
	String strENCData = "";

	public DataEncrypt() {
	}

	public String encrypt(String strData) { // ��ȣȭ ��ų ������
		try {
			strSRCData = strData;
			// MessageDigest md = MessageDigest.getInstance("MD5"); // "MD5 �������� ��ȣȭ"
			MessageDigest md = MessageDigest.getInstance("SHA-256"); // "SHA-256 �������� ��ȣȭ"
			byte[] bytData = strData.getBytes();
			md.update(bytData);
			byte[] digest = md.digest(); // �迭�� ������ �Ѵ�.
			for (int i = 0; i < digest.length; i++) {
				strENCData = strENCData
						+ Integer.toHexString(digest[i] & 0xFF).toUpperCase();
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.print("��ȣȭ ����" + e.toString());
		}
		return strENCData; // ��ȣȭ�� �����͸� ����
	}
} // end class

	
