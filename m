Return-Path: <linux-kselftest+bounces-8645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E388AD915
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E2DB2373F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313613C69D;
	Mon, 22 Apr 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo46xM6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E356B7B;
	Mon, 22 Apr 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828252; cv=none; b=PgMixYB3/iplNWJMU1mN3ILXUy+l480RIlywfdwFpAFIV6J2sYkFhazAsBzJAHyfDklwAHBNvYFtwvBWgW/H7gmhUmA31aMr8jk9uhq/qahTXLJU2hTwssoR5nvQW5lpn84EeyafAYyz2dOXiDka4RV9+9LZJECLWVMYVylZ+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828252; c=relaxed/simple;
	bh=yHOPjVOcCE+Ksw5MklAAOSy6V3eOvEnnef42i3XfHTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JP6icmlF79bDUEVqZN3Xl37fd6GlDEUYg4NTE8/64ZKpL6Tsz7mbzlsy631Qb9ze0EymunOeE25AlT06wlN0RvlAMSBUlLs4KtYSfKKRrVVR83vzq9kr+RdcOaC96m6YttpGcYaCmbFUvQ8xlNAqotWnpbSdlgovHKPS5idpYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo46xM6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430CEC2BD11;
	Mon, 22 Apr 2024 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828252;
	bh=yHOPjVOcCE+Ksw5MklAAOSy6V3eOvEnnef42i3XfHTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo46xM6oqrdFMP9M2fHHxtrBfwzuHL7wyzotLNEE1NFpuHDlDnFKHKohJUWVDx9K+
	 Enpy7gqq88W6n/vv4bOscBUi2WTyas98EsZE7mX3bNnVteuGvyJhAqoyi6otZ/ufX8
	 Bgm+LDHp73lkR6d56MG/J6FBkLPCWydKCOmFhCGwFWj6I7duqmdx1cvYAIOCEdC75t
	 2KisW8he0uOosAhxlgvQjrU81/wX8x7bjbqS1MqQ2J0k8kqrG7/Er5nbZcJAzLn9/S
	 H1CIMb5CW7d+7RIkCG7tfI2yVmWuEWYDtq9kghJ6kAWxxA+H0G+FDT9BogbV3REi/O
	 6ousNm7SgAXNQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 05/10] platform: Add test managed platform_device/driver APIs
Date: Mon, 22 Apr 2024 16:23:58 -0700
Message-ID: <20240422232404.213174-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240422232404.213174-1-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce KUnit resource wrappers around platform_driver_register(),
platform_device_alloc(), and platform_device_add() so that test authors
can register platform drivers/devices from their tests and have the
drivers/devices automatically be unregistered when the test is done.

This makes test setup code simpler when a platform driver or platform
device is needed. Add a few test cases at the same time to make sure the
APIs work as intended.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/dev-tools/kunit/api/index.rst   |   5 +
 .../dev-tools/kunit/api/platformdevice.rst    |  10 +
 drivers/base/test/Makefile                    |   3 +
 drivers/base/test/platform_kunit-test.c       | 140 ++++++++++++++
 drivers/base/test/platform_kunit.c            | 174 ++++++++++++++++++
 include/kunit/platform_device.h               |  15 ++
 6 files changed, 347 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
 create mode 100644 drivers/base/test/platform_kunit-test.c
 create mode 100644 drivers/base/test/platform_kunit.c
 create mode 100644 include/kunit/platform_device.h

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 282befa17edf..02b26f5e8750 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -10,6 +10,7 @@ API Reference
 	resource
 	functionredirection
 	of
+	platformdevice
 
 
 This page documents the KUnit kernel testing API. It is divided into the
@@ -36,3 +37,7 @@ Driver KUnit API
 Documentation/dev-tools/kunit/api/of.rst
 
  - Documents the KUnit device tree (OF) API
+
+Documentation/dev-tools/kunit/api/platformdevice.rst
+
+ - Documents the KUnit platform device API
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
index e321dfc7e922..740aef267fbe 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,8 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
+obj-$(CONFIG_KUNIT) += platform_kunit.o
+
 obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
 obj-$(CONFIG_DM_KUNIT_TEST)	+= platform-device-test.o
+obj-$(CONFIG_DM_KUNIT_TEST)	+= platform_kunit-test.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
 CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/platform_kunit-test.c b/drivers/base/test/platform_kunit-test.c
new file mode 100644
index 000000000000..ce545532d209
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
+static void platform_device_add_kunit_twice_fails_test(struct kunit *test)
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
+	KUNIT_CASE(platform_device_add_kunit_twice_fails_test),
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
index 000000000000..54af6db2a6d8
--- /dev/null
+++ b/drivers/base/test/platform_kunit.c
@@ -0,0 +1,174 @@
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
+/**
+ * platform_device_alloc_kunit() - Allocate a KUnit test managed platform device
+ * @test: test context
+ * @name: device name of platform device to alloc
+ * @id: identifier of platform device to alloc.
+ *
+ * Allocate a test managed platform device. The device is put when the test completes.
+ *
+ * Return: Allocated platform device on success, NULL on failure.
+ */
+struct platform_device *
+platform_device_alloc_kunit(struct kunit *test, const char *name, int id)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		return NULL;
+
+	if (kunit_add_action_or_reset(test, (kunit_action_t *)&platform_device_put, pdev))
+		return NULL;
+
+	return pdev;
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
+ * Return: 0 on success, negative errno on failure.
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
+	} else if (kunit_add_action_or_reset(test,
+					     (kunit_action_t *)&platform_device_unregister,
+					     pdev)) {
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_device_add_kunit);
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
+ * Return: 0 on success, negative errno on failure.
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
+	return kunit_add_action_or_reset(test,
+					 (kunit_action_t *)&platform_driver_unregister,
+					 drv);
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


