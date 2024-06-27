Return-Path: <linux-kselftest+bounces-12887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B009E91B1A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 23:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24280B24851
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C25E19F488;
	Thu, 27 Jun 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrynArIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B94249F9;
	Thu, 27 Jun 2024 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524676; cv=none; b=S73zNebOdfWLmA0HxiM1XEMWqiDqxP9hb1d9gwfzVe4y6ph29GAH1sLz6H9Gvq11Fnkd7sTq0Bb4sYwg6QwMIktYTKF+TGDmeYG+KMtfm61LqXsqEiicWZvNUcmSHWUjRILF61dMkDHrOil4Bw0mmH4VbLLv6NBmtyFOhgxe+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524676; c=relaxed/simple;
	bh=kn68BtQ6AWZ3RcXT2AfKsVPC/rmYoZaD6FVsONJ4H34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZFt59WWeVKSfa9FmtmW/d759UKZFuAqd72HZOUGlIyn/YgYRjJCpqFAFGJN0HXXLQRhQ5VfDVDL4ULfodGp5DS8CcO7+lohUI86s5q3UFMJvSqn07xwKMKgoFyE4de36UUo3Ku+nQnylejX7dK2+TZFjwAL95mcEmaxOTMf00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrynArIl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa2ea1c443so44503615ad.0;
        Thu, 27 Jun 2024 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719524673; x=1720129473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQZBke7p8dpuWc4nCjSqAhRJMLUZMYWtUAmiNcjemkc=;
        b=YrynArIlVU1FBHuQV3IK3XxujZL/hU+IqxmWJIb/6TNSzWjV6Pz57zduepZhU88cOw
         QOMkEgrGoZRb1GWfwn4Yf/JV4tfoUFv/n3IR40ZSq2ci/bDVk1k8F9XpehpqGZ8klGuX
         T//XHCDMsfNqDLGRUpPWWDMOLIormqxByG1TYqwvy28mJdaPw27DQIZ5ORAmpA5sp8YX
         +2jGZ45H58tYYxvRyPcQSpa3TJ5X5heBxmlgBdSMTggtivClvG9BR5dtmnYxbmlSu/TG
         LkjhR0C5NTlL3n+9AVSK+TT308YIcVuH7YOvpp8bJlym7ec5NXDUZDIRPiQfQBspPNT3
         dEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719524673; x=1720129473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQZBke7p8dpuWc4nCjSqAhRJMLUZMYWtUAmiNcjemkc=;
        b=w6Jt30TCLvP1T7pOsoN5HZtNmTa0JEE14xUywc2U+1hcnRZ5h9g5ALzmnL5d3iAC05
         IgxWrfV9np2F7lsW/+8QMlKd/w0II0klfPvdTyDhK33sbcNLIFSuDaKGwenUOYKUT8+I
         5/9vC6kthHkHkVDw1aksicFnBBmdQPwlHf7qsv80EzYVLK0liGIUSPCoKmHewDTcEmYO
         AlFqyOuXapVzKk4zLwKxMJxR0r/ny5H0AgTxP9gGZcazUGh35Uuz5SW6SYuNvDtTVn7j
         +UMyyoFFCp1iFQLvuSM/3mwZEuoA1spsFxQLPEiF1KlZ/TPAMdKKhmNRtmOjD1BFzbsp
         yG5g==
X-Forwarded-Encrypted: i=1; AJvYcCXsE/DeaFl7iDeC3ZtgmDiILkMkoZhGTp9gYA7EZqmi03Qq//vHLNuk0aE4UHOiNwC89Y3Q0hSSFZThoaTWKJPnzkLMPWE6GTFC+pr6DAosZVL8bv+rYL64n55lueqHS1wW4F8EVhkT4qwRrHwUmCvvABlgRs3ih/k+IuI/EZtNZN+1vEHoa5DDmWZntaKmgQ==
X-Gm-Message-State: AOJu0YyeQNdaQ0Xpr289TjzRtyS2/YY2w8U/0Yd3gIkQrp6R43rQhSB6
	ie12U4/USOQIrekb0I2Gw7g7yfBpoVM2PbMkO+2SY3y9Ow9V/+7N
