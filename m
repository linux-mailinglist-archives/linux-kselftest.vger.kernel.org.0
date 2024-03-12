Return-Path: <linux-kselftest+bounces-6257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4950879690
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 15:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F031C214BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863867AE64;
	Tue, 12 Mar 2024 14:41:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E0446DB;
	Tue, 12 Mar 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254508; cv=none; b=UR/sfJ/cm29CjB+UI/dqjCUpnU/xuLdcnKySxeRZQD3f12uGo2ApK58necONZS43WYfBaOZBH4RD+AuRliSsFLjiS3PlgMbzhynMEgEW4pHoRS9zzIzWwV/Apg9LpIVp61PXr/9gmP+o41m6Tk5015BLBzddc05/7VclPUNevx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254508; c=relaxed/simple;
	bh=uOpsSVCbQLH9NXmsb8YDOq8vdcXwSuTFtG7lRr025Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHionPf1XAqYdN5SW0kMWoITz7evdFqS9MWJQ/ne9wJZJCIrgAoUPxMe28H8h1PiI9ZFy8wsp3/rAE9vH35PQu86iOwFEnp7R75U1KTO68gPgarFvXc7Qf2L+YwkhtL77Q4p7VxY9HJdEdYpujJSEBpRY31yIJPvDwvZbTv4Di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609f1f97864so55695997b3.0;
        Tue, 12 Mar 2024 07:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254505; x=1710859305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXmOsnx/ac8DtMDdTaI7xWpzg70Sr5+vs/F3ep2Teoo=;
        b=Gb9rK+6amKsX1tPvJNdbvw5LUCDa0lbKzhQ6CTIDLPI6AUmQTe92Wyfb1c/kZo6cLW
         byEcwcsTKCBeeQCcA9ivK0OEGy3QJITbyhp+CSavgfjWBvhwV8xmjMHfSi53aQX6aWEb
         u6AWe5vvDXETZClkghmQ4NuM+ExRp4tXek+klFiSRTFf6X4cpTPb+P0dzK9rikyb+mni
         Pu4wbsTn5EgkJqx6CWo8ET/RmkiklZ/6CJamKnB682aaWDiejHUj63yxVb6iuZKl/436
         CG3ScmoXC0KlD9QX8Y9qXi4XaM2WIWPS6S4G3q/eDXHeoa4RZ15/H6ixpLk1uny/8xP8
         gSIg==
X-Forwarded-Encrypted: i=1; AJvYcCWUBly8RdBEm4ypHM0E3uUZtHD9TAhnBa/TEapq/m/J+cf9D768rFmHifQTkKhGUYmJLdTXDwMRIB+oETXM+hVfVeVZlPN7PBCdUpXJFJR3oWQIbhrJzDwMaxCW+v/0HlmSz239Q5uDqlPX7RZrduhFNBIn8yqq4kSfowQ+lfaFauOp2VrGQ6rqXg==
X-Gm-Message-State: AOJu0YyRHBNFygXosKKgoJFke1vnxxFlalCxKTsz27o1jfFD120/ZCLD
	XwH4BhE2wxVCj+yc1gRoiPDdZRF7O3Chf058jZ2LMu5ICBBAUpjAzORpYgzStd4=
X-Google-Smtp-Source: AGHT+IFLwd80llousdW43NQpvSVAF9TrBV6DC7CPUdtOC5qyNcQLYMvcQCQWU24VbvyzJLfnk6Vsog==
X-Received: by 2002:a5b:f09:0:b0:dc7:45d3:ffd0 with SMTP id x9-20020a5b0f09000000b00dc745d3ffd0mr7126482ybr.1.1710254504686;
        Tue, 12 Mar 2024 07:41:44 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id w12-20020a25918c000000b00dcd9e3d3fd0sm1654333ybl.19.2024.03.12.07.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:41:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4788449276.3;
        Tue, 12 Mar 2024 07:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXnV3/HQE+LAvydLJTu+RgETy5FoiWEpsmakY+GgBjoA8xGbK8ZdBSJx07+hvYmaldzGtxB5Q4qFi1XIvWyJQlWxeUZJRya4dVKJHRpWHDKrYjzP7k3mLduc1trd6n3JA3FN8GAeIPcNfDn05Zh8rzWEezCL7F9mnH/nrBbCg1sTn3n9AhJKvgJw==
