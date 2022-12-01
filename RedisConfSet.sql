요약

기본설정

daemonize (daemon으로 실행 여부 설정)

pidfile (daemon 실행시 pid가 저장될 파일 경로)

port (접근을 허용할 port 설정)

bind (요청을 대기할 interface[랜카드] 설정)

unixsocket, unixsocketperm (요청을 대기할 unix 소켓 설정)

timeout (client와 connection을 끓을 idle 시간 설정)

loglevel (loglevel 설정)

logfile (log 파일 경로 설정)

syslog-enabled (system logger 사용 여부 설정)

syslog-ident (syslog에서의 identity 설정)

syslog-facility (syslog facility 설정)

databases (database 수 설정)

 

REPLICATION

slaveof (master server 설정)

masterauth (master server 접근 비밀번호 설정)

slave-server-stale-data (master와 connection이 끊긴 경우 행동 설정)

repl-ping-slave-perid (미리 정의된 서버로 PING을 날릴 주기 설정)

repl-timeout (reply timeout 설정)

 

SECURITY

requirepass (server 접근 비밀번호 설정)

rename-command (command 이름 변경)

 

LIMITS

maxclients (최대 client 허용 수 설정)

maxmemory (최대 사용가능 메모리 크기 설정)

maxmemory-policy (maxmemory 도달 시 행동 설정)

maxmemory-samples (LRU 또는 mnimal TTL 알고리즘 샘플 수 설정)

 

APPEND ONLY MODE

appendonly (AOF 사용여부 설정)

appendfilename (AOF 파일명 설정)

appendsync (fsync() 호출 모드 설정)

no-appendfsync-on-rewrite (background saving 작업시 fsync() 호출 여부 설정)

auto-aof-rewrite-percentage, auto-aof-rewrite-min-size (AOF file rewrite 기준 설정)

 

SLOW LOG

slowlog-log-slower-than (slow execution 기준 설정)

slowlog-max-len (최대 저장 slow log 수 설정)

 

VIRTUAL MEMORY

vm-enabled (vm 모드 사용여부 설정)

 

ADVANCED CONFIG

hash-max-zipmap-entries, hash-max-zipmap-value (hash encode 사용 기준 설정)

list-max-ziplist-entries, list-max-ziplist-value (list encode 사용 기준 설정)

set-max-intset-entries (set encode 사용 기준 설정)

zset-max-ziplist-entries, zset-max-ziplist-value (sorted set encode 사용 기준 설정)

activerehashing (자동 rehashing 사용 여부 설정)

 

기본설정

daemonize [boolean] (기본값: no)

Redis는 기본적으로 daemon으로 실행하지 않는다. 만약 Daemon으로 실행하고 싶다면 'yes'를 사용해라.

Redis는 daemon으로 실행될 때 '/var/run/redis.pid' 파일에 pid를 기록할 것이다.

예) daemonize no

 

pidfile [file path] (기본값: /var/run/redis.pid)

daemon으로 실행 시 pid가 기록될 파일 위치를 설정한다. 값이 설정되지 않으면 '/var/run/redis.pid'에 pid를 기록한다.

예) pidfile /ver/run/redis.pid

 

port [number] (기본값: 6379)

Connection을 허용할 Port를 지정한다. 기본값은 6379이다.

만약 port 값을 0으로 지정하면, Redis는 어떤 TCP socket에 대해서도 listen하지 않을 것이다.

예) port 6379

 

bind [ip] (기본값: 모든 인터페이스)

Redis를 bind 할 특정 interface(랜카드)를 지정할 수 있다. 만약 명시하지 않으면, 모든 interface로부터 들어오는 요청들을 listen할 것이다.

예) bind 127.0.0.1

 

unixsocket [path], unixsocketperm [number] (기본값: 없음)

들어오는 요청을 listen할 unix socket의 결로를 지정한다. 이 설정에는 기본 값이 없다. 따라서 값이 지정되지 않으면 unix socket에 대해서는 listen하지 않을 것이다.

예) unixscoket /tmp/redis.sock

예) unixsocketperm 755

 

timeout [second]

client의 idle이 N 초 동안 지속되면 connection이 닫힌다. (0으로 지정하면 connection이 계속 유지된다.)

예) timeout 0

 

loglevel [level]

