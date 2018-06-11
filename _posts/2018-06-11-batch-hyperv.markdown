---
layout: post
title:  "[batch] Hyper-V 활성/비활성화"
date:   2018-06-11 00:00:00
categories: delphi
published: true
---

0. TOC
{:toc}

#####  Hyper-V 활성/비활성

- 윈도우에서 vmware와 docker를 같이 사용할 때 충돌이 발생 할 수 있기에 사용에 따라 활성, 비활성화 해야한다.
- Hyper-V / Vt-x 동시 사용불가
- 활성화: bcdedit /set hypervisorlaunchtype auto
- 비활성화 : bcdedit /set hypervisorlaunchtype off
- 설정 후엔 재부팅 필요

##### Batch File

- 관리자 권환 요청 후 Hyper-V 활성

{% highlight ruby %}

@echo off
 :: BatchGotAdmin
 ::-------------------------------------
 REM  --> Check for permissions
 >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
 if '%errorlevel%' NEQ '0' (
     echo Requesting administrative privileges...
     goto UACPrompt
 ) else ( goto gotAdmin )

:UACPrompt
     echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
     echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
     exit /B

:gotAdmin
     if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
     pushd "%CD%"
     CD /D "%~dp0"
 ::--------------------------------------  

echo 'HyperV Start'
echo 'BEGIN'
bcdedit /set hypervisorlaunchtype auto
echo 'END'

pause
{% endhighlight %}