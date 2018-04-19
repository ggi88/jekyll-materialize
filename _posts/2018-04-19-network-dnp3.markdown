---
layout: post
title:  "[network] DNP3(Distriuted Network Protocol 3)"
date:   2018-04-19 00:00:00
categories: network
published: true
---
##### DNP3 (Distriuted Network Protocol 3)
 - DNP3는 현장제어장치와 중앙 운영 센터 사이에서 수집된 데이터 정보와 제어 메시지의 전송에 최적화되어 설계된 표준 통신 프로토콜
- 2010년 7월 DNP Technical Committee 와 IEEE Std 1815-2010을 통해 DNP3를 발표
- 2012년 10월, IEEE Std 1815-2012를 통해 DNP3의 많은 부분이 업데이트, DNP3 Secure Authentication v5 포함


##### format
![DNP3 message architecure](/downloads/DNP3/DNP3_message_architecure.png){: width="100%" }


##### DNP3 Sample Captures
- [dnp3_read.pcap](https://wiki.wireshark.org/SampleCaptures?action=AttachFile&do=get&target=dnp3_read.pcap)
- [dnp3_select_operate.pcap](https://wiki.wireshark.org/SampleCaptures?action=AttachFile&do=get&target=dnp3_select_operate.pcap)
- [dnp3_write.pcap](https://wiki.wireshark.org/SampleCaptures?action=AttachFile&do=get&target=dnp3_write.pcap)


##### 참조
- [보안공학연구논문지](http://www.sersc.org/journals/JSE/vol7_no1_2010/2.pdf)
- [A Linux-based firewall for the DNP3 protocol(semanticscholar.org)](https://www.semanticscholar.org/paper/A-Linux-based-firewall-for-the-DNP3-protocol-Nivethan-Papa/ba81e21d27f243d6e3620a1256cbdc524ce44492)
- [wiki.wireshark.org/SampleCaptures](https://wiki.wireshark.org/SampleCaptures)