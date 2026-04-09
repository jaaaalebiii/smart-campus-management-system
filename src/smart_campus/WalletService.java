package smart_campus;
import java.sql.*;

public class WalletService {

    public void addMoney(long prn, double amount) {
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE Wallet SET Balance = Balance + ? WHERE PRN = ?"
            );

            ps.setDouble(1, amount);
            ps.setLong(2, prn);

            ps.executeUpdate();
            System.out.println("Money added successfully");

            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}