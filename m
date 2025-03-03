Return-Path: <linux-kselftest+bounces-28236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BCA4EC24
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AC51889652
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7A25E83F;
	Tue,  4 Mar 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="XLaSwOOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545D2512FC
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113139; cv=pass; b=p9gus6SfGfIUPrfucQCL4PSZghcNrgX4Zc5mKYPxf+ap7qUHcAtY5SE0QwpG5spgCj3028K3mZ8HOBFw8X6g3NKeEN+OXAKZlrf9gaDwxNZIs6/OznpzjSzGRHhzyK/TkyaIXYF8c2to4Mqo9hRbBNmc3yCkDOa9IMzQn/A0U4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113139; c=relaxed/simple;
	bh=xYs8oQZuRfB0zoSFhmCjBgJ5r8qarpmQYj5NC33B8P8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MWuQP/XQwHdfb7D5T8LS790cYqv71nF/SwWfbgitYsM1P/7T6Cz8MWc3Et6VMWXyqDZwz19tY8JUPdHa8ThPuY72X8wPps8F44vPLpDnoGVM5JMOjG4WzAsfm25wKUBXqcopxYgv02AzbsxZH9Oz/pP43IIXSf5ai+Qy1WbGvGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=XLaSwOOW; arc=none smtp.client-ip=209.85.221.54; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id A965D40CFBBE
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 21:32:15 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=kragniz.eu header.i=@kragniz.eu header.a=rsa-sha256 header.s=google header.b=XLaSwOOW
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h711klrzG3SQ
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 19:32:45 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0F9F342726; Tue,  4 Mar 2025 19:32:28 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=XLaSwOOW
X-Envelope-From: <linux-kernel+bounces-541201-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=XLaSwOOW
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id DB30B42A8D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:56:25 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 22E052DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:56:24 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EF7A4094
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7DD1F0E40;
	Mon,  3 Mar 2025 08:49:47 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E11F03CA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991783; cv=none; b=C9LfG3/JlmzZEbFE35VLQfNZpAkjSd6t0+QVdVfia+VnyIUbm5o5m8L5LdstjGPaOSnUUZpXiEJkJD60lUQGB6ooTunKb6GlrExphYNyrrlr6TEzqDBHXwqYnGFuNnjJdspNMAgYdny81u80WM0p5Dd0FwNX1OJTFpF0B+vQcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991783; c=relaxed/simple;
	bh=xYs8oQZuRfB0zoSFhmCjBgJ5r8qarpmQYj5NC33B8P8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kUlHvvgh60T0WYsxdDmPlNbAZE2gijNg/eX7klajYGwOUX/FYwyDOOFTDVXcB4wu/nWzeGs23l7467V9CYdkHax0hVpanXkSe5ryVpRIv/Bz50sSVYLkt2ZDoxdllnDcfSn6+mMPYxo8Cej87q2iW7F7tcBRxZoLf0qhLXPRN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=XLaSwOOW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390dd35c78dso2695052f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1740991779; x=1741596579; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWOcI3LfOtoqMvDoa0uHK2j1WwNZ7lsxEpbnE3uhycI=;
        b=XLaSwOOWP/FEWlLmfbmsqOV5jRPowbPiJ3EZl/edCkGg+eAbE5exqIl5Vuv+qSjlaz
         Cb/Xjo8cY1THudUUaGCaqntLyqXWCtFPI34GlUAy+TB3eeMQZevxpX1lljrppNYyOEFz
         3qRnDOdYkHGM/1ifzmNak09HszzDjgU87sHVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991779; x=1741596579;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JWOcI3LfOtoqMvDoa0uHK2j1WwNZ7lsxEpbnE3uhycI=;
        b=bYkezG0T2xQtU2R2TlFsCWIndVlgPbdd2VBSMq6+0oDwuwhvpAJ7/qHBHRbmjxxmbU
         ssO/wxKV8G26eF23SWza9JTMNCSZmwCuTG0Uxd8uw1/kaFEUkFaikKSbE5qZx8kPvB/Y
         ZuqPC6iUN5suJYtKAKdhiYkGe9iDQkHwYqjrlvtmQDOtp74ZKAcuL3FT4VadEy5JV1VW
         tLc/qfg1MfM0MD34x1/tdeH4/2QoIHgKlzKbuQ9g+UfXn1XRCl9za36h1K11zJqsGYdy
         WL+xkPZ2ejBixjgpB5FpKlIoFcgomSDLr0JR+4bp0corQcAMs1DFrih7rfzMPPkv5/lq
         LOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWXBoBG9c1VkAOiOU3oUaI628Kdbbpcc1eu3OvRvIi8E4+trjjlVVmCFWMVW8zTB99gBmyTdvhKu9MrWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqAKT0VFu+vU0+yiQzQkRu7ST+D2uhOydi2C+GfFk2QZcWcNW
	vdYznMcRL+6cyDPWIAiFad4TfEl0ZB4d8XPHxWT0n6dDcw53sLrWBjmsV8dJWDU=
X-Gm-Gg: ASbGncuCYug7ErAKdNWoEwNy71+pmFHWrwGF/0Ok5u37PQDHhbK/DZ0V2rtQLWXdUXX
	WT2w1h3xXsAONbCd8axk5aHxtuer+kSTSHmHMx9YffQSF67oZM8EHMv9RX7FVoLoXA44FFsmjri
	uKLsWoegG2WLBfq/EeQu2g7cul8tdZ4+zhmvTsquJKseAjgPdICFnZctEtXMqeJoCbvHOWrnpV1
	92FoYwtfvsKnf/U+IDEUh0OhnWMd3WFKFAQkz0CEypAx+V0Bjacj5H/N7OotyWYTM+rOJIIHV94
	CsQwf9qd8TgncBQ29J8qO5kmu/TBFGSp0bEfEI/PAPx2CzdYWDwbNazMihCtwzih1A==
