Return-Path: <linux-kselftest+bounces-10257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681278C66DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 15:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFED1C20E57
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29F85956;
	Wed, 15 May 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvdY/AXK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BC3B79F;
	Wed, 15 May 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778384; cv=none; b=qrqgKUqXZWe11TY/0pSrYvwWsrlr7haB7rOW9WVb9vORm/+tO5svQAPIS92Z72uqfSllCzdKFpdLEFG+e7UB6nqqLndNv5ja2WKX0gm0A2FLRq01VeLQtc07xyvO5+HuNSo4cLeiylpEss5gUri5gRMa74tjXSQ8pccNxYvX3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778384; c=relaxed/simple;
	bh=A0YxFuuJShHBQ3xCPsMtAedx1f9EA+YbMAddHPRKwiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJI28n8oetkNZIbK1w6QW0OcRLgyLp6m8QySNjzudO3DLr14APAfLFCrS5fVSFJ5wnbFDbm5qg+Ayngy7Xm33ts2jWGzzZRzx5iOkuOqkO+021v4rD/b/jedd0LtNF8sX7EZq1lNuLXwDdlJzv33p/M7tucBfEJfKVhnFz42sTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvdY/AXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC19C32782;
	Wed, 15 May 2024 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715778384;
	bh=A0YxFuuJShHBQ3xCPsMtAedx1f9EA+YbMAddHPRKwiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rvdY/AXKAcsO8WrapFPJs3ADz99OtdbHGqSxheuLegvO/mgbeU30ahKSaF0QhsY5y
	 jVWBU2e1R8nM9RKtuKLZcyqRzLPvxodOMT9Kmx/4PVwKtjQfAg8Ia4yOAPG6t03QY1
	 mVii6+i5lWDUW1jIt0dUYlNy9XJEErw5WRExs39M8NU2NhhJnZUw2VYMgelfBTGTkV
	 ySX7RroJD4hhnzC/U9+2V4v92uR81h/Lp/b3KAXUqW/Vw2Z2SmwUUL1ILSBplQOqrZ
	 19upOy+ZKuH9uiMVeafnaM9h5/9salMdrPI7ugdL7UYnZiZIrZeTt99w8AHySqIpzv
	 uR7gXmEpq/TMQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so7446299e87.0;
        Wed, 15 May 2024 06:06:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSamnP/7Eq+iYgJmvO5wMFAqT6dvzqzSp9oY81DtiehGrZvKJdP+mRj25hKUP2V5uptOJ2wQZVEh73IMyweO2N19hQiheHTO0GWLj7d4DOF2s/qkf3/pL2c3MAV38suTunsNcb3dNN9KlOElyHt5CNmJcuj5t9ez6JlcEmlADQOINfMG5SnWGMAAG9Y/rkwDb9gtJUpX9n6mg+oCJGlGPEd9KPRg==
X-Gm-Message-State: AOJu0YzaVqzID+FYY9qjWamroUlh7MX38yjnRVpW0lNeU7TjZ0R/5qd+
	PMRYQP7ub3U1BwQDWYVMU4QqMGIW/8gU+ExFt8L/R4LP7/JDDNaxUaw7ld0asnVHcmJOIu3cYDf
	rX7yPNqv5oqpbAeDCCO42TZVP/A==
X-Google-Smtp-Source: AGHT+IFx85HwyGkq7nhuxIMzVBaBcFT+g2jH7StU0bEW7eR8FFo2zOGOMnX4dCVgnkGHDb6Fk2RaGnQFsJxSXXkyhAc=
X-Received: by 2002:a05:6512:3043:b0:522:36f7:3660 with SMTP id
 2adb3069b0e04-52236f739f8mr11158575e87.36.1715778382780; Wed, 15 May 2024
 06:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422232404.213174-1-sboyd@kernel.org> <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com>
 <b822c6a5488c4098059b6d3c35eecbbd.sboyd@kernel.org> <5c919f0d3d72fe1592a11c45545e8a60.sboyd@kernel.org>
In-Reply-To: <5c919f0d3d72fe1592a11c45545e8a60.sboyd@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 15 May 2024 08:06:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4EZ0RhYCw6ZaeYSJu5Ps1J+J25vjwQy2XvNa5F5d7Pw@mail.gmail.com>
Message-ID: <CAL_JsqK4EZ0RhYCw6ZaeYSJu5Ps1J+J25vjwQy2XvNa5F5d7Pw@mail.gmail.com>
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

