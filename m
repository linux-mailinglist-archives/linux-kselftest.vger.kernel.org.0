Return-Path: <linux-kselftest+bounces-10584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F98CC4FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31791B21258
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8814038F;
	Wed, 22 May 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="UQrGAa5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38DE6AD7
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396034; cv=none; b=B1TiJKV5eYJ8hENX/WNvL2Eb9oZ8ELmHeYgvIMuLuU5TcpcJf6JIwex83FOs6P6F5ZniqH0PmNMHHU++XM1gjSNHFZU7Ym79INwENXWVyo4fzYKqdxjqGL5BO8rKJko10gCiR49DMn/OQxTlpHyh7QY1In1njSbII+USCiFNaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396034; c=relaxed/simple;
	bh=AQgUlV9ljyVvTXd6sdYi/VKpv3N6lC3vGB8gSB2bAQI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=TTFfQvsfxslyEcghrzwwtClMct2vjIOnGxEd7077xhrEAGJoyJ8Y+JZ9frqGRwDq6tP7CPruyDyy5PvGNIW0k1EBaCPtVfMlCzpB3gPFMmq8dgU58EPjaXFfdLYUTSQLBkXNho6AO3QhsPzIJkImWoRa3af1klZ/O4Fovd+Vu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=UQrGAa5I; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee5235f5c9so112575285ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1716396032; x=1717000832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh2hEBp7C+i2NTaEC7uyemcMKD8WTFnEb/ThoPY8mY0=;
        b=UQrGAa5IdsZVSuVDF/zLZn7ozK11aW9vPcyK7GFDQtdJllB5juftSGJfr6OIzRqE4i
         m1YUfn8x58blCmJZ8ZgB3I6S7h5XhkpisxmHYkGrVcXZK+jo86B8Z/SoYycQ4Hlg7FKQ
         AtgVg4y76VfwJxEmac1o31cYE3gRAGuhNkQQlp/jBmBjeboCUgE1bo7cqko8q7XdnNQC
         F4Up2aDTYjFla2T6Za67mqdOQz4uIToIMGK5EcRNJTVc6tP4sgYl0jBXt3tVeME4lSS9
         TrGXjl0iIAFaHpEqVPUe/q0QMSdWeWBP1mTQR3/fpYO8/kFS/P2wxdomI33pB+2tir9U
         XbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716396032; x=1717000832;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh2hEBp7C+i2NTaEC7uyemcMKD8WTFnEb/ThoPY8mY0=;
        b=WSkWhUFHDctZ2Ck6VZX11QqPMsPLh5YQM4A9efGhaqekAJ9c6NeJ8xWIzjomNQEtD6
         pXmL2GXqMA025YVnPZSYsIMpoDMPaiW6vxe2cwbpjwpnbCEuCwyP1HfLcT8jZKslTYV9
         Ra4gU7yr2PvvT46ap+OmbGdKY/uJ3/ZlZ9A5GXhk662NtsvT1R0UkNW7yog1R2++Sqq1
         s0IBG5eGRb0wXg4reK0K3Sm+vLaMU3rpm32WBpRxp4Qr01Lymjkx0qqV3/NO86CfURse
         SBEs0GB6kWKDlUuw6UVe1oXCNOQqH1XZKg7wGF6zM3Bz61bfmidgk5X2hGalr1GkO+HI
         dXvg==
X-Forwarded-Encrypted: i=1; AJvYcCV99xslQToR0aqEh0H7fjMFii1331omLXAf6BFq6pwhHLQ2lg6+Nh6llQu+NFCgGHZ+W15bjgUpNuLLaLJReUPNrorisV+bXnGoyz46q9Qd
X-Gm-Message-State: AOJu0Yzzqeqh807d0nogWp1C9/uk/dP/x0ZI578PyGyty9g9TuUoEZRo
	S89NVKZVz2XJKeopYTazuiWbuKb/nGQYcRQmX+piB0b0QccZnnR951ZdqzJfNUA=
X-Google-Smtp-Source: AGHT+IHTgDEZ1Rdi9Tw0QmvSjoSsko/OAJhdhHxBLtqT7rpxgRJiixbvhXF7RsPN5V9wFt21tEw6+Q==
X-Received: by 2002:a17:902:9895:b0:1f2:efdf:a410 with SMTP id d9443c01a7336-1f31c97be08mr23788185ad.15.1716396031849;
        Wed, 22 May 2024 09:40:31 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad7eb8sm241308015ad.90.2024.05.22.09.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:40:31 -0700 (PDT)
Date: Wed, 22 May 2024 09:40:31 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2024 09:40:20 PDT (-0700)
Subject:     Re: [PATCH] riscv: selftests: Add signal handling vector tests
In-Reply-To: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
CC: shuah@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, andy.chiu@sifive.com, bjorn@kernel.org, Vineet Gupta <vineetg@rivosinc.com>,
  linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
  Charlie Jenkins <charlie@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-50849ea8-b103-43af-aef4-073aff99ae61@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 16:50:29 PDT (-0700), Charlie Jenkins wrote:
