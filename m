Return-Path: <linux-kselftest+bounces-203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31907EDBD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 08:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002E91C208FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 07:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8049C2C0;
	Thu, 16 Nov 2023 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF94DA;
	Wed, 15 Nov 2023 23:16:35 -0800 (PST)
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 3AG7GMdZ007436;
	Thu, 16 Nov 2023 08:16:22 +0100
Date: Thu, 16 Nov 2023 08:16:22 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] selftests/nolibc: add custom test harness
Message-ID: <ZVXBxuymJYDUNdvs@1wt.eu>
References: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
 <20231115-nolibc-harness-v1-1-4d61382d9bf3@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115-nolibc-harness-v1-1-4d61382d9bf3@weissschuh.net>

Hi Thomas,

On Wed, Nov 15, 2023 at 10:08:19PM +0100, Thomas Weiﬂschuh wrote:
> The harness provides a framework to write unit tests for nolibc itself
> and kernel selftests using nolibc.
> 
> Advantages over the current harness:
> * Makes it possible to emit KTAP for integration into kselftests.
> * Provides familiarity with the kselftest harness and google test.
> * It is nicer to write testcases that are longer than one line.
> 
> Design goals:
> * Compatibility with nolibc. kselftest-harness requires setjmp() and
>   signals which are not supported on nolibc.
> * Provide the same output as the existing unittests.
> * Provide a way to emit KTAP.
> 
> Notes:
> * This differs from kselftest-harness in its support for test suites,
>   the same as google test.
>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Nice intro to present the benefits, but you forgot to explain what
the patch itself does among these points, the decisions you took,
tradeoffs if any etc. All of these are particularly important so as
to figure what to expect from the patch itself, because, tob be
honest, for me it's a bit difficult to estimate the suitability of
the code for a given purpose, thus for now I'll mostly focus on
general code.

A few comments below:

> +static void putcharn(char c, size_t n)
> +{
> +	char buf[64];
> +
> +	memset(buf, c, n);
> +	buf[n] = '\0';
> +	fputs(buf, stdout);
> +}

You should really check that n < 64 here, not only because it's test
code that will trigger about any possible bug around, but also because
you want others to easily contribute and not get trapped by calling
this with a larger value without figuring it will do whatever. And
that way you can remove the tests from the callers which don't need
to hard-code this limit.

> +#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> +#define is_pointer_type(var)	(__builtin_classify_type(var) == 5)

The hard-coded "5" above should either be replaced with pointer_type_class
(if available here) or left as-is with a comment at the end of the line
saying e.g. "// pointer_type_class" so that the value can be looked up
more easily if needed.

Willy

