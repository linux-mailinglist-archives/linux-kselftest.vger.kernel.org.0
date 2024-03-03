Return-Path: <linux-kselftest+bounces-5799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A672686F428
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 10:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D02C1F21AF6
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B844AD53;
	Sun,  3 Mar 2024 09:31:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43644AD2C;
	Sun,  3 Mar 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709458273; cv=none; b=bqyLeZIxiQopckT7CDbYOIHzrjGYFdaSekqsvLmQveE2x0oAHQsCwkxF6R7iDxJ06Pz6ZjOtoOqgs3cUYMCdfRRH/qoLDva/+Xhn7+Ts5c5Qn2JhpIz4h7g03ehxitkcWNva84TRJz1CiRnSee32mIRNR9GunC4ZVSBEMk7Hpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709458273; c=relaxed/simple;
	bh=qNRnfHzytu7FlNcNip2StOGlbTwoZ8fM8RaPRfKvn7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuYoBAVonfL07ymm7IAwl9oWyFxA4ce7832rMtp9sq2xNnsl+oW3vMz4di2H+7THlOmHEUbSnha0YGQN0CdO7T4BQGBdkNgGnooMsXC1ErEN92/8YMW07iC7ajjSzt2ydUimajCK+OEs5LHhDIPtqGfjDHUcuuRyTlXR+5Ot8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60978e6f9a3so31982327b3.3;
        Sun, 03 Mar 2024 01:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709458269; x=1710063069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h+cxR9Zi+zZIFamlmv2ivpOejR06HV/J+RWDkEaK2g=;
        b=bWVWXdd32OV9jL7z3RuckYbX6ZjpfdArx9zOZ8uoaUl69VnVPtIIO86irJvyzoDj53
         oJve3PEtiDG2ojA0SdD1d4YmW3BiAj4gAp0e34rgU29U/I6KQX59N5Gcixg9LBdcEa6l
         YHiq1v4uWx6p4chSLnH/NhMezMePocu8ZvEmwLUvEoR0umw21QHMHxx/YIHMyFN0pzfv
         oiDVWxxJbob+hr2i/3KHjuWlI7c6vu5pgNaD/hoagvi4n+Bvh+KTxJ8goTU71+EGQa3u
         6Y0tZcIvOlJaWcyClQaH9mvHlmQYWnWcpCFYhfRTNN80Bhfp7F12qpoAvjSAI2MT8guN
         UeUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWajYu4PJxdrfWjRDBeN/YTkaBScq40drY3jl9sULh3GWPR4bI1sU1XFuiNmJPvgFi/B/3B6LwJG4OHi3MMbRuC1qt9c0rG+YEcSNTsl7rFC4zu0hRoTqrdggveCwFDVCl6qP8QnRudCOOJNfFD31T3+XKQX/TZXn0jmxrTem2mlzmuDb4BLBu/
X-Gm-Message-State: AOJu0YwkP+KxkS4qcG/kgoa308HZgM5+V/RcxWXTvymqUkErrVBgs19z
	t9fnTH4WSUXVjBskqfW2x4gHP2h2NGONEM+X5msmFposUtApQAJaSJ5kzC8HuJE=
X-Google-Smtp-Source: AGHT+IF3gJ5Cr9PLyLFUiKhGAWk1QYjh/+IegJPCZUkNk0jRj2EtLZ8vLHRb0EU5PB7vLcze5FtwVA==
X-Received: by 2002:a05:690c:ed4:b0:607:ca2e:f23e with SMTP id cs20-20020a05690c0ed400b00607ca2ef23emr7699212ywb.30.1709458269560;
        Sun, 03 Mar 2024 01:31:09 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y17-20020a81a111000000b00607a42af275sm1970289ywg.48.2024.03.03.01.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 01:31:09 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso3465830276.2;
        Sun, 03 Mar 2024 01:31:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4zK6VTmLYkkTT+/T6EMMR6Dyp3J+IBWkSt9Vd6g+ha2WniTyk3wH8etVFe5fprffD7pF1h1Z2Wf0H8svOCv+RiLjUdWPEuaOJ2mxAvWanUHqipP6AVFwdOZZgw9d0nLS8FfvgvDswkdC6b3FIKjTkPuaeV0VneSzyxhNGfLVE8Q/PyngNcm3B
