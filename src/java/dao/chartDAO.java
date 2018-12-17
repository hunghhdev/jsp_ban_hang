package dao;

import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Value;

public class chartDAO {
    BillDAO billDAO = new BillDAO();
    public ArrayList<Value> getAll() {
        try {
            ArrayList<Value> list = new ArrayList<>();
            list.add(new Value("Chưa xử lý", billDAO.getCountBill(0)));
            list.add(new Value("Xác nhận", billDAO.getCountBill(1)));
            list.add(new Value("Hủy", billDAO.getCountBill(2)));
            return list;
        } catch (Exception ex) {
            Logger.getLogger(chartDAO.class.getName()).log(Level.ALL, null, ex);
        }
        return null;
    }
}
