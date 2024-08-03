Return-Path: <linux-kselftest+bounces-14767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF573946905
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBCEB21681
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA512B143;
	Sat,  3 Aug 2024 10:16:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE74A2F;
	Sat,  3 Aug 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722680191; cv=none; b=IOBqy4mjkmwH4aYw+ozOhNgn/SX7/gVxT77lQRm9SgYCFoZ/O8YYARSvOJ+BTQAWUTpXfWT6IpVo7EOT4A8DqNT84ROKfU9eVqfJpIG41Wh8cNa/yQbcDIA/1iDlgW2peDSZyGxKin4nvDG+jfwl1v11ZFynf1NP8MfW57k+588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722680191; c=relaxed/simple;
	bh=HTPZJ4SGhjD4vKLrizhvIA6HtB5O7tBYXmfo/h5cv4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq790MZTnJX4jo767+qHRnOxZ/P/g6G31ieDvfbDbX333BT8TW0mjE2TtmJO2s6cgkbyBHMea3qGYKGd5+ptPVuvPBdU2kxnC10GfBd9lXViH+AFqPtYTFK4O5/nBPoRtPRElMCFuZmWqlpglSZLaOwGbtvTGEcrpGuT2iLcccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 473AGPHe029315;
	Sat, 3 Aug 2024 12:16:25 +0200
Date: Sat, 3 Aug 2024 12:16:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add support for [v]sscanf()
Message-ID: <20240803101625.GH29127@1wt.eu>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
 <20240731-nolibc-scanf-v1-1-f71bcc4abb9e@weissschuh.net>
 <3956cee8-1623-42d6-bbc6-71b5abd67759@linuxfoundation.org>
 <5db920e0-51e8-48d9-b0ae-95479e875fad@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5db920e0-51e8-48d9-b0ae-95479e875fad@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 02, 2024 at 05:48:13PM +0200, Thomas Weißschuh wrote:
> > With all these libc functionality added, it isn't nolibc looks like :)
> 
> Well :-)
> 
> The main motivation is to provide kselftests compatibility.
> Maybe Willy disagrees.

No no I'm perfectly fine with adding the functions that developers use
or need to write their test or init tools. I don't have any strong
opinion on scanf(). Just like strtok(), I stopped using it 25 years ago
when I noticed that it never survives code evolutions, lacks a lot of
flexibility and is often strongly tied to your types (more than printf
where you can cast). But I perfectly understand that others are used to
it and would appreciate to have it, for example if it helps with command
line arguments.

> > > +static int test_scanf(void)
> > > +{
> > > +	unsigned long long ull;
> > > +	unsigned long ul;
> > > +	unsigned int u;
> > > +	long long ll;
> > > +	long l;
> > > +	void *p;
> > > +	int i;
> > > +
> > > +	if (sscanf("", "foo") != EOF)
> > > +		return 1;
> > > +
> > > +	if (sscanf("foo", "foo") != 0)
> > > +		return 2;
> > > +
> > > +	if (sscanf("123", "%d", &i) != 1)
> > > +		return 3;
> > > +
> > > +	if (i != 123)
> > > +		return 4;
> > > +
> > > +	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
> > > +		return 5;
> > > +
> > > +	if (i != 123)
> > > +		return 6;
> > > +
> > > +	if (u != 456)
> > > +		return 7;
> > > +
> > > +	if (p != (void *)0x90)
> > > +		return 8;
> > > +
> > > +	if (sscanf("a    b1", "a b%d", &i) != 1)
> > > +		return 9;
> > > +
> > > +	if (i != 1)
> > > +		return 10;
> > > +
> > > +	if (sscanf("a%1", "a%%%d", &i) != 1)
> > > +		return 11;
> > > +
> > > +	if (i != 1)
> > > +		return 12;
> > > +
> > > +	if (sscanf("1|2|3|4|5|6",
> > > +		   "%d|%ld|%lld|%u|%lu|%llu",
> > > +		   &i, &l, &ll, &u, &ul, &ull) != 6)
> > > +		return 13;
> > > +
> > > +	if (i != 1 || l != 2 || ll != 3 ||
> > > +	    u != 4 || ul != 5 || ull != 6)
> > > +		return 14;
> > > +
> > > +	return 0;
> > 
> > Can we simplify this code? It is hard to read code with too
> > many conditions. Maybe defining an array test conditions
> > instead of a series ifs.
> 
> I tried that and didn't find a way.
> Any pointers are welcome.

I think it would be difficult by nature of varargs.

However, since you grouped some expressions, maybe a one-liner comment
between each scanf() to explain the intent of the test would make it
easier to follow. E.g:
    /* test multiple naked numbers */
    ...
    /* test numbers delimited with a character */
    ...
    /* test multiple integer types at once */

etc. This allows the reviewer to more easly re-focus on the test they
were reading.

Willy

