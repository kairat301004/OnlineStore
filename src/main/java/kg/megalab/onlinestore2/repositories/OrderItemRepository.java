package kg.megalab.onlinestore2.repositories;

import kg.megalab.onlinestore2.models.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
    void deleteByProductId(Long productId);
}