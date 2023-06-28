Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70232740DF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjF1JxB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 05:53:01 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:36840 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjF1Jt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:49:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC16612A1;
        Wed, 28 Jun 2023 09:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A299BC433C8;
        Wed, 28 Jun 2023 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687945797;
        bh=rZcqaoz/CBdF7GrtJ5iSysEDcLNhugfhSPfKQxyhYBo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dzxTK2gY0pUHneftUazB97SJMeTvijaJCQNQ6oHRRZNgcmc7BD1n7LJOguGtPZJxC
         c6bJlRAD8BNEGjUs2H0M3cRqHoHz2shCMndFokSXBJA6oRrdi/7wcMgUTKoT7DJXZ9
         JHU5pm/nuVIIASG6NGhSOD0tw60DikNSc41p7EGOXFbN5WSmxDbXQszj9zlB5YKh65
         Zv3oziHJSeG6VBAgT22a3qBwTxEwdu64ArcrVHt9xW+9NzteQ5mc5eq7VR3/6Hb1df
         YAOkJRureIjaVNLdTble5nwY2ZlHdLVARNcF9su6Dzeto1+E0FpB9L2mhdopPVdSQ+
         NvDbLPcyM9Fyw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 28 Jun 2023 11:49:22 +0200
Subject: [PATCH v2 2/3] drivers: base: Add basic devm tests for platform
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-kunit-devm-inconsistencies-test-v2-2-19feb71e864b@kernel.org>
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7457; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rZcqaoz/CBdF7GrtJ5iSysEDcLNhugfhSPfKQxyhYBo=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDClzmDR0Jl9Yy6doWt7D/15tWmZXhn9QbE3Ycn3d1crbH
 loZdwh0lLIwiHExyIopssQImy+JOzXrdScb3zyYOaxMIEMYuDgFYCJFMgz/46RjBRw+pxmcEHKq
 bWI63uoVd/76uWlpDtHOTS/mn/T5ysgw80f4xImLrjLpcT1ZnH+p+hmXQIvPVLsXuQovS9Z4K9/
 gBwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Platform devices show some inconsistencies with how devm resources are
released when the device has been probed and when it hasn't. Let's add a
few tests to exercise thos paths and odd cases.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/base/test/Makefile               |   1 +
 drivers/base/test/platform-device-test.c | 222 +++++++++++++++++++++++++++++++
 2 files changed, 223 insertions(+)

diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index d589ca3fa8fc..e321dfc7e922 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
+obj-$(CONFIG_DM_KUNIT_TEST)	+= platform-device-test.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
 CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
new file mode 100644
index 000000000000..b6ebf1dcdffb
--- /dev/null
+++ b/drivers/base/test/platform-device-test.c
@@ -0,0 +1,222 @@
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
+	wait_queue_head_t probe_wq;
+	wait_queue_head_t release_wq;
+	struct device *dev;
+};
+
+static int platform_device_devm_init(struct kunit *test)
+{
+	struct test_priv *priv;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->probe_wq);
+	init_waitqueue_head(&priv->release_wq);
+
+	test->priv = priv;
+
+	return 0;
+}
+
+static void devm_device_action(void *ptr)
+{
+	struct test_priv *priv = ptr;
+
+	priv->release_done = true;
+	wake_up_interruptible(&priv->release_wq);
+}
+
+static void devm_put_device_action(void *ptr)
+{
+	struct test_priv *priv = ptr;
+
+	put_device(priv->dev);
+	priv->release_done = true;
+	wake_up_interruptible(&priv->release_wq);
+}
+
+#define RELEASE_TIMEOUT_MS	100
+
+/*
+ * Tests that a platform bus, non-probed device will run its
+ * device-managed actions when unregistered.
+ */
+static void platform_device_devm_register_unregister_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv = test->priv;
+	int ret;
+
+	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret = platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->dev = &pdev->dev;
+
+	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+/*
+ * Tests that a platform bus, non-probed device will run its
+ * device-managed actions when unregistered, even if someone still holds
+ * a reference to it.
+ */
+static void platform_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv = test->priv;
+	int ret;
+
+	kunit_skip(test, "This needs to be fixed in the core.");
+
+	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret = platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->dev = &pdev->dev;
+
+	get_device(priv->dev);
+
+	ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static int fake_probe(struct platform_device *pdev)
+{
+	struct test_priv *priv = platform_get_drvdata(pdev);
+
+	priv->probe_done = true;
+	wake_up_interruptible(&priv->probe_wq);
+
+	return 0;
+}
+
+static struct platform_driver fake_driver = {
+	.probe	= fake_probe,
+	.driver = {
+		.name = DEVICE_NAME,
+	},
+};
+
+/*
+ * Tests that a platform bus, probed device will run its device-managed
+ * actions when unregistered.
+ */
+static void probed_platform_device_devm_register_unregister_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv = test->priv;
+	int ret;
+
+	ret = platform_driver_register(&fake_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	ret = platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = wait_event_interruptible_timeout(priv->probe_wq, priv->probe_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+
+	platform_driver_unregister(&fake_driver);
+}
+
+/*
+ * Tests that a platform bus, probed device will run its device-managed
+ * actions when unregistered, even if someone still holds a reference to
+ * it.
+ */
+static void probed_platform_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv = test->priv;
+	int ret;
+
+	ret = platform_driver_register(&fake_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	ret = platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = wait_event_interruptible_timeout(priv->probe_wq, priv->probe_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	get_device(priv->dev);
+
+	ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	platform_device_unregister(pdev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+
+	platform_driver_unregister(&fake_driver);
+}
+
+static struct kunit_case platform_device_devm_tests[] = {
+	KUNIT_CASE(platform_device_devm_register_unregister_test),
+	KUNIT_CASE(platform_device_devm_register_get_unregister_with_devm_test),
+	KUNIT_CASE(probed_platform_device_devm_register_unregister_test),
+	KUNIT_CASE(probed_platform_device_devm_register_get_unregister_with_devm_test),
+	{}
+};
+
+static struct kunit_suite platform_device_devm_test_suite = {
+	.name = "platform-device-devm",
+	.init = platform_device_devm_init,
+	.test_cases = platform_device_devm_tests,
+};
+
+kunit_test_suite(platform_device_devm_test_suite);

-- 
2.40.0

