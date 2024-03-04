Return-Path: <linux-kselftest+bounces-5823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D8886FE66
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E6CB21F65
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24F2233A;
	Mon,  4 Mar 2024 10:07:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A519BA6;
	Mon,  4 Mar 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546860; cv=none; b=eyfZbd9C9SR83Qm3UsEkreCEYqpYRp+Pgfvtp7C068DBaCvQqsPFJKogwisxwOnmiuXcWcrgzzg+8pV6G/LEe8NfYf8vDtGkZxUlEQlmZa4++Zj4MFenXfyfEQJG9jhop0H2pfgmshVHpXeORjsZSZeGfBvywfIXh2RCZTYGACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546860; c=relaxed/simple;
	bh=ItdYRVoq54OKq2AVn5zcTMjjQ4E7x0re7IeusVb+ZrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDDuP9NGKm5YLTm1t5xMFBXvZrgbJDi8SpE67IX6/phKRWzEoMAsn+GCC70mRNA6iRq+zjSp1ZbbfHF+wP3+GmvgTeKdiHwNKgPuCDN8HSOpRX4PHC+8cPkWUdZ86bnO3JLTutyHBA8Q9z2UDh06L/le+KvrRU4FqzMpqbLtkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6095dfcb461so40086787b3.2;
        Mon, 04 Mar 2024 02:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546856; x=1710151656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER0dUVit3cfqDNJxrJfG+KdxGIXN2zcWnKvfnV+eZ4A=;
        b=P0KV7+4kMn/JHEAugUwfHtAF5FvkI7tUHQ6JneqKSXm2owOef3wbvZuFeStqvBUEhj
         +j8JAc5nJfiyyiwksWPlgdKZVtGfsPQg6TP88vBLoC+uTdk5qJcxEJDOuHIJb2wlPqeQ
         Jsq7ISPV7weCSM5a9pZPlYWxkUPiCw0QkulwQmEiNJCKCLzy4Geq22RXuZhdPJo8q58c
         qnBPxW7gVySFd1TgsFLcls14nldnNKs/ICDMDW+7LZCwnrLZPQf1q9ZD6MUHbfyeSJf1
         VvbqXSRMvZM8hpbbpu/PwY/hQhbbQyHL+Ru8ANAFbz79JSV9Xm02jJ4jXOFh+cJpnlex
         2/pA==
X-Forwarded-Encrypted: i=1; AJvYcCVPN0RkIWxx/0vFKJx/Cv0zxtpDZ9r2/ZJPNYavCutZb0nJqHQNTPiaNnqyy37CheGQ3wjXe2a/39nd/5SLMU0xlxfNIj7Iw5AjSmhZvGbIQjEh5pNE8RjJvrXmNOzJoghKtF9oxzd1zI0fKH7xcn2Rem+7uPphYrdNzuMkpExp5keWgcII7kHe
X-Gm-Message-State: AOJu0YwY1Myx2PITwyu6qX3BTa1h8mdVXI9sqK/vD8FCsnDLaKAdZNAM
	keCJbCpbAtogvSg1KUxPxHRvzRf9zBwH2NJMi+dyynIjO2pv5hTakUwXwGCxSiw=
X-Google-Smtp-Source: AGHT+IGSX0Qke3WlqBFpd4EhNxWre9v3aaJ3FphzDLDMm6A1E+XV/jHBQ+2/w/X4kYvKG+9WjSsUyA==
X-Received: by 2002:a0d:db83:0:b0:609:740a:c782 with SMTP id d125-20020a0ddb83000000b00609740ac782mr7436411ywe.17.1709546856125;
        Mon, 04 Mar 2024 02:07:36 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id by18-20020a05690c083200b006096c7415c2sm2458758ywb.26.2024.03.04.02.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 02:07:35 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60983233a0dso32844557b3.3;
        Mon, 04 Mar 2024 02:07:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrYJE2VeKsr4IMQweCfu2TYwz7Pbgx8CDjcuwN76Tigq+SdyVdti9J4+flYTdKLdrwV0NmBJB+187EAWIOSgI+r78Ix4fLPUUbExR86dLXSCLbnRoqX3kNW5Vb6Nu7x6VmmpeSEJF2BzbuJNrFum/P2B8O/l4YFxABhzxVKpOP4njzaeHapZXx
