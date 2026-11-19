package com.api.core.dto;

import com.api.core.domain.Person;

public record PersonResponseDto(
        long id,
        String fullName
) {
    public static PersonResponseDto fromEntity(Person person) {
        return new PersonResponseDto(
                person.getId(),
                person.getFirstName() + " " + person.getLastName()
        );
    }
}
