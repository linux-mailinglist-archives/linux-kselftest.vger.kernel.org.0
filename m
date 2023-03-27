Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AAE6CA27E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjC0LeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjC0LeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 07:34:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273B49D1;
        Mon, 27 Mar 2023 04:34:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bi9so10958555lfb.12;
        Mon, 27 Mar 2023 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679916847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTSQxrRoE8Shcy5mtway4FQV4AF6vH1cCAm1YryA9wE=;
        b=iYExBj9hAxdPZi1fuhIeAn9Mq1mSWvCXJBPYUJQ32gb/LkUpqkT053vj499yRIRtZx
         95T+mABLT5Kn6a529wcr00nC8WiUZ6MTP8DXETRDo3l4o13gzUT8MgEOeqgdYC6q5NCb
         8rw6F/9+tH3BKaiy8/uP/M9uh8cgg/gGthZrdiILn4TEgsegonHycVqujRWzr3xXZUIv
         52p/Mb3TXPXNC2+fBsKT0c+a+9WMrw66isQmtYiK5k3D4cUT+NyC5+a2JulrbG2aky3U
         pPgMZlks9iU9ZCIaTQmxVVSLVoZDRRxShI9qENgxGaxYC410QcMb8rGlSMGgtwWe4EYs
         vcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTSQxrRoE8Shcy5mtway4FQV4AF6vH1cCAm1YryA9wE=;
        b=JtsEuZPTHeAupBSbJXYUYDvcS/x6epHajhMCJiIpcNgqg8gjPUSaKwG0JCTNBBfITp
         newmah35r/8kPmR07rHYQUsbEaDoEmtbV85zyzUQqCHC5KxbfuBn+TOuAPvzEErmXatO
         ISM/9sRHGIx0YqJFxt1L8eiojySsywHrg270iIY7sN7xPTXV5wBZ5fCchI0FTHkJk0hq
         Ff99aWCv0Q9ndOUFv1i2QMp/mpDU1w9TbTFu92moCYaVocagRsxtU6IRICcdKeN5tlpN
         qaGsIwSvVtVs2bZRN7zfCSSraj2EZISpV+5btXfdtuLIn3sIpgaeMdL0NJV0q0Kz5ML+
         NtOg==
X-Gm-Message-State: AAQBX9cGRhzgqa73k4sztRRflp3QCRALTalxkLZSuFzCItGi3nPQ/0H7
        f+CfXsvOh7iycjIWbPOE6Xo=
X-Google-Smtp-Source: AKy350YonYc0d8QJUr+vn6SSI4APqCbjccljhCEBZuYvQG0GJny1lnz9OR43eJJ6QXOHUgqIE91vhw==
X-Received: by 2002:a05:6512:11c3:b0:4d8:6f37:2611 with SMTP id h3-20020a05651211c300b004d86f372611mr3137200lfr.20.1679916846842;
        Mon, 27 Mar 2023 04:34:06 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id j7-20020a19f507000000b004db3e2d3efesm4646907lfb.204.2023.03.27.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:34:06 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:34:02 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v6 3/7] kunit: Add kunit wrappers for (root) device creation
Message-ID: <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CB8Pv1301zrQNio8"
Content-Disposition: inline
In-Reply-To: <cover.1679915278.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--CB8Pv1301zrQNio8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few tests need to have a valid struct device. One such example is
tests which want to be testing devm-managed interfaces.

Add kunit wrapper for root_device_[un]register(), which create a root
device and also add a kunit managed clean-up routine for the device
destruction upon test exit.

Special note: In some cases the device reference-count does not reach
zero and devm-unwinding is not done if device is not sitting on a bus.
The root_device_[un]register() are dealing with such devices and thus
this interface may not be usable by all in its current form. More
information can be found from:
https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/

The use of root-devices in the kunit helpers is intended to be an
intermediate solution to allow tests which do not require device to sit
on a bus avoid directly abusing the root_device_[un]register() while
proper kunit device solution is being worked on. Related discussion can be
found from:
https://lore.kernel.org/lkml/CABVgOSmx3A4Vwos2_8xO-XQrQAw5gvY0nc5zLpLmcJ7Ft=
A-dTQ@mail.gmail.com/

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Change history:
v5 =3D> v6:
- Kunit resource-managed root_device creation wrapper (new patch)

