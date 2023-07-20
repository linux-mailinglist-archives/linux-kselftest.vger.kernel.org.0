Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F72C75AEAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGTMp3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 08:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGTMpZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 08:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6D26A9;
        Thu, 20 Jul 2023 05:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E4361A8B;
        Thu, 20 Jul 2023 12:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9CDC433C8;
        Thu, 20 Jul 2023 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689857119;
        bh=8IOySnpTmyXSWuK7L3QmCKUbkD1t8RLwEFPQIb+aA90=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Y3WHwurCpZ0welbIc4KXl0Xeh9ELtXr67OKJBxPyeK6mFXR9Ym8GS+QGAfWcnkzkL
         c3h8Rvmv7y0oOKZxVd1OjNhJejc/ifFgkdUj21PlYCEGDF1HbQgX6lvANZmkmRv1fJ
         EHFii4cXMk+hUgG5Uym+z+KiGubGBRs7wX3dZnbC0E5pzOJo9RQ4SnhjMuUpAfNdOQ
         6GpkcxbRvHAWPpGjLe1cmaWNWBErCkcInabqBy/KHP+2dKuMRy31XyE86Xz59CYAiB
         JSs3xjuV45ksTQIMtu6ESDAHDNGh7aEEzjP3Z64QV2Ipr0N46YIy9tsK1VnNe4Fnkb
         zwVuo6/2XAe7Q==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 14:45:07 +0200
Subject: [PATCH v3 1/3] drivers: base: Add basic devm tests for root
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kunit-devm-inconsistencies-test-v3-1-6aa7e074f373@kernel.org>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
In-Reply-To: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5424; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8IOySnpTmyXSWuK7L3QmCKUbkD1t8RLwEFPQIb+aA90=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7dSIcznNsPz63S5mXKS32vVN/l6qZGcvFj+ql37mSu
 T7EsYd0lLIwiHExyIopssQImy+JOzXrdScb3zyYOaxMIEMYuDgFYCKv1BgZXkytyJzWcKvDmrO8
 PNs0Z83r/y/O3tjz3XrlkvfbWAMV7BkZzhnETwyquMpiU21iZVV5banKD6UNFu0t8sJ7J4j92yH
 CBwA=
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

The root devices show some odd behaviours compared to regular "bus" devices
that have been probed through the usual mechanism, so let's create kunit
tests to exercise those paths and odd cases.

It's not clear whether root devices are even allowed to use device
managed resources, but the fact that it works in some cases but not
others like shown in that test suite shouldn't happen either way: we
want to make it consistent and documented.

These tests will (after the following patches) ensure that consistency
and effectively document that it's allowed.

If it ever turns out to be a bad idea, we can always roll back and
modify the tests then.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
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
2.41.0

