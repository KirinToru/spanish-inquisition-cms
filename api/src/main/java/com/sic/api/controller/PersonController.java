package com.sic.api.controller;

import com.sic.api.dto.PersonCreateDto;
import com.sic.api.dto.PersonResponseDto;
import com.sic.api.service.PersonService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/persons")
public class PersonController {

    private final PersonService personService;

    public PersonController(PersonService personService) {
        this.personService = personService;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public PersonResponseDto createPerson(@RequestBody PersonCreateDto requestDto) {
        return personService.createPerson(requestDto);
    }

    @GetMapping
    public List<PersonResponseDto> getAllPersons() {
        return personService.getAllPersons();
    }
}
