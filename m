Return-Path: <linux-kselftest+bounces-13273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D99290E6
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 06:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29B71C21509
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA34317C;
	Sat,  6 Jul 2024 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dulk1Y1r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4BF42A9A;
	Sat,  6 Jul 2024 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241705; cv=none; b=Z1u58oD7mqdGR/rVtg9IS/qvhPTZXSsaLKy23J2swzGYRUpp7Uv1XM2fFf0g3KX8VQXTb5ZB6nXxFU+PnSzWjWhAJ8OMQp4cviu02FDCBjwCbMfC4Fr9JvkueQ3oZj1Tsud9UTcy6QKxI1Mtrd3vo2mPif+Asu9yZTvzAsj+BJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241705; c=relaxed/simple;
	bh=st2Ms1bN8sE6Z5ywlsCGwxuICLUADsDh8X61EAH47dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUsZKuX8r7/dG4CFDV8rVRpKHl9s7vJDGWTun3CzpqFXXvhcit17pSThsr/z7imBAsrGceG/xt/gtSEFP/YU6bllwry0orduNSs0RzgtAd82XN5bjdHXtlNT7YyHLX+J/a/fWEyzruLq3j1DCQh8P1aU23Y4aYLNyE4u3V6axPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dulk1Y1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C31C4AF1A;
	Sat,  6 Jul 2024 04:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720241705;
	bh=st2Ms1bN8sE6Z5ywlsCGwxuICLUADsDh8X61EAH47dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dulk1Y1rM8gDLSN7lBzhfMybwzWFpC6mIWLV48Qm2XH6eaClJo4y7XXXdp2SEIwQE
	 DOx4BE+4Cw9Jwrs7EMth8PlbqDOZXhTtvGWl6TAk7h5yjY3fqp/I3ClgL1M6ladCxd
	 +rRDZ/Y5fFLZWnHz5+h0bXTXDa46UBsJQjMnMahza+BMvbd+FRtv2JjNLatr+QeqrR
	 g0zIJdCMGyB38bRAXQXWoil1cAcJ0SdnNyNX4+kWL9OZ0BtIyl/L2S8Ai2oz+RXmYu
	 d+9Net3mDrKUDxUgXIf4KtX1dW6SKPapoLIO6wROffxZRvrKGjYyYMhs7NOeJ2SSud
	 TT0yvpySvaCyg==
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
Subject: [PATCH v6 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
Date: Fri,  5 Jul 2024 21:54:53 -0700
Message-ID: <20240706045454.215701-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045454.215701-1-sboyd@kernel.org>
References: <20240706045454.215701-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that clks registered with 'struct clk_parent_data' work as
intended and can find their parents.

Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Reviewed-by: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Kconfig                         |   2 +
 drivers/clk/Makefile                        |   3 +-
 drivers/clk/clk_parent_data_test.h          |  10 +
 drivers/clk/clk_test.c                      | 453 +++++++++++++++++++-
 drivers/clk/kunit_clk_parent_data_test.dtso |  28 ++
 5 files changed, 494 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/clk_parent_data_test.h
 create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d8482e015c49..0e4819c1cfd2 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -508,6 +508,8 @@ config CLK_KUNIT_TEST
 	tristate "Basic Clock Framework Kunit Tests" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
+	select OF_OVERLAY if OF
+	select DTC
 	help
 	  Kunit tests for the common clock framework.
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7b57e3d22cee..ed4e1a0e6943 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -2,7 +2,8 @@
 # common clock types
 obj-$(CONFIG_HAVE_CLK)		+= clk-devres.o clk-bulk.o clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o
-obj-$(CONFIG_CLK_KUNIT_TEST)	+= clk_test.o
+obj-$(CONFIG_CLK_KUNIT_TEST)	+= clk_test.o \
+				   kunit_clk_parent_data_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
diff --git a/drivers/clk/clk_parent_data_test.h b/drivers/clk/clk_parent_data_test.h
new file mode 100644
index 000000000000..eedd53ae910d
--- /dev/null
+++ b/drivers/clk/clk_parent_data_test.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _CLK_PARENT_DATA_TEST_H
+#define _CLK_PARENT_DATA_TEST_H
+
+#define CLK_PARENT_DATA_1MHZ_NAME	"1mhz_fixed_legacy"
+#define CLK_PARENT_DATA_PARENT1		"parent_fwname"
+#define CLK_PARENT_DATA_PARENT2		"50"
+#define CLK_PARENT_DATA_50MHZ_NAME	"50_clk"
+
+#endif
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 39e2b5ff4f51..c2127f46fb93 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -4,12 +4,19 @@
  */
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 /* Needed for clk_hw_get_clk() */
 #include "clk.h"
 
+#include <kunit/clk.h>
+#include <kunit/of.h>
+#include <kunit/platform_device.h>
 #include <kunit/test.h>
 
+#include "clk_parent_data_test.h"
+
 static const struct clk_ops empty_clk_ops = { };
 
 #define DUMMY_CLOCK_INIT_RATE	(42 * 1000 * 1000)
@@ -2659,6 +2666,448 @@ static struct kunit_suite clk_mux_no_reparent_test_suite = {
 	.test_cases = clk_mux_no_reparent_test_cases,
 };
 
+struct clk_register_clk_parent_data_test_case {
+	const char *desc;
+	struct clk_parent_data pdata;
+};
+
+static void
+clk_register_clk_parent_data_test_case_to_desc(
+		const struct clk_register_clk_parent_data_test_case *t, char *desc)
+{
+	strcpy(desc, t->desc);
+}
+
+static const struct clk_register_clk_parent_data_test_case
+clk_register_clk_parent_data_of_cases[] = {
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::index.
+		 */
+		.desc = "clk_parent_data_of_index_test",
+		.pdata.index = 0,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::fwname.
+		 */
+		.desc = "clk_parent_data_of_fwname_test",
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT1,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::name.
+		 */
+		.desc = "clk_parent_data_of_name_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+		.pdata.name = CLK_PARENT_DATA_1MHZ_NAME,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct
+		 * clk_parent_data::{fw_name,name}.
+		 */
+		.desc = "clk_parent_data_of_fwname_name_test",
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT1,
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::{index,name}.
+		 * Index takes priority.
+		 */
+		.desc = "clk_parent_data_of_index_name_priority_test",
+		.pdata.index = 0,
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct
+		 * clk_parent_data::{index,fwname,name}. The fw_name takes
+		 * priority over index and name.
+		 */
+		.desc = "clk_parent_data_of_index_fwname_name_priority_test",
+		.pdata.index = 1,
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT1,
+		.pdata.name = "not_matching",
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_register_clk_parent_data_of_test, clk_register_clk_parent_data_of_cases,
+		  clk_register_clk_parent_data_test_case_to_desc)
+
+/**
+ * struct clk_register_clk_parent_data_of_ctx - Context for clk_parent_data OF tests
+ * @np: device node of clk under test
+ * @hw: clk_hw for clk under test
+ */
+struct clk_register_clk_parent_data_of_ctx {
+	struct device_node *np;
+	struct clk_hw hw;
+};
+
+static int clk_register_clk_parent_data_of_test_init(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_of_ctx *ctx;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_clk_parent_data_test));
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->np = of_find_compatible_node(NULL, NULL, "test,clk-parent-data");
+	if (!ctx->np)
+		return -ENODEV;
+
+	of_node_put_kunit(test, ctx->np);
+
+	return 0;
+}
+
+/*
+ * Test that a clk registered with a struct device_node can find a parent based on
+ * struct clk_parent_data when the hw member isn't set.
+ */
+static void clk_register_clk_parent_data_of_test(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_of_ctx *ctx = test->priv;
+	struct clk_hw *parent_hw;
+	const struct clk_register_clk_parent_data_test_case *test_param;
+	struct clk_init_data init = { };
+	struct clk *expected_parent, *actual_parent;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->np);
+
+	expected_parent = of_clk_get_kunit(test, ctx->np, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_parent);
+
+	test_param = test->param_value;
+	init.parent_data = &test_param->pdata;
+	init.num_parents = 1;
+	init.name = "parent_data_of_test_clk";
+	init.ops = &clk_dummy_single_parent_ops;
+	ctx->hw.init = &init;
+	KUNIT_ASSERT_EQ(test, 0, of_clk_hw_register_kunit(test, ctx->np, &ctx->hw));
+
+	parent_hw = clk_hw_get_parent(&ctx->hw);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+
+	actual_parent = clk_hw_get_clk_kunit(test, parent_hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, actual_parent);
+
+	KUNIT_EXPECT_TRUE(test, clk_is_match(expected_parent, actual_parent));
+}
+
+static struct kunit_case clk_register_clk_parent_data_of_test_cases[] = {
+	KUNIT_CASE_PARAM(clk_register_clk_parent_data_of_test,
+			 clk_register_clk_parent_data_of_test_gen_params),
+	{}
+};
+
+/*
+ * Test suite for registering clks with struct clk_parent_data and a struct
+ * device_node.
+ */
+static struct kunit_suite clk_register_clk_parent_data_of_suite = {
+	.name = "clk_register_clk_parent_data_of",
+	.init = clk_register_clk_parent_data_of_test_init,
+	.test_cases = clk_register_clk_parent_data_of_test_cases,
+};
+
+/**
+ * struct clk_register_clk_parent_data_device_ctx - Context for clk_parent_data device tests
+ * @dev: device of clk under test
+ * @hw: clk_hw for clk under test
+ * @pdrv: driver to attach to find @dev
+ */
+struct clk_register_clk_parent_data_device_ctx {
+	struct device *dev;
+	struct clk_hw hw;
+	struct platform_driver pdrv;
+};
+
+static inline struct clk_register_clk_parent_data_device_ctx *
+clk_register_clk_parent_data_driver_to_test_context(struct platform_device *pdev)
+{
+	return container_of(to_platform_driver(pdev->dev.driver),
+			    struct clk_register_clk_parent_data_device_ctx, pdrv);
+}
+
+static int clk_register_clk_parent_data_device_probe(struct platform_device *pdev)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx;
+
+	ctx = clk_register_clk_parent_data_driver_to_test_context(pdev);
+	ctx->dev = &pdev->dev;
+
+	return 0;
+}
+
+static void clk_register_clk_parent_data_device_driver(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx = test->priv;
+	static const struct of_device_id match_table[] = {
+		{ .compatible = "test,clk-parent-data" },
+		{ }
+	};
+
+	ctx->pdrv.probe = clk_register_clk_parent_data_device_probe;
+	ctx->pdrv.driver.of_match_table = match_table;
+	ctx->pdrv.driver.name = __func__;
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
+}
+
+static const struct clk_register_clk_parent_data_test_case
+clk_register_clk_parent_data_device_cases[] = {
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::index.
+		 */
+		.desc = "clk_parent_data_device_index_test",
+		.pdata.index = 1,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::fwname.
+		 */
+		.desc = "clk_parent_data_device_fwname_test",
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT2,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::name.
+		 */
+		.desc = "clk_parent_data_device_name_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+		.pdata.name = CLK_PARENT_DATA_50MHZ_NAME,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::{fw_name,name}.
+		 */
+		.desc = "clk_parent_data_device_fwname_name_test",
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT2,
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::{index,name}. Index
+		 * takes priority.
+		 */
+		.desc = "clk_parent_data_device_index_name_priority_test",
+		.pdata.index = 1,
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::{index,fwname,name}.
+		 * The fw_name takes priority over index and name.
+		 */
+		.desc = "clk_parent_data_device_index_fwname_name_priority_test",
+		.pdata.index = 0,
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT2,
+		.pdata.name = "not_matching",
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_register_clk_parent_data_device_test,
+		  clk_register_clk_parent_data_device_cases,
+		  clk_register_clk_parent_data_test_case_to_desc)
+
+/*
+ * Test that a clk registered with a struct device can find a parent based on
+ * struct clk_parent_data when the hw member isn't set.
+ */
+static void clk_register_clk_parent_data_device_test(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx;
+	const struct clk_register_clk_parent_data_test_case *test_param;
+	struct clk_hw *parent_hw;
+	struct clk_init_data init = { };
+	struct clk *expected_parent, *actual_parent;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	test->priv = ctx;
+
+	clk_register_clk_parent_data_device_driver(test);
+
+	expected_parent = clk_get_kunit(test, ctx->dev, "50");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_parent);
+
+	test_param = test->param_value;
+	init.parent_data = &test_param->pdata;
+	init.num_parents = 1;
+	init.name = "parent_data_device_test_clk";
+	init.ops = &clk_dummy_single_parent_ops;
+	ctx->hw.init = &init;
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_register_kunit(test, ctx->dev, &ctx->hw));
+
+	parent_hw = clk_hw_get_parent(&ctx->hw);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+
+	actual_parent = clk_hw_get_clk_kunit(test, parent_hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, actual_parent);
+
+	KUNIT_EXPECT_TRUE(test, clk_is_match(expected_parent, actual_parent));
+}
+
+static const struct clk_register_clk_parent_data_test_case
+clk_register_clk_parent_data_device_hw_cases[] = {
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw.
+		 */
+		.desc = "clk_parent_data_device_hw_index_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when
+		 * struct clk_parent_data::fw_name is set.
+		 */
+		.desc = "clk_parent_data_device_hw_fwname_test",
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT2,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when struct
+		 * clk_parent_data::name is set.
+		 */
+		.desc = "clk_parent_data_device_hw_name_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+		.pdata.name = CLK_PARENT_DATA_50MHZ_NAME,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when struct
+		 * clk_parent_data::{fw_name,name} are set.
+		 */
+		.desc = "clk_parent_data_device_hw_fwname_name_test",
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT2,
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when struct
+		 * clk_parent_data::index is set. The hw pointer takes
+		 * priority.
+		 */
+		.desc = "clk_parent_data_device_hw_index_priority_test",
+		.pdata.index = 0,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when
+		 * struct clk_parent_data::{index,fwname,name} are set.
+		 * The hw pointer takes priority over everything else.
+		 */
+		.desc = "clk_parent_data_device_hw_index_fwname_name_priority_test",
+		.pdata.index = 0,
+		.pdata.fw_name = CLK_PARENT_DATA_PARENT2,
+		.pdata.name = "not_matching",
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_register_clk_parent_data_device_hw_test,
+		  clk_register_clk_parent_data_device_hw_cases,
+		  clk_register_clk_parent_data_test_case_to_desc)
+
+/*
+ * Test that a clk registered with a struct device can find a
+ * parent based on struct clk_parent_data::hw.
+ */
+static void clk_register_clk_parent_data_device_hw_test(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx;
+	const struct clk_register_clk_parent_data_test_case *test_param;
+	struct clk_dummy_context *parent;
+	struct clk_hw *parent_hw;
+	struct clk_parent_data pdata = { };
+	struct clk_init_data init = { };
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	test->priv = ctx;
+
+	clk_register_clk_parent_data_device_driver(test);
+
+	parent = kunit_kzalloc(test, sizeof(*parent), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	parent_hw = &parent->hw;
+	parent_hw->init = CLK_HW_INIT_NO_PARENT("parent-clk",
+						&clk_dummy_rate_ops, 0);
+
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_register_kunit(test, ctx->dev, parent_hw));
+
+	test_param = test->param_value;
+	memcpy(&pdata, &test_param->pdata, sizeof(pdata));
+	pdata.hw = parent_hw;
+	init.parent_data = &pdata;
+	init.num_parents = 1;
+	init.ops = &clk_dummy_single_parent_ops;
+	init.name = "parent_data_device_hw_test_clk";
+	ctx->hw.init = &init;
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_register_kunit(test, ctx->dev, &ctx->hw));
+
+	KUNIT_EXPECT_PTR_EQ(test, parent_hw, clk_hw_get_parent(&ctx->hw));
+}
+
+static struct kunit_case clk_register_clk_parent_data_device_test_cases[] = {
+	KUNIT_CASE_PARAM(clk_register_clk_parent_data_device_test,
+			 clk_register_clk_parent_data_device_test_gen_params),
+	KUNIT_CASE_PARAM(clk_register_clk_parent_data_device_hw_test,
+			 clk_register_clk_parent_data_device_hw_test_gen_params),
+	{}
+};
+
+static int clk_register_clk_parent_data_device_init(struct kunit *test)
+{
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_clk_parent_data_test));
+
+	return 0;
+}
+
+/*
+ * Test suite for registering clks with struct clk_parent_data and a struct
+ * device.
+ */
+static struct kunit_suite clk_register_clk_parent_data_device_suite = {
+	.name = "clk_register_clk_parent_data_device",
+	.init = clk_register_clk_parent_data_device_init,
+	.test_cases = clk_register_clk_parent_data_device_test_cases,
+};
+
 kunit_test_suites(
 	&clk_leaf_mux_set_rate_parent_test_suite,
 	&clk_test_suite,
@@ -2671,7 +3120,9 @@ kunit_test_suites(
 	&clk_range_test_suite,
 	&clk_range_maximize_test_suite,
 	&clk_range_minimize_test_suite,
+	&clk_register_clk_parent_data_of_suite,
+	&clk_register_clk_parent_data_device_suite,
 	&clk_single_parent_mux_test_suite,
-	&clk_uncached_test_suite
+	&clk_uncached_test_suite,
 );
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/kunit_clk_parent_data_test.dtso b/drivers/clk/kunit_clk_parent_data_test.dtso
new file mode 100644
index 000000000000..7d3ed9a5a2e8
--- /dev/null
+++ b/drivers/clk/kunit_clk_parent_data_test.dtso
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+#include "clk_parent_data_test.h"
+
+&{/} {
+	fixed_50: kunit-clock-50MHz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = CLK_PARENT_DATA_50MHZ_NAME;
+	};
+
+	fixed_parent: kunit-clock-1MHz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000>;
+		clock-output-names = CLK_PARENT_DATA_1MHZ_NAME;
+	};
+
+	kunit-clock-controller {
+		compatible = "test,clk-parent-data";
+		clocks = <&fixed_parent>, <&fixed_50>;
+		clock-names = CLK_PARENT_DATA_PARENT1, CLK_PARENT_DATA_PARENT2;
+		#clock-cells = <1>;
+	};
+};
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


