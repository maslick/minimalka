package io.maslick.minimalka;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.http.MediaType.APPLICATION_JSON_UTF8_VALUE;

@RestController
@CrossOrigin
public class RestAPI {
	@GetMapping(value = "/helloworld", produces = APPLICATION_JSON_UTF8_VALUE)
	public String hello() {
		return "{\"hello\": \"Hello world\"}";
	}
}
