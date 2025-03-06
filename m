Return-Path: <linux-kselftest+bounces-28424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A10AA55500
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 19:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E107A77F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F8269CE8;
	Thu,  6 Mar 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="KXypKuu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5D191461
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285825; cv=none; b=oz4B7pJ/sAMOzRXhNr2BXF7mNIt/OFsTQq1OnQxkuPYs7s4X1EMx1aHnKyAv+tc2XlDBNvLr4Lu0clxoI/0C+gmAtCfrp4q8yDcJ8nxNupz/DgRXhaUxz4Llg4ENwpiwtwo41Dn58YmMHJZ7Vkl+CgSePWLzwV6jfwcnUbdQOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285825; c=relaxed/simple;
	bh=mtkkZRnb3QLswP4ydiPCslDz36MawM+f+fLjr8+Ebd4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FmP8cce/BnpYl5+wJu8WjquqT44rzHoViPlkgPXmYKqZn+jnfcRV5t1nt8UiRC/bL3FLziIIxe8nRVFQooeaQIl/ciNh0t3UGv/d7RMAM4binYR4NClzcDZtfxvisGQClojWfhkjQM9HN5nBs5CqHxjezzOs1BXJj/daqLKVp4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=KXypKuu3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc638686eso15105725e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741285821; x=1741890621; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPCEqaMTT2sQzMB8Mq+AK33JFTreikwE+NAyimZeTB8=;
        b=KXypKuu362KrjUGmax0l2m8cRCjiZSFhQozcwjO0HK/KXoEgdL+r5wvHj3jk5xr7r0
         f1jPk3BtR67RqTZ/uWr8o3o3r/6dUvKL0CVHBXXgGT5soCAFVD/6BPfQby0PcFM+IRmf
         HlTYfTZbE/srOg+iPu8xqh9J8A50ix5SJr1b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285821; x=1741890621;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rPCEqaMTT2sQzMB8Mq+AK33JFTreikwE+NAyimZeTB8=;
        b=KTmJ1DOvOjjnciA0HXDgxZlm9XwXV4sN0QUZvdy46tU6zgWx3brYN9g/9bEwsQZtYy
         xZd2GQm0dgu0dutB44ieKCHW0m01YqaYG2EIwGMu8PLVSjm9Xp3NtfQuss6rMjkG/x4u
         WEQW6sOKYlxvt+VTVmdMkhzYPQL0VkSkrhYs3bDpEMCjhdtpfz1x06A+2tIHUeJuX7SP
         +YLbzHxtuij1WkhBP+Aidxwk9ITVMCJcSDYq436avuqXpjSjevY4TPkwqY/NspSpxBYD
         eTEL5IBBlwJIzRj9um67OaSrPsex3Icv/xip+vPlQnl1GH9xZyA/RndQ8PBZOu+Nr80e
         S7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXdUE8dWrKoswXaIW2LdBNQVpV0Z/N8Kb6EtNIYPTm6GwKHDJSGjS6Pnh/vuaIV9V7W6GOjsAEGUcPNzOOfR9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuy6eB3E0Fh1WmPU8muxL6ucpUKo1z0GVlJRfZBHY1nWR5BasT
	p5ysfdwfy/GTz7o+CzlXd6rsh1/fHIKHhACriRkxHnxUpokOZrjvv/Yiwsr4TDc=
X-Gm-Gg: ASbGncudvpLGT2j9L7E+2g8zR0WUcRL3ba9UrqYiafL/nZT4B6mXuLTfvm2xli8eG8m
	oNOoR6aQtzDsLdon0rkdicAcKp86Au1vhFlVNQclTwcyBLSkGiuTXLnm246iMV6FIxzOrAOXA95
	FvGyqV8C3u00o0DJT5QDXYLs5hIZUwhKnojhNOe6q8xY1VHSChaHHnnP0NxRKCo+ghc5tjEAPz/
	N5Iw/d8taQdg4gFuSL1GFY0zSUbpEEcJulyWTVNpGvxDm6t+hXAHVQUe6TVacQ0N/4HaXCloESP
	32Ubt+8YC71h5bF/egExnPIRhbCKO1vEYOgRVRiyjHt6IhSyhIEeVwiogICDJlIwIg==
