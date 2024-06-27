Return-Path: <linux-kselftest+bounces-12854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D591A94D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A221C21238
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4419753F;
	Thu, 27 Jun 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5F0kAqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD441974FA;
	Thu, 27 Jun 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498885; cv=none; b=TeFrBgt8RWyDqkqTW6n4smRlEJoGFZJnEO/gJAmaRl2MooQh/sEEfUfg69rVI3ai00BeTqdM+clEQtTdZPp8AzCOS2Yv0aLWDBLilQzzcGEZwVY72ejUGOyp5JAkvmJBnusKfoAQBHpzXlMZms0ueOF8A+pwr5C5jH6PAl3uCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498885; c=relaxed/simple;
	bh=+EcQSElV8U7hgTnk8jkGMqLkzjgdHI0a/w4WJecqjsY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NUMAJFugJzZTnE93lzwp3IdLwcZ2EFARry8zIP9Gowkd+5bKQ3gSWsLZ79Ioj/P48EBw8BtmjQXAmFWArT7bPVhakmHehNd45uPIPFG2EEo0EdpqC6rdxy4GI9v9w0C3XN6RMmYLPI358Xg67UHq/Ma2ciIKEPZHfmp9E8Iep6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5F0kAqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B653C32786;
	Thu, 27 Jun 2024 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719498884;
	bh=+EcQSElV8U7hgTnk8jkGMqLkzjgdHI0a/w4WJecqjsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S5F0kAqgyGrlkhKFMuWACktWySeAvPHCFK8gYwdlWgAeueBuATpcfR1EUA+b+ZF98
	 mYUft68aqb6Y6nFi0suTvZJ0NV0q/RdXweRAZzWPEt11vak2rTu1D49rDBPQJlOkDw
	 kowME0cymxAzhx9zCQT/JuH5rHZzspvo5aooOgktcIHVyuWxO0RUOcbdDiujtRRnXa
	 hK48fl0UKLkIOoPicBT1ETIe1Wz7XyK0O+G9Z+Sx407KQBTWgkDjFHje/yssA4akW7
	 /+jRZukkO7cNg8p4Rbz7alAd9zB6CNtR+So5fAstHaSZlpckV6rox1yle9zKFDqd1h
	 sMfyRKLrLGMyw==
Date: Thu, 27 Jun 2024 23:34:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Akanksha J N <akanksha@linux.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, MichelleJin <shjy180909@gmail.com>,
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: selftests/ftrace kprobe_eventname test fails on s390x QEMU
 (KVM/Linux)
Message-Id: <20240627233440.256b3057e0bb299090cf4207@kernel.org>
In-Reply-To: <1add7a0a-f91d-4249-9632-424505597e45@gmail.com>
References: <1add7a0a-f91d-4249-9632-424505597e45@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Thanks for reporting!

On Thu, 27 Jun 2024 14:03:14 +0900
Yunseong Kim <yskelg@gmail.com> wrote:

