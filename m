Return-Path: <linux-kselftest+bounces-3209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3A831D81
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127C71F238C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790629436;
	Thu, 18 Jan 2024 16:22:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9A2C191;
	Thu, 18 Jan 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594941; cv=none; b=V7dfXIGLHngHSHlLQ9h9W++a3ReHopkoVLVUBX+2cTNUH813hLkl7eOUuWw30qxUIhVfyFsCfJa9jMk5wGh2jK6mmwfhIZNxWUlzbcFrFqJI9A58xryAtdy0i2q1bxqNvvH5Izg72ePqg0gu0g6UmmAjUBN2wYWp5k2s7rnTSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594941; c=relaxed/simple;
	bh=qPzK6gVFp3Jx3vDLYl65XpUDJJEvx4TME7a9OfF/BS4=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=XjVd89ZtgGLiVF31Xkd82685Bz37z9XjyRLoi7Aj25t2MeO8U+awn03cJA5/v3Q/wNEDuf1JMCVYbilI6wfzZg3kb2jkfHxWJCqeIiThnLAyUhY/FWWwfVhQ6tmJ+nCLVR9KIMVIHrvBTXGhb0XoDFtuUYW/olCBzt1beXW57Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f8cf76ef5bso115564427b3.0;
        Thu, 18 Jan 2024 08:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594938; x=1706199738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1ZHBh2IhHUk6R0mb0HwNUYRqWpgjfOFml5hWvgYMDU=;
        b=gdZlFlMg/+UKTmNa5cZ6eBtX9LavcIF+pE8O+M9s/8xUssjdpxpjvlhpY9Aco4Wh+W
         DCIJifGShRaTxgrL42LRuyCxCdJxQuhWrXeNyRv93aCCv+8E4D7sL9SXvuJeYhHRSnuh
         ByWAMtAA1l3ie3cKyMlX396YjrfX7Tbf6sAm9f+w/7wqTM9fHfOaJq8Z55PeO02iI01L
         z0bWxhAlxA0cZAIfFYMXCWK2GnkT6gYPo5cMw87FWi7nScFujE+JIumpxlSXwsO0UUoG
         Mdu3qDcz0DfxtddepcWZUuzLszpl0p8ATiajHgA1hMGbmSoPCxCgEAhalc7kfmqvZE+8
         +Mcw==
X-Gm-Message-State: AOJu0YwjwYs2jh9hn+V6Pr8NkDkigQzeHNhXQepKXOmcNoy55Q930TfJ
	t8nfySyz/ZkbZNu6Tj9B2kge9GmzwssR012Mmf0OAuLh6wGmDuGusdI3l//AqeA=
X-Google-Smtp-Source: AGHT+IHUuGGvnRS3UHcJCDKV6s7skaYjxFy1kjDijpAobnDrNgk8lI82gVuS0UufXdeKFlIMCvW4PQ==
X-Received: by 2002:a81:de4b:0:b0:5f7:9a2b:fd0a with SMTP id o11-20020a81de4b000000b005f79a2bfd0amr1128415ywl.35.1705594937789;
        Thu, 18 Jan 2024 08:22:17 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id r124-20020a819a82000000b005e92fd632e0sm6806716ywg.24.2024.01.18.08.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:22:17 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso2155921276.0;
        Thu, 18 Jan 2024 08:22:17 -0800 (PST)
X-Received: by 2002:a25:748a:0:b0:da0:3bfc:b915 with SMTP id
 p132-20020a25748a000000b00da03bfcb915mr1030675ybc.11.1705594937194; Thu, 18
 Jan 2024 08:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N> <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
 <ZalCcivD0vXpQfr9@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZalCcivD0vXpQfr9@FVFF77S0Q05N.cambridge.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jan 2024 17:22:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVW+zBU-7OEpsMZKFfkFbyN98jatG0RsLuzZmXKWavNAA@mail.gmail.com>
Message-ID: <CAMuHMdVW+zBU-7OEpsMZKFfkFbyN98jatG0RsLuzZmXKWavNAA@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Jan 18, 2024 at 4:23=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
> On Tue, Jan 16, 2024 at 03:13:42PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Jan 16, 2024 at 12:51=E2=80=AFPM Mark Rutland <mark.rutland@arm=
.com> wrote:
> > > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty=
 DTB
> > > > on platforms that don't boot with a firmware provided or builtin DT=
B.
> > > > There's no harm in calling unflatten_device_tree() unconditionally.
> > >
> > > For better or worse, that's not true: there are systems the provide b=
oth a DTB
> > > *and* ACPI tables, and we must not consume both at the same time as t=
hose can
> > > clash and cause all sorts of problems. In addition, we don't want peo=
ple being
> > > "clever" and describing disparate portions of their system in ACPI an=
d DT.
> >
> > We'd get to the latter anyway, when plugging in a USB device where the
> > circuitry on/behind the USB device is described in DT.
>
> I don't understand what you mean there; where is the DT description of th=
e USB
> device coming from if the DTB hasn't been unflattened?

Either stored in (FLASH) ROM on the USB device, or loaded from
/lib/firmware/.  In both cases that would be handled by the USB driver
for the device.

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

