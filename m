Return-Path: <linux-kselftest+bounces-5522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8186AC00
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 11:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3124A1F229A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823123BB4F;
	Wed, 28 Feb 2024 10:15:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79893AC1E;
	Wed, 28 Feb 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115348; cv=none; b=MQ4s5lHwiWBuuk5CSSqfRBcz3QK/fUHG4OUdVOMRjTLztsuDqHX3xR6Z2UFBhZYE18ry8/Q15e1cTQAI7NSqBkqsKPEpf7CtOX/3LITo0a1YTVS+thWHDDosolYdxtanQsKVO98sqBD8hB8+Gp4Bbcbi7DJ4EB6YabYyRml8+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115348; c=relaxed/simple;
	bh=JXWi3QJrd65veDhHNrOB2GuMIcSXUkgzzrY8SPVTSXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsYDGpMplLpX4I4MNORyVkqu03viAtjMeRq3d84rJOeD2Hj2hKccmNt9RLIiyUGvvpLW3kun16wTafXfJ0xT+DV1P1j/pinTQPjXgn4fk2kAZr8R4Q/NTXrKt/m0+BDoXncMrAMvwve6+gujAdBN4DkBaCYEui2JcGHxcrL8aWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608959cfcbfso56258327b3.3;
        Wed, 28 Feb 2024 02:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115345; x=1709720145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sisHDeqoo8my2vybw8Rh8HLkZ37ptybG5ZlPOOTIA0=;
        b=SrOlw4kGc5GQlPwaJXDodMxm6MkdNXmmY4+N23VAT/OmMZ62qbdi7zlvhUPa75rbou
         YUsK3jYogXC8yGW95lpl+G3U3D9Px4D2XKG90tO2tQRxBwjuILNiOK9bVkTVXL3t0yW7
         S0G8fAamnI5iWtadD/+BqrMKbNGg1Gf5spzJwp2csdfFJ0eV/0cSFVYrYNBDLBP2Djeu
         M/fsUrIwz7j0jwLEv41X+6ZYGELWQ67WVvro1rj2wzdB0s1rt57O/siKXIecEF8JfNbQ
         6hcade1TKJPtTBb+13i0gP12LArGRSFP1FhT4FRfDDosXL04sAwseQUiDveXo9UwnXg0
         Jm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXprdae49aozTqwgdJSXNAU152dREgA45PI32+YLYX54d6BTVRBIYJUnYLxnrK0hlQEufqn6rsImtInbCaymoHFekCiE6caXZMQtY7HqY9J6NYsWPQvKx5okn5KJsRKm1IFibQ4UparT04B//xRT2Ysw+5LyQyaydHtg9Ka63pzWnxoZpDu5GAsLtEw
X-Gm-Message-State: AOJu0YyHt014n3WDzYQNivndWnovI670lUxw8sDWrJvP2n6cltzHml+h
	n5uwThK4k02hRGVqfesiPFRav7EFfIj0Zzrt+bNXZLEBf60yOMdv6tq1N1SUABcUzA==
X-Google-Smtp-Source: AGHT+IFwIykTXE9M7RomK7vpBNurVSTHX9Dk/OfhtigZLyyIrG4fW7NF3RWMMFuS3syFCCed9fnY3g==
X-Received: by 2002:a0d:e24b:0:b0:609:3a3b:1728 with SMTP id l72-20020a0de24b000000b006093a3b1728mr1718801ywe.26.1709115345512;
        Wed, 28 Feb 2024 02:15:45 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id be19-20020a05690c009300b00608d9a50b59sm2079531ywb.28.2024.02.28.02.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 02:15:45 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608959cfcbfso56258107b3.3;
        Wed, 28 Feb 2024 02:15:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViBXXGabQVKAhXLQSZXSGZPloGXYNDDNfKbMvpLqdxH952diQZsSlkE2cXKBosBtGgTJ1LUzkYwh3wQc7//t4JGcVVUHLKKh+UP52KomlL3FEEbMe5eNbHKlSwTtyhdMrZVPViJ7greejeIkFGfdXQPHu33JpKrfui+T5dyPvyEs9ohmhwyJAEs4sY
X-Received: by 2002:a05:6902:1a47:b0:dcd:ad52:6927 with SMTP id
 cy7-20020a0569021a4700b00dcdad526927mr2537761ybb.11.1709115345066; Wed, 28
 Feb 2024 02:15:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net> <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
 <ZdzZ5tk459bgUrgz@ghost> <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net> <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk> <Zd58jvN3PjQSe+yt@ghost>
 <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu> <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
In-Reply-To: <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 11:15:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-sUYr8_y6av9Dbtz6JJAxBUsiTGZcK2QYEHo0x1z44w@mail.gmail.com>
Message-ID: <CAMuHMdW-sUYr8_y6av9Dbtz6JJAxBUsiTGZcK2QYEHo0x1z44w@mail.gmail.com>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
To: Guenter Roeck <linux@roeck-us.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Charlie Jenkins <charlie@rivosinc.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, David Laight <David.Laight@aculab.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Helge Deller <deller@gmx.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC testing

On Wed, Feb 28, 2024 at 8:59=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On 2/27/24 23:25, Christophe Leroy wrote:
> [ ... ]
> >>
> >> This test case is supposed to be as true to the "general case" as
> >> possible, so I have aligned the data along 14 + NET_IP_ALIGN. On ARM
> >> this will be a 16-byte boundary since NET_IP_ALIGN is 2. A driver that
> >> does not follow this may not be appropriately tested by this test case=
,
> >> but anyone is welcome to submit additional test cases that address thi=
s
> >> additional alignment concern.
> >
> > But then this test case is becoming less and less true to the "general
> > case" with this patch, whereas your initial implementation was almost
> > perfect as it was covering most cases, a lot more than what we get with
> > that patch applied.
> >
> NP with me if that is where people want to go. I'll simply disable checks=
um
> tests on all architectures which don't support unaligned accesses (so far
> it looks like that is only arm with thumb instructions, and possibly nios=
2).
> I personally find that less desirable and would have preferred a second
> configurable set of tests for unaligned accesses, but I have no problem
> with it.

IMHO the tests should validate the expected functionality.  If a test
fails, either functionality is missing or behaves wrong, or the test
is wrong.

What is the point of writing tests for a core functionality like network
checksumming that do not match the expected functionality?

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

