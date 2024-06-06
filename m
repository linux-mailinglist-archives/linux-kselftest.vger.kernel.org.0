Return-Path: <linux-kselftest+bounces-11296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDD8FF096
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7471F25F84
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F6197543;
	Thu,  6 Jun 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGDQ3Nz9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E53195FC4;
	Thu,  6 Jun 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687413; cv=none; b=BLRLht+k/wqXEaC2/aGSoZepMrU441mL8XnJilNWyB+dqVXvsui/VhcB+p1P/PlUusuNyEjAInkbzSRxpPsfYnKprVbeu5THq6geIUMkgj6e1rONU+O7Js1yDz8lQ3s26pxv6UvSsStrqRHgfr8YApRSV/SclsD59svpwwT+CFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687413; c=relaxed/simple;
	bh=n8Yr0UeoP6wPmeyQGK/cVLGthNtM0TGWP7koLQxIank=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=U7wc7JLUDcTd0Ul92MxvtHIi77i5bTyydXHUjRJbsJR0rrUzxekcUq5a6UyTkQbcAUheSYwzblhTwlgqsbdD7yGS/f4h59DiIGuV96oQKIOQMNQjBS5fFrGUWN4RTvrYWO+mAF1ZjlILqWGJo6HZ12Q0WIgOaDM/pre7VNp2a9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGDQ3Nz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE53C2BD10;
	Thu,  6 Jun 2024 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717687412;
	bh=n8Yr0UeoP6wPmeyQGK/cVLGthNtM0TGWP7koLQxIank=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bGDQ3Nz9FJaTI03nkHRRI8Rkbmqyr8quCZRGkaHPS78qF5hhbIu4lQZVvtyfMCwaJ
	 HNNQFCq99KG4QMX5sAPumvaa8eOxjVdP0f17ulhpsskQ7G4f0MWGcAe45aou2zPUIo
	 puEO9reNGbm2iTeM2JO3MKqGYKuBjyDajfpZP6CH1fdj1EcSZRdM4UxCM95p1BzN+1
	 d2W44/s7KjAFeuSgy6+WD9SocKtMJeh7WRL68waquEN4l2jQv20b7Dcv1Jfj+I/yQc
	 kPZbyvhjJzExje/AobiV3kGiteGFOJxgnfi5obYxJpmbDqewG2Y1hzqQkn2G+xMaPb
	 LBWRr86Qk3guQ==
Message-ID: <025da51b45c5234dc05c4bfc6b0570e5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240605234720.GA3441001-robh@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-6-sboyd@kernel.org> <20240605234720.GA3441001-robh@kernel.org>
Subject: Re: [PATCH v5 05/11] of: Add a KUnit test for overlays and test managed APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Rob Herring <robh@kernel.org>
Date: Thu, 06 Jun 2024 08:23:30 -0700
User-Agent: alot/0.10

Quoting Rob Herring (2024-06-05 16:47:20)
> On Mon, Jun 03, 2024 at 03:38:02PM -0700, Stephen Boyd wrote:
> > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > index 2ae909adde49..abd9c578343b 100644
> > diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
> > new file mode 100644
> > index 000000000000..9a8083c3a659
> > --- /dev/null
> > +++ b/drivers/of/overlay_test.c
> > @@ -0,0 +1,116 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit tests for device tree overlays
> > + */
> > +#include <linux/device/bus.h>
> > +#include <linux/kconfig.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <kunit/of.h>
> > +#include <kunit/test.h>
> > +
> > +static const char * const kunit_node_name =3D "kunit-test";
> > +static const char * const kunit_compatible =3D "test,empty";
> > +
> > +/* Test that of_overlay_apply_kunit() adds a node to the live tree */
> > +static void of_overlay_apply_kunit_apply(struct kunit *test)
> > +{
> > +     struct device_node *np;
> > +
> > +     KUNIT_ASSERT_EQ(test, 0,
> > +                     of_overlay_apply_kunit(test, kunit_overlay_test));
> > +
> > +     np =3D of_find_node_by_name(NULL, kunit_node_name);
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
> > +     of_node_put(np);
> > +}
> > +
> > +/*
> > + * Test that of_overlay_apply_kunit() creates platform devices with the
> > + * expected device_node
> > + */
> > +static void of_overlay_apply_kunit_platform_device(struct kunit *test)
> > +{
> > +     struct platform_device *pdev;
> > +     struct device_node *np;
> > +
> > +     KUNIT_ASSERT_EQ(test, 0,
> > +                     of_overlay_apply_kunit(test, kunit_overlay_test));
> > +
> > +     np =3D of_find_node_by_name(NULL, kunit_node_name);
> > +     of_node_put_kunit(test, np);
>=20
> Moving target, but we now have of_node_put() cleanups. Would that work=20
> here instead?

Do you mean cleanup.h? I don't think it will work. The assert logic is
like an exception handler. If the assertion fails we basically jump out
of the test and run any test exit code, including kunit resource exits.
I could introduce another kunit wrapper for of_find_node_by_name() and
use that here so that the reference is dropped when the test exits.

>=20
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> > +
> > +     pdev =3D of_find_device_by_node(np);
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, pdev);
> > +     if (pdev)
> > +             put_device(&pdev->dev);
> > +}
> > +
> > +static int of_overlay_bus_match_compatible(struct device *dev, const v=
oid *data)
> > +{
> > +     return of_device_is_compatible(dev->of_node, data);
> > +}
> > +
> > +/* Test that of_overlay_apply_kunit() cleans up after the test is fini=
shed */
> > +static void of_overlay_apply_kunit_cleanup(struct kunit *test)
> > +{
> > +     struct kunit fake;
> > +     struct platform_device *pdev;
> > +     struct device *dev;
> > +     struct device_node *np;
> > +
> > +     if (!IS_ENABLED(CONFIG_OF_OVERLAY))
> > +             kunit_skip(test, "requires CONFIG_OF_OVERLAY");
> > +     if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
> > +             kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE for r=
oot node");
> > +
> > +     kunit_init_test(&fake, "fake test", NULL);
> > +     KUNIT_ASSERT_EQ(test, fake.status, KUNIT_SUCCESS);
> > +
> > +     KUNIT_ASSERT_EQ(test, 0,
> > +                     of_overlay_apply_kunit(&fake, kunit_overlay_test)=
);
> > +
> > +     np =3D of_find_node_by_name(NULL, kunit_node_name);
> > +     of_node_put(np); /* Not derefing 'np' after this */
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> > +
> > +     pdev =3D of_find_device_by_node(np);
>=20
> Don't you need to hold a ref on np until here?

Oh, good catch. We need an of_find_node_by_name_kunit() wrapper then.

