Return-Path: <linux-kselftest+bounces-22746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A19E1CD4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF37616061C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAD1EC018;
	Tue,  3 Dec 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T3Ayc+wD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1E1EBFFB
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230513; cv=none; b=EdMIykZYeR/IGgA23nIWOGKyCb58IeLLxt5gR3nU/HsxG0jDL/aoT2J6QEVwtk+GuYSEbFdSNGkWUz+CRc1zpyNufVl6jUUokALgsXl1oLDT742iPDK5ggO6PFtU92gnWxZNdsZ+b8iLDX//vP64TRY2HBGZio/gvGVDBtEiCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230513; c=relaxed/simple;
	bh=xJ4R0fDe5PkCqV7jZ4w+az2L3kxVQVOPc8NpcoJPooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROiCDsH3fZo7yyZjpw4H/7DdSvlfh5ZMzVNCFoYy9CUCuNlVYqgID2ymCYovaEoqti27MsZgf2yAgC5BcyF8zWa05weL6eOKRVikuLes7TKr4a8TvwnqiMBiuZIMze0EkeVsNED7l8vAMjnld7fBqNf/zU/sL6+9I1LaEw7CUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=T3Ayc+wD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa5ec8d6f64so77444766b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733230509; x=1733835309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHILDQFXZNWmnBoZHrlTEDnKUcbN4skUfD9kORV0Rxw=;
        b=T3Ayc+wDHS8oXy2w2Ix62gBmm55RUj95/VHf/dcl6SjjWw6dbmafJZnFjyYWZORaIN
         U3GNhwf72Ib6NDbZDrqQ1qTIznBapOXnb44hXS2mCA41MyoBpmyalR97nCLXxxBCH11f
         7ylKB8sEqufYJPBlvte5+Y5culi/LSQ7B/81s1W0wQHX4AjDBh9EDGGuaGbGavu4ju+o
         jBvOXTeAobYBUJLGjefp+Aoy0va7/EZgtchmkMhwoITnRNWgMSDBw3eoaDUOkFAJAUWQ
         QNDtuEEsS3M7zeEAL/kDRW6FfbNmonApp2Ss0BMw0Owyh0FF4EvJY9KlmF97h3jx28yN
         yxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733230509; x=1733835309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHILDQFXZNWmnBoZHrlTEDnKUcbN4skUfD9kORV0Rxw=;
        b=ixOEg8rNmdqINhGMRyaKHhpQ20CK6v9q5XyJA6l3FGWig7EImJ8OoamIqjh4wtxcBn
         9pdrp8aDgnqSEcYaJDcpShkfTlPYTKr9yrbTP9jNVsZfqmYmbp9bT66XN1LALm6YINcj
         X7nhzKBHUsstRwK/eQAVtURC8fqbQKQvd57i+iCdDmxEZRcBFPY8jKsRd2u13yerR8kF
         BdUeC1/x6zLCbH7bJOFwnRchmLkH34Y/ukNdrhHKD4gJ1vMBVbzjexSgZFjQGOqtyyB5
         kATpb3EbRUg3O34EoTIonnojBLqTxmoa4S5RHozcv37/NcaZpKi4BVXzj5o6vL7vRYSJ
         J7qw==
X-Forwarded-Encrypted: i=1; AJvYcCW0/vrHnaXT137KrFHezsALaWDKqbA77Yxj8zOtMR3FDMDNl6Xsip8n++JmqDPugGoe3TAxY0AlMjx2CyfXoS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6YkiZjQFav/DngHoBq8TqcktWLrULamyltHdylh/bSfe4INj
	U83xPzFsKIfex/WC5+KcJrq4t7j3x4HiIfzKjyShkAltpnVt44SG7FjHjs2fo4U=
X-Gm-Gg: ASbGncvFjYu/Wd+tkkjq7+2wVf2Ufy/1fVtMCYnBbw3NeeyQRSB4nnmfNK7B9OlU6L0
	j0rDYu/Zar0mgb8vmg/i/85gZZtCyI3R2nL/XJj2lRA1TOgtPSICRbiFYwSDM+gBZGW//qNzQ3W
	05g1ZPrU2+st0hKsfg1zsKejdXGE6vssF/kWFsGrOqGrnwf+Z3Ptw7Mg2ScY75WgdIDQfwb3gXB
	Q0P9quKO/iyKBYgiBRp8SJDyZxnrZ4irbojX3C6Y1diRThAAP9UEaGezWxSfBAZucI1/sJIjDkW
	vG8RaetIOr/Fc2h53yY/oKg5+F35913ylzg=
X-Google-Smtp-Source: AGHT+IGekZlGXSXB9uvq/WKox/qwoGRSQFTd/XXdhj+W5cxmME+Tkf15rQ0BhZmI5BozveUjcxzWTA==
X-Received: by 2002:a05:6402:234a:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5d10cb5c778mr2754267a12.19.1733230508565;
        Tue, 03 Dec 2024 04:55:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d55fdsm607288366b.55.2024.12.03.04.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:55:08 -0800 (PST)
