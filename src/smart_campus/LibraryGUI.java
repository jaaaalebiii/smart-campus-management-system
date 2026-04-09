package smart_campus;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class LibraryGUI {

    public LibraryGUI() {

        JFrame frame = new JFrame("Library System");
        frame.setSize(400, 250);
        frame.setLayout(new FlowLayout());

        JTextField rfidField = new JTextField(15);
        JTextField bookField = new JTextField(10);

        JButton issueBtn = new JButton("Issue Book");
        JButton returnBtn = new JButton("Return Book");

        frame.add(new JLabel("RFID:"));
        frame.add(rfidField);

        frame.add(new JLabel("Book ID:"));
        frame.add(bookField);

        frame.add(issueBtn);
        frame.add(returnBtn);
        issueBtn.addActionListener(e -> {
            try {
                String rfid = rfidField.getText();
                int bookId = Integer.parseInt(bookField.getText());

                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                        "SELECT PRN FROM RFID_Card WHERE CardID=?"
                );
                ps.setString(1, rfid);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    long prn = rs.getLong("PRN");
                    CallableStatement cs = con.prepareCall(
                            "{CALL IssueBook(?, ?)}"
                    );
                    cs.setLong(1, prn);
                    cs.setInt(2, bookId);

                    cs.execute();

                    JOptionPane.showMessageDialog(frame, "Book Issued");

                } else {
                    JOptionPane.showMessageDialog(frame, "Invalid RFID");
                }

                con.close();

            } catch (Exception ex) {
                JOptionPane.showMessageDialog(frame, ex);
            }
        });
        
        returnBtn.addActionListener(e -> {
            try {
                String rfid = rfidField.getText();
                int bookId = Integer.parseInt(bookField.getText());
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                        "SELECT PRN FROM RFID_Card WHERE CardID=?"
                );
                ps.setString(1, rfid);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    long prn = rs.getLong("PRN");

                    PreparedStatement ps2 = con.prepareStatement(
                            "UPDATE Library_Record SET ReturnDate = CURDATE() WHERE PRN=? AND BookID=? AND ReturnDate IS NULL"
                    );
                    ps2.setLong(1, prn);
                    ps2.setInt(2, bookId);

                    int rows = ps2.executeUpdate();

                    if (rows > 0) {
                        JOptionPane.showMessageDialog(frame, "Book Returned");
                    } else {
                        JOptionPane.showMessageDialog(frame, "No active record");
                    }

                } else {
                    JOptionPane.showMessageDialog(frame, "Invalid RFID");
                }

                con.close();

            } catch (Exception ex) {
                JOptionPane.showMessageDialog(frame, ex);
            }
        });

        frame.setVisible(true);
    }
}