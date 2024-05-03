Return-Path: <linux-kselftest+bounces-9300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD88BA4C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CD5B21C01
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 01:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E623BE58;
	Fri,  3 May 2024 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnSEQHyT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182818F47;
	Fri,  3 May 2024 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698240; cv=none; b=NUoob3SoqVvLw88VJbcBtpocxJbnmtUri7yGD/QM/M/dNOsH9QktF4vi+4OmITXPU5xSOpAov56C9W278NYHenXGK3y0TeOwpGm4uNPbBTyT8QdnnVlecmq03L/o41CaWg0SjvfH3sATKXiG9NdWShpzL9cQ/CKqL+iv2d8mWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698240; c=relaxed/simple;
	bh=FGn9Nc/maQsdZyOrXW+2uXst/XbmpaxL7uMg4iUh4zU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Vfqf3ZUMA1kbax+oSQVWz3C9J42pDEuXb8grHz0pyC+mb+zYTtr6GY80ZNXeA0TGgpKC/8PJs4ijIUHen+3XwnQ6wbke+9PNFB2LB+yCGnh9PXqOGPuDl6SzjtPogs6DyGEwuPBaW/H7PLJWJxOMyPo3A3N7vnx4Hir2bEouH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnSEQHyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71828C113CC;
	Fri,  3 May 2024 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714698239;
	bh=FGn9Nc/maQsdZyOrXW+2uXst/XbmpaxL7uMg4iUh4zU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AnSEQHyTTCGHh7q/8NojpB8iXu+pmFD3q8+Qt5iDoSxU44CaD9uP7HES+rqAfHtOj
	 D+FGPt62oX9GyAGpLUoEwvJcndLS2sn8wqGwAT5A8OOxhsiWCPn5E82SWqQee/z7te
	 15Fqb7S6RL5Kwyrths1IyL4Vkkmn6ku7y9sRQBf3rEj8AM/jUSOuNgwV8w7iwTS8l8
	 /wMtvPmyBk0nc3ZGf2onYV3qeNKpRw/0uxJlLZC7N/2JhwAo56BKf/lRnC2TuLyfQY
	 FDKjH+/W4XsZIPvpdsd/wS3Z9eU4QeifoPxi0bX4KsEtkuTttJFEGvL0SmvlnaeY5Y
	 OxZQySt3ibrpw==
Message-ID: <431171223433496db0a85072be5c83ba.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSk=jGzj55v+YWzOBCsG7Wdk68pyZr0VdAYftybv+5X67A@mail.gmail.com>
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-6-sboyd@kernel.org> <CABVgOSk=jGzj55v+YWzOBCsG7Wdk68pyZr0VdAYftybv+5X67A@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Thu, 02 May 2024 18:03:57 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-05-01 00:55:46)
> On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
> > diff --git a/Documentation/dev-tools/kunit/api/platformdevice.rst b/Doc=
umentation/dev-tools/kunit/api/platformdevice.rst
> > new file mode 100644
> > index 000000000000..b228fb6558c2
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/api/platformdevice.rst
> > @@ -0,0 +1,10 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Platform Device API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The KUnit platform device API is used to test platform devices.
> > +
> > +.. kernel-doc:: drivers/base/test/platform_kunit.c
> > +   :export:
> > diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> > index e321dfc7e922..740aef267fbe 100644
> > --- a/drivers/base/test/Makefile
> > +++ b/drivers/base/test/Makefile
> > @@ -1,8 +1,11 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)  +=3D test_async_driver_probe.o
> >
> > +obj-$(CONFIG_KUNIT) +=3D platform_kunit.o
> > +
>=20
> Do we want this to be part of the kunit.ko module (and hence,
> probably, under lib/kunit), or to keep this as a separate module.
> I'm tempted, personally, to treat this as a part of KUnit, and have it
> be part of the same module. There are a couple of reasons for this:
> - It's nice to have CONFIG_KUNIT produce only one module. If we want
> this to be separate, I'd be tempted to put it behind its own kconfig
> entry.
> - The name platform_kunit.ko suggests (to me, at least) that this is
> the test for platform devices, not the implementation of the helper.

