Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4A6C7E15
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCXMcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 08:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCXMcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 08:32:12 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE34C04;
        Fri, 24 Mar 2023 05:32:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 640B732009DB;
        Fri, 24 Mar 2023 08:32:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Mar 2023 08:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679661120; x=1679747520; bh=Ka
        l7h6ja/GucBRhylyeLS0auVfpAQYDhDeEDhY9FtEg=; b=Cqb60qKjGZRU8b82ml
        mQaK9z2xC54tOkyO/EVRwLQ2lO2RUOMyAXmylkbtF7IbSP3+kiMTV9WZB924mo+z
        Bfv35R/XQ2gFa7oiZurf2rgVoRvqMF9MlhxWGR311E9swbNDeazKlI1ONXV3tANr
        ceKDFXrHQYsMQLkkf11MQK/+EkstuR9wZIFcJFNJGzAtmyW8Hdh5zQ/UY9VaK/4N
        N6wgF7C5lt0WiWLshQw8XUEQT6h06BvFfLtQVD5cIai9rzuOCV17yaAQAtxl7xGn
        hMDY5FQRRUySGfoKcma/wIDPkCAQGTKrIRyF9UySv2GMx6Q/QJH8BFw39Q5lYEjS
        Greg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679661120; x=1679747520; bh=Kal7h6ja/GucB
        RhylyeLS0auVfpAQYDhDeEDhY9FtEg=; b=GTjkL1MJHPNexoGfEDZVItQPV6pzX
        wxsb1QzGcw/eNFgd2Md8yHS+TUOfEw7EqBXlJjCNzpn7LLl/Q+iQGpPQahYJ3BGb
        KO+Ck1VbB6SlZpLVSFBeOh7s9v8fY4aBH1CpPEeWSRWJXQFpxFFZoL4gPjatqJ6G
        zAcPlHuwLQvZWuuBaAYVScC63OBITMVJUEBTXai64/G44KbHXFsLy/G5nqS7NHDC
        8cAJktX0W5u6Zemr4UyJ6nXJmKQVteEqJRpGhfsZTTDm2PreHGoIplYxTsypIebY
        8vnv2NVmjeQUJ8iYwIn3q2UuhumEUGE2WRmgcVio4LCYhnE55EpRbDDFQ==
X-ME-Sender: <xms:P5gdZICuEyYfqNSe5MmH-QOgp2UyANo2YMckfsj7tHKdYA7EG3WHAg>
    <xme:P5gdZKhoHgsAPul-Zq7JIKa4j7hbf2p9BUcBaOIFbQ_uHRNOoTiGqFctrlfTlnEyU
    gS7Ny4y2hLwXtfidmo>
X-ME-Received: <xmr:P5gdZLnXOTBGIOp3u3ARlUNnbxsjbPGJwgcwJSApV3XzkYRMXYO0Nc_jqEwbU3NXSecg8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:P5gdZOx74BHzquwznp5BPpUgTFoznW9T-v748hXySh_tBLkViiZH7Q>
    <xmx:P5gdZNSPvm2sjCrMA-ciswjkxnG-9UX0PH7To1a1h8GMikHROUipWw>
    <xmx:P5gdZJZRst-vOfp7CKCijRrW_fh1x_ULDkwOsj6t6zfwuPcShYrClA>
    <xmx:QJgdZIlt9jDXqRw-PxpgvbiWMc3zVFJuH1bD3PVu7PERYqFRYDnPkQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 08:31:59 -0400 (EDT)
Date:   Fri, 24 Mar 2023 13:31:57 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <20230324123157.bbwvfq4gsxnlnfwb@houat>
References: <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
 <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat>
 <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2sexxycsppzqwxl"
Content-Disposition: inline
In-Reply-To: <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--d2sexxycsppzqwxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:
> On 3/23/23 18:36, Maxime Ripard wrote:
> > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
> > > On 3/23/23 14:29, Maxime Ripard wrote:
> > > > On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> > > >=20
> > > > This is the description of what was happening:
> > > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@h=
ouat/
> > >=20
> > > Thanks Maxime. Do I read this correcty. The devm_ unwinding not being=
 done