logl evel 을 지정한다. Log level 에는 아래 4가지 중 하나를 지정할 수 있다.

 loglevel​

 

 설 명​

 

 debug​

 

 엄청나게 많은 정보를 기록한다. 개발과 테스테 시 유용하다.​

 

 verbose​

 

 유용하지 않은 많은 양의 정보를 기록한다. 하지만 'debug level'만큼 많지는 않다.​

 

 notice​

 

 제품을 운영하기에 적당한 양의 로그가 남는다.​

 

 warning​

 

 매우 중요하거나 심각한 내용만 남는다.​


예) loglevel verbose

 

 

logfile [file path]

로그 파일을 명시한다.'stdout'로 Redis가 the standard output에 로그를 기록하도록 할 수 있다. 만약 'stdout'를 명시했으나 Redis가 daemon으로 동작한다면 로그는 /dev/null logfile stdout 로 보내질 것이다. 따라서 로그가 남지 않을 것이다.

예) logfile stdout

 

syslog-enabled [boolean]

system logger를 사용해서 logging 할 수 있게 한다. 단지 'yes'로 설정하고 추가적 설정을 위해서 다른 syslog parameter들을 설정할 수 있다.

예) syslog-enabled no

 

syslog-ident [identity]

syslog identity를 지정한다.

예) syslog-ident redis

 

syslog-facility [facility]

syslog facility(시설)을 지정한다. 반드시 USER 또는 LOCAL0 - LOCAL7 사이 값이 사용되어야 한다.

예) syslog-facility local0

 

databases [size]

dababase들의 숫자를 설정한다. 기본 dababase는 DB 0이다. 물론 connecton당 'SELECT <dbid>' 사용해서 다른 database를 선택할 수 있다. dbid는 0 과 'database 수 - 1'사이의 수이다.

예) databases 16

 

SNAPSHOTTING (RDB 지속성 설정)

save [seconds] [changes]

disk에 DB를 저장한다. DB에서 주어진 값인 seconds와 changes를 모두 만족시키면 DB를 저장 할 것이다.

이 설정은 여러번 설정할 수 있다.

 

아래는 예제를 설명한 것이다.

900초(15)분 동안에 1개 이상의 key 변경이 발생했다면 DB를 저장한다.

300초(5)분 동안에 10개 이상의 key 변경이 발생했다면 DB를 저장한다.

60초(1)분 동안에 10000개 이상의 key 변경이 발생했다면 DB를 저장한다.

실제 서비스에서는 너무 자주 동기화가 일어나게 설정하면 안된다.

 

주목: DB를 저장하고 싶지 않으면 모든 save 라인들을 주석 처리한다.

 

예) save 900 1

예) save 300 10

예) save 60 10000

 

 

rdbcompression [boolean] (기본값: yes)

.rbd database를 덤플 할 때 LZF를 사용해서 문자열 부분을 압축할지 설정한다.

압축하는 것은 대부분의 경우 좋기 때문에 기본값은 'yes'이다.

만약 child set을 저장할 때 CPU 사용을 절약하고 싶다면 'no'로 설정한다. 하지만 values 또는 keys가 압축이 가능했다면, dataset은 보다 커질 것이다.

예) rdbcompression yes

 

dbfilename [file path]

DB가 dump될 파일을 설정한다.

예) dbfilename dump.rdb

 

dir [directory path]

DB가 기록될 디렉토리를 설정한다. DB dump파일은 위의 dbfilename과 함께 최종적으로 파일이 기록될 곳이 지정된다.

Append Only File 또한 이 디렉토리에 파일을 생성할 것이다.

반드시 여기에 디렉토리를 설정해야 한다. file name에 설정하면 안 된다.

예) dir ./

 

REPLICATION (복제 셋 구성 설정)

slaveof [masterip] [masterport]

Master-Slave replication을 구성하기 위해서 slaveof를 사용한다. 이것은 Redis instance가 다른 Redis server의 복사본이 되게 한다.

slave에 대한 설정은 local에 위치한다. 따라서 slave에서는 내부적으로 따로 DB를 저장 하거나, 다른 port를 listen하는 등 slave만의 설정이 가능하다.

예) slaveof 127.0.0.1 6379

 

masterauth [master-password]

