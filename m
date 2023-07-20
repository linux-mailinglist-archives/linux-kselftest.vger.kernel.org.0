Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E413575AEB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGTMpr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjGTMpa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 08:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1242690;
        Thu, 20 Jul 2023 05:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F0961A77;
        Thu, 20 Jul 2023 12:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C7C433C7;
        Thu, 20 Jul 2023 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689857121;
        bh=jh5HlgHr0tntYKi2YKW8GWjCSxPgRIdKfqKt13WVbd4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rjNy7fkseKFpz7WLroBf2VO4giyz1i9dlNUN5sRveyRv2IrTI6VrR2VLzirvxbl0h
         UTVjg3vw6k5vK5IELq5tUx3kr9yJoYIlCwoUHdnpFgd+pqmnof4teNtXDaEbAF1BVD
         Os3bU+sVTBZVTDTMT0HWHy2brPJbcsogcXkNrRlXZ3818rxb78pG3VJNykqV5sVbCb
         lfH/uPg+JRqLPRir5SyGHGJI2SrXnsG2IIFxPwIVS53ue8aa2MeLlqg3FF8mrkgWjU
         5lg60kk2CHtO7R/VoHHX/D7r2pMYVhKNBjq+hzti+OuLPnc/XgwyY1DXmQREOGNDek
         pM45waRGfhR5g==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 14:45:08 +0200
Subject: [PATCH v3 2/3] drivers: base: Add basic devm tests for platform
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kunit-devm-inconsistencies-test-v3-2-6aa7e074f373@kernel.org>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
In-Reply-To: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8336; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jh5HlgHr0tntYKi2YKW8GWjCSxPgRIdKfqKt13WVbd4=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7dSI3BLfk+fxk/ypyR9PxRNux3k1cpr9tv+TcOFzXM
 5dNaxdfRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACZiGMvwVzK66IDd1dYfq/Nb
 Go99vJnqefhKaMyO0K8XrEpeXnux4gHDP6trv2ZKT5199dhnniV/K4W4P6zJbb8rlT27kb2ZzaH
 8HC8A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Platform devices show some inconsistencies with how devm resources are
released when the device has been probed and when it hasn't.

In particular, we can register device-managed actions no matter if the
device has be bound to a driver or not, but devres_release_all() will
only be called if it was bound to a driver or if there's no reference
held to it anymore.

If it wasn't bound to a driver and we still have a reference,
devres_release_all() will never get called. This is surprising
considering that if the driver isn't bound but doesn't have any
reference to it anymore, that function will get called, and if it was
bound to a driver but still has references, that function will get
called as well.

Even if that case is fairly unusual, it can easily lead to memory leaks.

The plan is, with the next patch, to make it consistent and enforce that
devres_release_all() is called no matter what situation we're in. For
now, it just tests for the current behaviour and skips over the
inconsistencies.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
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
2.41.0

