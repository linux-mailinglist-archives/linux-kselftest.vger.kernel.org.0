Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6C6BBC74
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCOSkK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjCOSjb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:39:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD9C4ECC3;
        Wed, 15 Mar 2023 11:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FC58B81F00;
        Wed, 15 Mar 2023 18:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDCCC433A0;
        Wed, 15 Mar 2023 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905455;
        bh=VeCTbFDgf433RPQn/Bgpt+Atf8zLoOGI2eNSf/kHlG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwmShr9iVq13xtC1ahqiWzjUyEjQtYJW+8yM7w6qfaVa6pAGLpcbyFBV4e6GXElOx
         6w5iVjugINaZ/5kPaatLIxFRr0sy+kMAVIlPvkOtj/wvvkkkJYoqNMW/1xwk6x7TNC
         +SaG+DODWAuD5Yjh5IE4RoeaT9m//ptdODL9ZK1ncHHKx9ONU9/CigQSAqy/v6j1Zk
         Pli4YG7srDGaRSfZeDwdsoaDBBoACheY3EgfSNA59p6ePboEh5ggcwuY3dpm5kO6Lf
         T8pWmNiy1XB09PjbhY/pzQwOqAfGG0e8Fum7kG+3GRSKn+fOfsta1BNv9VX/VewMh5
         WP/47avyQaHCA==
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
Subject: [PATCH v2 08/11] clk: Add test managed clk provider/consumer APIs
Date:   Wed, 15 Mar 2023 11:37:25 -0700
Message-Id: <20230315183729.2376178-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315183729.2376178-1-sboyd@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 drivers/clk/clk_kunit.c | 219 ++++++++++++++++++++++++++++++++++++++++
 include/kunit/clk.h     |  28 +++++
 3 files changed, 252 insertions(+)
 create mode 100644 drivers/clk/clk_kunit.c
 create mode 100644 include/kunit/clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..226b4b729703 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -17,6 +17,11 @@ ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
 endif
 
+# KUnit specific helpers
+ifeq ($(CONFIG_COMMON_CLK), y)
+obj-$(CONFIG_KUNIT)		+= clk_kunit.o
+endif
+
 # hardware specific clock types
 # please keep this section sorted lexicographically by file path name
 obj-$(CONFIG_COMMON_CLK_APPLE_NCO)  	+= clk-apple-nco.o