만약 master에 password가 설정되어 있다면 replication synchronization(복제 동기화) 과정이 시작되기 전에 slave의 인증이 가능하다. (이것은 "requirepass" 설정으로 가능하다). 만약 password가 틀리다면 slave의 요청은 거절될 것이다.

예) masterauth password1234 

 

slave-server-stale-data [boolean] (기본값: yes)

만약 slave가 master와의 connection이 끊어 졌거나, replication이 진행 중일 때는 아래의 2가지 행동을 취할 수 있다.

'yes(기본값)'로 설정한 경우, 유효하지 않은 data로 client의 요청에 계속 응답할 것이다. 만약 첫번째 동기화 중이였다면 data는 단순히 empty로 설정될 것이다.

'no'로 설정한 경우, INFO와 SLAVEOF commad(명령)을 제외한 모든 command들에 대해서 "SYNC with master in progress" error로 응답할 것이다.

예) slave-server-stale-data yes

 

repl-ping-slave-perid [seconds] (기본값: 10)

Salve가 내부적으로 미리 정의된 server로 지정된 시간마다 PING을 보내도록 설정한다.

예) repl-ping-slave-perid 10

 

repl-timeout [seconds] (기본값: 60)

'bulk transfer I/O(대량 전송 I/O) timeout'과 'master에 대한 data또는 ping response timeout'을 설정한다.

이 값은 'repl-ping-slave-period' 값 보다 항상 크도록 설정되어야 한다. 그렇지 않으면 master와 slave간 작은 traffic이 발생할 때 마다 timeout이 인지될 것이다.

예) repl-timeout 60

 

SECURITY (보안 설정)

requirepass [password]

client에게 다른 command들을 수행하기 전에 password를 요구하도록 설정한다. 이것은 redis-server에 접근하는 client들을 믿을 수 없는 환경일 때 유용한다.

반대로 개방적으로 사용하기 위해서는 주석 처리 되어야 한다. 왜냐하면 대부분의 사람들은 auth가 필요하지 않기 때문이다.

주의: Redis는 매우 빠르기 때문엔 좋은 환경에서는 외부 사용자가 1초 당 15만개의 password를 시도할 수 있다. 따라서 매우 강력한 password를 설정해야 한다.

예) requirepass foobared

 

rename-command [target-command] [new-command]

Commnad renaming

공유되는 환경에서는 위험한 command들의 이름을 변경할 수 있다. 예를 들어서 CONFIG command를 추측하기 어려운 다른 값으로 변경할 수 있다. 물론 internal-use tool로는 해당 명령어가 사용하지만, 일반적인 외부 client들에 대해서는 불가능하다.

예) rename-command CONFIG b840fc02d524045429941cc15f59e41cb7be6c52

또한 command를 공백으로 rename해서 완전히 사용 불가능하게 할 수도 있다.

예) rename-command CONFIG ""

 

LIMITS (접속 및 메모리 설정)

maxclients [size] (기본값: 제한 없음)

한번에 연결될 수 있는 최대 client 수를 설정한다. 기본값은 제한이 없으나, Redis process의 file descriptor의 숫자만큼 연결가능하다. 특별히 '0' 값은 제한 없음을 의미한다.

limit에 도달했을 때 새로운 connection들에 대해서는 'max number of clients reached' error를 전송한고 connection을 close 한다.

예) maxclients 128

 

maxmemory [bytes]

명시한 bytes의 양보다 많은 메모리를 사용하지 말아라.

memory가 limit에 도달했을 때 Redis는 선택된 eviction policy(제거 정책)(maxmemory-policy)에 따라서 key들을 제거할 것이다.

 

만약 Redis가 eviction policy에 의해서 key를 제거하지 못하거나 polict가 'noeviction'으로 설정되어 있다면, SET, LPUSH와 같이 메모리를 사용하는 command들에 대ㅐ서는 error를 반환하고, 오직 GET 같은 read-only command들에 대해서만 응답할 것이다.

 

주의: maxmoery 설정 된 instance에 slave가 존재 할 때, slave에게 data를 제공하기위해서 사용되는 output buffer의 size는  used memory count에서 제외된다. 왜냐하면 network 문제나 재동기화가 keys들이 제거된 loop에 대한 trigger를 발생시키지 않게 하기 위해서이다. loop가 발생하면 slave의 output buffer가 제거된 key들의 DEL 명령으로 가득 찰 것이다. 그리고 이것은 database가 완전히 빌 때 까지 지속된다. (좀 더 정확히 알아볼 필요가 있다. 확실히 이해가 안 됨)

 

