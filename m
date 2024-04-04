Return-Path: <linux-kselftest+bounces-7156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD457897D2A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 02:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61C81C27E03
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6334689;
	Thu,  4 Apr 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dpo8It0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B473FF4
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191435; cv=none; b=EbEUmJ8Vfv902X/DLIKB8BlZQhKWG/TpbDitoGGnlOA0lKSWJBqwQdzy2nfBThc8Py2ekHMl9q5EDKMzT5uFF8eVJpo+SHN5ySkpbl4jMdnX5RvlB5dCDSlSDhypt5cxXs78TwVLmagaYNR2pmpgo2rZWChZXrAMSpSNv8m8YtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191435; c=relaxed/simple;
	bh=l7SjNlBscIXDHCJfPdHXfaKN62Yzih8xgtSq0+UhS8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnUDgit+2rcvVVyflbrdq50ve3MlukLNwaFh/NqpMnmiSADKGP3vu5bkcojW9BSjSZ9oUej3CrEdbg4MMaJAN8+yl3J6a3O2NxLAgbk+jMJIAxcfwtTShvb99TWwiG83RpUFwRe/NR9Bfs8l7Ko2spwMUCpcb85rAvFad6woGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dpo8It0M; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so443304a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 17:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712191433; x=1712796233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPAkNpwkOcE2aj5H76UIs4DtdZThjvuKeLHUXLWOipM=;
        b=Dpo8It0MpO/4EKZq/dLqnl8VTu/k+kFqte8YzPZCW+5NoceEpdaptDFvkM8/6Qp43d
         9aypLH9C07xpgQMJtdus0fCSBOWsyIIhHZqIiZqqJ1XIpWOq6/mBSAombSzU7SMjrp+w
         3ZG1rgfLsPJ2zA+DL1jUDkCwmaadAYXXFL4ifkZVdFcvFrK289icC7M4z0pvZvhSBW9w
         PlakplbIsNIe0nOeBfn6Jkz5QZ99sYccO/6nFtSjHC1R4dyNSVAj9ul9ayPNggDfY0z2
         EvhPU+WQSIjICum+rhVFKsJNw0PtJmGWsYEnoFHImkJUXgoiwCZ5bnf1Wvd9/PNqd/X2
         azkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712191433; x=1712796233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPAkNpwkOcE2aj5H76UIs4DtdZThjvuKeLHUXLWOipM=;
        b=ajPJifJIrAUWAZSBP0weA/2/ZdwSqdj7JfF9vlCRtfBSP5L9bpmxo4+IyQ5MIrVyn6
         wXNYvMwI3kRfdZcQsrmGdW/RfQGGRVaefMfWbz2JDYlqMdamX/qiwSuhKJn9hKQmjd6q
         nDsomXZKEdNDyPwjp5B3qgkr0Ok0LNt78KUoBY4KwqwsMGk7/N84fDDBt1PQq9NK/H7K
         JBmbgJ26q+aKCtnpj5JaMUwobE5zMpVgIM2x6IYux37si8be1WQPxXLeQXaoT0hmdTD5
         2oGCEgUc/2DxECT7TyKGckZ97xogGDQgRI5jLVcEYAUSl0qdlAXEk/r3v/zn1s2XeV1D
         dKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn3KrBkWsbmRMbuipe0m+wZlRUH+sm2hNBMlCtmifJAT6BzvT0GAC0wvfJynWKppN2mvxjr2oBUjbKy6/9LpOMpiDBT3rSXhTKqDUjlIp5
X-Gm-Message-State: AOJu0Yx+irc7LEprtAk38S1ZvCkcY1W8m42DSiLub3WUUgEimc5O882Q
	m/sh83YEXbkOWfH1gOVCXtl5ERvVUoNopucJmJ7gbp1wTF3EiRSEx/mXCY0AFaM=
