package smart_campus;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;
import java.sql.SQLIntegrityConstraintViolationException;

public class AttendanceGUI {

    public AttendanceGUI() {

        JFrame frame = new JFrame("Attendance System");
        frame.setSize(400, 200);
        frame.setLayout(new FlowLayout());

        JLabel label = new JLabel("Tap RFID Card:");
        JTextField rfidField = new JTextField(15);
        JButton markBtn = new JButton("Mark Attendance");
        frame.add(label);
        frame.add(rfidField);
        frame.add(markBtn);
        markBtn.addActionListener(e -> {
            try {
                String rfid = rfidField.getText();
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                        "SELECT PRN FROM RFID_Card WHERE CardID = ?"
                );
                ps.setString(1, rfid);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    long prn = rs.getLong("PRN");
                    try {
                        PreparedStatement ps2 = con.prepareStatement(
                                "INSERT INTO Attendance (Date, Status, PRN, SubjectID, FacultyID) VALUES (CURDATE(), 'Present', ?, 1, 1)"
                        );
                        ps2.setLong(1, prn);
                        ps2.executeUpdate();

                        JOptionPane.showMessageDialog(frame, "Attendance Marked");

                    } catch (SQLIntegrityConstraintViolationException ex) {
                        JOptionPane.showMessageDialog(frame, "Attendance already marked");
                    }
                    
                    rfidField.setText("");
                    rfidField.requestFocus();

                } else {
                    JOptionPane.showMessageDialog(frame, "Invalid RFID");
                }

                con.close();

            } catch (Exception ex) {
                JOptionPane.showMessageDialog(frame, "Error: " + ex.getMessage());
            }
        });

        frame.setVisible(true);
    }
}