X-Google-Smtp-Source: AGHT+IGZ5GAw/yJ9TSmMUvhxwM5ULlBFAfwpvd/941TRQqHjvjrPmUrPLnNR1dnWxJ5kNILZaCkYFw==
X-Received: by 2002:a5d:64a4:0:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-3912982ea9amr3437553f8f.18.1741285820618;
        Thu, 06 Mar 2025 10:30:20 -0800 (PST)
Received: from localhost (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031e3sm2749571f8f.82.2025.03.06.10.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Mar 2025 18:30:19 +0000
Message-Id: <D89EB2A6K6H8.SDEMLB4O6NMR@kragniz.eu>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Willy Tarreau" <w@1wt.eu>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
From: "Louis Taylor" <louis@kragniz.eu>
X-Mailer: aerc 0.18.1
References: <20250304075846.66563-1-louis@kragniz.eu>
 <8a1fc6ff-e36c-41b5-b959-2d667bb8279a@t-8ch.de>
In-Reply-To: <8a1fc6ff-e36c-41b5-b959-2d667bb8279a@t-8ch.de>

On Thu Mar 6, 2025 at 5:10 PM GMT, Thomas Wei=C3=9Fschuh wrote:
> On 2025-03-04 07:58:15+0000, Louis Taylor wrote:
> > openat is useful to avoid needing to construct relative paths, so expos=
e
> > a wrapper for using it directly.
> >=20
> > Signed-off-by: Louis Taylor <louis@kragniz.eu>
>
> Looks good. I have some tiny nitpicks inline,
> but if you prefer I can also pick it up as-is.
>
> Acked-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

No problem, I'll send another version.

> > ---
> >  tools/include/nolibc/sys.h                   | 25 ++++++++++++++++++++
> >  tools/testing/selftests/nolibc/nolibc-test.c | 21 ++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >=20
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 8f44c33b1213..3cd938f9abda 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -765,6 +765,31 @@ int mount(const char *src, const char *tgt,
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
> > +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
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
> > +		mode =3D va_arg(args, mode_t);
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
> > index 79c3e6a845f3..2a1629938dd6 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1028,6 +1028,26 @@ int test_rlimit(void)
> >  	return 0;
> >  }
> > =20
> > +static int test_openat(void)
>
> As mentioned in my other mail, this in fact should not be static.
> Sorry for the back and forth.

Ah that's fine, I'll drop the other patch as well.

> > +{
> > +	int dev;
> > +	int null;
>
> Can be on a single line.
>
> > +
> > +	dev =3D openat(AT_FDCWD, "/dev", O_DIRECTORY);
> > +	if (dev < 0)
> > +		return -1;
> > +
> > +	null =3D openat(dev, "null", 0);
>
> As per the standard:
>
> 	The argument flags must include one of the following access modes:
> 	O_RDONLY, O_WRONLY, or O_RDWR.
>
> The other tests don't do it either and on Linux it doesn't matter
> because O_RDONLY =3D=3D 0. But if we are here anyways.
>
> close(dev) could be moved here for some saved lines.
>
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
> > @@ -1116,6 +1136,7 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); b=
reak;
> >  		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp =3D open("/dev/nul=
l", 0), -1); if (tmp !=3D -1) close(tmp); break;
> >  		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp =3D open("/proc/se=
lf/blah", 0), -1, ENOENT); if (tmp !=3D -1) close(tmp); break;
> > +		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); br=
eak;
>
> EXPECT_SYSZR() should work here.
>
> >  		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
> >  		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); bre=
ak;
> >  		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds =
=3D { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
> > --=20
> > 2.45.2
> >=20