Please note: This patch uses root-devices (as was suggested) until there
is a proper dummy device creation mechanism added in kunit. The root
devices are embedded in kunit wrappers to simplify replacing the
root-devices with proper solution when it is available.

David Gow has sent out an RFC[1] which should implement these helpers
using not-yet-in-tree deferring API. This RFC aims to support
kunit_device which should be _the right thing to do_. I added this
implementation here because it may (or may not) take a while for the David's
RFC to make it's way in-kernel. So, in order to not delay this series I
added these helpers which use the existing kunit resource management for
clean-up while the new deferring kunit API is not yet in place.

[1] https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidg=
ow@google.com/T/#mf797239a8bce11630875fdf60aab9ed627add1f0

---
 include/kunit/device.h | 18 ++++++++++++++++++
 lib/kunit/Makefile     |  3 ++-
 lib/kunit/device.c     | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/device.h
 create mode 100644 lib/kunit/device.c

diff --git a/include/kunit/device.h b/include/kunit/device.h
new file mode 100644
index 000000000000..f02740b7583b
--- /dev/null
+++ b/include/kunit/device.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __KUNIT_DEVICE_H__
+#define __KUNIT_DEVICE_H__
+
+#include <kunit/test.h>
+
+struct device;
+
+/* Register a new device against a KUnit test. */
+struct device *kunit_device_register(struct kunit *test, const char *name);
+/*
+ * Unregister a device created by kunit_device_register() early (i.e.,
+ * before test cleanup).
+ */
+void kunit_device_unregister(struct kunit *test, struct device *dev);
+
+#endif
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index cb417f504996..64449549b990 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -6,7 +6,8 @@ kunit-objs +=3D				test.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
-					executor.o
+					executor.o \
+					device.o
=20
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=3D				debugfs.o
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
new file mode 100644
index 000000000000..425f6d62ebd7
--- /dev/null
+++ b/lib/kunit/device.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+#include <linux/device.h>
+
+static void kunit_device_drop(struct kunit_resource *res)
+{
+	root_device_unregister(res->data);
+}
+
+struct device *kunit_device_register(struct kunit *test, const char *name)
+{
+	struct device *dev;
+
+	dev =3D root_device_register(name);
+	if (IS_ERR_OR_NULL(dev))
+		return dev;
+
+	return kunit_alloc_resource(test, NULL, kunit_device_drop, GFP_KERNEL,
+				    dev);
+}
+EXPORT_SYMBOL_GPL(kunit_device_register);
+
+static bool kunit_device_match(struct kunit *test, struct kunit_resource *=
res,
+			       void *match_data)
+{
+	return res->data =3D=3D match_data;
+}
+
+void kunit_device_unregister(struct kunit *test, struct device *dev)
+{
+	kunit_destroy_resource(test, kunit_device_match, dev);
+}
+EXPORT_SYMBOL_GPL(kunit_device_unregister);
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

--CB8Pv1301zrQNio8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQhfyoACgkQeFA3/03a
ocVQXAgAyZVE0QRRpK31+jSoHckNCo70yF/cR2/GHjcY6of7s5j9gRR/jCv/5N/J
LZj55kvhs/mE2qZe6Xy7gzAHd8i+jvua77DScKT5wNQjNEr5gMZIy0GUJzScssL5
6NY/IUdvUDuadnSDAHF5MdHDyzSaemPGQGRSwyIEsAGNYcM6eHMer6HBtknHmwfT
QmZptzmFLBdRUraCclLmdAWGE07QAZ3PqZAgZIYTlKTZoGaRhniJy6wp2Xxrsz5+
wrXDOyle2+TaQl391BABjDpGBqRt3p/jMMyn4mq5iQUW9ZTSqkiuazeRBzpX+rjD
pXSP5lbxBIAC3f16tPgyoRrnscweVA==
=fna1
-----END PGP SIGNATURE-----

--CB8Pv1301zrQNio8--
