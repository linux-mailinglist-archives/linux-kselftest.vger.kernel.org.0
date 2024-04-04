Return-Path: <linux-kselftest+bounces-7155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B9897D0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 02:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04311F2A165
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 00:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7560139E;
	Thu,  4 Apr 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0dgeL0Pm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E611370
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190448; cv=none; b=n5cZhHycoxAtEEw46K7Kf8JPewBjj3Iz1fOu40ua7iGOw5XON4n+Tcp1enBSgvAhwJqI8dyIvwyQwwOWsdUCjUvNkMAfsOAqcHv0YO/OsOsfHqP7QAPBwgqBIpKOqDHiTu/RVRrSVq1tgUlfR+KOBaHRBaGQjW+KrUxK5ivzAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190448; c=relaxed/simple;
	bh=j+TvKY7Bn8AoSIc99pjkGihpjD70Jl3L1uBRE0nwDj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcocPH1fxMKLiUfqVKdhV7nw0t0AZN2I1kMHAkPegfYktwNJ/32mlshseA1zY0bBYuX0Ymv0fNhYBHasp3FfQxWOF0CslBn6va60wLk5LsWO2W1aakfmiscLq9Zdyt/TW/9eCALgxpt+2qIai7bhgvumi1XgrihQ61PBc/kNQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0dgeL0Pm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e709e0c123so356278b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712190445; x=1712795245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulNjjnGHacupkL1wK4ADZTn/tTEYJEcOSwDzhvF8wnk=;
        b=0dgeL0Pmg5j7lwdT0Dvf9+zIuSAWk0ATNWFyFIF2I4gbfqq7o14lUePfnsOSq0WlfH
         AqWrPmH48wJ67aYqk3Afz4k+ucRiZmPevYmZhbhz8ydsEGcKwCpABJuynFaKRgtDKBi6
         11f27wWacm1AyRiklGncNcDAcuasnrHAVeEEa8eEPGi+HZ616jC3hC8/kv02eRykiBoW
         4O/S4IlxIuwujpQSLhyQW7kr/Dp/dcKPT5EBoLeJ4+Q5Zhuojo3N/lIEAEwNukBR5CIF
         DIoslT+k3QGitwPToysb6oouFIlps64H1tD+FcGQV6BTrYeUOJuKDhaVYrhq4px3Be6B
         6Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190445; x=1712795245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulNjjnGHacupkL1wK4ADZTn/tTEYJEcOSwDzhvF8wnk=;
        b=VngEJAOQ7XESGROWjE8ROxPBWTC4fbt/O8JLn2nC1iq3DSVYocEDDYrHmyvoxdMOn+
         s5E5XF+/+0wVs0M1B1cp6h6GaZUcoIpzhk/4sJeD7XQJ9a3mZ/3jdbB9jV5fSeNHdBWK
         8ouWQLy28zmuVcaqPsXbjgfu8f0U1Zbj3jhmMDnxMqRcgyjPalis2JkdE8tK/M94jEiX
         e7rSIU8VhszrHALNFoVOG+5nQpn91umRYbzSR53uUtSsCJjDEa2es31AQm1qpDRtd+UG
         EqI1cpr7qylbVjajXXrCcsrbG1q+x08qx4SF0gAyRGAfiEoXzsfYbW25hY03EWlMgoij
         3DmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuTQbXN8ZmPfE0AvQPWeYNdFR3Eg4OqQkyl3a04TeMHBJugNQyoVhJ3u1dGMMel7vsBUGzxAjJAdvWO4i/D1pn4NQL4pUYgDPsV3+VJpRf
X-Gm-Message-State: AOJu0Yzz7r2oi6y2uXfgQnoe9fYJNYbaFuzp38/97hbjIM995iYNTt1f
	MW3+U6BI3Mu/ZC1hAHClQobd2vWswGtSEaR3I1QWc5eH+pO2A4aYO8BzKBU/agA=
X-Google-Smtp-Source: AGHT+IFHYuFf4798AwOR1iHBDx2IxXYtUAW7d845lRV4JHj0meMCcPt6hv0exjv65S7XmTxWfZPjqg==
X-Received: by 2002:a05:6a00:908d:b0:6ea:d10d:c96d with SMTP id jo13-20020a056a00908d00b006ead10dc96dmr1366514pfb.19.1712190445206;
        Wed, 03 Apr 2024 17:27:25 -0700 (PDT)
Received: from [10.0.16.165] ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7928f000000b006ea7d877191sm12440141pfa.2.2024.04.03.17.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 17:27:24 -0700 (PDT)
Message-ID: <56863fe7-4d82-4f37-a518-2acf368c3ea6@rivosinc.com>
Date: Wed, 3 Apr 2024 17:27:23 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: selftests: Add signal handling vector tests
To: Charlie Jenkins <charlie@rivosinc.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andy Chiu <andy.chiu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
Content-Language: en-US
From: Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 16:50, Charlie Jenkins wrote:
> Add two tests to check vector save/restore when a signal is received
> during a vector routine. One test ensures that a value is not clobbered
> during signal handling. The other verifies that vector registers
> modified in the signal handler are properly reflected when the signal
> handling is complete.

