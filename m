Return-Path: <linux-kselftest+bounces-12467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A4912E6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874BF2872B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381B16DEC5;
	Fri, 21 Jun 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N9KBJFux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF8169AD5
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001220; cv=none; b=KHNTCYLh+r4piZnhULwYR8lOhcm7UGeT5GQDsqxchCFpGNGNWxS1cWwLJsybyyI76JaCXFGvpSUFipYddHjZVmPpc8SGVonfHbQCR2vqLmTe0Q6MRHEZubIX/bWc8pKRSQpNWVbcLP9YCjG0j3QrFrDWV4js/mu+6vdYxtjLhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001220; c=relaxed/simple;
	bh=wVRdsRmYyClPzTZ7YTDFFNxrA2ib4Edbp6kUI/9aXzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Flcs7Vb9F7YW5zb638akMuv4enW5Tx6KYVVbno/7UQln4sG8gjt2u281yVxr4IFjMnbh17mgxwEQtoW/sqCJHaQFMP6pv9MeKn/fkHo1iikGW75xPzOgEierBnqwm548rbe0NHdaEi42J0L/Mnmpi0XlMRpqdKPxq6YV7P/J3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N9KBJFux; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7041ed475acso2156953b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719001216; x=1719606016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eMScHEDiuETUapNa1ev+6UoeG35GPtgtXtBbwoMnOlE=;
        b=N9KBJFuxKnjNZC4ejuOWvACIsOqZWv3abhiNUEmQ4LsNLS7DOfo7oDZ0BsXGA6Jsqg
         L/qZP8jyoZCQ12ODWE+tEKjKDf74BnxIAyOYgR6ZI1BqDQWNjX1FMqchoH4IiespwykF
         hnhnMjtKcnsJOGMqp0IRPIEOSWuWt4HrVYMPxgUZPyzsuOFEoStwe26zh4LlFdq/gkiH
         rjzHREltAzhqijE035dJimok8EHwDh/xpl+dVBzEs6az7JhiEULOp03CjgzduYQh6D9L
         joDqBpBtY6pVOJ4gD4cYp5amxRPXjoL3Znz9uF382TTPw1w4SnHg97kOqmEiJgXYRwre
         H4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719001216; x=1719606016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMScHEDiuETUapNa1ev+6UoeG35GPtgtXtBbwoMnOlE=;
        b=OXbP5Cjo9BMOhpiDgkVlKKkY1zOg/KpF0Z02vtYmma7hj7OfGjseNyw1rn2ZiaBtg3
         shrc03FkY3gwmfvh+VF/+R/GY5lhtkaGNccdn14YQi7KEpQCVtUwjQP8R06ei1I7eX2p
         njA7t15OuZ7AiyGnJekWR33X3jv57D2xfz0dOUpyPOA5pA1xrLySsFU+QuqOWhQ19YGR
         LPtwv28BB8I0hT+8dz9mryDTsNO1r5Ew1uEf5g39N6edKTH1xkeIcw2jj49nyDB1OJmT
         hxN8a5ychVXSeZqoYzgWio9t1vv0GEHZ+DbbehkmWfz+m6Jo7YfsLXq2+BTlIXKN7d1e
         kr/w==
X-Forwarded-Encrypted: i=1; AJvYcCV00iVizzbUVMVhV7PIjVh9wunbC01K6eLMQejczD9anXUWrdQfqZpT0GQRdPo694uQPpbYQOqeCEQQk/vBiIocdiyt/Va0BTu84feATE1K
X-Gm-Message-State: AOJu0Ywr/Cfo3sprz3Uusy31JtUtVXZAwn+Br7a8x0qOHZQYBjsSXqmJ
	muKdD3bzVrTRmYAfojBQ6zwcqtkfDlX1YenkMQ64cNbLfWFDuqCse9QA5ubu6I0=
X-Google-Smtp-Source: AGHT+IFELYMosbM/aIHJsab5wUAdXuVXauVTmyZHCcalea2gidyqnYBx2eN3YzvtFdUJk86VPcPqZg==
X-Received: by 2002:aa7:8b0f:0:b0:705:d9e3:6179 with SMTP id d2e1a72fcca58-7062bf98e16mr7964607b3a.26.1719001216053;
        Fri, 21 Jun 2024 13:20:16 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:e8dd:a296:71d5:2490])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065119f2bfsm1812483b3a.81.2024.06.21.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:20:15 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:20:13 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Quan Zhou <zhouquan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, oleg@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	andy.chiu@sifive.com, shuah@kernel.org
