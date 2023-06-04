Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D27721594
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFDIbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjFDIbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 04:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E078CE;
        Sun,  4 Jun 2023 01:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA8CD6090B;
        Sun,  4 Jun 2023 08:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC260C433EF;
        Sun,  4 Jun 2023 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685867505;
        bh=F27uxYsLzEgMGhdwhuxQJBAyQP3GTCJqX5q0Q66VgtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIHURHP2S0yUnX7gww9XbxKY6FoCojovxIdtc9lVPkzxJ8z60TMeSdQOKo0TlxH1v
         X2nhX+N+aIugg0uy7npIy5KOeVVH8Qp48ard5EHNd2JR29CaFbYyYOEjgBxY77tfdB
         sCp5Una1clbGYj/tmcxMIwglQf2CqAshncBGDT/OQB/smCqhl83WCrtlMb8iA9cQg/
         lH+NrkmMWQOh/++gA7PIrc6twcXMv5H2y4/qOxWknWYTe+UOYY9lLisB2dOq8x++U3
         vaIX+LxSUi8anwsYieFoMAsV4RJg773DAeY8DrvofLOtRLKiycrw99nQsBG8Ykf55V
         2tJLBG5ufF8ZQ==
Date:   Sun, 4 Jun 2023 10:31:42 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] drivers: base: Add basic devm tests for root
 devices
Message-ID: <ngable7tvu3bpbxm4gjkposta73coii5f3w5myghqfysarrcvz@mdnczc33ixjc>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
 <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
 <2023060339-unvaried-keenness-c14a@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3n2owgqbm57r3upu"
