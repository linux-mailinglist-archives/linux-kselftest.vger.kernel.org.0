Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D372D740E07
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjF1KFx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjF1Jy1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42330FF;
        Wed, 28 Jun 2023 02:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5746126D;
        Wed, 28 Jun 2023 09:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8557C433C8;
        Wed, 28 Jun 2023 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687945793;
        bh=xbWw7cmsOxiNqVKh5JAAK/jC3NoD/LahpRuwtqAGc04=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bZZl1/WZiWc8fVhnPFkBZX2PNzvyJSk3n7A29f8e22BRjm5NR8mU3eMPTKxoxgwmu
         0TTbiimdwFgrz+Bo7R3bQ/45QqBHV0yzpGIDxXS6giYJVvr+gSoiy2qxkS11IsYDFC
         lW+lCz1kHWlXTku3OjAN5bIz0qTO10aPsYZ5yP9spwHmxGIJlESuXkIEs2ilGOrlTa
         +UwUAcJ2mnbo7w1tEhCgdvMmfyZEgunuZLHB37lR9BJnfH8fwa5/XktmlGzEjovC3c
         8PiPX2esh/3iEIqsVPsK7JhjQn05tG0rHjxFpD9CDJfDRt/bRha0Eaf2A7NxjfQlwV
         DB4pkP5M9HvEg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 28 Jun 2023 11:49:21 +0200
Subject: [PATCH v2 1/3] drivers: base: Add basic devm tests for root
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-kunit-devm-inconsistencies-test-v2-1-19feb71e864b@kernel.org>
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4911; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xbWw7cmsOxiNqVKh5JAAK/jC3NoD/LahpRuwtqAGc04=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDClzmDQkb9WZG7smsUSKHpt8UuuGno2bvp8Fu1XV0WcNm
 xJ8Lq/uKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwESmJTD8TysOmNJU56rDOj2o
 zmvxEenVW159aruRL912deP15fpq1YwMn9+sm1R2f5Ukl+bmy1E/ko/NSU01X2Uet4I5Ujen704
 xIwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The root devices show some odd behaviours compared to regular "bus" devices
that have been probed through the usual mechanism, so let's create kunit
tests to exercise those paths and odd cases.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/base/test/.kunitconfig       |   2 +
 drivers/base/test/Kconfig            |   4 ++
 drivers/base/test/Makefile           |   2 +
 drivers/base/test/root-device-test.c | 110 +++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/drivers/base/test/.kunitconfig b/drivers/base/test/.kunitconfig
new file mode 100644
index 000000000000..473923f0998b
--- /dev/null
+++ b/drivers/base/test/.kunitconfig
@@ -0,0 +1,2 @@
+CONFIG_KUNIT=y
+CONFIG_DM_KUNIT_TEST=y
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 610a1ba7a467..9d42051f8f8e 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -9,6 +9,10 @@ config TEST_ASYNC_DRIVER_PROBE
 
 	  If unsure say N.
 
+config DM_KUNIT_TEST
+	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+
 config DRIVER_PE_KUNIT_TEST
 	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 7f76fee6f989..d589ca3fa8fc 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
+obj-$(CONFIG_DM_KUNIT_TEST)	+= root-device-test.o
+
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
 CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
new file mode 100644
index 000000000000..9a3e6cccae13
--- /dev/null
+++ b/drivers/base/test/root-device-test.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2023 Maxime Ripard <mripard@kernel.org>
+
+#include <kunit/resource.h>
+
+#include <linux/device.h>
+
+#define DEVICE_NAME "test"
+
+struct test_priv {
+	bool probe_done;
+	bool release_done;
+	wait_queue_head_t release_wq;
+	struct device *dev;
+};
+
+static int root_device_devm_init(struct kunit *test)
+{
+	struct test_priv *priv;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
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
+#define RELEASE_TIMEOUT_MS	100
+
+/*
+ * Tests that a bus-less, non-probed device will run its device-managed
+ * actions when unregistered.
+ */
+static void root_device_devm_register_unregister_test(struct kunit *test)
+{
+	struct test_priv *priv = test->priv;
+	int ret;
+
+	priv->dev = root_device_register(DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
+
+	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	root_device_unregister(priv->dev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
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
+/*
+ * Tests that a bus-less, non-probed device will run its device-managed
+ * actions when unregistered, even if someone still holds a reference to
+ * it.
+ */
+static void root_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
+{
+	struct test_priv *priv = test->priv;
+	int ret;
+
+	kunit_skip(test, "This needs to be fixed in the core.");
+
+	priv->dev = root_device_register(DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
+
+	get_device(priv->dev);
+
+	ret = devm_add_action_or_reset(priv->dev, devm_put_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	root_device_unregister(priv->dev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static struct kunit_case root_device_devm_tests[] = {
+	KUNIT_CASE(root_device_devm_register_unregister_test),
+	KUNIT_CASE(root_device_devm_register_get_unregister_with_devm_test),
+	{}
+};
+
+static struct kunit_suite root_device_devm_test_suite = {
+	.name = "root-device-devm",
+	.init = root_device_devm_init,
+	.test_cases = root_device_devm_tests,
+};
+
+kunit_test_suite(root_device_devm_test_suite);

-- 
2.40.0

