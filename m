Return-Path: <linux-kselftest+bounces-13510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D592D9D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29711C20F4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 20:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA391991AB;
	Wed, 10 Jul 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGpZAZCb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBF1991A0;
	Wed, 10 Jul 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642373; cv=none; b=SYrzRLQq5yzN9bbmts2V3p2jOKlcntBOsqc93UnX+vofuWWJEquBlGrmOdIkbgPVu+5f7mc1a8Dub81/hmHjovpHkLZV45bz/ZEtPfJYpB+hK7JFGTOQ3Kv347uQI5cHLKCcclifUKQdMaItnUMPfDYuOR59r/e8uN4pTyZc95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642373; c=relaxed/simple;
	bh=n1S/kZHXlE8AgYjLTZvPqoFMaf/kirIHM9CTO0L4VoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/nhPDVsbNfohObUNxI4DAPcJCIVB2ivKCCj4vIbreSXF1+WFfi1PoygxANW5kTehAf/8wV77SFERFtpWJfzQMwXERm21XFcqC+nf7VKvHIUo3ox2ZU6r/RUoPoU0C3ejDdCoFl7zbCgIEWiOqvWEPzVEcyHD2IWIOs2LwG6Q/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGpZAZCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AB3C32782;
	Wed, 10 Jul 2024 20:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720642373;
	bh=n1S/kZHXlE8AgYjLTZvPqoFMaf/kirIHM9CTO0L4VoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGpZAZCbHGJsPG0VzxC11QTkb6laX2XXkwTcQpnU86mHppXnw8qOjW631TcffrzYl
	 CXOuVf8qp3gAM2vVz6LWx89tUfEFK3wngcDDD4c3rAxc2PAi3GTKKbXvBCPZWsawJh
	 HKIpe5S4cGOBzKou7uB0UMgFWJJBV0/vySCQJgBShHeDLaDJ8zlsSsQNMs0GmRXKLx
	 XQkiyt+0rYcsegtjBpua3WajQmbSuld/KsCS1zkBTkbrC06MrzdDcTmuBVdZL09fOk
	 p/xa3HaBOfNjoRJUwEOaDhI8OYWgmOFhjNICiiY3ba18tEfHB8ZU6d6naSPn92Ay5z
	 VR48MmfUTh1xQ==
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
Subject: [PATCH v7 5/8] platform: Add test managed platform_device/driver APIs
Date: Wed, 10 Jul 2024 13:12:41 -0700
Message-ID: <20240710201246.1802189-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240710201246.1802189-1-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org>
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
Reviewed-by: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/dev-tools/kunit/api/index.rst   |   5 +
 .../dev-tools/kunit/api/platformdevice.rst    |  10 +
 include/kunit/platform_device.h               |  20 ++
 lib/kunit/Makefile                            |   4 +-
 lib/kunit/platform-test.c                     | 224 +++++++++++++
 lib/kunit/platform.c                          | 302 ++++++++++++++++++
 6 files changed, 564 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
 create mode 100644 include/kunit/platform_device.h
 create mode 100644 lib/kunit/platform-test.c
 create mode 100644 lib/kunit/platform.c

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
index 000000000000..49ddd5729003
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
+.. kernel-doc:: lib/kunit/platform.c
+   :export:
diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
new file mode 100644
index 000000000000..0fc0999d2420
--- /dev/null
+++ b/include/kunit/platform_device.h
@@ -0,0 +1,20 @@
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
+int kunit_platform_device_prepare_wait_for_probe(struct kunit *test,
+						 struct platform_device *pdev,
+						 struct completion *x);
+
+int kunit_platform_driver_register(struct kunit *test,
+				   struct platform_driver *drv);
+
+#endif
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 309659a32a78..a980ae62eff6 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -8,7 +8,8 @@ kunit-objs +=				test.o \
 					try-catch.o \
 					executor.o \
 					attributes.o \
-					device.o
+					device.o \
+					platform.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
@@ -18,6 +19,7 @@ endif
 obj-y +=				hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/platform-test.c b/lib/kunit/platform-test.c
