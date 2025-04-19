package kg.megalab.onlinestore2.repositories;

import kg.megalab.onlinestore2.models.Cart;
import kg.megalab.onlinestore2.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Optional<Cart> findByUser(User user); // Поиск корзины по пользователю
}