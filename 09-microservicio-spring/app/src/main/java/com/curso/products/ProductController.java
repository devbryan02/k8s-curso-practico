package com.curso.products;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ProductController {

    private final ProductRepository repository;

    public ProductController(ProductRepository repository) {
        this.repository = repository;
    }

    /** Endpoint público: muestra qué pod respondió (útil para ver el balanceo). */
    @GetMapping("/public/ping")
    public Map<String, String> ping() {
        String pod = System.getenv().getOrDefault("HOSTNAME", "local");
        return Map.of("status", "ok", "pod", pod);
    }

    /** Requiere JWT válido de Keycloak. */
    @GetMapping("/whoami")
    public Map<String, Object> whoami(@AuthenticationPrincipal Jwt jwt) {
        return Map.of(
                "user", String.valueOf(jwt.getClaimAsString("preferred_username")),
                "issuer", String.valueOf(jwt.getIssuer()),
                "expiresAt", String.valueOf(jwt.getExpiresAt()));
    }

    @GetMapping("/products")
    public List<Product> list() {
        return repository.findAll();
    }

    @PostMapping("/products")
    @ResponseStatus(HttpStatus.CREATED)
    public Product create(@RequestBody Product product) {
        product.setId(null);
        return repository.save(product);
    }
}