간단히 말하면, 만약 slave를 가진다면, slave output buffer를 위해서 system에 약간의 free RAM이 존재시키기 위해서, maxmoery에 약간 낮은 limit를 설정하는 것이 추천된다. (하지만 policy가 'noeviction'이면 필요하지 않다.)

 

큰 메모리를 표시하기 위해서 아래와 같이 표기가 가능하다.

 

1k 1,000 bytes

1kb 1024 bytes

1m 1,000,000 bytes

1mb 1024*1024 bytes

1g 1,000,000,000 bytes

1gb 1012*1024*1024 bytes

예) maxmoery 1000

 

maxmemory-policy [policy] (기본값: volatile-lru)

MAXMEMORY POLICY: maxmemory에 도달했을 때 무엇을 삭제 할 것인지 설정한다. 아래 5개 옵션 중 하나를 선택할 수 있다.

 

옵션 설 명

volatile-lru expire가 설정된 key 들 중 LRU algorithm에 의해서 선택된 key를 제거한다.

allkeys-lru 모든 key 들 중 LRU algorithm에 의해서 선택된 key를 제거한다.

volatile-random expire가 설정된 key 들 중 임의의 key를 제거한다.

allkeys-random 모든 key 들 중 인의의 key를 제거한다.

volatile-ttl expire time이 가장 적게 남은 key를 제거한다. (minor TTL)

noeviction 어떤 key도 제거하지 않는다. 단지 쓰기 동작에 대해서 error를 반환한다.

예) maxmemory-policy volatile-lru

 

maxmemory-samples [size] (기본값: 3)

LRU와 minimal TTL algorithms(알고리즘)은 정확한(최적) 알고리즘들은 아니다. 하지만 거의 최적에 가깝다. 따라서 (메모리를 절약하기 위해서) 검사를 위한 샘플의 크기를 선택할 수 있다. 예를 들어, Redis는 기본적으로 3개의 key들은 검사하고 최근에 가장 적게 사용된 key를 선택할 것이다. 하지만 아래 예와 같이 샘플의 크기를 변경할 수 있다.

예) maxmoery-samples 3

 

APPEND ONLY MODE (AOF 지속성 설정)

appendonly [boolean] (기본값: no)

 

Redis는 기본적으로 비동기로 disk에 dataset의 dump를 남긴다. 이 방법은 crash가 발생했을 때 최근의 record를 손실되어도 문제가 없을 때 좋은 방법이다. 하지만 하나의 record도 유실되지 않기를 원한다면 append only mode를 활성화 시키는 것이 좋을 것이다.: 이 mode가 활성화 되면, Redis는 요청받는 모든 write operation들을 appendonly.aof 파일에 기록할 것이다. Redis가 재 시작될 때 memory에 dataset를 rebuild하기 위해서 이 파일을 읽을 것이다.

 

주목: 원한다면 async dumps와 asppend only file을 동시에 사용할 수 있다. 만약 append only mode가 활성화 되어 있다면, startup 때 dataset의 rebuild를 위해서 append only mode의 log file을 사용하고, dump.rdb 파일은 무시할 것이다.

 

중요: 순간적으로 write operation이 많을 때 background에서 어떻게 append log file을 rewirte 하는 방법을 확인하기 위해서 BGREWRITEAOF를 확인해라.

 

예) appendonly no

 

appendfilename [file name] (기본값: appenonly.aof)

 

append only file의 이름을 설정한다.

파일이 저장되는 디렉토리는 SNAPSHOTTING의 dir 속성을 사용한다.

 

예) appendfilename appendonly.aof

 

appendsync [option]

fsync() call 은 Operating System(운영체제)에게 output buffer 내에 보다 많은 데이터들을 기다리지 않고, disk에 실제로 data를 작성하라고 말한다. 어떤 OS 는 실제로 disk에 data를 기록할 것이고, 어떤 OS들은 가능한 빨리 data를 기록하려고 시도할 것이다.

 

Redis는 3가지의 다른 mode들을 지원한다.

 

