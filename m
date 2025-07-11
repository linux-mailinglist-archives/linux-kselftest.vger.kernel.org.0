Return-Path: <linux-kselftest+bounces-37063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD6B012CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 07:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3817B6D3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 05:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9711B423B;
	Fri, 11 Jul 2025 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XlcbLcRx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060E192D83
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212419; cv=none; b=AqMHrBcfFxx+lNcfp7tIXC8M/YK6A4B2uXZ2+PeYY3hWWjxtpxRMS8a++/AJ/8i52TvaVuNTbWGZQB/aB9c/cn7qLlNnOJZzo1iA2peuldYTArLLzfv9Zlx/44WXym4e4zBslMNZQsZ0cN06X1czoERkisK1h/r62XrX+Jnf+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212419; c=relaxed/simple;
	bh=G2GNS9lC5cay4R36isE6wwS2VCf7shOEeplNv7rYLiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAw6bH5a4Snp4Q3u+nIRkyzxajKU7JMkhGd3+wn3qoFMdO7lR+ATaoz/Kez0IJH7ZN7tp1eK80zRrWeYNLVXQJgfzGh4O94yqqogl9Tm5Ggu3KlkFsIu1Yo9fALU/WrmvrcBWSMiLXYdOHv2Yw1QAJ8PMn2/5zvF2A6PhyKbzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XlcbLcRx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752212414;
	bh=G2GNS9lC5cay4R36isE6wwS2VCf7shOEeplNv7rYLiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlcbLcRxr6WysACdZuGi1b/8aNvW9rOjmrbB50d0hFf03Y1b/Th+SwIcFKfJ19iSh
	 M401PQsUTJLK1beAVINHdumPGve0Jbu1aTA+Knev+aQ2aAuL/qtoEw+miXcrBg7KTZ
	 0xRfNMaZxfLFryBJEb7R23id8Cr+GC45Sp4GybkU=
Date: Fri, 11 Jul 2025 07:40:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 4/4] tools/nolibc: add signal support
Message-ID: <f72ddf71-40e4-49d0-92b6-da219e33bd29@t-8ch.de>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
 <20250710103950.1272379-5-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710103950.1272379-5-benjamin@sipsolutions.net>

On 2025-07-10 12:39:50+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add support for sigaction() and implement the normal sa_mask helpers.
> 
> On many architectures, linux/signal.h pulls in compatibility definitions
> for the old sigaction syscall instead of rt_sigaction. However, the
> kernel can be compiled without support for this compatibility syscall
> and it also results in sa_mask to be too small for realtime signals.
> 
> To work around this, the includes are handled separately for each
> architecture. This way either linux/signal.h or the asm-generic headers
> can be used to get the correct definition for the rt_sigaction syscall
> including sigset_t.

I checked this against my WIP alpha support and there this scheme
breaks. linux/signal.h provides the old compat types but
the asm-generic variant provides an incorrect SIGCHLD.

Any ideas?

> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> 
> v2:
> - Use newly added macros to check signal emission order
> - Add tests for sigset handling
> - Restore the default handler after signal test
> - make signal_check variable static
> 
> v1:
> - Update architecture support (adding sh)
> - Move sparc sys_rt_sigaction logic into its header
> - Add sig_atomic_t
> - Use new BITSET_* macros
> - Move test into syscall suite
> - Various other small changes
> ---
>  tools/include/nolibc/arch-arm.h              |   7 ++
>  tools/include/nolibc/arch-arm64.h            |   3 +
>  tools/include/nolibc/arch-loongarch.h        |   3 +
>  tools/include/nolibc/arch-m68k.h             |  10 ++
>  tools/include/nolibc/arch-mips.h             |   3 +
>  tools/include/nolibc/arch-powerpc.h          |   8 ++
>  tools/include/nolibc/arch-riscv.h            |   3 +
>  tools/include/nolibc/arch-s390.h             |   8 +-
>  tools/include/nolibc/arch-sh.h               |   5 +
>  tools/include/nolibc/arch-sparc.h            |  47 ++++++++
>  tools/include/nolibc/arch-x86.h              |  13 +++
>  tools/include/nolibc/signal.h                | 103 +++++++++++++++++
>  tools/include/nolibc/sys.h                   |   2 +-
>  tools/include/nolibc/time.h                  |   3 +-
>  tools/include/nolibc/types.h                 |   9 ++
>  tools/testing/selftests/nolibc/nolibc-test.c | 115 +++++++++++++++++++
>  16 files changed, 338 insertions(+), 4 deletions(-)
> 

(...)

> diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
> index ac13e53ac31d..16b8b17496bc 100644
> --- a/tools/include/nolibc/signal.h
> +++ b/tools/include/nolibc/signal.h
> @@ -14,6 +14,14 @@
>  #include "arch.h"
>  #include "types.h"
>  #include "sys.h"
> +#include "string.h"

Unnecessary now as memset() is not used anymore.

> +/* other signal definitions are included by arch.h */
> +
> +/* The kernel headers do not provide a sig_atomic_t definition */
> +#ifndef __sig_atomic_t_defined
> +#define __sig_atomic_t_defined 1
> +typedef int sig_atomic_t;
> +#endif

(...)

> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index d612150d2ea3..fcd44b27cd5e 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1293,6 +1293,120 @@ int test_namespace(void)
>  	return ret;
>  }
>  
> +sig_atomic_t signal_check;

Still not static :-)

