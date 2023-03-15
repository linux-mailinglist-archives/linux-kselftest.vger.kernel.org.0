Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3276C6BBC58
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjCOSiQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjCOSiN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:38:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F198EA3;
        Wed, 15 Mar 2023 11:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1BC9B81EDC;
        Wed, 15 Mar 2023 18:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A2DC433D2;
        Wed, 15 Mar 2023 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905454;
        bh=0rxpngBvIH2M23H86MEKqXtA8o/howGrTg4po3hl4ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=canwMIGa9bQK4Trk+oO6eOnoAAQk2qsvzqZvsO4w2AHbKmdpLquQ8dYetsvJOTiJ2
         TBNbSNB7+wPkIZ3y86qOOIHdVqKt6d7mtnzinRcHkXlo600RUo8KyZib9g0QjPetXi
         ygnBAeuDCxlx2QLh7kIO7rRRJWniiJ+JjlLzQIpyEN5P3n/J+FVsR+qOPuYVQ0+ruw
         kKF0cx8NgdeIqKlDXhpC0g99XMVn9Rc+yBKWo3VIVx4oMiAPFQMHd5j+v2ehw7pMZy
         dTfa5/2k5xbwgQbWNy92SJhLwpdRf+bs4VFUE14JI7ZG4bMAs1QaxxjpQJOxsmEgx+
         wTkcsUoDt8N9Q==
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
Subject: [PATCH v2 06/11] platform: Add test managed platform_device/driver APIs
Date:   Wed, 15 Mar 2023 11:37:23 -0700
Message-Id: <20230315183729.2376178-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315183729.2376178-1-sboyd@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce KUnit resource wrappers around platform_driver_register(),
platform_device_alloc(), and platform_device_add() so that test authors
can register platform drivers/devices from their tests and have the
drivers/devices automatically be unregistered when the test is done.

This makes test setup code simpler when a platform driver or platform
device is needed. Add a few test cases at the same time to make sure the
APIs work as intended.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/base/test/Makefile              |   3 +
 drivers/base/test/platform_kunit-test.c | 108 ++++++++++++++
 drivers/base/test/platform_kunit.c      | 186 ++++++++++++++++++++++++
 include/kunit/platform_device.h         |  15 ++
 4 files changed, 312 insertions(+)
 create mode 100644 drivers/base/test/platform_kunit-test.c
 create mode 100644 drivers/base/test/platform_kunit.c
 create mode 100644 include/kunit/platform_device.h

diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 7f76fee6f989..9edebaac4e75 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -3,3 +3,6 @@ obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
 CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
