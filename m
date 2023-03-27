Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627556CB19D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjC0WWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 18:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjC0WWH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 18:22:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40680359C;
        Mon, 27 Mar 2023 15:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB6A9B818BD;
        Mon, 27 Mar 2023 22:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0B5C433A7;
        Mon, 27 Mar 2023 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679955722;
        bh=LAa/aNT4zdgU+Ia0kIQS667n9LLbgnaZNMvjexZYCdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lv/nAADuwFCWDUvdu6xImj3qWCykJZR+j3kJMFgraTs7miL3pTD/q/3j+xLNADxI7
         LFG75Zgtpzm9KCzXoPIPS0ZI7XORyrA89hIDjFcRIQuKN7pt7Hn0yCvLTopvaPkccR
         xelrcSrvPn72Q1EclncmEXfrn9iJfujYtU2wlIswo7xhcAVTH8hFsv8IEp9i8l9+Fz
         jUOQr1RyRLRkO4dG8qj6jDaX2LenX/UlqKbi7G7kJpa05DXKbmNz5jXJ/dqZQVG+vZ
         ra9U8bzE2JS4s46XeIWBV0Ye5kUr0hxFWnSVMjlgz5RB7FYfUJzu7wMl1BvH/TiToV
         mIl7Y0pVRXlbA==
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
Subject: [PATCH v3 02/11] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
Date:   Mon, 27 Mar 2023 15:21:50 -0700
Message-Id: <20230327222159.3509818-3-sboyd@kernel.org>
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
do this is to add and remove nodes with a 'kunit-' prefix, almost
guaranteeing that the same node won't be present in the tree loaded at
boot.

Suggested-by: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/dev-tools/kunit/api/index.rst |  12 ++
 Documentation/dev-tools/kunit/api/of.rst    |  13 ++
 drivers/of/Makefile                         |   1 +
 drivers/of/of_kunit.c                       | 125 ++++++++++++++++++++
 include/kunit/of.h                          |  94 +++++++++++++++
 5 files changed, 245 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/of.rst
 create mode 100644 drivers/of/of_kunit.c
 create mode 100644 include/kunit/of.h

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 2d8f756aab56..5eb5f76e532c 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -9,11 +9,15 @@ API Reference
 	test
 	resource
 	functionredirection
+	of
 
 
 This page documents the KUnit kernel testing API. It is divided into the
 following sections:
 
+Core KUnit API
+==============
+
 Documentation/dev-tools/kunit/api/test.rst
 
  - Documents all of the standard testing API
@@ -25,3 +29,11 @@ Documentation/dev-tools/kunit/api/resource.rst
 Documentation/dev-tools/kunit/api/functionredirection.rst
 
  - Documents the KUnit Function Redirection API
+
+Driver KUnit API
+================
+
+Documentation/dev-tools/kunit/api/of.rst
+
+ - Documents the KUnit device tree (OF) API
+
diff --git a/Documentation/dev-tools/kunit/api/of.rst b/Documentation/dev-tools/kunit/api/of.rst
new file mode 100644
index 000000000000..8587591c3e78
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/of.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Device Tree (OF) API
+====================
+
+The KUnit device tree API is used to test device tree (of_*) dependent code.
+
+.. kernel-doc:: include/kunit/of.h
+   :internal:
+
+.. kernel-doc:: drivers/of/of_kunit.c
+   :export:
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index b11a8adcb985..c694f998b9f5 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -19,6 +19,7 @@ obj-y	+= kexec.o
 endif
 endif
 
+obj-$(CONFIG_KUNIT) += of_kunit.o
 obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/of_kunit.c b/drivers/of/of_kunit.c
new file mode 100644
index 000000000000..38be23ae1d88
--- /dev/null
+++ b/drivers/of/of_kunit.c
@@ -0,0 +1,125 @@
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
+ * Just like of_overlay_fdt_apply(), except the overlay is managed by the test
+ * case and is automatically removed with of_overlay_remove() after the test
+ * case concludes.
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
+ * This is mostly internal API. See of_overlay_apply_kunit() for the wrapper
+ * that makes this easier to use.
+ *
+ * Similar to of_overlay_fdt_apply(), except the overlay is managed by the test
+ * case and is automatically removed with of_overlay_remove() after the test
+ * case concludes.
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
+ * Just like of_node_put(), except the node is managed by the test case and is
+ * automatically put with of_node_put() after the test case concludes.
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
index 000000000000..d1f66806e16a
--- /dev/null
+++ b/include/kunit/of.h
@@ -0,0 +1,94 @@
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
+			 const u8 *overlay_end)
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
+ * @overlay_name\.dtbo.o in their Makefile along with their unit test and then
+ * load the overlay during their test. The @overlay_name matches the filename
+ * of the overlay without the dtbo filename extension. If CONFIG_OF_OVERLAY is
+ * not enabled, the @test will be skipped.
+ *
+ * In the Makefile
+ *
+ * .. code-block:: none
+ *
+ *	obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) += overlay_test.o kunit_overlay_test.dtbo.o
+ *
+ * In the test
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