옵션 설 명

no fsync()를 호출하지 않는다. data의 flush를 OS에 맡긴다. 빠르다.

always append only log에 wrtie 할 때 마다 fsync()를 호출한다. 느리다, 안전하다.

everysec 매 초 마다 fsync()를 호출한다. 절충안

기본값인 'everysec'은 일반적으로 속도와 데이터 안정성 사이에서 적절한 절충안이다. 이것은 당신의 관대함(?)에 달려있다. 만약 'no'로 설정한다면 OS는 적절한 타이밍에 output buffer를 flush하고 보다 좋은 성능을 낼 것이다. (그러나 만약 data loss가 발생해도 문제가 없다면 기본 persistence(영속성) mode는 snapshotting일 것이다.) 반면에 "always"를 사용하면 매우 느릴 것이다. 하지만 'everysec'보다 조금 더 안전할 것이다.

 

만약 확실하지않다면 'everysec'를 사용해라.

 

예) appendfasync everysec

 

no-appendfsync-on-rewrite [boolean]

AOF fsync policy를 always 또는 everysec로 설정했다면, background saving process(background 저장 또는 AOF log backgournd rewriting)은 disk에 대해서 매우 많은 I/O를 발생시킬 것이다. 따라서 어떤 Linux에서 fsync() call은 매우 긴 block를 발생시킬수도 있다.

 

주목: 현재 이것에 대한 fix(수정)은 없다. 다른 thread에서 fsync를 수행하더라도 동시에 발생하는 wirte call(2)이 block 될 것이다.

 

이 문제를 완화 시키기 위해서 BGSAVE 또는 BGREWRITEAOF가 수행중인 동안에 메인 process에서 fsync()가 호출되는 것을 막을 수 있는 no-appendfsync-on-rewirte option을 사용하는 것이 가능하다.

 

이것은 Redis의 영속성을 저장하는 동안에 다른 자식은 "appendfsync none"으로 설정한 것과 동일하다. 쉽게 말하면, (Linux의 기본 설정에 의해서) 최악의 경우 30초 가량의 log가 손실될 수 있다는 것이다. (이해가 잘 안됨)

 

이로 인해서 잠재적 문제가 있다면 이 옵션을 'yes'로 설정해라. 하지만 다른 경우에는 'no'로 남겨두는 것이 영속성의 view(?)부터 가장 안전한 선택이다.

 

예) no-appendfsync-on-rewrite no

 

auto-aof-rewrite-percentage [percente], auto-aof-rewrite-min-size [bytes]

Append only file의 Automatic rewrite(자동 재 작성)

Redis는 AOF log의크기가 명시된 퍼센트를 넘어갔을 때, 자동적으로 BGREWRITEAOF를 호출함으로서 log file를 재작성 하는 것이 가능하다. (비교 대상이 무엇인지 모르겠다.해당 Drive의 전체 크기인가?)

 

작동법: Redis는 최근 rewirte후에 AOF file의 크기( 또는 restart이후  rewirte가 발생하지 않았다면, startup 때 사용된 AOF의 크기)를 기억하고 있다.

 

이 기본 크기는 현재 크기와 비교되어진다. 만약 현재 크기가 설정된 퍼센트보다 크다면, rewrite가 동작하게된다. 또한 rewritten(재작성되는) AOF 파일의 최소 크기를 지정해 주어야 한다. 이것은 비록 퍼센트 증가가 설정 값에 도달하더라도 여전히 작은 크기일 때 AOF file이 rewriting되는 것은 피하는데 유용하다.

 

Automatic AOF rewirte을 비활성화 시키기 위해서는 percentage값을 0으로 설정해라.

 

예) auto-aof-rewrite-percentage 100

예) auto-aof-rewrite-min-size 64mb

 

SLOW LOG

Redis Slow Log는 설정된 실행 시간을 초과한 쿼리들의 로그를 남기는 시스템이다. 실행 시간은 talking with the client, sending the reply와 같은 I/O operation들은 포함되지 않는다. 단지 command를 수행하는데 필요한 시간(command 실행을 위해서 threaad가 block되어서 다른 request를 처리할 수 없는 시간)만이 측정된다.

 

