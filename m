Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9403B6C459A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 10:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCVJGM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCVJGJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 05:06:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740595D775;
        Wed, 22 Mar 2023 02:06:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t14so18124485ljd.5;
        Wed, 22 Mar 2023 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679475960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq1TQHfWKhCrqGdGRD8hzy5/NcSDrQPMb1arOqhfVgM=;
        b=qt8Ow0LupAc8J7pqLyfFJvRzn7iL+L0UYEve8dbTMxLjWp+NrG9Q/+fa92tEyVybIB
         NQ4mqmTD/hfcjje+SsJueuo3QzszpJVuGza0YnuJFHEUiNPU2pYGw+h9vDV5Vc9hYjPc
         n+NLbxeJ6FcBCGU2E1pq2PEZ/JV50Khep5ds0vYGi9TBcKBxiXGNQh7UiL+k0cIW/a+k
         nEEBfpwpPCChMIdizBTEakEzmPnqspAI0Zs9GdamcWs4K24ykWU6lUBrd6Wk9bCrJbrI
         cgj6ksSSCFMgIt2AR3w5DplRN22O768w22aHEiAz9YXrP4YqytMXslwZr3gT6d9J18fp
         pkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679475960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq1TQHfWKhCrqGdGRD8hzy5/NcSDrQPMb1arOqhfVgM=;
        b=T/b4hCFFe3vX4abCYeUm9F5C1e6WoSShBc0Qzw2MpxTEWnZlAyLJpQfBsFbVUsKHH+
         mjTFpahcKZ/L/9ii7WdwMmrE+VuL0IqURJRgjM5nLxKt/ylplz8E/uSNWAmZfHpaWrwN
         1ZOa5yrYknrMrTeGP/1TV3OZMcmoiBr/80G1PL6V8B/h4C1I5hdiJhpXRx0uiixipOG2
         llYMMe0fSXolygXqDVyFsSRSlGhijM7j5xrANPWqJFK8+M5Ouzjvd6D9EpO/sPKwfvRp
         6Ha4TsEkPjn6sYOe/tp8nUrcGMuxpM4wr91fATkoKOohzS7UeRLLAGvWH8Y6BrUfIbeY
         XXOw==
X-Gm-Message-State: AO0yUKUH/ThbURFHf9FiDyuU08/A+LS4M+MmLOFXPBy/19648mV6jC62
        IcMo29IE6w6QQWTTlScABwE=
X-Google-Smtp-Source: AK7set8KtyLZHcy7e7+Wd58E7Eu6RdJQ9K322A/O70YDqechrKygXuB/WJWEwLnY4qm7x1+ErAz6Qg==
X-Received: by 2002:a2e:2408:0:b0:2a0:202c:93a7 with SMTP id k8-20020a2e2408000000b002a0202c93a7mr955036ljk.14.1679475960386;
        Wed, 22 Mar 2023 02:06:00 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a17-20020a2eb171000000b0029bcfada416sm1927935ljm.138.2023.03.22.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:05:59 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:05:55 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PnFkEcwLXzlaHWqn"
Content-Disposition: inline
In-Reply-To: <cover.1679474247.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--PnFkEcwLXzlaHWqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The creation of a dummy device in order to test managed interfaces is a
generally useful test feature. The drm test helpers
drm_kunit_helper_alloc_device() and drm_kunit_helper_free_device()
are doing exactly this. It makes no sense that each and every component
which intends to be testing managed interfaces will create similar
helpers so stole these for more generic use.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Changes:
v4 =3D> v5:
- Add accidentally dropped header and email recipients
- do not rename + move helpers from DRM but add temporary dublicates to
  simplify merging. (This patch does not touch DRM and can be merged
  separately. DRM patch and IIO test patch still depend on this one).

Please note that there's something similar ongoing in the CCF:
https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/