> Hi all,
> 
> 
> In my s390x archtecture, kprobe_eventname selftest have always failed
> because of rcu_sched stalls.
> 
> My environment is QEMU Ubuntu 24.04 KVM Machine Linux version
> 6.8.0-36-generic (buildd@bos01-s390x-012) (s390x-linux-gnu-gcc-13
> (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #36
> 
> 1 configured CPUs, Linux is running under KVM in 64-bit mode
> 
> 
>  qemu-system-s390x -no-reboot -name auto-inst-test -nographic -m 4096 \
>    -drive file=disk-image.qcow2,format=qcow2,cache=none,if=virtio \
>    -netdev user,id=enc0,hostfwd=tcp::10000-:22 \
>    -device virtio-net-ccw,netdev=enc0 \
>    -qmp tcp:localhost:4444,server,nowait
> 
> 
> Currently, This failure can be always reproduced by this kselftests script:
> 
>  # tools/testing/selftests/ftrace/ftracetest
> tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> 
> I've investigating cause of line, then I find this line.
> 
>  for i in `seq 0 255`; do
>    echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
>  done
> 
>  cat kprobe_events >> $testlog
> 
>  echo 1 > events/kprobes/enable # <<<

Isn't it kprobe_insn_boundary.tc?

Also, can you modify it as

for i in `seq 0 255`; do
  echo p $FUNCTION_FORK+${i} >> kprobe_events || continue
  echo 1 > events/kprobes/enable
done

And run it with --console option? It may tell us when the stall happens
with what offset. 

Also, please try it with the latest kernel instead of 6.8.x

Thank you,

> 
> 
> This line makes "rcu_sched detected stalls" log and stall the system.
> 
>  [ 7825.578940] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> 
> After this line, the test doesn't go any further.
> 
> 
> This test was added in the patch below.
> 
> ("selftests/ftrace: Add new test case which adds multiple consecutive
> probes in a function")
> Link:
> https://lore.kernel.org/linux-trace-kernel/20230428163842.95118-2-akanksha@linux.ibm.com/
> 
> 
> I've attached a link to a compressed version of vmcore, vmlinux and
> config files that I dumped from my environment.
> 
>  https://drive.google.com/file/d/1O2bCKrRbyJ-yP4zTz_sAd_qM80nHnCGr/view?usp=sharing
> 
> 
> I used QEMU QMP to dump the vmcore.
> 
>  $ telnet localhost 4444
> 
>   {"execute": "qmp_capabilities"}
> 
>   {"execute":"dump-guest-memory","arguments":
> {"paging":false,"protocol":"file:/home/paran/vmcore1.img"}}
> 
> 
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:s:
> rcu:
> (detected by 0, t=6002 jiffies, g=24353, q=1 ncpus=1)1)
> rcu: All QSes seen, last rcu_sched kthread activity 6002
> (4294978930-4294972928), jiffies_till_next_fqs=1, root ->qsmask 0x0x0
> rcu: rcu_sched kthread starved for 6002 jiffies! g24353 f0x2
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0=0
> rcu:
> Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected
> behavior.r.
> rcu: RCU grace-period kthread stack dump:p:
> task:rcu_sched       state:R  running task     stack:0     pid:16
> tgid:16    ppid:2      flags:0x0000000000
> Call Trace:e:
>  __schedule+0x346/0x8b8 8
>  schedule+0x36/0x148 8
>  schedule_timeout+0x8e/0x148 8
>  rcu_gp_fqs_loop+0x444/0x548 8
>  rcu_gp_kthread+0x146/0x198 8
>  kthread+0x124/0x128 8
>  __ret_from_fork+0x40/0x58 8
>  ret_from_fork+0xa/0x30 0
> rcu: Stack dump where RCU GP kthread last ran:n:
> CPU: 0 PID: 1077 Comm: ftracetest Not tainted 6.8.0-36-generic #36-Ubuntu
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> Krnl PSW : 0704f00180000000 0000000000121d32 kprobe_exceptions_notify
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/kprobes.c:519
> (discriminator 1))
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3:3
> Krnl GPRS: 0000000000000000 0000000000000000 0000000000008001
> 0000000000000000
>            0000000000000000 0000000000000000 0000000000000000
> 0000000001956720
>            ffffffffffffffff 0000000000121c98 0000000001958d40
> 00000380000cfbd8
>            000003ff938dbc78 00000380000cfab8 0000000000121d1c
> 00000380000cf980
> Krnl Code: 0000000000121d26: 9103b008
> 
> Code starting with the faulting instruction
> ===========================================
> 8(%r11),3
> 0000000000121d2a: a7840004
> 8,0000000000121d32
> #0000000000121d2e: ad03f0a0
> stosm
> 160(%r15),3
> >0000000000121d32: b9140022
> lgfr
> %r2,%r2
> 0000000000121d36: ebbff0a80004
> %r11,%r15,168(%r15)
> 0000000000121d3c: a7190000
> lghi
> %r1,0
> 0000000000121d40: a7390000
> lghi
> %r3,0
> 0000000000121d44: a7490000
> lghi
> %r4,0
> Call Trace:
>  kprobe_exceptions_notify
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/kprobes.c:519
> (discriminator 1))
>  kprobe_exceptions_notify
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/kprobes.c:504
> (discriminator 1))
>  notifier_call_chain (/build/linux-3nCxw2/linux-6.8.0/kernel/notifier.c:93)
>  notify_die (/build/linux-3nCxw2/linux-6.8.0/kernel/notifier.c:597)
>  do_per_trap
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/traps.c:75
> (discriminator 1))
>  __do_pgm_check
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/irqflags.h:47
> (discriminator 1)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/irqflags.h:52
> (discriminator 1)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/traps.c:356
> (discriminator 1))
>  pgm_check_handler
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/entry.S:383)
>  kernel_clone
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/uaccess.h:119
> (discriminator 1) /build/linux-3nCxw2/linux-6.8.0/kernel/fork.c:2927
> (discriminator 1))
>  __do_sys_clone (/build/linux-3nCxw2/linux-6.8.0/kernel/fork.c:3055)
>  __s390x_sys_clone (/build/linux-3nCxw2/linux-6.8.0/kernel/fork.c:3027)
>  __do_syscall
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/ptrace.h:195
> (discriminator 3)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/ptrace.h:200
> (discriminator 3)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/syscall.c:145
> (discriminator 3)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/syscall.c:168
> (discriminator 3))
>  system_call (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/entry.S:309)
> Last Breaking-Event-Address:
> 0xfdf5045050
> ?rcu: INFO: rcu_sched detected stalls on CPUs/tasks:s:
> @rcu:
> (detected by 0, t=24007 jiffies, g=24353, q=1 ncpus=1)
> rcu: All QSes seen, last rcu_sched kthread activity 24007
> (4294996935-4294972928), jiffies_till_next_fqs=1, root ->qsmask 0x0x0
> rcu: rcu_sched kthread starved for 24007 jiffies! g24353 f0x2
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0=0
> rcu:
> Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected
> behavior.r.
> rcu: RCU grace-period kthread stack dump:p:
> task:rcu_sched       state:R  running task     stack:0     pid:16
> tgid:16    ppid:2      flags:0x0000000000
> Call Trace:e:
>  __schedule+0x346/0x8b8 8
>  schedule+0x36/0x148 8
>  schedule_timeout+0x8e/0x148 8
>  rcu_gp_fqs_loop+0x444/0x548 8
>  rcu_gp_kthread+0x146/0x198 8
>  kthread+0x124/0x128 8
>  __ret_from_fork+0x40/0x58 8
>  ret_from_fork+0xa/0x30 0
> rcu: Stack dump where RCU GP kthread last ran:n:
> CPU: 0 PID: 1077 Comm: ftracetest Not tainted 6.8.0-36-generic #36-Ubuntu
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> Krnl PSW : 0704d00180000000 0000000000ebe0b2 __do_pgm_check
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/traps.c:353)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3:3
> Krnl GPRS: 0704c00180000000 0000000000000000 00000380000cfb97
> 0000000000000000
>            0000000000000000 0704c00180000000 0000000000000000
> 0000000000000000
>            0704c00180000000 00000000001a8388 0000000000000000
> 00000380000cfbd8
>            000003ff938dbc78 0000000000ed1c6c 0000000000ebe024
> 00000380000cfaf0
> Krnl Code: 0000000000ebe0a4: a504bfff
> 
> Code starting with the faulting instruction
> ===========================================
> nihh
> %r0,49151
> 0000000000ebe0a8: e300f0a80024
> %r0,168(%r15)
> #0000000000ebe0ae: 8000f0a8
> 168(%r15)
> >0000000000ebe0b2: 5850b0a0
> %r5,160(%r11)
> 0000000000ebe0b6: c05b0000007f
> nilf
> %r5,127
> 0000000000ebe0bc: a7840012
> 8,0000000000ebe0e0
> 0000000000ebe0c0: b91600e5
> llgfr
> %r14,%r5
> 0000000000ebe0c4: c0400051121e
> larl
> %r4,00000000018e0500
> Call Trace:
>  __do_pgm_check
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/traps.c:353)
>  __do_pgm_check
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/traps.c:318)
>  pgm_check_handler
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/entry.S:383)
>  kernel_clone
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/uaccess.h:119
> (discriminator 1) /build/linux-3nCxw2/linux-6.8.0/kernel/fork.c:2927
> (discriminator 1))
>  __do_sys_clone (/build/linux-3nCxw2/linux-6.8.0/kernel/fork.c:3055)
>  __s390x_sys_clone (/build/linux-3nCxw2/linux-6.8.0/kernel/fork.c:3027)
>  __do_syscall
> (/build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/ptrace.h:195
> (discriminator 3)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/include/asm/ptrace.h:200
> (discriminator 3)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/syscall.c:145
> (discriminator 3)
> /build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/syscall.c:168
> (discriminator 3))
>  system_call (/build/linux-3nCxw2/linux-6.8.0/arch/s390/kernel/entry.S:309)
> Last Breaking-Event-Address:
>  0x4404c0018000000000
> 
> 
> It's not easy for me to resolve this issue. If advice or guidance can be
> provided on how to resolve this issue, I'll try sending a patch!
> 
> 
> Warm regards,
> Yunseong Kim
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

