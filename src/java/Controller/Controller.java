/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import MyConnection.MyConnection;
import java.sql.*;
import Model.*;

/**
 *
 * @author Stel
 */
public class Controller extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getParameter("addCart") != null) {
            String shoppingCartError = ShoppingCart.update(req);
        } else if (req.getParameter("emptyCart") != null) {
            String shoppingCartError = ShoppingCart.clear(req);
        } else if (req.getParameter("placeOrder") != null) {
            String orderError = Order.placeOrder(req);
            String shoppingCartError = ShoppingCart.clear(req);
        }

        Order.getOrders(req);

        RequestDispatcher dispatcher
                = getServletContext().getRequestDispatcher("/pokemonShop.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp); //To change body of generated methods, choose Tools | Templates.
    }

}
