package com.ResultsApp;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import javax.print.DocFlavor.STRING;

public class sample {
	
	public static void main(File f, String y) {

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/re", "root", "jo");
			
			FileInputStream excelFile = new FileInputStream(f);
			@SuppressWarnings("resource")
			Workbook workbook = new XSSFWorkbook(excelFile);
			for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
				Sheet datatypeSheet = workbook.getSheetAt(i);
				Iterator<Row> iterator = datatypeSheet.iterator();
				iterator.next();
				iterator.next();
				iterator.next();
				int count = 0;
				ArrayList<String> sa = new ArrayList<String>();
				Row currentRow = iterator.next();
				Iterator<Cell> cellIterator = currentRow.iterator();

				cellIterator.next();
				while (true) {

					Cell currentCell = cellIterator.next();
					if (currentCell.getCellTypeEnum() == CellType.STRING) {
						if ("Total".equalsIgnoreCase(currentCell.getStringCellValue()))
							break;

						else if (currentCell.getStringCellValue().equals("")) {
							continue;
						}

						else {
							sa.add(currentCell.getStringCellValue());
							count++;
						}
					}
				}
				ArrayList<String> sn = new ArrayList<String>();
				currentRow = iterator.next();
				cellIterator = currentRow.iterator();
				cellIterator.next();
				cellIterator.next();
				while (cellIterator.hasNext()) {
					try {
					Cell currentcell = cellIterator.next();
					sn.add(currentcell.getStringCellValue());
					cellIterator.next();
					cellIterator.next();
					cellIterator.next();
					}catch(Exception e) {
						break;
					}
				}
				System.out.println(sn);
				iterator.next();
				while (iterator.hasNext()) {
					currentRow = iterator.next();
					cellIterator = currentRow.iterator();

					Cell currentCell = cellIterator.next();
					
					if (currentCell.getCellTypeEnum() == CellType.STRING
							&& currentCell.getStringCellValue().equalsIgnoreCase("total"))
						break;

					
					
					String s = cellIterator.next().getStringCellValue();
					
					if(s.equalsIgnoreCase("total")) break;

					int total = 0, cred = 0, nfail = 0;
					try {
						for (int j = 0; j < count; j++) {
							currentCell = cellIterator.next();
							int im = (int) currentCell.getNumericCellValue();
							currentCell = cellIterator.next();
							int e = (int) currentCell.getNumericCellValue();
							currentCell = cellIterator.next();
							int t = (int) currentCell.getNumericCellValue();
							currentCell = cellIterator.next();
							int c = (int) currentCell.getNumericCellValue();
							PreparedStatement pst = conn.prepareStatement("insert into res"+y+" values(?,?,?,?,?,?,?)");
							pst.setString(1, s);
							pst.setString(2, sa.get(j));
							pst.setString(3, sn.get(j));
							pst.setInt(4, im);
							pst.setInt(5, e);
							pst.setInt(6, t);
							pst.setInt(7, c);
							pst.executeUpdate();
							if (c == 0)
								nfail++;
							else
								cred += c;
							total += t;
						}
					} catch (Exception e) {
						e.printStackTrace();
						continue;
					}
					int passorfail = 0;
					if (nfail != 0)
						passorfail = 1;
					char b = s.charAt(7);
					String branch ="";
					switch(b) {
					case '1': branch="CIVIL"; break;
					case '2': if(s.charAt(6)=='1') branch="IT"; else if(s.charAt(6)=='0') branch="EEE"; break;
					case '3': branch="MECH"; break;
					case '4': branch="ECE"; break;
					case '5': branch="CSE"; break;
					default: branch="OTHER";
					}
					PreparedStatement pst = conn.prepareStatement("insert into res"+y+"d values(?,?,?,?,?,?,?)");
					pst.setString(1, s);
					pst.setInt(2, total);
					pst.setInt(3, cred);
					pst.setInt(4, nfail);
					pst.setInt(5, passorfail);
					pst.setInt(6, (total * 100) / 750);
					pst.setString(7, branch);
					pst.executeUpdate();
				}
			}
		} catch (Exception e) {
			
		}
		System.out.println("Upload Successfully");
	}
}
