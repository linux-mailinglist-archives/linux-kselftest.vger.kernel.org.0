Return-Path: <linux-kselftest+bounces-5177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6085DD9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 15:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28DC1F22AFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AEA7F48C;
	Wed, 21 Feb 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quTqlShH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6BA7E581;
	Wed, 21 Feb 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524383; cv=none; b=EaJ4BbdR6SWurSyTPYnQr8bwVTw02cs64FW+EQIs+O5Q6AV2U/oQAdw+8Pw+IkbzrU5/+MwEXg4HPmwIHvTSB2HWg6gAwDPjjuLFbY6PU06cA597mfjCZX4zlNBUOTMqInfyxGVb6E5vBt/fiMetD/kyZzLwc/mb4tp0tL7aGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524383; c=relaxed/simple;
	bh=SpL2kvMci3BCJiem1BIyIcsSR8wgzqXdO4GroPnsjP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnejATfNpLeLnU9pyExQtycJBP0eIuFeLTIkoT/hNg0Jsi2PMdwwt0LoETBB+NHzMrm0yBJNEB6Rsl2IWpwDD8EwmbILYYqWjaS8ewC/X7PsTeHegki4n+toGSNSiSSP+UWqn8PnDy3srb1tKzxWmXhIMSQnOWl1uEkK6QGZ6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quTqlShH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55D1C43330;
	Wed, 21 Feb 2024 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708524382;
	bh=SpL2kvMci3BCJiem1BIyIcsSR8wgzqXdO4GroPnsjP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=quTqlShH4LWCaBTZCyQx62hLzRwZVLko6t4suir8Ot2AOcWbSVtaZdamqaM7w58fp
	 DdbftVoCHsUCAtZrueBfz94C0QKag0ucP4UlPGWV03xB+JkTeRxT7Kq9hgc7NcsZXc
	 jdVQs71Al076uLZgmoSahZ0U4RfJj5YkVku8IV4GGdbBtx+pGpMdhZ8eAyp0Z+GWNI
	 ltQ8vrqQsV3IadYmjrgumJm2YIKXXDGjK7zP6SVgH1PoRvtuNWCUadyNVbSvnC7IKo
	 CWUmyo8zmuq8zIcdMAr4cQxUEbW3qmbUZIszTl3aXJCaXPVHDRD5aTkpo7iJrjg6vx
	 SyGzgnFgXWrrA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d23fab7708so25586461fa.0;
        Wed, 21 Feb 2024 06:06:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgxI1aIhFiISdHKbOPv3LI+Ybb2MLVhOUAESW0tO5Mw3qDNmpV/j/MQLG+Ck5lReXFhjnR7vLp/s63VZ2iYYrpbbyQYYxPGnojwTqUJPfOvKbnvRKyTh+B3c2fYYlCrIObWSI8wLVNwzpqPRzQnHIB55XF50JuDi2wYNL5Phm0c8u6f2BCTMlVCw==
X-Gm-Message-State: AOJu0YyGalt5axyKBgbkFRl7BVdfw5b1GzEplwn1bN0pFbqj5pBrChHM
	/wExKJ1Ar0QoxOG1PBNpqRbpU7h/lyB5Bu87RLernlPxJSpOnM0gYZojrS3gWaKzlX6enMmuHBE
	67qgqFr7AC6P0UYpcInceKNBOxQ==
X-Google-Smtp-Source: AGHT+IHOSOSP7ipJG1AW58Fmxdj1uchlXs5YgDpmVhr8XeqjnmnNtuMuC8wFe5RgRdG+Eir4Pr5TzJCIR/BeGaQpP5A=
X-Received: by 2002:a05:651c:220b:b0:2d2:42d7:7d88 with SMTP id
 y11-20020a05651c220b00b002d242d77d88mr3092656ljq.22.1708524380920; Wed, 21
 Feb 2024 06:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Feb 2024 07:06:08 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
Message-ID: <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:08=E2=80=AFPM Saurabh Singh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> On Fri, Feb 16, 2024 at 05:05:51PM -0800, Frank Rowand wrote:
> > When enabling CONFIG_OF on a platform where 'of_root' is not populated
> > by firmware, we end up without a root node. In order to apply overlays
> > and create subnodes of the root node, we need one. Create this root nod=
e
> > by unflattening an empty builtin dtb.
> >
> > If firmware provides a flattened device tree (FDT) then the FDT is
> > unflattened via setup_arch(). Otherwise, the call to
> > unflatten(_and_copy)?_device_tree() will create an empty root node.
> >
> > We make of_have_populated_dt() return true only if the DTB was loaded b=
y
> > firmware so that existing callers don't change behavior after this
> > patch. The call in the of platform code is removed because it prevents
> > overlays from creating platform devices when the empty root node is
> > used.
> >
> > [sboyd@kernel.org: Update of_have_populated_dt() to treat this empty dt=
b
> > as not populated. Drop setup_of() initcall]
> >
> > Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> > Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list@g=
mail.com
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---


> > @@ -1645,6 +1635,21 @@ static inline bool of_device_is_system_power_con=
troller(const struct device_node
> >       return of_property_read_bool(np, "system-power-controller");
> >  }
> >
> > +/**
> > + * of_have_populated_dt() - Has DT been populated by bootloader
> > + *
> > + * Return: True if a DTB has been populated by the bootloader and it i=
sn't the
> > + * empty builtin one. False otherwise.
> > + */
> > +static inline bool of_have_populated_dt(void)
> > +{
> > +#ifdef CONFIG_OF
> > +     return of_property_present(of_root, "compatible");
>
> This adds the strict check for compatible which makes compatible
> to be mandatory for root nodes. So far, DeviceTree without compatible
> property in root nodes can work. Do we want to make this documented
> somewhere ?

It already is in the DT spec and schemas.

Rob

