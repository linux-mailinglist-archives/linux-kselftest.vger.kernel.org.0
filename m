Return-Path: <linux-kselftest+bounces-36223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AFAF062B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF2916D957
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113F2701BF;
	Tue,  1 Jul 2025 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GmJ3rJea"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6946239573
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407499; cv=none; b=KXrVnmiWoTeWrFcg7jDf6YOse2j6nEliGzMM4NF5NX1TNFlCL9dM2FZzA9bjVUrSs0VVV8Fv0zMGDqkpl+1EKX5guK1uVJwNRB6FGSR8Ke560O/rFAPsWSbp3g4VEUfrPx14kM29DlJzlrb8Gsfwbogdv2ySsinZX3J+JUZDEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407499; c=relaxed/simple;
	bh=to0L7CAI3+dDwrvdS9zgWGoRL9Tdff5CNJR1VIiKfyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOCLAOnr0HrMd69CEQRHM99OsVt7ohmLvYbcAJ0U4pxN3Spb8TEQgQlx6lBlqqvF8S22FwhWR5Osf+qXxAcarg/eQaKIEJjV2UUE20+a+KrKjk7npPWA8la4axqZROnleXaE/G0QXdUA2+xsycnKsA8Cp/CXhGB0BWdTBD8hjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GmJ3rJea; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1751407488;
	bh=to0L7CAI3+dDwrvdS9zgWGoRL9Tdff5CNJR1VIiKfyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmJ3rJeabW1IXX20LcEIMLVA/Qs7nEGl4tAJZMt5r0pL5ZkIQD0M0JpTtNj9vqNoL
	 9ZC2RQlj+8zoTHVeJcnWCegsKM9XjMdirElh9zh1sSqgzt8dZiWtFUYICe24I/WgrT
	 pOUJqNr0f6VgoZUV71fc9rZCA8IZdtdlpc7vOro4=
Date: Wed, 2 Jul 2025 00:04:47 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [RFC v2] tools/nolibc: add sigaction()
Message-ID: <21cf1fee-21ce-43b2-95cc-18aa58adcd87@t-8ch.de>
References: <20250701122910.45823-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701122910.45823-1-benjamin@sipsolutions.net>

Hi Benjamin,

Thanks for your patch!

On 2025-07-01 14:29:10+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>

Please send the next revisions to the nolibc maintainers from the
MAINTAINERS file. Willy and my @weissschuh.net address.

> In preparation to add tests that use it.

Here "tests" is not clear about its meaning.

> Note that some architectures do not have a usable linux/signal.h include
> file. However, in those cases we can use asm-generic/signal.h instead.

This should explain what "unusable" means.

> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> 
> Another attempt at signal handling for nolibc which should actually be
> working. Some trickery is needed to get the right definition, but I feel
> it is sufficiently clean this way.
> 
> Submitting this as RFC mostly because I do not yet have a proper patch
> to add a test that uses the feature.

We do pick up new features in nolibc without them having in-kernel users.
So if you want to get this in already you can drop the RFC state.

> Benjamin
> ---
>  tools/include/nolibc/arch-aarch64.h          |  3 +

In nolibc/for-next, arch-aarch64.h is now called arch-arm64.h.

https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/log/?h=for-next

>  tools/include/nolibc/arch-arm.h              |  7 ++
>  tools/include/nolibc/arch-i386.h             | 13 +++

... and arch-i386.h was renamed to arch-x86.h

>  tools/include/nolibc/arch-loongarch.h        |  3 +
>  tools/include/nolibc/arch-m68k.h             | 10 ++
>  tools/include/nolibc/arch-mips.h             |  3 +
>  tools/include/nolibc/arch-powerpc.h          |  8 ++
>  tools/include/nolibc/arch-riscv.h            |  3 +
>  tools/include/nolibc/arch-s390.h             |  8 +-
>  tools/include/nolibc/arch-sparc.h            | 43 +++++++++
>  tools/include/nolibc/arch-x86_64.h           | 10 ++

same for arch-x86_64.h, Unlucky timing.

