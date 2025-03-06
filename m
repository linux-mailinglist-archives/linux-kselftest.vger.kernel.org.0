Return-Path: <linux-kselftest+bounces-28398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409AA54885
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 11:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1181895074
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED54205AAF;
	Thu,  6 Mar 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWqBMR5k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6802040B3;
	Thu,  6 Mar 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258606; cv=none; b=tSvw/Mz1D9Cj6l9lBkZCOYuuU7b9tzz4X6Sq+rv7nRvAhveHNIP0wrtC5aASi3pr0XmOubo4HD8M5DoYTOkLdL259RJ+eS7qwN6uTobdSd48XZk+FJUlvGowZs2RUV2JdezkxpnL0nEP1A0slawMsnxnogb9VOcpsvaX0piF+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258606; c=relaxed/simple;
	bh=OZOz4ppa2x3js0XKm0w8nNkZ/jFIt9LsQCdsSo8qZhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEmCpa6uEdraFEFe3CmA49DRl1J8Zzj1C1ZfNTBadQL+c1m/oF7/wVHGheipZLA8F5wOLPH15D+8wfXdFcI+epkn/1z+WmpAfHoaZq+OzpM0kHuvk+cwqgDSVYSQgTrE+umO4j1aEs7GLrTIM/Kv6+aaJi1hAk/GvGt/CAiGiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWqBMR5k; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bb64a4060so4606481fa.2;
        Thu, 06 Mar 2025 02:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741258602; x=1741863402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMHaQ1o6v21KrrkkRtJmLVVRwtGp3fBs93qM6xwU+Zc=;
        b=OWqBMR5kn4NdrkiO+NDSHKuO1N58vjfEVSFNaxcMbyx8xWXSDk7NrtiSp/ii6yGQfH
         YTrHEZobUdlJPF6M57NExpcXo5/9OCP3oncm4ftMxWoK+l1igkGT471zxVDr/auOjJpI
         3W+s9Yoxr1PuxGI6Pj+EZurz0H1t7evkP/6yHrfSf2feEo6fyp+CU88kg4LkIqdoRT/X
         6fmNthjN8pIqIUjT6wwHgAUJIqw8fiIG7Y+Dzp1a+tkxCVuxQbYsMVTyUTDuPK1ebnBn
         fPQciSJ7O+idn48If9WDGMB7TGM85y2kqw4v3eD0P8TaV81VY2+H4YSa4fp4mXieGEWV
         E5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258602; x=1741863402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMHaQ1o6v21KrrkkRtJmLVVRwtGp3fBs93qM6xwU+Zc=;
        b=S1igTMqc4xWP6+jTXgi5IvaPpz1ImAwzGsFGYXo74aRH+KlNX4b+Fx/xVHFsXnZFNX
         HI9fxkf1gwWsThnbKflYmLJbNTe7n5cgCN5Je+rz+K6fsQ4AqyB/Vy/f19zVjDtn8bfC
         ZMcy+zPVLm4EFsiYsgDVbwaXVJgPrnnyJGvD67I+dEQ3y9fMZ2m8lybc0O8n/MygE/4F
         dXLLQqA1iOzVpdyPUb+o7un9WHWL3Xa0cBwGTOzQxixOQitG+j3v6QTuVgz+E3I4P65i
         yq1BuMAHmZJDD43ge6uwsKAjOC2ysc/2Bzr2E2YJ/6lY9V6Qnh6DRzXC+6OT3T9IdAOX
         A3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV9liOGYsIhWGgIwytmAp+vxALeOAvfmHe7Plc8iYAMwVxRJBnNGPzXGyVnjM192SaGAEP+fXaWJ+dXHtY=@vger.kernel.org, AJvYcCWoCJF/Gu/CGPs0wDmPI0eCBw5TPSNHpwxL9kSVZqCREWIQ4rOnntpIaDHPVbnInp2Jm9hMIeS/WWSr8QmoTWoy@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaMw2Ni6QhQ4eaNyq7A/OkJN6GYZ2bC6KPPwtc6BSY+x7HeJm
	cuv2Yewv+cH5NbEED8LQsQ/nmlmPMrWlHbqFEoRnV+NwzNKa/zcY+DQ1UXhPIECzlZMLV3q8HVk
	tMw36zJhD+ANBavQHO6ZvRyn8bbLkNxSgKG8=
X-Gm-Gg: ASbGncsyDrX0646S69D6rYLK93evpR6Ap/iI8vVgK/z2LwIHQNlWD9BTaIyX90/FLlb
	E6JJ7H04u2rOqxa1v+G9A+gS2L8CSXykIxpzfAMW6UR8sgh+14WtFBTd6sq9xqQsbqRKFAHvKIV
	8V5RuIQVHVFWExsDsaJJaWxXtDieod5G3LK8JpTThY7KzC9TYi9bz8z5ji3e+U
X-Google-Smtp-Source: AGHT+IG/TO5T0n0wIvdg1Tm0CVBvk9K3gHk3VYPGFJfuz5YDgYf4G5nntM0CP18nSr2vF+yrV9bLaUe/sBClD35k5FE=
X-Received: by 2002:a2e:bc06:0:b0:30b:cc6a:ffd9 with SMTP id
 38308e7fff4ca-30bd789238amr28340571fa.0.1741258602110; Thu, 06 Mar 2025
 02:56:42 -0800 (PST)
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
 <Z8ltGEp7NmhTwPRW@pathway.suse.cz>
In-Reply-To: <Z8ltGEp7NmhTwPRW@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 6 Mar 2025 05:56:04 -0500
X-Gm-Features: AQ5f1JpKo5Ng2Vlq-qCIgYpgDnzhnALdfZF8-xRNElx2CsSV5d1QAgxLDHkcU1E
Message-ID: <CAJ-ks9=6qM2nn9eGZirtEUa=WifdToFRr=kE0gXw3OjFoqi4zA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:38=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2025-03-05 10:57:47, Tamir Duberstein wrote:
> > On Wed, Mar 5, 2025 at 10:55=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Wed, Mar 05, 2025 at 10:25:51AM -0500, Tamir Duberstein wrote:
> > > > On Wed, Mar 5, 2025 at 10:01=E2=80=AFAM Petr Mladek <pmladek@suse.c=
om> wrote:
> > > > > On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
> > >
> > > ...
> > >
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
> > >
> > I think I'm getting conflicting instructions here. IWYU is indeed what
> > I did: bitops, kernel, overflow, printk are all unused;
>
> I believe that the headers were added for a reason. And this patchset
> keeps most of the code. This is why the change look suspicious.
> And I see in the patched lib/tests/scanf_kunit.c:
>
>   + hweight32(), BITS_PER_TYPE(), BITS_PER_LONG which looks like bitops s=
tuff
>   + is_signed_type(), type_min(), type_max() from overflow.h
>
> So, I would keep bitops.h and overflow.h.

Thanks for checking.

> The printk() calls were obviously removed in the 3rd patch so printk.h
> include should be removed there.
>
> I do not see any obvious reason for kernel.h, so I would remove it
> in a separate patch.
>
> >  string is used only for sprintf, so I made that replacement.
>
> Makes sense. But please do this in a separate patch with this
> explanation. It might be done together with the kernel.h removal.

Will do.

Thanks again.
Tamir

