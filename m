Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACEC6A7900
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBBiq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCBBin (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:38:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C74366AD;
        Wed,  1 Mar 2023 17:38:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91BC2B811E9;
        Thu,  2 Mar 2023 01:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A2AC433A4;
        Thu,  2 Mar 2023 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677721106;
        bh=3k+YvMdWMsnOAG6Xbljbz1eZOpgJZtilmS9lPO8bApY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1tDZTB8oHaK4uGxcnbievgIEFFJPTmIrMhXBoFMFjvGUjrIl2802ciDrN52ep62A
         AVE9HbAZGEFxf0hNkdfxmi+B/8Z34RfMeP2bCn8SNnGQPyMGnJTvsCKqXC3SffE0kf
         mIGMLE+9tsSXw0OjOu5K2+NQwZw4tTL7y1+VRyFbrlzIfBUWAt4i7i63Thxc3L4imN
         jMkVsQvjRn/tsxOs/e4dmcYHMzbxRay9MCSSp9oj+kPuudtdFQJzTVPOpP2Pf9S9HL
         lTXsCpRx4boL3rL4bAp59OIe9HFqUAPV1kiB1nJb9NLeVE6wklKducBO79kdyLbtGk
         aXitEVYhkrAuw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 3/8] kunit: Add test managed platform_device/driver APIs
Date:   Wed,  1 Mar 2023 17:38:16 -0800
Message-Id: <20230302013822.1808711-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Should this be moved to drivers/base/ and called platform_kunit.c?
The include/kunit/platform_driver.h could also be
kunit/platform_device.h to match linux/platform_device.h if that is more
familiar.

And I'm not super certain about allocating a driver structure and
embedding it in a wrapper struct. Maybe the code should just use
kunit_get_current_test() instead?

 include/kunit/platform_driver.h  |  15 +++
 lib/kunit/Makefile               |   6 +
 lib/kunit/platform_driver-test.c | 107 ++++++++++++++++
 lib/kunit/platform_driver.c      | 207 +++++++++++++++++++++++++++++++
 4 files changed, 335 insertions(+)
 create mode 100644 include/kunit/platform_driver.h
 create mode 100644 lib/kunit/platform_driver-test.c
 create mode 100644 lib/kunit/platform_driver.c

diff --git a/include/kunit/platform_driver.h b/include/kunit/platform_driver.h
new file mode 100644
index 000000000000..dc211ff8f893
--- /dev/null
+++ b/include/kunit/platform_driver.h
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
+kunit_platform_device_alloc(struct kunit *test, const char *name, int id);
+int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev);
+
+int kunit_platform_driver_register(struct kunit *test, struct platform_driver *drv);
+
+#endif
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 29aff6562b42..5964d8231ff5 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
+# Core KUnit code
 kunit-objs +=				test.o \
 					resource.o \
 					string-stream.o \
@@ -11,7 +12,12 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
 
