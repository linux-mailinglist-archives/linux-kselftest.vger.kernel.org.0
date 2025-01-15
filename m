Return-Path: <linux-kselftest+bounces-24571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208DA122B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46643A27BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA271EEA5E;
	Wed, 15 Jan 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kKCo+pn+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC01EBFE8
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941043; cv=none; b=n8RglMZwlCLdbCYLI3ek4TTrBzj4SoHFfhqOpRixetqQbjEEIolm1k8xv0oCTWBiZ1lCRzPb0FOiIgIxNENd958jkblMTEjyF0LXPiWWzR9iqDchXEqjBXa+L/auSsskntQhGYqyI2zMXw1+JjwT8L4Cg7lXUrJuaUqVI4b4mQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941043; c=relaxed/simple;
	bh=DwkxGouHc3BqlYdBKhtJ9qrBMlyUp10OuLpK6o2GlzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzICfp8d1AEfWqlr7whiUDmsuNYHqu8YPQSUVbxdgFOCRzVANvOju46q0ZQio4SROoesCKTQ0TFI0PgznDXLvfcUGU8WVxSSZ8Mle03CZYNOi9U6ovFx+pXeTqQgQ7jktOC3Vx9xWvVasZ0ZZiLRur//k5Irpuga41epEOg/YAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kKCo+pn+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab34a170526so165230966b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736941040; x=1737545840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bR+WWYwGVwj9iq4wp1piIxfs/pyaIAjlJdJ0bpNK8EE=;
        b=kKCo+pn+dKJI0grpQI2sJdAOmn3wFvAbzRi43bXieOkDN5rDgV5AR/3gXLyWo6uwBV
         OkMp6ac30IJu8wFZdqT+oHXIq7W1x8VSTksuMjqPYS6PhhDJlCT+aDQhVOXX7PfdyWSC
         69hCKRrC/Vr7dxAcYFzNZE/ZhpfhMMiaIBe52MFxj1cOkakZx1tzW/G+gvElIkng3Jjh
         px5+8RwfabQLFBe2jNTGBadDwjEar6/iGBX2zJk+VTe0O+Y0Cr0ICWsgiNqFGArGEhjn
         T2gkRDKUlmbm7YdxX9lbCtMW7RR/iHDeSUNUuEN44PK6o4K4tFn9x1bvYNk+z9NY7pm9
         bizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736941040; x=1737545840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR+WWYwGVwj9iq4wp1piIxfs/pyaIAjlJdJ0bpNK8EE=;
        b=G7FTo96Ddt4j2ctbQPIKaM6j72hdqGvYXzfw92WSW71zopmBDt+F7VGx+W7VYqY4Ry
         UMEUxKfUDwDJJQEyuf92UAInxcyVnuOm+TQ8zk/f4Dwh83YMqOPqecawww1t2wL7uHfe
         Iyb2R4zC3EAKrW4oNFCpJPL2c/Gwy2/y8hwEVU4elPIMJsoH3/0yFsaJZdJ1WAjFqtTY
         kqIZo0jX6CLBCJjiLrqQ1kN1HNvgGVr341z8QNkocz7jcsYmrGZxPIRWRlU9BniW2DOh
         t7KU4pV9s5q2Q2P9NlVwYiDmfpZCDP+mhzHUpmjJ7udYKO6G8nQrpolsoiyF+5ciap/q
         OfLg==
X-Forwarded-Encrypted: i=1; AJvYcCX8hj6o52RFANTIQTH1KY06zM6gfJw7PZ+4FKjKd4deRenGl4stzgM2Mg3dpmtEP2GD+rPABQIsUMe1uI1ezqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/RpbKd1iSUn9YCTbGEfRJdzyhrHn4Eh/gD8XBJ1OWMfahquw
	GT/EuFUtPnbfUijNFHed6bebKTWJ79BEpMzC72oQs0n8wta8Lgh7EeR9WVp0QDw=
X-Gm-Gg: ASbGncuEfPloKR856k5y+YSMcq5zQFGCOF6C9gadMeXag6Gjp7/9zJHCRLE/f0czIVA
	C4ly88eZAZ9DKp/K9KQAphk27+ws9dRsAeirWNyIj5gGhLUnAO8zjCs8rACCYVJHPUQ5i8jaDEf
	jYkokGUYBHEhtXum0ONPV8911P1S8NXvY6np3ciPsHATS4ezVqpNg5NVdNo3eaosYpQmBwOjYAu
	edaYv50npsSz8igCOHgOKLCGJNO3AT/DsDGxNDC+vwP9FodB782QnC2M8i290VYIcXOoCiY9Sym
	I5cihEWwYL/cYdJrCi3f3ifqBpbU++ENy/KIej0ZsQ==