X-Google-Smtp-Source: AGHT+IGikKERanb0wYATNNbc62kMceyfTd7c58Xz5xhwWDj5hZXipidI0sR4ijXGdrOINhhyafcnWA==
X-Received: by 2002:a17:902:ccce:b0:1f7:126:5bab with SMTP id d9443c01a7336-1fa23ed509dmr161068885ad.40.1719524672844;
        Thu, 27 Jun 2024 14:44:32 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568f43sm2316195ad.187.2024.06.27.14.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 14:44:32 -0700 (PDT)
Message-ID: <fe224893-2f54-41d3-ae2a-e449fc147473@gmail.com>
Date: Fri, 28 Jun 2024 06:44:27 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests/ftrace kprobe_eventname test fails on s390x QEMU
 (KVM/Linux)
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>
Cc: Akanksha J N <akanksha@linux.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 MichelleJin <shjy180909@gmail.com>, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <1add7a0a-f91d-4249-9632-424505597e45@gmail.com>
 <yt9dsewy746p.fsf@linux.ibm.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <yt9dsewy746p.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

On 6/28/24 1:15 오전, Sven Schnelle wrote:
> Yunseong Kim <yskelg@gmail.com> writes:
> 
>> In my s390x archtecture, kprobe_eventname selftest have always failed
>> because of rcu_sched stalls.
>>
>> My environment is QEMU Ubuntu 24.04 KVM Machine Linux version
>> 6.8.0-36-generic (buildd@bos01-s390x-012) (s390x-linux-gnu-gcc-13
>> (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #36
>>
>> 1 configured CPUs, Linux is running under KVM in 64-bit mode
>>
>>
>>  qemu-system-s390x -no-reboot -name auto-inst-test -nographic -m 4096 \
>>    -drive file=disk-image.qcow2,format=qcow2,cache=none,if=virtio \
>>    -netdev user,id=enc0,hostfwd=tcp::10000-:22 \
>>    -device virtio-net-ccw,netdev=enc0 \
>>    -qmp tcp:localhost:4444,server,nowait
>>
>>
>> Currently, This failure can be always reproduced by this kselftests script:
>>
>>  # tools/testing/selftests/ftrace/ftracetest
>> tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc

> Could you see if you have the same issue on the most recent kernel?
>
> -- Steve


Thanks you Steve,


As soon as I saw your mail, I pulled the latest kernel.


Linux version 6.10.0-rc5+ (paran@fedora) (s390x-linux-gnu-gcc (GCC)
14.1.1 20240507 (Red Hat Cross 14.1.1-1), GNU ld version 2.41-1.fc40)
#30 SMP Fri Jun 28 04:32:20 KST 2024


My Linux is running under QEMU KVM in 64-bit mode, cpu: 1 configured
CPUs, 0 standby CPUs.


[  726.069032] Kernel panic - not syncing: Corrupt kernel stack, can't
continue.
[  726.069297] CPU: 0 PID: 1023 Comm: ftracetest Not tainted 6.10.0-rc5+ #30
[  726.069335] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[  726.069361] Call Trace:
[  726.069383]  [<000003ffe0dc545e>] dump_stack_lvl+0x76/0xa8
[  726.069446]  [<000003ffe0db7170>] panic+0x170/0x358
[  726.069485]  [<000003ffe0000f16>] kernel_stack_overflow+0x56/0x60
[  726.069522]  [<0000000000000200>] 0x200
[  726.069987] Dumping ftrace buffer:
[  726.070144] ---------------------------------
[  726.071356]    <...>-1023      0..... 1829038us : p_kernel_clone_0:
(kernel_clone+0x0/0x390)
[  726.071452]    <...>-1023      0dN... 1829717us : p_kernel_clone_6:
(kernel_clone+0x6/0x390)
[  726.071506]    <...>-1023      0dN... 1830009us : p_kernel_clone_12:
(kernel_clone+0xc/0x390)
[  726.071558]    <...>-1023      0dN... 1830064us : p_kernel_clone_16:
...


I have changed the QEMU setting a bit to run latest kernel.


qemu-system-s390x -no-reboot -name auto-inst-test -nographic -m 4096 \
  -kernel bzImage-6.10.0-rc5-00035-gafcd48134c58 \
  -initrd 6.8.0-36-generic/initrd.img-6.8.0-36-generic  \
  -append
"root=/dev/disk/by-id/dm-uuid-LVM-7JeH1Hjp3H1U60GH8m82Od6YXP47ItB01EcvyJ33Ya80VPeRinI1vfMjI9Ndzcc3
crashkernel=512M-:1024M oops=panic panic_on_warn=1
ftrace_dump_on_oops=orig_cpu slub_debug=UZ nokaslr gcov_persist=0 " \
  -drive file=disk-image.qcow2,format=qcow2,cache=none,if=virtio \
  -netdev user,id=enc0,hostfwd=tcp::10000-:22 \
  -device virtio-net-ccw,netdev=enc0 \
  -qmp tcp:localhost:4444,server,nowait


> Hi,
>
> Thanks for reporting!


Hi, Masami, It's my pleasure.


>>  # tools/testing/selftests/ftrace/ftracetest
>> tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
>>
>> I've investigating cause of line, then I find this line.
>>
>>  for i in `seq 0 255`; do
>>    echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
>>  done
>>
>>  cat kprobe_events >> $testlog
>>
>>  echo 1 > events/kprobes/enable # <<<
>
> Isn't it kprobe_insn_boundary.tc?


That's exactly right!
I'm sorry, I slipped up again. :(


This is my exactly tested command.


 $ cd tools/testing/selftests/ftrace/
 $ sudo ./ftracetest --console test.d/kprobe/kprobe_insn_boundary.tc


> Also, can you modify it as
>
> for i in `seq 0 255`; do
>   echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
>   echo 1 > events/kprobes/enable
> done
>
> And run it with --console option? It may tell us when the stall happens
> with what offset.
>
> Also, please try it with the latest kernel instead of 6.8.x
>
> Thank you,
>


I took what you said and applied it in test script.


--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
@@ -6,11 +6,11 @@

 for i in `seq 0 255`; do
   echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
+  echo 1 > events/kprobes/enable
 done

 cat kprobe_events >> $testlog

-echo 1 > events/kprobes/enable
 ( echo "forked" )
 echo 0 > events/kprobes/enable
 echo > kprobe_events


This is the results from console.


=== Ftrace unit tests ===
[1] Register multiple kprobe events in a function+ checkreq
/home/paran/linux-source/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
+ + grep ^#[ \t]*requires:
/home/paran/linux-source-6.8.0/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
cut -f2- -d:
+ requires= kprobe_events
+ eval check_requires  kprobe_events
+ check_requires kprobe_events
+ p=kprobe_events
+ r=kprobe_events
+ t=kprobe_events
+ [ kprobe_events != kprobe_events ]
+ [ kprobe_events != kprobe_events ]
+ [ kprobe_events != kprobe_events ]
+ [ ! -e kprobe_events ]
+ initialize_ftrace
+ disable_tracing
+ echo 0
+ reset_tracer
+ echo nop
+ reset_trigger
+ [ -d events/synthetic ]
+ reset_trigger_file events/alarmtimer/alarmtimer_cancel/trigger
events/alarmtimer/alarmtimer_fired/trigger events/alarmtimer+

....

clear_trace
+ echo
+ enable_tracing
+ echo 1
+ .
/home/paran/linux-source/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
+ seq 0 255
+ echo p kernel_clone+0
+ echo 1
+ echo p kernel_clone+1
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+2
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+3
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+4
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+5
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+6
+ echo 1
+ echo p kernel_clone+7
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+8
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+9
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+10
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+11
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+12
+ echo 1
+ echo p kernel_clone+13
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+14
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+15
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+16
+ echo 1
+ echo p kernel_clone+17
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+18
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+19
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+20
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+21
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+22
+ echo 1
+ echo p kernel_clone+23
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+24
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+25
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+26
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+27
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+28
+ echo 1
+ echo p kernel_clone+29
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+30
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+31
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+32
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+33
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+34
+ echo 1
+ echo p kernel_clone+35
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+36
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+37
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+38
+ echo 1
+ echo p kernel_clone+39
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+40
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+41
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+42
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+43
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+44
+ echo 1
+ echo p kernel_clone+45
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+46
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+47
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+48
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+49
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+50
+ echo 1
+ echo p kernel_clone+51
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+52
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+53
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+54
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+55
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+56
+ echo 1
+ echo p kernel_clone+57
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+58
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+59
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+60
+ echo 1
+ echo p kernel_clone+61
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+62
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+63
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+64
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+65
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+66
+ echo 1
+ echo p kernel_clone+67
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+68
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+69
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+70
+ echo 1
+ echo p kernel_clone+71
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+72
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+73
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+74
+ echo 1
+ echo p kernel_clone+75
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+76
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+77
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+78
+ echo 1
+ echo p kernel_clone+79
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+80
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+81
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+82
+ echo 1
+ echo p kernel_clone+83
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+84
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+85
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+86
+ echo 1
+ echo p kernel_clone+87
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+88
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+89
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+90
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+91
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+92
+ echo 1
+ echo p kernel_clone+93
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+94
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+95
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+96
+ echo 1
+ echo p kernel_clone+97
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+98
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+99
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+100
+ echo 1
+ echo p kernel_clone+101
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+102
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+103
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+104
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+105
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+106
+ echo 1
+ echo p kernel_clone+107
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+108
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+109
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+110
+ echo 1
+ echo p kernel_clone+111
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+112
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+113
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+114
+ echo 1
+ echo p kernel_clone+115
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+116
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+117
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+118
+ echo 1
+ echo p kernel_clone+119
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+120
+ echo 1
+ echo p kernel_clone+121
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+122
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+123
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+124
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+125
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+126
+ echo 1
+ echo p kernel_clone+127
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+128
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+129
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+130
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+131
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+132
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+133
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+134
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+135
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+136
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+137
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+138
+ echo 1
+ echo p kernel_clone+139
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+140
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+141
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+142
+ echo 1
+ echo p kernel_clone+143
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+144
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+145
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+146
+ echo 1
+ echo p kernel_clone+147
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+148
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+149
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+150
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+151
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+152
+ echo 1
+ echo p kernel_clone+153
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+154
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+155
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+156
+ echo 1
+ echo p kernel_clone+157
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+158
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+159
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+160
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+161
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+162
+ echo 1
+ echo p kernel_clone+163
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+164
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+165
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+166
+ echo 1
+ echo p kernel_clone+167
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+168
+ echo 1
+ echo p kernel_clone+169
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+170
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+171
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+172
+ echo 1
+ echo p kernel_clone+173
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+174
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+175
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+176
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+177
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+178
+ echo 1
+ echo p kernel_clone+179
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+180
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+181
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+182
+ echo 1
+ echo p kernel_clone+183
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+184
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+185
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+186
+ echo 1
+ echo p kernel_clone+187
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+188
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+189
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+190
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+191
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+192
+ echo 1
+ echo p kernel_clone+193
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+194
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+195
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+196
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+197
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+198
+ echo 1
+ echo p kernel_clone+199
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+200
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+201
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+202
+ echo 1
+ echo p kernel_clone+203
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+204
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+205
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+206
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+207
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+208
+ echo 1
+ echo p kernel_clone+209
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+210
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+211
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+212
+ echo 1
+ echo p kernel_clone+213
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+214
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+215
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+216
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+217
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+218
+ echo 1
+ echo p kernel_clone+219
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+220
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+221
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+222
+ echo 1
+ echo p kernel_clone+223
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+224
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+225
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+226
+ echo 1
+ echo p kernel_clone+227
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+228
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+229
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+230
+ echo 1
+ echo p kernel_clone+231
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+232
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+233
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+234
+ echo 1
+ echo p kernel_clone+235
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+236
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+237
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+238
+ echo 1
+ echo p kernel_clone+239
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+240
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+241
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+242
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+243
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+244
+ echo 1
+ echo p kernel_clone+245
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+246
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+247
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+248
+ echo 1
+ echo p kernel_clone+249
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+250
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+251
./ftracetest: 8: echo: echo: I/O error
+ continue
+ echo p kernel_clone+252


>> I've investigating cause of line, then I find this line.
>>
>>  for i in `seq 0 255`; do
>>    echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
>>  done
> 
> I think this is fixed with:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.10-rc5&id=c239c83ed5c558be3b5926c7f11639f02c8acd00
> 
> Regards,
> Sven


Hi, Sven, Oh thank you so much for the link.

I have also checked that the patch(c239c83ed5c55) you mentioned has been
applied to the code.


It looks like have another problem.

This is the whole call trace.


[  726.069032] Kernel panic - not syncing: Corrupt kernel stack, can't
continue.
[  726.069297] CPU: 0 PID: 1023 Comm: ftracetest Not tainted 6.10.0-rc5+ #30
[  726.069335] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[  726.069361] Call Trace:
[  726.069383]  [<000003ffe0dc545e>] dump_stack_lvl+0x76/0xa8
[  726.069446]  [<000003ffe0db7170>] panic+0x170/0x358
[  726.069485]  [<000003ffe0000f16>] kernel_stack_overflow+0x56/0x60
[  726.069522]  [<0000000000000200>] 0x200
[  726.069987] Dumping ftrace buffer:
[  726.070144] ---------------------------------
[  726.071356]    <...>-1023      0..... 1829038us : p_kernel_clone_0:
(kernel_clone+0x0/0x390)
[  726.071452]    <...>-1023      0dN... 1829717us : p_kernel_clone_6:
(kernel_clone+0x6/0x390)
[  726.071506]    <...>-1023      0dN... 1830009us : p_kernel_clone_12:
(kernel_clone+0xc/0x390)
[  726.071558]    <...>-1023      0dN... 1830064us : p_kernel_clone_16:
(kernel_clone+0x10/0x390)
[  726.071610]    <...>-1023      0dN... 1830116us : p_kernel_clone_22:
(kernel_clone+0x16/0x390)
[  726.071661]    <...>-1023      0dN... 1830161us : p_kernel_clone_28:
(kernel_clone+0x1c/0x390)
[  726.071711]    <...>-1023      0dN... 1830204us : p_kernel_clone_34:
(kernel_clone+0x22/0x390)
[  726.071762]    <...>-1023      0dN... 1830252us : p_kernel_clone_38:
(kernel_clone+0x26/0x390)
[  726.071815]    <...>-1023      0dN... 1830301us : p_kernel_clone_44:
(kernel_clone+0x2c/0x390)
[  726.071866]    <...>-1023      0dN... 1830355us : p_kernel_clone_50:
(kernel_clone+0x32/0x390)
[  726.071917]    <...>-1023      0dN... 1830399us : p_kernel_clone_56:
(kernel_clone+0x38/0x390)
[  726.071967]    <...>-1023      0dN... 1830441us : p_kernel_clone_60:
(kernel_clone+0x3c/0x390)
[  726.072018]    <...>-1023      0dN... 1830495us : p_kernel_clone_66:
(kernel_clone+0x42/0x390)
[  726.072068]    <...>-1023      0dN... 1830553us : p_kernel_clone_70:
(kernel_clone+0x46/0x390)
[  726.072118]    <...>-1023      0dN... 1830597us : p_kernel_clone_74:
(kernel_clone+0x4a/0x390)
[  726.072168]    <...>-1023      0dN... 1830639us : p_kernel_clone_78:
(kernel_clone+0x4e/0x390)
[  726.072217]    <...>-1023      0dN... 1830681us : p_kernel_clone_82:
(kernel_clone+0x52/0x390)
[  726.072267]    <...>-1023      0dN... 1830722us : p_kernel_clone_86:
(kernel_clone+0x56/0x390)
[  726.072318]    <...>-1023      0dN... 1830765us : p_kernel_clone_92:
(kernel_clone+0x5c/0x390)
[  726.072368]    <...>-1023      0dN... 1830806us : p_kernel_clone_96:
(kernel_clone+0x60/0x390)
[  726.072418]    <...>-1023      0dN... 1830847us : p_kernel_clone_100:
(kernel_clone+0x64/0x390)
[  726.072468]    <...>-1023      0dN... 1830911us : p_kernel_clone_106:
(kernel_clone+0x6a/0x390)
[  726.072518]    <...>-1023      0dN... 1830953us : p_kernel_clone_110:
(kernel_clone+0x6e/0x390)
[  726.072568]    <...>-1023      0dN... 1830994us : p_kernel_clone_114:
(kernel_clone+0x72/0x390)
[  726.072619]    <...>-1023      0dN... 1831035us : p_kernel_clone_118:
(kernel_clone+0x76/0x390)
[  726.072669]    <...>-1023      0dN... 1831092us : p_kernel_clone_120:
(kernel_clone+0x78/0x390)
[  726.072718]    <...>-1023      0dN... 1831133us : p_kernel_clone_126:
(kernel_clone+0x7e/0x390)
[  726.072769]    <...>-1023      0dN... 1831175us : p_kernel_clone_138:
(kernel_clone+0x8a/0x390)
[  726.072819]    <...>-1023      0dN... 1831221us : p_kernel_clone_142:
(kernel_clone+0x8e/0x390)
[  726.072869]    <...>-1023      0dN... 1831262us : p_kernel_clone_146:
(kernel_clone+0x92/0x390)
[  726.072919]    <...>-1023      0dN... 1831303us : p_kernel_clone_152:
(kernel_clone+0x98/0x390)
[  726.072970]    <...>-1023      0dN... 1831344us : p_kernel_clone_156:
(kernel_clone+0x9c/0x390)
[  726.073020]    <...>-1023      0dN... 1831385us : p_kernel_clone_162:
(kernel_clone+0xa2/0x390)
[  726.073070]    <...>-1023      0dN... 1831427us : p_kernel_clone_166:
(kernel_clone+0xa6/0x390)
[  726.073120]    <...>-1023      0dN... 1831469us : p_kernel_clone_168:
(kernel_clone+0xa8/0x390)
[  726.073910]    <...>-1023      0dN... 1831511us : p_kernel_clone_172:
(kernel_clone+0xac/0x390)
[  726.073983]    <...>-1023      0dN... 1831554us : p_kernel_clone_178:
(kernel_clone+0xb2/0x390)
[  726.074047]    <...>-1023      0dN... 1831601us : p_kernel_clone_182:
(kernel_clone+0xb6/0x390)
[  726.074109]    <...>-1023      0dN... 1831642us : p_kernel_clone_186:
(kernel_clone+0xba/0x390)
[  726.074172]    <...>-1023      0dN... 1831683us : p_kernel_clone_192:
(kernel_clone+0xc0/0x390)
[  726.074234]    <...>-1023      0dN... 1831725us : p_kernel_clone_198:
(kernel_clone+0xc6/0x390)
[  726.074296]    <...>-1023      0dN... 1831766us : p_kernel_clone_202:
(kernel_clone+0xca/0x390)
[  726.074358]    <...>-1023      0dN... 1831807us : p_kernel_clone_208:
(kernel_clone+0xd0/0x390)
[  726.074419]    <...>-1023      0dN... 1831848us : p_kernel_clone_212:
(kernel_clone+0xd4/0x390)
[  726.074481]    <...>-1023      0dN... 1831895us : p_kernel_clone_218:
(kernel_clone+0xda/0x390)
[  726.074542]    <...>-1023      0dN... 1831941us : p_kernel_clone_222:
(kernel_clone+0xde/0x390)
[  726.074603]    <...>-1023      0dN... 1831982us : p_kernel_clone_226:
(kernel_clone+0xe2/0x390)
[  726.074665]    <...>-1023      0dN... 1832023us : p_kernel_clone_230:
(kernel_clone+0xe6/0x390)
[  726.074727]    <...>-1023      0dN... 1832064us : p_kernel_clone_234:
(kernel_clone+0xea/0x390)
[  726.074787]    <...>-1023      0dN... 1832105us : p_kernel_clone_238:
(kernel_clone+0xee/0x390)
[  726.074846]    <...>-1023      0dN... 1832146us : p_kernel_clone_244:
(kernel_clone+0xf4/0x390)
[  726.074906]    <...>-1023      0dN... 1832188us : p_kernel_clone_248:
(kernel_clone+0xf8/0x390)
[  726.074965]    <...>-1023      0dN... 1832229us : p_kernel_clone_252:
(kernel_clone+0xfc/0x390)
[  726.075024]    <...>-1023      0dN... 1832286us : p_kernel_clone_74:
(kernel_clone+0x4a/0x390)
[  726.075083]    <...>-1023      0dN... 1832324us : p_kernel_clone_78:
(kernel_clone+0x4e/0x390)
[  726.075142]    <...>-1023      0dN... 1832361us : p_kernel_clone_82:
(kernel_clone+0x52/0x390)
[  726.075200]    <...>-1023      0dN... 1832398us : p_kernel_clone_86:
(kernel_clone+0x56/0x390)
[  726.075259]    <...>-1023      0dN... 1832436us : p_kernel_clone_92:
(kernel_clone+0x5c/0x390)
[  726.075317]    <...>-1023      0dN... 1832472us : p_kernel_clone_96:
(kernel_clone+0x60/0x390)
[  726.075376]    <...>-1023      0dN... 1832510us : p_kernel_clone_100:
(kernel_clone+0x64/0x390)
[  726.075434]    <...>-1023      0dN... 1832547us : p_kernel_clone_106:
(kernel_clone+0x6a/0x390)
[  726.075493]    <...>-1023      0dN... 1832584us : p_kernel_clone_110:
(kernel_clone+0x6e/0x390)
[  726.075552]    <...>-1023      0dN... 1832620us : p_kernel_clone_114:
(kernel_clone+0x72/0x390)
[  726.075611]    <...>-1023      0dN... 1832657us : p_kernel_clone_118:
(kernel_clone+0x76/0x390)
[  726.075669]    <...>-1023      0dN... 1832694us : p_kernel_clone_120:
(kernel_clone+0x78/0x390)
[  726.075734]    <...>-1023      0dN... 1832731us : p_kernel_clone_126:
(kernel_clone+0x7e/0x390)
[  726.075793]    <...>-1023      0dN... 1832768us : p_kernel_clone_138:
(kernel_clone+0x8a/0x390)
[  726.075860]    <...>-1023      0dN... 1832805us : p_kernel_clone_142:
(kernel_clone+0x8e/0x390)
[  726.075922]    <...>-1023      0dN... 1832848us : p_kernel_clone_146:
(kernel_clone+0x92/0x390)
[  726.075980]    <...>-1023      0dN... 1832885us : p_kernel_clone_152:
(kernel_clone+0x98/0x390)
[  726.076046]    <...>-1023      0dN... 1832922us : p_kernel_clone_156:
(kernel_clone+0x9c/0x390)
[  726.076107]    <...>-1023      0dN... 1832959us : p_kernel_clone_162:
(kernel_clone+0xa2/0x390)
[  726.076168]    <...>-1023      0dN... 1832996us : p_kernel_clone_166:
(kernel_clone+0xa6/0x390)
[  726.076229]    <...>-1023      0dN... 1833038us : p_kernel_clone_168:
(kernel_clone+0xa8/0x390)
[  726.076290]    <...>-1023      0dN... 1833078us : p_kernel_clone_172:
(kernel_clone+0xac/0x390)
[  726.076376]    <...>-1023      0dN... 1833117us : p_kernel_clone_178:
(kernel_clone+0xb2/0x390)
[  726.076438]    <...>-1023      0dN... 1833154us : p_kernel_clone_182:
(kernel_clone+0xb6/0x390)
[  726.076505]    <...>-1023      0dN... 1833190us : p_kernel_clone_186:
(kernel_clone+0xba/0x390)
[  726.076565]    <...>-1023      0dN... 1833229us : p_kernel_clone_192:
(kernel_clone+0xc0/0x390)
[  726.076634]    <...>-1023      0dN... 1833266us : p_kernel_clone_198:
(kernel_clone+0xc6/0x390)
[  726.076695]    <...>-1023      0dN... 1833302us : p_kernel_clone_202:
(kernel_clone+0xca/0x390)
[  726.076779]    <...>-1023      0dN... 1833339us : p_kernel_clone_208:
(kernel_clone+0xd0/0x390)
[  726.076842]    <...>-1023      0dN... 1833376us : p_kernel_clone_212:
(kernel_clone+0xd4/0x390)
[  726.076886] ---------------------------------



Thank you Steve, Masami and Sven for the great advice on what I reported.

If there are any additional aspects I should check or any advice,
please let me know and I will look into it.


Warm regards,
Yunseong Kim