X-Google-Smtp-Source: AGHT+IHnuXNye/1qJaXWs5vSMSc0DTbHIYysP8Hv++UrbD3hU/8w6vGpoI5sVVOGEgQrqnzTMEj70w==
X-Received: by 2002:a17:90a:8d01:b0:2a2:b5db:79cf with SMTP id c1-20020a17090a8d0100b002a2b5db79cfmr1155132pjo.21.1712191433057;
        Wed, 03 Apr 2024 17:43:53 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:b005:9197:83df:91f1])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a0d0f00b002a24886fa5asm358052pja.36.2024.04.03.17.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 17:43:52 -0700 (PDT)
Date: Wed, 3 Apr 2024 17:43:50 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Vineet Gupta <vineetg@rivosinc.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: selftests: Add signal handling vector tests
Message-ID: <Zg33xhwOe6Zwi23A@ghost>
References: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
 <56863fe7-4d82-4f37-a518-2acf368c3ea6@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56863fe7-4d82-4f37-a518-2acf368c3ea6@rivosinc.com>

On Wed, Apr 03, 2024 at 05:27:23PM -0700, Vineet Gupta wrote:
> On 4/3/24 16:50, Charlie Jenkins wrote:
> > Add two tests to check vector save/restore when a signal is received
> > during a vector routine. One test ensures that a value is not clobbered
> > during signal handling. The other verifies that vector registers
> > modified in the signal handler are properly reflected when the signal
> > handling is complete.
> 
> Hmm, isn't this testing two contradictory things ?
> 
> We do want V regs to be not clobbered across a handled signal, o/w V
> enabled code would just not work at all.
> That implies that anything done by signal handler should just be
> discarded - no ?
> 
> Am I missing something.
> 
> -Vineet

This is referring to the user-implemented signal handler. The test in
question is testing the ability of the user-implemented signal handler
to be able to modify the vector registers. In the test:

static void vector_override(int sig_no, siginfo_t *info, void *vcontext)
{ ...

	*(int *)v_ext_state->datap = SIGNAL_HANDLER_OVERRIDE;

	...  }

This line is changing the saved state of the user program's vector
registers.

When the signal handling concludes and the original user program resumes
execution, the content of the user-context registers that were modified
by the signal handler should be restored into the hardware registers.
Hence the test case checks that the v0 register contains the value
SIGNAL_HANDLER_OVERRIDE.

EXPECT_EQ(SIGNAL_HANDLER_OVERRIDE, result);

- Charlie

