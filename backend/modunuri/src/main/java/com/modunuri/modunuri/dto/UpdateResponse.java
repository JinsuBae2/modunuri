package com.modunuri.modunuri.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class UpdateResponse {
    private String username;
    private String email;
    private String phoneNumber;
    private LocalDate birthDate;
}
