Return-Path: <linux-kselftest+bounces-48343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1761CFACEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2607131B9B78
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D633CEA5;
	Tue,  6 Jan 2026 19:35:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB533CEA1
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728111; cv=none; b=sP9OUCo/aUyzj1bp7Ks00+3vJdAf0UiRfRhJBn956YM3gVkReYAQqkRDQMC2BFWCQj0t+0O2YLqesu9bQH+seACmEjIZ9F3SRG0aTFNRRIFznpwK+nTHs0a08bIRlom60Zc3GG0evP2cor9ChJcc1ick2o/71OZwFWaeXS4IgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728111; c=relaxed/simple;
	bh=x7/QQp9XL6uTCnagg64Z2+1OMIMLZWV3AkfDCmxY+EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaT8fD123L748mkMzS0M8tmOoIZ2DaNyRj6fWd3+KS/lk5u3wnQ5k5n2Qb0R47F+gREoxjkvjuFCMGsAKZ2fquQ57pZqhnl/0VnJFCpABVt2GXzOqbAe3GQ89hYea1XuOrNkeZ4oWoybz5J7WaVi6uKOzwfw3MT0HMIP/I6sqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-56021f047d6so391591e0c.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 11:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728109; x=1768332909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnGqZJ/wg2iPwZiZPDKgK8JJKRw89sDJ8l667rg2Ahc=;
        b=kQ4PUgNI8embenr3m1XxJgK9aqGDHo+A2KE7X0mqe3j3WKAvAwvtgLz7v8MymOSYar
         yN9A5jLQcoJ3qkq4irnADvt2eNppJbthHyiJNyt/guSPzHaIV6D3wK2f42kJ4HEuX1Bf
         NieqXD+JImAF4759q3t/cgA9L5at/FKo+Fx9i6Bv6VA7bsUugsJngI+np9mrtwV1gT4p
         qCYj8TNTSNAO1u4v+VIzlWV75mm8XHyRVVir9N2jZUBcvY/HNeFlUpEd40D+P5Q2y7db
         zgd8yTJ1KNtlWTZV3k9Rz0kYM2FwUHkx14BKXpAX63sipH6JfyKgazG4gTFdDD+Ph7E0
         VR8g==
X-Forwarded-Encrypted: i=1; AJvYcCX3sMfDwcSO8a6ZQo8rAMpmyth9y1P8VUoszvF8lMFEcGq9hiF68896PGPp/RSBoMeih3RhInm9UmWsXm9fAKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkaFJTA3nbNJFAJiGio8sh1UW7NDrQD4TiJ37svykIODwXhs0n
	LByv34MuA9uLCriQQj8Pv6eLMU/gWSO8vuYTnjyLkNirEq3cYK7FZmDHMDEscv33
X-Gm-Gg: AY/fxX6IewGKceIrboqPSglVxTqncPhzQEg5OS/4GA/CLfgmZn4c/zxS1unTwyGy+M3
	ih3v24RUbtF7JrAQTatcJxJWVxCkjaOHLW1ptJxgIqn3jJO6mD9dfmQXXoY2SU5o4P2JorAVmK0
	liVq4N2UOYZRQDvd2vBVoWhNF8LHUsiOHjZwMLmuTS+nzXVqSGUvx+6OwE0JRMh3L6yaGHWCi0V
	k9nU6DqNKx7N3+DI+0fqojfKn9yxgv4WE3LHJaY+z6/hJIyT0P+xty9DT+gCi17Ydba+kPIw6zJ
	UH1U1q0isx1fC15x+rNBXLGS9goRlDqaDa/Z/mQVIGFTm5U1AFAHyap8rDxuTkfETdW94Pm6O56
	DT1Wj03YmfIp+ezP5UBYmC0ZPcOVCbZ6a+ZYLcrIhDtuhb3y4n7KWPioTRKvufxym24ytEJG92j
	LwQ3r5xh29/9wVXFhHQjJGuh+4OWzuLN5EKRJvkq9XtsksAHvz