Subject: Re: [RFC PATCH 2/2] riscv: selftests: Add a ptrace test to check a0
 of restarted syscall
Message-ID: <ZnXgfQ/19eCRT33y@ghost>
References: <cover.1718693532.git.zhouquan@iscas.ac.cn>
 <b5fbdd3417e925dbe5db4716e51ce49d21d27f2f.1718693532.git.zhouquan@iscas.ac.cn>
 <ZnOaBeNnNpvrE5ss@ghost>
 <909f2c3d-9992-4515-996b-35a17725701b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <909f2c3d-9992-4515-996b-35a17725701b@iscas.ac.cn>

On Fri, Jun 21, 2024 at 02:29:07PM +0800, Quan Zhou wrote:
> 
> 
> On 2024/6/20 10:55, Charlie Jenkins wrote:
> > On Wed, Jun 19, 2024 at 10:01:47AM +0800, zhouquan@iscas.ac.cn wrote:
> > > From: Quan Zhou <zhouquan@iscas.ac.cn>
> > > 
> > > This test creates two processes: a tracer and a tracee. The tracer actively
> > > sends a SIGUSR1 signal in user mode to interrupt the read syscall being
> > > executed by the tracee. We will reset a0/orig_a0 and then observe the value
> > > of a0 held by the restarted read syscall.
> > 
> > I don't quite follow what the goal of this test is. With orig_a0 being
> > added to the previous patch for ptrace, a more constrained test could
> > ensure that this value is respected.
> > 
> 
> Sry, I may not have described the patch clearly enough. This patch provides
> a channel for modifying a0 in user-space ptrace via orig_a0. Here, I will
> try to outline the whole situation:
> 
> 1、When the tracer calls ptrace to modify regs->a0, can the tracee's a0 be
> correctly modified?
> 
> Through testing, if the user only modifies regs->a0, it doesn't work. Why?
> 
> The execution flow of the tracee in the test program is as follows.Prior to
> this explanation:
> 
> - PTRACE_SYSCALL can make the tracee block before and after executing
>   a syscall.
> - The tracer sends SIGUSR1 to interrupt read, and the kernel will
>   restart it.
> - Please note the point marked with (*), which I believe is the cause
>   of the issue.
> 
> user     kernel
>     |
>     |
>     |
>      read
>         | +-> regs->orig_a0 = regs->a0; //(*1)
>         |                                       <=tracer:PTRACE_SYSCALL
>         | +-> syscall_enter_from_user_mode
>               +-> ptrace_report_syscall_entry
>                   +-> ptrace_stop
>         | //stopped
>         |                                       <= tracer:SIGUSR1
>         |
>         | //resume                              <= tracer:PTRACE_SYSCALL
>         | syscall_handler...
>         |
>         | +-> syscall_exit_to_user_mode
>               +-> syscall_exit_to_user_mode_prepare
>                   +-> ptrace_report_syscall_exit
>                       +-> ptrace_stop
>     | //stopped
>     |
>     | /* Change a0/orig_a0 here and observe the restarted syscall */
>     | regs->{a0/orig_a0} = fd_zero; //(*2)
>     | ptrace(PTRACE_SETREGSET, ...);
>         |                                      <= tracer:PTRACE_SYSCALL
>         | //restarting..., skip SIGUSR1
>         |
>         | +-> exit_to_user_mode_loop
>               +-> arch_do_signal_or_restart
>                   +-> /* Settings for syscall restart */
>                       regs->a0 = regs->orig_a0; //(*3)
>     | //stopped
>     | //and block before the syscall again, get current regs->a0
>     | *result = regs->a0;
>     |
>     | /* Now, Check regs->a0 of restarted syscall */
>     | EXPECT_NE(0x5, result); //for PTRACE_SETREGSSET a0, failed
>     | EXPECT_EQ(0x5, result); //for PTRACE_SETREGSSET orig_a0, succeed
> 
> If I'm wrong, please let me know. 🙂
> 
> 2、Actually, I discovered the issue while using the execve function.
> When I tried to modify the first parameter of execve in the tracer,
> I found it didn't work.
> 
> As for why not use execve for testing, there are two reasons:
> 
> 1) The root cause of this issue is that when a syscall is interrupted
> and then resumed, it restarts with orig_a0 instead of a0, so modifying
> a0 doesn't work. I want to focus the test on the "restarted syscall".
> 
> 2) Compared to the current test scenario, execve is terminated by ptrace
> earlier, so I chose a later point. In fact, setting regs->a0 in the path
> between (*1) and (*3) is ineffective because it will eventually be
> overwritten by orig_a0, correct?

