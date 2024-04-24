Return-Path: <linux-kselftest+bounces-8806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6618B11BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01A71F22CDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C4B16D9B7;
	Wed, 24 Apr 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9/cA3vg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359815CD6E;
	Wed, 24 Apr 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982284; cv=none; b=VfBuvPAVdv4ju1Ni57jS7+qeY1KCbF+yBi2GudsQlrMFUcSZHjBDAzcynEB7usO66VIkb3xAyro20qJpTwcsUceIGrZDgAnD1PwIzMvLCqk47+EhSej9sfIuD9APR/PBHJ7zmbk4WtWtDq89SY7f2pbzMomAqQc5Y34FXdi11jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982284; c=relaxed/simple;
	bh=7ItkOO8ka84a13QOYC/aAIFtqzRRzJtyWXnNHVtkfXs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=uTsUL3CUGMDxhrs5Tz2UyRjsJ+cjQiEkO3b7zSYACJUDH7n8IrE33GJVW9pD8kQwIE3+iEczv8xXw0Pusdyz2dmq4Fx3J7NsAIwMxmGwYF8qjMfkzXuabMW3AUbuzYTaCEFTRj2jOVRnUPuOmr3wIn0C5sON/68FL9OyAqjCw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9/cA3vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C6EC113CD;
	Wed, 24 Apr 2024 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713982283;
	bh=7ItkOO8ka84a13QOYC/aAIFtqzRRzJtyWXnNHVtkfXs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=k9/cA3vgWEuYDIlY9xYTJDAcqk4oed74YCEJbNg6AYjrBBi0bPg1rwO7LF11gJ2po
	 kDUMN1//9aKMK217sOAG0VamcjNYaNNMW5W/ZVGCJDX7HjeaxPaHLZ4TtYZttkBF7e
	 l3aodjBreSbnFH01sWt608pHXaX8+W6QGTiG4ndnQhnCpu4zoBEEJVJsuHeWS9yvNy
	 ILSDfQWmpN7GDDvQtUvh0qKXAzwadxoGNkBFhE6+HUM1+5XotZ7RMLT/b/Qte4q3yg
	 ChagwXxCFOmGxp9Gx0p8gU+y26SnIyFME+hoH9Vcm/CvVBk2dYsQsh59UZxSWv5zkX
	 7R/oie8nU6Nkw==
Message-ID: <128dc42a50bfe166993205108a5b23cd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240422232404.213174-6-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-6-sboyd@kernel.org>
Subject: Re: [PATCH v4 05/10] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Wed, 24 Apr 2024 11:11:21 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-04-22 16:23:58)
> diff --git a/drivers/base/test/platform_kunit.c b/drivers/base/test/platf=
orm_kunit.c
> new file mode 100644
> index 000000000000..54af6db2a6d8
> --- /dev/null
> +++ b/drivers/base/test/platform_kunit.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test managed platform driver
> + */
> +
[...]
> +
> +/**
> + * platform_driver_register_kunit() - Register a KUnit test managed plat=
form driver
> + * @test: test context
> + * @drv: platform driver to register
> + *
> + * Register a test managed platform driver. This allows callers to embed=
 the
> + * @drv in a container structure and use container_of() in the probe fun=
ction
> + * to pass information to KUnit tests. It can be assumed that the driver=
 has
> + * probed when this function returns.
> + *
> + * Example
> + *
> + * .. code-block:: c
> + *
> + *     struct kunit_test_context {
> + *             struct platform_driver pdrv;
> + *             const char *data;
> + *     };
> + *
> + *     static inline struct kunit_test_context *
> + *     to_test_context(struct platform_device *pdev)
> + *     {
> + *             return container_of(to_platform_driver(pdev->dev.driver),
> + *                                 struct kunit_test_context,
> + *                                 pdrv);
> + *     }
> + *
> + *     static int kunit_platform_driver_probe(struct platform_device *pd=
ev)
> + *     {
> + *             struct kunit_test_context *ctx;
> + *
> + *             ctx =3D to_test_context(pdev);
> + *             ctx->data =3D "test data";
> + *
> + *             return 0;
> + *     }
> + *
> + *     static void kunit_platform_driver_test(struct kunit *test)
> + *     {
> + *             struct kunit_test_context *ctx;
> + *
> + *             ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> + *             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> + *
> + *             ctx->pdrv.probe =3D kunit_platform_driver_probe;
> + *             ctx->pdrv.driver.name =3D "kunit-platform";
> + *             ctx->pdrv.driver.owner =3D THIS_MODULE;
> + *
> + *             KUNIT_EXPECT_EQ(test, 0, platform_driver_register_kunit(t=
est, &ctx->pdrv));
> + *             KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
> + *     }
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int platform_driver_register_kunit(struct kunit *test,
> +                                  struct platform_driver *drv)
> +{
> +       int ret;
> +
> +       ret =3D platform_driver_register(drv);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Wait for the driver to probe (or at least flush out of the def=
erred
> +        * workqueue)
> +        */
> +       wait_for_device_probe();

Should this be removed? I was thinking that this isn't a pure wrapper
around platform_driver_register() because it has this wait call.  Maybe
it's better to have some other kunit API that can wait for a specific
device to probe and timeout if it doesn't happen in that amount of time.
That API would use the bus notifiers and look for
BUS_NOTIFY_BOUND_DRIVER. Or maybe that function could setup a completion
that the test can wait on.

> +
> +       return kunit_add_action_or_reset(test,
> +                                        (kunit_action_t *)&platform_driv=
er_unregister,
> +                                        drv);
> +}
> +EXPORT_SYMBOL_GPL(platform_driver_register_kunit);

