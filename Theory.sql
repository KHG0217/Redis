레디스
	1. 레디스란
		-> REmote Dlctionary Server의 약자로 오픈소스 DBMS입니다.
		In-memory(인메모리) 데이터 저장소이며, Key-Value기반의 NoSQL DBMS 입니다.
		보통 DB, Cashe, 메시지 브로커 등의 용도로 사용한다.
		메모리에 저장하기 때문에 디스크에 저장하는 데이터베이스보다 속도가 빠르다
		* 메모리 계층 사진 참고
		
		* NOSQL - key value값을 가진 비정형 데이터를 저장 
		- 검색,추가기능같은 것을 응답, 처리를 빠른 속도로 처리 가능
		- 반정형데이터, 비정형데이터를 유연한 스키마로 빠르고 반복적인 개발을 할 수있음
		- 분산처리 쉬움
		- 조인은 불가능
		- 트랜잭션 지원 안함
		- 확장성, 가용성, 높은성능
		- 수정과 삭제 사용이 힘들다
		- 다수가 오픈소스 제공을 하고있다.

		-> 초당 10만 ~ 15만건의 명령을 수행 가능, 리눅스는 100만건도 가능
		
		-> 여러서버에서 같은 데이터를 공유할때
		   Atomic자료구조 나 캐시를 사용할때 
		   
		   * Atomic(원자성)
		   		- 원자라는 의미를 가지며 원자적 연산, 더이상 쪼개어질 수 없는 연산을 진행
		   		- 원자적 연산은 처리하는 중간에 다른 스레드가 끼어들 여지를 주지 않으며,
		   		  전부 처리하거나 or 아무것도 하지 못한다. 이 두가지 상황이 존재하는연산
		   		  즉 한번만 일어나는 연산이다.
		   		- 싱글 스레드 환경에서는 중요하지 않으나 멀티 스레드 환경에서는 중요하다.
		   		  -> 둘이상의 스레드가 공유 자원에 접근할때 발생하는 문제를 '경쟁상태'라고 한다.
		   		     '경쟁상태'는 mutex와 같은 상호 배제 객체로 해결이 간으하나 atomic 연산을
		   		     통해 가능하다.
		   		- 메모리 가시성 문제또한 해결한다. 
		   		* 가시성이란 멀티 코어의 캐시 불일치 문제
		   		  하나의 스레드에서 특정한 변수의 값을 수정하였는데, 다른 스레드에서 그 수정된 값을
		   		  제대로 읽어 들인다는 보장이 없다. CPU에서 메모리에 선언된 변수를 읽어 들일 때
		   		  최적화를 위해 해당 메모리 주위에 메모리를 가져가 캐시에 저장한다.
		   		  
		   		  =lock 짧음 -> 다른쪽에서 대기할 시간이 준다. -> 병렬처리에 효율이 높기때문에 속도가 빠르다.
			

	2. 용어
		1. RSS (Resident Set Size)
		- 실제 메모리 사용

		2. AOF(Append Only File)
		- 명령이 발생할 때마다 기록하는 장소
		- 서버가 재시작 할 시 write/update를 순차적으로 재실행

		3. COW (Copy On Write)
		- 레디스가 데이터를 쓰기 위해 사용하는 매커니즘
	
	3. 특징
		1. 싱글스레드 기반 명령 수행 
		- 이를 통해 Atomic operations을 보장하며, 동시성을 지원

		2. Key-Value 기반으로 데이터 저장

		3. 다양한 DataType 지원
		( Strings, hashes, lists, sets, sorted sets, bitmaps, hyperloglogs, geospatial indexes, streams)
		- 개발 편의성 극대화
		*Lists의 경우 일반적인 RDB보다 10배 빠름 

		4. Master-Slave 구성이 가능 
		- Master-Slave와 같은 Redis Replication뿐 아니라 Redis cluster을 이용한 분산처리,
		  Redis Sentinel을 이용한 장애복구 시스템을 제공합니다.

		* Copy on Write
		- 레디스의 프로세스들은 자원을 공유
		- 데이터에 대한 쓰기명령이 발생하면 프로세스는 fork()되고, 쓰기 대상이 되는 자원을
		  Copy한 뒤 명령을 수행함
		- 이와 같은 특징으로 레디스는 메모리공간을 2배로 사용하게 되며, 메모리 파편화가 발생하기 쉬움
		* 그림 1 참고

		* 메모리 파편화
			-> 메모리를 할당하고 해제하는 과정에서 메모리 공간을 할당하지 못해
			프로세스가 죽는 문제 발생
			* 그림 2 참고
			
			
	4. Redis Cli 명령어
		1. CRUD 명령어
			- keys * - 현재의 키값들을 확인 가능 (데이터 많을경우 과부하 주의)
			
			- set key / value 형태로 저장하기 - set [key] [value]
			ex) set k_one v_one
			
			- mset 여러개의 key / value 형태로 저장하기 - mset [key1] [value1] [key2] [value2]
			ex) mset k_two v_two k_tree v_tree
			
			- setex 소멸시간 지정해서 저장하기 - setex [key] [s] [value]
			ex) setex k_four 10 v_four (10초후)
			
			- ttl 타임아웃까지 남은 시간을 초단위로 반환 - ttl [key]
			ex) ttl k_four

			- pttl 타임아웃까지 남은 시간을 밀리 초단위로 반환 - pttl [key]
			ex) pttl k_four
			
			   (integer) -2 는 key값이 없거나 소멸된 경우 출력됩니다.
			   (integer) -1 는 기한이 없는경우 출력됩니다.
 				
			- get key에 해당하는 value를 조회하기 - get [key]
			ex) get k_one (해당 value값이 없다면 nil)
			
			- mget 여러개의 key에 해당하는 value를 조회하기 - mget [key1] [key2]
			ex) mget k_two k_tree
			
			- del 해당 key와 value를 삭제하기 - del [key]
			ex) del k_one ( integer 0 - 해당키 없을경우 or 1 - 삭제완료)
			
			- keys *검색어* - key *검색단어* (해당단어가 들어간 모든 key 검색) 
			ex) keys *k*
			
			- rename [기존key] [변경할key]
			(변경할 key명이 존재할경우 덮어씌움)
			ex) renmae k_two k_two_re
			
			- renamenx [기존key] [변경할key]
			(변경할 key명이 존재할경우 실행 x)
			(integer)는 해당 key가 존재할 경우 출력
			
			- flushall - 모든 데이터 삭제
			
			- SELECT[1~15] - DB조회 (1 ~ 15까지 DB 정해짐 0이 default)
			
			- RANDOMKEY - 랜덤으로 key 조회
			
			- keys [key] - [key] 조회가능 (존재하면 1 없으면 0)
			
			
			
			
			 
	
	
	
	
	
	
	