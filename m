Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA96BBC64
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjCOSjV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjCOSjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:39:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C608F9CBDE;
        Wed, 15 Mar 2023 11:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B0ECB81ED4;
        Wed, 15 Mar 2023 18:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C50C433A1;
        Wed, 15 Mar 2023 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905451;
        bh=3L2Xu/NW6pOmhQkv1wb9fwejKXY1sSIDFzQV7jc+TUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpIEH93oEIszxJ9wbrrZ4boseufgK8YMkgpBcN537Xp8Cgc34pbIlifa71PkBzW0C
         5W9tTxjbDDHVyJn24VWrDbwKG9+zlq6NlcwEU6QShqpavUGnk0J84gpaHumD2PhIFQ
         oPulV1Qeq7U9llZwPDoRtP5zASahewP8jfOwMZ7HNSSQ6hZGr9HrVtE+tCO1A9T7y1
         czH2+nPB0EKBTM/mB1RrrwZ6PTLbHaW+Qlqqcqv4sAw/vr1gsYZFVE5V/WjvULg3za
         akXVHnFHNN28xlvBNjBx9yrMjvi8cgX+06P6ZZxa2K1nDK/3CUJf5QrEUzbOzef5xc
         hQHfp2H8hfJQg==
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
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/11] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
Date:   Wed, 15 Mar 2023 11:37:19 -0700
Message-Id: <20230315183729.2376178-3-sboyd@kernel.org>
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

Add test managed wrappers for of_overlay_apply() that automatically
removes the overlay when the test is finished. This API is intended for
use by KUnit tests that test code which relies on 'struct device_node's
and of_*() APIs.

KUnit tests will call of_overlay_apply_kunit() to load an overlay that's
been built into the kernel image. When the test is complete, the overlay
will be removed.

This has a few benefits:

 1) It keeps the tests hermetic because the overlay is removed when the
    test is complete. Tests won't even be aware that an overlay was
    loaded in another test.

 2) The overlay code can live right next to the unit test that loads it.
    The overlay and the unit test can be compiled into one kernel module
    if desired.

 3) We can test different device tree configurations by loading
    different overlays. The overlays can be written for a specific test,
    and there can be many of them loaded per-test without needing to jam
    all possible combinations into one DTB.

 4) It also allows KUnit to test device tree dependent code on any
    architecture, not just UML. This allows KUnit tests to test
    architecture specific device tree code.

There are some potential pitfalls though. Test authors need to be
careful to not overwrite properties in the live tree. The easiest way to
do this is to add and remove nodes to the kunit_bus node.

Suggested-by: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/Makefile   |   2 +
 drivers/of/of_kunit.c | 123 ++++++++++++++++++++++++++++++++++++++++++
 include/kunit/of.h    |  90 +++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/of/of_kunit.c
 create mode 100644 include/kunit/of.h

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index cf6ee7ba6350..d1110358fd45 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -19,6 +19,8 @@ obj-y	+= kexec.o
 endif
 endif
 
+obj-$(CONFIG_KUNIT) += of_kunit.o
+
 DTC_FLAGS_kunit += -@
 obj-$(CONFIG_OF_KUNIT) += kunit.dtbo.o
 obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