new file mode 100644
index 000000000000..e3debb8fbcef
--- /dev/null
+++ b/lib/kunit/platform-test.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for KUnit platform driver infrastructure.
+ */
+
+#include <linux/platform_device.h>
+
+#include <kunit/platform_device.h>
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
+	const char *name = "kunit-platform-add";
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
+/*
+ * Test that kunit_platform_device_add() called twice with the same device name
+ * and id fails the second time and properly cleans up.
+ */
+static void kunit_platform_device_add_twice_fails_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	const char *name = "kunit-platform-add-2";
+	const int id = -1;
+
+	pdev = kunit_platform_device_alloc(test, name, id);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
+
+	pdev = kunit_platform_device_alloc(test, name, id);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	KUNIT_EXPECT_NE(test, 0, kunit_platform_device_add(test, pdev));
+}
+
+static int kunit_platform_device_find_by_name(struct device *dev, const void *data)
+{
+	return strcmp(dev_name(dev), data) == 0;
+}
+
+/*
+ * Test that kunit_platform_device_add() cleans up by removing the platform
+ * device when the test finishes. */
+static void kunit_platform_device_add_cleans_up(struct kunit *test)
+{
+	struct platform_device *pdev;
+	const char *name = "kunit-platform-clean";
+	const int id = -1;
+	struct kunit fake;
+	struct device *dev;
+
+	kunit_init_test(&fake, "kunit_platform_device_add_fake_test", NULL);
+	KUNIT_ASSERT_EQ(test, fake.status, KUNIT_SUCCESS);
+
+	pdev = kunit_platform_device_alloc(&fake, name, id);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(&fake, pdev));
+	dev = bus_find_device(&platform_bus_type, NULL, name,
+			      kunit_platform_device_find_by_name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	put_device(dev);
+
+	/* Remove pdev */
+	kunit_cleanup(&fake);
+
+	/*
+	 * Failing to migrate the kunit_resource would lead to an extra
+	 * put_device() call on the platform device. The best we can do here is
+	 * make sure the device no longer exists on the bus, but if something
+	 * is wrong we'll see a refcount underflow here. We can't test for a
+	 * refcount underflow because the kref matches the lifetime of the
+	 * device which should already be freed and could be used by something
+	 * else.
+	 */
+	dev = bus_find_device(&platform_bus_type, NULL, name,
+			      kunit_platform_device_find_by_name);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
+	put_device(dev);
+}
+
+/*
+ * Test suite for struct platform_device kunit APIs
+ */
+static struct kunit_case kunit_platform_device_test_cases[] = {
+	KUNIT_CASE(kunit_platform_device_alloc_test),
+	KUNIT_CASE(kunit_platform_device_add_test),
+	KUNIT_CASE(kunit_platform_device_add_twice_fails_test),
+	KUNIT_CASE(kunit_platform_device_add_cleans_up),
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
+/* Test that kunit_platform_driver_register() registers a driver that probes. */
+static void kunit_platform_driver_register_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct kunit_platform_driver_test_context *ctx;
+	DECLARE_COMPLETION_ONSTACK(comp);
+	const char *name = "kunit-platform-register";
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	pdev = kunit_platform_device_alloc(test, name, -1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
+
+	ctx->pdrv.probe = kunit_platform_driver_probe;
+	ctx->pdrv.driver.name = name;
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
+
+	KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
+	KUNIT_EXPECT_NE(test, 0, wait_for_completion_timeout(&comp, 3 * HZ));
+	KUNIT_EXPECT_STREQ(test, ctx->data, test_data);
+}
+
+/*
+ * Test that kunit_platform_device_prepare_wait_for_probe() completes the completion
+ * when the device is already probed.
+ */
+static void kunit_platform_device_prepare_wait_for_probe_completes_when_already_probed(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct kunit_platform_driver_test_context *ctx;
+	DECLARE_COMPLETION_ONSTACK(comp);
+	const char *name = "kunit-platform-wait";
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	pdev = kunit_platform_device_alloc(test, name, -1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
+
+	ctx->pdrv.probe = kunit_platform_driver_probe;
+	ctx->pdrv.driver.name = name;
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	/* Make sure driver has actually probed */
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
+	KUNIT_ASSERT_NE(test, 0, wait_for_completion_timeout(&comp, 3 * HZ));
+
+	reinit_completion(&comp);
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
+
+	KUNIT_EXPECT_NE(test, 0, wait_for_completion_timeout(&comp, HZ));
+}
+
+static struct kunit_case kunit_platform_driver_test_cases[] = {
+	KUNIT_CASE(kunit_platform_driver_register_test),
+	KUNIT_CASE(kunit_platform_device_prepare_wait_for_probe_completes_when_already_probed),
+	{}
+};
+
+/*
+ * Test suite for struct platform_driver kunit APIs
+ */
+static struct kunit_suite kunit_platform_driver_suite = {
+	.name = "kunit_platform_driver",
+	.test_cases = kunit_platform_driver_test_cases,
+};
+
+kunit_test_suites(
+	&kunit_platform_device_suite,
+	&kunit_platform_driver_suite,
+);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test for KUnit platform driver infrastructure");
diff --git a/lib/kunit/platform.c b/lib/kunit/platform.c
new file mode 100644
index 000000000000..0b518de26065
--- /dev/null
+++ b/lib/kunit/platform.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test managed platform driver
+ */
+
+#include <linux/completion.h>
+#include <linux/device/bus.h>
+#include <linux/device/driver.h>
+#include <linux/platform_device.h>
+
+#include <kunit/platform_device.h>
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
+ * @name: device name of platform device to alloc
+ * @id: identifier of platform device to alloc.
+ *
+ * Allocate a test managed platform device. The device is put when the test completes.
+ *
+ * Return: Allocated platform device on success, NULL on failure.
+ */
+struct platform_device *
+kunit_platform_device_alloc(struct kunit *test, const char *name, int id)
+{
+	struct kunit_platform_device_alloc_params params = {
+		.name = name,
+		.id = id,
+	};
+
+	return kunit_alloc_resource(test,
+				    kunit_platform_device_alloc_init,
+				    kunit_platform_device_alloc_exit,
+				    GFP_KERNEL, &params);
+}
+EXPORT_SYMBOL_GPL(kunit_platform_device_alloc);
+
+static void kunit_platform_device_add_exit(struct kunit_resource *res)
+{
+	struct platform_device *pdev = res->data;
+
+	platform_device_unregister(pdev);
+}
+
+static bool
+kunit_platform_device_alloc_match(struct kunit *test,
+				  struct kunit_resource *res, void *match_data)
+{
+	struct platform_device *pdev = match_data;
+
+	return res->data == pdev && res->free == kunit_platform_device_alloc_exit;
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(platform_device_unregister_wrapper,
+			    platform_device_unregister, struct platform_device *);
+/**
+ * kunit_platform_device_add() - Register a KUnit test managed platform device
+ * @test: test context
+ * @pdev: platform device to add
+ *
+ * Register a test managed platform device. The device is unregistered when the
+ * test completes.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ret;
+
+	res = kunit_find_resource(test, kunit_platform_device_alloc_match, pdev);
+	if (res) {
+		/*
+		 * Transfer the reference count of the platform device if it
+		 * was allocated with kunit_platform_device_alloc(). In this
+		 * case, calling platform_device_put() when the test exits from
+		 * kunit_platform_device_alloc_exit() would lead to reference
+		 * count underflow because platform_device_unregister_wrapper()
+		 * calls platform_device_unregister() which also calls
+		 * platform_device_put().
+		 *
+		 * Usually callers transfer the refcount initialized in
+		 * platform_device_alloc() to platform_device_add() by calling
+		 * platform_device_unregister() when platform_device_add()
+		 * succeeds or platform_device_put() when it fails. KUnit has to
+		 * keep this straight by redirecting the free routine for the
+		 * resource to the right function. Luckily this only has to
+		 * account for the success scenario.
+		 */
+		res->free = kunit_platform_device_add_exit;
+		kunit_put_resource(res);
+	} else {
+		ret = kunit_add_action_or_reset(test, platform_device_unregister_wrapper, pdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_platform_device_add);
+
+struct kunit_platform_device_probe_nb {
+	struct completion *x;
+	struct device *dev;
+	struct notifier_block nb;
+};
+
+static int kunit_platform_device_probe_notify(struct notifier_block *nb,
+					      unsigned long event, void *data)
+{
+	struct kunit_platform_device_probe_nb *knb;
+	struct device *dev = data;
+
+	knb = container_of(nb, struct kunit_platform_device_probe_nb, nb);
+	if (event != BUS_NOTIFY_BOUND_DRIVER || knb->dev != dev)
+		return NOTIFY_DONE;
+
+	complete(knb->x);
+
+	return NOTIFY_OK;
+}
+
+static void kunit_platform_device_probe_nb_remove(void *nb)
+{
+	bus_unregister_notifier(&platform_bus_type, nb);
+}
+
+/**
+ * kunit_platform_device_prepare_wait_for_probe() - Prepare a completion
+ * variable to wait for a platform device to probe
+ * @test: test context
+ * @pdev: platform device to prepare to wait for probe of
+ * @x: completion variable completed when @dev has probed
+ *
+ * Prepare a completion variable @x to wait for @pdev to probe. Waiting on the
+ * completion forces a preemption, allowing the platform driver to probe.
+ *
+ * Example
+ *
+ * .. code-block:: c
+ *
+ *	static int kunit_platform_driver_probe(struct platform_device *pdev)
+ *	{
+ *		return 0;
+ *	}
+ *
+ *	static void kunit_platform_driver_test(struct kunit *test)
+ *	{
+ *		struct platform_device *pdev;
+ *		struct platform_driver *pdrv;
+ *		DECLARE_COMPLETION_ONSTACK(comp);
+ *
+ *		pdev = kunit_platform_device_alloc(test, "kunit-platform", -1);
+ *		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+ *		KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
+ *
+ *		pdrv = kunit_kzalloc(test, sizeof(*pdrv), GFP_KERNEL);
+ *		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdrv);
+ *
+ *		pdrv->probe = kunit_platform_driver_probe;
+ *		pdrv->driver.name = "kunit-platform";
+ *		pdrv->driver.owner = THIS_MODULE;
+ *
+ *		KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
+ *		KUNIT_ASSERT_EQ(test, 0, kunit_platform_driver_register(test, pdrv));
+ *
+ *		KUNIT_EXPECT_NE(test, 0, wait_for_completion_timeout(&comp, 3 * HZ));
+ *	}
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int kunit_platform_device_prepare_wait_for_probe(struct kunit *test,
+						 struct platform_device *pdev,
+						 struct completion *x)
+{
+	struct device *dev = &pdev->dev;
+	struct kunit_platform_device_probe_nb *knb;
+	bool bound;
+
+	knb = kunit_kzalloc(test, sizeof(*knb), GFP_KERNEL);
+	if (!knb)
+		return -ENOMEM;
+
+	knb->nb.notifier_call = kunit_platform_device_probe_notify;
+	knb->dev = dev;
+	knb->x = x;
+
+	device_lock(dev);
+	bound = device_is_bound(dev);
+	if (bound) {
+		device_unlock(dev);
+		complete(x);
+		kunit_kfree(test, knb);
+		return 0;
+	}
+
+	bus_register_notifier(&platform_bus_type, &knb->nb);
+	device_unlock(&pdev->dev);
+
+	return kunit_add_action_or_reset(test, kunit_platform_device_probe_nb_remove, &knb->nb);
+}
+EXPORT_SYMBOL_GPL(kunit_platform_device_prepare_wait_for_probe);
+
+KUNIT_DEFINE_ACTION_WRAPPER(platform_driver_unregister_wrapper,
+			    platform_driver_unregister, struct platform_driver *);
+/**
+ * kunit_platform_driver_register() - Register a KUnit test managed platform driver
+ * @test: test context
+ * @drv: platform driver to register
+ *
+ * Register a test managed platform driver. This allows callers to embed the
+ * @drv in a container structure and use container_of() in the probe function
+ * to pass information to KUnit tests.
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
+ *		KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
+ *		<... wait for driver to probe ...>
+ *		KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
+ *	}
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int kunit_platform_driver_register(struct kunit *test,
+				   struct platform_driver *drv)
+{
+	int ret;
+
+	ret = platform_driver_register(drv);
+	if (ret)
+		return ret;
+
+	return kunit_add_action_or_reset(test, platform_driver_unregister_wrapper, drv);
+}
+EXPORT_SYMBOL_GPL(kunit_platform_driver_register);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


