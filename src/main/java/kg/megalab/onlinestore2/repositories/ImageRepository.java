package kg.megalab.onlinestore2.repositories;

import kg.megalab.onlinestore2.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
}
