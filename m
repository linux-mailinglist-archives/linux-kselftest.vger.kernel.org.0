Return-Path: <linux-kselftest+bounces-8648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD338AD91F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B281F235F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258815574E;
	Mon, 22 Apr 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjyGOJOO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A0155739;
	Mon, 22 Apr 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828256; cv=none; b=kZsV+uSNZBr5GiwZ08G+NMZJYaxMRMxZZ8OZMCHOh0cqMSO44PqaR5o920SAQkpTWjCVuzIaV8H0SpER6LaHp9jwvyz3dY7/z8cERCfbd8P5wF5qDoS8/+EGxvH4CHp5qXr58sPUFO1kf/eKw2uwXRrM0sm7u63hADEx8AaurfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828256; c=relaxed/simple;
	bh=KTLoXL5YdK5wzXmGEB8G4na/u53FVZnXRX3f9lor51A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljVDjJ1c2h/c5dVRo8abdPtV9fnow4GLvXW0vtKMT78ojvbprRGkQGqLdmfw3nQtmoimUWCIkWooz5Z1XuD/tkoB8Ktj+AeVRE83Wkv4lFuGilbbLSufShxrnDzLkvsc0nQkmgVge+ynNwLi0zxngIl6DA/TElM4lzbSCwBtg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjyGOJOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E2BC113CC;
	Mon, 22 Apr 2024 23:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828256;
	bh=KTLoXL5YdK5wzXmGEB8G4na/u53FVZnXRX3f9lor51A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjyGOJOOP4XhWotyK5uB8/gGIkGPwSMhr4CsGePVj/8MegvvP/nMYSs4Xbarv6zi7
	 ahal6TUd9ZS5wsdFJtoRT72rgluMebjPfHgIgGK+8EOTJSM9/DYBiF74b0vkz7EAg8
	 6e/cG5Ibpy56Zuz9acYYyEcRahxwG+D4oQL2OTLw3aTyhI/3cSgzsLWtvDXmtkEHZ4
	 fas2fJXTD0X2Dt/izpF6ZNpIUM1RIcdsN2XoF+zDas5/KywFj/ROW1Vgtcn+6jmABs
	 U1uekj5DvfwOgVkIrUhquEGykf6p/kWbDiOqY9Se843eLRwu5NEUsE0nY7nKKKmQUL
	 vAa2xjpeVJ06Q==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 08/10] clk: Add KUnit tests for clk fixed rate basic type
Date: Mon, 22 Apr 2024 16:24:01 -0700
Message-ID: <20240422232404.213174-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240422232404.213174-1-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that the fixed rate basic type clk works as intended.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/.kunitconfig                   |   2 +
 drivers/clk/Kconfig                        |   8 +
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-fixed-rate_test.c          | 377 +++++++++++++++++++++
 drivers/clk/clk-fixed-rate_test.h          |   8 +
 drivers/clk/kunit_clk_fixed_rate_test.dtso |  19 ++
 6 files changed, 415 insertions(+)
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.h
 create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index efa12ac2b3f2..54ece9207055 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -1,6 +1,8 @@
 CONFIG_KUNIT=y
+CONFIG_OF=y
 CONFIG_COMMON_CLK=y
 CONFIG_CLK_KUNIT_TEST=y
+CONFIG_CLK_FIXED_RATE_KUNIT_TEST=y
 CONFIG_CLK_GATE_KUNIT_TEST=y
 CONFIG_CLK_FD_KUNIT_TEST=y
 CONFIG_UML_PCI_OVER_VIRTIO=n
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..6e66d04dd11d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -510,6 +510,14 @@ config CLK_KUNIT_TEST
 	help
 	  Kunit tests for the common clock framework.
 
+config CLK_FIXED_RATE_KUNIT_TEST
+	tristate "Basic fixed rate clk type KUnit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select OF_OVERLAY if OF
+	help
+	  KUnit tests for the basic fixed rate clk type.
+
 config CLK_GATE_KUNIT_TEST
 	tristate "Basic gate type Kunit test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1fd74658a801..816abac45fbd 100644
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
index 000000000000..d1dd7c1568f2
--- /dev/null
+++ b/drivers/clk/clk-fixed-rate_test.c
@@ -0,0 +1,377 @@
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
+ * Return: Registered fixed rate clk_hw or ERR_PTR on failure
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
+ * Return: 0 on success or negative errno on failure
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
+	KUNIT_ASSERT_EQ(test, 0,
+			platform_driver_register_kunit(test, &ctx->pdrv));
+
+	return 0;
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


