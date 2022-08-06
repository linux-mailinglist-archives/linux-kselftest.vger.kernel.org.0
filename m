Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2862258B49C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiHFIwf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Aug 2022 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiHFIwe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Aug 2022 04:52:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3F411C0F;
        Sat,  6 Aug 2022 01:52:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so5938092edd.3;
        Sat, 06 Aug 2022 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fIC7ahPt/yl/Wyy4QWb7dX1zPPvhwOFguvsp8IXkz8=;
        b=WiebgT5b2J4a0+leH+elpcb5xrOH20I+e99nRYnioqk0cPGLYuSR65D/V5ao0bRQN6
         lpooaDZR1Gb26N2xT9OQjoK3+ONLmWGohPc3ssSa2n7ltPgoX1Avn2Z6xhvfe+7eCLN9
         /V+TyRhiIFdTc+ZDrjcxfs0Mq91wD8GYPY2SougDba7OXMhWYIiHqYBYQhE+PPO8QoaF
         3r9h3RVMvyPHPH+Do2dzzmwqjdsn+gX9FBDIrn1d90/oTwFV8p1TdnnDd1wZ4bOcn36m
         jXkopJvRk3vyLhTvvGIuM55ghDEZHv0QvX91GJyZ73YDfQ0VMJe+P6P169teRsYlCZ/o
         Yu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8fIC7ahPt/yl/Wyy4QWb7dX1zPPvhwOFguvsp8IXkz8=;
        b=JZTP3XuVcd3MrBu6nt8o1y7mM/X1WUaSFBWtfhBaW4CmlLGB11ztjFXpaXnbi5zEiP
         Avpfo+pmx6dlm3i74ye/Kq8k1NiMXKJMhklFXfXB0C36KnNplJtH7LmcJ4A6ua4Ygyok
         S5XWrxR/XnVwVV36SvNl90TwFf6jDqlPUuyOKatlBaeGBXNAvPqbiqHdPUejKLthfUIC
         KYA2Lzf7I1s94xarqJgos7MOyosoz2RqxQeyU1obQjm5efRV2C/XeN9tGMmUek/3NGGr
         ZKTxulHPHqCzb72tHqEhoQcoScbc+U7RrIj0H/hTWyHrwV2uD8qatTs6ra+Q2Wvkj1V5
         bA5Q==
X-Gm-Message-State: ACgBeo1g9YxOYgLyngRL+X0//wcZ9Txp52tJCYw+GSq+Djt07QBn8fY6
        Lqzgt9LFIO/8UIpuM57+vi0=
X-Google-Smtp-Source: AA6agR7I3BPzMaJLhn7mIBm8oYPE933dMZssupMAVRo2LmXHgjANUX3pIUiEIg0GbYRxMFeejYFBKQ==
X-Received: by 2002:a05:6402:2691:b0:43d:ba10:854b with SMTP id w17-20020a056402269100b0043dba10854bmr9583625edd.158.1659775951887;
        Sat, 06 Aug 2022 01:52:31 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709062ad100b0072b7d76211dsm2434804eje.107.2022.08.06.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 01:52:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 10:52:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Subject: Re: [PATCH v4 2/2] selftests/vm/pkeys: Add a regression test for
 setting PKRU through ptrace
Message-ID: <Yu4rzf9XI6NzHwne@gmail.com>
References: <20220805230158.39378-1-khuey@kylehuey.com>
 <20220805230158.39378-2-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805230158.39378-2-khuey@kylehuey.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Kyle Huey <me@kylehuey.com> wrote:

