Return-Path: <linux-kselftest+bounces-28314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C01A50365
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0719F188B521
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E924F594;
	Wed,  5 Mar 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T10SyE6D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3624E4A0;
	Wed,  5 Mar 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188391; cv=none; b=ODwEUv/0sav213QvhHqVOM+1M2zDR9oayBpOs7TTMhoexqqy93/ULLyFXjPwN+0klE542Ib5RVlbxkoNu3EFmZIhni2+5T2io98jDXFTo85BS/mKc6vxnwUifzP/LX5lREYkZWYt1MB6GymlML3iKs9D104tnOINxrPKV8CHne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188391; c=relaxed/simple;
	bh=c0C/8k2NcvsPFWNP1zfNmrJf1Virv11f4zz8laCgVAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdXyMJLrQdQ/0XGYPTl+2DFyZ/zRBVdZnHawdZCzeaoXFvmp9jAsZc8s9jpLlYMAAjR12eDic/XdwUFAbuEEG/n30bvnXShWoczjYaU9cPspLnzvyVagbIm+4ydNEWvDaA6wCd/JbdKwjTZLOOAEr4ZH/9qd0KPByeIy6Nrw0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T10SyE6D; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a59so77636931fa.0;
        Wed, 05 Mar 2025 07:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741188388; x=1741793188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2CveGYR3dMGbaWlRSW+hSiMZrtxGbB7gR1yx1BQsF0=;
        b=T10SyE6D0Vso7J795Os9NDVcx4+YE4Zygjxstw7rVcR48QbW0WZ97jZYlHw7t0lpwA
         SY/JjYfPg/6HMQGdQ//5WAl9e0gsx1zDu51TR/gBb2YFHkvW7+Y/mrXar2r8Da7tml0U
         5uqvEnlLpFX0+37sOLAbTXNhAO0zn5TZXj+w5EdObxyiN0hloxvrnrfD16mHA7Aclp9i
         XSkDRdTQDxnyJC5uC57K4QqYbtjsm8l+HDJfv9/c+NJHjKl1YEMIpVHU/2PkNOv01Ebf
         MVmhBBki0bVX1TYVO3QE8dA1nF1Cw+GCaBx8vw3xJWADqblt8gSMLSb2yqXqnfnvtsPk
         P4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188388; x=1741793188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2CveGYR3dMGbaWlRSW+hSiMZrtxGbB7gR1yx1BQsF0=;
        b=BaGHv2odHiyYzpa5PTn3ouVRp4nELqMpd8F3sEZ7Zm3Ylk5CoQ+0M0bfWnFtAZhVs0
         ZCAE2PGas4NgE1QoLvI9/nxKLG0LaKFwh2JCMwWSDVOq+kN3zi5OCGb3U3OUYz9AdFso
         /8xYGp9xhndhJztXgCODyq6F60w1LwQy6rgeWT6yPg2W/YhRTti/NcwbQb1DFcC2a5IN
         wuV+MQC3HsIQ7opzHuNDwUIU/0/Hn2ZUtSS80agYk2PDM/CD7kC7w+V6gCqi/O0psb4r
         XoI/7zy8cd9GnRhcfuxhd0ZF6zdQ4i+S//MEdkYugReggZTp4/8oPRIZYMPWsdqEd7+w
         pjMw==
X-Forwarded-Encrypted: i=1; AJvYcCUM3+xPIr0Y9P0/zaCV7yAJNqs5gbGrUjVQDm/GmIIEUhX9BBunWMB2k6ClmANMShfggb6qLy5QSWIxUdYTNoAY@vger.kernel.org, AJvYcCW6G+PRn3lh1wJPN8yhuX8pkSv4GKxVbAvPw6BOhhpd2xW78thr3oOvidgqL2P3rYthObAF3AhOR6zcDWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbj/ETZB016NU7nDQXEAPuCzlp07T5Cis5tKjOXIqKnJyvX+O6
	GnvemzNBNCz2ub1JlXJ2eYRmCvcwV5hPz6m9W8k1+L3CfuHSC8ZJcuYmgUtMZC2CmC4t3uWIhmJ
	fsjx1T8sMJjcxtgR8MMXUpx06xeBporAbe/mQ1g==
X-Gm-Gg: ASbGncubSuZMPKlNJu9ODRtCi337JCGkZUyXnn1TZKV4+kukzUXiLrWhWJX8x99F+xg
	ByUvGzTw4qKR9fWi1tDq/xpUaiht/mLkYLFLI1cCJ6JmZZXOpcLAulA68JwwXmwiBZxSCuElL30
	e5Q7FyHHfVCfd1MWnhhxroghjC+y5hQakqN5uPCzMC2Q==
