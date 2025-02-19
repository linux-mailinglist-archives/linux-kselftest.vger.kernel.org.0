Return-Path: <linux-kselftest+bounces-27017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1436A3CA9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 21:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317E41774C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D424E4BC;
	Wed, 19 Feb 2025 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWSowlse"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E521B9C5;
	Wed, 19 Feb 2025 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998728; cv=none; b=MObXfOAMi8oypJM8LqfavntAQPUoivkGxKpr2TggHQ/kdrIWH+3TUGIIGD6QaZTKn04/RKwVHiIp/BHaBU8fd8gCXc7plqNQB+mDFelfh3+7CePCDYxhqvu3OB+G3KtKPcqibdZGZn/5p7RxzVmm+KcQT3PJr5hBLn9hI5vHHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998728; c=relaxed/simple;
	bh=1YnkwmqTBrxU2LC4IjJbS9rALrX2MyA+O3NS8Wavzwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNHyn74FFbamosXN0ErrD8AFFkEe8GG5fvbEQd7590OOSMxvD9sQLIv4HMIMwAd0eWjDGxM5O1Z36RWB6UHKm2EkV3PfDzJZ5j27SjnEwRyBJwi7WUNt5xxzSZtIUWKHh3p+HEi9WuqPQELLzn+lezAyeuA/pGjdf5JWXKKcl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWSowlse; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30615661f98so1878541fa.2;
        Wed, 19 Feb 2025 12:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739998725; x=1740603525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29zpgtmqkMxdyASEnJJCIlnqLj+EywBz14CpRjuAKx4=;
        b=FWSowlseyT47EW9v6ktzl5vc6swboIOyCQMzh/pauntE4B42MhigCVGrDp55s6oRli
         rvv2QxHm0zxGCaJiaK075RseSf6ZQZvfVtcq5e/QDWxTKDsTYQRXvigL3blfHmX3nEja
         sf3uyQTWu32jRrhwijZ7nltNtT3wbtP2ETPb2+EO//ttXjOEO2t82Tke+0Gr8NwvHrTE
         +VPJqeKRQSNBGuJtuVjNCTiB1/AwVA5NIWZZ1oqigoD99STpD9VBaKwp8Z7+M2XdlDVW
         bPUN6VGdqsJvAC3ikmb3ziwVrILokxxDLtD9kLSQ1FwXbSoSfsiUwSyEN0/cF7KHD3JV
         xSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998725; x=1740603525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29zpgtmqkMxdyASEnJJCIlnqLj+EywBz14CpRjuAKx4=;
        b=MyDZczhDHQ0txjGcq0fGl26h/GYgeCiptcGdtIRMGW3XGWiIfGip0ZSbCHsSd19T9T
         l5H93w8oGN/KR7avOaen87KC44a+6GsJk5cBHG763nBaOiFT3lPV+cpShOQu09kdjS9b
         u1hnlqlNePyHKHDsUjIRDRWcvTf+GJqIoKjP6qKRnjsgBAUoz60QwwqGDnUTVylvpoEa
         lwy4Ij4QlzGNVoxm10N+Fym3MZiJl0DEHuWbx8G0MPXAVS0BitJPENL/UbLtR0k+wI5/
         ssCsL3uUtTk47YgHTZbDXjDKk1pfvyl+F5mtLO/ViGMzlu1VeQbm/VqDIEBuR9pfYH9Z
         u+dA==
X-Forwarded-Encrypted: i=1; AJvYcCVUlT9AilP68JhPnN9Bolht6oA21c7JvbWTEfuSGFnfN+J/Xj25d0nH5Ul1W2AMd8vFSY3NvAMFlNw/0CDdoz1A@vger.kernel.org, AJvYcCWfOz2ag0raN8CG7STpVfkMhttfN6EXPTci5WuvYTsTjh4Rbmg3Do8LXO1oXjyxrbxFkJk45gsxanjRrXDw@vger.kernel.org, AJvYcCX3U8HviNzjo1Tab3j6KLMUF4WEsWi6tfxU5Yqh4xK4511/NIhjve7+HxXGSHvP8SAUIkDmOn7rSFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBo05/NwirQtC1poN2asACreQ07tOr0SjezCzk5H27JJaBvL00
	DJIo1fTCw+l/Dhc/+ClooD+zqaiUdyYBI5MWKi9366TQzqAzFyxTKK5xr9LcJKDH4a2l2BUsK5S
	7Mj9RirkoxVQJREQ+mIgU29u5opg=
X-Gm-Gg: ASbGnctLwhtqFb7AqYGClu6ld+VcfWQXetKxifL593OygAz7VWVhYtxkSgBe5FYG8+O
	i5FQPpyy7mPWHX6SanEvXJFv5Dprlj2mkavGHojDcDtAaoomSRWI+jvxZ0wsBeupCM3AI54+Hpm
	fBed1CcLp+aU3U
X-Google-Smtp-Source: AGHT+IGoT3bsf2kdFagKyysGj4sdKTWGjnr/6od8iw5I/qyGVa7OesRWN+3jUei2+ekugunoU+v2tNYtkTv+DDddmPk=
X-Received: by 2002:a2e:b60e:0:b0:308:f4cc:9505 with SMTP id
 38308e7fff4ca-30927a577c6mr53587141fa.2.1739998724732; Wed, 19 Feb 2025
 12:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com>
 <20250214-printf-kunit-convert-v4-3-c254572f1565@gmail.com> <CAKwiHFh52-_ssWjC3wdtZ=92AHAw7grnDugZpmf7T962VQrEbQ@mail.gmail.com>
In-Reply-To: <CAKwiHFh52-_ssWjC3wdtZ=92AHAw7grnDugZpmf7T962VQrEbQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Feb 2025 15:58:08 -0500
X-Gm-Features: AWEUYZllpGxIALFm_VU7C7f0caMYFvyxidAHTXkA2rezSlvudlun8QXj74kF6fQ
Message-ID: <CAJ-ks9kadHvF3gKjZh-_oFdb1x_qOR6i1=Jamuaw9iq129gOnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] printf: implicate test line in failure messages
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:41=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On Fri, 14 Feb 2025 at 22:53, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > This improves the failure output by pointing to the failing line at the
> > top level of the test, e.g.:
> >       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:103
> >   lib/printf_kunit.c:167: vsnprintf(buf, 256, "%#-12x", ...) wrote '0x1=
234abcd  ', expected '0x1234abce  '
> >       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:142
> >   lib/printf_kunit.c:167: kvasprintf(..., "%#-12x", ...) returned '0x12=
34abcd  ', expected '0x1234abce  '
> >
>
> Actually, I'm not sure that is an improvement as-is, with the two
> different line numbers being printed. It takes some thought to
> recognize which one is relevant and which one is not.

They're both relevant -- `do_test` does a bunch of checks, so you want
to know which particular check failed, but also which invocation at
the top level resulted in that check failing.

> Can't we have a variant of KUNIT_FAIL that allows one to pass the
> file/line info when the caller has better info than the location of
> the KUNIT_FAIL itself?
>
> >  static void __printf(5, 0)
> > -do_test(struct kunit *kunittest, int bufsize, const char *expect, int =
elen,
> > -       const char *fmt, va_list ap)
> > +do_test(struct kunit *kunittest, const char *file, const int line, int=
 bufsize, const char *expect,
> > +       int elen, const char *fmt, va_list ap)
>
> This can't be right, the __printf attribute must be updated accordingly.

Good catch. Oddly I'm not able to reproduce any compiler complaints
here, even with the attribute completely removed.