I do like the simplicity of these DRM-originated helpers so I think
they're worth. I do equally like the Stephen's idea of having the
"dummy platform device" related helpers under drivers/base and the
header being in include/kunit/platform_device.h which is similar to real
platform device under include/linux/platform_device.h
---
 drivers/base/test/Kconfig             |  5 ++
 drivers/base/test/Makefile            |  2 +
 drivers/base/test/test_kunit_device.c | 83 +++++++++++++++++++++++++++
 include/kunit/platform_device.h       | 13 +++++
 4 files changed, 103 insertions(+)
 create mode 100644 drivers/base/test/test_kunit_device.c
 create mode 100644 include/kunit/platform_device.h

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 610a1ba7a467..642b5b183c10 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -1,4 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+
+config TEST_KUNIT_DEVICE_HELPERS
+	depends on KUNIT
+	tristate
+
 config TEST_ASYNC_DRIVER_PROBE
 	tristate "Build kernel module to test asynchronous driver probing"
 	depends on m
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 7f76fee6f989..49926524ec6f 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+=3D test_async_driver_probe.o
=20
+obj-$(CONFIG_TEST_KUNIT_DEVICE_HELPERS) +=3D test_kunit_device.o
+
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) +=3D property-entry-test.o
 CFLAGS_property-entry-test.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/test_kunit_device.c b/drivers/base/test/test=
_kunit_device.c
new file mode 100644
index 000000000000..75790e15b85c
--- /dev/null
+++ b/drivers/base/test/test_kunit_device.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * These helpers have been extracted from drm test code at
+ * drm_kunit_helpers.c which was authored by
+ * Maxime Ripard <maxime@cerno.tech>
+ */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+#include <kunit/platform_device.h>
+
+#define KUNIT_DEVICE_NAME	"test-kunit-mock-device"
+
+static int fake_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int fake_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver fake_platform_driver =3D {
+	.probe	=3D fake_probe,
+	.remove	=3D fake_remove,
+	.driver =3D {
+		.name	=3D KUNIT_DEVICE_NAME,
+	},
+};
+
+/**
+ * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
+ * @test: The test context object
+ *
+ * This allocates a fake struct &device to create a mock for a KUnit
+ * test. The device will also be bound to a fake driver. It will thus be
+ * able to leverage the usual infrastructure and most notably the
+ * device-managed resources just like a "real" device.
+ *
+ * Callers need to make sure test_kunit_helper_free_device() on the
+ * device when done.
+ *
+ * Returns:
+ * A pointer to the new device, or an ERR_PTR() otherwise.
+ */
+struct device *test_kunit_helper_alloc_device(struct kunit *test)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	ret =3D platform_driver_register(&fake_platform_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev =3D platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret =3D platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return &pdev->dev;
+}
+EXPORT_SYMBOL_GPL(test_kunit_helper_alloc_device);
+
+/**
+ * test_kunit_helper_free_device - Frees a mock device
+ * @test: The test context object
+ * @dev: The device to free
+ *
+ * Frees a device allocated with test_kunit_helper_alloc_device().
+ */
+void test_kunit_helper_free_device(struct kunit *test, struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&fake_platform_driver);
+}
+EXPORT_SYMBOL_GPL(test_kunit_helper_free_device);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/kunit/platform_device.h b/include/kunit/platform_devic=
e.h
new file mode 100644
index 000000000000..2a9c7bdd75eb
--- /dev/null
+++ b/include/kunit/platform_device.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __KUNIT_PLATFORM_DEVICE__
+#define __KUNIT_PLATFORM_DEVICE__
+
+#include <kunit/test.h>
+
+struct device;
+
+struct device *test_kunit_helper_alloc_device(struct kunit *test);
+void test_kunit_helper_free_device(struct kunit *test, struct device *dev);
+
+#endif
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--PnFkEcwLXzlaHWqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQaxPMACgkQeFA3/03a
ocWP3Qf9G+hEI+GF8Dp3g9kqEFdxDErT6sRacv2WVhpDZfSirkjAfP2l/6uJhJ/9
E9cGtwhpSQL1Pas1GPd1lrvcQ94H90LTGKfPz3cTtLKUeo8k71AJoiQBP5u28AJm
1fRIs8yVx/ZXCiIm53HSfnxNXEIX5PSuGL3D+NFCTSgA4jONrfYKxu5h/ek0X9Sv
C161xouvReo+j9xMmyNVf0muxdyou1iJikTyEXEuX+dDuv3w4ldkKFtUl72Jzyrj
pO7kPGmGIdzUoNlnQR4O6wLZM7cbLLk4G9eTFlXt5zm5DLIo7TCkLatcyXpWvn61
8zVqdf1fcILCW1gyKOUboTO4YmTcTA==
=bmmE
-----END PGP SIGNATURE-----

--PnFkEcwLXzlaHWqn--
