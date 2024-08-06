Return-Path: <linux-kselftest+bounces-14826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0785294881D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 05:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDDA1C2218C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 03:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4BE1BA867;
	Tue,  6 Aug 2024 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8Weu7Y2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA501B9B57;
	Tue,  6 Aug 2024 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916495; cv=none; b=UJcVXz99dt1g69QnlLOhmWUXfmBjz4d8sivv7zTCBPZUm7Kr7TJEoEVk4ZX5jdNyiYEPMzDVsWhU9QbcY26OVSgAvz6YAx60KHID/Q9InjwKV5Aa5G75sErd8TxlRxrAnfz1oB5in4iekWKUwR6rVsGmRN6wsmT25PCGKNpgDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916495; c=relaxed/simple;
	bh=ZN7LpMGj7zrmpfRGmVKaOCvARt0JyWCvzNUEqCDoDQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqPjqifq8vYKSDKp8bQybQ1ABv/UJvHsjWeNI1iqACVii8T9FLutZ0xZnjCR/nbDOsurkqtEsjOJcYXXxBYYonm8otqZ6gL67FUgZ1kImB2mGoNyusp5AuvcoJcWnukF3KHqAjTMbIUq6jLoRZl8gahcsme3Yr/jmH8U9n2j2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8Weu7Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA205C32786;
	Tue,  6 Aug 2024 03:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722916494;
	bh=ZN7LpMGj7zrmpfRGmVKaOCvARt0JyWCvzNUEqCDoDQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8Weu7Y2u+9A2JYm6rvXwGOSTOLzWkUqOaHH4e8QT6kE4d36A9vli3jj1A/JW+uuC
	 SmHjqErcIJiy2XqELNbvRJn4fpt0BpEV5yn+z3xykCDZzgQvMwxs4i1cpnFytv4jX1
	 r1Wz2fzY8bewmmlw80OSHZbEGdlyVTJzk82+y8bm2FNvBL155Ej3y8v3bFEKefSeGK
	 rkogUeMwt+ZjRHriemu4nf/po3z0UzAd6iOY+g8GudodQhbypv+gmdxttLDlhRlZp3
	 LyDvY7ZSCyOLbkGIZDOMXzhg4NUAoGL/kwUImG7tyUilhwrZijXNrUitI7sAvppsmF
	 mKsBgx/5zyJ5g==
Date: Mon, 5 Aug 2024 20:54:54 -0700
From: Kees Cook <kees@kernel.org>
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
	Will Deacon <will@kernel.org>, jannh@google.com,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v7 9/9] selftests/clone3: Test shadow stack support
Message-ID: <202408052046.00BC7CBC@keescook>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
 <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-clone3-shadow-stack-v7-9-a9532eebfb1d@kernel.org>

