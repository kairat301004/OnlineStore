package kg.megalab.onlinestore2.repositories;

import kg.megalab.onlinestore2.models.Order;
import kg.megalab.onlinestore2.models.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    @EntityGraph(attributePaths = {"items", "items.product"})
    List<Order> findByUser(User user);

    Optional<Order> findByIdAndUser(Long orderId, User user);
}