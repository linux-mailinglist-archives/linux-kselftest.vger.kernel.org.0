Return-Path: <linux-kselftest+bounces-3187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06042831508
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 09:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A69A1C22117
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 08:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278FF125A2;
	Thu, 18 Jan 2024 08:46:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E43C15B;
	Thu, 18 Jan 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567565; cv=none; b=Y6+2VoTp/C+xt5SWpyYFIOo9jIK+smeEJxJsvsOtxuib2ZytNITidrMrDgd4n2Dx98eMPLNmLXqii8Hcgdn3W4y2aJYucm2jzTQx/1nIzHUPTO/9faj9qg20apsaG+3Oo4iy8qcCP2HMZgUM8r186WaEjVQooCpMxpQJrNzBJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567565; c=relaxed/simple;
	bh=01BoHNQA6T6yKlyGx8npZBgE/grUaHHDD/eN3XO2uNg=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=tr1/PNr4/sJkuBS8JhCC2QXNRBtsIdYGCKspj+hinxAYbtohCq/psW3Op4kpmvEZB78QLhf5hptIqZJ/4paR113avja56nNUzB8I0aRo3Qhf2BqE3kqSyCWAgVxpBQZW4QB6A/jRvzxOrrJg0Qhj/PfTTAb1i89ROowCPvspUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f00bef973aso123974157b3.0;
        Thu, 18 Jan 2024 00:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705567562; x=1706172362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8e3GAGk3S+G/Tg/kgQzOivmxsVaFHTxxZt1lcCM6Y4=;
        b=gi7CDr/JP2Ouwy4ye18AAyFCVDgRr2xezi7MWiVpE0pOTMAV6b59dXlWkgPpad5c4E
         H1RNeQw4OAtGoJsvAagIcdg9Vp80MBZssVlDb9l+8x5+bv7e5f34M5aGHTWupw+FH3iF
         XhsIMOMDng8cXNJXd7qsLzkaBtUHdlMXzjw3akOz9jHtNpXx9qg2/aS/yi76Ay5mHm9K
         5Kdo4c4+SkCVzJdMe3RdcWHvKMpspPrf/NmUSh1++8kile5Wxmv70V6qyHj+7zffQkHi
         OZrW9levWh12CjdlAgJzXDMhOBLo7N7fch4ZsAmM5JHoYwQ38QAmSdc1SLoWYnyPhAgc
         roSg==
X-Gm-Message-State: AOJu0Yyi20+M1Nnz5uCRjyzsxmp/ymP67Ps1vHX0nNHb457s0rJvcT5L
	Ojd9xLdH/ib1ZvUVKd5Zx2mmKbLThipjcHS8ySov9Uvr38PaW9c8Ez/acykvIdY=
X-Google-Smtp-Source: AGHT+IHvvFI0EKFuaqhwkSaKVT0T/X3GfiuOIV69Pdv26hhCiB1t7P2gv8Ug5DhSfd2xne+cH3H7tA==
X-Received: by 2002:a0d:d888:0:b0:5ef:902b:7c60 with SMTP id a130-20020a0dd888000000b005ef902b7c60mr472840ywe.25.1705567561767;
        Thu, 18 Jan 2024 00:46:01 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id bf22-20020a05690c029600b005d0fea7ad01sm6444273ywb.122.2024.01.18.00.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 00:46:01 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f00bef973aso123973997b3.0;
        Thu, 18 Jan 2024 00:46:01 -0800 (PST)
X-Received: by 2002:a5b:949:0:b0:dc2:41de:b744 with SMTP id
 x9-20020a5b0949000000b00dc241deb744mr333386ybq.32.1705567560920; Thu, 18 Jan
 2024 00:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-5-sboyd@kernel.org>
 <20240115203230.GA1439771-robh@kernel.org> <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
 <20240117174114.GA2779523-robh@kernel.org>