+
+obj-$(CONFIG_KUNIT) += platform_kunit.o
+obj-$(CONFIG_KUNIT_TEST) += platform_kunit-test.o
diff --git a/drivers/base/test/platform_kunit-test.c b/drivers/base/test/platform_kunit-test.c
new file mode 100644
index 000000000000..c4cf6204f86e
--- /dev/null
+++ b/drivers/base/test/platform_kunit-test.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for platform driver infrastructure.
+ */
+
+#include <linux/platform_device.h>
+
+#include <kunit/platform_device.h>
+#include <kunit/test.h>
+
+/*
+ * Test that platform_device_alloc_kunit() creates a platform device.
+ */
+static void platform_device_alloc_kunit_test(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+			platform_device_alloc_kunit(test,
+						    "kunit-platform", 1));
+}
+
+/*
+ * Test that platform_device_add_kunit() registers a platform device on the
+ * platform bus with the proper name and id.
+ */
+static void platform_device_add_kunit_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	const char *name = "kunit-platform";
+	const int id = -1;
+
+	pdev = platform_device_alloc_kunit(test, name, id);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	KUNIT_EXPECT_EQ(test, 0, platform_device_add_kunit(test, pdev));
+	KUNIT_EXPECT_TRUE(test, dev_is_platform(&pdev->dev));
+	KUNIT_EXPECT_STREQ(test, pdev->name, name);
+	KUNIT_EXPECT_EQ(test, pdev->id, id);
+}
+
+static struct kunit_case platform_device_kunit_test_cases[] = {
+	KUNIT_CASE(platform_device_alloc_kunit_test),
+	KUNIT_CASE(platform_device_add_kunit_test),
+	{}
+};
+
+static struct kunit_suite platform_device_kunit_suite = {
+	.name = "platform_device_kunit",
+	.test_cases = platform_device_kunit_test_cases,
+};
+
+struct kunit_platform_driver_test_context {
+	struct platform_driver pdrv;
+	const char *data;
+};
+
+static inline struct kunit_platform_driver_test_context *
+to_test_context(struct platform_device *pdev)
+{
+	return container_of(to_platform_driver(pdev->dev.driver),
+			    struct kunit_platform_driver_test_context,
+			    pdrv);
+}
+
+static int kunit_platform_driver_probe(struct platform_device *pdev)
+{
+	struct kunit_platform_driver_test_context *ctx;
+
+	ctx = to_test_context(pdev);
+	ctx->data = "test data";
+
+	return 0;
+}
+
+/* Test that platform_driver_register_kunit() registers a driver that probes. */
+static void platform_driver_register_kunit_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct kunit_platform_driver_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	pdev = platform_device_alloc_kunit(test, "kunit-platform", -1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, platform_device_add_kunit(test, pdev));
+
+	ctx->pdrv.probe = kunit_platform_driver_probe;
+	ctx->pdrv.driver.name = "kunit-platform";
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	KUNIT_EXPECT_EQ(test, 0, platform_driver_register_kunit(test, &ctx->pdrv));
+	KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
+}
+
+static struct kunit_case platform_driver_kunit_test_cases[] = {
+	KUNIT_CASE(platform_driver_register_kunit_test),
+	{}
+};
+
+static struct kunit_suite platform_driver_kunit_suite = {
+	.name = "platform_driver_kunit",
+	.test_cases = platform_driver_kunit_test_cases,
+};
+
+kunit_test_suites(&platform_device_kunit_suite,
+		  &platform_driver_kunit_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/base/test/platform_kunit.c b/drivers/base/test/platform_kunit.c
new file mode 100644
index 000000000000..3660b1898e79
--- /dev/null
+++ b/drivers/base/test/platform_kunit.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test managed platform driver
+ */
+
+#include <linux/device/driver.h>
+#include <linux/platform_device.h>
+
+#include <kunit/platform_device.h>
+#include <kunit/resource.h>
+
+struct platform_device_alloc_params_kunit {
+	const char *name;
+	int id;
+};
+
+static int platform_device_alloc_kunit_init(struct kunit_resource *res, void *context)
+{
+	struct platform_device_alloc_params_kunit *params = context;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(params->name, params->id);
+	if (!pdev)
+		return -ENOMEM;
+
+	res->data = pdev;
+
+	return 0;
+}
+
+static void platform_device_alloc_kunit_exit(struct kunit_resource *res)
+{
+	struct platform_device *pdev = res->data;
+
+	platform_device_put(pdev);
+}
+
+/**
+ * platform_device_alloc_kunit() - Allocate a KUnit test managed platform device
+ * @test: test context
+ * @dev: platform device to alloc
+ *
+ * Register a test managed platform device. The device is put when the test completes.
+ *
+ * Returns: Allocated platform device on success, NULL on failure.
+ */
+struct platform_device *
+platform_device_alloc_kunit(struct kunit *test, const char *name, int id)
+{
+	struct platform_device_alloc_params_kunit params = {
+		.name = name,
+		.id = id,
+	};
+
+	return kunit_alloc_resource(test,
+				    platform_device_alloc_kunit_init,
+				    platform_device_alloc_kunit_exit,
+				    GFP_KERNEL, &params);
+}
+EXPORT_SYMBOL_GPL(platform_device_alloc_kunit);
+
+static void platform_device_add_kunit_exit(struct kunit_resource *res)
+{
+	struct platform_device *pdev = res->data;
+
+	platform_device_unregister(pdev);
+}
+
+/**
+ * platform_device_add_kunit() - Register a KUnit test managed platform device
+ * @test: test context
+ * @dev: platform device to add
+ *
+ * Register a test managed platform device. The device is unregistered when the
+ * test completes.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int platform_device_add_kunit(struct kunit *test, struct platform_device *pdev)
+{
+	int ret;
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	if (!kunit_alloc_resource(test,
+				   NULL,
+				   platform_device_add_kunit_exit,
+				   GFP_KERNEL, pdev)) {
+		platform_device_unregister(pdev);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_device_add_kunit);
+
+static void platform_driver_register_kunit_exit(struct kunit_resource *res)
+{
+	struct platform_driver *drv = res->data;
+
+	platform_driver_unregister(drv);
+}
+
+/**
+ * platform_driver_register_kunit() - Register a KUnit test managed platform driver
+ * @test: test context
+ * @drv: platform driver to register
+ *
+ * Register a test managed platform driver. This allows callers to embed the
+ * @drv in a container structure and use container_of() in the probe function
+ * to pass information to kunit tests. It can be assumed that the driver has
+ * probed when this function returns.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	struct kunit_test_context {
+ *		struct platform_driver pdrv;
+ *		const char *data;
+ *	};
+ *
+ *	static inline struct kunit_test_context *
+ *	to_test_context(struct platform_device *pdev)
+ *	{
+ *		return container_of(to_platform_driver(pdev->dev.driver),
+ *				    struct kunit_test_context,
+ *				    pdrv);
+ *	}
+ *
+ *	static int kunit_platform_driver_probe(struct platform_device *pdev)
+ *	{
+ *		struct kunit_test_context *ctx;
+ *
+ *		ctx = to_test_context(pdev);
+ *		ctx->data = "test data";
+ *
+ *		return 0;
+ *	}
+ *
+ *	static void kunit_platform_driver_test(struct kunit *test)
+ *	{
+ *		struct kunit_test_context *ctx;
+ *
+ *		ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+ *		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+ *
+ *		ctx->pdrv.probe = kunit_platform_driver_probe;
+ *		ctx->pdrv.driver.name = "kunit-platform";
+ *		ctx->pdrv.driver.owner = THIS_MODULE;
+ *
+ *		KUNIT_EXPECT_EQ(test, 0, platform_driver_register_kunit(test, &ctx->pdrv));
+ *		KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
+ *	}
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int platform_driver_register_kunit(struct kunit *test,
+				   struct platform_driver *drv)
+{
+	int ret;
+
+	ret = platform_driver_register(drv);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for the driver to probe (or at least flush out of the deferred
+	 * workqueue)
+	 */
+	wait_for_device_probe();
+
+	if (!kunit_alloc_resource(test, NULL,
+				  platform_driver_register_kunit_exit,
+				  GFP_KERNEL, drv)) {
+		platform_driver_unregister(drv);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_driver_register_kunit);
diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
new file mode 100644
index 000000000000..28d28abf15a4
--- /dev/null
+++ b/include/kunit/platform_device.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KUNIT_PLATFORM_DRIVER_H
+#define _KUNIT_PLATFORM_DRIVER_H
+
+struct kunit;
+struct platform_device;
+struct platform_driver;
+
+struct platform_device *
+platform_device_alloc_kunit(struct kunit *test, const char *name, int id);
+int platform_device_add_kunit(struct kunit *test, struct platform_device *pdev);
+
+int platform_driver_register_kunit(struct kunit *test, struct platform_driver *drv);
+
+#endif
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