Content-Disposition: inline
In-Reply-To: <2023060339-unvaried-keenness-c14a@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3n2owgqbm57r3upu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 03, 2023 at 04:43:51PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 02, 2023 at 05:20:43PM +0200, Maxime Ripard wrote:
> > From: Maxime Ripard <maxime@cerno.tech>
> >=20
> > The root devices show some odd behaviours compared to regular "bus" dev=
ices
> > that have been probed through the usual mechanism, so let's create kunit
> > tests to exercise those paths and odd cases.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/base/test/.kunitconfig       |   2 +
> >  drivers/base/test/Kconfig            |   4 ++
> >  drivers/base/test/Makefile           |   2 +
> >  drivers/base/test/root-device-test.c | 120 +++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 128 insertions(+)
> >=20
> > diff --git a/drivers/base/test/.kunitconfig b/drivers/base/test/.kunitc=
onfig
> > new file mode 100644
> > index 000000000000..473923f0998b
> > --- /dev/null
> > +++ b/drivers/base/test/.kunitconfig
> > @@ -0,0 +1,2 @@
> > +CONFIG_KUNIT=3Dy
> > +CONFIG_DM_KUNIT_TEST=3Dy
> > diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> > index 610a1ba7a467..9d42051f8f8e 100644
> > --- a/drivers/base/test/Kconfig
> > +++ b/drivers/base/test/Kconfig
> > @@ -9,6 +9,10 @@ config TEST_ASYNC_DRIVER_PROBE
> > =20
> >  	  If unsure say N.
> > =20
> > +config DM_KUNIT_TEST
> > +	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
> > +	depends on KUNIT
> > +
> >  config DRIVER_PE_KUNIT_TEST
> >  	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
> >  	depends on KUNIT=3Dy
> > diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> > index 7f76fee6f989..d589ca3fa8fc 100644
> > --- a/drivers/base/test/Makefile
> > +++ b/drivers/base/test/Makefile
> > @@ -1,5 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+=3D test_async_driver_probe.o
> > =20
> > +obj-$(CONFIG_DM_KUNIT_TEST)	+=3D root-device-test.o
> > +
> >  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) +=3D property-entry-test.o
> >  CFLAGS_property-entry-test.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
> > diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/r=
oot-device-test.c
> > new file mode 100644
> > index 000000000000..fcb55d8882aa
> > --- /dev/null
> > +++ b/drivers/base/test/root-device-test.c
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright 2023 Maxime Ripard <mripard@kernel.org>
> > +
> > +#include <kunit/resource.h>
> > +
> > +#include <linux/device.h>
> > +
> > +#define DEVICE_NAME "test"
> > +
> > +struct test_priv {
> > +	bool probe_done;
> > +	bool release_done;
> > +	wait_queue_head_t release_wq;
> > +	struct device *dev;
> > +};
> > +
> > +static void devm_device_action(void *ptr)
> > +{
> > +	struct test_priv *priv =3D ptr;
> > +
> > +	priv->release_done =3D true;
> > +	wake_up_interruptible(&priv->release_wq);
> > +}
> > +
> > +static void devm_put_device_action(void *ptr)
> > +{
> > +	struct test_priv *priv =3D ptr;
> > +
> > +	put_device(priv->dev);
> > +	priv->release_done =3D true;
> > +	wake_up_interruptible(&priv->release_wq);
> > +}
> > +
> > +#define RELEASE_TIMEOUT_MS	500
> > +
> > +static void root_device_devm_register_unregister_test(struct kunit *te=
st)
> > +{
> > +	struct test_priv *priv;
> > +	int ret;
> > +
> > +	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> > +	init_waitqueue_head(&priv->release_wq);
> > +
> > +	priv->dev =3D root_device_register(DEVICE_NAME);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> > +
> > +	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	root_device_unregister(priv->dev);
> > +
> > +	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->rele=
ase_done,
> > +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> > +	KUNIT_EXPECT_GT(test, ret, 0);
> > +}
> > +
> > +static void root_device_devm_register_get_put_unregister_test(struct k=
unit *test)
> > +{
> > +	struct test_priv *priv;
> > +	int ret;
> > +
> > +	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> > +	init_waitqueue_head(&priv->release_wq);
> > +
> > +	priv->dev =3D root_device_register(DEVICE_NAME);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> > +
> > +	get_device(priv->dev);
>=20
> Why are you incrementing the reference here?
>=20
> > +
> > +	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	put_device(priv->dev);
>=20
> And then dropping it here?
>=20
> What did that accomplish?  You shouldn't have needed to do that at all,
> right?
>=20
> THat's all the difference from the previous function?  What is this
> testing?
>=20
>=20
> > +
> > +	root_device_unregister(priv->dev);
> > +
> > +	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->rele=
ase_done,
> > +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> > +	KUNIT_EXPECT_GT(test, ret, 0);
> > +}
> > +
> > +static void root_device_devm_register_get_unregister_with_devm_test(st=
ruct kunit *test)
> > +{
> > +	struct test_priv *priv;
> > +	int ret;
> > +
> > +	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> > +	init_waitqueue_head(&priv->release_wq);
> > +
> > +	priv->dev =3D root_device_register(DEVICE_NAME);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
> > +
> > +	get_device(priv->dev);
> > +
> > +	ret =3D devm_add_action_or_reset(priv->dev, devm_put_device_action, p=
riv);
> > +	KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +	root_device_unregister(priv->dev);
> > +
> > +	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->rele=
ase_done,
> > +					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
> > +	KUNIT_EXPECT_GT(test, ret, 0);
> > +}
> > +
> > +static struct kunit_case root_device_devm_tests[] =3D {
> > +	KUNIT_CASE(root_device_devm_register_unregister_test),
> > +	KUNIT_CASE(root_device_devm_register_get_put_unregister_test),
> > +	KUNIT_CASE(root_device_devm_register_get_unregister_with_devm_test),
>=20
> I can't figure out what you are trying to test here at all, which
> doesn't bode well for this patchset.
>=20
> Can you document it better?  What should be happening (or not happening)
> that you are trying to ensure works properly?
>=20
> All I see is a register/devm_something/unregister sequence and then wait
> for the device to be freed.  Am I missing something else?

So I guess most of the context was dropped since I first posted that
series (and I believe that the following will also answer the comment on
the other patch).

It spawned from the discussion here:
https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@hou=
at/

Basically, depending on the bus (platform vs root devices), and whether
a driver was bound to the device or not, the device managed actions
might or might not run.

This lead us in DRM to create helpers that will register a platform
device and bind it to a dumb driver so that we can have the proper
behaviour (ie, when we free the device, the device managed actions are
executed).

We wanted to create generic helpers for kunit to create a new device
instance to run a test on, and you were (not surprisingly) not really
along with it. We discussed the above fact that the bus and bind-ness of
a device was affecting device managed actions, I provided a bunch of
kunit tests showing the inconsistencies that led to what we did in DRM,
and you offered to fix it if I submitted the tests.

https://lore.kernel.org/linux-kselftest/ZB2a291P5abeah6s@kroah.com/

And so here we are :)

