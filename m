Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E037B6BBC54
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjCOSiP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjCOSiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9265103;
        Wed, 15 Mar 2023 11:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 036B361E47;
        Wed, 15 Mar 2023 18:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CED0C4339B;
        Wed, 15 Mar 2023 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905453;
        bh=OhTnxlFMN+kdsVZGN8Un8ZAPR2Heza4JgO3N/EMGkoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxNfxVdXub33nw5zhTD7YYGcoA9rRsrmRAnDK7NvfCyWC9g3KRRZ/r1qPP46O+QWc
         imcM2n4aOORt6CQvsgyrwem9q4/TwaCF7+ewT2qFyPYP/qKsattbIIC39mBhHbwGdO
         q4KHMnW1PfG8T1Dr9NQ0EKWQTS8AgEv2byVvFnLtkdULZtoZoh2Y/sSmxtk5EjkrwJ
         eGp5p8JXs5IeNpiqN54S+4Y+sVmgtdCsVXfXQAdMfc1/8zZ/2x1sR75kimhAsavg5t
         uzXGKv1JJNmVCoilDSASo/qFvvgaeiV0m+qV+Y+ua+WK2ajw5GrZ0PiePwB0vx1R8w
         i1HhlzGlgp+WA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 05/11] of: Add a KUnit test for overlays and test managed APIs
Date:   Wed, 15 Mar 2023 11:37:22 -0700
Message-Id: <20230315183729.2376178-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315183729.2376178-1-sboyd@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the KUnit test managed overlay APIs. Confirm that platform devices
are created and destroyed properly. This provides us confidence that the
test managed work correctly and can be relied upon to provide tests with
fake platform devices and device nodes via overlays compiled into the
kernel image.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/.kunitconfig            |   2 +
 drivers/of/Kconfig                 |  10 +++
 drivers/of/Makefile                |   1 +
 drivers/of/kunit_overlay_test.dtso |   9 +++
 drivers/of/overlay_test.c          | 107 +++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 drivers/of/kunit_overlay_test.dtso
 create mode 100644 drivers/of/overlay_test.c

diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
index 5a8fee11978c..7d570cb922a1 100644
--- a/drivers/of/.kunitconfig
+++ b/drivers/of/.kunitconfig
@@ -1,3 +1,5 @@
 CONFIG_KUNIT=y
 CONFIG_OF=y
 CONFIG_OF_KUNIT_TEST=y
+CONFIG_OF_OVERLAY=y
+CONFIG_OF_OVERLAY_KUNIT_TEST=y
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index f6739b9560c5..736029c120ae 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -112,6 +112,16 @@ config OF_OVERLAY
 	  While this option is selected automatically when needed, you can
 	  enable it manually to improve device tree unit test coverage.
 
+config OF_OVERLAY_KUNIT_TEST
+	tristate "Device Tree overlay KUnit tests" if !KUNIT_ALL_TESTS
+	depends on OF_OVERLAY
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds KUnit unit tests for the device tree overlay code.
+
+	  If unsure, say N here, but this option is safe to enable.
+
 config OF_NUMA
 	bool
 
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index d1110358fd45..b49351c4d0d2 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -24,5 +24,6 @@ obj-$(CONFIG_KUNIT) += of_kunit.o
 DTC_FLAGS_kunit += -@
 obj-$(CONFIG_OF_KUNIT) += kunit.dtbo.o
 obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
+obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) += overlay_test.o kunit_overlay_test.dtbo.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/kunit_overlay_test.dtso b/drivers/of/kunit_overlay_test.dtso
new file mode 100644
index 000000000000..6e70e2f8cd90
--- /dev/null
+++ b/drivers/of/kunit_overlay_test.dtso
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&kunit_bus {
+	test-kunit {
+		compatible = "test,kunit-empty";
+	};
+};
diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
new file mode 100644
index 000000000000..1b044ecc2f02
--- /dev/null
+++ b/drivers/of/overlay_test.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for device tree overlays
+ */
+#include <linux/device/bus.h>
+#include <linux/kconfig.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <kunit/of.h>
+#include <kunit/test.h>
+
+/* Test that of_overlay_apply_kunit() adds a node to the live tree */
+static void of_overlay_apply_kunit_apply(struct kunit *test)
+{
+	struct device_node *np;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_overlay_test));
+
+	np = of_find_node_by_name(NULL, "test-kunit");
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
+	of_node_put(np);
+}
+
+static int bus_match_np(struct device *dev, const void *data)
+{
+	const struct device_node *np = data;
+
+	return np == dev->of_node;
+}
+
+/*
+ * Test that of_overlay_apply_kunit() creates platform devices with the
+ * expected device_node
+ */
+static void of_overlay_apply_kunit_platform_device(struct kunit *test)
+{
+	struct device *dev;
+	struct device_node *np;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_overlay_test));
+
+	np = of_find_node_by_name(NULL, "test-kunit");
+	of_node_put_kunit(test, np);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
+
+	dev = bus_find_device(&platform_bus_type, NULL, np, bus_match_np);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+	put_device(dev);
+}
+
+static int of_overlay_bus_match_compatible(struct device *dev, const void *data)
+{
+	return of_device_is_compatible(dev->of_node, data);
+}
+
+/* Test that of_overlay_apply_kunit() cleans up after the test is finished */
+static void of_overlay_apply_kunit_cleanup(struct kunit *test)
+{
+	struct device *dev;
+	struct device_node *np;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_overlay_test));
+
+	np = of_find_node_by_name(NULL, "test-kunit");
+	of_node_put(np); /* Not derefing 'np' after this */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
+
+	dev = bus_find_device(&platform_bus_type, NULL, np, bus_match_np);
+	put_device(dev); /* Not derefing 'device' after this */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	/* Remove overlay */
+	kunit_cleanup(test);
+
+	np = of_find_node_by_name(NULL, "test-kunit");
+	KUNIT_EXPECT_PTR_EQ(test, NULL, np);
+	of_node_put(np);
+
+	dev = bus_find_device(&platform_bus_type, NULL, "test,kunit-empty",
+			      of_overlay_bus_match_compatible);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
+	put_device(dev);
+}
+
+static struct kunit_case of_overlay_apply_kunit_test_cases[] = {
+	KUNIT_CASE(of_overlay_apply_kunit_apply),
+	KUNIT_CASE(of_overlay_apply_kunit_platform_device),
+	KUNIT_CASE(of_overlay_apply_kunit_cleanup),
+	{}
+};
+
+/*
+ * Test suite for test managed device tree overlays.
+ */
+static struct kunit_suite of_overlay_apply_kunit_suite = {
+	.name = "of_overlay_apply_kunit",
+	.test_cases = of_overlay_apply_kunit_test_cases,
+};
+
+kunit_test_suites(
+	&of_overlay_apply_kunit_suite,
+);
+MODULE_LICENSE("GPL");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