I was following *_kunit as "helpers" and *_test as the test. Only
loosely based on the documentation that mentions to use _test or _kunit
for test files. Maybe it should have _kunit_helpers postfix?

Following the single module design should I merge the tests for this
code into kunit-test.c? And do the same sort of thing for clk helpers?
That sounds like it won't scale very well if everything is in one module.

Shouldn't the wrapper code for subsystems live in those subsystems like
drm_kunit_helpers.c does? Maybe the struct device kunit wrappers should
be moved out to drivers/base/? lib/kunit can stay focused on providing
pure kunit code then.

>=20
> I probably can be persuaded otherwise if you've got a strong
> preference for it to stay as-is, though.
>=20
> > diff --git a/drivers/base/test/platform_kunit.c b/drivers/base/test/pla=
tform_kunit.c
> > new file mode 100644
> > index 000000000000..54af6db2a6d8
> > --- /dev/null
> > +++ b/drivers/base/test/platform_kunit.c
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test managed platform driver
> > + */
> > +
> > +#include <linux/device/driver.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <kunit/platform_device.h>
> > +#include <kunit/resource.h>
> > +
> > +/**
> > + * platform_device_alloc_kunit() - Allocate a KUnit test managed platf=
orm device
> > + * @test: test context
> > + * @name: device name of platform device to alloc
> > + * @id: identifier of platform device to alloc.
> > + *
> > + * Allocate a test managed platform device. The device is put when the=
 test completes.
> > + *
> > + * Return: Allocated platform device on success, NULL on failure.
> > + */
> > +struct platform_device *
> > +platform_device_alloc_kunit(struct kunit *test, const char *name, int =
id)
>=20
> I'd prefer, personally, this be named something like
> kunit_platform_device_alloc(), to match the existing
> kunit_device_register() functions.
>=20
>=20
> > +{
> > +       struct platform_device *pdev;
> > +
> > +       pdev =3D platform_device_alloc(name, id);
> > +       if (!pdev)
> > +               return NULL;
> > +
> > +       if (kunit_add_action_or_reset(test, (kunit_action_t *)&platform=
_device_put, pdev))
>=20
> Alas, casting function pointers to kunit_action_t* breaks CFI. It's
> worth using a wrapper, which can be created with the
> KUNIT_DEFINE_ACTION_WRAPPER() macro, e.g.
>=20
> KUNIT_DEFINE_ACTION_WRAPPER(platform_device_put_wrapper,
> platform_device_put, struct platform_device *);

Thanks. I missed that.

>=20
> > +               return NULL;
> > +
> > +       return pdev;
> > +}
> > +EXPORT_SYMBOL_GPL(platform_device_alloc_kunit);
> > +
> > +static void platform_device_add_kunit_exit(struct kunit_resource *res)
> > +{
> > +       struct platform_device *pdev =3D res->data;
> > +
> > +       platform_device_unregister(pdev);
> > +}
> > +
> > +static bool
> > +platform_device_alloc_kunit_match(struct kunit *test,
> > +                                 struct kunit_resource *res, void *mat=
ch_data)
> > +{
> > +       struct platform_device *pdev =3D match_data;
> > +
> > +       return res->data =3D=3D pdev;
> > +}
> > +
> > +/**
> > + * platform_device_add_kunit() - Register a KUnit test managed platfor=
m device
> > + * @test: test context
> > + * @pdev: platform device to add
> > + *
> > + * Register a test managed platform device. The device is unregistered=
 when the
> > + * test completes.
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int platform_device_add_kunit(struct kunit *test, struct platform_devi=
ce *pdev)
>=20
> As above, I'd lean towards naming this kunit_platform_device_add() for
> consistency with the other KUnit device helpers.
>=20
> > +{
> > +       struct kunit_resource *res;
> > +       int ret;
> > +
> > +       ret =3D platform_device_add(pdev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       res =3D kunit_find_resource(test, platform_device_alloc_kunit_m=
atch, pdev);
> > +       if (res) {
> > +               /*
> > +                * Transfer the reference count of the platform device =
if it was
> > +                * allocated with platform_device_alloc_kunit(). In tha=
t case,
> > +                * calling platform_device_put() leads to reference cou=
nt
> > +                * underflow because platform_device_unregister() does =
it for
> > +                * us and we call platform_device_unregister() from
> > +                * platform_device_add_kunit_exit().
> > +                *
> > +                * Usually callers transfer the refcount from
> > +                * platform_device_alloc() to platform_device_add() and=
 simply
> > +                * call platform_device_unregister() when done, but wit=
h kunit
> > +                * we have to keep this straight by redirecting the free
> > +                * routine for the resource.
> > +                */
> > +               res->free =3D platform_device_add_kunit_exit;
> > +               kunit_put_resource(res);
> > +       } else if (kunit_add_action_or_reset(test,
> > +                                            (kunit_action_t *)&platfor=
m_device_unregister,
> > +                                            pdev)) {
>=20
> Nit: We don't want to cast directly to kunit_action_t *, as that
> breaks CFI. Can we use KUNIT_DEFINE_ACTION_WRAPPER()?
>=20
> > +               return -ENOMEM;
>=20
> Nit: This is fine, as kunit_add_action_or_reset() only returns 0 or
> -ENOMEM at the moment, but it could cause problems down the line if we
> ever want to return a different error. I don't think that's
> particularly likely, but it might be nicer to properly propagate the
> error.

I will propagate the return value.

>=20
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(platform_device_add_kunit);
> > +
> > +/**
> > + * platform_driver_register_kunit() - Register a KUnit test managed pl=
atform driver
> > + * @test: test context
> > + * @drv: platform driver to register
> > + *
> > + * Register a test managed platform driver. This allows callers to emb=
ed the
> > + * @drv in a container structure and use container_of() in the probe f=
unction
> > + * to pass information to KUnit tests. It can be assumed that the driv=
er has
> > + * probed when this function returns.
> > + *
> > + * Example
> > + *
> > + * .. code-block:: c
> > + *
> > + *     struct kunit_test_context {
> > + *             struct platform_driver pdrv;
> > + *             const char *data;
> > + *     };
> > + *
> > + *     static inline struct kunit_test_context *
> > + *     to_test_context(struct platform_device *pdev)
> > + *     {
> > + *             return container_of(to_platform_driver(pdev->dev.driver=
),
> > + *                                 struct kunit_test_context,
> > + *                                 pdrv);
> > + *     }
> > + *
> > + *     static int kunit_platform_driver_probe(struct platform_device *=
pdev)
> > + *     {
> > + *             struct kunit_test_context *ctx;
> > + *
> > + *             ctx =3D to_test_context(pdev);
> > + *             ctx->data =3D "test data";
> > + *
> > + *             return 0;
> > + *     }
> > + *
> > + *     static void kunit_platform_driver_test(struct kunit *test)
> > + *     {
> > + *             struct kunit_test_context *ctx;
> > + *
> > + *             ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> > + *             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> > + *
> > + *             ctx->pdrv.probe =3D kunit_platform_driver_probe;
> > + *             ctx->pdrv.driver.name =3D "kunit-platform";
> > + *             ctx->pdrv.driver.owner =3D THIS_MODULE;
> > + *
> > + *             KUNIT_EXPECT_EQ(test, 0, platform_driver_register_kunit=
(test, &ctx->pdrv));
> > + *             KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
> > + *     }
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int platform_driver_register_kunit(struct kunit *test,
> > +                                  struct platform_driver *drv)
>=20
> As above, I'd prefer kunit_platform_driver_register()
>=20
> > +{
> > +       int ret;
> > +
> > +       ret =3D platform_driver_register(drv);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * Wait for the driver to probe (or at least flush out of the d=
eferred
> > +        * workqueue)
> > +        */
> > +       wait_for_device_probe();
>=20
> Personally, I don't mind if this wrapper waits here (even if it makes
> it less of a 'pure' wrapper), so long as we document it. Can you think
> of any cases where we explicitly want _not_ to wait in a test?
>=20

I don't like it because it's not deterministic. The function doesn't
take any struct device to wait for. I've already written the code to use
a completion, and it works well enough so I'll just do that. Then we
don't have to worry if this API goes away, or that it doesn't actually
determine if the driver has probed the device.

