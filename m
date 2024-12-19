Return-Path: <linux-kselftest+bounces-23621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6C9F8729
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 22:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D78118984AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150E91BEF81;
	Thu, 19 Dec 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sfm9t730"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B917E00E
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644218; cv=none; b=EEbTqIPFYLCYJNtF2AiI96ujWjOMMl4YIzkdTvA4gbvRtm3rNwoIefios/gWpP6ImHZcEKkca71jmd+hojJRqthp5Ax6QdK98x4eEic31K7wuEd127JrIYh2LpYH3mMrrh2XGGq4SEDKVVqJg5uIIO1oboQDKmDtOTNYQvFzyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644218; c=relaxed/simple;
	bh=3S23dTTP7NsKmXAV0bzH89sOImqZmkUX/E13JUSWaW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF4fMtuUqC4jI2Emz0IA2Jl9Dik3F43ExJcjmSsWLVL+lhbv2TpMBexO0hmp6I016uK+jPPpgXC3aFSagrsivf2s0WlWMs/SPITWviqzmw3s8JnVjJVONELW8Ss2z2n325alFty63/57pNTlN7s9CGzBPXeGuE4R6bphwFGAOiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sfm9t730; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee74291415so940470a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 13:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734644215; x=1735249015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBYqbJyIvcJfLc67nzPKYdjSB+90GgtMbY2G3flDnUI=;
        b=sfm9t730EGhHY/HDvwVTSzZ6n+w4e5zbkvbO3U3TktsIyyvsMuC1DpteOC9joE4eye
         UnX8mxwqaI6JtFfHp/dnCfOBJLKfWYxC3+J+0elcFDji9ACm7T/gPL64zkoeqZ8dWEKd
         us4a/6RiS1c9wHvm5fzGE/L6lX7pzDO5lY22OduTQ8iy0VFMP3SB1GmTGQgTAVnOVoY+
         h9XXQriSE3oBbfHwrxctU71DmNQLt+hWD559NBo6gumI1/+w0m1AaS1+Pzq2OToYAoer
         q2b0yFOY+8cgu4isaFK0r8ObbeMvTEeT0my2zmbBfCqqK8HcNnegpqwE/nCQOfedkno+
         3kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734644215; x=1735249015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBYqbJyIvcJfLc67nzPKYdjSB+90GgtMbY2G3flDnUI=;
        b=hd85c8Oon/u9QsV8jrkPXJ7h1pZXC//ThUqkRsOB+1wUqL2Pz15B6ICb1UcKUNV0cZ
         NC/DNGzNyrs19B+SVziMGD4YEBHRl4PmtQatSC/eLMVsoLTiI1D3oEcE/t9BK6KcTkjI
         mNf7YDsit0mqBfQlSNyXHywWjA+a0ujri1YTSL68mjZ2bD/K1HkGJ9khRXpQM5CTFQ5w
         MBZEedB1nZXzbEVoQcJOWe46BzdRsjuqv1AoGdY1lekD++L2got+q1drIXtizOt3pQ+C
         V0G2BI5it/P+ccOc2haUo4i64ONiIYQAJTMx11g9Bkj4QRdsVA6Z3/wsrqVz0pAHx91k
         sq+w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9bMx3/WTeBo8XuA90O7wAe4sEKKSiH1oGtscon6lzFvxa7NY6Dc86IsvW9cMQJlDx9FBz+l31thh3iZvuGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidYdQLtpGVCHp+JxogtXIYSEef63OaUlJEAINZDnqhK05aBOV
	KDygBjJSCy5X2pHc5WEue2X89ixiAZa3PYNHr5JkGOEd68hyRcMUyx0fdSHo0oY=
X-Gm-Gg: ASbGncvsz/nIwSFSY0SD5QnUoOPGkLiq6DDQesO1EhnnpyHnZ60Nlv7dzk8QoTbn5Ni
	bU1CI9/nV6Rkzc9m3qbSeybJNh1Lrk/tLIuH2D/8XimIGRexxaaNhRP0ss2JZ9kk+RUYD4xglG9
	i1IKzAwb/bh6ia3RDI789gTU9XkeIIcpacZxx1MtmfbjewiZbs+VTvicI6Qub3OOh4NBqGhVq2E
	5NlF1ejlUXSZes5FatJ4zNYew5+ztiEwYwB2jMgJs1qBAs=
X-Google-Smtp-Source: AGHT+IG/Dgc/5kYcDlkg099vZ9/LAsV1QDOIoLm+mwtiNyuB7pILZ0WR6EgDxOuwJUotkZK+n+l86A==
X-Received: by 2002:a17:90a:d64d:b0:2ee:b2fe:eeee with SMTP id 98e67ed59e1d1-2f452e3021cmr942885a91.15.1734644214713;
        Thu, 19 Dec 2024 13:36:54 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed644d87sm4166935a91.27.2024.12.19.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 13:36:54 -0800 (PST)