> 
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > These tests came about to highlight the bug fixed in
> > https://lore.kernel.org/lkml/20240403072638.567446-1-bjorn@kernel.org/
> > and will only pass with that fix applied.
> > ---
> >  tools/testing/selftests/riscv/Makefile             |  2 +-
> >  tools/testing/selftests/riscv/sigreturn/.gitignore |  1 +
> >  tools/testing/selftests/riscv/sigreturn/Makefile   | 12 ++++
> >  .../testing/selftests/riscv/sigreturn/sigreturn.c  | 82 ++++++++++++++++++++++
> >  4 files changed, 96 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> > index 4a9ff515a3a0..7ce03d832b64 100644
> > --- a/tools/testing/selftests/riscv/Makefile
> > +++ b/tools/testing/selftests/riscv/Makefile
> > @@ -5,7 +5,7 @@
> >  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> >  
> >  ifneq (,$(filter $(ARCH),riscv))
> > -RISCV_SUBTARGETS ?= hwprobe vector mm
> > +RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
> >  else
> >  RISCV_SUBTARGETS :=
> >  endif
> > diff --git a/tools/testing/selftests/riscv/sigreturn/.gitignore b/tools/testing/selftests/riscv/sigreturn/.gitignore
> > new file mode 100644
> > index 000000000000..35002b8ae780
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/sigreturn/.gitignore
> > @@ -0,0 +1 @@
> > +sigreturn
> > diff --git a/tools/testing/selftests/riscv/sigreturn/Makefile b/tools/testing/selftests/riscv/sigreturn/Makefile
> > new file mode 100644
> > index 000000000000..eb8bac9279a8
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/sigreturn/Makefile
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2021 ARM Limited
> > +# Originally tools/testing/arm64/abi/Makefile
> > +
> > +CFLAGS += -I$(top_srcdir)/tools/include
> > +
> > +TEST_GEN_PROGS := sigreturn
> > +
> > +include ../../lib.mk
> > +
> > +$(OUTPUT)/sigreturn: sigreturn.c
> > +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > diff --git a/tools/testing/selftests/riscv/sigreturn/sigreturn.c b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
> > new file mode 100644
> > index 000000000000..62397d5934f1
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <signal.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <ucontext.h>
> > +#include <linux/ptrace.h>
> > +#include "../../kselftest_harness.h"
> > +
> > +#define RISCV_V_MAGIC		0x53465457
> > +#define DEFAULT_VALUE		2
> > +#define SIGNAL_HANDLER_OVERRIDE	3
> > +
> > +static void simple_handle(int sig_no, siginfo_t *info, void *vcontext)
> > +{
> > +	ucontext_t *context = vcontext;
> > +
> > +	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
> > +}
> > +
> > +static void vector_override(int sig_no, siginfo_t *info, void *vcontext)
> > +{
> > +	ucontext_t *context = vcontext;
> > +
> > +	// vector state
> > +	struct __riscv_extra_ext_header *ext;
> > +	struct __riscv_v_ext_state *v_ext_state;
> > +
> > +	/* Find the vector context. */
> > +	ext = (void *)(&context->uc_mcontext.__fpregs);
> > +	if (ext->hdr.magic != RISCV_V_MAGIC) {
> > +		fprintf(stderr, "bad vector magic: %x\n", ext->hdr.magic);
> > +		abort();
> > +	}
> > +
> > +	v_ext_state = (void *)((char *)(ext) + sizeof(*ext));
> > +
> > +	*(int *)v_ext_state->datap = SIGNAL_HANDLER_OVERRIDE;
> > +
> > +	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
> > +}
> > +
> > +static int vector_sigreturn(int data, void (*handler)(int, siginfo_t *, void *))
> > +{
> > +	int after_sigreturn;
> > +	struct sigaction sig_action = {
> > +		.sa_sigaction = handler,
> > +		.sa_flags = SA_SIGINFO
> > +	};
> > +
> > +	sigaction(SIGSEGV, &sig_action, 0);
> > +
> > +	asm(".option push				\n\
> > +		.option		arch, +v		\n\
> > +		vsetivli	x0, 1, e32, ta, ma	\n\
> > +		vmv.s.x		v0, %1			\n\
> > +		# Generate SIGSEGV			\n\
> > +		lw		a0, 0(x0)		\n\
> > +		vmv.x.s		%0, v0			\n\
> > +		.option pop" : "=r" (after_sigreturn) : "r" (data));
> > +
> > +	return after_sigreturn;
> > +}
> > +
> > +TEST(vector_restore)
> > +{
> > +	int result;
> > +
> > +	result = vector_sigreturn(DEFAULT_VALUE, &simple_handle);
> > +
> > +	EXPECT_EQ(DEFAULT_VALUE, result);
> > +}
> > +
> > +TEST(vector_restore_signal_handler_override)
> > +{
> > +	int result;
> > +
> > +	result = vector_sigreturn(DEFAULT_VALUE, &vector_override);
> > +
> > +	EXPECT_EQ(SIGNAL_HANDLER_OVERRIDE, result);
> > +}
> > +
> > +TEST_HARNESS_MAIN
> >
> > ---
> > base-commit: 4cece764965020c22cff7665b18a012006359095
> > change-id: 20240403-vector_sigreturn_tests-8118f0ac54fa
> 

