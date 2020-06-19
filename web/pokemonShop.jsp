<%--
    Document   : PersonCollection
    Created on : Oct 22, 2018, 5:33:12 PM
    Author     : Stel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pokemon Cards</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.2/css/bulma.min.css" integrity="sha256-2pUeJf+y0ltRPSbKOeJh09ipQFYxUdct5nTY6GAXswA=" crossorigin="anonymous" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            .tile.is-3 form {margin: 10px 0 20px 0}
            #checkout{display: inline-block}
        </style>
    </head>
    <body>
        <section class="hero is-info">
            <div class="hero-body">
                <div class="container">
                    <h1 class="title is-1">
                        Buy Pokemon Cards
                    </h1>
                    <h2 class="subtitle">
                        Can you catch them all?
                    </h2>
                </div>
            </div>
        </section>
        <section class="section">
            <div class="container">
                <h2 class="title is-4">Cards Available</h2>
                <div class="tile is-ancestor">
                    <div class="tile is-3 is-parent">
                        <div class="tile is-child has-text-centered">
                            <figure class="image">
                                <img src="https://52f4e29a8321344e30ae-0f55c9129972ac85d6b1f4e703468e6b.ssl.cf2.rackcdn.com/products/pictures/211925.jpg">
                            </figure>
                            <h3 class="subtitle is-3">$5</h3>
                            <form method="post">
                                <input type="hidden" name="name" value="jigglypuff">
                                <input type="hidden" name="price" value="5">
                                <input class="button is-primary" type="submit" name="addCart" value="Add to Cart">
                            </form>
                        </div>
                    </div>
                    <div class="tile is-3 is-parent">
                        <div class="tile is-child has-text-centered">
                            <figure class="image">
                                <img src="https://52f4e29a8321344e30ae-0f55c9129972ac85d6b1f4e703468e6b.ssl.cf2.rackcdn.com/products/pictures/149507.jpg">
                            </figure>
                            <h3 class="subtitle is-3">$8</h3>
                            <form method="post">
                                <input type="hidden" name="name" value="vaporeon">
                                <input type="hidden" name="price" value="8">
                                <input class="button is-primary" type="submit" name="addCart" value="Add to Cart">
                            </form>
                        </div>
                    </div>
                    <div class="tile is-3 is-parent">
                        <div class="tile is-child has-text-centered">
                            <figure class="image">
                                <img src="https://52f4e29a8321344e30ae-0f55c9129972ac85d6b1f4e703468e6b.ssl.cf2.rackcdn.com/products/pictures/183615.jpg">
                            </figure>
                            <h3 class="subtitle is-3">$3</h3>
                            <form method="post">
                                <input type="hidden" name="name" value="togepi">
                                <input type="hidden" name="price" value="3">
                                <input class="button is-primary" type="submit" name="addCart" value="Add to Cart">
                            </form>
                        </div>
                    </div>
                    <div class="tile is-3 is-parent">
                        <div class="tile is-child has-text-centered">
                            <figure class="image">
                                <img src="https://52f4e29a8321344e30ae-0f55c9129972ac85d6b1f4e703468e6b.ssl.cf2.rackcdn.com/products/pictures/148906.jpg">
                            </figure>
                            <h3 class="subtitle is-3">$10</h3>
                            <form method="post">
                                <input type="hidden" name="name" value="butterfree">
                                <input type="hidden" name="price" value="10">
                                <input class="button is-primary" type="submit" name="addCart" value="Add to Cart">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <c:if test = "${sessionScope.shoppingCart != null}">
            <section class="section">
                <div class="container has-text-centered">
                    <h2 class="title is-2">Your Shopping Cart</h2>
                    <table class="table is-striped is-inline-block">
                        <thead>
                        <th class="has-text-centered">Pokemon Card</th>
                        <th class="has-text-centered">Price</th>
                        <th class="has-text-centered">Quantity</th>
                        </thead>
                        <tbody>
                            <c:forEach items="${sessionScope.shoppingCart}" var="pokemonCard">
                                <tr>
                                    <td class="has-text-centered">${pokemonCard.getName().toUpperCase()}</td>
                                    <td class="has-text-centered">$${pokemonCard.getPrice()}</td>
                                    <td class="has-text-centered">${pokemonCard.getQuantity()}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:set var="total" value="${0}"/>
                    <c:forEach var="pokemonCard" items="${sessionScope.shoppingCart}">
                        <c:set var="total" value="${pokemonCard.getPrice() * pokemonCard.getQuantity() + total}" />
                    </c:forEach>
                    <p class="title is-4">TOTAL: $${total}</p>
                    <form method='post' style="display: inline-block">
                        <input class="button is-danger" type="submit" name="emptyCart" value="Empty Cart">
                    </form>
                    <button id="checkout" class="button is-info">Checkout</button>
                    <div id="modal" class="modal">
                        <div id="background" class="modal-background"></div>
                        <div class="modal-card has-text-left">
                            <form method="post">
                                <header class="modal-card-head">
                                    <p class="modal-card-title">Checkout</p>
                                </header>
                                <section class="modal-card-body">
                                    <div class="field">
                                        <label class="label">First Name</label>
                                        <div class="control">
                                            <input class="input" type="text" name="firstName" placeholder="First" required>
                                        </div>
                                    </div>
                                    <div class="field">
                                        <label class="label">Last Name</label>
                                        <div class="control">
                                            <input class="input" type="text" name="lastName" placeholder="Last" required>
                                        </div>
                                    </div>
                                </section>
                                <footer class="modal-card-foot">
                                    <input class="button is-info" type="submit" name="placeOrder" value="Place Order">
                                </footer>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </c:if>
        <c:if test = "${orders != null}">
            <section class="hero is-primary">
                <div class="hero-body">
                    <div class="container">
                        <h1 class="title">
                            Past Orders
                        </h1>
                    </div>
                </div>
            </section>
            <section class="section">
                <div class="container">
                    <table class="table is-striped table is-fullwidth">
                        <thead>
                        <th class="has-text-centered">Date</th>
                        <th class="has-text-centered">First Name</th>
                        <th class="has-text-centered">Last Name</th>
                        <th class="has-text-centered"># of Cards</th>
                        <th class="has-text-centered">Total Cost</th>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td class="has-text-centered">${order.getDate()}</td>
                                    <td class="has-text-centered">${order.getFirstName()}</td>
                                    <td class="has-text-centered">${order.getLastName()}</td>
                                    <td class="has-text-centered">${order.getCardNumber()}</td>
                                    <td class="has-text-centered">$${order.getTotal()}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </c:if>
        <footer class="footer">
            <div class="content has-text-centered">
                <p>
                    Made by <strong>Stel Abrego</strong>
                </p>
            </div>
        </footer>
        <script>
            var modalButton = document.getElementById("checkout");
            modalButton.addEventListener("click", function () {
                var modal = document.getElementById("modal");
                modal.className = "modal is-active";
            });
            var modalButton = document.getElementById("background");
            modalButton.addEventListener("click", function () {
                var modal = document.getElementById("modal");
                modal.className = "modal";
            });
        </script>
    </body>
</html>
