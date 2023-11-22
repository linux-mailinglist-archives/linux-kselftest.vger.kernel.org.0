Return-Path: <linux-kselftest+bounces-444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F567F44CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 12:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2828145A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977D4B5A0;
	Wed, 22 Nov 2023 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9hBk4aI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7112112
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 03:19:53 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507bd19eac8so8716364e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700651992; x=1701256792; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3kjvu0VloZP4KQiHhVadM49un1kZn5Ae0fw9syYhgw=;
        b=b9hBk4aI07U7BHGkvvcEj++6n+o412jYbFGek2hsPU2ARW23/a6t9wGJ7+/FBtV8b3
         RuCcEUa6XcWCpe7L0q5AnVmEUJPY9OJvqSRXKu3Tt59F6v7fOUjhSO75gPVwcfRpg4aa
         ZUJOdNWQrUitW0pVEUSAinyZNUoKUsXq+ZC6rMF9e7UOEKYAWeRYHaYaAVNDHXRI9Syz
         fmQY41OaliII61zBkxhVKwoQYMbqoNCG4juKPWIJ3GSRIH0uGNZN/Es+6dYkV2hqoYsA
         eWpdKzfaAjPSKGhQR4XIc6TxhUQyK43rHssz8H5vFXveEEM5fKroOD/yxFomIuydZtTh
         XEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700651992; x=1701256792;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3kjvu0VloZP4KQiHhVadM49un1kZn5Ae0fw9syYhgw=;
        b=VqB7F5BhquK26N/UBW8XkyInELasr5LV7LWRBPVyVhSzsp/pM9RBmGiHPSGKG/yFmx
         fqzUhSuajA+pA3MjQ9Wi9MkwPjEYp2TxxVzC0FWDOyZN+1w/RUjlQgATybz3MD2TSV6n
         plseDNEXrBlYZztHz+tPSUuWHjRRkSPAPuXp/BydQ155rdazoNOQWUB+FIrbd8gLGgQk
         by5G0ddVNHrQwEbgYXvMswzOpoionipZeDX2s5Ubof61xLQuWzOax6PY6IUpCsdo138x
         V6a1o+WANle7SYxLGmI4sjbN7zNqXLUwuMhFjyY9PbndeB8pTiXpzSy/sJSOzN6muyQq
         rYOw==
X-Gm-Message-State: AOJu0YxeCzCrCm/WfjiT2f8T/bwf+fPsRjUASyCQYLSA8pi6xnYUdnn5
	JWN1vR9vAwNApBMHwqu4mgjPjA==
X-Google-Smtp-Source: AGHT+IFWE7BT+PN/5dFFTqteLPvvSzgahW3WvHk+hNVUuji5wb1Oegaf4BVmOZvzkNpsM4twrHMhoA==
X-Received: by 2002:a05:6512:544:b0:509:4530:e7fb with SMTP id h4-20020a056512054400b005094530e7fbmr1229715lfl.32.1700651991933;
        Wed, 22 Nov 2023 03:19:51 -0800 (PST)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id f19-20020a0565123b1300b0050aaaa37f16sm1205123lfv.208.2023.11.22.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:19:51 -0800 (PST)
