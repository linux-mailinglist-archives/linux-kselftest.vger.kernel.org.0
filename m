Return-Path: <linux-kselftest+bounces-23613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AD19F8337
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 19:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAA5167CE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0B1A2554;
	Thu, 19 Dec 2024 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dO2x4/ZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB931A08C5
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632783; cv=none; b=rLltei7Wgc8maNceFgwWeAXAu4lj2/2ugMrZruD2AnjcQnO1lvjV7FsqZIWGj+RYb5RZtBP3SDNi+9KLYiCPW7xIluXOsDO5r4Bo2PTImelqghoCcsxCZfXc98Bc8iwIPiJl3hh9V0HW1RnBOpBcPRsUL3YQ135+Qm8kjHCP2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632783; c=relaxed/simple;
	bh=/2GFVTGWItCrct80AUQkOv7AggOUOeigNcKeS4Yoytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuXXVjv4Ki5ljm8M5pajIlXSOhagTjtDAhIn3fvUcEyC7NUvLfLl4H3seS+AOK1CkONinzWWC9N0uhhNLbuKrbleT60n8XtwTgBGWa1CmsvXkOpOKOjzBycPLffDj8jvLT+DuaItyu3UOFE13M6XCYIVvh8+HSETLRpcLDGdQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dO2x4/ZC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso743761a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734632779; x=1735237579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMRnvozbssngVqbSknpjzbx2RK+JVnD39zwZDG+y2n8=;
        b=dO2x4/ZCJFI+la1r4/jZdjk0XFVqDmcOJ1x7+fuTT52KH1i92kkbroUXqv/rU68PMj
         ZagsLlGsikFlgnxcPCBbarvl6HxzYFDYNOHswgWPXvwstGO2ZfRVgWyeJ5E1lpdXbIr3
         4rlp5lU64zSMyu1Q1LujpeuQtBT7hC0cS2L7qXybmhkKF673Nd+S017gVaPFh3WxQ9Lo
         fFYIeXTUUpRk1iExxz/k8IQ8bGa7dQE/S2wC98J24KFAYkIwKYD4RKX1kpgFsLU9gQme
         W2Shp0BTVILPc+fwZPoW4FQcVjxnW2B+C7RM4m0eR7STEaN37+Zna9offByYbx9C25BY
         H+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734632779; x=1735237579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMRnvozbssngVqbSknpjzbx2RK+JVnD39zwZDG+y2n8=;
        b=wSoFQ4d6f4h38KNbcX9RpL2y4uS6/2IEY7NkN8QhBz37GeNmNrnzKv5FCaaYz2kY2i
         0cB2/dHNYhFNCLHSd+lEmLLsKJccsQD85EBcd9HL19Hnn/dHCr+K4P2d5fQizkMl4LcK
         iA1KGj8jsHofmwTZZnVBvoTglW6NxxEiKJSKUvwNohi+khqyakIZ6FKNbqzB/gpx9sQG
         s9mWoxBq/Imeunm3R0h+gjXigDUibcCftX/bsVM322DQ4AESv9DkXCVwtRB5rYUzSlpj
         qkSgSyo15rtvbd9Yc4V1NiBcS2+0DOpQ8CwrfbmLChwRuE+N66uSR2gR106UopVTWu5A
         RWqw==
X-Forwarded-Encrypted: i=1; AJvYcCWdlV+z5c/XV3VTuhhSq6qIvXt2aPGXCQxysK3ug554fxlUFUSEn1IMF0yRFmuK2UJSoZoHAlFPqxzIGbhz9G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLX08No6SqeXjdR+ngixz91gCMkbaKmSy6oIzkPBQyHvSEoLmg
	RRw7H/w0+8wD1NZklHfjR0Iyg2nfUKHy//1leJC9ST4atbE3TAxPlB/RZf8/a0g=
