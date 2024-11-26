package com.modunuri.modunuri.controller;
import com.modunuri.modunuri.model.Member;
import com.modunuri.modunuri.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import com.modunuri.modunuri.dto.ErrorResponse;
import com.modunuri.modunuri.dto.LoginRequest;
import com.modunuri.modunuri.dto.ResponseMessage;
import com.modunuri.modunuri.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class LoginController {
    @Autowired
    private final LoginService loginService;
    @Autowired
    private final MemberService memberService;

    public LoginController(LoginService loginService, MemberService memberService) {
        this.loginService = loginService;
        this.memberService = memberService;
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginRequest loginRequest) {
        String token = loginService.login(loginRequest.getUsername(), loginRequest.getPassword());
        if (token == null) {
            return ResponseEntity.badRequest().body(Map.of("message", "아이디와 비밀번호를 확인하세요."));
        }

        Member member = loginService.getUserDetail(loginRequest.getUsername());
        Map<String, Object> response = new HashMap<>();
        response.put("token", token);
        response.put("user", member);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader("Authorization") String token) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()) {
            loginService.logout();
            return ResponseEntity.ok(new ResponseMessage("Logout successful"));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ErrorResponse("Invalid token"));
        }
    }
    @PostMapping("/register")
    public ResponseEntity<String> registerMember(@RequestBody Member member) {
        if (loginService.findByUsername(member.getUsername()) != null) {
            return ResponseEntity.badRequest().body("이미 사용중인 아이디입니다.");
        }

        loginService.registerMember(member);
        return ResponseEntity.ok("회원가입이 완료되었습니다.");
    }
}
