Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1656CB1A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 00:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjC0WWS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 18:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjC0WWP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 18:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289723C22;
        Mon, 27 Mar 2023 15:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD1BD614BE;
        Mon, 27 Mar 2023 22:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB7CC433A1;
        Mon, 27 Mar 2023 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679955727;
        bh=lRMOO2E269k+cX4x6/50yH0eLshKrFNHYJq+jxmM/IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJxv4IHb09vIvbMHEhD4jTmo/jgb+KtRqOr4g9NZWjaPO0yCaKR2qL+HXiclsaP2h
         RlQRmNdm98z38ptG1HF1NFdBafcDJxVZoo3zarIJF1xouo40RnLEgWv9QqHT4TZlyJ
         llJrdbyVOxKgi6/jrwvZJHVbyITihDx8rDNxsAlQXQBO+Iyxs4Da3zsyGuY1js5/rz
         F+LLcTfvpHxhHIXkoHmuABZtug9S8xIzYTBCjx2XE89Xy5azBd3+cBc9qAjYqM0ajk
         1EG/IVgyyhhMUIySrB4Sa1vOO7zrOs4JXorbBgVNlyIQp1v/uyhHjJYPQBRq7VzC/B
         +zdu595iRtYBw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 09/11] clk: Add KUnit tests for clk fixed rate basic type
Date:   Mon, 27 Mar 2023 15:21:57 -0700
Message-Id: <20230327222159.3509818-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230327222159.3509818-1-sboyd@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test that the fixed rate basic type clk works as intended.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/.kunitconfig                   |   3 +
 drivers/clk/Kconfig                        |   7 +
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-fixed-rate_test.c          | 374 +++++++++++++++++++++
 drivers/clk/clk-fixed-rate_test.h          |   8 +
 drivers/clk/kunit_clk_fixed_rate_test.dtso |  19 ++
 6 files changed, 412 insertions(+)
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.h
 create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index 2fbeb71316f8..5faf67773b74 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -1,5 +1,8 @@
 CONFIG_KUNIT=y
+CONFIG_OF=y
+CONFIG_OF_OVERLAY=y
 CONFIG_COMMON_CLK=y
 CONFIG_CLK_KUNIT_TEST=y
+CONFIG_CLK_FIXED_RATE_KUNIT_TEST=y
 CONFIG_CLK_GATE_KUNIT_TEST=y
 CONFIG_UML_PCI_OVER_VIRTIO=n
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index b6c5bf69a2b2..a992ca5e1efe 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -478,6 +478,13 @@ config CLK_KUNIT_TEST
 	help
 	  Kunit tests for the common clock framework.
 
+config CLK_FIXED_RATE_KUNIT_TEST
+	tristate "Basic fixed rate clk type KUnit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the basic fixed rate clk type.
+
 config CLK_GATE_KUNIT_TEST
 	tristate "Basic gate type Kunit test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 226b4b729703..4fb809f4bd95 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_CLK_KUNIT_TEST)	+= clk_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
+obj-$(CONFIG_CLK_FIXED_RATE_KUNIT_TEST)	+= clk-fixed-rate_test.o kunit_clk_fixed_rate_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
 obj-$(CONFIG_CLK_GATE_KUNIT_TEST) += clk-gate_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