On Wed, Jul 31, 2024 at 01:14:15PM +0100, Mark Brown wrote:
> Add basic test coverage for specifying the shadow stack for a newly
> created thread via clone3(), including coverage of the newly extended
> argument structure.  We check that a user specified shadow stack can be
> provided, and that invalid combinations of parameters are rejected.
> 
> In order to facilitate testing on systems without userspace shadow stack
> support we manually enable shadow stacks on startup, this is architecture
> specific due to the use of an arch_prctl() on x86. Due to interactions with
> potential userspace locking of features we actually detect support for
> shadow stacks on the running system by attempting to allocate a shadow
> stack page during initialisation using map_shadow_stack(), warning if this
> succeeds when the enable failed.
> 
> In order to allow testing of user configured shadow stacks on
> architectures with that feature we need to ensure that we do not return
> from the function where the clone3() syscall is called in the child
> process, doing so would trigger a shadow stack underflow.  To do this we
> use inline assembly rather than the standard syscall wrapper to call
> clone3().  In order to avoid surprises we also use a syscall rather than
> the libc exit() function., this should be overly cautious.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/clone3/clone3.c           | 134 +++++++++++++++++++++-
>  tools/testing/selftests/clone3/clone3_selftests.h |  38 ++++++
>  2 files changed, 171 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 26221661e9ae..81c2e8648e8b 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -3,6 +3,7 @@
>  /* Based on Christian Brauner's clone3() example */
>  
>  #define _GNU_SOURCE
> +#include <asm/mman.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <linux/types.h>
> @@ -11,6 +12,7 @@
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/mman.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/un.h>
> @@ -19,8 +21,12 @@
>  #include <sched.h>
>  
>  #include "../kselftest.h"
> +#include "../ksft_shstk.h"
>  #include "clone3_selftests.h"
>  
> +static bool shadow_stack_supported;
> +static size_t max_supported_args_size;
> +
>  enum test_mode {
>  	CLONE3_ARGS_NO_TEST,
>  	CLONE3_ARGS_ALL_0,
> @@ -28,6 +34,10 @@ enum test_mode {
>  	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
>  	CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
>  	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
> +	CLONE3_ARGS_SHADOW_STACK,
> +	CLONE3_ARGS_SHADOW_STACK_NO_SIZE,
> +	CLONE3_ARGS_SHADOW_STACK_NO_POINTER,
> +	CLONE3_ARGS_SHADOW_STACK_NO_TOKEN,
>  };
>  
>  typedef bool (*filter_function)(void);
> @@ -44,6 +54,44 @@ struct test {
>  	filter_function filter;
>  };
>  
> +
> +/*
> + * We check for shadow stack support by attempting to use
> + * map_shadow_stack() since features may have been locked by the
> + * dynamic linker resulting in spurious errors when we attempt to
> + * enable on startup.  We warn if the enable failed.
> + */
> +static void test_shadow_stack_supported(void)
> +{
> +	long ret;
> +
> +	ret = syscall(__NR_map_shadow_stack, 0, getpagesize(), 0);
> +	if (ret == -1) {
> +		ksft_print_msg("map_shadow_stack() not supported\n");
> +	} else if ((void *)ret == MAP_FAILED) {
> +		ksft_print_msg("Failed to map shadow stack\n");
> +	} else {
> +		ksft_print_msg("Shadow stack supportd\n");

typo: supportd -> supported

> +		shadow_stack_supported = true;
> +
> +		if (!shadow_stack_enabled)
> +			ksft_print_msg("Mapped but did not enable shadow stack\n");
> +	}
> +}

On my CET system, this reports:

  ...
  # clone3() syscall supported
  # Shadow stack supportd
  # Running test 'simple clone3()'
  ...

(happily doesn't print "Mapped but did not enable ...").

> +
> +static unsigned long long get_shadow_stack_page(unsigned long flags)
> +{
> +	unsigned long long page;
> +
> +	page = syscall(__NR_map_shadow_stack, 0, getpagesize(), flags);
> +	if ((void *)page == MAP_FAILED) {
> +		ksft_print_msg("map_shadow_stack() failed: %d\n", errno);
> +		return 0;
> +	}
> +
> +	return page;
> +}
> +
>  static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>  {
>  	struct __clone_args args = {
> @@ -89,6 +137,21 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>  	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
>  		args.exit_signal = 0x00000000000000f0ULL;
>  		break;
> +	case CLONE3_ARGS_SHADOW_STACK:
> +		/* We need to specify a normal stack too to avoid corruption */
> +		args.shadow_stack = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
> +		args.shadow_stack_size = getpagesize();
> +		break;

  # Running test 'Shadow stack on system with shadow stack'
  # [5496] Trying clone3() with flags 0 (size 0)
  # I am the parent (5496). My child's pid is 5505
  # Child exited with signal 11
  # [5496] clone3() with flags says: 11 expected 0
  # [5496] Result (11) is different than expected (0)
  not ok 20 Shadow stack on system with shadow stack

The child segfaults immediately, it seems?

> +	case CLONE3_ARGS_SHADOW_STACK_NO_POINTER:
> +		args.shadow_stack_size = getpagesize();
> +		break;

  # Running test 'Shadow stack with no pointer'
  # [5496] Trying clone3() with flags 0 (size 0)
  # Invalid argument - Failed to create new process
  # [5496] clone3() with flags says: -22 expected -22
  ok 21 Shadow stack with no pointer

This seems like it misses the failure and reports ok

> +	case CLONE3_ARGS_SHADOW_STACK_NO_SIZE:
> +		args.shadow_stack = get_shadow_stack_page(SHADOW_STACK_SET_TOKEN);
> +		break;

  # Running test 'Shadow stack with no size'
  # [5496] Trying clone3() with flags 0 (size 0)
  # Invalid argument - Failed to create new process
  # [5496] clone3() with flags says: -22 expected -22
  ok 22 Shadow stack with no size

Same?

> +	case CLONE3_ARGS_SHADOW_STACK_NO_TOKEN:
> +		args.shadow_stack = get_shadow_stack_page(0);
> +		args.shadow_stack_size = getpagesize();
> +		break;

This actually segfaults the parent:

  # Running test 'Shadow stack with no token'
  # [5496] Trying clone3() with flags 0x100 (size 0)
  # I am the parent (5496). My child's pid is 5507
  Segmentation fault

Let me know what would be most helpful to dig into more...

-- 
Kees Cook

