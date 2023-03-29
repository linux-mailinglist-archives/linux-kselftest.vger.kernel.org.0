Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978366CF347
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjC2Tks (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2Tkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 15:40:37 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3175FE5;
        Wed, 29 Mar 2023 12:40:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 28EF33200951;
        Wed, 29 Mar 2023 15:40:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Mar 2023 15:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680118826; x=1680205226; bh=6jrHQ6/YPia8boiljRNhXD4D8z92Q76B7pC
        uLPuNXng=; b=lUNg8eQcjSgyVPFtpidBy709lheQfDkcperusmL1/qCeMTy52Xg
        BikzqSM5//gw3FtMIoIRUr/N3cSnzXtYYL2JfbeS/ZsN2DQjurtFOmOZDvE+vHqY
        yVu3rURZkMvgToqR5rCthmukVPedPlVLB8i8ac44wjww0RnxPlky59Ijs4k88kMh
        +TkPulLQoWO9SMSSC72/WuHzTZvtnTyVp9TlW+OPqp1WPgWp5j6bYybREkU3EROg
        Eh44irwclVKF89ig6WmxvuCOhth/96e2V0jX2dlWksm6KztB03uyEdKTRyDqAWsV
        75imSqHDnrRxR23EZeZ3ndMzlARBqzUpwNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680118826; x=1680205226; bh=6jrHQ6/YPia8boiljRNhXD4D8z92Q76B7pC
        uLPuNXng=; b=p/bjry/+At4m9ClE7Vp8BUeYccAMbrlXGdY/gRz0zoKK/DOobHt
        /Om+AfdcOnUR14Ijxe9NYaCVz3qWTCfzpMsfbUzKVkORp1gGzE/caitQ9KXVDoWE
        cM8NgHHp8WjgUc8EVV6N4KnqAcXgwhIVNzwIvHv2audaYq6r0xdHsK1itVX+9WZZ
        IOs68nDzO8A+wsFursqm2MQoML7OHO9dbZgDsFuzUescMQJWZ3Bqq60sUPHJQbV8
        G08Uc7MYQ1Kz91n1CG8Cc4usr5WC8/5+U4QPALbQEDOKXEralNwCuybBScv7+Pjh
        VtJgT3Rbbt4nmVvG55QIXXecwQ255ZaNWyQ==
X-ME-Sender: <xms:KpQkZBVmP_1CPHqpxsJdsFJiSaneu9p6V2Iygjqs_muSuI0EZhNTFA>
    <xme:KpQkZBlxB2MwHddYf2KgSMIKUCjOxdqlaPSPpROsCuTc5ZG1kZa0ZrrEerSXHvxew
    w7czoHOfjlG_rueu0k>
X-ME-Received: <xmr:KpQkZNb1M8IR9iJ4QCNuZX81_Wnl5Ez44M1DG6-VoSmcv0jDH4B_0GtnUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeevvdelieejgedvkeffheekheeilefhgefgffehteekueelvddtueff
    heetledtffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KpQkZEVcKdnlnHJsUrRQFN-yUqwlnaoafSfF3lNR82HpN9fqrHEVJw>
    <xmx:KpQkZLkLYsH_v60eWzXMvXX3Pu_ynFOu2sYC2iuIZczYXjtemvG21w>
    <xmx:KpQkZBfQuSqGjIBZlkh6b2avcgdmwVI-fjc9WJrRnRj7ZAVcnZSI_g>
    <xmx:KpQkZJZ61pi51LTve7G2rtyP7DN4Q_5gPXdCCuHe78uyCx6oq8ukGQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Mar 2023 15:40:25 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Wed, 29 Mar 2023 20:38:31 +0100
Subject: [PATCH 1/2] drivers: base: Add basic devm tests for root devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-kunit-devm-inconsistencies-test-v1-1-c33127048375@cerno.tech>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5347; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=OS9EEWkczT/VRoCJKj+k8TghFo5xQF8yMCiLwlIENmU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCkqk3clGh++a7RyQfFcT7Oze80PrG4/bukydf13D7vFQ
 ndqlvj/7yhlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBEdlxl+CtwL+vh/rmzm+4+
 /rtx/suHOet4b+a9ON1aVtC4463Eta9ijAwP79+aculDDde+R3ZX9ncv7JovHqxr3Z18dTPnqsV
 u/1XYAA==
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
2.40.0

