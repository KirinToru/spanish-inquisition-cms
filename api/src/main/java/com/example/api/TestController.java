package com.example.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class TestController {
    @GetMapping("/ping")
    public Map<String, String> ping() {
        return Map.of(
          "status", "ok",
          "message", "The backend is working correctly!"
        );
    }
}