Date: Tue, 3 Dec 2024 13:55:07 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	"Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
	Charlie Jenkins <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	Han Gao <gaohan@iscas.ac.cn>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Message-ID: <20241203-55c76715e16422ddaf8d7edf@orel>
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
 <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>

On Tue, Dec 03, 2024 at 05:30:05PM +0800, Celeste Liu wrote:
> From: Charlie Jenkins <charlie@rivosinc.com>
> 
> This test checks that orig_a0 allows a syscall argument to be modified,
> and that changing a0 does not change the syscall argument.
> 
> Cc: stable@vger.kernel.org
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Co-developed-by: Celeste Liu <uwu@coelacanthus.name>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>  tools/testing/selftests/riscv/abi/Makefile   |   5 +-
>  tools/testing/selftests/riscv/abi/ptrace.c   | 134 +++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
> --- a/tools/testing/selftests/riscv/abi/.gitignore
> +++ b/tools/testing/selftests/riscv/abi/.gitignore
> @@ -1 +1,2 @@
>  pointer_masking
> +ptrace
> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..3f74d059dfdcbce4d45d8ff618781ccea1419061 100644
> --- a/tools/testing/selftests/riscv/abi/Makefile
> +++ b/tools/testing/selftests/riscv/abi/Makefile
> @@ -2,9 +2,12 @@
>  
>  CFLAGS += -I$(top_srcdir)/tools/include
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
> index 0000000000000000000000000000000000000000..d192764b428d1f1c442f3957c6fedeb01a48d556
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> @@ -0,0 +1,134 @@
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
> +#define ORIG_A0_MODIFY      0x01
> +#define A0_MODIFY           0x02
> +#define A0_OLD              0x03
> +#define A0_NEW              0x04

Shouldn't A0_OLD and A0_NEW set more bits, since 3 and 4 aren't very
unique (we could have those values by accident)? And should we include
setting bits over 31 for 64-bit targets?

> +
> +#define perr_and_exit(fmt, ...)						\
> +	({								\
> +		char buf[256];						\
> +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
> +			__func__, __LINE__, ##__VA_ARGS__);		\
> +		perror(buf);						\
> +		exit(-1);						\
> +	})

Can we use e.g. ksft_exit_fail_perror() instead? I'd prefer we try to
consolidate testing/selftests/riscv/* tests on a common format for
errors and exit codes and we're already using other kselftest stuff.

> +
> +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> +{
> +	int status;
> +
> +	if (ptrace(flag, pid, 0, 0))
> +		perr_and_exit("failed to resume the tracee %d\n", pid);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +}
> +
> +static void ptrace_test(int opt, int *result)
> +{
> +	int status;
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
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		/* Mark oneself being traced */
> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> +
> +		if (val)
> +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> +
> +		kill(getpid(), SIGSTOP);
> +
> +		/* Perform exit syscall that will be intercepted */
> +		exit(A0_OLD);
> +	}
> +
> +	if (pid < 0)
> +		exit(1);

This unexpected error condition deserves a message, so I'd use
ksft_exit_fail_perror() here.

> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +
> +	/* Stop at the entry point of the syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Check tracee regs before the syscall */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (orig_a0 != A0_OLD)
> +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
> +
> +	/* Modify a0/orig_a0 for the syscall */
> +	switch (opt) {
> +	case A0_MODIFY:
> +		regs.a0 = A0_NEW;
> +		break;
> +	case ORIG_A0_MODIFY:
> +		orig_a0 = A0_NEW;
> +		break;
> +	}
> +
> +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to set tracee registers\n");
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee\n");
> +
> +	*result = WEXITSTATUS(status);
> +}
> +
> +TEST(ptrace_modify_a0)
> +{
> +	int result;
> +
> +	ptrace_test(A0_MODIFY, &result);
> +
> +	/* The modification of a0 cannot affect the first argument of the syscall */
> +	EXPECT_EQ(A0_OLD, result);

What about checking that we actually set regs.a0 to A0_NEW? We'd need
A0_NEW to be more unique than 4, though.

> +}
> +
> +TEST(ptrace_modify_orig_a0)
> +{
> +	int result;
> +
> +	ptrace_test(ORIG_A0_MODIFY, &result);
> +
> +	/* Only modify orig_a0 to change the first argument of the syscall */

If we run ptrace_modify_a0 first then we've already set regs.a0 to A0_NEW
and can't check with this test that we don't set it to A0_NEW. We should
probably have two different test values, one for regs.a0 and one for
orig_a0 and ensure on both tests that we aren't writing both.

> +	EXPECT_EQ(A0_NEW, result);
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.47.0
>

Thanks,
drew

