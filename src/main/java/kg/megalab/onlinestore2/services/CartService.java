package kg.megalab.onlinestore2.services;

import kg.megalab.onlinestore2.models.Cart;
import kg.megalab.onlinestore2.models.CartItem;
import kg.megalab.onlinestore2.models.Product;
import kg.megalab.onlinestore2.models.User;
import kg.megalab.onlinestore2.repositories.CartRepository;
import kg.megalab.onlinestore2.repositories.CartItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
@RequiredArgsConstructor
public class CartService {
    private final CartRepository cartRepository;
    private final ProductService productService;

    public Cart getCartByUser(User user) {
        return cartRepository.findByUser(user).orElseGet(() -> {
            Cart newCart = new Cart();
            newCart.setUser(user);
            return cartRepository.save(newCart);
        });
    }

    public void addToCart(User user, Long productId, int quantity) {
        Cart cart = getCartByUser(user);
        Product product = productService.getProductById(productId);

        if (product != null) {
            Optional<CartItem> existingItem = cart.getItems().stream()
                    .filter(item -> item.getProduct().getId().equals(productId))
                    .findFirst();

            if (existingItem.isPresent()) {
                // Если товар уже есть в корзине, увеличиваем количество
                CartItem item = existingItem.get();
                item.setQuantity(item.getQuantity() + quantity);
            } else {
                // Если товара нет в корзине, добавляем новый элемент
                CartItem item = new CartItem();
                item.setCart(cart);
                item.setProduct(product);
                item.setQuantity(quantity);
                cart.getItems().add(item);
            }
            cartRepository.save(cart);
        }
    }

    public void removeFromCart(User user, Long itemId) {
        Cart cart = getCartByUser(user);
        cart.getItems().removeIf(item -> item.getId().equals(itemId));
        cartRepository.save(cart);
    }

    public void clearCart(User user) {
        Cart cart = getCartByUser(user);
        cart.getItems().clear();
        cartRepository.save(cart);
    }
}