> Add two tests to check vector save/restore when a signal is received
> during a vector routine. One test ensures that a value is not clobbered
> during signal handling. The other verifies that vector registers
> modified in the signal handler are properly reflected when the signal
> handling is complete.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> These tests came about to highlight the bug fixed in
> https://lore.kernel.org/lkml/20240403072638.567446-1-bjorn@kernel.org/
> and will only pass with that fix applied.

Thaks.  I'm just staging this, I have a testcase too that I keep 
forgetting to post because I haven't gotten in into the selftests sanely 
yet...

    #include "../../kselftest.h"
    #include <signal.h>
    #include <stdlib.h>
    #include <asm/ptrace.h>
    #include <stdint.h>
    
    #define ITERATIONS     (1 << 24)
    #define RISCV_V_MAGIC  0x53465457
    
    struct __riscv_ctx_hdr {
            __u32 magic;
            __u32 size;
    };
    
    struct __riscv_extra_ext_header {
            __u32 __padding[129] __attribute__((aligned(16)));
            /*
             * Reserved for expansion of sigcontext structure.  Currently zeroed
             * upon signal, and must be zero upon sigreturn.
             */
            __u32 reserved;
            struct __riscv_ctx_hdr hdr;
    };
    
    
    struct __riscv_v_ext_state {
            unsigned long vstart;
            unsigned long vl;
            unsigned long vtype;
            unsigned long vcsr;
            unsigned long vlenb;
            void *datap;
            /*
             * In signal handler, datap will be set a correct user stack offset
             * and vector registers will be copied to the address of datap
             * pointer.
             */
    };
    
    /* The beginning of the actual state. */
    int count;
    
    void handler(int, siginfo_t *si, void *ucontext_void)
    {
    	ucontext_t *ucontext = ucontext_void;
    
    	/* Skip over the SEGV by just jumping to a0. */
    	ucontext->uc_mcontext.__gregs[REG_PC] = ucontext->uc_mcontext.__gregs[REG_A0];
    
    	/* Increment the first element of v0. */
    	{
    		struct __riscv_extra_ext_header *ext;
    		struct __riscv_v_ext_state *v_ext_state;
    		uint32_t val;
    
    		/* Find the vector context. */
    		ext = (void *)(&ucontext->uc_mcontext.__fpregs);
    		if (ext->hdr.magic != RISCV_V_MAGIC) {
    			fprintf(stderr, "bad vector magic: %x\n", ext->hdr.magic);
    			abort();
    		}
    
    		v_ext_state = (void *)((char *)(ext) + sizeof(*ext));
    
    		/* Actually do the increment. */
    		memcpy(&val, v_ext_state->datap, sizeof(val));
    		val++;
    		memcpy(v_ext_state->datap, &val, sizeof(val));
    	}
    
    	/* Count the delivered signal, to make sure we don't miss any. */
    	count++;
    }
    
    void sigill(int, siginfo_t *si, void *ucontext_void)
    {
    	fprintf(stderr, "SIGILL after %d iterations\n", count);
    	abort();
    }
    
    void check_signal(void)
    {
    	int check = rand();
    	int out;
    
    	__asm__ volatile (
    		"vsetvli a0, %2, e32, ta, ma\n\t"
    		"vmv.s.x v0, %1\n\t"
    		"la a0, 1f\n\t"
    		"lw t0, 0(x0)\n\t"
    		"1:\n\t"
    		"vmv.x.s %0, v0"
    		: "=&r"(out)
    		: "r"(check-1), "r"(1)
    		: "a0"
    #ifdef __riscv_vector
    		  , "v0"
    #endif
    	);
    
    	if (out != check) {
    		fprintf(stderr, "out: %d\ncheck: %d\n", out, check);
    		abort();
    	}
    }
    
    int main(void)
    {
    	struct sigaction sa_segv, sa_ill;
    
    	memset(&sa_segv, 0, sizeof(sa_segv));
    	sa_segv.sa_sigaction = &handler;
    	sa_segv.sa_flags     = SA_SIGINFO;
    	sigaction(SIGSEGV, &sa_segv, NULL);
    
    	memset(&sa_ill, 0, sizeof(sa_ill));
    	sa_ill.sa_sigaction = &sigill;
    	sa_ill.sa_flags     = SA_SIGINFO;
    	sigaction(SIGILL, &sa_ill, NULL);
    
    	count = 0;
    	for (int i = 0; i < ITERATIONS; ++i)
    		check_signal();
    
    	if (count != ITERATIONS) {
    		fprintf(stderr, "count: %d\n", count);
    		abort();
    	}
    
    	return 0;
    }

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