X-Google-Smtp-Source: AGHT+IEOkZVi43hTcd5c9zWbi3HxwwGowdbRYih1cWc4DFfPmKBxVNAcGDdIhoBiy/DfEt+4yE+XqA==
X-Received: by 2002:a17:906:f58e:b0:aa5:225f:47d9 with SMTP id a640c23a62f3a-ab2ab749f27mr2166727066b.29.1736941039534;
        Wed, 15 Jan 2025 03:37:19 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95af65dsm746359666b.140.2025.01.15.03.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:37:19 -0800 (PST)
Date: Wed, 15 Jan 2025 12:37:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
	Charlie Jenkins <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>, 
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v6 3/3] riscv: selftests: Add a ptrace test to verify a0
 and orig_a0 access
Message-ID: <20250115-13cc73c36c7bb3b9f046f614@orel>
References: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
 <20250115-riscv-new-regset-v6-3-59bfddd33525@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115-riscv-new-regset-v6-3-59bfddd33525@coelacanthus.name>

On Wed, Jan 15, 2025 at 07:13:29PM +0800, Celeste Liu wrote:
> This test checks that orig_a0 and a0 can be modified and accessed
> independently.
> 
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>  tools/testing/selftests/riscv/abi/Makefile   |   6 +-
>  tools/testing/selftests/riscv/abi/ptrace.c   | 193 +++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
> --- a/tools/testing/selftests/riscv/abi/.gitignore
> +++ b/tools/testing/selftests/riscv/abi/.gitignore
> @@ -1 +1,2 @@
>  pointer_masking
> +ptrace
> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..359a082c88a401883fb3776b35e4dacf69beaaaa 100644
> --- a/tools/testing/selftests/riscv/abi/Makefile
> +++ b/tools/testing/selftests/riscv/abi/Makefile
> @@ -1,10 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS += -I$(top_srcdir)/tools/include
> +CFLAGS += $(KHDR_INCLUDES)
>  
> -TEST_GEN_PROGS := pointer_masking
> +TEST_GEN_PROGS := pointer_masking ptrace
>  
>  include ../../lib.mk
>  
>  $(OUTPUT)/pointer_masking: pointer_masking.c
>  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> +
> +$(OUTPUT)/ptrace: ptrace.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..cbd60462021165ca2bcc38be24b8423c96047b93
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> @@ -0,0 +1,193 @@
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
> +#include <linux/ptrace.h>
> +#include <linux/stddef.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define ORIG_A0_MODIFY      0x01
> +#define A0_MODIFY           0x02
> +#define A0_OLD              0xbadbeefbeeff
> +#define A0_NEW              0xffeebfeebdab
> +
> +
> +struct a0_regs {
> +	__s64 orig_a0;
> +	__u64 a0;
> +};
> +
> +#define perr_and_exit(fmt, ...)						\
> +	({								\
> +		char buf[256];						\
> +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
> +			__func__, __LINE__, ##__VA_ARGS__);		\
> +		ksft_exit_fail_perror(buf);				\
> +	})
> +
> +static void ptrace_test(int opt, struct a0_regs result[])
> +{
> +	int status;
> +	long rc;
> +	pid_t pid;
> +	struct user_regs_struct regs;
> +	struct iovec iov = {
> +		.iov_base = &regs,
> +		.iov_len = sizeof(regs),
> +	};
> +
> +	unsigned long orig_a0;
> +	struct iovec a0_iov = {
> +		.iov_base = &orig_a0,
> +		.iov_len = sizeof(orig_a0),
> +	};
> +	struct ptrace_syscall_info syscall_info = {
> +		.op = 0xff,
> +	};
> +	const unsigned int expected_sci_entry_size =
> +		offsetofend(struct ptrace_syscall_info, entry.args);
> +	const unsigned int expected_sci_exit_size =
> +		offsetofend(struct ptrace_syscall_info, exit.is_error);
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		/* Mark oneself being traced */
> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> +
> +		if (val < 0)
> +			perr_and_exit("failed to request for tracer to trace me: %ld", val);
> +
> +		kill(getpid(), SIGSTOP);
> +
> +		/* Perform chdir syscall that will be intercepted */
> +		syscall(__NR_chdir, A0_OLD);
> +
> +		exit(0);
> +	}
> +
> +	if (pid < 0)
> +		ksft_exit_fail_perror("failed to fork");
> +
> +	for (int i = 0; i < 3; i++) {
> +		if (waitpid(pid, &status, 0) != pid)
> +			perr_and_exit("failed to wait for the tracee %d", pid);
> +		if (WIFSTOPPED(status)) {
> +			switch (WSTOPSIG(status)) {
> +			case SIGSTOP:
> +				if (ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_O_TRACESYSGOOD) < 0)
> +					perr_and_exit("failed to set PTRACE_O_TRACESYSGOOD");
> +				break;
> +			case SIGTRAP|0x80:
> +				/* Modify twice so GET_SYSCALL_INFO get modified a0 and orig_a0 */
> +				if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +					perr_and_exit("failed to get tracee registers");
> +				if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +					perr_and_exit("failed to get tracee registers");
> +
> +				/* Modify a0/orig_a0 for the syscall */
> +				switch (opt) {
> +				case A0_MODIFY:
> +					regs.a0 = A0_NEW;
> +					break;
> +				case ORIG_A0_MODIFY:
> +					orig_a0 = A0_NEW;
> +					break;
> +				}
> +
> +				if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
> +					perr_and_exit("failed to set tracee registers");
> +				if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +					perr_and_exit("failed to set tracee registers");
> +				switch (i) {
> +				case 1:
> +					/* Stop at the beginning of syscall */
> +					rc = ptrace(PTRACE_GET_SYSCALL_INFO, pid,
> +						sizeof(syscall_info), &syscall_info);
> +					if (rc < 0)
> +						perr_and_exit("failed to get syscall info of entry");
> +					if (rc < expected_sci_entry_size
> +						|| syscall_info.op != PTRACE_SYSCALL_INFO_ENTRY)
> +						perr_and_exit("stop position of entry mismatched");
> +					result[0].orig_a0 = syscall_info.entry.args[0];
> +					break;
> +
> +				case 2:
> +					/* Stop at the end of syscall */
> +					rc = ptrace(PTRACE_GET_SYSCALL_INFO, pid,
> +						sizeof(syscall_info), &syscall_info);
> +					if (rc < 0)
> +						perr_and_exit("failed to get syscall info of entry");
> +					if (rc < expected_sci_exit_size
> +						|| syscall_info.op != PTRACE_SYSCALL_INFO_EXIT)
> +						perr_and_exit("stop position of exit mismatched");
> +					result[0].a0 = syscall_info.exit.rval;
> +
> +					if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +						perr_and_exit("failed to get tracee registers");
> +					result[1].a0 = regs.a0;
> +					if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0,
> +						   &a0_iov))
> +						perr_and_exit("failed to get tracee registers");
> +					result[1].orig_a0 = orig_a0;
> +				}
> +			}
> +			if (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
> +				perr_and_exit("failed to resume tracee");
> +		}
> +	}
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee");
> +
> +}
> +
> +TEST(ptrace_access_a0)
> +{
> +	struct a0_regs result[2];
> +
> +	ptrace_test(A0_MODIFY, result);
> +
> +	/* Verify PTRACE_SETREGSET */
> +	/* The modification of a0 cannot affect the first argument of the syscall */
> +	EXPECT_EQ(A0_OLD, result[0].orig_a0);
> +	EXPECT_EQ(A0_NEW, result[0].a0);
> +
> +	/* Verify PTRACE_GETREGSET */
> +	EXPECT_EQ(result[1].orig_a0, result[0].orig_a0);
> +	EXPECT_EQ(result[1].a0, result[0].a0);
> +}
> +
> +TEST(ptrace_access_orig_a0)
> +{
> +	struct a0_regs result[2];
> +
> +	ptrace_test(ORIG_A0_MODIFY, result);
> +
> +	/* Verify PTRACE_SETREGSET */
> +	/* Only modify orig_a0 to change the first argument of the syscall */
> +	EXPECT_EQ(A0_NEW, result[0].orig_a0);
> +	/* a0 will not be affected */
> +	EXPECT_NE(A0_NEW, result[0].a0);
> +
> +	/* Verify PTRACE_GETREGSET */
> +	EXPECT_EQ(result[1].orig_a0, result[0].orig_a0);
> +	EXPECT_EQ(result[1].a0, result[0].a0);
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.48.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

