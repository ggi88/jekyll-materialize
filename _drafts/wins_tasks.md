# 업무 정리

# 1. 관리 프로젝트 및 소스
## SniperONE
- 설명: SniperONE 프로젝트 소스 및 브렌치
- 주소: git-repo@10.0.8.220:sniper_ng
- 브렌치 목록:
	- origin/Master: 메인소스
	- origin/ONE_v3.0.4: 3.0.4 브렌치
	- origin/ONE_v3.0.5: 3.0.5 브렌치
	- origin/ONE_v3.0.5_SCADA: 3.0.5 한전 스카다 버전 브렌치
	- origin/dev_commonlib: 공통 라이브러리 개발 브렌치
	- origin/dev_sessionwhitelist: 파일추출(예외) 정책 브렌치
	- origin/ONE-d_v3.0.0: 인증용 ONE-d 3.0 브렌치
	- origin/ONE-i_v3.0.0: 인증용 ONE-i 3.0 브렌치
- 참조: http://175.113.83.14/projects/sniper5/wiki/Sniper_ONE

## SniperAPTX
- 설명: SniperAPTX 2.0, 3.0, 정책관리 유틸 소스, 단종됨
- 주소: svn://10.0.8.220/SVNSERVER/activex_aptx/
- 참조: http://175.113.83.14/projects/sniper5/wiki/Sniper_APTX
	
## SniperWAF
- 설명: SniperWaf 소스, 단종됨
- 주소: svn://10.0.8.220/SVNSERVER/activex_waf/
- 참조: http://175.113.83.14/projects/sniper5/wiki/Sniper_WAF
	
## SniperVoip
- 설명: SniperVoip 소스, 단종됨
- 주소: svn://10.0.8.220/SVNSERVER/activex_voip/
- 참조: http://175.113.83.14/projects/sniper5/wiki/Sniper_VF
	
## Sniper Cripto Libaray
- 설명: 윈스 암복호화 라이브버리
- 주소:
	- Delphi 2006: svn://10.0.8.220/SVNSERVER/sniper_library/sniper_crypto_v14
	- Delphi XE8: svn://10.0.8.220/SVNSERVER/sniper_library/sniper_crypto_v14_XE
	
## Endecryptor 
- 설명: KTL 외주로 만든 암복호화 프로그램
- 주소: http://10.0.8.218/svn/sniper_crypto_KTL/

## Dephi GDI+ Tester
- 설명: GDI+ 를 이용한 델파이 그래픽 라이브러리
- 주소: http://10.0.8.218/svn/sniper_library/YUGraphics2D
	
## Sniper ONE Prototype
- 설명: ONE 제품의 프로토 타입 소스
- 주소: http://10.0.8.218/svn/activex_sniper2014

	
## sn_spu 암복호화 dll
- 설명: Sniper Cripto Libaray DLL을 만들기 위한 C 프로젝트
- 주소: svn://10.0.8.220/SVNSERVER/sniper_library/Clang_sn_spu_dll
	
## PatternDownloadManager
- 설명: 패턴업데이트 파일 일괄 다운로드 프로그램
- 주소: git-repo@10.0.8.220:project_utils
- 참조: http://175.113.83.14/projects/sniper5/wiki/%EC%9C%A0%ED%8B%B8%EB%A6%AC%ED%8B%B0_%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8
	
## Sniper SWF
- 설명: 개발 중단된 SniperFrameWork 소스
- 주석: git-repo@10.0.8.220:swf
- 참조: http://175.113.83.14/projects/swf/wiki/Wiki

# 2. 관리 서버

## VM 운용 서버
- 설명: 여러 테스트를 하기 위해 VM가 운용되는 서버, 빌드서버 운영
- 주소: 10.0.10.10
- 계정: administrator/sniper!@#1
	
### 빌드서버원격(가상 OS)
- 설명: 통합개발팀에서 생산되는 프로젝트를 빌드하는 통합빌드 시스템
- 주소: 10.0.10.11
- 계정: Administrator/sniper!@#123
- 계정: gi0210/qwe123!@#
- 이전 인증서 서명 비밀번호: Sniper17212031wins21com
- 최신 인증서 서명 비밀번호: wins21com@

## vSphere 운용 서버
- 설명: 여러 테스트를 하기 위해 VSphere가 운용되는 서버, SWF 테스트서버 운영
- 참조: http://175.113.83.14/projects/sniper5/wiki/VSphere_%EA%B0%80%EC%83%81_%EC%84%9C%EB%B2%84_%EC%A0%95%EB%B3%B4
- 주소: 10.0.10.225
- 계정: root/sniper3_01

### SWF 테스트 장비 1(가상OS)
- 설명: swf 테스트 장비 1
- 주소: 10.0.10.222:4000
- 계정: sniper/sniper!@#45

	
###  SWF 테스트 장비2(가상OS)
- 설명: swf 테스트 장비 2
- 주소: 10.0.10.229:4000
- 계정: sniper/sniper!@#1
	

### 테스트 서버(가상OS)
- 설명: SniperONE 운영 테스트
- 주소: 10.0.10.221
- 계정: sniper3/sniper!@#

# 3. 19" 상반기 고과 현황

## ONE 3.1 개발 및 릴리즈
- 상태: 진행
- 내용: Reputation 국가 입력 및 컬럼정리 이슈는 개선하였으며 사용자 정의 국가DB 설정 기능 개발 필요
- 주소: http://175.113.83.14/issues/61626

## ONE 3.0.6 멀티팩터를 이용한 로그인 개발
- 상태: 미진행
- 내용: 개발 검토부터 이루어져야함
- 주소: http://175.113.83.14/issues/61627
	
## ONE 3.0.6 파일 추출 예외 설정 개발
- 상태: 진행
- 내용: origin/dev_sessionwhitelist 브렌치에 기능개발 완료, 서버쪽과 협의하여 마스터 브렌치에 적용해야함.
- 주소: http://175.113.83.14/issues/61629
	
## ONE 3.0.6 고도화 및 관리
- 상태: 진행
- 내용: 아직 주요 이슈는 없으며, 이슈시점 마다 관리
- 주소: http://175.113.83.14/issues/61630
	
## ONE 3.0.4 고도화 및 관리
- 상태: 진행
- 내용: 공통모듈 개선 작업 진행 중, origin/dev_commonlib 브렌치에서 확인가능함
- 주소: http://175.113.83.14/issues/61631

##  ONE 3.x 인증
- 상태: 진행
- 내용: 런처관련 이슈를 제외한 SniperONE에서의 인증이슈는 현재 모두 해결
- 주소: http://175.113.83.14/issues/61632

	
## 빌드시스템 관리 및 개선
- 상태: 미진행
- 내용: 시스템 운영정책부터 검토해야함
- 주소: http://175.113.83.14/issues/61633
	
