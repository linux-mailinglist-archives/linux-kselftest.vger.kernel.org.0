Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8996CB1AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 00:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjC0WWV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 18:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0WWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 18:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4770F19AB;
        Mon, 27 Mar 2023 15:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE3661530;
        Mon, 27 Mar 2023 22:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78EEC433EF;
        Mon, 27 Mar 2023 22:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679955725;
        bh=/DEIr7Sw4DkVY0Y+8LTV1B/3eOTXIenriA7lqf+vjdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ccp6tZNpaVST7S09hkPaQmZWYbNypUO2C1rx9xj2/t4Gam6MjVj53v+TftwvFXdCS
         zcadXlZ20zcUCSj+leSlzWBx0yqZk96MVhdjDHgwP3FUOLDVnyOwSmrJPQKGzLYAuw
         /jMYlxCPl+X86AC/SHpXzQ63gyEdOm8I4Rqj07yA1Jd864u1AK/UWLwdzxjrvEYVAv
         yKvDmdkAsoqXVQ6rydBY04H1YCIg8mfcTq2SIpGR/2ZfOTt85yqswFzkhqGRIQIiUz
         oD++n+3Wc4iWDqRZk1PUxyfxtOFuRCpRzczGSJ9B/EME+IGO0/j3gTM9aatEfHR/Nz
         xapxE3NQaq2uw==
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
Subject: [PATCH v3 06/11] platform: Add test managed platform_device/driver APIs
Date:   Mon, 27 Mar 2023 15:21:54 -0700
Message-Id: <20230327222159.3509818-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230327222159.3509818-1-sboyd@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
 Documentation/dev-tools/kunit/api/index.rst   |   5 +
 .../dev-tools/kunit/api/platformdevice.rst    |  10 +
 drivers/base/test/Makefile                    |   3 +
 drivers/base/test/platform_kunit-test.c       | 140 ++++++++++++
 drivers/base/test/platform_kunit.c            | 215 ++++++++++++++++++
 include/kunit/platform_device.h               |  15 ++
 6 files changed, 388 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
 create mode 100644 drivers/base/test/platform_kunit-test.c
 create mode 100644 drivers/base/test/platform_kunit.c
 create mode 100644 include/kunit/platform_device.h

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 5eb5f76e532c..eb628cb2c72a 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -10,6 +10,7 @@ API Reference
 	resource
 	functionredirection
 	of
+	platformdevice
 
 
 This page documents the KUnit kernel testing API. It is divided into the
@@ -37,3 +38,7 @@ Documentation/dev-tools/kunit/api/of.rst
 
  - Documents the KUnit device tree (OF) API
 