>  tools/include/nolibc/signal.h                | 97 ++++++++++++++++++++
>  tools/include/nolibc/sys.h                   |  2 +-
>  tools/include/nolibc/time.h                  |  3 +-
>  tools/testing/selftests/nolibc/nolibc-test.c | 52 +++++++++++
>  15 files changed, 261 insertions(+), 4 deletions(-)

<snip>

> --- a/tools/include/nolibc/arch-i386.h
> +++ b/tools/include/nolibc/arch-i386.h
> @@ -10,6 +10,19 @@
>  #include "compiler.h"
>  #include "crt.h"
>  
> +/* Needed to get the correct struct sigaction definition */
> +#define SA_RESTORER	0x04000000
> +
> +/* Restorer must be set on i386 */
> +#define _NOLIBC_ARCH_NEEDS_SA_RESTORER
> +
> +/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
> +#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
> +
> +/* Avoid linux/signal.h, it has an incorrect _NSIG and sigset_t */
> +#include <asm-generic/signal.h>
> +#include <asm-generic/siginfo.h>

This doesn't work if the user already has <linux/signal.h> included for
some other reason. The symbol names will conflict.

Can we do something like this:

#include <linux/signal.h>

/* lifted from asm-generic/signal.h */
struct __nolibc_sigaction {
	__sighandler_t sa_handler;
	unsigned long sa_flags;
#ifdef SA_RESTORER
	__sigrestore_t sa_restorer;
#endif
	__nolibc_sigset_t sa_mask;
};

int sys_rt_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
{
	struct __nolibc_sigaction nolibc_act, nolibc_oldact;
	int ret;

	/* Convert whatever gunk we got from linux/signal.h to what the
	 * kernel actually expects. If it is the same structure,
	 * hopefully the compiler manages to optimize it away.
	 * See __nolibc_user_timespec_to_kernel() et al.
	 * (Comment not meant to be copied verbatim)
	 */
	__nolibc_sigaction_user_to_kernel(act, &nolibc_act);

#if defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER)
...
#endif

	ret = my_syscall4(__NR_rt_sigaction, signum, &nolibc_act, &nolibc_oldact, sizeof(nolibc_act->sa_mask));

	__nolibc_sigaction_kernel_to_user(&nolibc_oldact, oldact);

	return ret;
}

Or am I missing something?

> +
>  /* Syscalls for i386 :
>   *   - mostly similar to x86_64
>   *   - registers are 32-bit

<snip>

> --- a/tools/include/nolibc/arch-sparc.h
> +++ b/tools/include/nolibc/arch-sparc.h
> @@ -12,6 +12,19 @@
>  #include "compiler.h"
>  #include "crt.h"
>  
> +/* Otherwise we would need to use sigreturn instead of rt_sigreturn */
> +#define _NOLIBC_ARCH_FORCE_SIG_FLAGS SA_SIGINFO
> +
> +/* The includes are sane, if one sets __WANT_POSIX1B_SIGNALS__ */
> +#define __WANT_POSIX1B_SIGNALS__
> +#include <linux/signal.h>

This also assumes the user did not already include <linux/signal.h>
before including nolibc.

> +
> +/*
> + * sparc has ODD_RT_SIGACTION, we always pass our restorer as an argument
> + * to rt_sigaction. The restorer is implemented in this file.
> + */
> +#define _NOLIBC_RT_SIGACTION_PASSES_RESTORER
> +
>  /*
>   * Syscalls for SPARC:
>   *   - registers are native word size
> @@ -188,4 +201,34 @@ pid_t sys_fork(void)
>  }
>  #define sys_fork sys_fork
>  
> +#define __nolibc_stringify_1(x...)     #x
> +#define __nolibc_stringify(x...)       __stringify_1(x)

If we need this, IMO it belongs into compiler.h.

> +
> +/* The compiler insists on adding a SAVE call to the start of every function */
> +#define __nolibc_sa_restorer __nolibc_sa_restorer
> +void __nolibc_sa_restorer (void);
> +#ifdef __arch64__
> +__asm__(                                                        \

We are avoiding bare toplevel asm calls.
You could use the same trick as my SuperH _start() function and use
asm() inside a function.

https://lore.kernel.org/lkml/20250623-nolibc-sh-v2-3-0f5b4b303025@weissschuh.net/

> +	".section .text\n"                                      \
> +	".align  4 \n"                                          \
> +	"__nolibc_sa_restorer:\n"                               \
> +	"nop\n"                                                 \
> +	"nop\n"                                                 \
> +	"mov     " __stringify(__NR_rt_sigreturn) ", %g1 \n"    \
> +	"t       0x6d \n");
> +#else
> +__asm__(                                                        \
> +	".section .text\n"                                      \
> +	".align  4 \n"                                          \
> +	"__nolibc_sa_restorer:\n"                               \
> +	"nop\n"                                                 \
> +	"nop\n"                                                 \
> +	"mov     " __stringify(__NR_rt_sigreturn) ", %g1 \n"    \
> +	"t       0x10 \n"                                       \

Only one line differs. I'd prefer the #ifdef around that.

> +	);
> +#endif
> +
> +#undef __nolibc_stringify_1(x...)
> +#undef __nolibc_stringify