+# KUnit helpers
+kunit-objs +=				platform_driver.o
+
+# KUnit tests
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		platform_driver-test.o
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/platform_driver-test.c b/lib/kunit/platform_driver-test.c
new file mode 100644
index 000000000000..c926fe01b40a
--- /dev/null
+++ b/lib/kunit/platform_driver-test.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for platform driver infrastructure.
+ */
+
+#include <linux/platform_device.h>
+
+#include <kunit/platform_driver.h>
+#include <kunit/test.h>
+
+/*
+ * Test that kunit_platform_device_alloc() creates a platform device.
+ */
+static void kunit_platform_device_alloc_test(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
+			kunit_platform_device_alloc(test, "kunit-platform", 1));
+}
+
+/*
+ * Test that kunit_platform_device_add() registers a platform device on the
+ * platform bus with the proper name and id.
+ */
+static void kunit_platform_device_add_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	const char *name = "kunit-platform";
+	const int id = -1;
+
+	pdev = kunit_platform_device_alloc(test, name, id);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	KUNIT_EXPECT_EQ(test, 0, kunit_platform_device_add(test, pdev));
+	KUNIT_EXPECT_TRUE(test, dev_is_platform(&pdev->dev));
+	KUNIT_EXPECT_STREQ(test, pdev->name, name);
+	KUNIT_EXPECT_EQ(test, pdev->id, id);
+}
+
+static struct kunit_case kunit_platform_device_test_cases[] = {
+	KUNIT_CASE(kunit_platform_device_alloc_test),
+	KUNIT_CASE(kunit_platform_device_add_test),
+	{}
+};
+
+static struct kunit_suite kunit_platform_device_suite = {
+	.name = "kunit_platform_device",
+	.test_cases = kunit_platform_device_test_cases,
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
+/* Test that kunit_platform_driver_register() registers a driver that probes. */
+static void kunit_platform_driver_register_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct kunit_platform_driver_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	pdev = kunit_platform_device_alloc(test, "kunit-platform", -1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
+
+	ctx->pdrv.probe = kunit_platform_driver_probe;
+	ctx->pdrv.driver.name = "kunit-platform";
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
+	KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
+}
+
+static struct kunit_case kunit_platform_driver_test_cases[] = {
+	KUNIT_CASE(kunit_platform_driver_register_test),
+	{}
+};
+
+static struct kunit_suite kunit_platform_driver_suite = {
+	.name = "kunit_platform_driver",
+	.test_cases = kunit_platform_driver_test_cases,
+};
+
+kunit_test_suites(&kunit_platform_device_suite,
+		  &kunit_platform_driver_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/kunit/platform_driver.c b/lib/kunit/platform_driver.c
new file mode 100644
index 000000000000..11d155114936
--- /dev/null
+++ b/lib/kunit/platform_driver.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test managed platform driver
+ */
+
+#include <linux/device/driver.h>
+#include <linux/platform_device.h>
+
+#include <kunit/resource.h>
+
+struct kunit_platform_device_alloc_params {
+	const char *name;
+	int id;
+};
+
+static int kunit_platform_device_alloc_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_platform_device_alloc_params *params = context;
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
+static void kunit_platform_device_alloc_exit(struct kunit_resource *res)
+{
+	struct platform_device *pdev = res->data;
+
+	platform_device_put(pdev);
+}
+
+/**
+ * kunit_platform_device_alloc() - Allocate a KUnit test managed platform device
+ * @test: test context
+ * @dev: platform device to alloc
+ *
+ * Register a test managed platform device. The device is put when the test completes.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+struct platform_device *
+kunit_platform_device_alloc(struct kunit *test, const char *name, int id)
+{
+	struct platform_device *pdev;
+	struct kunit_platform_device_alloc_params params = {
+		.name = name,
+		.id = id,
+	};
+
+	pdev = kunit_alloc_resource(test,
+				   kunit_platform_device_alloc_init,
+				   kunit_platform_device_alloc_exit,
+				   GFP_KERNEL, &params);
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	return pdev;
+}
+EXPORT_SYMBOL_GPL(kunit_platform_device_alloc);
+
+static int kunit_platform_device_add_init(struct kunit_resource *res, void *context)
+{
+	struct platform_device *pdev = context;
+	int ret;
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
+	res->data = pdev;
+
+	return 0;
+}
+
+static void kunit_platform_device_add_exit(struct kunit_resource *res)
+{
+	struct platform_device *pdev = res->data;
+
+	platform_device_unregister(pdev);
+}
+
+/**
+ * kunit_platform_device_add() - Register a KUnit test managed platform device
+ * @test: test context
+ * @dev: platform device to add
+ *
+ * Register a test managed platform device. The device is unregistered when the
+ * test completes.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev)
+{
+	struct platform_device *res;
+
+	res = kunit_alloc_resource(test,
+				   kunit_platform_device_add_init,
+				   kunit_platform_device_add_exit,
+				   GFP_KERNEL, pdev);
+	if (!res)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_platform_device_add);
+
+static int kunit_platform_driver_register_init(struct kunit_resource *res, void *context)
+{
+	struct platform_driver *drv = context;
+	int ret;
+
+	ret = platform_driver_register(drv);
+	if (ret)
+		return ret;
+	res->data = drv;
+
+	/*
+	 * Wait for the driver to probe (or at least flush out of the deferred
+	 * workqueue)
+	 */
+	wait_for_device_probe();
+
+	return 0;
+}
+
+static void kunit_platform_driver_register_exit(struct kunit_resource *res)
+{
+	struct platform_driver *drv = res->data;
+
+	platform_driver_unregister(drv);
+}
+
+/**
+ * kunit_platform_driver_register() - Register a KUnit test managed platform driver
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
+ *		KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
+ *		KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
+ *	}
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int kunit_platform_driver_register(struct kunit *test,
+				   struct platform_driver *drv)
+{
+	struct platform_driver *res;
+
+	res = kunit_alloc_resource(test,
+				   kunit_platform_driver_register_init,
+				   kunit_platform_driver_register_exit,
+				   GFP_KERNEL, drv);
+	if (!res)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_platform_driver_register);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

