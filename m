Return-Path: <linux-kselftest+bounces-26403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C5A3137B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC8A1888B7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD72C1E04AE;
	Tue, 11 Feb 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuUpPM7G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348A26157E;
	Tue, 11 Feb 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296257; cv=none; b=G99aW4jcIsXmoR4lgogOIy1QjnAUwkb4HhDBhLq95uEVZI1GNnLbP2ZBt1yxzDXUvR7GtHa0iqpgVmm83Hz9JMRMYgohDh96OqWqmsn9R4DAnlmIqFzsBsleUhsxCSgGo6ftk9KAkBMTUtUcAQ9REeUO+XsdPtv4ZcUo+oG8arQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296257; c=relaxed/simple;
	bh=0iY/NwZJPE/fXHS0kCVsYRJPFwF6UsT5NCvJsyVXccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNTBWF8u3QTrrlp5Nhu5XJY6bYfnPnvlWMj761wsvnOHuM3UA40jnSPhbe92CBWraa6JECaWKS1EM35b41YEUHPCFrpLT6S+TXAbN8U+MDm28G4dQudKRbT+FT1UJ8GpfVLtRtaQs19htMeRfMjWH9hBGQCwTpIx0OptC4iIj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuUpPM7G; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30795988ebeso59036971fa.3;
        Tue, 11 Feb 2025 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739296254; x=1739901054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYsCvLpqdvorzqPcyGkiCMqppnyBYnn8VtGTqKpYrvk=;
        b=GuUpPM7GyfY/G2vvRmmnQpD9Z28wSZsHrs47C1bTqN6prBaIBOPiVGpjle0rybIVOV
         MJfmxlkF6XX4qlJKUrwAo/rg35n61+q7MKvHFVz/3yucz8SBCaGXUP6taZS6ia4ayew0
         XLxDOBwT9iEfzAyqC0eMRJrrZW9NWsou/pvuDjcgm5tgkD8HTmWHZd+gbTG7Ejlz3leX
         SBlMcsU9MN4tOi4kJNEqKJOTGFTFhdXQS/0hZKA0XSDpxtXWdcrrYnWJ9eXrwDZFWj+y
         eXfXWEAkMEDsC7Yiik4sO1mSEHi42DFqfdKavU6OzsvoCvc3LG/ShFZyTqYWpdEwoxUl
         2MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739296254; x=1739901054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYsCvLpqdvorzqPcyGkiCMqppnyBYnn8VtGTqKpYrvk=;
        b=DWCPpMHvCR2IsADGyr2yexkpysySsaagsgQT5gBWa4r9kx/WLwcJ5bAS8lwAvgpvM+
         PMZaXdKeOQ73+0wGQtEs4QHcpFFMlrx2oB+U4n0q4+l9qc3GgqUPkgS1iy0oOMTcDaN/
         jjFd4WMQ8bUjHB39LETMmPmLJ9IUBMQ8rrql4DZiAqHtL5aZdKE14rmdJlKhgZKFcxZY
         Ga9+nqlfryAUhr5k3VyXxz8TP1pAAiOXP3v4gl6mQC38viuMgcck26cAX9wLA2m5wy2B
         H1btR9VY+G2xEf6c+oSW6jjZpQ2Cjvm/73mWAgjAgSyFj8xe6/zqhk5eiienOGbylKgj
         SOrg==
X-Forwarded-Encrypted: i=1; AJvYcCUj5dM74ZywEVBne7TsmBHK2jbG+Xu/cuT3wjP2Zq1HppIs4T/+nS1g0+9e8qlArdH6T32SRUZsdmskMnNiRJ2A@vger.kernel.org, AJvYcCUoeLIbqOEZqmw63Fb+L58M+yqxQF/03Frv0f/Ad7lqgbyOETJvwYxIdAh96P54GZqyquh74TKWa3KJgvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Qswlc8hzqWq7lmmBzS6uf+Dls0ygGY2UgHWNphfwN/HdAaFE
	2wqNmzOOT+B4lH5DOj9SwWTKQajMubOkdWQK/i3fU7T1IqcxS4KHssPk6IFiDE1CL3thW95C0Rq
	hMh/V9yi/KkmDe8LssCtWTsGvEL4=