> +
> +static void sighandler(int signum)
> +{
> +	if (signum == SIGUSR1) {
> +		kill(getpid(), SIGUSR2);
> +		/* The second step has not run because SIGUSR2 is masked */
> +		MARK_STEP_DONE(signal_check, 0);
> +	} else {
> +		MARK_STEP_DONE(signal_check, 1);
> +	}
> +}
> +
> +int test_signals(int test_idx)
> +{
> +	struct sigaction sa = {
> +		.sa_flags = 0,
> +		.sa_handler = sighandler,
> +	};
> +	struct sigaction sa_old = {
> +		/* Anything other than SIG_DFL */
> +		.sa_handler = sighandler,
> +	};
> +	int llen; /* line length */
> +	int ret = 0;
> +	int res;
> +
> +	signal_check = 0;
> +
> +#ifdef NOLIBC
> +	/* Do some checks on sa_mask handling */
> +	sigfillset(&sa.sa_mask);
> +	llen = printf("    sa_mask.sig[0] (full): ");
> +	EXPECT_EQ(1, sa.sa_mask.sig[0],
> +		     ~(__typeof__(sa.sa_mask.sig[0]))0);
> +	llen = printf("    sa_mask.sig[%d] (full): ", (int)_NSIG_WORDS - 1);
> +	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1],
> +		     ~(__typeof__(sa.sa_mask.sig[0]))0);
> +
> +	sigemptyset(&sa.sa_mask);
> +	llen = printf("    sa_mask.sig[0] (empty): ");
> +	EXPECT_EQ(1, sa.sa_mask.sig[0], 0);
> +	llen = printf("    sa_mask.sig[%d] (empty): ", (int)_NSIG_WORDS - 1);
> +	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1], 0);
> +
> +	/* SIGUSR2 is always in the first word */
> +	sigaddset(&sa.sa_mask, SIGUSR2);
> +	llen = printf("    sa_mask.sig[0] (SIGUSR2 set): ");
> +	EXPECT_EQ(1, sa.sa_mask.sig[0], 1 << (SIGUSR2 - 1));
> +
> +	llen = printf("    sa_mask.sig[0] (test SIGUSR2): ");
> +	EXPECT_NZ(1, sigismember(&sa.sa_mask, SIGUSR2));
> +
> +	sigdelset(&sa.sa_mask, SIGUSR2);
> +	llen = printf("    sa_mask.sig[0] (SIGUSR2 unset): ");
> +	EXPECT_ZR(1, sigismember(&sa.sa_mask, SIGUSR2));
> +
> +	/* _NSIG is the highest valid number and may not be in the first word */
> +	sigaddset(&sa.sa_mask, _NSIG);
> +	llen = printf("    sa_mask.sig[%d] (_NSIG set): ", (int)_NSIG_WORDS - 1);
> +	EXPECT_EQ(1, sa.sa_mask.sig[_NSIG_WORDS - 1],
> +		     1UL << (_NSIG - (_NSIG_WORDS - 1) * _NSIG_BPW - 1));
> +
> +	llen = printf("    sa_mask.sig[%d] (test _NSIG): ", (int)_NSIG_WORDS - 1);
> +	EXPECT_NZ(1, sigismember(&sa.sa_mask, _NSIG));
> +
> +	sigdelset(&sa.sa_mask, _NSIG);
> +	llen = printf("    sa_mask.sig[%d] (_NSIG unset): ", (int)_NSIG_WORDS - 1);
> +	EXPECT_ZR(1, sigismember(&sa.sa_mask, _NSIG));
> +#endif

This is more testing than expected, but that's good.
Could you move it to a dedicated test function, gated on "is_nolibc" and
the #ifdef.

> +
> +	/* sa_mask is empty at this point, set SIGUSR2 to verify masking */
> +	sigaddset(&sa.sa_mask, SIGUSR2);
> +
> +	res = sigaction(SIGUSR1, &sa, &sa_old);
> +	llen = printf("    register SIGUSR1: %d", res);
> +	EXPECT_SYSZR(1, res);
> +	if (res)
> +		goto out;
> +
> +	llen = printf("    sa_old.sa_handler: SIG_DFL (%p)", SIG_DFL);
> +	EXPECT_PTREQ(1, SIG_DFL, sa_old.sa_handler);
> +	if (res)
> +		goto out;
> +
> +	res = sigaction(SIGUSR2, &sa, NULL);
> +	llen = printf("    register SIGUSR2: %d", res);
> +	EXPECT_SYSZR(1, res);
> +	if (res)
> +		goto out;
> +
> +	/* Trigger the first signal. */
> +	kill(getpid(), SIGUSR1);
> +
> +	/* Check the two signal handlers ran in the expected order */
> +	llen = printf("    signal emission: ");
> +	EXPECT_STEPS(1, signal_check, 2);
> +
> +out:
> +	sa.sa_handler = SIG_DFL;
> +	res = sigaction(SIGUSR1, &sa, NULL);
> +	llen = printf("    restore SIGUSR1: %d", res);
> +	EXPECT_SYSZR(1, res);
> +
> +	res = sigaction(SIGUSR1, &sa, NULL);

SIGUSR2?

> +	llen = printf("    restore SIGUSR2: %d", res);
> +	EXPECT_SYSZR(1, res);
> +
> +	llen = printf("%d %s", test_idx, "sigaction");
> +	EXPECT_EQ(1, res, 0);
> +
> +	return ret;
> +}
> +
>  /* Run syscall tests between IDs <min> and <max>.
>   * Return 0 on success, non-zero on failure.
>   */
> @@ -1421,6 +1535,7 @@ int run_syscall(int min, int max)
>  		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
>  		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
>  		CASE_TEST(namespace);         EXPECT_SYSZR(euid0 && proc, test_namespace()); break;
> +		case __LINE__:                ret += test_signals(test); break;
>  		case __LINE__:
>  			return ret; /* must be last */
>  		/* note: do not set any defaults so as to permit holes above */
> -- 
> 2.50.0
> 