Date: Thu, 19 Dec 2024 13:36:51 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Andrew Jones <ajones@ventanamicro.com>, Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	"Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Quan Zhou <zhouquan@iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Message-ID: <Z2SR86wpB5waLtx-@ghost>
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
 <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>
 <20241203-55c76715e16422ddaf8d7edf@orel>
 <Z2RlR1cP9tne8rNi@ghost>
 <50a62291-5ae1-47b0-8f64-a42271820789@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a62291-5ae1-47b0-8f64-a42271820789@coelacanthus.name>

On Fri, Dec 20, 2024 at 05:29:45AM +0800, Celeste Liu wrote:
> 
> On 2024-12-20 02:26, Charlie Jenkins wrote:
> > On Tue, Dec 03, 2024 at 01:55:07PM +0100, Andrew Jones wrote:
> >> On Tue, Dec 03, 2024 at 05:30:05PM +0800, Celeste Liu wrote:
> >>> From: Charlie Jenkins <charlie@rivosinc.com>
> >>>
> >>> This test checks that orig_a0 allows a syscall argument to be modified,
> >>> and that changing a0 does not change the syscall argument.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> >>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> >>> Co-developed-by: Celeste Liu <uwu@coelacanthus.name>
> >>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> >>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >>> ---
> >>>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
> >>>  tools/testing/selftests/riscv/abi/Makefile   |   5 +-
> >>>  tools/testing/selftests/riscv/abi/ptrace.c   | 134 +++++++++++++++++++++++++++
> >>>  3 files changed, 139 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> >>> index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
> >>> --- a/tools/testing/selftests/riscv/abi/.gitignore
> >>> +++ b/tools/testing/selftests/riscv/abi/.gitignore
> >>> @@ -1 +1,2 @@
> >>>  pointer_masking
> >>> +ptrace
> >>> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> >>> index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..3f74d059dfdcbce4d45d8ff618781ccea1419061 100644
> >>> --- a/tools/testing/selftests/riscv/abi/Makefile
> >>> +++ b/tools/testing/selftests/riscv/abi/Makefile
> >>> @@ -2,9 +2,12 @@
> >>>  
> >>>  CFLAGS += -I$(top_srcdir)/tools/include
> >>>  
> >>> -TEST_GEN_PROGS := pointer_masking
> >>> +TEST_GEN_PROGS := pointer_masking ptrace
> >>>  
> >>>  include ../../lib.mk
> >>>  
> >>>  $(OUTPUT)/pointer_masking: pointer_masking.c
> >>>  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> >>> +
> >>> +$(OUTPUT)/ptrace: ptrace.c
> >>> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> >>> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..d192764b428d1f1c442f3957c6fedeb01a48d556
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> >>> @@ -0,0 +1,134 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +#include <stdio.h>
> >>> +#include <stdlib.h>
> >>> +#include <string.h>
> >>> +#include <unistd.h>
> >>> +#include <fcntl.h>
> >>> +#include <signal.h>
> >>> +#include <errno.h>
> >>> +#include <sys/types.h>
> >>> +#include <sys/ptrace.h>
> >>> +#include <sys/stat.h>
> >>> +#include <sys/user.h>
> >>> +#include <sys/wait.h>
> >>> +#include <sys/uio.h>
> >>> +#include <linux/elf.h>
> >>> +#include <linux/unistd.h>
> >>> +#include <asm/ptrace.h>
> >>> +
> >>> +#include "../../kselftest_harness.h"
> >>> +
> >>> +#define ORIG_A0_MODIFY      0x01
> >>> +#define A0_MODIFY           0x02
> >>> +#define A0_OLD              0x03
> >>> +#define A0_NEW              0x04
> >>
> >> Shouldn't A0_OLD and A0_NEW set more bits, since 3 and 4 aren't very
> >> unique (we could have those values by accident)? And should we include
> >> setting bits over 31 for 64-bit targets?
> >>
> >>> +
> >>> +#define perr_and_exit(fmt, ...)						\
> >>> +	({								\
> >>> +		char buf[256];						\
> >>> +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
> >>> +			__func__, __LINE__, ##__VA_ARGS__);		\
> >>> +		perror(buf);						\
> >>> +		exit(-1);						\
> >>> +	})
> >>
> >> Can we use e.g. ksft_exit_fail_perror() instead? I'd prefer we try to
> >> consolidate testing/selftests/riscv/* tests on a common format for
> >> errors and exit codes and we're already using other kselftest stuff.
> >>
> >>> +
> >>> +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> >>> +{
> >>> +	int status;
> >>> +
> >>> +	if (ptrace(flag, pid, 0, 0))
> >>> +		perr_and_exit("failed to resume the tracee %d\n", pid);
> >>> +
> >>> +	if (waitpid(pid, &status, 0) != pid)
> >>> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> >>> +}
> >>> +
> >>> +static void ptrace_test(int opt, int *result)
> >>> +{
> >>> +	int status;
> >>> +	pid_t pid;
> >>> +	struct user_regs_struct regs;
> >>> +	struct iovec iov = {
> >>> +		.iov_base = &regs,
> >>> +		.iov_len = sizeof(regs),
> >>> +	};
> >>> +
> >>> +	unsigned long orig_a0;
> >>> +	struct iovec a0_iov = {
> >>> +		.iov_base = &orig_a0,
> >>> +		.iov_len = sizeof(orig_a0),
> >>> +	};
> >>> +
> >>> +	pid = fork();
> >>> +	if (pid == 0) {
> >>> +		/* Mark oneself being traced */
> >>> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> >>> +
> >>> +		if (val)
> >>> +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> >>> +
> >>> +		kill(getpid(), SIGSTOP);
> >>> +
> >>> +		/* Perform exit syscall that will be intercepted */
> >>> +		exit(A0_OLD);
> >>> +	}
> >>> +
> >>> +	if (pid < 0)
> >>> +		exit(1);
> >>
> >> This unexpected error condition deserves a message, so I'd use
> >> ksft_exit_fail_perror() here.
> >>
> >>> +
> >>> +	if (waitpid(pid, &status, 0) != pid)
> >>> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> >>> +
> >>> +	/* Stop at the entry point of the syscall */
> >>> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> >>> +
> >>> +	/* Check tracee regs before the syscall */
> >>> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> >>> +		perr_and_exit("failed to get tracee registers\n");
> >>> +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> >>> +		perr_and_exit("failed to get tracee registers\n");
> >>> +	if (orig_a0 != A0_OLD)
> >>> +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
> >>> +
> >>> +	/* Modify a0/orig_a0 for the syscall */
> >>> +	switch (opt) {
> >>> +	case A0_MODIFY:
> >>> +		regs.a0 = A0_NEW;
> >>> +		break;
> >>> +	case ORIG_A0_MODIFY:
> >>> +		orig_a0 = A0_NEW;
> >>> +		break;
> >>> +	}
> >>> +
> >>> +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> >>> +		perr_and_exit("failed to set tracee registers\n");
> >>> +
> >>> +	/* Resume the tracee */
> >>> +	ptrace(PTRACE_CONT, pid, 0, 0);
> >>> +	if (waitpid(pid, &status, 0) != pid)
> >>> +		perr_and_exit("failed to wait for the tracee\n");
> >>> +
> >>> +	*result = WEXITSTATUS(status);
> >>> +}
> >>> +
> >>> +TEST(ptrace_modify_a0)
> >>> +{
> >>> +	int result;
> >>> +
> >>> +	ptrace_test(A0_MODIFY, &result);
> >>> +
> >>> +	/* The modification of a0 cannot affect the first argument of the syscall */
> >>> +	EXPECT_EQ(A0_OLD, result);
> >>
> >> What about checking that we actually set regs.a0 to A0_NEW? We'd need
> >> A0_NEW to be more unique than 4, though.
> >>
> >>> +}
> >>> +
> >>> +TEST(ptrace_modify_orig_a0)
> >>> +{
> >>> +	int result;
> >>> +
> >>> +	ptrace_test(ORIG_A0_MODIFY, &result);
> >>> +
> >>> +	/* Only modify orig_a0 to change the first argument of the syscall */
> >>
> >> If we run ptrace_modify_a0 first then we've already set regs.a0 to A0_NEW
> >> and can't check with this test that we don't set it to A0_NEW. We should
> >> probably have two different test values, one for regs.a0 and one for
> >> orig_a0 and ensure on both tests that we aren't writing both.
> >>
> > 
> > Celeste, do you want to fix this up or are you waiting for me to?
> 
> Sorry for delay. I was busy with household affairs in the past few weeks.
> v3 will be sent tomorrow or the day after tomorrow.
> 
> I am deeply sorry for this.

No need to apologize! Just wanted to make sure you weren't expected me
to update the test :)

- Charlie

> 
> > 
> > - Charlie
> > 
> >>> +	EXPECT_EQ(A0_NEW, result);
> >>> +}
> >>> +
> >>> +TEST_HARNESS_MAIN
> >>>
> >>> -- 
> >>> 2.47.0
> >>>
> >>
> >> Thanks,
> >> drew
> 

