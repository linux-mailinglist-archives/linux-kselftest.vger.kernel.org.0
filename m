Return-Path: <linux-kselftest+bounces-8815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229998B15BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535961C21E39
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AC15885C;
	Wed, 24 Apr 2024 22:02:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD0157474;
	Wed, 24 Apr 2024 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996173; cv=none; b=mXl/a3+0uz1DjaAdW8W7nj3cq7KNwQf+bh5/Cf6XaL6GLkw60Qaz3RIcbZh/wXaKjBjZ+ztyLbJQhquC8Oaz2b5BNkx6NN0BsE4usbKiDP5nmnIqsdzwCkf2WeqVxvUgOYywQHjJpnR08Z54/tshSlQENv52k5I+7pMWA/pgpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996173; c=relaxed/simple;
	bh=889DZ02S6SUVQkUhisDCWyheeMIzXijzcmfyta4BrzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxnUdwm19JGgbGrTE2dw4jAPlfrV/m8zAn1bx3ZtlBHLPNu5W6vka8h6Uka7fjq2Bq/X5R4XXYNlKuM/SsAGDKGbAZhgWEQrP5WFAHBRh1MLhBHnfdjrWFTgxI4QzDUK+EPI0Pz2PbMQKWhO7RLXeaQf1GJYce93JAGdO6Ek2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 43OM2bnN010288;
	Thu, 25 Apr 2024 00:02:37 +0200
Date: Thu, 25 Apr 2024 00:02:37 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: disable brk()/sbrk() tests on musl
Message-ID: <20240424220237.GA10281@1wt.eu>
References: <20240424-nolibc-musl-brk-v1-1-b49882dd9a93@weissschuh.net>
 <20240424021313.GA7774@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424021313.GA7774@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 24, 2024 at 04:13:13AM +0200, Willy Tarreau wrote:
> On Wed, Apr 24, 2024 at 12:15:33AM +0200, Thomas Weiﬂschuh wrote:
> > On musl calls to brk() and sbrk() always fail with ENOMEM.
> > Detect this and skip the tests on musl.
> > 
> > Tested on glibc 2.39 and musl 1.2.5 in addition to nolibc.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 94bb6e11c16f..89be9ba95179 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -942,6 +942,7 @@ int run_syscall(int min, int max)
> >  	int ret = 0;
> >  	void *p1, *p2;
> >  	int has_gettid = 1;
> > +	int has_brk;
> >  
> >  	/* <proc> indicates whether or not /proc is mounted */
> >  	proc = stat("/proc", &stat_buf) == 0;
> > @@ -954,6 +955,9 @@ int run_syscall(int min, int max)
> >  	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
> >  #endif
> >  
> > +	/* on musl setting brk()/sbrk() always fails */
> > +	has_brk = brk(0) == 0;
> > +
> >  	for (test = min; test >= 0 && test <= max; test++) {
> >  		int llen = 0; /* line length */
> >  
> > @@ -969,9 +973,9 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
> >  		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
> >  		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESRCH); break;
> > -		CASE_TEST(sbrk_0);            EXPECT_PTRNE(1, sbrk(0), (void *)-1); break;
> > -		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
> > -		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
> > +		CASE_TEST(sbrk_0);            EXPECT_PTRNE(has_brk, sbrk(0), (void *)-1); break;
> > +		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(has_brk, (p2 == (void *)-1) || p2 == p1); break;
> > +		CASE_TEST(brk);               EXPECT_SYSZR(has_brk, brk(sbrk(0))); break;
> >  		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
> >  		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
> >  		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
> 
> Looks good, thank you Thomas!

BTW, Acked-by: Willy Tarreau <w@1wt.eu>

Willy