Those tests are not doing much indeed but checking whether a device
managed action would run in various scenarii. If you run them, you'll
end up with:

$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/base/test/
[10:28:39] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=3Dum O=3D.kunit olddefconfig
[10:28:40] Building KUnit Kernel ...
Populating config with:
$ make ARCH=3Dum O=3D.kunit olddefconfig
Building with:
$ make ARCH=3Dum O=3D.kunit --jobs=3D32
[10:28:50] Starting KUnit Kernel (1/1)...
[10:28:50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:28:50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D root-device-devm (3 s=
ubtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:28:50] [PASSED] root_device_devm_register_unregister_test
[10:28:50] [PASSED] root_device_devm_register_get_put_unregister_test
[10:28:50] # root_device_devm_register_get_unregister_with_devm_test: EXPEC=
TATION FAILED at drivers/base/test/root-device-test.c:105
[10:28:50] Expected ret > 0, but
[10:28:50]     ret =3D=3D 0 (0x0)
[10:28:50] [FAILED] root_device_devm_register_get_unregister_with_devm_test
[10:28:50] # root-device-devm: pass:2 fail:1 skip:0 total:3
[10:28:50] # Totals: pass:2 fail:1 skip:0 total:3
[10:28:50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] root-d=
evice-devm =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:28:50] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D platform-device-devm (6 sub=
tests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:28:50] [PASSED] platform_device_devm_register_unregister_test
[10:28:51] [PASSED] platform_device_devm_register_get_put_unregister_test
[10:28:51] # platform_device_devm_register_get_unregister_with_devm_test: E=
XPECTATION FAILED at drivers/base/test/platform-device-test.c:123
[10:28:51] Expected ret > 0, but
[10:28:51]     ret =3D=3D 0 (0x0)
[10:28:51] [FAILED] platform_device_devm_register_get_unregister_with_devm_=
test
[10:28:51] [PASSED] probed_platform_device_devm_register_unregister_test
[10:28:51] [PASSED] probed_platform_device_devm_register_get_put_unregister=
_test
[10:28:51] [PASSED] probed_platform_device_devm_register_get_unregister_wit=
h_devm_test
[10:28:51] # platform-device-devm: pass:5 fail:1 skip:0 total:6
[10:28:51] # Totals: pass:5 fail:1 skip:0 total:6
[10:28:51] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] platform-dev=
ice-devm =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:28:51] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[10:28:51] Testing complete. Ran 9 tests: passed: 7, failed: 2
[10:28:51] Elapsed time: 11.701s total, 0.979s configuring, 9.601s building=
, 1.087s running

So you can see (and test) those inconsistencies: if you're using devm,
you need to have a "bus" device bound to a driver. Failing that, devm
actions will not run, which we all believed was a bug in that thread
above.

Maxime

--3n2owgqbm57r3upu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZHxL6gAKCRDj7w1vZxhR
xaMdAQDnI4nn0lPG/5WRBkeRLx5PlCkC2tio32Mkh4S9gEcDNAEAwNXqbZejQ0Bv
jknVavonMc0dgJjT0JOa0rGFTamrswc=
=eY2Q
-----END PGP SIGNATURE-----

--3n2owgqbm57r3upu--