X-Google-Smtp-Source: AGHT+IFswMYJlFKw6rcEI+lBq/Ofs1NDqK93sLM1XX+uZwHU+bAvw51/fBUsKyls/CSjsXtDGvPDClTtGTYP6MrNV60=
X-Received: by 2002:a2e:95d0:0:b0:30b:b28d:f0a7 with SMTP id
 38308e7fff4ca-30bd7a5732dmr14309601fa.18.1741188387503; Wed, 05 Mar 2025
 07:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com> <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
In-Reply-To: <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 5 Mar 2025 10:25:51 -0500
X-Gm-Features: AQ5f1Jq56dRx7DvhN80Y413j-_SP-TssQKHq2qIdENoUsZ-WHtOgbBs35tb-2Jk
Message-ID: <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
To: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 10:01=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
> > Use `suite_init` and move some tests into `scanf_test_cases`. This
> > gives us nicer output in the event of a failure.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  lib/tests/scanf_kunit.c | 95 ++++++++++++++++++++++++++---------------=
--------
> >  1 file changed, 51 insertions(+), 44 deletions(-)
> >
> > diff --git a/lib/tests/scanf_kunit.c b/lib/tests/scanf_kunit.c
> > index 3bbad9ebe437..fa215a7db366 100644
> > --- a/lib/tests/scanf_kunit.c
> > +++ b/lib/tests/scanf_kunit.c
> > @@ -4,14 +4,10 @@
> >   */
> >
> >  #include <kunit/test.h>
> > -#include <linux/bitops.h>
> > -#include <linux/kernel.h>
> >  #include <linux/module.h>
> > -#include <linux/overflow.h>
> > -#include <linux/printk.h>
> >  #include <linux/prandom.h>
> >  #include <linux/slab.h>
> > -#include <linux/string.h>
> > +#include <linux/sprintf.h>
> >
> >  #define BUF_SIZE 1024
>
> It would make more sense to do this clean up in the 3rd patch
> where some code was replaced by the kunit macros.
>
> Also I am not sure about the choice. It might make sense to remove
> <include/printk.h> because the pr_*() calls were removed.
> But what about the others? Did anyone request the clean up, please?
>
> I do not want to open a bike shadding because different people
> have different opinion.
>
> I would personally prefer to keep the explicit includes when the
> related API is still used. It helps to optimize nested includes
> in the header files which helps to speedup build. AFAIK, there
> are people working in this optimization and they might need
> to revert this change.

Yeah, I don't feel strongly. I'll just restore all the includes.

> > @@ -50,10 +46,9 @@ do {                                                =
                               \
> >       for (; n_args > 0; n_args--, expect++) {                         =
       \
> >               typeof(*expect) got =3D *va_arg(ap, typeof(expect));     =
         \
> >               if (got !=3D *expect) {                                  =
         \
> > -                     KUNIT_FAIL(test,                                 =
       \
> > -                                "%s:%d: vsscanf(\"%s\", \"%s\", ...) e=
xpected " arg_fmt " got " arg_fmt, \
> > -                                file, line, str, fmt, *expect, got);  =
       \
> > -                     return;                                          =
       \
> > +                     KUNIT_FAIL_AND_ABORT(test,                       =
       \
> > +                                          "%s:%d: vsscanf(\"%s\", \"%s=
\", ...) expected " arg_fmt " got " arg_fmt, \
> > +                                          file, line, str, fmt, *expec=
t, got); \
>
> I am just curious. Is there any particular reason why
> KUNIT_FAIL() is replaced with KUNIT_FAIL_AND_ABORT()?
>
> Did the move of some tests into KUNIT_CASE() increased the number of
> reported errors?
>
> Why is _ABORT() variant used in _check_numbers_template() and not in _tes=
t()?
>
> I do not have strong opinion. The change just looks a bit ad-hoc and
> inconsistent.
>
>
> >               }                                                        =
       \
> >       }                                                                =
       \
> >  } while (0)

Honestly I don't remember. The effect is definitely to kill tests
earlier in the case of failure, but you're right to point out the
inconsistency with _test. The original code had the same behavior in
both cases, so I will restore that.

>
> Otherwise, the change looks good to me.
>
> Best Regards,
> Petr
>
> PS: I suggest to wait at least one or two days with the respin. Other
>     reviewers might want to add their own opinion.

Will do. Thanks for the reviews.
Tamir