> > > when root_device_register() is used is not because root_device_unregi=
ster()
> > > would not trigger the unwinding - but rather because DRM code on top =
of this
> > > device keeps the refcount increased?
> >=20
> > There's a difference of behaviour between a root_device and any device
> > with a bus: the root_device will only release the devm resources when
> > it's freed (in device_release), but a bus device will also do it in
> > device_del (through bus_remove_device() -> device_release_driver() ->
> > device_release_driver_internal() -> __device_release_driver() ->
> > device_unbind_cleanup(), which are skipped (in multiple places) if
> > there's no bus and no driver attached to the device).
> >=20
> > It does affect DRM, but I'm pretty sure it will affect any framework
> > that deals with device hotplugging by deferring the framework structure
> > until the last (userspace) user closes its file descriptor. So I'd
> > assume that v4l2 and cec at least are also affected, and most likely
> > others.
>=20
> Thanks for the explanation and patience :)
>=20
> >=20
> > > If this is the case, then it sounds like a DRM specific issue to me.
> >=20
> > I mean, I guess. One could also argue that it's because IIO doesn't
> > properly deal with hotplugging.
>=20
> I must say I haven't been testing the IIO registration API. I've only tes=
ted
> the helper API which is not backed up by any "IIO device". (This is fine =
for
> the helper because it must by design be cleaned-up only after the
> IIO-deregistration).
>=20
> After your explanation here, I am not convinced IIO wouldn't see the same
> issue if I was testing the devm_iio_device_alloc() & co.

It depends really. The issue DRM is trying to solve is that, when a
device is gone, some application might still have an open FD and could
still poke into the kernel, while all the resources would have been
free'd if it was using devm.

So everything is kept around until the last fd is closed, so you still
have a reference to the device (even though it's been removed from its
bus) until that time.

It could be possible that IIO just doesn't handle that case at all. I
guess most of the devices aren't hotpluggable, and there's not much to
interact with from a userspace PoV iirc, so it might be why.

> > I'm not sure how that helps. Those are
> > common helpers which should accommodate every framework,
>=20
> Ok. Fair enough. Besides, if the root-device was sufficient - then I would
> actually not see the need for a helper. People could in that case directly
> use the root_device_register(). So, if helpers are provided they should be
> backed up by a device with a bus then.
>=20
> > and your second
> > patch breaks the kunit tests for DRM anyway.
>=20
> Oh, I must have made an error there. It was supposed to be just a
> refactoring with no functional changes. Sorry about that. Anyways, that
> patch can be forgotten as Greg opposes using the platform devices in gene=
ric
> helpers.
>=20
> > > Whether it is a feature or bug is beyond my knowledge. Still, I would
> > > not say using the root_device_[un]register() in generic code is not
> > > feasible - unless all other subsytems have similar refcount handling.
> > >=20
> > > Sure thing using root_device_register() root_device_unregister() in D=
RM does
> > > not work as such. This, however, does not mean the generic kunit help=
ers
> > > should use platform_devices to force unwinding?
> >=20
> > platform_devices were a quick way to get a device that would have a bus
> > and a driver bound to fall into the right patch above. We probably
> > shouldn't use platform_devices and a kunit_device sounds like the best
> > idea, but the test linked in the original mail I pointed you to should
> > work with whatever we come up with. It works with multiple (platform,
> > PCI, USB, etc) buses, so the mock we create should behave like their
> > real world equivalents.
>
> Thanks for the patience and the explanation. Now I understand a generic t=
est
> device needs to sit on a bus.
>=20
> As I said, in my very specific IIO related test the test device does not
> need a bus. Hence I'll drop the 'generic helpers' from this series.

So, I went around and created a bunch of kunit tests that shows the
problem without DRM being involved at all.

It does three things:

 - It registers a device, attaches a devm action, unregisters the device
   and then checks that the action has ran.

 - It registers a device, gets a reference to it, attaches a devm
   action, puts back the reference, unregisters the device and then
   checks that the action has ran.

 - It registers a device, gets a reference to it, attaches a devm action
   that will put back the reference, unregisters the device and then
   checks that the action has ran.

And in three cases: first with a root_device, then platform_device, then
a platform_device that has been bound to a driver.

Once you've applied that patch, you can run it using:

=2E/tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/base/test/ dev=
m-inconsistencies

You'll see that only the last case passes all the tests, even though the
code itself is exactly the same.

Maxime

-- >8 --
diff --git a/drivers/base/test/.kunitconfig b/drivers/base/test/.kunitconfig
new file mode 100644
index 000000000000..473923f0998b
--- /dev/null
+++ b/drivers/base/test/.kunitconfig
@@ -0,0 +1,2 @@
+CONFIG_KUNIT=3Dy
+CONFIG_DM_KUNIT_TEST=3Dy
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 610a1ba7a467..9d42051f8f8e 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -9,6 +9,10 @@ config TEST_ASYNC_DRIVER_PROBE

 	  If unsure say N.

+config DM_KUNIT_TEST
+	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+
 config DRIVER_PE_KUNIT_TEST
 	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT=3Dy
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 7f76fee6f989..31bcaa743e94 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+=3D test_async_driver_probe.o

+obj-$(CONFIG_DM_KUNIT_TEST)	+=3D test-devm-cleanup.o
+
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) +=3D property-entry-test.o
 CFLAGS_property-entry-test.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/test-devm-cleanup.c b/drivers/base/test/test=
