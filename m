Return-Path: <linux-kselftest+bounces-8748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E3D8AFE37
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63FA284BBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1378101EC;
	Wed, 24 Apr 2024 02:13:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A2125C1;
	Wed, 24 Apr 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924809; cv=none; b=qJAKKvux/FeLLpCYJY4cCiqq96eteayw9V00bP9Eh4lMhPEnKCbTV0q5wjqV/BWT90INBYj/jlcF/PSEP3qqISdmAgpGZHnq0IL2oH8J6jtuQ+hk3TP0sS8UYW3UVfSr/s1Bb6wZOZO91rtbouIoaHMY/4+xkztzG0Y4k3jHYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924809; c=relaxed/simple;
	bh=lUse8f6nu8h1oEGZ9yjkkS7WlVOhsvKS4neUAaFNvl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7GQsNIRSR/46yzKMQichRuyz+5d0FxopCozYGdgPCd2jL8ZbvbrZy76fFwZDamC+5XOH/UP2dljEspXgfH/l80qSIsWCEFr+cobodBrdN8oairC9faZob25RsSh6Y+/3+Db+pypy5LrTTB6RPHL1nRc1wYzZJjdXdEH9U33S8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 43O2DDbW007803;
	Wed, 24 Apr 2024 04:13:13 +0200
Date: Wed, 24 Apr 2024 04:13:13 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: disable brk()/sbrk() tests on musl
Message-ID: <20240424021313.GA7774@1wt.eu>
References: <20240424-nolibc-musl-brk-v1-1-b49882dd9a93@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424-nolibc-musl-brk-v1-1-b49882dd9a93@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 24, 2024 at 12:15:33AM +0200, Thomas Weiﬂschuh wrote:
> On musl calls to brk() and sbrk() always fail with ENOMEM.
> Detect this and skip the tests on musl.
> 
> Tested on glibc 2.39 and musl 1.2.5 in addition to nolibc.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 94bb6e11c16f..89be9ba95179 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -942,6 +942,7 @@ int run_syscall(int min, int max)
>  	int ret = 0;
>  	void *p1, *p2;
>  	int has_gettid = 1;
> +	int has_brk;
>  
>  	/* <proc> indicates whether or not /proc is mounted */
>  	proc = stat("/proc", &stat_buf) == 0;
> @@ -954,6 +955,9 @@ int run_syscall(int min, int max)
>  	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
>  #endif
>  
> +	/* on musl setting brk()/sbrk() always fails */
> +	has_brk = brk(0) == 0;
> +
>  	for (test = min; test >= 0 && test <= max; test++) {
>  		int llen = 0; /* line length */
>  
> @@ -969,9 +973,9 @@ int run_syscall(int min, int max)
>  		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
>  		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
>  		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESRCH); break;
> -		CASE_TEST(sbrk_0);            EXPECT_PTRNE(1, sbrk(0), (void *)-1); break;
> -		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
> -		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
> +		CASE_TEST(sbrk_0);            EXPECT_PTRNE(has_brk, sbrk(0), (void *)-1); break;
> +		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(has_brk, (p2 == (void *)-1) || p2 == p1); break;
> +		CASE_TEST(brk);               EXPECT_SYSZR(has_brk, brk(sbrk(0))); break;
>  		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
>  		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
>  		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;

Looks good, thank you Thomas!

Willy

