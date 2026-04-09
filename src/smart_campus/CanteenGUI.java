package smart_campus;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;
import java.util.*;

public class CanteenGUI {

    Map<String, Integer> itemMap = new HashMap<>();
    Map<String, Double> priceMap = new HashMap<>();

    DefaultListModel<String> cartModel = new DefaultListModel<>();
    JList<String> cartList = new JList<>(cartModel);

    double totalAmount = 0;

    public CanteenGUI() {

        JFrame frame = new JFrame("Canteen System");
        frame.setSize(600, 400);
        frame.setLayout(new FlowLayout());

        DefaultListModel<String> itemModel = new DefaultListModel<>();
        JList<String> itemList = new JList<>(itemModel);
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM Canteen_Item");

            while (rs.next()) {
                String name = rs.getString("ItemName");
                int id = rs.getInt("ItemID");
                double price = rs.getDouble("Price");

                itemModel.addElement(name + " - " + price);

                itemMap.put(name, id);
                priceMap.put(name, price);
            }

            con.close();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(frame, e);
        }

        JButton addBtn = new JButton("Add Item");

        JTextField qtyField = new JTextField(5);

        JTextField rfidField = new JTextField(15);
        JButton payBtn = new JButton("Scan & Pay");

        JLabel totalLabel = new JLabel("Total: 0");

        frame.add(new JLabel("Items"));
        frame.add(itemList);

        frame.add(new JLabel("Qty:"));
        frame.add(qtyField);

        frame.add(addBtn);

        frame.add(new JLabel("Cart"));
        frame.add(cartList);

        frame.add(totalLabel);

        frame.add(new JLabel("RFID:"));
        frame.add(rfidField);

        frame.add(payBtn);
        addBtn.addActionListener(e -> {
            String selected = itemList.getSelectedValue();
            String qtyText = qtyField.getText();

            if (selected == null) {
                JOptionPane.showMessageDialog(frame, "Select an item first");
                return;
            }

            if (qtyText.isEmpty()) {
                JOptionPane.showMessageDialog(frame, "Enter quantity");
                return;
            }

            try {
                int qty = Integer.parseInt(qtyText);

                if (qty <= 0) {
                    JOptionPane.showMessageDialog(frame, "Invalid quantity");
                    return;
                }

                String name = selected.split(" - ")[0];
                double price = priceMap.get(name);

                double itemTotal = price * qty;

                cartModel.addElement(name + " x" + qty + " = " + itemTotal);

                totalAmount += itemTotal;
                totalLabel.setText("Total: " + totalAmount);

                // clear after adding
                qtyField.setText("");

            } catch (NumberFormatException ex) {
                JOptionPane.showMessageDialog(frame, "Enter valid number");
            }
        });
        payBtn.addActionListener(e -> {
            try {
                String rfid = rfidField.getText();

                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                        "SELECT PRN FROM RFID_Card WHERE CardID=?"
                );
                ps.setString(1, rfid);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    long prn = rs.getLong("PRN");
                    PreparedStatement ps2 = con.prepareStatement(
                            "SELECT WalletID, Balance FROM Wallet WHERE PRN=?"
                    );
                    ps2.setLong(1, prn);

                    ResultSet rs2 = ps2.executeQuery();

                    if (rs2.next()) {

                        int walletId = rs2.getInt("WalletID");
                        double balance = rs2.getDouble("Balance");
                        if (balance < totalAmount) {
                            JOptionPane.showMessageDialog(frame, "Insufficient Balance");
                            return;
                        }
                        PreparedStatement ps3 = con.prepareStatement(
                                "INSERT INTO Canteen_Transaction (WalletID, ItemID, Quantity, TotalAmount) VALUES (?, ?, ?, ?)"
                        );
                        String firstItem = cartModel.get(0).split(" x")[0];
                        int itemId = itemMap.get(firstItem);

                        ps3.setInt(1, walletId);
                        ps3.setInt(2, itemId);
                        ps3.setInt(3, 1);
                        ps3.setDouble(4, totalAmount);

                        ps3.executeUpdate();

                        JOptionPane.showMessageDialog(frame, "Payment Successful");
                        cartModel.clear();
                        totalAmount = 0;
                        totalLabel.setText("Total: 0");
                        rfidField.setText("");
                        qtyField.setText("");
                        rfidField.requestFocus();

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