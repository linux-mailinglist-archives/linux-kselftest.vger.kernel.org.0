Return-Path: <linux-kselftest+bounces-12294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0390FB6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 04:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9123E1F2235C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29271CF90;
	Thu, 20 Jun 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UJcVa5wX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331F18EB1
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852109; cv=none; b=JyRi36uWR0o5hmMQwGt9/UMXghUBAaWpj9hI5GNOnMcSxAh3cuuo2il7SQHNzEPN5ni+9O3rXmloEmtDNlg1Om5R5FNTnNov+L0hkXMo8Sx/JVPC6A7uYkCWSSpui5S73j0nr9jkvkUoQQgg3AJKCrh5C+31PHc90DXNOm3o7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852109; c=relaxed/simple;
	bh=4vOFoZhAj53ozxv0sBcR5pi9c3j8ei9+wiE77QQ0qpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/bh8f/6ZfFwz2XwOLKjKbwD3F6svmUjEF1ohgQRF5S/i6iRIFgomU2IwK8GyXegfxF7BAzTNJLiZHKsksbwWMyKnuAKkNH4Nsz8FpDHap43bS7oqx5spGUUhlWSVmy9HNfMR8LGbap7P82Z74zMOQobVsnx9IVDfpeyPu14M/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UJcVa5wX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c70c08d98fso412269a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 19:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718852106; x=1719456906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0YpBScLtAJGTGM2s3CoYyWDmo/kLXPc7O8IoTMAC7I=;
        b=UJcVa5wXAV5HXm3Fct5bFmnTFvIcQNhui4Ntb/K6vXliZ0MiLrPXUlN7GAEakEWlnY
         aW9SYQ5+hJQtEW8W7UzTnoM+RXXRXlZSmm7uWCcDbhn3BxSydHDYG01Rcnma2WUAyLvE
         y4/Itdr0lZhKh3gKbuHVV48+2LUJREmoOz2L7bicuCsSB7cntZ5Rg4EFNUawU5yN1tOI
         +3V/AffOE6qk8i1o0aJDB5m+yOAJxS451h1KoP/iNeQ8+ESibUsJWGfvrteiKP4NJ429
         GOWopzyzzI1tE29IKXZZzrQUK4alBPYXlwLVu7ftkbCm97i5h3B1qgDc0Yix6fAX/OuT
         4+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718852106; x=1719456906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0YpBScLtAJGTGM2s3CoYyWDmo/kLXPc7O8IoTMAC7I=;
        b=lrC20I0HgSuGWi+qsAdklkDXn661rBJ+7/XbUYipO4AM05DW6iB17dW3uemRqbBv7T
         d6AcqzGJ9LYmHKeX3y7OS23Gbo4Svcr/j2Os5fKNj+P8ttUBeU5Zeq3lrVpADPMn5IiH
         YpWuhijxcKLf1WMo1u4y9Wqt7Q3Vtvnnz9i9xJPjq0VPF9y2BHBy2KVhPfUtAp1AemS1
         yRJ+2mK4cEaZ8KlVd430HvPCaR+eehWKU29lCj5erXThJCwgHOpTpaCy8IXVE63inltN
         XLx8ozAezSjDahjBoREVL/JetxiicCzeMupG/jW+d/H7/kn7a4dNzsfOiN+UfP/9C5T1
         8I3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTNoCmy3zF/emfdq8K2jQ/1ITnxMUDmU2eqayRsCcYyKmXrFOMoFcp2y+YzVuo7wExoYhq2lvKXxVYd116pf9Lt3U8UY1SbYqFRva/rWMk
X-Gm-Message-State: AOJu0YyWa0P9BfnKAbxDeebz+SeHXufdggr9xwEW+RjwWCqsGSpghKMn
	3x5y0EG9mrm11Pfa+jM3WNkU67Y1WlMtKf2MKT49OHevxE9j/5Z1toKmM/DeHTI=
X-Google-Smtp-Source: AGHT+IGoHty+m475VS6H7tBXu/rGiyFhft2efoZBmP4zONICNba0bof2A+QASS4REaNRwQE+15tCtw==
X-Received: by 2002:a17:90a:1fc7:b0:2c7:c788:d34d with SMTP id 98e67ed59e1d1-2c7c788d4dcmr3119962a91.38.1718852105931;
        Wed, 19 Jun 2024 19:55:05 -0700 (PDT)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e57ce2e9sm446262a91.33.2024.06.19.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 19:55:05 -0700 (PDT)
Date: Wed, 19 Jun 2024 19:55:01 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: zhouquan@iscas.ac.cn
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, oleg@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	andy.chiu@sifive.com, shuah@kernel.org
Subject: Re: [RFC PATCH 2/2] riscv: selftests: Add a ptrace test to check a0
 of restarted syscall
Message-ID: <ZnOaBeNnNpvrE5ss@ghost>
References: <cover.1718693532.git.zhouquan@iscas.ac.cn>
 <b5fbdd3417e925dbe5db4716e51ce49d21d27f2f.1718693532.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fbdd3417e925dbe5db4716e51ce49d21d27f2f.1718693532.git.zhouquan@iscas.ac.cn>

