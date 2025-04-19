package kg.megalab.onlinestore2.controllers;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;
import jakarta.servlet.http.HttpServletResponse;
import kg.megalab.onlinestore2.models.Product;
import kg.megalab.onlinestore2.models.User;
import kg.megalab.onlinestore2.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/")
    public String products(@RequestParam(name = "searchWord", required = false) String title,
                           @RequestParam(name = "searchCity", required = false) String city,
                           Principal principal, Model model) {
        model.addAttribute("products", productService.listProducts(title, city));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("searchWord", title);
        model.addAttribute("searchCity", city);
        return "products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("authorProduct", product.getUser());
        return "product-info";
    }

    @PostMapping("/product/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3, Product product, Principal principal) throws IOException {
        productService.saveProduct(principal, product, file1, file2, file3);
        return "redirect:/my/products";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Long id, Principal principal) {
        User user = productService.getUserByPrincipal(principal);
        productService.deleteProduct(user, id);
        return "redirect:/"; // Перенаправление на главную страницу
    }

    @GetMapping("/my/products")
    public String userProducts(Principal principal, Model model) {
        User user = productService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "my-products";
    }

    @GetMapping("/product/{id}/pdf")
    public void getProductPdf(@PathVariable Long id, HttpServletResponse response) throws IOException, DocumentException {
        Product product = productService.getProductById(id);
        if (product == null) {
            response.sendError(HttpStatus.NOT_FOUND.value(), "Product not found");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=product_" + product.getId() + ".pdf");

        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Заголовок документа
        document.add(new Paragraph("Информация о товаре", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));

        // Информация о товаре
        document.add(new Paragraph("Название: " + product.getTitle()));
        document.add(new Paragraph("Цена: " + product.getPrice() + " ₽"));
        document.add(new Paragraph("Город: " + product.getCity()));
        document.add(new Paragraph("Описание: " + product.getDescription()));

        // Контактная информация продавца
        document.add(new Paragraph("Продавец: " + product.getUser().getName()));
        document.add(new Paragraph("Телефон: " + product.getUser().getPhoneNumber()));

        document.close();
    }
}