Thank you for the thorough explanation! I feel like a test case like the
following achieves the same goal but without needing the pipes and the
file. What do you think?

From 5f13cdf8f7312b2b3cc98fbfbb3c95fcef62c0f0 Mon Sep 17 00:00:00 2001
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 21 Jun 2024 12:58:29 -0700
Subject: [PATCH] riscv: selftests: Add a ptrace test to check a0 of restarted
 syscall

Add a riscv selftest that checks that a0 of syscalls are able to be
replaced. When entering a syscall, a0 contains the first argument to the
syscall and upon exiting, a0 contains the return value. To replace the
a0 argument instead of the a0 return value with ptrace after halting the
program with PTRACE_SYSCALL, orig_a0 must be used. This test checks that
orig_a0 allows a syscall argument to be modified, and that changing a0
does not change the syscall argument.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 .../riscv/abi/ptrace_restart_syscall.c        | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c

diff --git a/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
new file mode 100644
index 000000000000..e74ae02c6850
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/stat.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <linux/elf.h>
+#include <linux/unistd.h>
+#include <asm/ptrace.h>
+
+#include "../../kselftest_harness.h"
+
+#define DEFAULT_A0		0x6
+
+#define ORIG_A0_AFTER_MODIFIED  0x5
+#define MODIFY_A0               0x01
+#define MODIFY_ORIG_A0          0x02
+
+#define perr_and_exit(fmt, ...) do {			\
+	char buf[256];					\
+	snprintf(buf, sizeof(buf), "%s:%d: " fmt ": %m\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);	\
+	perror(buf);						\
+	exit(-1);						\
+} while (0)
+
+static inline void resume_and_wait_tracee(pid_t pid, int flag)
+{
+	int status;
+
+	if (ptrace(flag, pid, 0, 0))
+		perr_and_exit("failed to resume the tracee %d\n", pid);
+
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee %d\n", pid);
+}
+
+static void ptrace_restart_syscall(int opt, int *result)
+{
+	int status;
+	pid_t pid;
+
+	struct user_regs_struct regs;
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(regs),
+	};
+
+	pid = fork();
+	if (pid == 0) {
+		/* Mark oneself being traced */
+		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
+		if (val)
+			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
+
+		kill(getpid(), SIGSTOP);
+
+		/* Perform exit syscall that will be intercepted */
+		exit(DEFAULT_A0);
+	} else if (pid < 0) {
+		exit(1);
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee %d\n", pid);
+
+	/* Stop at the entry point of the restarted syscall */
+	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
+
+	/* Now, check regs.a0 of the restarted syscall */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to get tracee registers\n");
+
+	/* Modify a0/orig_a0 for the restarted syscall */
+	switch (opt) {
+	case MODIFY_A0:
+		regs.a0 = ORIG_A0_AFTER_MODIFIED;
+		break;
+	case MODIFY_ORIG_A0:
+		regs.orig_a0 = ORIG_A0_AFTER_MODIFIED;
+		break;
+	}
+
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to set tracee registers\n");
+
+	/* Resume the tracee */
+	ptrace(PTRACE_CONT, pid, 0, 0);
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee\n");
+
+	*result = WEXITSTATUS(status);
+}
+
+TEST(ptrace_modify_a0)
+{
+	int result;
+
+	ptrace_restart_syscall(MODIFY_A0, &result);
+
+	/* The tracer's modification of a0 cannot affect the restarted tracee */
+	EXPECT_EQ(DEFAULT_A0, result);
+}
+
+TEST(ptrace_modify_orig_a0)
+{
+	int result;
+
+	ptrace_restart_syscall(MODIFY_ORIG_A0, &result);
+
+	/* The tracer must modify orig_a0 to actually change the tracee's a0 */
+	EXPECT_EQ(ORIG_A0_AFTER_MODIFIED, result);
+}
+
+TEST_HARNESS_MAIN
-- 
2.44.0

> 
> The current test may not intuitively reflect the issue. If possible, I will
> provide a more comprehensive test based on everyone's suggestions.
> 
> Thanks,
> Quan
> 
> > > 
> > > Compared to the test program, a more common scenario is the use of the
> > > exece syscall, which sends a signal in the kernel path to restart
> > > the syscall.
> > > 
> > > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > > ---
> > >   tools/testing/selftests/riscv/Makefile        |   2 +-
> > >   tools/testing/selftests/riscv/abi/.gitignore  |   1 +
> > >   tools/testing/selftests/riscv/abi/Makefile    |  12 ++
> > >   .../riscv/abi/ptrace_restart_syscall.c        | 148 ++++++++++++++++++
> > >   4 files changed, 162 insertions(+), 1 deletion(-)
> > >   create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
> > >   create mode 100644 tools/testing/selftests/riscv/abi/Makefile
> > >   create mode 100644 tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> > > 
> > > diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> > > index 7ce03d832b64..98541dc2f164 100644
> > > --- a/tools/testing/selftests/riscv/Makefile
> > > +++ b/tools/testing/selftests/riscv/Makefile
> > > @@ -5,7 +5,7 @@
> > >   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> > >   ifneq (,$(filter $(ARCH),riscv))
> > > -RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
> > > +RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn abi
> > >   else
> > >   RISCV_SUBTARGETS :=
> > >   endif
> > > diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> > > new file mode 100644
> > > index 000000000000..e1e00ffb9db9
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/abi/.gitignore
> > > @@ -0,0 +1 @@
> > > +abi
> > 
> > The gitignore should contain a list of all of the generated binaries
> > that should be ignored. Can you put ptrace_restart_syscall in here
> > instead of abi?
> > 
> 
> ...yeah, I will fix it later.
> 
> > > diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> > > new file mode 100644
> > > index 000000000000..634fa7de74e6
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/abi/Makefile
> > > @@ -0,0 +1,12 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2021 ARM Limited
> > > +# Originally tools/testing/arm64/abi/Makefile
> > > +
> > > +CFLAGS += -I$(top_srcdir)/tools/include
> > > +
> > > +TEST_GEN_PROGS := ptrace_restart_syscall
> > > +
> > > +include ../../lib.mk
> > > +
> > > +$(OUTPUT)/ptrace_restart_syscall: ptrace_restart_syscall.c
> > > +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > > diff --git a/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> > > new file mode 100644
> > > index 000000000000..3e25548cb95e
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> > > @@ -0,0 +1,148 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <unistd.h>
> > > +#include <fcntl.h>
> > > +#include <signal.h>
> > > +#include <errno.h>
> > > +#include <sys/types.h>
> > > +#include <sys/ptrace.h>
> > > +#include <sys/stat.h>
> > > +#include <sys/user.h>
> > > +#include <sys/wait.h>
> > > +#include <sys/uio.h>
> > > +#include <linux/elf.h>
> > > +#include <linux/unistd.h>
> > > +#include <asm/ptrace.h>
> > > +
> > > +#include "../../kselftest_harness.h"
> > > +
> > > +#define ORIG_A0_AFTER_MODIFIED  0x5
> > > +#define MODIFY_A0               0x01
> > > +#define MODIFY_ORIG_A0          0x02
> > > +
> > > +#define perr_and_exit(fmt, ...) do {			\
> > > +	char buf[256];					\
> > > +	snprintf(buf, sizeof(buf), "%s:%d: " fmt ": %m\n",	\
> > > +			__func__, __LINE__, ##__VA_ARGS__);	\
> > > +	perror(buf);						\
> > > +	exit(-1);						\
> > > +} while (0)
> > > +
> > > +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> > > +{
> > > +	int status;
> > > +
> > > +	if (ptrace(flag, pid, 0, 0))
> > > +		perr_and_exit("failed to resume the tracee %d", pid);
> > > +
> > > +	if (waitpid(pid, &status, 0) != pid)
> > > +		perr_and_exit("failed to wait for the tracee %d", pid);
> > > +}
> > > +
> > > +static void ptrace_restart_syscall(int opt, int *result)
> > > +{
> > > +	int status;
> > > +	int p[2], fd_zero;
> > > +	pid_t pid;
> > > +
> > > +	struct user_regs_struct regs;
> > > +	struct iovec iov = {
> > > +		.iov_base = &regs,
> > > +		.iov_len = sizeof(regs),
> > > +	};
> > > +
> > > +	if (pipe(p))
> > > +		perr_and_exit("failed to create a pipe");
> > > +
> > > +	fd_zero = open("/dev/zero", O_RDONLY);
> > > +	if (fd_zero < 0)
> > > +		perr_and_exit("failed to open /dev/zero");
> > > +
> > > +	pid = fork();
> > > +	if (pid == 0) {
> > > +		char c;
> > > +
> > > +		/* Mark oneself being traced */
> > > +		if (ptrace(PTRACE_TRACEME, 0, 0, 0))
> > > +			perr_and_exit("failed to request for tracer to trace me");
> > > +
> > > +		kill(getpid(), SIGSTOP);
> > > +
> > > +		if (read(p[0], &c, 1) != 1)
> > > +			exit(1);
> > > +
> > > +		exit(0);
> > > +	} else if (pid < 0)
> > > +		exit(1);
> > > +
> > > +	if (waitpid(pid, &status, 0) != pid)
> > > +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> > > +
> > > +	/* Resume the tracee until the next syscall */
> > > +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> > > +
> > > +	/* Deliver a signal to interrupt the syscall */
> > > +	kill(pid, SIGUSR1);
> > > +
> > > +	/* The tracee stops at syscall exit */
> > > +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> > > +
> > > +	/* Check tracee orig_a0 before syscall restart */
> > > +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> > > +		perr_and_exit("failed to get tracee registers");
> > > +	if (regs.orig_a0 != p[0])
> > > +		perr_and_exit("unexpected a0");
> > > +
> > > +	/* Modify a0/orig_a0 for the restarted syscall */
> > > +	switch (opt) {
> > > +	case MODIFY_A0:
> > > +		regs.a0 = fd_zero;
> > > +		break;
> > > +	case MODIFY_ORIG_A0:
> > > +		regs.orig_a0 = fd_zero;
> > > +		break;
> > > +	}
> > > +
> > > +	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
> > > +		perr_and_exit("failed to set tracee registers");
> > > +
> > > +	/* Ignore SIGUSR1 signal */
> > > +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> > > +
> > > +	/* Stop at the entry point of the restarted syscall */
> > > +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> > > +
> > > +	/* Now, check regs.a0 of the restarted syscall */
> > > +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> > > +		perr_and_exit("failed to get tracee registers");
> > > +	*result = regs.a0;
> > > +
> > > +	/* Resume the tracee */
> > > +	ptrace(PTRACE_CONT, pid, 0, 0);
> > > +	if (waitpid(pid, &status, 0) != pid)
> > > +		perr_and_exit("failed to wait for the tracee");
> > > +}
> > > +
> > > +TEST(ptrace_modify_a0)
> > > +{
> > > +	int result;
> > > +
> > > +	ptrace_restart_syscall(MODIFY_A0, &result);
> > > +
> > > +	/* The tracer's modification of a0 cannot affect the restarted tracee */
> > > +	EXPECT_NE(ORIG_A0_AFTER_MODIFIED, result);
> > > +}
> > > +
> > > +TEST(ptrace_modify_orig_a0)
> > > +{
> > > +	int result;
> > > +
> > > +	ptrace_restart_syscall(MODIFY_ORIG_A0, &result);
> > > +
> > > +	/* The tracer must modify orig_a0 to actually change the tracee's a0 */
> > > +	EXPECT_EQ(ORIG_A0_AFTER_MODIFIED, result);
> > 
> > How does the value end up being 5?
> > 
> > - Charlie
> > 
> 
> The tracer ultimately sets `fd_zero` to the restarted syscall.
> 
> Since 0, 1, and 2 are standard input, output, and error, the file
> descriptors will be allocated in this order: `p[0] -> p[1] -> fd_zero`.
> Thus, fd_zero will be 5.
> 
> > > +}
> > > +
> > > +TEST_HARNESS_MAIN
> > > -- 
> > > 2.34.1
> > > 
> 

