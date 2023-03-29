Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07E96CF34A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjC2Tkt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjC2Tkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 15:40:40 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD64EEA;
        Wed, 29 Mar 2023 12:40:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3EAD43200319;
        Wed, 29 Mar 2023 15:40:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 29 Mar 2023 15:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680118829; x=1680205229; bh=oCRtzMP0uhnHc8NSGY+rMiPyQyD8My/WGPc
        wgMYk0ag=; b=Paflhy5zi3TirIwPS2HTxoOiDlOG02CcTSdYq1blKtVgdvYLgo+
        4/G3wzIli762MPh/EKPzUgd0knSEJMoD1vCg3eqFbfuvwKi1k/7DHaobJ6tvlHao
        vqE8EE2d89sRs3ywffKbDgMV/8IJ2/mzWK1SvU1pveGPtfRUCoGc/FEgGuU2b4ov
        eeYx0deL6hLxPaqRHfYLtC/Hve9mW3YSse1PlZRXAuJVvOw7OjLBhqu9DqfDfyyb
        6TWsZxFEHut5HP4F3YUvegp2Z8cbAW1X+cPSMcDkYz1ZuSsTmf2IEDWZTiqp8x0T
        cfeZ+he3xZlI4SpejfNm17be6R6YUgs+oww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680118829; x=1680205229; bh=oCRtzMP0uhnHc8NSGY+rMiPyQyD8My/WGPc
        wgMYk0ag=; b=Zgx40hjLjF76VIwFo91xBQpFe2jCR8dhTe+wGrVnReOj0gTCX1O
        qZpXb6RAN7ided81NzRE/V2Nrtk525hZHIO+MN9GRzsYMw0UF09mIpTIgvP9IZqK
        5TG55qQO+YjZdF8adkQpW/XofFmiSsHUMx9wGdFpemvV0jLSJur+0DdI6jW2+L1p
        p8jDCIzwJt1f8ePFxlaE1qKklXTTz8zGipjACIlvfaFClSogGHF4acTOlzeGVGs0
        NuBtUGIycLYceU9LCXrD+TwK21tRsYMaCWNIhpqF7K9elYFLPxKxW930y4yVdhu3
        3mf6wVCVzOuR7RsO58GV0L0ydQ2UUdtRhqw==
X-ME-Sender: <xms:LZQkZMIfl3pwV5psEEcaiuzjQy82S85kgM32-w5Cx2bVHejDO4C1AA>
    <xme:LZQkZMLtrsP-iEHlIFoLZGLAFKK227BGb66EkbutUHue5VTU88B8pgu481bXgyex8
    2DDlG1sH4KIpl4kx-Y>
X-ME-Received: <xmr:LZQkZMvfT93E-yM1fhqWxt6Uoe_JXeyWpYfzzn13PCLqmGXu8UGx91ftDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeevvdelieejgedvkeffheekheeilefhgefgffehteekueelvddtueff
    heetledtffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LZQkZJYXGpzcuvDRpauglNzPOJAVtpJmDvPmPlMHGvJ44PSfxkdlOw>
    <xmx:LZQkZDaT2Padxw1gz_lIc-lAUVMwYJXJQo8q4ITlN6dYF9D7zVmFeA>
    <xmx:LZQkZFDOJ7nmFgpeaIN0F3g_SRFBx0De-djUdfruNx85NmaE4ajAfg>
    <xmx:LZQkZIP58x0PRQkE6cle9sbwxkpjlMrM1YEtYTSMH5ZbZd54kASAzw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Mar 2023 15:40:29 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Wed, 29 Mar 2023 20:38:32 +0100
Subject: [PATCH 2/2] drivers: base: Add basic devm tests for platform
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-kunit-devm-inconsistencies-test-v1-2-c33127048375@cerno.tech>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9290; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=9kHOXiUf2EZjMq29pOLHYOOkBT4xdY/UjBx4g2N5FhM=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCkqk3dFyOuzavx9HVJx8PqvLAueA3/f6y7MaTo3ocEzn
 Sl0zj6ujlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEykwYaR4dGJxBc3jqk6pXVz
 THpnxZqy4GrT4oLCwBf1VTsa9aoX9jD8M+UUje5nd33FJ/pWaE75XbvdSZPXLDrRXacvdjz5dw8
 jMwA=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
2.40.0

