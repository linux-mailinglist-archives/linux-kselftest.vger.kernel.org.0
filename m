Return-Path: <linux-kselftest+bounces-28332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B515A50C3D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73783164E1B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DEA254841;
	Wed,  5 Mar 2025 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMog1TNC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECA19D06A;
	Wed,  5 Mar 2025 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205397; cv=none; b=LuRg+DvQ/cAqS88BopdwbrcpbQ4abPcvoT1rZtnK/o8yi4vfljgkRSZHDgYKrEo7exP2f/lHCfiaUF2BE2eZGUypeXRNsia3qyARvMzTZVoSnCDtrva5JjG12mRU51T4pwcLP8sT7OW+/tJYXs2K0wWzJk8qa/wXLQ8HQxBwneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205397; c=relaxed/simple;
	bh=JKjvBJkaP+bCSF8OB6i2C4q9ia72TjvN1Ur2MmP/E7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGxO4ykQWY+mcWkqncP1k6Ot4D+xxECG/FW2A85zohbZX1k6qVhIkOatDWyLxkI1IBJKhMcesaTbpEXP639ed1Uisjkohg53HvYvXD7vrYJXk3A2fvjghkLGG9aL7eklTu1vzpx8e0PpheNNgmlAEuXYBHrhpJZ80LR6sU42ViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMog1TNC; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1387424e87.1;
        Wed, 05 Mar 2025 12:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741205392; x=1741810192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NMDP3nY/Cv5QrKrBYxr9nsmy0z9S+GoDya+jfd+rcg=;
        b=lMog1TNC0MXtn/xZDeSNl/MDcmTE9jpChpQT+PZpIwrzHJDoHcRPTHY25tSPVJjQLo
         tejs43uCpOQwgTRrQdQfYFzGvgpQY9soUMoByZw8A5sgbN6ZdkQn5JqcxP9UQggPgw6I
         A84OZGKwANUn4noH2edS8GD6WVEqy8v4gM/zPKByc2Yc65uzT9roLYqyAtkteXf3VXVZ
         CIb8mYB7DZfiPNkBZN3Rt58kcQyPpV7+DloGk2U1p0s6RtBa1trq5j9d42G9pCfusho4
         WZqBtwo0NsPjXoIKmE0qnQhaJ3PVap4rAFGSNPZX1AlmBt4RCWA/2HibQf7Xqq5rs4c0
         v+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205392; x=1741810192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NMDP3nY/Cv5QrKrBYxr9nsmy0z9S+GoDya+jfd+rcg=;
        b=Y40N3scx3IgSGrOPvTELNK1m+yAHoJ1TLEnHc+XZaDc5i3b2755r0UX0R/TYSg5inN
         g/QvZBhtP6OG3M9jFQAKGgldN9Lc519CTZ9fwt8DHStF8el8bfkeqvqjrK+my5PIm2nN
         TWRZvM4ufpS79ri+jDAPjP2vpTBtLG/Ga2TjmZNHcM8wrB+CxAZPu8gOgdpOxol+XiBC
         PdyRAmZAh5NSl3Hktg89n8RnVCiF9d2n5/WmqA0D4pxL+3vUqLGq4GD2GOOWmGjwBoaR
         KnG7eRuxJQq3n2Pn8mYmobuD77nbIbIss1Mp/reG5FehsNShE9U+HHJxJT/LuMHVTRG4
         ibGw==
X-Forwarded-Encrypted: i=1; AJvYcCWg0+91Q/0V1+UfI6dDcK0qhD9rJkiZqDppoLoks/JY3SvQxLlQ6QiDkPVUpFOAXjRB2xWSX3djutR53gqG8TpR@vger.kernel.org, AJvYcCXPCw0UTNahWriyMB6HKaHbu2eFFFwbuUP5B8t4QSHjM7VfILbOoaIFOKb6QzBFvO+3/eQzwNvtuRBkZAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3iQYXvM23Kip77djf07LR+GJgrXfM6I2Vgv+dmmt4C+xYPh3
	ICGm52LsuJkaIS0pPd5DP8PKn2/1X2cnuLoxfJ5bL3pi2etlz9GzMMihiHlJob4+GAushZ2eMqL
	J2ruS2LuUQH3qlm8I/L9RP4spzFk=