diff --git a/drivers/clk/clk_kunit.c b/drivers/clk/clk_kunit.c
new file mode 100644
index 000000000000..0d0232bf4d83
--- /dev/null
+++ b/drivers/clk/clk_kunit.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for clk providers and consumers
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <kunit/clk.h>
+#include <kunit/resource.h>
+
+static void clk_disable_unprepare_kunit(struct kunit_resource *res)
+{
+	struct clk *clk = res->data;
+
+	clk_disable_unprepare(clk);
+}
+
+/**
+ * clk_prepare_enable_kunit() - Test managed clk_prepare_enable()
+ * @test: The test context
+ * @clk: clk to prepare and enable
+ *
+ * Returns: 0 on success, or negative errno on failure.
+ */
+int clk_prepare_enable_kunit(struct kunit *test, struct clk *clk)
+{
+	if (!kunit_alloc_resource(test, NULL, clk_disable_unprepare_kunit,
+				  GFP_KERNEL, clk))
+		return -EINVAL;
+
+	return clk_prepare_enable(clk);
+}
+EXPORT_SYMBOL_GPL(clk_prepare_enable_kunit);
+
+static void clk_put_kunit(struct kunit_resource *res)
+{
+	struct clk *clk = res->data;
+
+	clk_put(clk);
+}
+
+static struct clk *__clk_get_kunit(struct kunit *test, struct clk *clk)
+{
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!kunit_alloc_resource(test, NULL, clk_put_kunit, GFP_KERNEL, clk)) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+
+/**
+ * clk_get_kunit() - Test managed clk_get()
+ * @test: The test context
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Just like `clk_get(...)`, except the clk is managed by the test case and is
+ * automatically put with `clk_put(...)` after the test case concludes.
+ *
+ * Returns: new clk consumer or ERR_PTR on failure.
+ */
+struct clk *
+clk_get_kunit(struct kunit *test, struct device *dev, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_get(dev, con_id);
+
+	return __clk_get_kunit(test, clk);
+}
+EXPORT_SYMBOL_GPL(clk_get_kunit);
+
+/**
+ * of_clk_get_kunit() - Test managed of_clk_get()
+ * @test: The test context
+ * @np: device_node for clock "consumer"
+ * @index: index in 'clocks' property of @np
+ *
+ * Just like `of_clk_get(...)`, except the clk is managed by the test case and
+ * is automatically put with `clk_put(...)` after the test case concludes.
+ *
+ * Returns: new clk consumer or ERR_PTR on failure.
+ */
+struct clk *
+of_clk_get_kunit(struct kunit *test, struct device_node *np, int index)
+{
+	struct clk *clk;
+
+	clk = of_clk_get(np, index);
+
+	return __clk_get_kunit(test, clk);
+}
+EXPORT_SYMBOL_GPL(of_clk_get_kunit);
+
+/**
+ * clk_hw_get_clk_kunit() - Test managed clk_hw_get_clk()
+ * @test: The test context
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Just like `clk_hw_get_clk(...)`, except the clk is managed by the test case
+ * and is automatically put with `clk_put(...)` after the test case concludes.
+ *
+ * Returns: new clk consumer or ERR_PTR on failure.
+ */
+struct clk *
+clk_hw_get_clk_kunit(struct kunit *test, struct clk_hw *hw, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_hw_get_clk(hw, con_id);
+
+	return __clk_get_kunit(test, clk);
+}
+EXPORT_SYMBOL_GPL(clk_hw_get_clk_kunit);
+
+/**
+ * clk_hw_get_clk_prepared_enabled_kunit() - Test managed clk_hw_get_clk() + clk_prepare_enable()
+ * @test: The test context
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Just like `clk_prepare_enable(clk_hw_get_clk(...))`, except the clk is
+ * managed by the test case and is automatically disabled and unprepared with
+ * `clk_disable_unprepare(...)` and put with `clk_put(...)` after the test case
+ * concludes.
+ *
+ * Returns: new clk consumer that is prepared and enabled or ERR_PTR on failure.
+ */
+struct clk *
+clk_hw_get_clk_prepared_enabled_kunit(struct kunit *test, struct clk_hw *hw,
+				      const char *con_id)
+{
+	int ret;
+	struct clk *clk;
+
+	clk = clk_hw_get_clk_kunit(test, hw, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = clk_prepare_enable_kunit(test, clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(clk_hw_get_clk_prepared_enabled_kunit);
+
+static void clk_hw_unregister_kunit(struct kunit_resource *res)
+{
+	struct clk_hw *hw = res->data;
+
+	clk_hw_unregister(hw);
+}
+
+static int __clk_hw_register_kunit(struct kunit *test, struct clk_hw *hw)
+{
+	if (!kunit_alloc_resource(test, NULL, clk_hw_unregister_kunit, GFP_KERNEL, hw)) {
+		clk_hw_unregister(hw);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * clk_hw_register_kunit() - Test managed clk_hw_register()
+ * @test: The test context
+ * @dev: device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Just like `clk_hw_register(...)`, except the clk registration is managed by
+ * the test case and is automatically unregistered after the test case
+ * concludes.
+ *
+ * Returns: 0 on success or a negative errno value on failure.
+ */
+int clk_hw_register_kunit(struct kunit *test, struct device *dev, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return __clk_hw_register_kunit(test, hw);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_kunit);
+
+/**
+ * of_clk_hw_register_kunit() - Test managed of_clk_hw_register()
+ * @test: The test context
+ * @node: device_node of device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Just like `of_clk_hw_register(...)`, except the clk registration is managed by
+ * the test case and is automatically unregistered after the test case
+ * concludes.
+ *
+ * Returns: 0 on success or a negative errno value on failure.
+ */
+int of_clk_hw_register_kunit(struct kunit *test, struct device_node *node, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ret;
+
+	return __clk_hw_register_kunit(test, hw);
+}
+EXPORT_SYMBOL_GPL(of_clk_hw_register_kunit);
diff --git a/include/kunit/clk.h b/include/kunit/clk.h
new file mode 100644
index 000000000000..73bc99cefe7b
--- /dev/null
+++ b/include/kunit/clk.h
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
+clk_get_kunit(struct kunit *test, struct device *dev, const char *con_id);
+struct clk *
+of_clk_get_kunit(struct kunit *test, struct device_node *np, int index);
+
+struct clk *
+clk_hw_get_clk_kunit(struct kunit *test, struct clk_hw *hw, const char *con_id);
+struct clk *
+clk_hw_get_clk_prepared_enabled_kunit(struct kunit *test, struct clk_hw *hw,
+				      const char *con_id);
+
+int clk_prepare_enable_kunit(struct kunit *test, struct clk *clk);
+
+int clk_hw_register_kunit(struct kunit *test, struct device *dev, struct clk_hw *hw);
+int of_clk_hw_register_kunit(struct kunit *test, struct device_node *node,
+			     struct clk_hw *hw);
+
+#endif
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

