Return-Path: <linux-kselftest+bounces-36892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2104AAFF3D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127E53A830F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F5224AFE;
	Wed,  9 Jul 2025 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qvhPs8jp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5C2185B1
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096101; cv=none; b=Y9rwlmWLpVm5sXSCvnA7ieqb1CDPOMiRzE2gPo3qwUCqIwddFOCAGCk54AfK3Hy1/rheuHb7885C1xrM6vpesIAHJIFUmuKJKZD3R5CTanxLGgOAHThYSnvNbcxDBqVsK2Dn72tf0L42ixpFGltGdutfpHjrcCU75JA/LbphEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096101; c=relaxed/simple;
	bh=dP367fUd28amdqfJPIo3DgT0c9fgqhV7yXceinDaOP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANCLh6VNcjFc7UYGhSVy8wqKl12KNIYyG8v1TsnGE7FaYRCm0iJQFH+9I8vL7nXnCdSQ2+WrxffqgCl7vj+a1i8+DS5d2jnFzZJiX5X3xH83mBi/T3qrvMYCE50YKtJ2jFJQoCejrvCFG5ZJNYfCw/sQ4v5C5/nB1uL7tIsQyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qvhPs8jp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752096097;
	bh=dP367fUd28amdqfJPIo3DgT0c9fgqhV7yXceinDaOP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvhPs8jpQhPoLM2li+k4GoegrDQrH8a/O/GVSwgNQ4IblCz2ccXWadDsK8Bcs8W1H
	 FHQeFtJo7QUkk49wSe7+qbs6HE8iZj0j+1WVo43U7UvKENyXDb2aKMC2pp1KnUFqla
	 vlvtD+/RHGI6ouqvFxQ0ow7ST6XVQldpF4gFgl24=
Date: Wed, 9 Jul 2025 23:21:37 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 3/3] tools/nolibc: add signal support
Message-ID: <7a524c29-6d2e-4676-82cb-28b0af76e1b7@t-8ch.de>
References: <20250709155512.971080-1-benjamin@sipsolutions.net>
 <20250709155512.971080-4-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709155512.971080-4-benjamin@sipsolutions.net>

On 2025-07-09 17:55:12+0200, Benjamin Berg wrote:
(...)

> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1270,6 +1270,72 @@ int test_namespace(void)
>  	return ret;
>  }
>  
> +sig_atomic_t signal_check;

static?

> +
> +static void sighandler(int signum)
> +{
> +	if (signum == SIGUSR1) {
> +		kill(getpid(), SIGUSR2);
> +		signal_check = 1;
> +	} else {
> +		signal_check++;
> +	}

This could use some operations which make it clearer which steps
occurred in which order. See the constructor tests.

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
> +	sigemptyset(&sa.sa_mask);
> +	sigaddset(&sa.sa_mask, SIGUSR2);

I'd like to see some tests for the sigset functions.

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
> +	/* If signal_check is 1 or higher, then signal emission worked */
> +	llen = printf("    signal emission: 1 <= signal_check");
> +	EXPECT_GE(1, signal_check, 1);
> +
> +	/* If it is 2, then signal masking worked */
> +	llen = printf("    signal masking: 2 == signal_check");
> +	EXPECT_EQ(1, signal_check, 2);
> +
> +out:
> +	llen = printf("%d %s", test_idx, "sigaction");
> +	EXPECT_EQ(1, res, 0);

Restore the default handler afterwards?

> +
> +	return ret;
> +}
> +
>  /* Run syscall tests between IDs <min> and <max>.
>   * Return 0 on success, non-zero on failure.
>   */
> @@ -1398,6 +1464,7 @@ int run_syscall(int min, int max)
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

