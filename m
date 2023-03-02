Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5576A7906
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCBBis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCBBio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:38:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3D23DB3;
        Wed,  1 Mar 2023 17:38:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE7F5B811E7;
        Thu,  2 Mar 2023 01:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F07C433A7;
        Thu,  2 Mar 2023 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677721108;
        bh=YUrgmkmhNxjIFII2DN6KJTUk7Xh2e6Kirr02L2QOPVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGJUS7xpzaWHki88lJN+lhc/1chy0l1LrjFyvlEv6IU30LKGxCFsBQw7hHQvSkvPq
         vEJrFH98oL7OsZ8o1OKjQxvjJr7siTFZHHROH5r73qZw4nuuAX2MwJWcA9cke7MT2h
         mLxZWWi7xybOGcpcgzFe1ZYUenI/E9eZ4TuU/T8UaDZA19+3hKkmF87DlI0KUR8o0Y
         wvIiApxrC7FXDJwSof6h2Rgt+clUK1Ef5mMamrNq30v2kIuzRFzKuK1Ov4RedPU7jI
         CaUbf+zoLT/9XaVl6mQZBwxDhRHcEeKeh5ozPK6Eqdzcl1rHpEbMl0V01REdM+TnxE
         bLXmgEaUhF8ww==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 6/8] clk: Add KUnit tests for clk fixed rate basic type
Date:   Wed,  1 Mar 2023 17:38:19 -0800
Message-Id: <20230302013822.1808711-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

This should be extended somewhat to test various combinations of the
registration functions.

 drivers/clk/.kunitconfig          |   3 +
 drivers/clk/Kconfig               |   7 +
 drivers/clk/Makefile              |   1 +
 drivers/clk/clk-fixed-rate_test.c | 296 ++++++++++++++++++++++++++++++
 drivers/of/kunit/clk.dtsi         |  15 ++
 drivers/of/kunit/kunit.dtsi       |   1 +
 6 files changed, 323 insertions(+)
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/of/kunit/clk.dtsi

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index 2fbeb71316f8..3616cebd22f5 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -1,5 +1,8 @@
 CONFIG_KUNIT=y
+CONFIG_OF=y
+CONFIG_OF_KUNIT=y
 CONFIG_COMMON_CLK=y
 CONFIG_CLK_KUNIT_TEST=y
+CONFIG_CLK_FIXED_RATE_KUNIT_TEST=y
 CONFIG_CLK_GATE_KUNIT_TEST=y
 CONFIG_UML_PCI_OVER_VIRTIO=n
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d79905f3e174..4849046b821f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -479,6 +479,13 @@ config CLK_KUNIT_TEST
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
index 7efce649b0d3..e0689e9f73a4 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_CLK_KUNIT_TEST)	+= clk_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
+obj-$(CONFIG_CLK_FIXED_RATE_KUNIT_TEST)	+= clk-fixed-rate_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
 obj-$(CONFIG_CLK_GATE_KUNIT_TEST) += clk-gate_test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