On Wed, Jun 19, 2024 at 10:01:47AM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> This test creates two processes: a tracer and a tracee. The tracer actively
> sends a SIGUSR1 signal in user mode to interrupt the read syscall being
> executed by the tracee. We will reset a0/orig_a0 and then observe the value
> of a0 held by the restarted read syscall.

I don't quite follow what the goal of this test is. With orig_a0 being
added to the previous patch for ptrace, a more constrained test could
ensure that this value is respected.

> 
> Compared to the test program, a more common scenario is the use of the
> exece syscall, which sends a signal in the kernel path to restart
> the syscall.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  tools/testing/selftests/riscv/abi/.gitignore  |   1 +
>  tools/testing/selftests/riscv/abi/Makefile    |  12 ++
>  .../riscv/abi/ptrace_restart_syscall.c        | 148 ++++++++++++++++++
>  4 files changed, 162 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/abi/Makefile
>  create mode 100644 tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> 
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 7ce03d832b64..98541dc2f164 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>  
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
> +RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn abi
>  else
>  RISCV_SUBTARGETS :=
>  endif
> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> new file mode 100644
> index 000000000000..e1e00ffb9db9
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/.gitignore
> @@ -0,0 +1 @@
> +abi

The gitignore should contain a list of all of the generated binaries
that should be ignored. Can you put ptrace_restart_syscall in here
instead of abi?

> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> new file mode 100644
> index 000000000000..634fa7de74e6
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 ARM Limited
> +# Originally tools/testing/arm64/abi/Makefile
> +
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +TEST_GEN_PROGS := ptrace_restart_syscall
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/ptrace_restart_syscall: ptrace_restart_syscall.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> new file mode 100644
> index 000000000000..3e25548cb95e
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/ptrace.h>
> +#include <sys/stat.h>
> +#include <sys/user.h>
> +#include <sys/wait.h>
> +#include <sys/uio.h>
> +#include <linux/elf.h>
> +#include <linux/unistd.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define ORIG_A0_AFTER_MODIFIED  0x5
> +#define MODIFY_A0               0x01
> +#define MODIFY_ORIG_A0          0x02
> +
> +#define perr_and_exit(fmt, ...) do {			\
> +	char buf[256];					\
> +	snprintf(buf, sizeof(buf), "%s:%d: " fmt ": %m\n",	\
> +			__func__, __LINE__, ##__VA_ARGS__);	\
> +	perror(buf);						\
> +	exit(-1);						\
> +} while (0)
> +
> +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> +{
> +	int status;
> +
> +	if (ptrace(flag, pid, 0, 0))
> +		perr_and_exit("failed to resume the tracee %d", pid);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d", pid);
> +}
> +
> +static void ptrace_restart_syscall(int opt, int *result)
> +{
> +	int status;
> +	int p[2], fd_zero;
> +	pid_t pid;
> +
> +	struct user_regs_struct regs;
> +	struct iovec iov = {
> +		.iov_base = &regs,
> +		.iov_len = sizeof(regs),
> +	};
> +
> +	if (pipe(p))
> +		perr_and_exit("failed to create a pipe");
> +
> +	fd_zero = open("/dev/zero", O_RDONLY);
> +	if (fd_zero < 0)
> +		perr_and_exit("failed to open /dev/zero");
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		char c;
> +
> +		/* Mark oneself being traced */
> +		if (ptrace(PTRACE_TRACEME, 0, 0, 0))
> +			perr_and_exit("failed to request for tracer to trace me");
> +
> +		kill(getpid(), SIGSTOP);
> +
> +		if (read(p[0], &c, 1) != 1)
> +			exit(1);
> +
> +		exit(0);
> +	} else if (pid < 0)
> +		exit(1);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +
> +	/* Resume the tracee until the next syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Deliver a signal to interrupt the syscall */
> +	kill(pid, SIGUSR1);
> +
> +	/* The tracee stops at syscall exit */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Check tracee orig_a0 before syscall restart */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers");
> +	if (regs.orig_a0 != p[0])
> +		perr_and_exit("unexpected a0");
> +
> +	/* Modify a0/orig_a0 for the restarted syscall */
> +	switch (opt) {
> +	case MODIFY_A0:
> +		regs.a0 = fd_zero;
> +		break;
> +	case MODIFY_ORIG_A0:
> +		regs.orig_a0 = fd_zero;
> +		break;
> +	}
> +
> +	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to set tracee registers");
> +
> +	/* Ignore SIGUSR1 signal */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Stop at the entry point of the restarted syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Now, check regs.a0 of the restarted syscall */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers");
> +	*result = regs.a0;
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee");
> +}
> +
> +TEST(ptrace_modify_a0)
> +{
> +	int result;
> +
> +	ptrace_restart_syscall(MODIFY_A0, &result);
> +
> +	/* The tracer's modification of a0 cannot affect the restarted tracee */
> +	EXPECT_NE(ORIG_A0_AFTER_MODIFIED, result);
> +}
> +
> +TEST(ptrace_modify_orig_a0)
> +{
> +	int result;
> +
> +	ptrace_restart_syscall(MODIFY_ORIG_A0, &result);
> +
> +	/* The tracer must modify orig_a0 to actually change the tracee's a0 */
> +	EXPECT_EQ(ORIG_A0_AFTER_MODIFIED, result);

How does the value end up being 5?

- Charlie

> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 