And there is no need to undef it again.

> +
>  #endif /* _NOLIBC_ARCH_SPARC_H */
> diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
> index 67305e24dbef..9f13a2205876 100644

<snip>

> --- a/tools/include/nolibc/signal.h
> +++ b/tools/include/nolibc/signal.h
> @@ -14,6 +14,8 @@
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> +#include "string.h"
> +/* signal definitions are included by arch.h */
>  
>  /* This one is not marked static as it's needed by libgcc for divide by zero */
>  int raise(int signal);
> @@ -23,4 +25,99 @@ int raise(int signal)
>  	return sys_kill(sys_getpid(), signal);
>  }
>  
> +/*
> + * sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
> + */
> +#if defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER) && !defined(__nolibc_sa_restorer)
> +static __attribute__((noreturn)) __nolibc_entrypoint __no_stack_protector

__attribute__((noreturn)) is not always available and should be behind
__nolibc_has_attribute(). 
I'm a bit unhappy about reusing the entrypoint machinery, but I guess
it's necessary.

> +void __nolibc_sa_restorer(void)
> +{
> +	my_syscall0(__NR_rt_sigreturn);
> +	__nolibc_entrypoint_epilogue();
> +}
> +#endif
> +
> +static __attribute__((unused))
> +int sys_rt_sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
> +{
> +	struct sigaction real_act = *act;
> +#if defined(SA_RESTORER) && defined(_NOLIBC_ARCH_NEEDS_SA_RESTORER)

If _NOLIBC_ARCH_NEEDS_SA_RESTORER is set then SA_RESTORER should also be
present. SA_RESTORER doesn't need to be checked also.
Are there cases where SA_RESTORER is defined but not needed?

> +	if (!(real_act.sa_flags & SA_RESTORER)) {
> +		real_act.sa_flags |= SA_RESTORER;
> +		real_act.sa_restorer = __nolibc_sa_restorer;
> +	}
> +#endif
> +#ifdef _NOLIBC_ARCH_FORCE_SIG_FLAGS
> +	real_act.sa_flags |= _NOLIBC_ARCH_FORCE_SIG_FLAGS;
> +#endif
> +
> +#ifndef _NOLIBC_RT_SIGACTION_PASSES_RESTORER
> +	return my_syscall4(__NR_rt_sigaction, signum, &real_act, oldact,
> +			   sizeof(act->sa_mask));
> +#else
> +	return my_syscall5(__NR_rt_sigaction, signum, &real_act, oldact,
> +			   __nolibc_sa_restorer, sizeof(act->sa_mask));

This calling convention is specific to SPARC, so I prefer it to be in
arch-sparc.h. Alpha also uses 5 arguments for the syscall, but of course
in a different order... (I do have nearly done patches for alpha
support).

Also if a user specified their custom sa_restorer in 'act', that one
should be used, no?

> +#endif
> +}
> +
> +static __attribute__((unused))
> +int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
> +{
> +	return __sysret(sys_rt_sigaction(signum, act, oldact));
> +}
> +
> +/*
> + * int sigemptyset(sigset_t *set)
> + */
> +static __attribute__((unused))
> +int sigemptyset(sigset_t *set)
> +{
> +	memset(set, 0, sizeof(*set));
> +	return 0;
> +}
> +
> +/*
> + * int sigfillset(sigset_t *set)
> + */
> +static __attribute__((unused))
> +int sigfillset(sigset_t *set)
> +{
> +	memset(set, 0xff, sizeof(*set));
> +	return 0;
> +}
> +
> +/*
> + * int sigaddset(sigset_t *set, int signum)
> + */
> +static __attribute__((unused))
> +int sigaddset(sigset_t *set, int signum)
> +{
> +	set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] |=
> +		1UL << ((signum - 1) % (8 * sizeof(set->sig[0])));
> +	return 0;