diff --git a/drivers/clk/clk-fixed-rate_test.c b/drivers/clk/clk-fixed-rate_test.c
new file mode 100644
index 000000000000..82e9e59a327c
--- /dev/null
+++ b/drivers/clk/clk-fixed-rate_test.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for clk fixed rate basic type
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <kunit/platform_driver.h>
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#include "clk-kunit.h"
+
+/**
+ * struct kunit_clk_hw_fixed_rate_params - Parameters to pass to __clk_hw_register_fixed_rate()
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
+struct kunit_clk_hw_fixed_rate_params {
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
+kunit_clk_hw_register_fixed_rate_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_clk_hw_fixed_rate_params *params = context;
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
+static void kunit_clk_hw_register_fixed_rate_free(struct kunit_resource *res)
+{
+	struct clk_hw *hw = res->data;
+
+	clk_hw_unregister_fixed_rate(hw);
+}
+
+/**
+ * kunit_clk_hw_register_fixed_rate() - Test managed __clk_hw_register_fixed_rate()
+ * @test: The test context
+ * @params: Arguments to __clk_hw_register_fixed_rate()
+ *
+ * Returns: registered fixed rate clk_hw or ERR_PTR on failure.
+ */
+static struct clk_hw *
+kunit_clk_hw_register_fixed_rate(struct kunit *test, struct kunit_clk_hw_fixed_rate_params *params)
+{
+	struct clk_hw *hw;
+
+	hw = kunit_alloc_resource(test,
+				  kunit_clk_hw_register_fixed_rate_init,
+				  kunit_clk_hw_register_fixed_rate_free,
+				  GFP_KERNEL, params);
+	if (!hw)
+		return ERR_PTR(-EINVAL);
+
+	return hw;
+}
+
+/**
+ * kunit_clk_hw_unregister_fixed_rate() - Test managed clk_hw_unregister_fixed_rate()
+ * @test: The test context
+ * @hw: fixed rate clk to unregister upon test completion
+ *
+ * Automatically unregister @hw when @test is complete via
+ * clk_hw_unregister_fixed_rate().
+ *
+ * Returns: 0 on success or negative errno on failure
+ */
+static int kunit_clk_hw_unregister_fixed_rate(struct kunit *test, struct clk_hw *hw)
+{
+	if (!kunit_alloc_resource(test, NULL,
+				  kunit_clk_hw_register_fixed_rate_free,
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
+	KUNIT_ASSERT_EQ(test, 0, kunit_clk_hw_unregister_fixed_rate(test, hw));
+
+	clk = kunit_clk_hw_get_clk_prepared_enabled(test, hw, __func__);
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
+	KUNIT_ASSERT_EQ(test, 0, kunit_clk_hw_unregister_fixed_rate(test, hw));
+
+	clk = kunit_clk_hw_get_clk(test, hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_EXPECT_EQ(test, fixed_accuracy, clk_get_accuracy(clk));
+}
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
+	struct kunit_clk_hw_fixed_rate_params parent_params = {
+		.name = parent_name,
+	};
+
+	parent_hw = kunit_clk_hw_register_fixed_rate(test, &parent_params);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+	KUNIT_ASSERT_STREQ(test, parent_name, clk_hw_get_name(parent_hw));
+
+	expected_parent = kunit_clk_hw_get_clk(test, parent_hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_parent);
+
+	hw = clk_hw_register_fixed_rate(NULL, "test-fixed-rate", parent_name, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_EQ(test, 0, kunit_clk_hw_unregister_fixed_rate(test, hw));
+
+	clk = kunit_clk_hw_get_clk(test, hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	actual_parent = clk_get_parent(clk);
+	KUNIT_EXPECT_TRUE(test, clk_is_match(expected_parent, actual_parent));
+}
+
+static struct kunit_case clk_fixed_rate_test_cases[] = {
+	KUNIT_CASE(clk_fixed_rate_rate_test),
+	KUNIT_CASE(clk_fixed_rate_accuracy_test),
+	KUNIT_CASE(clk_fixed_rate_parent_test),
+	{}
+};
+
+static struct kunit_suite clk_fixed_rate_suite = {
+	.name = "clk_fixed_rate",
+	.test_cases = clk_fixed_rate_test_cases,
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
+	clk = kunit_clk_get(test, dev, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_ASSERT_EQ(test, 0, kunit_clk_prepare_enable(test, clk));
+	KUNIT_EXPECT_EQ(test, 50000000, clk_get_rate(clk));
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
+	clk = kunit_clk_get(test, dev, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	KUNIT_EXPECT_EQ(test, 300, clk_get_accuracy(clk));
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
+		{ .compatible = "linux,clk-kunit-fixed-rate" },
+		{ }
+	};
+
+	if (!IS_ENABLED(CONFIG_OF_KUNIT))
+		kunit_skip(test, "requires CONFIG_OF_KUNIT");
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
+	return kunit_platform_driver_register(test, &ctx->pdrv);
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
+);
+MODULE_LICENSE("GPL");
diff --git a/drivers/of/kunit/clk.dtsi b/drivers/of/kunit/clk.dtsi
new file mode 100644
index 000000000000..e3466bcfeb4b
--- /dev/null
+++ b/drivers/of/kunit/clk.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	fixed_50MHz: clock-50MHz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-accuracy = <300>;
+	};
+
+	clock-consumer-fixed-50 {
+		compatible = "linux,clk-kunit-fixed-rate";
+		clocks = <&fixed_50MHz>;
+	};
+};
diff --git a/drivers/of/kunit/kunit.dtsi b/drivers/of/kunit/kunit.dtsi
index 82f6c3e2b8d5..bce5bd8b9505 100644
--- a/drivers/of/kunit/kunit.dtsi
+++ b/drivers/of/kunit/kunit.dtsi
@@ -6,3 +6,4 @@ / {
 };
 
 /* Include testcase dtsi files below */
+#include "clk.dtsi"
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

