package com.sic.api.dto;

import com.sic.api.domain.Person;

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
