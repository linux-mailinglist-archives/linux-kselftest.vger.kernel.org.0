Return-Path: <linux-kselftest+bounces-14716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DB99460CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 17:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FCF1F21297
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1547136347;
	Fri,  2 Aug 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qquajbMG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB2136341;
	Fri,  2 Aug 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613702; cv=none; b=E9Xk8WszZj2wiRd+iEa7/cGSAHj22IybOu8hggluZjZg35KtWiAWdPUF5loGvjJ5EyWNoa9ztZs5/LGGRZXj06RcRN/DgBCEjRF8X9cERlF05SfOewExaFEypEmwDlQR+UrvB8nKW3pSqLPGGCMM43LNUPdAXg9dD5eGn6HsrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613702; c=relaxed/simple;
	bh=laWMCHNuzj/wltnWdMcvnIWeUr5J4xYYVvmfO2V8pJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiDGr7gFvxb1eMYFvgpKOR8v+ex8KEkOZwcTgjf9xLTJQ0wT7iP1dNRrFGZF64PFQRR1yt5Tbs+ZeYcxknzCrT6Ty199jCbSJW7zMc7CvC9zqZxkYD6zxPzFOz7bpL0L8V+g65Xxh78msSl8qF8rFhgjeyp0Lp5ovnXNvDJXBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qquajbMG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722613694;
	bh=laWMCHNuzj/wltnWdMcvnIWeUr5J4xYYVvmfO2V8pJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qquajbMGP2Bg8S3BzEO8ua3hM5ge0zHj3AFXbU/AXIuiWBTkkCb2HHyt2238G5oNy
	 HoPl3mxbEve8z32F8Vnhw60E6faXkfO6Qir+IRpha/GpcNfamssev2GtMjg6KHwfX2
	 7dAH8J5dNaiLN+vSSvfD08riadDBBHwAIS/wgC6I=
Date: Fri, 2 Aug 2024 17:48:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add support for [v]sscanf()
Message-ID: <5db920e0-51e8-48d9-b0ae-95479e875fad@t-8ch.de>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
 <20240731-nolibc-scanf-v1-1-f71bcc4abb9e@weissschuh.net>
 <3956cee8-1623-42d6-bbc6-71b5abd67759@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3956cee8-1623-42d6-bbc6-71b5abd67759@linuxfoundation.org>

On 2024-07-31 17:01:09+0000, Shuah Khan wrote:
> On 7/31/24 12:32, Thomas Weißschuh wrote:
> > The implementation is limited and only supports numeric arguments.
> 
> I would like to see more information in here. Why is this needed
> etc. etc.

Ack.

> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
> >   tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
> >   2 files changed, 152 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index c968dbbc4ef8..d63c45c06d8e 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> > @@ -348,6 +348,99 @@ int printf(const char *fmt, ...)
> >   	return ret;
> >   }
> > +static __attribute__((unused))
> > +int vsscanf(const char *str, const char *format, va_list args)
> 
> Is there a reason why you didn't use the same code in lib/vsprintf.c?
> You could simply duplicate the code here?

lib/vsprintf.c is GPL-2.0-only while nolibc is LGPL-2.1 OR MIT,
so code reuse isn't really possible.
Furthermore I think the vsprintf.c implements the custom kernel formats,
while nolibc should use posix ones.

> With all these libc functionality added, it isn't nolibc looks like :)

Well :-)

The main motivation is to provide kselftests compatibility.
Maybe Willy disagrees.

