package com.example.Redis;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.Redis.entity.Person;
import com.example.Redis.repository.PersonRedisRepository;

@SpringBootTest
public class RedisRepositoryTest {
	
    @Autowired
    private PersonRedisRepository repo;
    
    @Test
    void test() {
        Person person = new Person("Kimhg", 27);

        // 저장
        Person a = repo.save(person);
        System.out.println(a.getId());
        System.out.println(a.getName());
        System.out.println(a.getAge());
        System.out.println(a.getCreatedAt());
        System.out.println(repo.count());

        // `keyspace:id` 값을 가져옴
        repo.findById(person.getId());

        // Person Entity 의 @RedisHash 에 정의되어 있는 keyspace (people) 에 속한 키의 갯수를 구함
        repo.count();
        
        // 삭제
       // repo.delete(person);
    }
    
}
