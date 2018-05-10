---
layout: post
title:  "[network] DNP3(Distriuted Network Protocol 3)"
date:   2018-04-19 00:00:00
categories: network
published: true
---

0. TOC
{:toc}

##### DNP3 (Distriuted Network Protocol 3)
 - DNP3는 현장제어장치와 중앙 운영 센터 사이에서 수집된 데이터 정보와 제어 메시지의 전송에 최적화되어 설계된 표준 통신 프로토콜
- 2010년 7월 DNP Technical Committee 와 IEEE Std 1815-2010을 통해 DNP3를 발표
- 2012년 10월, IEEE Std 1815-2012를 통해 DNP3의 많은 부분이 업데이트, DNP3 Secure Authentication v5 포함


##### format
<pre>
- DNP3
+----------+-----------+-------------+
| DataLink | Transport | Application |
+----------+-----------+-------------+
|10        | 1         | n           | Byte
+----------+-----------+-------------+


- DataLink
+--------+--------+---------+-------------+--------+-----+
| Header | Length | Control | Destination | Source | SRC |
+--------+--------+---------+-------------+--------+-----+
|2       | 1      | 1       | 2           | 2      | 2   | Byte
+--------+--------+---------+-------------+--------+-----+

-- Header : 시작 0x05, 0x64 고정
-- Length : 데이터 사이즈, Control + Destination, Source, User Data 사이즈, Header, Length, CRC는 제외되며 최대 255(FF)이다
-- Control
+-----+-----+-----+---------+---------------+
| DIR | PRM | FCB | FCV/DFC | FUNCTION CODE |
+-----+-----+-----+---------+---+---+---+---+
| 7   | 6   | 5   | 4       | 3 | 2 | 1 | 0 | Bit
+-----+-----+-----+---------+---+---+---+---+

--- DIR : 전송방향(1 Master > Slave, 0 Slave > Master)
--- PRM : 1 Primary, 0 Secondary
--- FCB : Frame Count Bit(정상 완료 시 0, 1이 반전)
--- FCV/DFC : 
  Frame Count Valid(Requst) / Data Flow Control(Response)
  FCV: 1인 경우 Response에서 FCB 확인  
  DFC: 수신 Buffer의 Overflow가 예상이 될 때 1로 전송
--- Function Code
---- Primary
  0   Remote Link Reset (Confirm Expected)
  1   User Process Reset (Confirm Expected)
  2   Test Function Expected (Confirm Expected)
  3   User Data Expected (Confirm Expected)
  4   Unconfirmed User Data Expected (No Reply Expected)

---- Secondary
  0   Confirm (ACK-positive akcnowledgement)
  1   Confirm (NACK-Message not accepted, Link busy)
  11  Respond (Link Status DFC=0 or DFC=1)

-- Destination : 수신측 DNP 주소
-- Source : 발신측 DNP 주소
-- CRC : CRC-16, Block 단위 에러검증 코드


- Transport
+-----+-----+-----------------------+
| FIN | FIR | SEQUENCE              |
+-----+-----+---+---+---+---+---+---+
| 7   | 6   | 5 | 4 | 3 | 2 | 1 | 0 | Bit
+-----+-----+---+---+---+---+---+---+

-- FIN(Final), FIR(First)는 전문 전송의 시작과 끝을 표시한다.
  FIN FIR 설명
  1   1   단일 User 전문
  1   0   복수 전문중 마지막
  0   1   복수 전문중 처음
  0   0   복수 전문중 중간
-- Sequence는 전솔되는 전문의 순서 번호이며 0~63까지 증가후 0으로 리셋


- Application (Slave 측 사용시에만 IIN 존재)
+----+----+-------+--------------+-----------+-------+----------+
| AC | FC | (IIN) | Object Group | Quallfier | Range | Data ... |
+----+----+-------+--------------+-----------+-------+----------+
| 1  | 1  | 2     | 2            | 1         | 2 ~ 4 | n        | Byte
+----+----+-------+--------------+-----------+-------+----------+

-- AC : Application Control
+-----+-----+-----+-------------------+
| FIN | FIR | CON | SEQUENCE          |
+-----+-----+-----+---+---+---+---+---+
| 7   | 6   | 5   | 4 | 3 | 2 | 1 | 0 | Bit
+-----+-----+-----+---+---+---+---+---+

