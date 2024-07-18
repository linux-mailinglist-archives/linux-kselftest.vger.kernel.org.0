Return-Path: <linux-kselftest+bounces-13865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E79347C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 08:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935F31F21F9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 06:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F8643ABD;
	Thu, 18 Jul 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T36km2hL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB563A1C9
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282569; cv=none; b=TKup4mG0hY5h3s/nSeI0kzYAwiiH82ed71vXJB7uHvYjecr6DV8TDlTWKViMbhMs/u3n7rtl3jHqEJKlucxD0eZLmgueQMHAmn/vqST4onb5aO1Bc2cL1efXIMTIlouH3N8Q0xBOxQR9lGTESiGQgYYZoPC4cBrgBaHGolDBfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282569; c=relaxed/simple;
	bh=Jp8lgBkAuDISy+2P4SYUxjODx0ncY8WxLbjyfE+77ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szwS8sc9CUnyqZ9xAsUfwnwUXJOmxOCYgjw2T9ZmkyGHES1SBEdra1qRTORHS8+UdA61ycDzdZxQxtYHedyZ7MZn1H3jwUkC2heB1OdptRuNrmNsN1nbHnWd2RpI4klgOB2gL5Vt9cJ3MS4+I9ujWGidETv0X5W/KLClg3TBxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T36km2hL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447df43324fso122591cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721282566; x=1721887366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qjc076EONwXYvwzYUQvk4NPppKt6jBp/GYetLLRJ1JY=;
        b=T36km2hLu1bj3E5YcDe0o4yDewcS9MSp3cNncpXwNaAV95217tJYpKX9lc2O+ZwC+9
         k5t5UQEXvZeKRGW1iEM/VPpwA+WtRBY1qEHIrPMbATA0yaY004aLtf5DIxh+nVyky9B1
         EP9d1Wuv3Yh3hoLmjWznrEaubCF/aKuJeeYbLR6BYYcyFjPLnk2kWzXUMngQCoUp7IHL
         1g0j30s4szsXxBvgVcveRZk678XWY+KGvInpWPrTAuUr1+ua9FNJEsgi7bi8Vnz3+LLV
         H4jMmQ6vktZ3W9upM5axQya+PIbKnpLUaOGRfNZv68pyyV3jsJuDeOj7JK1S/laz+zw8
         iC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721282566; x=1721887366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjc076EONwXYvwzYUQvk4NPppKt6jBp/GYetLLRJ1JY=;
        b=c8jeNXdOAAR/NUvgPdUmjjycSCwUeePBHWnxfWG/JhYqO0ipm4hUCDID7xM7tDUceK
         W/mw/9LyXUqkKyLn7N8ijlWaEqsgIICapIsItUc0xUsx4jM2QeJ4mrSJb0+1JCK2DVYv
         FsA8MSNJ9AmNVuYzM25Ens5hAefqrRzwJGDu5Hx1dzm3OwpCop4NlaUWptRKpXa4NoDm
         FlQrdhWv02UiHq9v7FssLK9oXnE7hTTwkJKAUglAFcYKOykg08fU5kjPg58pqe2XpBbQ
         87sPNnASLcrKZlLjZwykokuR4sS7jnQcZwiAxRqRyafiHpfr4vBTL6riw/URsRIoZYds
         U5tw==
X-Forwarded-Encrypted: i=1; AJvYcCVHQiODaT2nnOnpsdnLkjkMWNrdjY2FXWLYndz1eqcDOLuzyaAeU52kMxsl/u8LnSvueuPk8jR+NAmPDK6zCy4rMKxPpnA6BhWymTsZdZce
X-Gm-Message-State: AOJu0YyGOMjxZsLpUiE6aQ+rr+/fgRIBQEdW5vgo+5x6uRKCtl2NSHw2
	9SDBeeNq87Qcxm84D9EzFYzJH4dWViSX9Piu9BRGYnwhfulf1QS9NTmBpIohHD78RYJYDaQAw4n
	AgcyFU/LNqKrnuW/StbgSQYZWPmLc47oUAapw
X-Google-Smtp-Source: AGHT+IHPG7DJ/ZiLIbA7hXXzjaMepSzn8ELza/rckzOCZ6v4pAHx4c9j+ynMDAhdCyFh/EKLLMqm1LvM03mhZHE7DXw=
X-Received: by 2002:a05:622a:5e8b:b0:441:5e6c:426c with SMTP id
 d75a77b69052e-44f923eed63mr1279301cf.17.1721282566329; Wed, 17 Jul 2024
 23:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407150921.BD2B798C6A@keescook> <CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com>
 <202407161505.A5AE57869@keescook> <CABVgOS=pUdWb6NDHszuwb1HYws4a1-b1UmN=i8U_ED7HbDT0mg@mail.gmail.com>
 <202407170944.FFC1A804@keescook>