X-Gm-Gg: ASbGncvwE24vr/MYlAvAWvnfcF5ZClkNGRX3K8XQlf0FsYtk1s0LhhGfbdQC78pJGjI
	XZepNq5KpqfiAT3/KMBVDYSbrip213uhkUesyyU90LWRxcy62I2N2raH3ExsaiQSp1qaXgeckVI
	bmf3OfvxhIwxJVVvbY61P6ydyPwE6tHDp05JrvfXdUEA==
X-Google-Smtp-Source: AGHT+IGY0d68tg4ygvsu8lFMjh8/pn1fTlEYcTFZfa4u6z0f6Q4LE3D+97AKPx5MQua8S1lsIuHOofp4osXlu8EKcFU=
X-Received: by 2002:a05:6512:1246:b0:549:5a14:96d with SMTP id
 2adb3069b0e04-54984c1d477mr229019e87.19.1741205391447; Wed, 05 Mar 2025
 12:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
 <Z8hnXIrMV0ct1YR6@pathway.suse.cz> <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
 <Z8hz8-Sa6XRC0W5Z@smile.fi.intel.com> <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>
 <Z8ineT_g9gzcftWe@smile.fi.intel.com>
In-Reply-To: <Z8ineT_g9gzcftWe@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 5 Mar 2025 15:09:14 -0500
X-Gm-Features: AQ5f1Jo1wsViVz5Qqbo6kN_0ma0b_fS-xinbRwRnH1wy9-9N740S0sz2OB5HnO4
Message-ID: <CAJ-ks9md5CMgKZ1==1+rW4nPJ+PBtMXUpqc6BRd=fOB8MXe+nQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 05, 2025 at 10:57:47AM -0500, Tamir Duberstein wrote:
> > On Wed, Mar 5, 2025 at 10:55=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Mar 05, 2025 at 10:25:51AM -0500, Tamir Duberstein wrote:
> > > > On Wed, Mar 5, 2025 at 10:01=E2=80=AFAM Petr Mladek <pmladek@suse.c=
om> wrote:
> > > > > On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
>
> ...
>
> > > > > >  #include <kunit/test.h>
> > > > > > -#include <linux/bitops.h>
> > > > > > -#include <linux/kernel.h>
> > > > > >  #include <linux/module.h>
> > > > > > -#include <linux/overflow.h>
> > > > > > -#include <linux/printk.h>
> > > > > >  #include <linux/prandom.h>
> > > > > >  #include <linux/slab.h>
> > > > > > -#include <linux/string.h>
> > > > > > +#include <linux/sprintf.h>
> > > > > >
> > > > > >  #define BUF_SIZE 1024
> > > > >
> > > > > It would make more sense to do this clean up in the 3rd patch
> > > > > where some code was replaced by the kunit macros.
> > > > >
> > > > > Also I am not sure about the choice. It might make sense to remov=
e
> > > > > <include/printk.h> because the pr_*() calls were removed.
> > > > > But what about the others? Did anyone request the clean up, pleas=
e?
> > > > >
> > > > > I do not want to open a bike shadding because different people
> > > > > have different opinion.
> > > > >
> > > > > I would personally prefer to keep the explicit includes when the
> > > > > related API is still used. It helps to optimize nested includes
> > > > > in the header files which helps to speedup build. AFAIK, there
> > > > > are people working in this optimization and they might need
> > > > > to revert this change.
> > > >
> > > > Yeah, I don't feel strongly. I'll just restore all the includes.
> > >
> > > It will be blind approach. Please, try to look at them closely and in=
clude what
> > > you use (IWYU principle). I don't think anybody uses kernel.h here, f=
or
> > > example.
> >
> > I think I'm getting conflicting instructions here. IWYU is indeed what
> > I did: bitops, kernel, overflow, printk are all unused; string is used
> > only for sprintf, so I made that replacement.
> >
> > However Petr said "Did anyone request the clean up, please?" which
> > implies to me an aversion to unwanted cleanup. So, which is it please?
>
> I believe he asks the background of the change. And if it made in a separ=
ate
> patch it would be clearer to begin with (e.g., Suggested-by tag).
>
> But I don't know how you deducted that it's unwanted. With a separate pat=
ch
> we may discuss and see if it's wanted or not. In any case I would like to=
 see
> such a patch.

Thanks for clarifying. Nobody suggested that cleanup. I will remove
printk.h in the 3rd patch as Petr suggested and the remaining headers
in a separate final patch for the next respin.