-devm-cleanup.c
new file mode 100644
index 000000000000..bad3cb1385b1
--- /dev/null
+++ b/drivers/base/test/test-devm-cleanup.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/resource.h>
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+#define DEVICE_NAME "test"
+
+struct test_priv {
+	bool probe_done;
+	bool release_done;
+	wait_queue_head_t release_wq;
+	struct device *dev;
+};
+
+static void devm_device_action(void *ptr)
+{
+	struct test_priv *priv =3D ptr;
+
+	priv->release_done =3D true;
+	wake_up_interruptible(&priv->release_wq);
+}
+
+static void devm_put_device_action(void *ptr)
+{
+	struct test_priv *priv =3D ptr;
+
+	put_device(priv->dev);
+	priv->release_done =3D true;
+	wake_up_interruptible(&priv->release_wq);
+}
+
+#define RELEASE_TIMEOUT_MS	500
+
+static void root_device_register_unregister_test(struct kunit *test)
+{
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	priv->dev =3D root_device_register(DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	root_device_unregister(priv->dev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static void root_device_register_get_put_unregister_test(struct kunit *tes=
t)
+{
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	priv->dev =3D root_device_register(DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
+
+	get_device(priv->dev);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	put_device(priv->dev);
+
+	root_device_unregister(priv->dev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static void root_device_register_get_unregister_with_devm_test(struct kuni=
t *test)
+{
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	priv->dev =3D root_device_register(DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
+
+	get_device(priv->dev);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	root_device_unregister(priv->dev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static void platform_device_register_unregister_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	pdev =3D platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->dev =3D &pdev->dev;
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static void platform_device_register_get_put_unregister_test(struct kunit =
*test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	pdev =3D platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->dev =3D &pdev->dev;
+
+	get_device(priv->dev);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	put_device(priv->dev);
+
+	platform_device_unregister(pdev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static void platform_device_register_get_unregister_with_devm_test(struct =
kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	pdev =3D platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->dev =3D &pdev->dev;
+
+	get_device(priv->dev);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static int fake_probe(struct platform_device *pdev)
+{
+	struct test_priv *priv =3D platform_get_drvdata(pdev);
+
+	priv->probe_done =3D true;
+	wake_up_interruptible(&priv->release_wq);
+
+	return 0;
+}
+
+static struct platform_driver fake_driver =3D {
+	.probe	=3D fake_probe,
+	.driver =3D {
+		.name =3D DEVICE_NAME,
+	},
+};
+
+static void probed_platform_device_register_unregister_test(struct kunit *=
test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	ret =3D platform_driver_register(&fake_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev =3D platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	priv->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->probe_do=
ne,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+
+	platform_driver_unregister(&fake_driver);
+}
+
+static void probed_platform_device_register_get_put_unregister_test(struct=
 kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	ret =3D platform_driver_register(&fake_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev =3D platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	priv->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->probe_do=
ne,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	get_device(priv->dev);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	put_device(priv->dev);
+
+	platform_device_unregister(pdev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+
+	platform_driver_unregister(&fake_driver);
+}
+
+static void probed_platform_device_register_get_unregister_with_devm_test(=
struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	ret =3D platform_driver_register(&fake_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev =3D platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	priv->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->probe_do=
ne,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	get_device(priv->dev);
+
+	ret =3D devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret =3D wait_event_interruptible_timeout(priv->release_wq, priv->release_=
done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+
+	platform_driver_unregister(&fake_driver);
+}
+
+static struct kunit_case devm_inconsistencies_tests[] =3D {
+	KUNIT_CASE(root_device_register_unregister_test),
+	KUNIT_CASE(root_device_register_get_put_unregister_test),
+	KUNIT_CASE(root_device_register_get_unregister_with_devm_test),
+	KUNIT_CASE(platform_device_register_unregister_test),
+	KUNIT_CASE(platform_device_register_get_put_unregister_test),
+	KUNIT_CASE(platform_device_register_get_unregister_with_devm_test),
+	KUNIT_CASE(probed_platform_device_register_unregister_test),
+	KUNIT_CASE(probed_platform_device_register_get_put_unregister_test),
+	KUNIT_CASE(probed_platform_device_register_get_unregister_with_devm_test),
+	{}
+};
+
+static struct kunit_suite devm_inconsistencies_test_suite =3D {
+	.name =3D "devm-inconsistencies",
+	.test_cases =3D devm_inconsistencies_tests,
+};
+
+kunit_test_suite(devm_inconsistencies_test_suite);
-- >8 --

--d2sexxycsppzqwxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZB2YPQAKCRDj7w1vZxhR
xY2CAP9uiQnzSZz+fCSPOb9shPv+jtpVPDbKEW/s+RjRHWmBmAEAtQXtrJyujBhA
BR+9PUr5nAEOF+2XdVPca6xc4ugdCw0=
=KY+G
-----END PGP SIGNATURE-----

--d2sexxycsppzqwxl--