X-Received: by 2002:a81:8494:0:b0:604:9b50:e973 with SMTP id
 u142-20020a818494000000b006049b50e973mr5488306ywf.44.1709458269052; Sun, 03
 Mar 2024 01:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com> <269232e6-41c9-4aa1-9320-662beabcd69b@infradead.org>
In-Reply-To: <269232e6-41c9-4aa1-9320-662beabcd69b@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 3 Mar 2024 10:30:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXuXV9WV3aANFTteuP8Q3JY6R5OWsVBedGOP7e_JguxqA@mail.gmail.com>
Message-ID: <CAMuHMdXuXV9WV3aANFTteuP8Q3JY6R5OWsVBedGOP7e_JguxqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Guenter Roeck <groeck@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Nikolai Kondrashov <spbnick@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
	gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 3:30=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
> On 3/2/24 14:10, Guenter Roeck wrote:
> > On Thu, Feb 29, 2024 at 12:21=E2=80=AFPM Linus Torvalds
> > <torvalds@linuxfoundation.org> wrote:
> >> On Thu, 29 Feb 2024 at 01:23, Nikolai Kondrashov <spbnick@gmail.com> w=
rote:
> >>>
> >>> However, I think a better approach would be *not* to add the .gitlab-=
ci.yaml
> >>> file in the root of the source tree, but instead change the very same=
 repo
> >>> setting to point to a particular entry YAML, *inside* the repo (somew=
here
> >>> under "ci" directory) instead.
> >>
> >> I really don't want some kind of top-level CI for the base kernel proj=
ect.
> >>
> >> We already have the situation that the drm people have their own ci
> >> model. II'm ok with that, partly because then at least the maintainers
> >> of that subsystem can agree on the rules for that one subsystem.
> >>
> >> I'm not at all interested in having something that people will then
> >> either fight about, or - more likely - ignore, at the top level
> >> because there isn't some global agreement about what the rules are.
> >>
> >> For example, even just running checkpatch is often a stylistic thing,
> >> and not everybody agrees about all the checkpatch warnings.
> >
> > While checkpatch is indeed of arguable value, I think it would help a
> > lot not having to bother about the persistent _build_ failures on
> > 32-bit systems. You mentioned the fancy drm CI system above, but they
> > don't run tests and not even test builds on 32-bit targets, which has
> > repeatedly caused (and currently does cause) build failures in drm
> > code when trying to build, say, arm:allmodconfig in linux-next. Most
> > trivial build failures in linux-next (and, yes, sometimes mainline)
> > could be prevented with a simple generic CI.
>
> Yes, definitely. Thanks for bringing that up.

+1

> > Sure, argue against checkpatch as much as you like, but the code
> > should at least _build_, and it should not be necessary for random
> > people to report build failures to the submitters.
>
> I do 110 randconfig builds nightly (10 each of 11 $ARCH/$BITS).
> That's about all the horsepower that I have. and I am not a CI.  :)
>
> So I see quite a bit of what you are saying. It seems that Arnd is
> in the same boat.

You don't even have to do your own builds (although it does help),
and can look at e.g. http://kisskb.ellerman.id.au/kisskb/

Kisskb can send out email when builds get broken, and when they get
fixed again.  I receive such emails for the m68k builds.
I have the feeling this is not used up to its full potential yet.
My initial plan with the "Build regressions/improvements in ..." emails
[1] was to fully automate this, and enable it for the other daily builds
(e.g. linux-next), too, but there are only so many hours in a day...

[1] https://lore.kernel.org/all/20240226081253.3688538-1-geert@linux-m68k.o=
rg/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

