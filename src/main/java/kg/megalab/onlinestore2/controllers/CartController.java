package kg.megalab.onlinestore2.controllers;

import kg.megalab.onlinestore2.models.Cart;
import kg.megalab.onlinestore2.models.User;
import kg.megalab.onlinestore2.services.CartService;
import kg.megalab.onlinestore2.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
@Controller
@RequestMapping("/cart")
public class CartController {
    private final CartService cartService;
    private final UserService userService;

    public CartController(CartService cartService, UserService userService) {
        this.cartService = cartService;
        this.userService = userService;
    }

    @GetMapping
    public String showCart(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);
        Cart cart = cartService.getCartByUser(user);
        model.addAttribute("cart", cart);
        model.addAttribute("user", user);
        return "cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam Long productId, @RequestParam int quantity, Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        cartService.addToCart(user, productId, quantity);
        return "redirect:/cart";
    }

    @PostMapping("/remove/{itemId}")
    public String removeFromCart(@PathVariable Long itemId, Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        cartService.removeFromCart(user, itemId);
        return "redirect:/cart";
    }

    @PostMapping("/clear")
    public String clearCart(Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        cartService.clearCart(user);
        return "redirect:/cart";
    }
}