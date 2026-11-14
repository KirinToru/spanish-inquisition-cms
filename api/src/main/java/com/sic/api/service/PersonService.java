package com.sic.api.service;

import com.sic.api.domain.Person;
import com.sic.api.dto.PersonCreateDto;
import com.sic.api.dto.PersonResponseDto;
import com.sic.api.repository.PersonRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PersonService {

    private final PersonRepository personRepository;

    public PersonService(PersonRepository personRepository) {
        this.personRepository = personRepository;
    }

    @Transactional
    public PersonResponseDto createPerson(PersonCreateDto dto) {
        Person person = new Person(
                dto.firstName(),
                dto.lastName()
        );

        Person savedPerson = personRepository.save(person);

        return PersonResponseDto.fromEntity(savedPerson);
    }

    public List<PersonResponseDto> getAllPersons() {
        return personRepository.findAll().stream()
                .map(PersonResponseDto::fromEntity)
                .toList();
    }
}