--- FIN, FIR: Transport Header 와 같은 의미
--- CON : Confirm(확인응답 요구 시 1, 확인 응답시 0)
--- Sequence: 정규 전문 송수신 시 0~15까지 사용 후 0으로 리셋, 비정규 전문 송수신 시 16~31까지 사용 후 16으로 리셋
-- FC : Function Code 전문의 목적
--- FC Type
  Code  Function
  0x00  Confirm                         
  0x01  Read
  0x02  Write
  0x03  Select
  0x04  Operate
  0x0d  Cold Start
  0x0e  Warm Start
  0x14  Enabled Unsollcited Message
  0x15  Disabled Unsollcited Message 
  0x81  Response
  0x82  Unsolicited Message

-- IIN : Internal Indication, Slave 측에서 응답 시 오류정보를 Bit 로 표시
--- 선행 Byte
  Bit   해당 Bit가 1이 되는 경우
  0x80  Device Restart
  0x40  Device Fail
  0x20  DNP로 접근 불가능한 DO Point 가 있음
  0x10  Time Sync 필요
  0x08  Class 3 Data가 있음
  0x04  Class 2 Data가 있음
  0x02  Class 1 Data가 있음
  0x01  전문 수신 완료
  
--- 후행 Byte
  Bit   해당 Bit가 1이 되는 경우
  0x80  사용 안함
  0x40  사용 안함
  0x20  설비 구상 정보 이상
  0x10  수행 완료된 Request가 재차 요구된 경우
  0x08  Event Buffer Overflow
  0x04  Out Of Range
  0x02  미사용 Data 또는 기능 요구
  0x01  사용 않함

-- Object Group : Object 와 그에 속한 하위 Variaton으로 구성
  Object  Varlation   정보
  0x01    00, 01, 02  BINARY INPUT WITH STATUS
  0x02    01          BINARY INPUT CHANGE WITHOUT TIME
  0x02    02          BINARY INPUT CHANGE WITH TIME
  0x0a    00, 02      BINARY OUTPUT STATUS
  0x0c    01          CONTROL RELAY OUTPUT BLOCK
  0x1e    00, 02      16-BIT ANALOG INPUT
  0x32    01          TIME AND DATE
  0x3c    02          CLASS 1 DATA
  0x3c    03          CLASS 2 DATA
  0x3c    04          CLASS 3 DATA
  0x46    01          FILE IDENTIFIER
  0x50    01          INTERNAL INDICATION
  0x50    02          EXTRA LINE CHECK
  
-- Qualifier: Range의 길이와 의미를 결정
+---+------------+----------------+
| 0 | Index Size | Qualifier Code |
+---+---+---+----+---+---+---+----+
| 7 | 6 | 5 | 4  | 3 | 2 | 1 | 0  | Bit
+---+---+---+----+---+---+---+----+
--- Qualifier Code
  Index Size 설명
  0          Range 내에서 Start, Stop Index가 8bit
  1          Range 내에서 Start, Stop Index가 16bit
  2          Range 내에서 Start, Stop Index가 32bit
  3          Range 의 절대 주소 Identifier 8bit
  4          Range 의 절대 주소 Identifier 16bit
  5          Range 의 절대 주소 Identifier 32bit
  6          Range 의 길이가 0
  7          Range 내의 정보가 8bit
  8          Range 내의 정보가 16bit
  9          Range 내의 정보가 32bit
  10         사용 안함
  11         Range의 길이가 위의 정의 보다 긴 경우 사용
  12~15      사용 안함

-- Range : User Data에 사용될 데이터의 시작과 끝 정보를 표시
</pre>

##### DNP3 Sample Captures
- [dnp3_read.pcap](https://wiki.wireshark.org/SampleCaptures?action=AttachFile&do=get&target=dnp3_read.pcap)
- [dnp3_select_operate.pcap](https://wiki.wireshark.org/SampleCaptures?action=AttachFile&do=get&target=dnp3_select_operate.pcap)
- [dnp3_write.pcap](https://wiki.wireshark.org/SampleCaptures?action=AttachFile&do=get&target=dnp3_write.pcap)


##### 참조
- [보안공학연구논문지](http://www.sersc.org/journals/JSE/vol7_no1_2010/2.pdf)
- [A Linux-based firewall for the DNP3 protocol(semanticscholar.org)](https://www.semanticscholar.org/paper/A-Linux-based-firewall-for-the-DNP3-protocol-Nivethan-Papa/ba81e21d27f243d6e3620a1256cbdc524ce44492)
- [wiki.wireshark.org/SampleCaptures](https://wiki.wireshark.org/SampleCaptures)