In-Reply-To: <202407170944.FFC1A804@keescook>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Jul 2024 14:02:35 +0800
Message-ID: <CABVgOS=B29PcKyhVXtTk47k_BhjSaoxL8eF15fVhzty_0syeSQ@mail.gmail.com>
Subject: Re: KUnit file naming conventions (was Re: [GIT PULL] execve updates
 for v6.11-rc1)
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 00:49, Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Jul 17, 2024 at 02:28:15PM +0800, David Gow wrote:
> > On Wed, 17 Jul 2024 at 11:53, Kees Cook <kees@kernel.org> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 01:10:41PM -0700, Linus Torvalds wrote:
> > > > On Mon, 15 Jul 2024 at 09:21, Kees Cook <kees@kernel.org> wrote:
> > > > >
> > > > >  fs/exec.c                                   |  49 ++++++++--
> > > > >  fs/exec_test.c                              | 141 ++++++++++++++++++++++++++++
> > > >
> > > > I've pulled this, but *PLEASE* don't do this.
> > > >
> > > > This screws up my workflow of just using tab-completion for filenames.
> > > > As a result, I absolutely abhor anybody who uses the same base-name
> > > > for different things.
> > > >
> > > > No, this is not the first time it happens, and it won't be the last.
> > > > And we had that same horrific pattern for fs/binfmt_elf_test.c from
> > > > before, and I didn't notice because it's not a core file to me, and I
> > > > seldom actually edit it.
> > > >
> > > > I would suggest that people use the patterns from lib/, which is
> > > > admittedly a bit schizophrenic in that you can either use
> > > > "lib/kunit/*.c" (probably preferred) or "lib/test_xyz.c".
> > > >
> > > > (Other subsystems use a "tests" subdirectory, so we do have a lot of
> > > > different ways to deal with this).
> > > >
> > > > Any of those models will keep the unit testing parts clearly separate,
> > > > and not mess up basic command line workflows.
> > > >
> > > > But do *not* use this "*_test.c" naming model. It's the worst of all
> > > > possible worlds.
> > > >
> > > > Please?
> > >
> > > Oh, sure, no problem! I have no attachment to this convention at all;
> > > I was trying to follow the Kunit docs:
> > > https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module-names
> > >
> > > If I look at the existing naming, it's pretty scattered:
> > >
> > > $ git grep '^static struct kunit_suite\b' | cut -d: -f1 | sort -u
> > >
> > > /test/*          7
> > > /tests/*        47
> > > *-test.[ch]     27
> > > *_test.[ch]     27
> > > test-*.c         1
> > > test_*.c        10
> > > *-kunit.c        1
> > > *_kunit.c       17
> > > kunit-*.c        2
> > > kunit_*.c        1
> > >
> > > Should we go with "put it all under a 'tests' subdirectory" ?
> >
> > I think that's probably best overall. I still think it isn't quite as
> > elegant as the suffix, but I'm happy to sacrifice theoretical elegance
> > for a practical reason like this.
>
> Okay, I will send a follow-up patch to rename things.
>
> > > So for fs/exec_test.c and fs/binfmt_elf_test.c, perhaps fs/tests/exec.c
> > > and fs/tests/binfmt_elf.c respectively?
> >
> > We might want to use both the directory and the suffix, e.g.
> > fs/tests/exec_test.c, because:
> > - it makes sure the module name contains 'test', so it's obvious that
> > it's a test and it is less likely to conflict.
> > - this matches what drm is doing, and they've got the most tests thus far; and
> > - we won't be renaming the file, just moving it, so it's less likely
> > to cause friction with workflows, etc.
> >
> > On the other hand, it has few disadvantages:
> > - we end up with the same prefix issue with module names (e.g., for
> > those who have tab completion for modprobe);
> > - the module name can be changed in the Makefile anyway; and
> > - it's ugly.
> >
> > I'm leaning towards tolerating the ugliness and keeping _test suffixes
> > on the files, at least for existing tests, but could be persuaded
> > otherwise. I'd even grow to accept a test_ prefix if I had to, though
> > that'd make my tab completion terribly boring.
>
> I'd been using _test for #included files, and _kunit for kunit modules,
> but perhaps this isn't a needed distinction?

I went back and checked the original discussion on this, and there
were a few proposed uses for the distinction:
- _test should be used by default, and _kunit should be used if
there's already a non-KUnit _test
- _kunit should be used for unit tests (i.e., relatively
self-contained, execute quickly), _test should be used for any other
form of test, even if it is implemented on top of KUnit
- _kunit should be used for _new_ KUnit tests, old tests should not be
renamed if it causes friction

In the end, we had the most support for the first option, but I don't
think there's a problem reconsidering it. We do have things like test
attributes now, which can allow tooling to filter out long-running
tests (so using the name for this isn't as important as it once was).

Ultimately, I don't think it really matters much for source files:
_test is already used a lot for both KUnit and non-KUnit tests, so
it's difficult to get any detailed meaning from it. And while it'd be
nice to know for a fact that all KUnit tests were in modules with
_kunit in their names, there are enough exceptions that we'll never
have this work perfectly. As long as people can find the tests (and,
if they're in a tests/ directory, this shouldn't be difficult,
regardless of the filenames), I don't think it matters. For the module
name, it does a bit more, and #included files don't influence the
module name anyway, so we might as well go with _kunit for everything.

>
> > > And for the lib/*_kunit.c files, use lib/tests/*.c ?
> >
> > Sounds good to me. I'd rather not put them in lib/kunit unless they're
> > actively testing KUnit itself (which, under this scheme, would want to
> > be in lib/kunit/tests).
>
> Right -- I didn't want to confuse things between kunit itself and kunit
> tests, so I too prefer the "tests" directory name.
>
> > > Then we can update the docs, etc.
> >
> > Even if we don't rename existing tests, we'll probably want to update
> > these just to avoid making the problem worse.
>
> Sounds good.
>

Excellent. Let's update the docs (I think we'll go with _kunit as the
suffix as discussed in the other thread, now we have the tests/
directory), and start renaming things if there's no objection to the
docs change.

-- David

