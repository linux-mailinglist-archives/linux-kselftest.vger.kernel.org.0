Return-Path: <linux-kselftest+bounces-31697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE758A9DA1B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D055A7DDA
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 10:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A8218592;
	Sat, 26 Apr 2025 10:32:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B854A11;
	Sat, 26 Apr 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745663544; cv=none; b=Bf8ZLdvRg3E09ti8/qw9AJRbKUyup0+YQjf+CUBEbJZZBI2P69uBKGbsGuNozP3gmoHAZa9OYrTO4pZh/mnV2mVBo2TgL0FuKuiQeaTEos8XGVgtsAqQCejy6uPZ6IH5TLhG3fjESh6o8U2Y9ntjCoI5njlJUt1n8hSXSGf2h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745663544; c=relaxed/simple;
	bh=m31Z+0bhfG048O9BNHlvK19iEVGmN6dHVgGcgE4xlMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5r+OkhSpZRwAy5px3V7T8F+3O4XaKKSppfntoBCPC8GoS/CiBC/1UZnczEs7lACzNjG7rly/vZ3B/0DhoLZVUFKDW1h56u78AGigUgTkupYshk0Qf4pJAfBWdDsfSzFVwFluVuf8mN2uSTKUhWmBbuwAdp7N6oftyOt5pQnFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53QAVwTm018112;
	Sat, 26 Apr 2025 12:31:58 +0200
Date: Sat, 26 Apr 2025 12:31:58 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/15] tools/nolibc: add getrandom()
Message-ID: <20250426103158.GB17549@1wt.eu>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
 <20250423-nolibc-misc-v1-5-a925bf40297b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423-nolibc-misc-v1-5-a925bf40297b@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Wed, Apr 23, 2025 at 05:01:35PM +0200, Thomas Weiﬂschuh wrote:
> --- /dev/null
> +++ b/tools/include/nolibc/sys/random.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * random definitions for NOLIBC
> + * Copyright (C) 2025 Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> + */
> +

Note: don't forget to add your nolibc include here from the other series.

> +#ifndef _NOLIBC_SYS_RANDOM_H
> +#define _NOLIBC_SYS_RANDOM_H
> +
> +#include "../arch.h"
> +#include "../sys.h"
(...)

> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index abe0ae794208762f6d91ad81e902fbf77253a1c1..95d08e9ccf5b3be924548100e9621cd47f39e8c2 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
(...)
> +int test_getrandom(void)
> +{
> +	uint64_t rng = 0;
> +	ssize_t ret;
> +
> +	ret = getrandom(&rng, sizeof(rng), 0);
> +	if (ret != sizeof(rng))
> +		return ret;
> +
> +	if (!rng) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +

Just a thought about this one: in a not-so-distant past, getrandom()
could hang forever when lacking entropy (classical problem when booting
a headless machine having no RNG), and since a recent kernel it turned
to "only" multiple seconds. I'm not seeing any easy solution to this,
but we need to keep an eye on this one, and in case of bad reports,
maybe have this test as an opt-in or something like this. Anyway the
best way to know is to have it right now and wait for reports to
arrive.

Willy

