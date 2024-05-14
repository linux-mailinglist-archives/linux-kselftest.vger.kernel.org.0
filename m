Return-Path: <linux-kselftest+bounces-10200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7948C5CCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921231F224B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE2181BA8;
	Tue, 14 May 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj7qo6Oq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC9180A6A;
	Tue, 14 May 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722183; cv=none; b=EAZb45ibjzurI2tf70q7Ybmr7rjtwxZMjMmItfBcdervkkBaU7BRPnhp7ZAZMN/XlHCYOXpcS9hpTl6axMuRFz6OYfFydHfoeccT2nkkLeyMJhBuUMcUdfeGgrjSa04XD+k+Ay4V5DbRKF8WAyQ0AsaA5hxUIit7/yBAyguJuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722183; c=relaxed/simple;
	bh=Y+m1nbd28r9a7918tO34Pw+7ZflDLT2x0sc9gLxM79Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=U8ovaJsXiIrFjqHxdEHP3xb/J6e+CRy+1FloTgVoZxdfzJZbmBiUuaS0BD80TgvM0Ru7VGTrsRDDvqr3oxnkSW0QQwd+ynJL+9Z36LWmc3ishgCbdh1fy2X9qzE67lmeilJd7SxNGPNHTkvlEYbdeouPg5wDIOcKZihquDCIDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj7qo6Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47491C2BD10;
	Tue, 14 May 2024 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715722182;
	bh=Y+m1nbd28r9a7918tO34Pw+7ZflDLT2x0sc9gLxM79Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tj7qo6OqQuXFdOdFZ1bi12ZdMFQ36pNjyngiRyzkjtqgMTgrAPBfYYo9cn1g0GmCq
	 Ojop1qK+lr5KWo1zePIYi343Vr7czqA8sBS/DTXRsy2ZQxTKk8+UlQ+4ggwg2w6lQq
	 tOHzWCvnQewAUise+RwW/gpoqKA/KHNDKqVD3f7UI7IWF9vnrlak3WhHoyGIZhpxOV
	 l4j0P79xvLU5JLeKZ8HU+Bu7YuVqVT6dUV/C/AGi5Qe0I48zQzt7VQogogY96yp8Pq
	 Kt4NqAFWtSGsT1r0u24xApI8REWXUrbC5s8FgZXOtHb3PgZzzWpeYqOKKkjgS75l8s
	 F9lSpEr0HqWTA==
Message-ID: <5c919f0d3d72fe1592a11c45545e8a60.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b822c6a5488c4098059b6d3c35eecbbd.sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org> <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com> <b822c6a5488c4098059b6d3c35eecbbd.sboyd@kernel.org>
Subject: Re: [PATCH v4 00/10] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>, Rob Herring <robh@kernel.org>
Date: Tue, 14 May 2024 14:29:40 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-05-02 18:27:42)
> Quoting David Gow (2024-05-01 01:08:11)
> >=20
> > The other thing I've noted so far is that the
> > of_apply_kunit_platform_device and of_overlay_apply_kunit_cleanup
> > tests fail (and BUG() with a NULL pointer) on powerpc:
> > > [15:18:51]     # of_overlay_apply_kunit_platform_device: EXPECTATION =
FAILED at drivers/of/overlay_test.c:47
> > > [15:18:51]     Expected pdev is not null, but is
> > > [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c
>=20
> This seems to be because pdev is NULL and we call put_device(&pdev->dev)
> on it. We could be nicer and have an 'if (pdev)' check there. I wonder
> if that fixes the other two below?
>=20
> ---8<---
> diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
> index 223e5a5c23c5..85cfbe6bb132 100644
> --- a/drivers/of/overlay_test.c
> +++ b/drivers/of/overlay_test.c
> @@ -91,7 +92,8 @@ static void of_overlay_apply_kunit_cleanup(struct kunit=
 *test)
>         dev =3D bus_find_device(&platform_bus_type, NULL, kunit_compatibl=
e,
>                               of_overlay_bus_match_compatible);
>         KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
> -       put_device(dev);
> +       if (dev)
> +               put_device(dev);
>  }

This last hunk isn't needed.

> =20
>  static struct kunit_case of_overlay_apply_kunit_test_cases[] =3D {
>=20
> > > [15:18:51]     # of_overlay_apply_kunit_platform_device: try faulted:=
 last line seen lib/kunit/resource.c:99
> > > [15:18:51]     # of_overlay_apply_kunit_platform_device: internal err=
or occurred preventing test case from running: -4
> > > [15:18:51] [FAILED] of_overlay_apply_kunit_platform_device
> >=20
> > > [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c
> > > [15:18:51] note: kunit_try_catch[698] exited with irqs disabled
> > > [15:18:51]     # of_overlay_apply_kunit_cleanup: try faulted: last li=
ne seen drivers/of/overlay_test.c:77
> > > [15:18:51]     # of_overlay_apply_kunit_cleanup: internal error occur=
red preventing test case from running: -4
> > > [15:18:51] [FAILED] of_overlay_apply_kunit_cleanup
> >=20
> > I've not had a chance to dig into it any further, yet, but it appears
> > to work on all of the other architectures I tried.
>=20
> Cool. I don't know why powerpc doesn't make devices. Maybe it has a
> similar design to sparc to create resources. I'll check it out.
>=20

powerpc doesn't mark the root node with OF_POPULATED_BUS. If I set that
in of_platform_default_populate_init() then the overlays can be applied.

---8<----
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..fa7b439e9402 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -565,6 +565,10 @@ static int __init of_platform_default_populate_init(vo=
id)
 				of_platform_device_create(node, buf, NULL);
 		}
=20
+		node =3D of_find_node_by_path("/");
+		if (node)
+			of_node_set_flag(node, OF_POPULATED_BUS);
+		of_node_put(node);
 	} else {
 		/*
 		 * Handle certain compatibles explicitly, since we don't want to create

I'm guessing this is wrong though, because I see bunch of powerpc specific =
code
calling of_platform_bus_probe() which will set the flag on the actual platf=
orm
bus nodes. Maybe we should just allow overlays to create devices at the root
node regardless? Of course, the flag doc says "platform bus created for
children" and if we never populated the root then that isn't entirely accur=
ate.

Rob, can you point me in the right direction? Do we need to use simple-bus =
in
the test overlays and teach overlay code to populate that bus?

