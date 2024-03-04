Return-Path: <linux-kselftest+bounces-5825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C587000A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 12:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44791F235C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01EC38DDD;
	Mon,  4 Mar 2024 11:13:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA9381D0;
	Mon,  4 Mar 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550785; cv=none; b=f/903pNL0HoY1YZ155uMiGO0iMqib9W11b5Zmuoftv0ewzqj3pHn3CfKLmO+D+ayPtGROr3Gz4IGI+qiDGCI1panTDUChfZY7uFY3PlbwNO9cfV3I9EhdjpZ7uT21D+HI28bP4qWxAfjjI+A9Pi0Zp9FZKtJZDFuBv8tz7WjSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550785; c=relaxed/simple;
	bh=BCy0Hx88WwhmnHSyuJBBAaJRbV8fYrG9jlRMWdx1Egg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXhn9YQsvQffMrE+m2uuLGYwIFWhFZIB1c4hHN4dffUbj6GpCWY7+gSRUD8LSFDdo6JeYhxDsowhxCKGBPOBMTA38s/cxjCTdiUGbBAuqLtfjfLzBGt/Pi3kVrppcsb6WOIzcqD5CHdY76hJaf8cetM1Z8vZkB87HxKk51qoHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6098bf69909so20326257b3.1;
        Mon, 04 Mar 2024 03:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550781; x=1710155581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8dLsJKtv+8j8qXEd3qFacsSzLxPyFjQtVyNStvTTTM=;
        b=Rl3+OQK8P3cblFvpPL4ZJGgLGltIy6HQbBT3Kbm+TsiOWQG8noYGj0NLrHrHNu5Vnc
         j5KX1yVqK1etO4zff8B+ncgA+qvM9gx+nwDy7yBRVe5EncLhmTmc9v9VPWJaa+eSoZKu
         w0QnxuNd33km9ROO8ehwW5uURNHkY+t5sv4+XbUV3KgiKg+W2pd9VU9j/wSha0nmw7eo
         inX6HGSGQy5RLz/wQDUPgiBoSfsS0MCcNPuA6mImfkL9YIJMwLFcrKlx61bXdqe0gZCc
         rp+7sFrbk4MHtw8CbR0gkwj4T7x0OD1qLz7VPTVauQMZYm+KSZuOjWNBhTZqkkq+ExbZ
         h+gg==
X-Forwarded-Encrypted: i=1; AJvYcCVyz6PZQkP/3d9VdzVBIoQv/O+zBn89SqFefZa8wT8U+esYfKs6H38qArbvRmfHY4eoRDrmWsEwqtCqfIWr/zirhldqHUesv9q+RREiWWmZnXmHEYBCiYemd+BVgmJO4e3qy8qlaIfdUDQfTkDlPlik2ivk+PL0WzSY980I4PemKYqZIC7QAv8Z
X-Gm-Message-State: AOJu0YxL/EAnXjVKC/Ef0Qn/0IYc7A5om9Z7GY/hf8RlAZOgkLnx8jkE
	U/0CoQ7nVkmQtIQEH0H1qo336CMpqgq2ozfLMjsxs8RqkrH6BvuLuLqghA2+I3o=
X-Google-Smtp-Source: AGHT+IGMESEWEYZbE5+BT/RgzoZuNlfDR6zie6WyT0wGeP135y7b/u4EvvLORzNzIV7O+dg2c5GaLQ==
X-Received: by 2002:a0d:e64b:0:b0:609:b59f:8352 with SMTP id p72-20020a0de64b000000b00609b59f8352mr693012ywe.19.1709550780754;
        Mon, 04 Mar 2024 03:13:00 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id bx18-20020a05690c081200b006091d284e67sm2521471ywb.54.2024.03.04.03.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 03:12:59 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3679947276.1;
        Mon, 04 Mar 2024 03:12:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW17gsnlehopKSARPZz6Y5U6NU9hUeHrFwCnwcnGZlKUi29fMDG+rrWilCBKSJP3Mfl4XRtJTpndxqDZqf8xo+rQCEwaBRrTn5pa40OlHAN6mALJlNKooFIH3Yulo8GvE4/tLcpIFv8ywE3ZID6cy34ru/MF/Otks7p7jBzEVvhx844fsR1Hjhb
X-Received: by 2002:a25:ab44:0:b0:dcc:55e9:ec34 with SMTP id
 u62-20020a25ab44000000b00dcc55e9ec34mr4965526ybi.30.1709550779663; Mon, 04
 Mar 2024 03:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat> <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <269232e6-41c9-4aa1-9320-662beabcd69b@infradead.org> <CAMuHMdXuXV9WV3aANFTteuP8Q3JY6R5OWsVBedGOP7e_JguxqA@mail.gmail.com>
 <CAMuHMdWi069YAvOoXe7sHJ_o702tY4tDQgL3sfApPR3aCnZboQ@mail.gmail.com>
 <20240304-transparent-oriole-of-honeydew-f4174e@houat> <CAMuHMdXyvcyXw8eXc2MONNaBYYGpVdnPh2h3T=QV38MEUzhu9A@mail.gmail.com>
 <20240304-dangerous-mastiff-of-fury-1fac5c@houat>
In-Reply-To: <20240304-dangerous-mastiff-of-fury-1fac5c@houat>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Mar 2024 12:12:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2HkYjowOZBgSZQ3N01UeUTnyv5kjx-82C9YJ+dsgsxQ@mail.gmail.com>
Message-ID: <CAMuHMdV2HkYjowOZBgSZQ3N01UeUTnyv5kjx-82C9YJ+dsgsxQ@mail.gmail.com>
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

On Mon, Mar 4, 2024 at 11:20=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Mon, Mar 04, 2024 at 11:07:22AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Mar 4, 2024 at 10:15=E2=80=AFAM Maxime Ripard <mripard@kernel.o=
rg> wrote:
> > > On Mon, Mar 04, 2024 at 09:12:38AM +0100, Geert Uytterhoeven wrote:
> > > > On Sun, Mar 3, 2024 at 10:30=E2=80=AFAM Geert Uytterhoeven <geert@l=
inux-m68k.org> wrote:
> > > > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.k=
o] undefined!
> > > > make[3]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> > > > make[2]: *** [Makefile:1871: modpost] Error 2
> > > > make[1]: *** [Makefile:240: __sub-make] Error 2
> > > > make: *** [Makefile:240: __sub-make] Error 2
> > > >
> > > > No warnings found in log.
> > > > -------------------------------------------------------------------=
>8---
> > >
> > > The driver is meant for a controller featured in an SoC with a Cortex=
-A8
> > > ARM CPU and less than a GiB/s memory bandwidth.
> >
> > Good, so the hardware cannot possibly need 64-bit pixel clock values ;-=
)
>
> This is an early patch to convert that function into a framework hook
> implementation. HDMI 2.1 has a max TMDS character rate of slightly less
> than 6GHz, so larger than 2^32 - 1.
>
> So yes, this driver doesn't need to. The framework does however.

That's gonna be interesting, as the Common Clock Framework does not
support 64-bit clock rates on 32-bit platforms yet...

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