This is documented to return EINVAL for an invalid signum.

> +}
> +
> +/*
> + * int sigdelset(sigset_t *set, int signum)
> + */
> +static __attribute__((unused))
> +int sigdelset(sigset_t *set, int signum)
> +{
> +	set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] &=
> +		~(1UL << ((signum - 1) % (8 * sizeof(set->sig[0]))));
> +	return 0;
> +}
> +
> +/*
> + * int sigismember(sigset_t *set, int signum)
> + */
> +static __attribute__((unused))
> +int sigismember(sigset_t *set, int signum)
> +{
> +	unsigned long res =
> +		set->sig[(signum - 1) / (8 * sizeof(set->sig[0]))] &
> +			(1UL << ((signum - 1) % (8 * sizeof(set->sig[0]))));
> +	return !!res;
> +}

These are similar to FD_CLR()/FD_SET() etc, no?
Moving both sets of functions to common inline helpers would be nice.

> +
>  #endif /* _NOLIBC_SIGNAL_H */

<snip>

> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index dbe13000fb1a..af66b739ea18 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1750,6 +1750,57 @@ static int run_protection(int min __attribute__((unused)),
>  	}
>  }
>  
> +volatile int signal_check;

Technically this should be sig_atomic_t.
Which can be a typedef to int.

> +void test_sighandler(int signum)
> +{
> +	if (signum == SIGUSR1) {
> +		kill(getpid(), SIGUSR2);
> +		signal_check = 1;
> +	} else {
> +		signal_check++;
> +	}
> +}
> +
> +int run_signal(int min, int max)
> +{
> +	struct sigaction sa = {
> +		.sa_flags = 0,
> +		.sa_handler = test_sighandler,
> +	};
> +	int llen; /* line length */
> +	int ret = 0;
> +	int res;
> +
> +	(void)min;
> +	(void)max;
> +
> +	signal_check = 0;
> +
> +	sigemptyset(&sa.sa_mask);
> +	sigaddset(&sa.sa_mask, SIGUSR2);

It would be good to do some assertions after sigemptyset() and
sigaddset() to validate the bitfiddling.

> +
> +	res = sigaction(SIGUSR1, &sa, NULL);
> +	llen = printf("register SIGUSR1: %d", res);
> +	EXPECT_EQ(1, 0, res);
> +	res = sigaction(SIGUSR2, &sa, NULL);
> +	llen = printf("register SIGUSR2: %d", res);
> +	EXPECT_EQ(1, 0, res);

Here it would be nice to validate the old action.

> +
> +	/* Trigger the first signal. */
> +	kill(getpid(), SIGUSR1);
> +
> +	/* If signal_check is 1 or higher, then signal emission worked */
> +	llen = printf("signal emission: 1 <= signal_check");
> +	EXPECT_GE(1, signal_check, 1);
> +
> +	/* If it is 2, then signal masking worked */
> +	llen = printf("signal masking: 2 == signal_check");
> +	EXPECT_EQ(1, signal_check, 2);
> +
> +	return ret;
> +}
> +
>  /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
>  int prepare(void)
>  {
> @@ -1815,6 +1866,7 @@ static const struct test test_names[] = {
>  	{ .name = "stdlib",     .func = run_stdlib     },
>  	{ .name = "printf",     .func = run_printf     },
>  	{ .name = "protection", .func = run_protection },
> +	{ .name = "signal",     .func = run_signal },

These 'struct test's are really more test suites.
This testcase can be part of the syscall suite.

>  	{ 0 }
>  };
>  
> -- 
> 2.50.0
> 

