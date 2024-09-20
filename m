Return-Path: <linux-kselftest+bounces-18184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F347597D9AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DBE282E56
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527E117DFE9;
	Fri, 20 Sep 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUWBPZsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC6B663;
	Fri, 20 Sep 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726858478; cv=none; b=rsV9AslFKZXdxrgtt4ekGh5qwKKw4JM42/5R8RSVuZTQ2QTVbDFaB3HAxIxqkfEQdOmWUGjG2zgRccZns1SKIYjwFk/Y8AkBB91Hi3N83dghWt1FmDwPLRUOtQkqvxvJG9gLUrYpw8MQPdUBvwXIyjWVcnc//Zu9affkJjg7JpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726858478; c=relaxed/simple;
	bh=mR84EBGM8Cys4fy25SD6rPpMGks83DIr/PZKyPuk3UQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H5FqOZCT92prwuQ2DdV/JobdeMIR0Zd+VUnaRZGKHbnC+u8FiLqSQSLTbNPmoGCq0RrVKzpxNAG7MFaHadRpBxwJmrBRQ1doknqsO7iwWcBOn3xf+7SYOOhDHxAOIGXnniSvvXk+Ft71IBxYs8NLlPDG5Ww06DHtf8F1vIsd7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUWBPZsq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so2752361a12.1;
        Fri, 20 Sep 2024 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726858474; x=1727463274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYnfodJu1G6xNTNc0rdOj3cHR1Z8yN1C64CNCYSVH68=;
        b=kUWBPZsq+bsHI0Yzzs2m+W+txX+KVrYrzTvHGnUrHlAac0n7tTXhMi6ismPfWMxY4d
         P6esd0c7OP55MqG85KtyEPtNVaf+MH5JtzbQ92m2ysx7u39M1J1XhPe3POpQQbnjIejT
         J+Q2YgYE1qUGYwt7wSokzj71xAulzOHRi+wdVtWFnrEECHdEe6HH3D+jRGfW/A6OYDCw
         T7K9udhKpriRGeXH7d9FNP4h2riRTgXJuvjzPnuaMkjaWwOcQTIU+GgQI1kYtku05skw
         3GoVSSl74uDr7I9bcG7A9QjsETVCXazfsFzDnKmxM83rfX1peTE8hHAryiQXK7KRXkey
         IYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726858474; x=1727463274;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYnfodJu1G6xNTNc0rdOj3cHR1Z8yN1C64CNCYSVH68=;
        b=rQcw9fm00v/hz2wNVwmYtSq9wqt1CEFLoYhbzboKngst+DaDpfofTbXNoTXywOTCTY
         Fo2/FBULR2pw3YRBJA+gGqJ4FZx7MKFYF1iwmuqN7qCW5OIcuse11ps0JKFW3PVTGO3W
         7ArEDYcLiItktCcwOfEEAlor4GLhVI0lQghzjY9r6l35yXEkXsohekKiMdoocVkASBx5
         YLIJHu7/Z/VXxxqqjjl+IZZDZOXNP94LciTisLtUokJg/nHIuI1amkDwnSQGgfcdK3kZ
         KjQ+cRojJKswJMiRy15qRNDPcWvBk95g/O8BEpIOXxPxR5P3b8XV6ukZBHU+nxYzK70N
         5SYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6fz/fMYSwMRQb2m2R7QrkQ/sqTJS1qQ8dBpxOX8wheTxQ6dfSHx4o4NasX/HyGqVVUWcYC6e2dbKJ8Uc=@vger.kernel.org, AJvYcCWOWUqERyAJkqLSrkVK5eF5LnUuIWdVmBl89cCXYZ4aOUYVk/edC3+Mw+atn6SQtR5nq+MOWSIxwtAlxCpLh1AT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz098g2inHzFhYX5P8ktJcoBfLoYUnHfIC5hY0RnlGrlRQTwj3V
	MaHM2Hn9boSr+tSKxDXkhXoVmGryKUyLuVtniWJERJkXLyXmWVdFMa0c3A==
X-Google-Smtp-Source: AGHT+IECLYIyQ9ArqEoEWejS7/McoKvnrSSOQtGYJ+UPJQXuf9gplRtZd/RAXpD8Wi4OPKD1dHBMVg==
X-Received: by 2002:a17:906:cae1:b0:a8d:2a46:6068 with SMTP id a640c23a62f3a-a90d5775f44mr273464566b.39.1726858474151;
        Fri, 20 Sep 2024 11:54:34 -0700 (PDT)