X-Received: by 2002:a25:4886:0:b0:dbe:9509:141c with SMTP id
 v128-20020a254886000000b00dbe9509141cmr6367424yba.30.1710254504263; Tue, 12
 Mar 2024 07:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 15:41:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
Message-ID: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
To: Rob Herring <robh+dt@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Frank Rowand <frowand.list@gmail.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	"Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

CC broonie
CC somlo

On Wed, Feb 21, 2024 at 3:06=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
> On Fri, Feb 16, 2024 at 11:08=E2=80=AFPM Saurabh Singh Sengar
> <ssengar@linux.microsoft.com> wrote:
> > On Fri, Feb 16, 2024 at 05:05:51PM -0800, Frank Rowand wrote:
> > > When enabling CONFIG_OF on a platform where 'of_root' is not populate=
d
> > > by firmware, we end up without a root node. In order to apply overlay=
s
> > > and create subnodes of the root node, we need one. Create this root n=
ode
> > > by unflattening an empty builtin dtb.
> > >
> > > If firmware provides a flattened device tree (FDT) then the FDT is
> > > unflattened via setup_arch(). Otherwise, the call to
> > > unflatten(_and_copy)?_device_tree() will create an empty root node.
> > >
> > > We make of_have_populated_dt() return true only if the DTB was loaded=
 by
> > > firmware so that existing callers don't change behavior after this
> > > patch. The call in the of platform code is removed because it prevent=
s
> > > overlays from creating platform devices when the empty root node is
> > > used.
> > >
> > > [sboyd@kernel.org: Update of_have_populated_dt() to treat this empty =
dtb
> > > as not populated. Drop setup_of() initcall]
> > >
> > > Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> > > Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list=
@gmail.com
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thanks for your patch, which is now commit 7b937cc243e5b1df ("of:
Create of_root if no dtb provided by firmware") in dt-rh/for-next
(next-20240312 and later).

On my OrangeCrab FPGA running Linux on LiteX/VexRiscv-V, the attached
OLED display now fails to probe:

    -ssd130x-i2c 0-003c: supply vcc not found, using dummy regulator
    -[drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
    +ssd130x-i2c 0-003c: incomplete constraints, dummy supplies not allowed
    +ssd130x-i2c 0-003c: error -ENODEV: Failed to get VCC regulator

> > > @@ -1645,6 +1635,21 @@ static inline bool of_device_is_system_power_c=
ontroller(const struct device_node
> > >       return of_property_read_bool(np, "system-power-controller");
> > >  }
> > >
> > > +/**
> > > + * of_have_populated_dt() - Has DT been populated by bootloader
> > > + *
> > > + * Return: True if a DTB has been populated by the bootloader and it=
 isn't the
> > > + * empty builtin one. False otherwise.
> > > + */
> > > +static inline bool of_have_populated_dt(void)
> > > +{
> > > +#ifdef CONFIG_OF
> > > +     return of_property_present(of_root, "compatible");
> >
> > This adds the strict check for compatible which makes compatible
> > to be mandatory for root nodes. So far, DeviceTree without compatible
> > property in root nodes can work. Do we want to make this documented
> > somewhere ?
>
> It already is in the DT spec and schemas.

How many systems in the wild violate this?

Apparently the DTS generated by LiteX does not have a root compatible
(and model) property, hence of_have_populated_dt() returns false.
While my gateware and DTS is quite old, a quick look at recent
litex_json2dts_linux.py history shows this is still true for current LiteX.

Now, how is this related to the failure I am seeing?

drivers/regulator/core.c has:

    static bool have_full_constraints(void)
    {
            return has_full_constraints || of_have_populated_dt();
    }

and

    static int __init regulator_init_complete(void)
    {
            /*
             * Since DT doesn't provide an idiomatic mechanism for
             * enabling full constraints and since it's much more natural
             * with DT to provide them just assume that a DT enabled
             * system has full constraints.
             */
            if (of_have_populated_dt())
                    has_full_constraints =3D true;

            ...
    }
    late_initcall_sync(regulator_init_complete);

(The latter looks a bit futile, as have_full_constraints() already
 contains a check for of_have_populated_dt()?)

When have_full_constraints() returns false, any dummy regulator will
fail to probe.

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

