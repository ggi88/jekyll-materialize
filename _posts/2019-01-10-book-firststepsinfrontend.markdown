---
layout: post
title:  "[book] 프론트엔드 개발 첫걸음"
date:   2019-01-10 00:00:00
categories: book
published: true
---

0. TOC
{:toc}


##### 참고
  
- 책 예제 코드: https://github.com/okachijs/jsframeworkbook

##### 프레임워크의 발전

- 프레임워크 vs 라이브러리
  - 라이브러리: 프로그램에서 필요로하는 기능을 제 3자가 사용할 수 있는 형태로 모아둔 것
  - 프레임워크: 애플리케이션의 전체 옥은 일부분의 형태를 규정 혹은 방침화한 것

- SPA(Single Page Application)
  - 브라우저 및 브라우저 렌더링 엔진 내부에서 동작하는 웹 애플리케이션
  - 프라우저에서 최초 접근한 URL을 기점으로 하여 다양한 화면으로 이동을 제공하지만 기본적으로 최초의 JTML 안에서 사용자 인터페이스가 완결됨
  - 페이지 내의 사용자 인터페이스 변화에 따라 URL이 순차적으로 변화하며, 브라우저 히스토리를 통해 앞의 페이지로 거슬러 올라갈 수 있음
  - 페이지에서 필요로 하는 데이터는 서버로부터 API등의 형태로 필요할 때마다 단편적으로 제공됨

##### React

- 사용자의 조작에 따라 사용자 인터페이스가 동적으로 변화하는 웹 애플리케이션을 개발할 수 있게 해주는 프론트엔드 라이브러리
- A JavaScript libarary fpr building user interfaces

##### Angular

- 강력한 명형행 도구와 잘 정돈된 폴더 구조, 프로젝트 생성과 동시에 각종 환경이 한번에 갖춰지는 등 필요한 기능을 모두 내장한 프론트엔드 프레임워크
- Angular CLI 명령행 도구
- 내부적으로 RxJS 사용됨

##### Vue.js

- 라이브러리적 측면과 프레임워크적인 측면을 동시에 갖는 프레임워크(프로그레시브 프레임워크)
- React처럼 가상DOM을 가지면서도 React만큼 템플릿이 자바스크립트와 밀접하게 결합하지 않는다
- 단일 파일 컴포넌트 스타일
- Vue CLI 지원

##### React Native

- React의 기술을 기반으로 모바일용 네이티브 애플리케이션을 개발하는 프레임워크
- iOS, 안드로이드 모두 지원하는 애플리케이션 개발
- 네이티브 컴포넌트를 React의 JSX로 추상화하는 방식을 취함
- A framework for building native apps with React