> > +{
> > +	uintmax_t uval;
> > +	intmax_t ival;
> > +	int base;
> > +	char *endptr;
> > +	int matches;
> > +	int lpref;
> > +
> > +	matches = 0;
> > +
> > +	while (1) {
> > +		if (*format == '%') {
> > +			lpref = 0;
> > +			format++;
> > +
> > +			if (*format == 'l') {
> > +				lpref = 1;
> > +				format++;
> > +				if (*format == 'l') {
> > +					lpref = 2;
> > +					format++;
> > +				}
> > +			}
> > +
> > +			if (*format == '%') {
> > +				if ('%' != *str)
> > +					goto done;
> > +				str++;
> > +				format++;
> > +				continue;
> > +			} else if (*format == 'd') {
> > +				ival = strtoll(str, &endptr, 10);
> > +				if (lpref == 0)
> > +					*va_arg(args, int *) = ival;
> > +				else if (lpref == 1)
> > +					*va_arg(args, long *) = ival;
> > +				else if (lpref == 2)
> > +					*va_arg(args, long long *) = ival;
> > +			} else if (*format == 'u' || *format == 'x' || *format == 'X') {
> > +				base = *format == 'u' ? 10 : 16;
> > +				uval = strtoull(str, &endptr, base);
> > +				if (lpref == 0)
> > +					*va_arg(args, unsigned int *) = uval;
> > +				else if (lpref == 1)
> > +					*va_arg(args, unsigned long *) = uval;
> > +				else if (lpref == 2)
> > +					*va_arg(args, unsigned long long *) = uval;
> > +			} else if (*format == 'p') {
> > +				*va_arg(args, void **) = (void *)strtoul(str, &endptr, 16);
> > +			} else {
> > +				SET_ERRNO(EILSEQ);
> > +				goto done;
> > +			}
> > +
> > +			format++;
> > +			str = endptr;
> > +			matches++;
> > +
> > +		} else if (*format == '\0') {
> > +			goto done;
> > +		} else if (isspace(*format)) {
> > +			while (isspace(*format))
> > +				format++;
> > +			while (isspace(*str))
> > +				str++;
> > +		} else if (*format == *str) {
> > +			format++;
> > +			str++;
> > +		} else {
> > +			if (!matches)
> > +				matches = EOF;
> > +			goto done;
> > +		}
> > +	}
> > +
> > +done:
> > +	return matches;
> > +}
> > +
> > +static __attribute__((unused, format(scanf, 2, 3)))
> > +int sscanf(const char *str, const char *format, ...)
> > +{
> > +	va_list args;
> > +	int ret;
> > +
> > +	va_start(args, format);
> > +	ret = vsscanf(str, format, args);
> > +	va_end(args);
> > +	return ret;
> > +}
> > +
> >   static __attribute__((unused))
> >   void perror(const char *msg)
> >   {
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 093d0512f4c5..addbceb0b276 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1277,6 +1277,64 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
> >   	return ret;
> >   }
> > +static int test_scanf(void)
> > +{
> > +	unsigned long long ull;
> > +	unsigned long ul;
> > +	unsigned int u;
> > +	long long ll;
> > +	long l;
> > +	void *p;
> > +	int i;
> > +
> > +	if (sscanf("", "foo") != EOF)
> > +		return 1;
> > +
> > +	if (sscanf("foo", "foo") != 0)
> > +		return 2;
> > +
> > +	if (sscanf("123", "%d", &i) != 1)
> > +		return 3;
> > +
> > +	if (i != 123)
> > +		return 4;
> > +
> > +	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
> > +		return 5;
> > +
> > +	if (i != 123)
> > +		return 6;
> > +
> > +	if (u != 456)
> > +		return 7;
> > +
> > +	if (p != (void *)0x90)
> > +		return 8;
> > +
> > +	if (sscanf("a    b1", "a b%d", &i) != 1)
> > +		return 9;
> > +
> > +	if (i != 1)
> > +		return 10;
> > +
> > +	if (sscanf("a%1", "a%%%d", &i) != 1)
> > +		return 11;
> > +
> > +	if (i != 1)
> > +		return 12;
> > +
> > +	if (sscanf("1|2|3|4|5|6",
> > +		   "%d|%ld|%lld|%u|%lu|%llu",
> > +		   &i, &l, &ll, &u, &ul, &ull) != 6)
> > +		return 13;
> > +
> > +	if (i != 1 || l != 2 || ll != 3 ||
> > +	    u != 4 || ul != 5 || ull != 6)
> > +		return 14;
> > +
> > +	return 0;
> 
> Can we simplify this code? It is hard to read code with too
> many conditions. Maybe defining an array test conditions
> instead of a series ifs.

I tried that and didn't find a way.
Any pointers are welcome.

> > +
> > +
> >   static int run_vfprintf(int min, int max)
> >   {
> >   	int test;
> > @@ -1298,6 +1356,7 @@ static int run_vfprintf(int min, int max)
> >   		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
> >   		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
> >   		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
> > +		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
> >   		case __LINE__:
> >   			return ret; /* must be last */
> >   		/* note: do not set any defaults so as to permit holes above */
> > 
> 
> thanks,
> -- Shuah