Date: Wed, 22 Nov 2023 12:19:49 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 5/5] kselftest/clone3: Test shadow stack support
Message-ID: <20231122111949.GB364395@mutt>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-5-a7b8ed3e2acc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120-clone3-shadow-stack-v3-5-a7b8ed3e2acc@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On 2023-11-20 23:54, Mark Brown wrote:
> Add basic test coverage for specifying the shadow stack for a newly
> created thread via clone3(), including coverage of the newly extended
> argument structure.
>
> In order to facilitate testing on systems without userspace shadow stack
> support we manually enable shadow stacks on startup, this is architecture
> specific due to the use of an arch_prctl() on x86. Due to interactions with
> potential userspace locking of features we actually detect support for
> shadow stacks on the running system by attempting to allocate a shadow
> stack page during initialisation using map_shadow_stack(), warning if this
> succeeds when the enable failed.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/clone3/clone3.c           | 117 ++++++++++++++++++++++
>  tools/testing/selftests/clone3/clone3_selftests.h |   7 ++
>  2 files changed, 124 insertions(+)
>
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 6adbfd14c841..0f9f99dc5aac 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -11,6 +11,7 @@
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/mman.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/un.h>
> @@ -21,6 +22,10 @@
>  #include "../kselftest.h"
>  #include "clone3_selftests.h"
>
> +static bool shadow_stack_enabled;
> +static bool shadow_stack_supported;
> +static size_t max_supported_args_size;
> +
>  enum test_mode {
>  	CLONE3_ARGS_NO_TEST,
>  	CLONE3_ARGS_ALL_0,
> @@ -28,6 +33,7 @@ enum test_mode {
>  	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
>  	CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
>  	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
> +	CLONE3_ARGS_SHADOW_STACK,
>  };
>
>  typedef bool (*filter_function)(void);
> @@ -44,6 +50,36 @@ struct test {
>  	filter_function filter;
>  };
>
> +#ifndef __NR_map_shadow_stack
> +#define __NR_map_shadow_stack 453
> +#endif
> +
> +/*
> + * We check for shadow stack support by attempting to use
> + * map_shadow_stack() since features may have been locked by the
> + * dynamic linker resulting in spurious errors when we attempt to
> + * enable on startup.  We warn if the enable failed.
> + */
> +static void test_shadow_stack_supported(void)
> +{
> +        long shadow_stack;
> +
> +	shadow_stack = syscall(__NR_map_shadow_stack, 0, getpagesize(), 0);
> +	if (shadow_stack == -1) {
> +		ksft_print_msg("map_shadow_stack() not supported\n");
> +	} else if ((void *)shadow_stack == MAP_FAILED) {
> +		ksft_print_msg("Failed to map shadow stack\n");
> +	} else {
> +		ksft_print_msg("Shadow stack supportd\n");
> +		shadow_stack_supported = true;
> +
> +		if (!shadow_stack_enabled)
> +			ksft_print_msg("Mapped but did not enable shadow stack\n");
> +
> +		munmap((void *)shadow_stack, getpagesize());
> +	}
> +}
> +
>  static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>  {
>  	struct __clone_args args = {
> @@ -89,6 +125,9 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>  	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
>  		args.exit_signal = 0x00000000000000f0ULL;
>  		break;
> +	case CLONE3_ARGS_SHADOW_STACK:
> +		args.shadow_stack_size = getpagesize();
> +		break;
>  	}
>
>  	memcpy(&args_ext.args, &args, sizeof(struct __clone_args));
> @@ -179,6 +218,26 @@ static bool no_timenamespace(void)
>  	return true;
>  }
>
> +static bool have_shadow_stack(void)
> +{
> +	if (shadow_stack_supported) {
> +		ksft_print_msg("Shadow stack supported\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool no_shadow_stack(void)
> +{
> +	if (!shadow_stack_supported) {
> +		ksft_print_msg("Shadow stack not supported\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static size_t page_size_plus_8(void)
>  {
>  	return getpagesize() + 8;
> @@ -322,16 +381,74 @@ static const struct test tests[] = {
>  		.expected = -EINVAL,
>  		.test_mode = CLONE3_ARGS_NO_TEST,
>  	},
> +	{
> +		.name = "Shadow stack on system with shadow stack",
> +		.flags = CLONE_VM,
> +		.size = 0,
> +		.expected = 0,
> +		.e2big_valid = true,
> +		.test_mode = CLONE3_ARGS_SHADOW_STACK,
> +		.filter = no_shadow_stack,
> +	},
> +	{
> +		.name = "Shadow stack on system without shadow stack",
> +		.flags = CLONE_VM,
> +		.size = 0,
> +		.expected = -EINVAL,
> +		.e2big_valid = true,
> +		.test_mode = CLONE3_ARGS_SHADOW_STACK,
> +		.filter = have_shadow_stack,
> +	},
>  };
>
> +#ifdef __x86_64__
> +#define ARCH_SHSTK_ENABLE	0x5001
> +#define ARCH_SHSTK_SHSTK	(1ULL <<  0)
> +
> +#define ARCH_PRCTL(arg1, arg2)					\
> +({								\
> +	long _ret;						\
> +	register long _num  asm("eax") = __NR_arch_prctl;	\
> +	register long _arg1 asm("rdi") = (long)(arg1);		\
> +	register long _arg2 asm("rsi") = (long)(arg2);		\
> +								\
> +	asm volatile (						\
> +		"syscall\n"					\
> +		: "=a"(_ret)					\
> +		: "r"(_arg1), "r"(_arg2),			\
> +		  "0"(_num)					\
> +		: "rcx", "r11", "memory", "cc"			\
> +	);							\
> +	_ret;							\
> +})
> +
> +#define ENABLED_SHADOW_STACK
> +static inline void enable_shadow_stack(void)
> +{
> +	int ret = ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> +	if (ret == 0)
> +		shadow_stack_enabled = true;
> +}
> +
> +#endif
> +
> +#ifndef ENABLE_SHADOW_STACK

Should this be ENABLED_SHADOW_STACK ?


Built this patchset for x86 gave me this build error:

make[4]: Entering directory '/home/anders/src/kernel/linux/tools/testing/selftests/clone3'
x86_64-linux-gnu-gcc -g -std=gnu99 -isystem /home/anders/.cache/tuxmake/builds/513/build/usr/include     clone3.c -lcap -o /home/anders/.cache/tuxmake/builds/513/build/kselftest/clone3/clone
3
clone3.c:436:13: error: redefinition of 'enable_shadow_stack'
  436 | static void enable_shadow_stack(void)
      |             ^~~~~~~~~~~~~~~~~~~
clone3.c:426:20: note: previous definition of 'enable_shadow_stack' with type 'void(void)'
  426 | static inline void enable_shadow_stack(void)
      |                    ^~~~~~~~~~~~~~~~~~~
make[4]: Leaving directory '/home/anders/src/kernel/linux/tools/testing/selftests/clone3'
make[4]: *** [../lib.mk:181: /home/anders/.cache/tuxmake/builds/513/build/kselftest/clone3/clone3] Error 1
make[3]: *** [Makefile:178: all] Error 2
make[3]: Target 'install' not remade because of errors.
make[2]: *** [/home/anders/src/kernel/linux/Makefile:1362: kselftest-install] Error 2


Cheers,
Anders

