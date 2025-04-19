package kg.megalab.onlinestore2.services;

import jakarta.persistence.EntityNotFoundException;
import kg.megalab.onlinestore2.models.Order;
import kg.megalab.onlinestore2.models.OrderItem;
import kg.megalab.onlinestore2.models.Product;
import kg.megalab.onlinestore2.models.User;
import kg.megalab.onlinestore2.repositories.OrderRepository;
import kg.megalab.onlinestore2.repositories.OrderItemRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
@Slf4j
@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final CartService cartService;

    public Order createOrder(User user, List<Product> products, String paymentMethod, String deliveryAddress) {
        log.info("Creating order for user: {}", user.getEmail());
        Order order = new Order();
        order.setUser(user);
        order.setPaymentMethod(paymentMethod);
        order.setDeliveryAddress(deliveryAddress);
        order.setCreatedAt(LocalDateTime.now());
        order.setStatus("В обработке");

        for (Product product : products) {
            log.info("Adding product to order: {}", product.getTitle());
            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProduct(product);
            item.setQuantity(1);
            item.setPrice(product.getPrice());
            order.getItems().add(item);
        }

        orderRepository.save(order);
        log.info("Order created successfully: {}", order.getId());
        cartService.clearCart(user);
        return order;
    }
    @Transactional
    public void deleteOrder(Long orderId, User user) {
        Order order = orderRepository.findByIdAndUser(orderId, user)
                .orElseThrow(() -> new EntityNotFoundException("Order not found"));

        // Проверяем, можно ли удалять заказ (например, только если статус "В обработке")
        if (!"В обработке".equals(order.getStatus())) {
            throw new IllegalStateException("Cannot delete order with status: " + order.getStatus());
        }

        orderRepository.delete(order);
    }


    public List<Order> getUserOrders(User user) {
        return orderRepository.findByUser(user);
    }
}