Received: from [192.168.178.20] (dh207-42-44.xnet.hr. [88.207.42.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f442dsm879041066b.59.2024.09.20.11.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 11:54:33 -0700 (PDT)
Message-ID: <917bd4b6-7536-4f68-90fb-99f37e3616ce@gmail.com>
Date: Fri, 20 Sep 2024 20:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests/nci: ./nci_dev hang in wait4()
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: netdev@vger.kernel.org
Cc: Bongsu Jeon <bongsu.jeon@samsung.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <4f2dfd0c-9e57-46d0-86c9-c73955f90d1b@gmail.com>
Content-Language: en-US
In-Reply-To: <4f2dfd0c-9e57-46d0-86c9-c73955f90d1b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/24 18:22, Mirsad Todorovac wrote:
> Hi, all,
> 
> I was testing Linux torvalds tree vanilla kernel, and I've noticed for a number of releases this
> ./nci_dev stops testing until it's terminated (15).
> 
> Now, I tried to examine what went wrong, I hoped it will go away by itself. it didn't, so I am posting
> a bug report.
> 
> The ./nci_dev seems to be stuck in several processes waiting on each other. I was able to produce
> stacktraces. I am unable to tell if it is testsuite bug or a problem in underlying syscalls.
> 
> user@host:~/linux/kernel/linux_torvalds$ sudo gdb --pid 14132
> GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
> 
> For help, type "help".
> Type "apropos word" to search for commands related to "word".
> Attaching to process 14132
> Reading symbols from /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/nci/nci_dev...
> Reading symbols from /lib/x86_64-linux-gnu/libc.so.6...
> Reading symbols from /usr/lib/debug/.build-id/6d/64b17fbac799e68da7ebd9985ddf9b5cb375e6.debug...
> Reading symbols from /lib64/ld-linux-x86-64.so.2...
> Reading symbols from /usr/lib/debug/.build-id/35/3e1b6cb0eebc08cf3ff812eae8a51b4efd684e.debug...
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> 0x00007be7cf3107a7 in __GI___wait4 (pid=pid@entry=14133, stat_loc=stat_loc@entry=0x7ffef60482dc, options=options@entry=0, usage=usage@entry=0x0) at ../sysdeps/unix/sysv/linux/wait4.c:30
> 
> warning: 30	../sysdeps/unix/sysv/linux/wait4.c: No such file or directory
> (gdb) where
> #0  0x00007be7cf3107a7 in __GI___wait4 (pid=pid@entry=14133, stat_loc=stat_loc@entry=0x7ffef60482dc, options=options@entry=0, usage=usage@entry=0x0) at ../sysdeps/unix/sysv/linux/wait4.c:30
> #1  0x00007be7cf3108eb in __GI___waitpid (pid=pid@entry=14133, stat_loc=stat_loc@entry=0x7ffef60482dc, options=options@entry=0) at ./posix/waitpid.c:38
> #2  0x00005d550d59299b in wrapper_NCI_start_poll (_metadata=0x7be7cf486000, variant=0x5d550d597020 <_NCI_NCI2_0_object>) at nci_dev.c:625
> #3  0x00005d550d591a94 in __run_test (f=f@entry=0x5d550d5970a0 <_NCI_fixture_object>, variant=variant@entry=0x5d550d597020 <_NCI_NCI2_0_object>, t=t@entry=0x7be7cf486000) at ../kselftest_harness.h:1249
> #4  0x00005d550d58fd47 in test_harness_run (argv=0x7ffef60488f8, argc=1) at ../kselftest_harness.h:1319
> #5  main (argc=1, argv=0x7ffef60488f8) at nci_dev.c:904
> (gdb) 
> 
> user@host:~$ sudo gdb --pid 14133
> GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
> 
> For help, type "help".
> Type "apropos word" to search for commands related to "word".
> Attaching to process 14133
> [New LWP 14137]
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> 0x00007be7cf298d61 in __futex_abstimed_wait_common64 (private=128, cancel=true, abstime=0x0, op=265, expected=14137, futex_word=0x7be7cf000990) at ./nptl/futex-internal.c:57
> 
> warning: 57	./nptl/futex-internal.c: No such file or directory
> (gdb) where
> #0  0x00007be7cf298d61 in __futex_abstimed_wait_common64 (private=128, cancel=true, abstime=0x0, op=265, expected=14137, futex_word=0x7be7cf000990) at ./nptl/futex-internal.c:57
> #1  __futex_abstimed_wait_common (cancel=true, private=128, abstime=0x0, clockid=0, expected=14137, futex_word=0x7be7cf000990) at ./nptl/futex-internal.c:87
> #2  __GI___futex_abstimed_wait_cancelable64 (futex_word=futex_word@entry=0x7be7cf000990, expected=14137, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=128)
>     at ./nptl/futex-internal.c:139
> #3  0x00007be7cf29e793 in __pthread_clockjoin_ex (threadid=136235540547264, thread_return=thread_return@entry=0x7ffef6047dd0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, 
>     block=block@entry=true) at ./nptl/pthread_join_common.c:102
> #4  0x00007be7cf29e633 in ___pthread_join (threadid=<optimized out>, thread_return=thread_return@entry=0x7ffef6047dd0) at ./nptl/pthread_join.c:24
> #5  0x00005d550d591e48 in NCI_setup (_metadata=_metadata@entry=0x7be7cf486000, self=self@entry=0x7ffef60482e0, variant=<optimized out>) at nci_dev.c:447
> #6  0x00005d550d5929f3 in wrapper_NCI_start_poll (_metadata=0x7be7cf486000, variant=0x5d550d597020 <_NCI_NCI2_0_object>) at nci_dev.c:625
> #7  0x00005d550d591a94 in __run_test (f=f@entry=0x5d550d5970a0 <_NCI_fixture_object>, variant=variant@entry=0x5d550d597020 <_NCI_NCI2_0_object>, t=t@entry=0x7be7cf486000)
>     at ../kselftest_harness.h:1249
> #8  0x00005d550d58fd47 in test_harness_run (argv=0x7ffef60488f8, argc=1) at ../kselftest_harness.h:1319
> #9  main (argc=1, argv=0x7ffef60488f8) at nci_dev.c:904
> (gdb) 
> 
> I hope this can help you see what went wrong. The testing suite gets stuck on each run.
> 
> Best regards,
> Mirsad Todorovac

P.S.

Forgot to mention, the kernel was 6.11.0 release.

Mea culpa.

Best regards,
Mirsad Todorovac


