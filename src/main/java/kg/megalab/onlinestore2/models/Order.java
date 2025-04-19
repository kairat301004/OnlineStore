package kg.megalab.onlinestore2.models;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> items = new ArrayList<>(); // Инициализация

    private String paymentMethod;
    private String deliveryAddress;
    private LocalDateTime createdAt;
    private String status;

    // Конструктор по умолчанию
    public Order() {
        this.items = new ArrayList<>();
    }
}