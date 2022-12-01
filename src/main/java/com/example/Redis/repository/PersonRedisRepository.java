 package com.example.Redis.repository;

import org.springframework.data.repository.CrudRepository;

import com.example.Redis.entity.Person;

public interface PersonRedisRepository extends CrudRepository<Person, String> {

}
