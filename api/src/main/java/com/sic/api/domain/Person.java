package com.sic.api.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "persons")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private String firstName;

    @Column(nullable = false)
    private String lastName;

    public Person() {}

    public Person(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName  = lastName;
    }

    public long getId()                         { return this.id; }
    public String getFirstName()                { return this.firstName; }
    public void setFirstName(String firstName)  { this.firstName = firstName; }
    public String getLastName()                 { return this.lastName; }
    public void getLastName(String lastName)    { this.lastName = lastName; }
}
