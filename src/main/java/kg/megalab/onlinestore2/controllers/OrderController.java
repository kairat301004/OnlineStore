package kg.megalab.onlinestore2.controllers;

import kg.megalab.onlinestore2.models.Order;
import kg.megalab.onlinestore2.models.Product;
import kg.megalab.onlinestore2.models.User;
import kg.megalab.onlinestore2.services.OrderService;
import kg.megalab.onlinestore2.services.ProductService;
import kg.megalab.onlinestore2.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;
    private final UserService userService;
    private final ProductService productService;

    @GetMapping("/orders")
    public String getUserOrders(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);
        List<Order> orders = orderService.getUserOrders(user);
        model.addAttribute("user", user);
        model.addAttribute("orders", orders);
        return "orders";
    }

    @PostMapping("/order/create")
    public String createOrder(
            Principal principal,
            @RequestParam List<Long> productIds,
            @RequestParam String paymentMethod,
            @RequestParam String deliveryAddress
    ) {
        User user = userService.getUserByPrincipal(principal);
        List<Product> products = productIds.stream()
                .map(productService::getProductById)
                .toList();
        orderService.createOrder(user, products, paymentMethod, deliveryAddress);
        return "redirect:/orders";
    }
    @PostMapping("/orders/{orderId}/delete")
    public String deleteOrder(@PathVariable Long orderId, Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        orderService.deleteOrder(orderId, user);
        return "redirect:/orders";
    }
}