+Documentation/dev-tools/kunit/api/platformdevice.rst
+
+ - Documents the KUnit platform device API
+
diff --git a/Documentation/dev-tools/kunit/api/platformdevice.rst b/Documentation/dev-tools/kunit/api/platformdevice.rst
new file mode 100644
index 000000000000..b228fb6558c2
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/platformdevice.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+Platform Device API
+===================
+
+The KUnit platform device API is used to test platform devices.
+
+.. kernel-doc:: drivers/base/test/platform_kunit.c
+   :export:
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
index 000000000000..36bf5e579c98
--- /dev/null
+++ b/drivers/base/test/platform_kunit-test.c
@@ -0,0 +1,140 @@
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
+static const char * const kunit_devname = "kunit-platform";
+
+/*
+ * Test that platform_device_alloc_kunit() creates a platform device.
+ */
+static void platform_device_alloc_kunit_test(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+			platform_device_alloc_kunit(test, kunit_devname, 1));
+}
+
+/*
+ * Test that platform_device_add_kunit() registers a platform device on the
+ * platform bus with the proper name and id.
+ */
+static void platform_device_add_kunit_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	const char *name = kunit_devname;
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
+/*
+ * Test that platform_device_add_kunit() called twice with the same device name
+ * and id fails the second time and properly cleans up.
+ */
+static void platform_device_add_kunit_2_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	const char *name = kunit_devname;
+	const int id = -1;
+
+	pdev = platform_device_alloc_kunit(test, name, id);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, platform_device_add_kunit(test, pdev));
+
+	pdev = platform_device_alloc_kunit(test, name, id);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	KUNIT_EXPECT_NE(test, 0, platform_device_add_kunit(test, pdev));
+}
+
+/*
+ * Test suite for struct platform_device kunit APIs
+ */
+static struct kunit_case platform_device_kunit_test_cases[] = {
+	KUNIT_CASE(platform_device_alloc_kunit_test),
+	KUNIT_CASE(platform_device_add_kunit_test),
+	KUNIT_CASE(platform_device_add_kunit_2_test),
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
+static const char * const test_data = "test data";
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
+	ctx->data = test_data;
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
+	pdev = platform_device_alloc_kunit(test, kunit_devname, -1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, platform_device_add_kunit(test, pdev));
+
+	ctx->pdrv.probe = kunit_platform_driver_probe;
+	ctx->pdrv.driver.name = kunit_devname;
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	KUNIT_EXPECT_EQ(test, 0, platform_driver_register_kunit(test, &ctx->pdrv));
+	KUNIT_EXPECT_STREQ(test, ctx->data, test_data);
+}
+
+static struct kunit_case platform_driver_kunit_test_cases[] = {
+	KUNIT_CASE(platform_driver_register_kunit_test),
+	{}
+};
+
+/*
+ * Test suite for struct platform_driver kunit APIs
+ */
+static struct kunit_suite platform_driver_kunit_suite = {
+	.name = "platform_driver_kunit",
+	.test_cases = platform_driver_kunit_test_cases,
+};
+
+kunit_test_suites(
+	&platform_device_kunit_suite,
+	&platform_driver_kunit_suite,
+);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/base/test/platform_kunit.c b/drivers/base/test/platform_kunit.c
new file mode 100644
index 000000000000..ed85ed98197a
--- /dev/null
+++ b/drivers/base/test/platform_kunit.c
@@ -0,0 +1,215 @@
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
+ * @name: device name of platform device to alloc
+ * @id: identifier of platform device to alloc.
+ *
+ * Allocate a test managed platform device. The device is put when the test completes.
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
+static bool
+platform_device_alloc_kunit_match(struct kunit *test,
+				  struct kunit_resource *res, void *match_data)
+{
+	struct platform_device *pdev = match_data;
+
+	return res->data == pdev;
+}
+
+/**
+ * platform_device_add_kunit() - Register a KUnit test managed platform device
+ * @test: test context
+ * @pdev: platform device to add
+ *
+ * Register a test managed platform device. The device is unregistered when the
+ * test completes.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int platform_device_add_kunit(struct kunit *test, struct platform_device *pdev)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ret;
+
+	res = kunit_find_resource(test, platform_device_alloc_kunit_match, pdev);
+	if (res) {
+		/*
+		 * Transfer the reference count of the platform device if it was
+		 * allocated with platform_device_alloc_kunit(). In that case,
+		 * calling platform_device_put() leads to reference count
+		 * underflow because platform_device_unregister() does it for
+		 * us and we call platform_device_unregister() from
+		 * platform_device_add_kunit_exit().
+		 *
+		 * Usually callers transfer the refcount from
+		 * platform_device_alloc() to platform_device_add() and simply
+		 * call platform_device_unregister() when done, but with kunit
+		 * we have to keep this straight by redirecting the free
+		 * routine for the resource.
+		 */
+		res->free = platform_device_add_kunit_exit;
+		kunit_put_resource(res);
+	} else {
+		if (!kunit_alloc_resource(test,
+					   NULL,
+					   platform_device_add_kunit_exit,
+					   GFP_KERNEL, pdev)) {
+			platform_device_unregister(pdev);
+			return -ENOMEM;
+		}
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
+ * to pass information to KUnit tests. It can be assumed that the driver has
+ * probed when this function returns.
+ *
+ * Example
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