X-Gm-Gg: ASbGncuI+nhoEA1vndsVvwF9a+WW4cDGBxoQ6zDDQeiRSHgmV6/evZCthoWFHtM9x3O
	gV8c1rRIqObKIvJdSpAqz+tXkZYwWO23LyYQ0Y/5VVlzmo0b5gXD6ydYzsOW4A3k+hpmrJxkJe4
	hqBeRSyUiT94ZlwOLrFls1zO3YL0/MV2TPOrb36IhgV6w09R6X7NwE/FgpRmWXqJ7Z8nDfM/XSs
	8Kc2tvJXEVpCGJGnSsR5FK095FKkpIe2xWvZa1kMzvtBan6N/y1
X-Google-Smtp-Source: AGHT+IFsWgJOva12zvp6tp180q3OiFLZ0d0TjIkVYwvTLN5q8JRYcM/SHtSfXHGK+OHbcvE+dj549w==
X-Received: by 2002:a17:90b:2c84:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2f452dfcb28mr13994a91.8.1734632779465;
        Thu, 19 Dec 2024 10:26:19 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:1e6a:6188:cfff:248e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447883b0csm1887523a91.42.2024.12.19.10.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 10:26:18 -0800 (PST)
Date: Thu, 19 Dec 2024 10:26:15 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	"Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Message-ID: <Z2RlR1cP9tne8rNi@ghost>
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
 <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>
 <20241203-55c76715e16422ddaf8d7edf@orel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-55c76715e16422ddaf8d7edf@orel>

