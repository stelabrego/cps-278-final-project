/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Stel
 */
public class ShoppingCart {

    public static String update(HttpServletRequest req) {
        String errorMessage = "";
        ArrayList<PokemonCard> cards = new ArrayList<>();
        HttpSession session = req.getSession();
        if (session.getAttribute("shoppingCart") != null) {
            cards = (ArrayList<PokemonCard>) session.getAttribute("shoppingCart");
        }
        String name = (String) req.getParameter("name");
        String priceString = (String) req.getParameter("price");
        int price = Integer.parseInt(priceString);

        PokemonCard pc = new PokemonCard(name, price, 1);
        if (cards.contains(pc)) {
            int index = cards.indexOf(pc);
            PokemonCard foundCard = cards.get(index);
            foundCard.setQuantity(foundCard.getQuantity() + 1);
        } else {
            cards.add(pc);
        }
        session.setAttribute("shoppingCart", cards);
        return errorMessage;
    }

    public static String clear(HttpServletRequest req) {
        String errorMessage = "";
        HttpSession session = req.getSession();
        if (session.getAttribute("shoppingCart") != null) {
            session.setAttribute("shoppingCart", null);
        }
        return errorMessage;

    }

}
