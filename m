Return-Path: <linux-kselftest+bounces-5815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14686FB61
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 09:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0342EB2134B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF014ABC;
	Mon,  4 Mar 2024 08:12:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32994171AC;
	Mon,  4 Mar 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539975; cv=none; b=nOzk/Pt6GKmRht0LgQoZRqw2fCm8IAL3uIKrtUuQUS7spmq1yx+LbnGsh5Lwrsv9OKYHR08IOI+sXZZPh093/vVAu97CNSo065KKR+8z+M4Qicn1Lup4e0F78e7+8JDcJqKf9E2TKKD+nIriQw0DMvqNGTVbq0sgmvf0ZJU6LWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539975; c=relaxed/simple;
	bh=dSPakM85splPyrahmvvAIpbuGYBrhOcpQ6LPsHcXsTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPbbW1bFxVOwRA0G44HSDTnpmRKyby+sWOtznZdWzJuHMq5l6SB8qsfIssz6BVgIneRnckzET34Y8V5GIaSdvE2Uu813AYofr0MUgqEThZLRzNVj4JN8FLIL4lvNyF9o2erWmkROAwrP7T8jwTqwFn3davW9XqXETjwnsouT5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6098bf69909so18938067b3.1;
        Mon, 04 Mar 2024 00:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539972; x=1710144772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J1p7SXZtqr3McfoeaXd0vJRTrL26m9P2IwKT4zVhdI=;
        b=XN5BvxHbBRwoajkhEYE2+RTjQwojxG/PFIAEfsNgkXvIkxoGF3Tkz8ylt8OPu+eCJV
         U7Vbxhh/RdJA9k7SGbIae4eKSeNIs4C2izgjA1W7pnYdjbv4046gaWYNx43TZfmtoqkS
         QKzFJY2AFcNlvX9asYxIZI+B1ZUt4LdlGSHzeoqsDM4Rih0qzEoD/QHjq3tJ2aAduNdb
         BxqbHGtwSTmuEqTS6eyEYLKUVGOmJ7adUXtBvlD+Oe3GnxrAW+4nuNqPVMOjtCs5qVj9
         mMq1Q5KY3djoph4I4Mv3Z46/B3dQVZcnqMGEILhB0wvA4gG2gKOjABkiCrkYFysokA2P
         Fw3g==
X-Forwarded-Encrypted: i=1; AJvYcCXqd7e579pUuczC1ugfXbMMq9Dpjv0w6Cm9c7rLmFTdhGi8q7yceLkZ6FC0p6upnfJ/tKeL5I5U2xasqgQj2agXOmZS3CUGXPkivzFO+Twb06RAgeKWFMKSaEXnAEn/+fyStUBA3KOjCdbocf5y4J7RUtaWOQ8B0wBLymJFUGzZ4oPC5SxptSht
X-Gm-Message-State: AOJu0Yy15iujqPbg8YdKQuBiVwKt3t/ztWQuXGwx9dCth7rSWZifNqVu
	m9kFfqoKKuSGm7Q7HSwaVklWR/IioQfMn18Bdl97Tv5CKUzLapDU+Sp1B27nQE0=
X-Google-Smtp-Source: AGHT+IFNELEY4dPLfn3VT/vThjEP4pg8tuhkEWou8DCLplV2tuC/UeN2S2bJXZpeJpY/1vQlZDfd5A==
X-Received: by 2002:a0d:e649:0:b0:608:d4a0:1dbe with SMTP id p70-20020a0de649000000b00608d4a01dbemr5274261ywe.15.1709539971725;
        Mon, 04 Mar 2024 00:12:51 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id m3-20020a819c03000000b00608d0a088e3sm2456535ywa.120.2024.03.04.00.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 00:12:50 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6098bf69909so18937977b3.1;
        Mon, 04 Mar 2024 00:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyyYp137yqO/FmYYnwkUQF+62shIfrTgI1uSHPQc/dwR/wvwt6TIdBFqt2TPvfhz8SoYlCHdBTaOWJkYJ0jYgUkOI0xCsti7ZO2osAWKKRCORhGd/vjxWR/CCvVaHp94vy3b8oyR7ZIR9mNK2pqXWtrKNk1HahBX+8UyAs27TWgpdjgWcA2TCY
X-Received: by 2002:a81:451c:0:b0:609:7699:dc63 with SMTP id
 s28-20020a81451c000000b006097699dc63mr5362566ywa.9.1709539970555; Mon, 04 Mar
 2024 00:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <269232e6-41c9-4aa1-9320-662beabcd69b@infradead.org> <CAMuHMdXuXV9WV3aANFTteuP8Q3JY6R5OWsVBedGOP7e_JguxqA@mail.gmail.com>
In-Reply-To: <CAMuHMdXuXV9WV3aANFTteuP8Q3JY6R5OWsVBedGOP7e_JguxqA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Mar 2024 09:12:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWi069YAvOoXe7sHJ_o702tY4tDQgL3sfApPR3aCnZboQ@mail.gmail.com>
Message-ID: <CAMuHMdWi069YAvOoXe7sHJ_o702tY4tDQgL3sfApPR3aCnZboQ@mail.gmail.com>
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

On Sun, Mar 3, 2024 at 10:30=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Sun, Mar 3, 2024 at 3:30=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> > On 3/2/24 14:10, Guenter Roeck wrote:
> > > While checkpatch is indeed of arguable value, I think it would help a
> > > lot not having to bother about the persistent _build_ failures on
> > > 32-bit systems. You mentioned the fancy drm CI system above, but they
> > > don't run tests and not even test builds on 32-bit targets, which has
> > > repeatedly caused (and currently does cause) build failures in drm
> > > code when trying to build, say, arm:allmodconfig in linux-next. Most
> > > trivial build failures in linux-next (and, yes, sometimes mainline)
> > > could be prevented with a simple generic CI.
> >
> > Yes, definitely. Thanks for bringing that up.
>
> +1

> Kisskb can send out email when builds get broken, and when they get
> fixed again.  I receive such emails for the m68k builds.

Like this (yes, one more in DRM; sometimes I wonder if DRM is meant only
for 64-bit little-endian platforms with +200 GiB/s memory bandwidth):

---8<-------------------------------------------------------------------
Subject: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Mon Mar 04, =
06:35
To: geert@linux-m68k.org
Date: Mon, 04 Mar 2024 08:05:14 -0000

FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Mon Mar 04, 06:35

http://kisskb.ellerman.id.au/kisskb/buildresult/15135537/

Commit:   Add linux-next specific files for 20240304
          67908bf6954b7635d33760ff6dfc189fc26ccc89
Compiler: m68k-linux-gcc (GCC) 8.5.0 / GNU ld (GNU Binutils) 2.36.1

Possible errors
---------------

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undef=
ined!
make[3]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[2]: *** [Makefile:1871: modpost] Error 2
make[1]: *** [Makefile:240: __sub-make] Error 2
make: *** [Makefile:240: __sub-make] Error 2

No warnings found in log.
------------------------------------------------------------------->8---

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

