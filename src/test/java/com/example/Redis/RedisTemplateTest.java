package com.example.Redis;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Map;
import java.util.Set;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.data.redis.core.ValueOperations;

@SpringBootTest
public class RedisTemplateTest {
	
	@Autowired
	private RedisTemplate<String, String> redisTemplate;
		
	@Test
	void testString() {
	    ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
	    
        // key
        String key = "stringKey";

        // key : value 추가
        valueOperations.set(key, "hello");

        String value = valueOperations.get(key);
        assertThat(value).isEqualTo("hello");
	}
	
	@Test
	void testSet() {
		SetOperations<String, String> setOperations = redisTemplate.opsForSet();
		
		// key
		String key = "setKey";
		
		// key : value 추가
		setOperations.add(key, "a","c","d","b","f");
		
		Set<String> set = setOperations.members(key);
		Long size = setOperations.size(key);
		
		assertThat(set).containsOnly("a","c","d","f","b");
		assertThat(size).isEqualTo(5);	
	}
	
	@Test
	void testHash() {
		HashOperations<String, Object, Object> hashOperations = redisTemplate.opsForHash();
		
		// key
		String key = "hashKey";
		
		// key : value 추가
		hashOperations.put(key, "hello", "world");
		
		Object value = hashOperations.get(key, "hello");
		assertThat(value).isEqualTo("world");
		
		Map<Object, Object> entries = hashOperations.entries(key);
        assertThat(entries.keySet()).containsExactly("hello");
        assertThat(entries.values()).containsExactly("world");
	
	}
}
