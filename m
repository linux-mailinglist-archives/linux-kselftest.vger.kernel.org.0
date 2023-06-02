Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30477205D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjFBPVA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjFBPUy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 11:20:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B318C;
        Fri,  2 Jun 2023 08:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96FF861913;
        Fri,  2 Jun 2023 15:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5BBC433EF;
        Fri,  2 Jun 2023 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719252;
        bh=8XaJXcozLlYKjV2jpZ+W8q+KArXiOK3wSFoJ+w0AxzE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FGJ9XMyMb1Zxkfy55ebN+xqmcuowDl8VVdS1S8oivtIoGaOkIyf6ldVrnUtL/P0bM
         UMao67EfGbhlbYdERRnQy2bbylDUE0co3Yz7bVCRU433qFqr7P71bumyXAPTnSjCe+
         dCuiE5XcAH+TNcmtjbqMWZ1nzx1dL6cFGinLrG+mJvStpYV5L+Lgy6/52O/XjfOOqj
         FuWRMaFD2PzL554taxCRqC/g3dRXFKprSuXGwX0neuJ4ATO4dg8SYQiXFcMGOz9fc3
         p6PAF2aqJ2i8c1DdZGhx3eiUxfOiAyzqk4bkvnLDMnk0kJ/oNeWuqtPLbangZvh4CT
         Kr1NsBUcasSig==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 02 Jun 2023 17:20:43 +0200
Subject: [PATCH RESEND 1/2] drivers: base: Add basic devm tests for root
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=5347; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ivcxwQWQcXWS/fXksYR14wmFIo787eFmeMtomO6iXEU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDClVHOdsomK/3jLNc/mWpGLYnf920/5Pf5NKbggFW801Tsjb
 v+x1RykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACbCv5Phn37TqbjPJ0/mbOkO2vlG5G
 m9UVWVXu332ZIajjvVcvPvrWBkuDB7q+mqkj/rTgv8mvDFpdHt7uKZNnwylY8PzJn3/niYGQMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Maxime Ripard <maxime@cerno.tech>

The root devices show some odd behaviours compared to regular "bus" devices
that have been probed through the usual mechanism, so let's create kunit
tests to exercise those paths and odd cases.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/base/test/.kunitconfig       |   2 +
 drivers/base/test/Kconfig            |   4 ++
 drivers/base/test/Makefile           |   2 +
 drivers/base/test/root-device-test.c | 120 +++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)

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
index 000000000000..fcb55d8882aa
--- /dev/null
+++ b/drivers/base/test/root-device-test.c
@@ -0,0 +1,120 @@
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
+#define RELEASE_TIMEOUT_MS	500
+
+static void root_device_devm_register_unregister_test(struct kunit *test)
+{
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+static void root_device_devm_register_get_put_unregister_test(struct kunit *test)
+{
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
+
+	priv->dev = root_device_register(DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
+
+	get_device(priv->dev);
+
+	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	put_device(priv->dev);
+
+	root_device_unregister(priv->dev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static void root_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
+{
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+	KUNIT_CASE(root_device_devm_register_get_put_unregister_test),
+	KUNIT_CASE(root_device_devm_register_get_unregister_with_devm_test),
+	{}
+};
+
+static struct kunit_suite root_device_devm_test_suite = {
+	.name = "root-device-devm",
+	.test_cases = root_device_devm_tests,
+};
+
+kunit_test_suite(root_device_devm_test_suite);

-- 
2.40.1

