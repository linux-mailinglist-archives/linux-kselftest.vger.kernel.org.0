Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184906A78F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCBBin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBBif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:38:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4506512BD7;
        Wed,  1 Mar 2023 17:38:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D6876153E;
        Thu,  2 Mar 2023 01:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625B0C433D2;
        Thu,  2 Mar 2023 01:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677721107;
        bh=fvPrCAyBkgnxgijN1lTuag/4in6rKiEGnEPO+gbwEs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8zopeNC1in3w5XGUJKY/LXKlzK5BRSdMPry4rWNbnjNE84GWR1xF+RINEeejLejd
         gKJpd8LdNs0TePE9fGcx70fY9XJ9a1rnTqoXELutE5T7dWUUu0TvXclZsGcJKLA9Ta
         TnaxwHXeO/1BPtBl6s09cfKsPnLL8/Qxj6LP+ZweOmzZPczLC4+iFKN4d6MB6t2ebM
         XlyovDX82U6lPSCyKUlkFXAD6OHJcEi7K4N64x81/QZvn8Jn0WIlq4kosMjwoNMe3M
         OV9ydVXq2h7mGhu/mlZ4GkHAYKEQSp5u/n9pe41izH+Ewj/iiX9TOcCMlYBIWrIxyC
         X6lYxry87mTrw==
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
Subject: [PATCH 4/8] clk: Add test managed clk provider/consumer APIs
Date:   Wed,  1 Mar 2023 17:38:17 -0800
Message-Id: <20230302013822.1808711-5-sboyd@kernel.org>
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

Unit tests are more ergonomic and simpler to understand if they don't
have to hoist a bunch of code into the test harness init and exit
functions. Add some test managed wrappers for the clk APIs so that clk
unit tests can write more code in the actual test and less code in the
harness.

Only add APIs that are used for now. More wrappers can be added in the
future as necessary.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Makefile    |   5 +
 drivers/clk/clk-kunit.c | 204 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-kunit.h |  28 ++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/clk/clk-kunit.c
 create mode 100644 drivers/clk/clk-kunit.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..7efce649b0d3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -17,6 +17,11 @@ ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
 endif
 
+# KUnit specific helpers
+ifeq ($(CONFIG_COMMON_CLK), y)
+obj-$(CONFIG_KUNIT)		+= clk-kunit.o
+endif
+
 # hardware specific clock types
 # please keep this section sorted lexicographically by file path name
 obj-$(CONFIG_COMMON_CLK_APPLE_NCO)  	+= clk-apple-nco.o
diff --git a/drivers/clk/clk-kunit.c b/drivers/clk/clk-kunit.c
new file mode 100644
index 000000000000..78d85b3a7a4a
--- /dev/null
+++ b/drivers/clk/clk-kunit.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for clk tests
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <kunit/resource.h>
+
+#include "clk-kunit.h"
+
+static void kunit_clk_disable_unprepare(struct kunit_resource *res)
+{
+	struct clk *clk = res->data;
+
+	clk_disable_unprepare(clk);
+}
+
+/**
+ * kunit_clk_prepare_enable() - Test managed clk_prepare_enable()
+ * @test: The test context
+ * @clk: clk to prepare and enable
+ *
+ * Returns: 0 on success, or negative errno on failure.
+ */
+int kunit_clk_prepare_enable(struct kunit *test, struct clk *clk)
+{
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_disable_unprepare,
+				  GFP_KERNEL, clk))
+		return -EINVAL;
+
+	return clk_prepare_enable(clk);
+}
+EXPORT_SYMBOL_GPL(kunit_clk_prepare_enable);
+
+static void kunit_clk_put(struct kunit_resource *res)
+{
+	struct clk *clk = res->data;
+
+	clk_put(clk);
+}
+
+/**
+ * kunit_clk_get() - Test managed clk_get()
+ * @test: The test context
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Returns: new clk consumer or ERR_PTR on failure
+ */
+struct clk *
+kunit_clk_get(struct kunit *test, struct device *dev, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_get(dev, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_clk_get);
+
+/**
+ * kunit_of_clk_get() - Test managed of_clk_get()
+ * @test: The test context
+ * @np: device_node for clock "consumer"
+ * @index: index in 'clocks' property of @np
+ *
+ * Returns: new clk consumer or ERR_PTR on failure
+ */
+struct clk *
+kunit_of_clk_get(struct kunit *test, struct device_node *np, int index)
+{
+	struct clk *clk;
+
+	clk = of_clk_get(np, index);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_of_clk_get);
+
+/**
+ * kunit_clk_hw_get_clk() - Test managed clk_hw_get_clk()
+ * @test: The test context
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Returns: new clk consumer or ERR_PTR on failure
+ */
+struct clk *
+kunit_clk_hw_get_clk(struct kunit *test, struct clk_hw *hw, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_hw_get_clk(hw, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_clk_hw_get_clk);
+
+/**
+ * kunit_clk_hw_get_clk_prepared_enabled() - Test managed clk_hw_get_clk() + clk_prepare_enable()
+ * @test: The test context
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Returns: new clk consumer that is prepared and enabled or ERR_PTR on failure
+ */
+struct clk *
+kunit_clk_hw_get_clk_prepared_enabled(struct kunit *test, struct clk_hw *hw,
+				      const char *con_id)
+{
+	int ret;
+	struct clk *clk;
+
+	clk = kunit_clk_hw_get_clk(test, hw, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = kunit_clk_prepare_enable(test, clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_clk_hw_get_clk_prepared_enabled);
+
+static void kunit_clk_hw_unregister(struct kunit_resource *res)
+{
+	struct clk_hw *hw = res->data;
+
+	clk_hw_unregister(hw);
+}
+
+/**
+ * kunit_clk_hw_register() - Test managed clk_hw_register()
+ * @test: The test context
+ * @dev: device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Returns: 0 on success or a negative errno value on failure
+ */
+int kunit_clk_hw_register(struct kunit *test, struct device *dev, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_hw_unregister, GFP_KERNEL, hw)) {
+		clk_hw_unregister(hw);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * kunit_of_clk_hw_register() - Test managed of_clk_hw_register()
+ * @test: The test context
+ * @node: device_node of device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Returns: 0 on success or a negative errno value on failure
+ */
+int kunit_of_clk_hw_register(struct kunit *test, struct device_node *node, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ret;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_hw_unregister, GFP_KERNEL, hw)) {
+		clk_hw_unregister(hw);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/clk-kunit.h b/drivers/clk/clk-kunit.h
new file mode 100644
index 000000000000..153597d69269
--- /dev/null
+++ b/drivers/clk/clk-kunit.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _CLK_KUNIT_H
+#define _CLK_KUNIT_H
+
+struct clk;
+struct clk_hw;
+struct device;
+struct device_node;
+struct kunit;
+
+struct clk *
+kunit_clk_get(struct kunit *test, struct device *dev, const char *con_id);
+struct clk *
+kunit_of_clk_get(struct kunit *test, struct device_node *np, int index);
+
+struct clk *
+kunit_clk_hw_get_clk(struct kunit *test, struct clk_hw *hw, const char *con_id);
+struct clk *
+kunit_clk_hw_get_clk_prepared_enabled(struct kunit *test, struct clk_hw *hw,
+				      const char *con_id);
+
+int kunit_clk_prepare_enable(struct kunit *test, struct clk *clk);
+
+int kunit_clk_hw_register(struct kunit *test, struct device *dev, struct clk_hw *hw);
+int kunit_of_clk_hw_register(struct kunit *test, struct device_node *node,
+			     struct clk_hw *hw);
+
+#endif
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

