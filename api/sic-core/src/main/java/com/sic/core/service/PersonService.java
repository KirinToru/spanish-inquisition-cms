package com.sic.core.service;

import com.sic.core.domain.Person;
import com.sic.core.dto.PersonCreateDto;
import com.sic.core.dto.PersonResponseDto;
import com.sic.core.repository.PersonRepository;
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