On Tue, Dec 03, 2024 at 01:55:07PM +0100, Andrew Jones wrote:
> On Tue, Dec 03, 2024 at 05:30:05PM +0800, Celeste Liu wrote:
> > From: Charlie Jenkins <charlie@rivosinc.com>
> > 
> > This test checks that orig_a0 allows a syscall argument to be modified,
> > and that changing a0 does not change the syscall argument.
> > 
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > Co-developed-by: Celeste Liu <uwu@coelacanthus.name>
> > Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/testing/selftests/riscv/abi/.gitignore |   1 +
> >  tools/testing/selftests/riscv/abi/Makefile   |   5 +-
> >  tools/testing/selftests/riscv/abi/ptrace.c   | 134 +++++++++++++++++++++++++++
> >  3 files changed, 139 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> > index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
> > --- a/tools/testing/selftests/riscv/abi/.gitignore
> > +++ b/tools/testing/selftests/riscv/abi/.gitignore
> > @@ -1 +1,2 @@
> >  pointer_masking
> > +ptrace
> > diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> > index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..3f74d059dfdcbce4d45d8ff618781ccea1419061 100644
> > --- a/tools/testing/selftests/riscv/abi/Makefile
> > +++ b/tools/testing/selftests/riscv/abi/Makefile
> > @@ -2,9 +2,12 @@
> >  
> >  CFLAGS += -I$(top_srcdir)/tools/include
> >  
> > -TEST_GEN_PROGS := pointer_masking
> > +TEST_GEN_PROGS := pointer_masking ptrace
> >  
> >  include ../../lib.mk
> >  
> >  $(OUTPUT)/pointer_masking: pointer_masking.c
> >  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > +
> > +$(OUTPUT)/ptrace: ptrace.c
> > +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..d192764b428d1f1c442f3957c6fedeb01a48d556
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <signal.h>
> > +#include <errno.h>
> > +#include <sys/types.h>
> > +#include <sys/ptrace.h>
> > +#include <sys/stat.h>
> > +#include <sys/user.h>
> > +#include <sys/wait.h>
> > +#include <sys/uio.h>
> > +#include <linux/elf.h>
> > +#include <linux/unistd.h>
> > +#include <asm/ptrace.h>
> > +
> > +#include "../../kselftest_harness.h"
> > +
> > +#define ORIG_A0_MODIFY      0x01
> > +#define A0_MODIFY           0x02
> > +#define A0_OLD              0x03
> > +#define A0_NEW              0x04
> 
> Shouldn't A0_OLD and A0_NEW set more bits, since 3 and 4 aren't very
> unique (we could have those values by accident)? And should we include
> setting bits over 31 for 64-bit targets?
> 
> > +
> > +#define perr_and_exit(fmt, ...)						\
> > +	({								\
> > +		char buf[256];						\
> > +		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
> > +			__func__, __LINE__, ##__VA_ARGS__);		\
> > +		perror(buf);						\
> > +		exit(-1);						\
> > +	})
> 
> Can we use e.g. ksft_exit_fail_perror() instead? I'd prefer we try to
> consolidate testing/selftests/riscv/* tests on a common format for
> errors and exit codes and we're already using other kselftest stuff.
> 
> > +
> > +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> > +{
> > +	int status;
> > +
> > +	if (ptrace(flag, pid, 0, 0))
> > +		perr_and_exit("failed to resume the tracee %d\n", pid);
> > +
> > +	if (waitpid(pid, &status, 0) != pid)
> > +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> > +}
> > +
> > +static void ptrace_test(int opt, int *result)
> > +{
> > +	int status;
> > +	pid_t pid;
> > +	struct user_regs_struct regs;
> > +	struct iovec iov = {
> > +		.iov_base = &regs,
> > +		.iov_len = sizeof(regs),
> > +	};
> > +
> > +	unsigned long orig_a0;
> > +	struct iovec a0_iov = {
> > +		.iov_base = &orig_a0,
> > +		.iov_len = sizeof(orig_a0),
> > +	};
> > +
> > +	pid = fork();
> > +	if (pid == 0) {
> > +		/* Mark oneself being traced */
> > +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> > +
> > +		if (val)
> > +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> > +
> > +		kill(getpid(), SIGSTOP);
> > +
> > +		/* Perform exit syscall that will be intercepted */
> > +		exit(A0_OLD);
> > +	}
> > +
> > +	if (pid < 0)
> > +		exit(1);
> 
> This unexpected error condition deserves a message, so I'd use
> ksft_exit_fail_perror() here.
> 
> > +
> > +	if (waitpid(pid, &status, 0) != pid)
> > +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> > +
> > +	/* Stop at the entry point of the syscall */
> > +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> > +
> > +	/* Check tracee regs before the syscall */
> > +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> > +		perr_and_exit("failed to get tracee registers\n");
> > +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> > +		perr_and_exit("failed to get tracee registers\n");
> > +	if (orig_a0 != A0_OLD)
> > +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
> > +
> > +	/* Modify a0/orig_a0 for the syscall */
> > +	switch (opt) {
> > +	case A0_MODIFY:
> > +		regs.a0 = A0_NEW;
> > +		break;
> > +	case ORIG_A0_MODIFY:
> > +		orig_a0 = A0_NEW;
> > +		break;
> > +	}
> > +
> > +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> > +		perr_and_exit("failed to set tracee registers\n");
> > +
> > +	/* Resume the tracee */
> > +	ptrace(PTRACE_CONT, pid, 0, 0);
> > +	if (waitpid(pid, &status, 0) != pid)
> > +		perr_and_exit("failed to wait for the tracee\n");
> > +
> > +	*result = WEXITSTATUS(status);
> > +}
> > +
> > +TEST(ptrace_modify_a0)
> > +{
> > +	int result;
> > +
> > +	ptrace_test(A0_MODIFY, &result);
> > +
> > +	/* The modification of a0 cannot affect the first argument of the syscall */
> > +	EXPECT_EQ(A0_OLD, result);
> 
> What about checking that we actually set regs.a0 to A0_NEW? We'd need
> A0_NEW to be more unique than 4, though.
> 
> > +}
> > +
> > +TEST(ptrace_modify_orig_a0)
> > +{
> > +	int result;
> > +
> > +	ptrace_test(ORIG_A0_MODIFY, &result);
> > +
> > +	/* Only modify orig_a0 to change the first argument of the syscall */
> 
> If we run ptrace_modify_a0 first then we've already set regs.a0 to A0_NEW
> and can't check with this test that we don't set it to A0_NEW. We should
> probably have two different test values, one for regs.a0 and one for
> orig_a0 and ensure on both tests that we aren't writing both.
> 

Celeste, do you want to fix this up or are you waiting for me to?

- Charlie

> > +	EXPECT_EQ(A0_NEW, result);
> > +}
> > +
> > +TEST_HARNESS_MAIN
> > 
> > -- 
> > 2.47.0
> >
> 
> Thanks,
> drew