X-Google-Smtp-Source: AGHT+IHVLjZBMOHPs+saOKuJEuqmctdpDU92+SVxz5HFg3qV39sxng1lBC4zbTnM/QwHjaV0RHgfIQ==
X-Received: by 2002:a5d:5f96:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-390e168d26amr12668179f8f.11.1740991778861;
        Mon, 03 Mar 2025 00:49:38 -0800 (PST)
Received: from localhost (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710c2sm178368295e9.32.2025.03.03.00.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:49:38 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Mar 2025 08:49:37 +0000
Message-Id: <D86I2TBQIPLZ.TCUUJWWM5DMO@kragniz.eu>
From: "Louis Taylor" <louis@kragniz.eu>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Willy Tarreau" <w@1wt.eu>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] tools/nolibc: add support for openat(2)
X-Mailer: aerc 0.18.1
References: <20250302202528.4169024-1-louis@kragniz.eu>
 <d0ed3b0d-4b7d-40cb-bbce-1f2a6605db7f@t-8ch.de>
In-Reply-To: <d0ed3b0d-4b7d-40cb-bbce-1f2a6605db7f@t-8ch.de>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h711klrzG3SQ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717846.30743@l7It5n5CbofUuocEfG7rmw
X-ITU-MailScanner-SpamCheck: not spam

On Sun Mar 2, 2025 at 10:24 PM GMT, Thomas Wei=C3=9Fschuh wrote:
> Hi Louis,
>
> On 2025-03-02 20:25:23+0000, Louis Taylor wrote:
> > openat is useful to avoid needing to construct relative paths, so expos=
e
> > a wrapper for using it directly.
>
> Can you say what you are using nolibc for? I'm curious :-)

An incredibly dumb side project which involves creating a very small
static binary. So far I've also needed a few other functions (for
example clock_gettime) which I've just added local wrappers for, since
I'm not sure if they're in scope for nolibc. If they are, I can also
send patches for those as well.

> > Signed-off-by: Louis Taylor <louis@kragniz.eu>
> > ---
> >  tools/include/nolibc/sys.h                   | 29 ++++++++++++++++++++
> >  tools/testing/selftests/nolibc/nolibc-test.c | 22 +++++++++++++++
> >  2 files changed, 51 insertions(+)
> >=20
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 8f44c33b1213..e5ff34df4aee 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -765,6 +765,35 @@ int mount(const char *src, const char *tgt,
> >  	return __sysret(sys_mount(src, tgt, fst, flags, data));
> >  }
> > =20
> > +/*
> > + * int openat(int dirfd, const char *path, int flags[, mode_t mode]);
> > + */
> > +
> > +static __attribute__((unused))
> > +int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
> > +{
> > +#ifdef __NR_openat
> > +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
> > +#else
> > +	return __nolibc_enosys(__func__, dirfd, path, flags, mode);
> > +#endif
>
> All architectures support openat(), so the #else could be dropped.

I agree, but I followed the existing implementation for sys_open which
only uses openat if it is defined. If openat can be assumed to always
exist, that other #ifdef should be dropped (which I can do in another
patch).

> > +}
> > +
> > +static __attribute__((unused))
> > +int openat(int dirfd, const char *path, int flags, ...)
> > +{
> > +	mode_t mode =3D 0;
> > +
> > +	if (flags & O_CREAT) {
> > +		va_list args;
> > +
> > +		va_start(args, flags);
> > +		mode =3D va_arg(args, int);
>
> mode_t instead of int?

This implementation is yoinked directly from open() below. I have no
opinions, but if it should be changed it should be changed in both
functions.

> > +		va_end(args);
> > +	}
> > +
> > +	return __sysret(sys_openat(dirfd, path, flags, mode));
> > +}
> > =20
> >  /*
> >   * int open(const char *path, int flags[, mode_t mode]);
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testi=
ng/selftests/nolibc/nolibc-test.c
> > index 79c3e6a845f3..97ded6c76f99 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1028,6 +1028,26 @@ int test_rlimit(void)
> >  	return 0;
> >  }
> > =20
> > +int test_openat(void)
>
> static.

I'll change this. Should the other test_ functions in this file also be
static?

> > +{
> > +	int dev;
> > +	int null;
> > +
> > +	dev =3D openat(AT_FDCWD, "/dev", O_DIRECTORY);
> > +	if (dev < 0)
> > +		return -1;
> > +
> > +	null =3D openat(dev, "null", 0);
> > +	if (null < 0) {
> > +		close(dev);
> > +		return -1;
> > +	}
> > +
> > +	close(dev);
> > +	close(null);
> > +
> > +	return 0;
> > +}
> > =20
> >  /* Run syscall tests between IDs <min> and <max>.
> >   * Return 0 on success, non-zero on failure.
> > @@ -1116,6 +1136,8 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); b=
reak;
> >  		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp =3D open("/dev/nul=
l", 0), -1); if (tmp !=3D -1) close(tmp); break;
> >  		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp =3D open("/proc/se=
lf/blah", 0), -1, ENOENT); if (tmp !=3D -1) close(tmp); break;
> > +		CASE_TEST(openat_fdcwd);      EXPECT_SYSNE(1, tmp =3D openat(AT_FDCW=
D, "/dev/null", 0), -1); if (tmp !=3D -1) close(tmp); break;
>
> AT_FDCWD is already used in test_openat(). What additional value does
> the test above add?

None, I just wrote that one first before thinking about how I'd test
opening something relative to an fd. I'll drop it.

>
> > +		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); br=
eak;
> >  		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
> >  		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); bre=
ak;
> >  		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds =
=3D { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
> > --=20
> > 2.45.2
> >=20