On Tue, May 14, 2024 at 4:29=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Stephen Boyd (2024-05-02 18:27:42)
> > Quoting David Gow (2024-05-01 01:08:11)
> > >
> > > The other thing I've noted so far is that the
> > > of_apply_kunit_platform_device and of_overlay_apply_kunit_cleanup
> > > tests fail (and BUG() with a NULL pointer) on powerpc:
> > > > [15:18:51]     # of_overlay_apply_kunit_platform_device: EXPECTATIO=
N FAILED at drivers/of/overlay_test.c:47
> > > > [15:18:51]     Expected pdev is not null, but is
> > > > [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c
> >
> > This seems to be because pdev is NULL and we call put_device(&pdev->dev=
)
> > on it. We could be nicer and have an 'if (pdev)' check there. I wonder
> > if that fixes the other two below?
> >
> > ---8<---
> > diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
> > index 223e5a5c23c5..85cfbe6bb132 100644
> > --- a/drivers/of/overlay_test.c
> > +++ b/drivers/of/overlay_test.c
> > @@ -91,7 +92,8 @@ static void of_overlay_apply_kunit_cleanup(struct kun=
it *test)
> >         dev =3D bus_find_device(&platform_bus_type, NULL, kunit_compati=
ble,
> >                               of_overlay_bus_match_compatible);
> >         KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
> > -       put_device(dev);
> > +       if (dev)
> > +               put_device(dev);
> >  }
>
> This last hunk isn't needed.
>
> >
> >  static struct kunit_case of_overlay_apply_kunit_test_cases[] =3D {
> >
> > > > [15:18:51]     # of_overlay_apply_kunit_platform_device: try faulte=
d: last line seen lib/kunit/resource.c:99
> > > > [15:18:51]     # of_overlay_apply_kunit_platform_device: internal e=
rror occurred preventing test case from running: -4
> > > > [15:18:51] [FAILED] of_overlay_apply_kunit_platform_device
> > >
> > > > [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c
> > > > [15:18:51] note: kunit_try_catch[698] exited with irqs disabled
> > > > [15:18:51]     # of_overlay_apply_kunit_cleanup: try faulted: last =
line seen drivers/of/overlay_test.c:77
> > > > [15:18:51]     # of_overlay_apply_kunit_cleanup: internal error occ=
urred preventing test case from running: -4
> > > > [15:18:51] [FAILED] of_overlay_apply_kunit_cleanup
> > >
> > > I've not had a chance to dig into it any further, yet, but it appears
> > > to work on all of the other architectures I tried.
> >
> > Cool. I don't know why powerpc doesn't make devices. Maybe it has a
> > similar design to sparc to create resources. I'll check it out.
> >
>
> powerpc doesn't mark the root node with OF_POPULATED_BUS. If I set that
> in of_platform_default_populate_init() then the overlays can be applied.
>
> ---8<----
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 389d4ea6bfc1..fa7b439e9402 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -565,6 +565,10 @@ static int __init of_platform_default_populate_init(=
void)
>                                 of_platform_device_create(node, buf, NULL=
);
>                 }
>
> +               node =3D of_find_node_by_path("/");
> +               if (node)
> +                       of_node_set_flag(node, OF_POPULATED_BUS);

I think you want to do this in of_platform_bus_probe() instead to
mirror of_platform_populate(). These are supposed to be the same
except that 'populate' only creates devices for nodes with compatible
while 'probe' will create devices for all child nodes. Looks like we
are missing some devlink stuff too. There may have been some issue for
PPC with it.

> +               of_node_put(node);
>         } else {
>                 /*
>                  * Handle certain compatibles explicitly, since we don't =
want to create
>
> I'm guessing this is wrong though, because I see bunch of powerpc specifi=
c code
> calling of_platform_bus_probe() which will set the flag on the actual pla=
tform
> bus nodes. Maybe we should just allow overlays to create devices at the r=
oot
> node regardless? Of course, the flag doc says "platform bus created for
> children" and if we never populated the root then that isn't entirely acc=
urate.
>
> Rob, can you point me in the right direction? Do we need to use simple-bu=
s in
> the test overlays and teach overlay code to populate that bus?

Overlays adding things to the root node might be suspect, but probably
there are some valid reasons to do so. If simple-bus makes sense here,
then yes, you should use it. But if what's on it is not MMIO devices,
don't. That's a warning in the schema now.

Rob