diff --git a/drivers/clk/clk-fixed-rate_test.c b/drivers/clk/clk-fixed-rate_test.c
new file mode 100644
index 000000000000..abe0c11ce9d3
--- /dev/null
+++ b/drivers/clk/clk-fixed-rate_test.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for clk fixed rate basic type
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <kunit/clk.h>
+#include <kunit/of.h>
+#include <kunit/platform_device.h>
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#include "clk-fixed-rate_test.h"
+
+/**
+ * struct clk_hw_fixed_rate_kunit_params - Parameters to pass to __clk_hw_register_fixed_rate()
+ * @dev: device registering clk
+ * @np: device_node of device registering clk
+ * @name: name of clk
+ * @parent_name: parent name of clk
+ * @parent_hw: clk_hw pointer to parent of clk
+ * @parent_data: parent_data describing parent of clk
+ * @flags: clk framework flags
+ * @fixed_rate: frequency of clk
+ * @fixed_accuracy: accuracy of clk
+ * @clk_fixed_flags: fixed rate specific clk flags
+ */
+struct clk_hw_fixed_rate_kunit_params {
+	struct device *dev;
+	struct device_node *np;
+	const char *name;
+	const char *parent_name;
+	const struct clk_hw *parent_hw;
+	const struct clk_parent_data *parent_data;
+	unsigned long flags;
+	unsigned long fixed_rate;
+	unsigned long fixed_accuracy;
+	unsigned long clk_fixed_flags;
+};
+
+static int
+clk_hw_register_fixed_rate_kunit_init(struct kunit_resource *res, void *context)
+{
+	struct clk_hw_fixed_rate_kunit_params *params = context;
+	struct clk_hw *hw;
+
+	hw = __clk_hw_register_fixed_rate(params->dev, params->np,
+					  params->name,
+					  params->parent_name,
+					  params->parent_hw,
+					  params->parent_data,
+					  params->flags,
+					  params->fixed_rate,
+					  params->fixed_accuracy,
+					  params->clk_fixed_flags,
+					  false);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	res->data = hw;
+
+	return 0;
+}
+
+static void clk_hw_register_fixed_rate_kunit_exit(struct kunit_resource *res)
+{
+	struct clk_hw *hw = res->data;
+
+	clk_hw_unregister_fixed_rate(hw);
+}
+
+/**
+ * clk_hw_register_fixed_rate_kunit() - Test managed __clk_hw_register_fixed_rate()
+ * @test: The test context
+ * @params: Arguments to __clk_hw_register_fixed_rate()
+ *
+ * Returns: Registered fixed rate clk_hw or ERR_PTR on failure.
+ */
+static struct clk_hw *
+clk_hw_register_fixed_rate_kunit(struct kunit *test,
+				 struct clk_hw_fixed_rate_kunit_params *params)
+{
+	struct clk_hw *hw;
+
+	hw = kunit_alloc_resource(test,
+				  clk_hw_register_fixed_rate_kunit_init,
+				  clk_hw_register_fixed_rate_kunit_exit,
+				  GFP_KERNEL, params);
+	if (!hw)
+		return ERR_PTR(-EINVAL);
+
+	return hw;
+}
+
+/**
+ * clk_hw_unregister_fixed_rate_kunit() - Test managed clk_hw_unregister_fixed_rate()
+ * @test: The test context
+ * @hw: fixed rate clk to unregister upon test completion
+ *
+ * Automatically unregister @hw when @test is complete via
+ * clk_hw_unregister_fixed_rate().
+ *
+ * Returns: 0 on success or negative errno on failure
+ */
+static int clk_hw_unregister_fixed_rate_kunit(struct kunit *test, struct clk_hw *hw)
+{
+	if (!kunit_alloc_resource(test, NULL,
+				  clk_hw_register_fixed_rate_kunit_exit,
+				  GFP_KERNEL, hw))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * Test that clk_get_rate() on a fixed rate clk registered with
+ * clk_hw_register_fixed_rate() gets the proper frequency.
+ */
+static void clk_fixed_rate_rate_test(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+	const unsigned long fixed_rate = 230000;
+
+	hw = clk_hw_register_fixed_rate(NULL, "test-fixed-rate", NULL, 0, fixed_rate);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_unregister_fixed_rate_kunit(test, hw));
+
+	clk = clk_hw_get_clk_prepared_enabled_kunit(test, hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_EXPECT_EQ(test, fixed_rate, clk_get_rate(clk));
+}
+
+/*
+ * Test that clk_get_accuracy() on a fixed rate clk registered via
+ * clk_hw_register_fixed_rate_with_accuracy() gets the proper accuracy.
+ */
+static void clk_fixed_rate_accuracy_test(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+	const unsigned long fixed_accuracy = 5000;
+
+	hw = clk_hw_register_fixed_rate_with_accuracy(NULL, "test-fixed-rate",
+						      NULL, 0, 0,
+						      fixed_accuracy);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_unregister_fixed_rate_kunit(test, hw));
+
+	clk = clk_hw_get_clk_kunit(test, hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_EXPECT_EQ(test, fixed_accuracy, clk_get_accuracy(clk));
+}
+
+/* Test suite for a fixed rate clk without any parent */
+static struct kunit_case clk_fixed_rate_test_cases[] = {
+	KUNIT_CASE(clk_fixed_rate_rate_test),
+	KUNIT_CASE(clk_fixed_rate_accuracy_test),
+	{}
+};
+
+static struct kunit_suite clk_fixed_rate_suite = {
+	.name = "clk_fixed_rate",
+	.test_cases = clk_fixed_rate_test_cases,
+};
+
+/*
+ * Test that clk_get_parent() on a fixed rate clk gets the proper parent.
+ */
+static void clk_fixed_rate_parent_test(struct kunit *test)
+{
+	struct clk_hw *hw, *parent_hw;
+	struct clk *expected_parent, *actual_parent;
+	struct clk *clk;
+	const char *parent_name = "test-fixed-rate-parent";
+	struct clk_hw_fixed_rate_kunit_params parent_params = {
+		.name = parent_name,
+	};
+
+	parent_hw = clk_hw_register_fixed_rate_kunit(test, &parent_params);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+	KUNIT_ASSERT_STREQ(test, parent_name, clk_hw_get_name(parent_hw));
+
+	expected_parent = clk_hw_get_clk_kunit(test, parent_hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_parent);
+
+	hw = clk_hw_register_fixed_rate(NULL, "test-fixed-rate", parent_name, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_unregister_fixed_rate_kunit(test, hw));
+
+	clk = clk_hw_get_clk_kunit(test, hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	actual_parent = clk_get_parent(clk);
+	KUNIT_EXPECT_TRUE(test, clk_is_match(expected_parent, actual_parent));
+}
+
+/*
+ * Test that clk_get_rate() on a fixed rate clk ignores the parent rate.
+ */
+static void clk_fixed_rate_parent_rate_test(struct kunit *test)
+{
+	struct clk_hw *hw, *parent_hw;
+	struct clk *clk;
+	const unsigned long expected_rate = 1405;
+	const unsigned long parent_rate = 90402;
+	const char *parent_name = "test-fixed-rate-parent";
+	struct clk_hw_fixed_rate_kunit_params parent_params = {
+		.name = parent_name,
+		.fixed_rate = parent_rate,
+	};
+
+	parent_hw = clk_hw_register_fixed_rate_kunit(test, &parent_params);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+	KUNIT_ASSERT_STREQ(test, parent_name, clk_hw_get_name(parent_hw));
+
+	hw = clk_hw_register_fixed_rate(NULL, "test-fixed-rate", parent_name, 0,
+					expected_rate);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_unregister_fixed_rate_kunit(test, hw));
+
+	clk = clk_hw_get_clk_prepared_enabled_kunit(test, hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_EXPECT_EQ(test, expected_rate, clk_get_rate(clk));
+}
+
+/*
+ * Test that clk_get_accuracy() on a fixed rate clk ignores the parent accuracy.
+ */
+static void clk_fixed_rate_parent_accuracy_test(struct kunit *test)
+{
+	struct clk_hw *hw, *parent_hw;
+	struct clk *clk;
+	const unsigned long expected_accuracy = 900;
+	const unsigned long parent_accuracy = 24000;
+	const char *parent_name = "test-fixed-rate-parent";
+	struct clk_hw_fixed_rate_kunit_params parent_params = {
+		.name = parent_name,
+		.fixed_accuracy = parent_accuracy,
+	};
+
+	parent_hw = clk_hw_register_fixed_rate_kunit(test, &parent_params);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+	KUNIT_ASSERT_STREQ(test, parent_name, clk_hw_get_name(parent_hw));
+
+	hw = clk_hw_register_fixed_rate_with_accuracy(NULL, "test-fixed-rate",
+						      parent_name, 0, 0,
+						      expected_accuracy);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_unregister_fixed_rate_kunit(test, hw));
+
+	clk = clk_hw_get_clk_kunit(test, hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_EXPECT_EQ(test, expected_accuracy, clk_get_accuracy(clk));
+}
+
+/* Test suite for a fixed rate clk with a parent */
+static struct kunit_case clk_fixed_rate_parent_test_cases[] = {
+	KUNIT_CASE(clk_fixed_rate_parent_test),
+	KUNIT_CASE(clk_fixed_rate_parent_rate_test),
+	KUNIT_CASE(clk_fixed_rate_parent_accuracy_test),
+	{}
+};
+
+static struct kunit_suite clk_fixed_rate_parent_suite = {
+	.name = "clk_fixed_rate_parent",
+	.test_cases = clk_fixed_rate_parent_test_cases,
+};
+
+struct clk_fixed_rate_of_test_context {
+	struct device *dev;
+	struct platform_driver pdrv;
+};
+
+static inline struct clk_fixed_rate_of_test_context *
+pdev_to_clk_fixed_rate_of_test_context(struct platform_device *pdev)
+{
+	return container_of(to_platform_driver(pdev->dev.driver),
+			    struct clk_fixed_rate_of_test_context,
+			    pdrv);
+}
+
+/*
+ * Test that of_fixed_clk_setup() registers a fixed rate clk with the proper
+ * rate.
+ */
+static void clk_fixed_rate_of_probe_test(struct kunit *test)
+{
+	struct clk_fixed_rate_of_test_context *ctx = test->priv;
+	struct device *dev = ctx->dev;
+	struct clk *clk;
+
+	clk = clk_get_kunit(test, dev, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_ASSERT_EQ(test, 0, clk_prepare_enable_kunit(test, clk));
+	KUNIT_EXPECT_EQ(test, TEST_FIXED_FREQUENCY, clk_get_rate(clk));
+}
+
+/*
+ * Test that of_fixed_clk_setup() registers a fixed rate clk with the proper
+ * accuracy.
+ */
+static void clk_fixed_rate_of_accuracy_test(struct kunit *test)
+{
+	struct clk_fixed_rate_of_test_context *ctx = test->priv;
+	struct device *dev = ctx->dev;
+	struct clk *clk;
+
+	clk = clk_get_kunit(test, dev, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_EXPECT_EQ(test, TEST_FIXED_ACCURACY, clk_get_accuracy(clk));
+}
+
+static struct kunit_case clk_fixed_rate_of_cases[] = {
+	KUNIT_CASE(clk_fixed_rate_of_probe_test),
+	KUNIT_CASE(clk_fixed_rate_of_accuracy_test),
+	{}
+};
+
+static int clk_fixed_rate_of_test_probe(struct platform_device *pdev)
+{
+	struct clk_fixed_rate_of_test_context *ctx;
+
+	ctx = pdev_to_clk_fixed_rate_of_test_context(pdev);
+	ctx->dev = &pdev->dev;
+
+	return 0;
+}
+
+static int clk_fixed_rate_of_init(struct kunit *test)
+{
+	struct clk_fixed_rate_of_test_context *ctx;
+	static const struct of_device_id match_table[] = {
+		{ .compatible = "test,clk-fixed-rate" },
+		{ }
+	};
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_clk_fixed_rate_test));
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->pdrv.probe = clk_fixed_rate_of_test_probe;
+	ctx->pdrv.driver.of_match_table = match_table;
+	ctx->pdrv.driver.name = __func__;
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	return platform_driver_register_kunit(test, &ctx->pdrv);
+}
+
+static struct kunit_suite clk_fixed_rate_of_suite = {
+	.name = "clk_fixed_rate_of",
+	.init = clk_fixed_rate_of_init,
+	.test_cases = clk_fixed_rate_of_cases,
+};
+
+kunit_test_suites(
+	&clk_fixed_rate_suite,
+	&clk_fixed_rate_of_suite,
+	&clk_fixed_rate_parent_suite,
+);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/clk-fixed-rate_test.h b/drivers/clk/clk-fixed-rate_test.h
new file mode 100644
index 000000000000..e0d28e5b6081
--- /dev/null
+++ b/drivers/clk/clk-fixed-rate_test.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _CLK_FIXED_RATE_TEST_H
+#define _CLK_FIXED_RATE_TEST_H
+
+#define TEST_FIXED_FREQUENCY	50000000
+#define TEST_FIXED_ACCURACY	300
+
+#endif
diff --git a/drivers/clk/kunit_clk_fixed_rate_test.dtso b/drivers/clk/kunit_clk_fixed_rate_test.dtso
new file mode 100644
index 000000000000..10989b07e5b3
--- /dev/null
+++ b/drivers/clk/kunit_clk_fixed_rate_test.dtso
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+#include "clk-fixed-rate_test.h"
+
+&{/} {
+	fixed_50MHz: kunit-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <TEST_FIXED_FREQUENCY>;
+		clock-accuracy = <TEST_FIXED_ACCURACY>;
+	};
+
+	kunit-clock-consumer {
+		compatible = "test,clk-fixed-rate";
+		clocks = <&fixed_50MHz>;
+	};
+};
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

