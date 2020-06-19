/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import MyConnection.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Stel
 */
public class Order {

    private String firstName;
    private String lastName;
    private String date;
    private int total;
    private int cardNumber;

    public Order(String firstName, String lastName, String date, int total, int cardNumber) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.date = date;
        this.total = total;
        this.cardNumber = cardNumber;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getDate() {
        return date;
    }

    public int getTotal() {
        return total;
    }

    public int getCardNumber() {
        return cardNumber;
    }

    public static String placeOrder(HttpServletRequest req) {
        String errorMessage = "";
        ArrayList<PokemonCard> cards = new ArrayList<>();
        HttpSession session = req.getSession();
        if (session.getAttribute("shoppingCart") != null) {
            cards = (ArrayList<PokemonCard>) session.getAttribute("shoppingCart");
        } else {
            return "Shopping cart is empty";
        }
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");

        if (firstName == null || lastName == null) {
            return "Please fill out first and last name";
        }

        int totalCost = 0;
        int totalCards = 0;
        for (PokemonCard card : cards) {
            totalCost += (card.getPrice() * card.getQuantity());
            totalCards += card.getQuantity();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        Date dt = new Date();
        String today = sdf.format(dt);

        Connection conn = MyConnection.getConnection("stdrake", "fyuuZRbFgk3h");

        try {
            PreparedStatement smt = conn.prepareStatement("INSERT into Orders ( firstName, lastName, date, total, cardNumber ) values ( ? , ? , ? , ? , ? );");

            smt.setString(1, firstName);
            smt.setString(2, lastName);
            smt.setString(3, today);
            smt.setInt(4, totalCost);
            smt.setInt(5, totalCards);
            smt.execute();
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }

        return errorMessage;
    }

    public static String getOrders(HttpServletRequest req) {
        Connection conn = MyConnection.getConnection("stdrake", "fyuuZRbFgk3h");
        ArrayList<Order> orders = new ArrayList<>();
        try {
            Statement smt = conn.createStatement();
            ResultSet rs = smt.executeQuery("SELECT firstName, lastName, date, total, cardNumber FROM Orders;");
            while (rs.next()) {
                String firstName = rs.getString(1);
                String lastName = rs.getString(2);
                String date = rs.getString(3);
                int total = rs.getInt(4);
                int cardNumber = rs.getInt(5);
                Order newOrder = new Order(firstName, lastName, date, total, cardNumber);
                orders.add(newOrder);
            }
            req.setAttribute("orders", orders);
        } catch (Exception e) {

        }
        return "";
    }
}