X-Gm-Gg: ASbGnct+feOtlvzG2zc0AOqK3Mj/q/6Bwjc6KnELgfVG61FrCpKX/CIDg2zv11ljJHR
	iqblVmLYUNkULZ4/rfAQdvwVEo1JqQBouzvMDakHuQqGpm40wQ6nqPHrt9xOUgMRtAwiorXk0F1
	dNCwI/bnfkn1wQ
X-Google-Smtp-Source: AGHT+IHwcGIJZ0HG/lVot9DPoNYOf8/OyzK1zTxLCUnGIcshHE21CEfAZAkhaQEq/KPpbfdaBtFmTzmAWacX6z08vb4=
X-Received: by 2002:a2e:b8d1:0:b0:308:f01f:1829 with SMTP id
 38308e7fff4ca-3090369a0c9mr1642301fa.6.1739296253584; Tue, 11 Feb 2025
 09:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com>
 <Z6tvzhZIMVKWH8kK@smile.fi.intel.com> <CAJ-ks9=Bf42eojROr1X+BnmeQLa=zF7EAr4Y3n2exwZXum+rbQ@mail.gmail.com>
 <Z6tzkY375ffTVEXQ@smile.fi.intel.com> <CAJ-ks9=xqXsEp1_PP82qr_WDm_OF_uW2eKQfqC5+aDapWdoJ2w@mail.gmail.com>
 <Z6uFlh6TgXTnwHI-@smile.fi.intel.com>
In-Reply-To: <Z6uFlh6TgXTnwHI-@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 12:50:17 -0500
X-Gm-Features: AWEUYZnasDPsgAR6YVeotrPtTHbrU9Jv-Jg8qe1Z31826R3Oh_jO7P4KrvNiOqM
Message-ID: <CAJ-ks9=WA0LSzgiLQfH+MZO9JcuAJgTFAL2EWf7UStt1NjG4jg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] scanf: remove redundant debug logs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 11, 2025 at 11:02:59AM -0500, Tamir Duberstein wrote:
> > On Tue, Feb 11, 2025 at 10:58=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Feb 11, 2025 at 10:50:33AM -0500, Tamir Duberstein wrote:
> > > > On Tue, Feb 11, 2025 at 10:42=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Tue, Feb 11, 2025 at 10:13:37AM -0500, Tamir Duberstein wrote:
> > > > > > The test already prints the same information on failure; remove
> > > > > > redundant pr_debug() logs.
>
> ...
>
> > > > > > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);               =
               \
> > > > >
> > > > > What *if* the n_args =3D=3D 0 here?
> > > >
> > > > Then there's no assertion in this block, so the test cannot possibl=
y fail here.
> > >
> > > Correct, but I'm talking about this in a scope of the removed debug p=
rint.
> > > I.o.w. how would we even know that this was the case?
> > >
> > > (I'm not objecting removal, what I want from you is to have a descrip=
tive and
> > >  explanatory commit message that's answers to "why is this needed?" a=
nd "why is
> > >  it safe to do?")
> >
> > The true answer to "why is this needed" is Petr requested it in
> > https://lore.kernel.org/all/Z6s2eqh0jkYHntUL@pathway.suse.cz/ (again,
> > lore is having issues):
> >
> > On Tue, Feb 11, 2025 at 6:37=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
>
> [...]
>
> > > But when thinking more about it. I think that even pr_debug() is not
> > > the right solution.
> > >
> > > IMHO, we really want to print these details only when the test fails.
> > >
> > > Best Regards,
> > > Petr
> >
> > The commit message already answers "why is it safe to do":
>
> Not really. It answers that "why is it safe to do when test case fails?".
>
> > > The test already prints the same information on failure; remove
> > > redundant pr_debug() logs.
> >
> > Perhaps what you're asking for is an assertion to be added if n_args
> > =3D=3D 0? I think that would make sense. Does it belong in this series?
>
> I don't know if it's possible case. I don't know if we need an assertion.
> Please, research.

Such an assertion is not necessary. `_check_numbers_template` is
called from `check_{ull,ll,ulong,long,uint,int,ushort,short,uchar,char}`
which are in turn called from `_test`:

> if (ret !=3D n_args) {
>   KUNIT_FAIL(test, "vsscanf(\"%s\", \"%s\", ...) returned %d expected %d"=
, string, fmt, ret, n_args);
> } else {
>   (*fn)(test, check_data, string, fmt, n_args, ap); // <-- `fn` is `check=
_*`.
> }

So `n_args` comes from the test expectation, and it's already checked
against the return value of `vsscanf`.

