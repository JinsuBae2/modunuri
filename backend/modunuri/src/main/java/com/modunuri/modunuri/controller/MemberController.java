package com.modunuri.modunuri.controller;

import com.modunuri.modunuri.dto.UpdateResponse;
import com.modunuri.modunuri.model.Member;
import com.modunuri.modunuri.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/member")
public class MemberController {
    @Autowired
    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/update-profile")
    public ResponseEntity<Member> udateProfile(@RequestBody UpdateResponse updateResponse) {

    }
}