X-Received: by 2002:a81:9856:0:b0:609:7e98:1562 with SMTP id
 p83-20020a819856000000b006097e981562mr6776283ywg.38.1709546855021; Mon, 04
 Mar 2024 02:07:35 -0800 (PST)
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
 <CAMuHMdWi069YAvOoXe7sHJ_o702tY4tDQgL3sfApPR3aCnZboQ@mail.gmail.com> <20240304-transparent-oriole-of-honeydew-f4174e@houat>
In-Reply-To: <20240304-transparent-oriole-of-honeydew-f4174e@houat>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Mar 2024 11:07:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXyvcyXw8eXc2MONNaBYYGpVdnPh2h3T=QV38MEUzhu9A@mail.gmail.com>
Message-ID: <CAMuHMdXyvcyXw8eXc2MONNaBYYGpVdnPh2h3T=QV38MEUzhu9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Maxime Ripard <mripard@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Guenter Roeck <groeck@google.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Nikolai Kondrashov <spbnick@gmail.com>, 
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

Hi Maxime,

On Mon, Mar 4, 2024 at 10:15=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Mon, Mar 04, 2024 at 09:12:38AM +0100, Geert Uytterhoeven wrote:
> > On Sun, Mar 3, 2024 at 10:30=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Sun, Mar 3, 2024 at 3:30=E2=80=AFAM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> > > > On 3/2/24 14:10, Guenter Roeck wrote:
> > > > > While checkpatch is indeed of arguable value, I think it would he=
lp a
> > > > > lot not having to bother about the persistent _build_ failures on
> > > > > 32-bit systems. You mentioned the fancy drm CI system above, but =
they
> > > > > don't run tests and not even test builds on 32-bit targets, which=
 has
> > > > > repeatedly caused (and currently does cause) build failures in dr=
m
> > > > > code when trying to build, say, arm:allmodconfig in linux-next. M=
ost
> > > > > trivial build failures in linux-next (and, yes, sometimes mainlin=
e)
> > > > > could be prevented with a simple generic CI.
> > > >
> > > > Yes, definitely. Thanks for bringing that up.
> > >
> > > +1
> >
> > > Kisskb can send out email when builds get broken, and when they get
> > > fixed again.  I receive such emails for the m68k builds.
> >
> > Like this (yes, one more in DRM; sometimes I wonder if DRM is meant onl=
y
> > for 64-bit little-endian platforms with +200 GiB/s memory bandwidth):
> >
> > ---8<------------------------------------------------------------------=
-
> > Subject: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Mon Mar =
04, 06:35
> > To: geert@linux-m68k.org
> > Date: Mon, 04 Mar 2024 08:05:14 -0000
> >
> > FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Mon Mar 04, 06:35
> >
> > http://kisskb.ellerman.id.au/kisskb/buildresult/15135537/
> >
> > Commit:   Add linux-next specific files for 20240304
> >           67908bf6954b7635d33760ff6dfc189fc26ccc89
> > Compiler: m68k-linux-gcc (GCC) 8.5.0 / GNU ld (GNU Binutils) 2.36.1
> >
> > Possible errors
> > ---------------
> >
> > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] u=
ndefined!
> > make[3]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> > make[2]: *** [Makefile:1871: modpost] Error 2
> > make[1]: *** [Makefile:240: __sub-make] Error 2
> > make: *** [Makefile:240: __sub-make] Error 2
> >
> > No warnings found in log.
> > ------------------------------------------------------------------->8--=
-
>
> The driver is meant for a controller featured in an SoC with a Cortex-A8
> ARM CPU and less than a GiB/s memory bandwidth.

Good, so the hardware cannot possibly need 64-bit pixel clock values ;-)

BTW, doesn't the build fail on arm32, too?


> And I just sent a fix for that one, thanks for the report.

Thanks!

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