Hmm, isn't this testing two contradictory things ?

We do want V regs to be not clobbered across a handled signal, o/w V
enabled code would just not work at all.
That implies that anything done by signal handler should just be
discarded - no ?

Am I missing something.

-Vineet

>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> These tests came about to highlight the bug fixed in
> https://lore.kernel.org/lkml/20240403072638.567446-1-bjorn@kernel.org/
> and will only pass with that fix applied.
> ---
>  tools/testing/selftests/riscv/Makefile             |  2 +-
>  tools/testing/selftests/riscv/sigreturn/.gitignore |  1 +
>  tools/testing/selftests/riscv/sigreturn/Makefile   | 12 ++++
>  .../testing/selftests/riscv/sigreturn/sigreturn.c  | 82 ++++++++++++++++++++++
>  4 files changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 4a9ff515a3a0..7ce03d832b64 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>  
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe vector mm
> +RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
>  else
>  RISCV_SUBTARGETS :=
>  endif
> diff --git a/tools/testing/selftests/riscv/sigreturn/.gitignore b/tools/testing/selftests/riscv/sigreturn/.gitignore
> new file mode 100644
> index 000000000000..35002b8ae780
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sigreturn/.gitignore
> @@ -0,0 +1 @@
> +sigreturn
> diff --git a/tools/testing/selftests/riscv/sigreturn/Makefile b/tools/testing/selftests/riscv/sigreturn/Makefile
> new file mode 100644
> index 000000000000..eb8bac9279a8
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sigreturn/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 ARM Limited
> +# Originally tools/testing/arm64/abi/Makefile
> +
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +TEST_GEN_PROGS := sigreturn
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/sigreturn: sigreturn.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/sigreturn/sigreturn.c b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
> new file mode 100644
> index 000000000000..62397d5934f1
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <ucontext.h>
> +#include <linux/ptrace.h>
> +#include "../../kselftest_harness.h"
> +
> +#define RISCV_V_MAGIC		0x53465457
> +#define DEFAULT_VALUE		2
> +#define SIGNAL_HANDLER_OVERRIDE	3
> +
> +static void simple_handle(int sig_no, siginfo_t *info, void *vcontext)
> +{
> +	ucontext_t *context = vcontext;
> +
> +	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
> +}
> +
> +static void vector_override(int sig_no, siginfo_t *info, void *vcontext)
> +{
> +	ucontext_t *context = vcontext;
> +
> +	// vector state
> +	struct __riscv_extra_ext_header *ext;
> +	struct __riscv_v_ext_state *v_ext_state;
> +
> +	/* Find the vector context. */
> +	ext = (void *)(&context->uc_mcontext.__fpregs);
> +	if (ext->hdr.magic != RISCV_V_MAGIC) {
> +		fprintf(stderr, "bad vector magic: %x\n", ext->hdr.magic);
> +		abort();
> +	}
> +
> +	v_ext_state = (void *)((char *)(ext) + sizeof(*ext));
> +
> +	*(int *)v_ext_state->datap = SIGNAL_HANDLER_OVERRIDE;
> +
> +	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
> +}
> +
> +static int vector_sigreturn(int data, void (*handler)(int, siginfo_t *, void *))
> +{
> +	int after_sigreturn;
> +	struct sigaction sig_action = {
> +		.sa_sigaction = handler,
> +		.sa_flags = SA_SIGINFO
> +	};
> +
> +	sigaction(SIGSEGV, &sig_action, 0);
> +
> +	asm(".option push				\n\
> +		.option		arch, +v		\n\
> +		vsetivli	x0, 1, e32, ta, ma	\n\
> +		vmv.s.x		v0, %1			\n\
> +		# Generate SIGSEGV			\n\
> +		lw		a0, 0(x0)		\n\
> +		vmv.x.s		%0, v0			\n\
> +		.option pop" : "=r" (after_sigreturn) : "r" (data));
> +
> +	return after_sigreturn;
> +}
> +
> +TEST(vector_restore)
> +{
> +	int result;
> +
> +	result = vector_sigreturn(DEFAULT_VALUE, &simple_handle);
> +
> +	EXPECT_EQ(DEFAULT_VALUE, result);
> +}
> +
> +TEST(vector_restore_signal_handler_override)
> +{
> +	int result;
> +
> +	result = vector_sigreturn(DEFAULT_VALUE, &vector_override);
> +
> +	EXPECT_EQ(SIGNAL_HANDLER_OVERRIDE, result);
> +}
> +
> +TEST_HARNESS_MAIN
>
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240403-vector_sigreturn_tests-8118f0ac54fa