X-Google-Smtp-Source: AGHT+IHoMtkuF0mDaQKD8l4CBx3S/DLI1+oFxY5iVQ0nPVnHrZKNS8Use/gd7ebUcfUpnlvr6pes0w==
X-Received: by 2002:a05:6122:311a:b0:559:ef6b:1ef4 with SMTP id 71dfb90a1353d-56339562b51mr1098618e0c.15.1767728108118;
        Tue, 06 Jan 2026 11:35:08 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a414155sm906423e0c.15.2026.01.06.11.35.07
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:35:07 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9412512e9f3so397188241.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 11:35:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYUTQP/tNXbdgqAxcQcnvfWlIbsfFKg1N7jNMUsfFWt8mVo66jDnLvtRri4xzqeoYcfeIEGgO/s4CdL7S9M/Q=@vger.kernel.org
X-Received: by 2002:a05:6102:560f:b0:5de:8e5:222d with SMTP id
 ada2fe7eead31-5ec744a59c1mr1207568137.22.1767728107723; Tue, 06 Jan 2026
 11:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
 <CAMuHMdUHBm_oiyeUumRc=avp+QCiCLZAfi0BvLwToAM3TumGmQ@mail.gmail.com>
 <18bb48f2-b5aa-42a6-bc09-4773e1907670@t-8ch.de> <CAMuHMdWBs5nGWEyvu7F+kWB4dMwEOvtqzdYnT+NE3YtU48udwg@mail.gmail.com>
 <e7eca29c-dca1-49c0-88ae-ece904209d1b@t-8ch.de>
In-Reply-To: <e7eca29c-dca1-49c0-88ae-ece904209d1b@t-8ch.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 20:34:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVyntSex=O1LX3aWKWc2cr8BBr1hMwV1SWHY5_CvK0sfw@mail.gmail.com>
X-Gm-Features: AQt7F2rmRiQLbY4mAmilRUBXeKygsYrC9Saqe-ovoE_S7d6iWgbyODoD5mypUNg
Message-ID: <CAMuHMdVyntSex=O1LX3aWKWc2cr8BBr1hMwV1SWHY5_CvK0sfw@mail.gmail.com>
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, 6 Jan 2026 at 19:32, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> w=
rote:
> On 2026-01-06 14:36:23+0100, Geert Uytterhoeven wrote:
> > On Tue, 6 Jan 2026 at 12:47, Thomas Wei=C3=9Fschuh <linux@weissschuh.ne=
t> wrote:
> > > On 2026-01-06 12:40:12+0100, Geert Uytterhoeven wrote:
> > > > On Sun, 4 Jan 2026 at 23:14, Thomas Wei=C3=9Fschuh <linux@weissschu=
h.net> wrote:
> > >
> > > (...)
> > >
> > > > > --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> > > > > +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> > > > > @@ -117,7 +117,7 @@ DEFCONFIG_riscv32    =3D rv32_defconfig
> > > > >  DEFCONFIG_riscv64    =3D defconfig
> > > > >  DEFCONFIG_s390x      =3D defconfig
> > > > >  DEFCONFIG_loongarch  =3D defconfig
> > > > > -DEFCONFIG_sparc32    =3D sparc32_defconfig
> > > > > +DEFCONFIG_sparc32    =3D sparc64_defconfig
> > > >
> > > > How can we test sparc32 using a 64-bit kernel?
> > >
> > > CONFIG_COMPAT=3Dy
> >
> > FWIW, testing 32-bit userland on a 64-bit kernel is something completel=
y
> > different...
>
> I can't really follow. We are testing the userspace nolibc here and
> assume that the kernel component already works correctly. Whether that
> is a native 32-bit kernel, 64-bit kernel with CONFIG_COMPAT=3Dy or even
> qemu-user-sparc doesn't really matter in my opinion. What am I missing?

Oh sorry, I thought this was part of the actual nolibc implementation
used by the selftests, not a test for nolibc itself.
>
> > > Please note that this changed in (the now committed) v2 anyways:
> > > https://lore.kernel.org/lkml/20260106-nolibc-sparc32-fix-v2-1-7c5cd6b=
175c2@weissschuh.net/
> >
> > Sorry, I hadn't noticed the newer version, as the latter does not
> > include some keywords to trigger my interest ;-)
>
> Now I am left wondering about the specific keyword that triggered on v1
> but not v2 :-)

"m68k"

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