2개의 parameter들를 통해서 slow log를 설정할 수 있다. : 첫번째 parameter는 Redis가 slow log를 기록하기 위해서  어떤 execution time이 느린 것인지 알려주기 위해서 microsencond로 설정한다. 두번째 parameter는 기록될 수 있는 slow log의 길이이다. 새로운 command가 log 되었을 때, 가장 오래전에 기록된 log가 제거된다. FIFO 형태인 것이다.

 

slowlog-log-slower-than [microseconds]

 

microsencod값으로 slow execution time를 설정한다. 1000000은 1초와 같다.

 

주의: 음수를 설정한 경우 slow log를 비활성화 시킨다. 0으로 설정한 경우 모든 command에 대해서 logging 수행된다.

 

예) slowlog-log-slower-than 10000

 

slowlog-max-len

길이에는 제한이 없다. 단지 이것은 memory를 소모하는 것은 인지하고 있어야 한다.

SLOWLOG RESET 명령으로 slow log에 의해서 사용된 memory를 반환 시킬 수 있다.

 

예) slowlog-max-len 128

 

VIRTUAL MEMORY

vm-enabled

Virtual Memory는 Redis 2.4에서 제거되었다. vm-enabled no로 설정해서 사용하지 않는다.

예) vm-enabled no

 

ADVANCED CONFIG

hash-max-zipmap-entries, hash-max-zipmap-value

hash들은 elements의 숫자가 설정된 entries(개수)에 도달하고 가장 큰 element가 설정된 threshold(기준치)를 초과하지 않으면 특별한 방법으로(보다 효과적인 메모리 사용법으로) encoded(인코딩)되어진다.

 

특별한 방법: hashtable 또는 zipmap

 

예) hash-max-zipmap-entries 512

예) hash-max-zipmap-value 64

 

list-max-ziplist-entries, list-max-ziplist-value

hash와 비슷하게 작은 list도 공간을 절약하기 위해서 특별한 방법으로 encode되어진다. 오직 설정된 값 보다 아래에 있을 때 특별한 방법이 사용되어진다.

 

특별한 방법: linkedlist 또는 ziplist

 

예) list-max-ziplist-entries 512

예) list-max-ziplist-value 64

 

set-max-intset-entries

 

Set은 오직 한 가지 경우에만 특별한 방법으로 encoded 되어진다. Set이 오직 string(문자열)로만 구성되었을 때, 64bit signed integer 범위의 radix 10의 integer로 변환된다.

아래 설정은 특별한 메모리 저장 인코딩을 사용하기 위해서 set 의 크기 제한을 설정한다. (정확한 확인 필요, 아마도 아래보다 크지 않을 때 사용하지 않을까 싶다.)

예) set-max-intset-entries 512

 

zset-max-ziplist-entries, zset-max-ziplist-value

hash 및 list와 비슷하게, sorted set도 많은 공간을 절약하기 위해서 특별하게 encoded되어진다. 이 Encoding은 sorted set의 element와 length가 설정치를 초과하지 않을 때 사용되어 진다.

 

예) zset-max-ziplist-entries 128

예) zset-max-ziplist-value 64

 

activerehashing

rehashing을 활성화 하면 main Redis has table(최상위 key-value hash table)을 rehashing하는 것을 돕기 위해서 CPU time의 매 100 millisecond 마다 1 millisencond를 사용한다. redis가 사용하는 hash table 구현은 lazy rehashing으로 동작한다. rehashing이 수행되는 hash table에서 많은 operation을 수행 할 수록, 보다 많은 rehashing 'steps'이 수행된다. 따라서 server가 idle 상태이면 rehashing은 결코 완료되지 않고, 약간의 메모리가 hash table에 의해서 사용되어진다.

 

기본값은 가능할 메모라는 free하게 만들기 위해서, main dictionary들의 rehashing을 active하는데 매 초마다 10 millisecond를 사용하는 것이다.

 

만약 힘든 잠재적 요구사항이나 당신의 환경에 적합하지 않아서 확신이 들지 않는다면 'activerehashing no'를 사용해라. 이 설정으로 인해서 Redis가 request들에 대해서 reply하는데 2 milliseoncds의 delay(지연)가 발생할 것이다.

 

만약 어려운 환경이 아니고 가장한 빠르게 메모리는 free하게 하고 싶다면 'activerehashing yes'를 사용해라.

예) activerehashing yes