Return-Path: <linux-kselftest+bounces-24555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB19A11D0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D52164FD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE0246A32;
	Wed, 15 Jan 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VaHFLL2F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6EB246A05
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932447; cv=none; b=KEcLu/QxcDmcCVkr1kFSx8kecNZwVR6tO5wlxiqqWracXkXZU32MfI8dm/pqPw+YEDNkRa5nVDY+T45x7gpY4hx/dWF1hipisgHMZD0XxlZ2EMRLOw57JmGYvLef/Vrdij8cO14SZgZZoakbQQxDbK3tAFYYBGAl1MNv9cuR/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932447; c=relaxed/simple;
	bh=+0V4tAesUtdtG8/PRPK/FB5wwaRqNI2aoQs5OY4ilKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT6A80yd+BCd7ObYGZXDwzwMIKZQ7ushmAPn7vRDsqLcm+9LdyeDdgM0N1PMEV/X8+qK+tVq7EUF1KWNluJVrmr07GN4TrR4Q9JXTL+1Ay6dg1SeU1kGuHmPRAREO/IgJAzWRgyB4fSfCERXwILQUQXSA3+FFnld1Cn1KG1jc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VaHFLL2F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so3457262f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736932443; x=1737537243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UkB3uXY/AOyeg5DHcTZ6HX3qGswDR1dziSNDHE7y11I=;
        b=VaHFLL2FXrTLewc85R6bYxnvLsFgMP55gEIJ5R3dEeA177tc10TJFHtTaDVmW8bFwx
         aPDA9IB42Kl+njz1OZsndohkd/eXTkzJ1FasyWrGzO0kpxoGYYFz92ZZ4m3i4u1DlZfP
         wRZPknHxOLyhsiBqUHV5WkTvY7/2U363THwSZLOPTHHbuih1Z8z5WCiT/Pb6dZMHQDrj
         YJ6/Fx7zHL9kNf2rIghqtW465RnQeeUy1FxmJQQ4Xh+isYP4bcu2wL62X2srXr/mB46B
         EfAOeKjEX315KBe1qCjwyfoTsOJH5Ld/ODqh/+XStqHlrXmiU4KkKRoRR8iouJv0HmAU
         pGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932443; x=1737537243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkB3uXY/AOyeg5DHcTZ6HX3qGswDR1dziSNDHE7y11I=;
        b=liGEOj4vgYg1+ys0R3pG4Ftf4yq+OXZx7cEMyvFMzdlSCo7BN6BSQx8ceuc4BB1mU6
         niQpwJPSOZ9qQo8sKmoza+aiwtsJGATfLsBRbFXq/1T+26rpOOkpxYbj59Q8dXuRKkR1
         G+BDzMW38dCMBSlwJi9yycFfPhJwJXhopA57YS6owSwUQqzjIiMuQWZ5BMqvvPeB2QGL
         TKkxrD7CSPLTwNdBYjn5B4BcFRbY4hhSIVH/avkPIqs3O/4jWO90clmoBCw00lIJnSOg
         /FYFrbRe2Bb8CaHEej4an5ajFz69h+WLECMR0hHg/dnWnbKVXUGYkbdGNwDPTfAfh8wO
         fLOA==
X-Forwarded-Encrypted: i=1; AJvYcCWWefZ3h5y1xgdHja4a58AAtHaoXB5yQ7rTkc9DPYRhC/PiAA9WO3ZpKb8OlUdb60qsZ8P0svoAcLLuqepZCIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKxRwUTOgK9ZHO/yaPRG5YD5FkQQHCTFmOuCTZktEFaVM/BuG
	xq6K5/iS3z4/EVQuPGNFu7Qt33cQNLbZrtunFBjQxVf/ydz4E3d5TsdVmVSvzog=
X-Gm-Gg: ASbGnctBNbNehpr+ZVsuC7IIB7e1Fy3c6fdM/QEuolb6SjldmkCG6Y5tQL0YTyGHQ3o
	xL6tOpecl0QvOHKx14OgSp/0n+x0LdxZeowulufRO0Bfb6xzOWEfr2iFSi01y+MzM+dx/N6CKIp
	znz5YHNgvbEhScbFi1KEZeEcFKCvtiIO0/Li7fN+t4wi3591k0eObp6L9T++CEFFNB4sO5bcnnQ
	wXmpFODsmj1sVuohig2W+zQEPOqhJ6PwR6gCWRZe3Vq6L75fr/Ir1wAwjWgcotlsBPN342zXL/q
	FO7w4Hbu64Wv2EsxOmcZsKFgr2FnAktytWyxBNTfLg==
X-Google-Smtp-Source: AGHT+IGmhitdB2mwPEw/mSZXPL9iFDHsGoUy45feW5F9AYgsqTCf/RMUBQMFPFd1JqfQEgOZ/guGog==
X-Received: by 2002:a5d:64e2:0:b0:38b:e32a:10ab with SMTP id ffacd0b85a97d-38be32a13a4mr4176173f8f.9.1736932443464;
        Wed, 15 Jan 2025 01:14:03 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74e3b97sm15973265e9.32.2025.01.15.01.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:14:03 -0800 (PST)
Date: Wed, 15 Jan 2025 10:14:02 +0100
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
Subject: Re: [PATCH v5 2/2] riscv: selftests: Add a ptrace test to verify a0
 and orig_a0 access
Message-ID: <20250115-28c95808502d43f84b3fe0a6@orel>
References: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
 <20250115-riscv-new-regset-v5-2-d0e6ec031a23@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115-riscv-new-regset-v5-2-d0e6ec031a23@coelacanthus.name>

On Wed, Jan 15, 2025 at 04:24:59AM +0800, Celeste Liu wrote:
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
>  tools/testing/selftests/riscv/abi/ptrace.c   | 201 +++++++++++++++++++++++++++
>  3 files changed, 207 insertions(+), 1 deletion(-)
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
> index 0000000000000000000000000000000000000000..f1a0458adccdd040bfaa350e2e8d98b1ef34c0ad
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> @@ -0,0 +1,201 @@
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
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#ifndef sizeof_field
> +#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> +#endif
> +#ifndef offsetofend
> +#define offsetofend(TYPE, MEMBER) \
> +	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
> +#endif

I think this is the sixth test to define these. We should copy
include/linux/stddef.h into tools/include. We already have
tools/include/uapi/linux/stddef.h with __struct_group and
__DECLARE_FLEX_ARRAY, so I think it should just work.

> +
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
> +	/* a0 will keep default value, orig_a0 or -ENOSYS, depends on internal. */
> +	EXPECT_NE(A0_NEW, result[0].a0);

I don't understand this test. Why don't we know what to expect? Also, the
comment says orig_a0 is an option for the value, but then we don't expect
it to be A0_NEW, even though we expect orig_a0 to be A0_NEW?

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

Other than the two comments/questions, this test looks great.

Thanks,
drew

