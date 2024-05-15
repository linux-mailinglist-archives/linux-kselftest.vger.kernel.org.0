Return-Path: <linux-kselftest+bounces-10265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEAC8C6E70
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 00:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BC3B22F02
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B33415B573;
	Wed, 15 May 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN4ss0bZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA715B129;
	Wed, 15 May 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715810942; cv=none; b=bT7sgUn/UkqzLUDMuLKhrzz0vk74EQsoE1KTO3AW1sVq1VLJX16DwEgr0tQp9YmznMUurKbe5lkFC4xsXDAiYMbrtidbHcpQh9Od93h7jhLJOg50vutGun9Zm0EDUGRAP57IrAOdH4H2KEQFik0IWZuNlbMJjltMf8eaCkMMWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715810942; c=relaxed/simple;
	bh=0MZIcUuawZGi6K+BymY9vuIR5HkbjpW1vBzGzyRWDxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrStTQMLaxs73oBJ3CGX4+L2EHmQ3udOrb1eOmKvBla1c+cvaGbTTsY7J3H7puForEaZndS4KGDIA1efNXMLhVZrYa2l/BZ/Wn3ONMZ/Pil93xpUD4OuDLSRPxoNYWz89b02GzADArrbz5UmKMDKzP/q/wqEVep9jgmFDXVBYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN4ss0bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E6AC4AF0A;
	Wed, 15 May 2024 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715810941;
	bh=0MZIcUuawZGi6K+BymY9vuIR5HkbjpW1vBzGzyRWDxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CN4ss0bZ/OrbxsYY87/Get/y83r9w6o+3mcjoSmkitZsDWY8Qr+b9xoTr+k4sI5we
	 L2+3a+icYVaqirYA8k1c/RUx1vlMHHA9l6b7ELW/575ed0Fh93hxTwF5q/1Uov4Nie
	 VlBh9rkl1oPTgtoSYEO2TuEhth/talxj4rwGGk9po6ntB9ERAtIGs/ldlXjAjxqMS4
	 ULWEhg5yIANC3VLJBu4TusxWmNKwwGxDPABfRpGXMGyC7rq+2uFHWADX+fdN43yDfa
	 1ngG2agHge7dDjE8EOIE1JOKBBln1PtHeMZlfrKJCOudR2HThvyggOjxl1LkJbapCp
	 Fv/arGddl3QvA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so906741fa.2;
        Wed, 15 May 2024 15:09:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8ZW/6UQYGbHNFPwS9H8tpQT1+dGcgTfU29pE/0+e3FJ4KgEmZXY3mSVsiXsuaHAW4WQWr1+Hm3Zd1c+OzlmSvMlGtgoVMtFlisbj+9cM6XD1hfJoH11lTjGSuH50whUl8jCd4N4dVpJtxiRYMI5nD3ctOzDHmGenUlwOQbNndnwhQtoqLxiKs5D4YlCxn9jWAXAlaEeYckkM4JCtgJQ8HdzQ3+A==
X-Gm-Message-State: AOJu0YyVGd+KFaNGWL4I1eBGjqvo/wBWLGwIgTHryNK+q9f07MgLpO5a
	mHSbfFIgE4zow98oPki+bmZhG9WN2pK+FARwXdPjiFN4aEjWqpkqpdfuogU6ZBDEPaSgtykPj6b
	9Cid3J77EeHBaFNX50Z1Hn3XXnQ==
X-Google-Smtp-Source: AGHT+IGzQttQC8UMU89GdfrYgHPoLKfcgLpWi8Xho2b4h4LtCH6dR5hoJ41H2FcllqnwQ6eag9/96nVB54HEREq3P58=
X-Received: by 2002:a05:6512:3a8d:b0:523:9226:41ea with SMTP id
 2adb3069b0e04-52392264794mr2835870e87.42.1715810940008; Wed, 15 May 2024
 15:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422232404.213174-1-sboyd@kernel.org> <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com>
 <b822c6a5488c4098059b6d3c35eecbbd.sboyd@kernel.org> <5c919f0d3d72fe1592a11c45545e8a60.sboyd@kernel.org>
 <CAL_JsqK4EZ0RhYCw6ZaeYSJu5Ps1J+J25vjwQy2XvNa5F5d7Pw@mail.gmail.com> <f6d7574582592f3bfa50fc45fefc53be.sboyd@kernel.org>
In-Reply-To: <f6d7574582592f3bfa50fc45fefc53be.sboyd@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 15 May 2024 17:08:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+M953w4FdOHmDWByqUbJmB+g_G=KxAuZ04zFqV6zBmzg@mail.gmail.com>
Message-ID: <CAL_Jsq+M953w4FdOHmDWByqUbJmB+g_G=KxAuZ04zFqV6zBmzg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] clk: Add kunit tests for fixed rate and parent data
To: Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 4:15=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Rob Herring (2024-05-15 06:06:09)
> > On Tue, May 14, 2024 at 4:29=E2=80=AFPM Stephen Boyd <sboyd@kernel.org>=
 wrote:
> > >
> > > powerpc doesn't mark the root node with OF_POPULATED_BUS. If I set th=
at
> > > in of_platform_default_populate_init() then the overlays can be appli=
ed.
> > >
> > > ---8<----
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index 389d4ea6bfc1..fa7b439e9402 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -565,6 +565,10 @@ static int __init of_platform_default_populate_i=
nit(void)
> > >                                 of_platform_device_create(node, buf, =
NULL);
> > >                 }
> > >
> > > +               node =3D of_find_node_by_path("/");
> > > +               if (node)
> > > +                       of_node_set_flag(node, OF_POPULATED_BUS);
> >
> > I think you want to do this in of_platform_bus_probe() instead to
> > mirror of_platform_populate(). These are supposed to be the same
> > except that 'populate' only creates devices for nodes with compatible
> > while 'probe' will create devices for all child nodes. Looks like we
> > are missing some devlink stuff too. There may have been some issue for
> > PPC with it.
>
> Got it. So this patch?
>
> ---8<---
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 389d4ea6bfc1..acecefcfdba7 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -421,6 +421,7 @@ int of_platform_bus_probe(struct device_node *root,
>         if (of_match_node(matches, root)) {
>                 rc =3D of_platform_bus_create(root, matches, NULL, parent=
, false);
>         } else for_each_child_of_node(root, child) {
> +               of_node_set_flag(root, OF_POPULATED_BUS);

No, the same spot as of_platform_populate has it. I guess this would
be the same, but no reason to do this in the for_each_child_of_node
loop...

>                 if (!of_match_node(matches, child))
>                         continue;
>                 rc =3D of_platform_bus_create(child, matches, NULL, paren=
t, false);
>
>
> This doesn't work though. I see that prom_init() is called, which
> constructs a DTB and flattens it to be unflattened by
> unflatten_device_tree(). The powerpc machine type used by qemu is
> PLATFORM_PSERIES_LPAR. It looks like it never calls
> of_platform_bus_probe() from the pseries platform code.

Huh. Maybe pseries doesn't have any platform devices?

Ideally, we'd still do it in of_platform_default_populate_init(), but
if you look at the history, you'll see that broke some PPC boards
(damn initcall ordering).

> What about skipping the OF_POPULATED_BUS check, or skipping the check
> when the parent is the root node? This is the if condition that's
> giving the headache.

I don't think we should just remove it, but a root node check seems fine.

Rob

