Return-Path: <linux-kselftest+bounces-223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8777EE311
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 15:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9986EB20B09
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99342168BC;
	Thu, 16 Nov 2023 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XtY+YwJk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EACB196;
	Thu, 16 Nov 2023 06:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700145594;
	bh=yrmKvsI+CnrWZRR/QLp4Qs3fYtF932zZA3HDcQg5SQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtY+YwJkr3U5KhDeW3j3Gi7Jn3iFCA57xrpl5EWp8VuDJ2wEqkHPYbhwKjGJRRvYN
	 6cONdCXXdxBOpjweBZHYmBu3KYbDz0ctgcQwkdy1dAfwg5NensWMEvzFRsJu4Tq4G2
	 uhX8tYolPkSWKgms2sdoqNh8I2yjjuW5RhCBczL4=
Date: Thu, 16 Nov 2023 15:39:54 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] selftests/nolibc: add custom test harness
Message-ID: <93f771cb-4db1-4b16-ab02-f777894e3620@t-8ch.de>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
 <20231115-nolibc-harness-v1-1-4d61382d9bf3@weissschuh.net>
 <ZVXBxuymJYDUNdvs@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVXBxuymJYDUNdvs@1wt.eu>

On 2023-11-16 08:16:22+0100, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Wed, Nov 15, 2023 at 10:08:19PM +0100, Thomas Weißschuh wrote:
> > The harness provides a framework to write unit tests for nolibc itself
> > and kernel selftests using nolibc.
> > 
> > Advantages over the current harness:
> > * Makes it possible to emit KTAP for integration into kselftests.
> > * Provides familiarity with the kselftest harness and google test.
> > * It is nicer to write testcases that are longer than one line.
> > 
> > Design goals:
> > * Compatibility with nolibc. kselftest-harness requires setjmp() and
> >   signals which are not supported on nolibc.
> > * Provide the same output as the existing unittests.
> > * Provide a way to emit KTAP.
> > 
> > Notes:
> > * This differs from kselftest-harness in its support for test suites,
> >   the same as google test.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Nice intro to present the benefits, but you forgot to explain what
> the patch itself does among these points, the decisions you took,
> tradeoffs if any etc. All of these are particularly important so as
> to figure what to expect from the patch itself, because, tob be
> honest, for me it's a bit difficult to estimate the suitability of
> the code for a given purpose, thus for now I'll mostly focus on
> general code.

Good points. I'll expand more in v2 after we are through this round.

> A few comments below:
> 
> > +static void putcharn(char c, size_t n)
> > +{
> > +	char buf[64];
> > +
> > +	memset(buf, c, n);
> > +	buf[n] = '\0';
> > +	fputs(buf, stdout);
> > +}
> 
> You should really check that n < 64 here, not only because it's test
> code that will trigger about any possible bug around, but also because
> you want others to easily contribute and not get trapped by calling
> this with a larger value without figuring it will do whatever. And
> that way you can remove the tests from the callers which don't need
> to hard-code this limit.

Ack.

> 
> > +#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> > +#define is_pointer_type(var)	(__builtin_classify_type(var) == 5)
> 
> The hard-coded "5" above should either be replaced with pointer_type_class
> (if available here) or left as-is with a comment at the end of the line
> saying e.g. "// pointer_type_class" so that the value can be looked up
> more easily if needed.

Ack.

