Return-Path: <linux-kselftest+bounces-28016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D2A4B9F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBAEA7A7C35
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC011F0E22;
	Mon,  3 Mar 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="XLaSwOOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00A1F0990
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991782; cv=none; b=nvMDtwx4FnFaRcf45fxwIgNv7yhnwXXtqgBSDcDvB4ZOKtsDUis9Uyr4A01YirzSIFncfUV87eu3pLmIw3gJotQQn74nh9B6CEYb6eT5XT4iQkCCTrD+bIWIUHj0iWR2cWkXJ+hOjhTwRZ7urF77U8bBuE/LlSdha7rVDALUIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991782; c=relaxed/simple;
	bh=xYs8oQZuRfB0zoSFhmCjBgJ5r8qarpmQYj5NC33B8P8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Rx7TbHe4Xx4JwvG3iZzLNrYO/KyB8RaJ7SyAgesTv+D1AQPtk0GF76zHg5Gh04IJuEjNKJpI2L0et/m1V+/wjiR5c/to7RoeaJQLHTUG1Tcj24E8Iwwn1swRw39UpvwVCNLFZ+lfwlR3E3oozVFaWD9tBIZNxFBaZTYvGGXq1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=XLaSwOOW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390dd35c78dso2695053f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 00:49:40 -0800 (PST)
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
        b=RBHI1PT/w6Nrp+TB2mL22vFGRNOiaUw5JrvTnD2EWD7P3lZRGW+79V0+T1S/soCpFi
         TXJGiM1QRXcfuuT/jfo4scB7lLrxV1XQN/OIA9K7dvf2+zGhbAHXLyTfCNvH5gNEnPDN
         AlNVWjpif3FRwHwIvrHzjOGlZLQc9kjSBmquWRl7kS2YailPxp4NSk8J6g/Am/S4jJvY
         de+V+QqbXPaTQOBp9ShqIFDZ+tZOSBb2nQNdbSntzD/RlR8MKeJjNp7TsV8eBPchlVTy
         DEgRt7K6MEwfoarEPXiWtM/LpLHkwkqNHlFhbkknvROv2qmr8oXbRaBs7q9gGcyV8Zr0
         9lnA==
X-Forwarded-Encrypted: i=1; AJvYcCVdQzMDz9MzN0k9LLqrtqvj8A+wdTxqtA2LnwmN8LOCl8U7XOKzlZwsPd9hmwV43QVck1/7vABhK/mr32yHoG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSXFDvGhZ/X8F88YcWhzHqUc5j4MY1JUAUHPCcnyWYeSN6BlP
	ep6V3PQ7+dVoDlW12qBf6Swc8mhHcuINoEuYRCOzyusTm7vDQ2+PizBMsTgtcF2ddmTtutSkt8f
	o5YfG1Q==
X-Gm-Gg: ASbGncuI/ogxlCJrSPqxzROK57QXOZDWX2a07BWB/nqXbnS2nMWPtchSvQh7uYeZ6BF
	fg7OyVDaSj88dQHdm5n0uotKtqxgWNNKx3GR3CEmsNw25vpENHhlDqCKCZKP8RIZH+AMLi27062
	HZEpsV7bZ2Vl1cjHWhPUjmW2m6SKLejQKABb7ea3uNac3aW4WcRF+cLF+NiZGG1XX38TwpCgcgk
	/1J5283XCbPwLkGQEgyoqStzri6kMXrPH5BEK7UdLj5aYHrfgrjAzQ7kgnQMfSg7bNNxJzuCk90
	vmpT+TQfPLyxD13Hp670uhtoYMlDVXdBHBruOSe7DZurPPaYl86aDVk+cb+mKeU1YQ==
X-Google-Smtp-Source: AGHT+IHVLjZBMOHPs+saOKuJEuqmctdpDU92+SVxz5HFg3qV39sxng1lBC4zbTnM/QwHjaV0RHgfIQ==
X-Received: by 2002:a5d:5f96:0:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-390e168d26amr12668179f8f.11.1740991778861;
        Mon, 03 Mar 2025 00:49:38 -0800 (PST)
Received: from localhost (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710c2sm178368295e9.32.2025.03.03.00.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:49:38 -0800 (PST)
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