diff --git a/drivers/of/of_kunit.c b/drivers/of/of_kunit.c
new file mode 100644
index 000000000000..59757145cbe6
--- /dev/null
+++ b/drivers/of/of_kunit.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test managed device tree APIs
+ */
+
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+#include <kunit/of.h>
+#include <kunit/test.h>
+#include <kunit/resource.h>
+
+struct of_overlay_fdt_apply_kunit_params {
+	void *overlay_fdt;
+	u32 overlay_fdt_size;
+	int *ovcs_id;
+};
+
+static int of_overlay_fdt_apply_kunit_init(struct kunit_resource *res, void *context)
+{
+	struct of_overlay_fdt_apply_kunit_params *params = context;
+	int ret;
+
+	ret = of_overlay_fdt_apply(params->overlay_fdt, params->overlay_fdt_size, params->ovcs_id);
+	if (ret)
+		return ret;
+
+	res->data = (void *)(uintptr_t)(*params->ovcs_id);
+
+	return 0;
+}
+
+static void of_overlay_fdt_apply_kunit_exit(struct kunit_resource *res)
+{
+	int ovcs_id = (uintptr_t)res->data;
+
+	of_overlay_remove(&ovcs_id);
+}
+
+/**
+ * of_overlay_fdt_apply_kunit() - Test managed of_overlay_fdt_apply()
+ * @test: test context
+ * @overlay_fdt: device tree overlay to apply
+ * @overlay_fdt_size: size in bytes of @overlay_fdt
+ * @ovcs_id: identifier of overlay, used to remove the overlay
+ *
+ * Just like `of_overlay_fdt_apply(...)`, except the overlay is managed by the
+ * test case and is automatically removed with `of_overlay_remove(...)` after
+ * the test case concludes.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
+			       u32 overlay_fdt_size, int *ovcs_id)
+{
+	struct of_overlay_fdt_apply_kunit_params params = {
+		.overlay_fdt = overlay_fdt,
+		.overlay_fdt_size = overlay_fdt_size,
+		.ovcs_id = ovcs_id,
+	};
+
+	if (!IS_ENABLED(CONFIG_OF_OVERLAY))
+		kunit_skip(test, "requires CONFIG_OF_OVERLAY");
+
+	if (!kunit_alloc_resource(test,
+				  of_overlay_fdt_apply_kunit_init,
+				  of_overlay_fdt_apply_kunit_exit,
+				  GFP_KERNEL, &params))
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_overlay_fdt_apply_kunit);
+
+/**
+ * __of_overlay_apply_kunit() - Test managed of_overlay_fdt_apply() variant
+ * @test: test context
+ * @overlay_begin: start address of overlay to apply
+ * @overlay_end: end address of overlay to apply
+ *
+ * Similar to `of_overlay_fdt_apply(...)`, except the overlay is managed by the
+ * test case and is automatically removed with `of_overlay_remove(...)` after
+ * the test case concludes.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int __of_overlay_apply_kunit(struct kunit *test, u8 *overlay_begin,
+			     const u8 *overlay_end)
+{
+	int unused;
+
+	return of_overlay_fdt_apply_kunit(test, overlay_begin,
+					  overlay_end - overlay_begin,
+					  &unused);
+}
+EXPORT_SYMBOL_GPL(__of_overlay_apply_kunit);
+
+static void of_node_put_kunit_exit(struct kunit_resource *res)
+{
+	struct device_node *node = res->data;
+
+	of_node_put(node);
+}
+
+/**
+ * of_node_put_kunit() - Test managed of_node_put()
+ * @test: test context
+ * @node: node to pass to `of_node_put()`
+ *
+ * Just like `of_node_put(...)`, except the node is managed by the test case
+ * and is automatically put with `of_node_put(...)` after the test case
+ * concludes.
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+void of_node_put_kunit(struct kunit *test, struct device_node *node)
+{
+	if (!kunit_alloc_resource(test, NULL, of_node_put_kunit_exit,
+				  GFP_KERNEL, node))
+		KUNIT_FAIL(test,
+			   "Can't allocate a kunit resource to put of_node\n");
+}
+EXPORT_SYMBOL_GPL(of_node_put_kunit);
diff --git a/include/kunit/of.h b/include/kunit/of.h
new file mode 100644
index 000000000000..00c43c6e3e67
--- /dev/null
+++ b/include/kunit/of.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KUNIT_OF_H
+#define _KUNIT_OF_H
+
+#include <kunit/test.h>
+
+struct device_node;
+
+#ifdef CONFIG_OF
+
+int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
+			       u32 overlay_fdt_size, int *ovcs_id);
+int __of_overlay_apply_kunit(struct kunit *test, u8 *overlay_begin,
+			     const u8 *overlay_end);
+
+void of_node_put_kunit(struct kunit *test, struct device_node *node);
+
+#else
+
+static inline int
+of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
+			   u32 overlay_fdt_size, int *ovcs_id)
+{
+	kunit_skip(test, "requires CONFIG_OF");
+	return -EINVAL;
+}
+
+static inline int
+__of_overlay_apply_kunit(struct kunit *test, u8 *overlay_begin,
+		         const u8 *overlay_end)
+{
+	kunit_skip(test, "requires CONFIG_OF");
+	return -EINVAL;
+}
+
+static inline
+void of_node_put_kunit(struct kunit *test, struct device_node *node)
+{
+	kunit_skip(test, "requires CONFIG_OF");
+}
+
+#endif /* !CONFIG_OF */
+
+/**
+ * of_overlay_apply_kunit() - Test managed of_overlay_fdt_apply() for built-in overlays
+ * @test: test context
+ * @overlay_name: name of overlay to apply
+ *
+ * This macro is used to apply a device tree overlay built with the
+ * cmd_dt_S_dtbo rule in scripts/Makefile.lib that has been compiled into the
+ * kernel image or KUnit test module. The overlay is automatically removed when
+ * the test is finished.
+ *
+ * Unit tests that need device tree nodes should compile an overlay file with
+ * `@overlay_name`.dtbo.o in their Makefile along with their unit test and then
+ * load the overlay during their test. The @overlay_name matches the filename
+ * of the overlay. If CONFIG_OF_OVERLAY is not enabled, the @test will be
+ * skipped.
+ *
+ * .. code-block:: none
+ *
+ *	obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) += overlay_test.o kunit_overlay_test.dtbo.o
+ *
+ * .. code-block:: c
+ *
+ *	static void of_overlay_kunit_of_overlay_apply(struct kunit *test)
+ *	{
+ *		struct device_node *np;
+ *
+ *		KUNIT_ASSERT_EQ(test, 0,
+ *				of_overlay_apply_kunit(test, kunit_overlay_test));
+ *
+ *		np = of_find_node_by_name(NULL, "test-kunit");
+ *		KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
+ *		of_node_put(np);
+ *	}
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+#define of_overlay_apply_kunit(test, overlay_name)		\
+({								\
+	extern uint8_t __dtbo_##overlay_name##_begin[];		\
+	extern uint8_t __dtbo_##overlay_name##_end[];		\
+								\
+	__of_overlay_apply_kunit((test),			\
+			__dtbo_##overlay_name##_begin,		\
+			__dtbo_##overlay_name##_end);		\
+})
+
+#endif
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

