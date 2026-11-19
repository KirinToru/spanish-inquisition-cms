package com.sic.core.dto;

import com.sic.core.domain.Person;

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
