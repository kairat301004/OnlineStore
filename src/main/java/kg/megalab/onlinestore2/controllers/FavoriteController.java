package kg.megalab.onlinestore2.controllers;

import kg.megalab.onlinestore2.models.User;
import kg.megalab.onlinestore2.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class FavoriteController {
    private final UserService userService;

    @PostMapping("/favorites/add/{productId}")
    public String addToFavorites(@PathVariable Long productId, Principal principal) {
        userService.addToFavorites(principal, productId);
        return "redirect:/product/" + productId;
    }

    @PostMapping("/favorites/remove/{productId}")
    public String removeFromFavorites(@PathVariable Long productId, Principal principal) {
        userService.removeFromFavorites(principal, productId);
        return "redirect:/product/" + productId;
    }

    @GetMapping("/favorites")
    public String getFavorites(Principal principal, Model model) {
        if (principal == null) {
            return "redirect:/login"; // Перенаправление на страницу входа, если пользователь не авторизован
        }
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("favorites", userService.getFavorites(principal));
        return "favorites";
    }
}