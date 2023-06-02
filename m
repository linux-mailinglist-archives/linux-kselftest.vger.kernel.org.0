Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0877205D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjFBPVB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjFBPU6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 11:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6343C1B7;
        Fri,  2 Jun 2023 08:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C89D6635D3;
        Fri,  2 Jun 2023 15:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EF7C433D2;
        Fri,  2 Jun 2023 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719255;
        bh=4NRmaXZV297pCf/rzgJTExz6ocam8P1xhVXw4bHqhwg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CezCuPSP1yDJ7fqWIjHJEy2EY8N1mLl2hdhNeXNTmTDrBKVoFB77r5WU1ZKkyglbw
         XykNoFSLRHFAu62ySD2DSe2B0/ybHRQiKmTjyg8akhr8OSrb2Exyxa/17Zhw293Ong
         6oA0bZDFkGEaIiyWqEpYCSaxKO/ws6vIKuQ2141KnF5qtt0m+USJDCAL7OQVoF4vga
         vzWYPsdXpH9rgi4Ae7QptezyWdXCIBAp4xkb7aQuoWSW7BqjanD08gnr1xBM/x6gUX
         3FZHKm38GR5SEuwITddtN9pvpjAlU4WBNUErVGiyuT4CVQQ1Mrm1IL6In2MMhOwqXl
         osFmaqaNkh0aA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 02 Jun 2023 17:20:44 +0200
Subject: [PATCH RESEND 2/2] drivers: base: Add basic devm tests for
 platform devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-kunit-devm-inconsistencies-test-v1-2-015b1574d673@kernel.org>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=9290; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+upD3Qwmbf0hj4qFxXxO0So+EHopJEk8H+Mz64g5xMs=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDClVHOemsz3e+juBZXYFW6iFbXwQz51YtXPs6p1aSir+7wVf
 9md3lLIwiHExyIopssQImy+JOzXrdScb3zyYOaxMIEMYuDgFYCKyAYwMx9sPMRz7yDhRqTjzi9Mv44
 WcZ4XX/P3/hGdh06uF70r3qTIy9CbVn75aF6Q+p+DM8X278pX1brY+uHK08sF5l8SZ+slpbAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Maxime Ripard <maxime@cerno.tech>

Platform devices show some inconsistencies with how devm resources are
released when the device has been probed and when it hasn't. Let's add a
few tests to exercise thos paths and odd cases.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/base/test/Makefile               |   1 +
 drivers/base/test/platform-device-test.c | 278 +++++++++++++++++++++++++++++++
 2 files changed, 279 insertions(+)

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
index 000000000000..2779c6dfac06
--- /dev/null
+++ b/drivers/base/test/platform-device-test.c
@@ -0,0 +1,278 @@
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
+static void platform_device_devm_register_unregister_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+static void platform_device_devm_register_get_put_unregister_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	put_device(priv->dev);
+
+	platform_device_unregister(pdev);
+
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->release_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_EXPECT_GT(test, ret, 0);
+}
+
+static void platform_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+	wake_up_interruptible(&priv->release_wq);
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
+static void probed_platform_device_devm_register_unregister_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->probe_done,
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
+static void probed_platform_device_devm_register_get_put_unregister_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->probe_done,
+					       msecs_to_jiffies(RELEASE_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	get_device(priv->dev);
+
+	ret = devm_add_action_or_reset(priv->dev, devm_device_action, priv);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	put_device(priv->dev);
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
+static void probed_platform_device_devm_register_get_unregister_with_devm_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct test_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	init_waitqueue_head(&priv->release_wq);
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
+	ret = wait_event_interruptible_timeout(priv->release_wq, priv->probe_done,
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
+	KUNIT_CASE(platform_device_devm_register_get_put_unregister_test),
+	KUNIT_CASE(platform_device_devm_register_get_unregister_with_devm_test),
+	KUNIT_CASE(probed_platform_device_devm_register_unregister_test),
+	KUNIT_CASE(probed_platform_device_devm_register_get_put_unregister_test),
+	KUNIT_CASE(probed_platform_device_devm_register_get_unregister_with_devm_test),
+	{}
+};
+
+static struct kunit_suite platform_device_devm_test_suite = {
+	.name = "platform-device-devm",
+	.test_cases = platform_device_devm_tests,
+};
+
+kunit_test_suite(platform_device_devm_test_suite);

-- 
2.40.1

