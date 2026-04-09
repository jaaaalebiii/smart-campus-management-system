package smart_campus;

import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class Dashboard {

    public static void main(String[] args) {

        JFrame frame = new JFrame("Smart Campus");
        frame.setSize(500, 300);
        frame.setLayout(new BorderLayout());
        JTextField prnField = new JTextField(15);
        JTextField amountField = new JTextField(15);
        JButton attendanceBtn = new JButton("Attendance");
        JButton canteenBtn = new JButton("Canteen");
        JButton libraryBtn = new JButton("Library");
        JButton addMoneyBtn = new JButton("Add Money");
        JButton showStudentsBtn = new JButton("Show Students");
        JPanel topPanel = new JPanel();
        topPanel.add(attendanceBtn);
        topPanel.add(canteenBtn);
        topPanel.add(libraryBtn);
        JPanel centerPanel = new JPanel(new GridLayout(2, 1, 10, 10));
        JPanel rfidPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        rfidPanel.add(new JLabel("RFID:"));
        prnField.setPreferredSize(new Dimension(100, 25));
        rfidPanel.add(prnField);
        JPanel amountPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        amountPanel.add(new JLabel("Amount:"));
        amountField.setPreferredSize(new Dimension(100, 25));
        amountPanel.add(amountField);
        centerPanel.add(rfidPanel);
        centerPanel.add(amountPanel);
        JPanel bottomPanel = new JPanel();
        bottomPanel.add(addMoneyBtn);
        bottomPanel.add(showStudentsBtn);
        frame.add(topPanel, BorderLayout.NORTH);
        frame.add(centerPanel, BorderLayout.CENTER);
        frame.add(bottomPanel, BorderLayout.SOUTH);
        attendanceBtn.addActionListener(e -> new AttendanceGUI());
        libraryBtn.addActionListener(e -> new LibraryGUI());
        canteenBtn.addActionListener(e -> new CanteenGUI());
        addMoneyBtn.addActionListener(e -> {
            try {
                long prn = Long.parseLong(prnField.getText());
                double amt = Double.parseDouble(amountField.getText());

                Connection con = DBConnection.getConnection();

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE Wallet SET Balance = Balance + ? WHERE PRN = ?"
                );

                ps.setDouble(1, amt);
                ps.setLong(2, prn);

                ps.executeUpdate();

                JOptionPane.showMessageDialog(frame, "Money Added");

                prnField.setText("");
                amountField.setText("");

                con.close();

            } catch (Exception ex) {
                JOptionPane.showMessageDialog(frame, "Invalid input");
            }
        });

        showStudentsBtn.addActionListener(e -> {
            try {
                Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();

                ResultSet rs = stmt.executeQuery("SELECT * FROM Student");

                String data = "";

                while (rs.next()) {
                    data += rs.getString("Name") + "\n";
                }

                JOptionPane.showMessageDialog(frame, data);

                con.close();

            } catch (Exception ex) {
                JOptionPane.showMessageDialog(frame, ex);
            }
        });
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}