> From: Kyle Huey <me@kylehuey.com>
> 
> This tests PTRACE_SETREGSET with NT_X86_XSTATE modifying PKRU directly and
> removing the PKRU bit from XSTATE_BV.
> 
> Signed-off-by: Kyle Huey <me@kylehuey.com>
> ---
>  tools/testing/selftests/vm/pkey-x86.h        | 12 +++
>  tools/testing/selftests/vm/protection_keys.c | 88 +++++++++++++++++++-
>  2 files changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
> index b078ce9c6d2a..72c14cd3ddc7 100644
> --- a/tools/testing/selftests/vm/pkey-x86.h
> +++ b/tools/testing/selftests/vm/pkey-x86.h
> @@ -104,6 +104,18 @@ static inline int cpu_has_pkeys(void)
>  	return 1;
>  }
>  
> +static inline int cpu_max_xsave_size(void)
> +{
> +	unsigned long XSTATE_CPUID = 0xd;
> +	unsigned int eax;
> +	unsigned int ebx;
> +	unsigned int ecx;
> +	unsigned int edx;
> +
> +	__cpuid_count(XSTATE_CPUID, 0, eax, ebx, ecx, edx);
> +	return ecx;
> +}
> +
>  static inline u32 pkey_bit_position(int pkey)
>  {
>  	return pkey * PKEY_BITS_PER_PKEY;
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 291bc1e07842..27759d3ed9cd 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -18,12 +18,13 @@
>   *	do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
>   *
>   * Compile like this:
> - *	gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> - *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> + *	gcc -mxsave      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> + *	gcc -mxsave -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
>   */
>  #define _GNU_SOURCE
>  #define __SANE_USERSPACE_TYPES__
>  #include <errno.h>
> +#include <linux/elf.h>
>  #include <linux/futex.h>
>  #include <time.h>
>  #include <sys/time.h>
> @@ -1550,6 +1551,86 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
>  	do_not_expect_pkey_fault("plain read on recently PROT_EXEC area");
>  }
>  
> +#if defined(__i386__) || defined(__x86_64__)
> +void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
> +{
> +	pid_t child;
> +	int status, ret;
> +	int pkey_offset = pkey_reg_xstate_offset();
> +	size_t xsave_size = cpu_max_xsave_size();
> +	void *xsave;
> +	u32 *pkey_register;
> +	u64 *xstate_bv;
> +	struct iovec iov;
> +
> +	child = fork();
> +	pkey_assert(child >= 0);
> +	dprintf3("[%d] fork() ret: %d\n", getpid(), child);
> +	if (!child) {
> +		u32 pkey_register = read_pkey_reg();
> +
> +		ptrace(PTRACE_TRACEME, 0, 0, 0);
> +		raise(SIGSTOP);
> +
> +		/*
> +		 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
> +		 * checking
> +		 */
> +		if (pkey_register == __read_pkey_reg())
> +			exit(1);
> +
> +		raise(SIGSTOP);
> +
> +		exit(__read_pkey_reg());
> +	}
> +
> +	pkey_assert(child == waitpid(child, &status, 0));
> +	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> +	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
> +
> +	xsave = (void *)malloc(xsave_size);
> +	pkey_assert(xsave > 0);
> +
> +	iov.iov_base = xsave;
> +	iov.iov_len = xsave_size;
> +	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> +	pkey_assert(ret == 0);
> +
> +	pkey_register = (u32 *)(xsave + pkey_offset);
> +	pkey_assert(*pkey_register == read_pkey_reg());
> +
> +	*pkey_register = !read_pkey_reg();
> +
> +	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> +	pkey_assert(ret == 0);
> +
> +	ret = ptrace(PTRACE_CONT, child, 0, 0);
> +	pkey_assert(ret == 0);
> +
> +	pkey_assert(child == waitpid(child, &status, 0));
> +	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> +	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
> +
> +	ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> +	pkey_assert(ret == 0);
> +
> +	xstate_bv = (u64 *)(xsave + 512);
> +	*xstate_bv &= ~(1 << 9);
> +
> +	ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> +	pkey_assert(ret == 0);
> +
> +	ret = ptrace(PTRACE_CONT, child, 0, 0);
> +	pkey_assert(ret == 0);
> +
> +	pkey_assert(child == waitpid(child, &status, 0));
> +	dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> +	pkey_assert(WIFEXITED(status));
> +	pkey_assert(WEXITSTATUS(status) == 0);
> +	free(xsave);

LGTM.

May I ask for a bit more in terms of testing the ABI: writing some 
non-trivial (not all-zero and not all-ones) value into the PKRU register, 
forcing the child task to go through a FPU save/restore context switch
and then reading it back and verifying the value, or something like that?

Thanks,

	Ingo
