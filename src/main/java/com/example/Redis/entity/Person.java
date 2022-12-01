package com.example.Redis.entity;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;

import lombok.Data;
import lombok.Getter;


@Getter
// value : Redis의 keyspace 값으로 사용, timeToLive 만료시간 지정
@RedisHash(value = "people") //, timeToLive = 30
public class Person {

    @Id // 필드가 Redis Key 값이 됨
    private String id;
    
    private String name;
    private Integer age;
    private LocalDateTime createdAt;
    
    // keyspace와 합쳐서 최종 키값은 keyspace:id
		
    public Person(String name, Integer age) {
//    	this.id = id;
        this.name = name;
        this.age = age;
        this.createdAt = LocalDateTime.now();
    }
		
}