In-Reply-To: <20240117174114.GA2779523-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jan 2024 09:45:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXg1Y7mwHKTYi_j7a_XGdMJ7Aa7u5dEv5+xsLe8=BMaRw@mail.gmail.com>
Message-ID: <CAMuHMdXg1Y7mwHKTYi_j7a_XGdMJ7Aa7u5dEv5+xsLe8=BMaRw@mail.gmail.com>
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, Jan 17, 2024 at 6:41=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Tue, Jan 16, 2024 at 05:18:15PM -0800, Stephen Boyd wrote:
> > Quoting Rob Herring (2024-01-15 12:32:30)
> > > On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> > > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > > index da9826accb1b..9628e48baa15 100644
> > > > --- a/drivers/of/Kconfig
> > > > +++ b/drivers/of/Kconfig
> > > > @@ -54,9 +54,14 @@ config OF_FLATTREE
> > > >       select CRC32
> > > >
> > > >  config OF_EARLY_FLATTREE
> > > > -     bool
> > > > +     bool "Functions for accessing Flat Devicetree (FDT) early in =
boot"
> > >
> > > I think we could instead just get rid of this kconfig option. Or
> > > always enable with CONFIG_OF (except on Sparc). The only cost of
> > > enabling it is init section functions which get freed anyways.
> >
> > Getting rid of it is a more massive change. It can be the default and
> > kept hidden instead? If it can't be selected on Sparc then it should be
> > hidden there anyway.
>
> The easier option is certainly fine for this series. I just don't want
> it visible.
>
> > > >       select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
> > > >       select OF_FLATTREE
> > > > +     help
> > > > +       Normally selected by platforms that process an FDT that has=
 been
> > > > +       passed to the kernel by the bootloader.  If the bootloader =
does not
> > > > +       pass an FDT to the kernel and you need an empty devicetree =
that
> > > > +       contains only a root node to exist, then say Y here.
> > > >
> > > >  config OF_PROMTREE
> > > >       bool
> > [...]
> > > > @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const str=
uct device_node *n, unsigned long
> > > >       return test_bit(flag, &n->_flags);
> > > >  }
> > > >
> > > > +/**
> > > > + * of_have_populated_dt() - Has DT been populated by bootloader
> > > > + *
> > > > + * Return: True if a DTB has been populated by the bootloader and =
it isn't the
> > > > + * empty builtin one. False otherwise.
> > > > + */
> > > > +static inline bool of_have_populated_dt(void)
> > > > +{
> > > > +     return of_root !=3D NULL && !of_node_check_flag(of_root, OF_E=
MPTY_ROOT);
> > >
> > > Just a side comment, but I think many/all callers of this function co=
uld
> > > just be removed.
> > >
> > > I don't love new flags. Another possible way to handle this would be
> > > checking for "compatible" being present in the root node. I guess thi=
s
> > > is fine as-is for now at least.
> >
> > Ok. I can add a check for a compatible property. That's probably better
> > anyway. Should there be a compatible property there to signal that this
> > DT isn't compatible with anything? I worry about DT overlays injecting =
a
> > compatible string into the root node, but maybe that is already
> > prevented.
>
> I worry about DT overlays injecting anything...
>
> I don't think it is explicitly forbidden, but I have asked that any
> general purpose interface to apply overlays be restricted to nodes
> explicitly allowed (e.g. downstream of a connector node). For now, the
> places (i.e. drivers) overlays are applied are limited.
>
> We could probably restrict the root node to new nodes only and no new
> or changed properties.

Changing (<wild dream>or appending to</wild dream>) the root
"compatible" and/or "model" properties is useful in case of large
extension boards, though.  This is also the case for DTBs created from
a base DTB and one or more overlays using fdtoverlay.

For the latter, see also the following threads, where you weren't
(but probably should have been) CCed:

[1] "[PATCH v9 2/2] arm64: boot: Support Flat Image Tree"
     https://lore.kernel.org/all/20231202035511.487946-3-sjg@chromium.org
[2] "Proposal: FIT support for extension boards / overlays"
    https://lore.kernel.org/all/CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH=
_9sTF7Mw@mail.gmail.com

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

