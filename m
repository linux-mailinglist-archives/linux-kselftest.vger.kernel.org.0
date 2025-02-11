Return-Path: <linux-kselftest+bounces-26390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F76A310A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496D61885585
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D73C253F25;
	Tue, 11 Feb 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUGk6FHB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C49253B47;
	Tue, 11 Feb 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289822; cv=none; b=HXnGuSVxJQnUAHn77Mwz5IgsfIib1QjjbCdk7nuZR7bP0WbXqyf8FuPGOs9VBbegfdBQ/9dZtD8iDsWLzEIemrwFecUuDmA2PHdqAA8ZbFroenT+VMmE3v+Hrfh066TwEVYiLnuvp0BtKutskH+5TA9nqeUX1MoyDpR79b2noQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289822; c=relaxed/simple;
	bh=y2quUKlQp3YDpfsFJEd9u2apBzN0pPoo+ubar++p7XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvB9LtnBoQ7oJhvqBM0MtFJWgnIJIq7hbFg/k8bfdL90T5wDnc7DpNx4h9z+c2Tl8Sae4t5TO0ePvo1JnQVzy1EKwH6xcqfcutQMwAy7qAd6cHXu+37kOYqF1XluApSBrvl6/TLWRZQA3TMTDtKtlE+Pcz5HBf4+oRgEWwGufuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUGk6FHB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307325f2436so53584891fa.0;
        Tue, 11 Feb 2025 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739289818; x=1739894618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M65DyXElWxbMxO2kjGuVsr5LRLQGqgQ6Ttqv8xb7Q8=;
        b=HUGk6FHBaWaBQvBcGD5w0lYhdj/6IQDuQ8o5JVnCJHITu3ryr1/e4DI7MLi+YxPh+b
         uK4zdliW6a64WVOP2AdM3hSe/7rmbSJP0um59Ly76lC5ZnqHdlFIbHNgYWHdiznL6LFp
         9X5R/sUoQTxTs5Xy5gjzy0iwVOW17Mf/ZI/ctoFCb0K2m6WxeOc37tjMdSNH5+RmZ113
         p338N/cmBRs6bJL+lReO+PDbp2NZdXcWqfezOSG48WED3t7ZNHwDay2Db5EaAAGztoUP
         yOukjmPjSxHIu6Zd/6qvHADPlU2q5trbYRh8fcS20EqDNanrmKrGb3wcDtgj4RQuGkv+
         297Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739289818; x=1739894618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M65DyXElWxbMxO2kjGuVsr5LRLQGqgQ6Ttqv8xb7Q8=;
        b=bW7lDtzYQ7ZZQHfuVndnxnNNbV4AvsohrwsZ34f1+v91XdFdu03K0QWOmnPYvv4NhK
         GyhzlvGsJtSvjHFkv/rUATtu0oH70SwGBHqJf8sdrabk+KVPsf9BGZMPj94U1NNT+qav
         qD6v5JCQKrvYyXgBe87SzdTvV5Kb+VVPLoA7+NZTqpXVjWj10/f0fpKbPpO7elytA80m
         oXPtEXxVbEoHrrqMSXqN6E5ZIhjk5VW/zYShSsVAKne79iS3IKio8JIlWFs7iJ/NtFyW
         M4L2rkojycypdIEJ4N1jUb46ZCJZs4L+SY272TDmBEr6dgn6EzQd8Ua50VPh0CvP1bRg
         8rEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEYHq9pt0ecwCsudzTJki3dMm53lt+1S6S9uvKROT3bnN89XES7vVHQaGaxzMu6YBWaq6BmjFhXHPSoKs=@vger.kernel.org, AJvYcCVuIAMD849/MR0YQzR7/T5OlHp1TbBcMm+i5bfu/RwQJd7o1s4uuDvzso/Swf0faYy0VrscgMkqK22EOAxanfui@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/t0d0h0M3C/lz3/4EodG1qbKrcwHPGytOZH3qtUy1DAiOrHIo
	tR4HfHHyXkzlKqSOWTaKde2ynBgig34R+V2Pq4dIaixFU6ysHzo3fKzw3sg3+qDCNA3CbLQ3yVE
	Pw06mKnaCt6BWsgwNRc3pSxKPXBY=
X-Gm-Gg: ASbGncu+jvXG51DuhVZbLSD+KGHBLzPX6U8t1eVAhkFfIT5qQCbQ662KpdnvhCsy2BL
	G6YY2QG3de74auTo7VPYNyyIJZGupahdOpqyyorcPhwMfNDBRxHWMWeHLq7dnAQFTBfuMFq4Fxn
	bC2dxV7eM/U14F
X-Google-Smtp-Source: AGHT+IEn0gXdg0osprKgTY4h+XEMzhka+2ZdcfY9w1vp1y6oDsG8p27snUZ/R6BJt+rZfVPUv/exrweGRnMrfX5KW4E=
X-Received: by 2002:a2e:b8c7:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-309036d8fb2mr265091fa.18.1739289816347; Tue, 11 Feb 2025
 08:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com>
 <Z6tvzhZIMVKWH8kK@smile.fi.intel.com> <CAJ-ks9=Bf42eojROr1X+BnmeQLa=zF7EAr4Y3n2exwZXum+rbQ@mail.gmail.com>
 <Z6tzkY375ffTVEXQ@smile.fi.intel.com>
In-Reply-To: <Z6tzkY375ffTVEXQ@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 11:02:59 -0500
X-Gm-Features: AWEUYZlu4jSeZi9UmOoyqtKCnQIyEWkScacMVCQG1SkWycxDVHy6dwNFcwQ4M5Q
Message-ID: <CAJ-ks9=xqXsEp1_PP82qr_WDm_OF_uW2eKQfqC5+aDapWdoJ2w@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] scanf: remove redundant debug logs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 11, 2025 at 10:50:33AM -0500, Tamir Duberstein wrote:
> > On Tue, Feb 11, 2025 at 10:42=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Feb 11, 2025 at 10:13:37AM -0500, Tamir Duberstein wrote:
> > > > The test already prints the same information on failure; remove
> > > > redundant pr_debug() logs.
>
> ...
>
> > > > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);                   =
           \
> > >
> > > What *if* the n_args =3D=3D 0 here?
> >
> > Then there's no assertion in this block, so the test cannot possibly fa=
il here.
>
> Correct, but I'm talking about this in a scope of the removed debug print=
.
> I.o.w. how would we even know that this was the case?
>
> (I'm not objecting removal, what I want from you is to have a descriptive=
 and
>  explanatory commit message that's answers to "why is this needed?" and "=
why is
>  it safe to do?")

The true answer to "why is this needed" is Petr requested it in
https://lore.kernel.org/all/Z6s2eqh0jkYHntUL@pathway.suse.cz/ (again,
lore is having issues):

On Tue, Feb 11, 2025 at 6:37=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> [...]
>
> But when thinking more about it. I think that even pr_debug() is not
> the right solution.
>
> IMHO, we really want to print these details only when the test fails.
>
> Best Regards,
> Petr

The commit message already answers "why is it safe to do":

> The test already prints the same information on failure; remove
> redundant pr_debug() logs.

Perhaps what you're asking for is an assertion to be added if n_args
=3D=3D 0? I think that would make sense. Does it belong in this series?

Tamir

