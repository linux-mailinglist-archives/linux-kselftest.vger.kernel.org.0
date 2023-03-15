Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438BC6BBC6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjCOSjg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjCOSjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2928B042;
        Wed, 15 Mar 2023 11:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C851961E40;
        Wed, 15 Mar 2023 18:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92836C4339B;
        Wed, 15 Mar 2023 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905451;
        bh=CM+hrHoCTheo2ybjpPQ11qSuAaBagFvVaZ4IR4lYyjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3K+uxHilA6+NQdCXzUgqirYlWRRKZR6VA3KTORBnoW3bV05VlwC3Yf1j1PGE/Qf2
         fyBIHjrOT4DLNE7heK/C68SIpnp54eXXU9xbi0XJgx9JzTMS0C5qZLIo1Uyp0C9Lj9
         njSgffVA7wMw5WKSBmxTgdzV+ijRno3aFNph/0mel1fdyju5F65XJefdskzoFedqJJ
         Rq+TTO0G9EaM+tMqfNrPd0v3sMbRs8xwbQQLISnuvabDEKEt053w+eL/YajUBDF7Uc
         a1Q3z2ZA7W4i0rDb6FswjgPWJMtRZhRC3gofSMUtJejnHn/Iz77znUAxV3oAMSFfjM
         Dq5xHwhOWHhBQ==
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
Subject: [PATCH v2 01/11] of: Load KUnit DTB from of_core_init()
Date:   Wed, 15 Mar 2023 11:37:18 -0700
Message-Id: <20230315183729.2376178-2-sboyd@kernel.org>
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

Load a small DTB for KUnit from of_core_init() as long as CONFIG_OF=y
and CONFIG_KUNIT=y/m. This allows KUnit tests to load overlays into the
running system. It also allows KUnit tests to run on any architecture
that supports it so that devicetree can be used while unit testing
architecture specific code.

Overlays need a target node to apply their overlays to, so make a fake
bus called 'kunit-bus' in the root node to allow this. Make the node a
simple-bus so that platform devices are automatically created for nodes
added as children of this node. Unit test overlays can target this node
via the label 'kunit_bus'.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/.kunitconfig |   3 +
 drivers/of/Kconfig      |  13 +++
 drivers/of/Makefile     |   4 +
 drivers/of/base.c       | 182 ++++++++++++++++++++++++++++++++++++++++
 drivers/of/kunit.dtso   |  10 +++
 drivers/of/of_private.h |   6 ++
 drivers/of/of_test.c    |  43 ++++++++++
 drivers/of/unittest.c   | 101 +---------------------
 8 files changed, 262 insertions(+), 100 deletions(-)
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/kunit.dtso
 create mode 100644 drivers/of/of_test.c

diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
new file mode 100644
index 000000000000..5a8fee11978c
--- /dev/null
+++ b/drivers/of/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_OF=y
+CONFIG_OF_KUNIT_TEST=y
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 644386833a7b..f6739b9560c5 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -37,6 +37,19 @@ config OF_UNITTEST
 
 	  If unsure, say N here. This option is not safe to enable.
 
+config OF_KUNIT
+	def_bool KUNIT
+	select OF_RESOLVE
+
+config OF_KUNIT_TEST
+	tristate "Devicetree KUnit DTB Test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds KUnit unit tests for device tree infrastructure.
+
+	  If unsure, say N here, but this option is safe to enable.
+
 config OF_ALL_DTBS
 	bool "Build all Device Tree Blobs"
 	depends on COMPILE_TEST
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..cf6ee7ba6350 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -19,4 +19,8 @@ obj-y	+= kexec.o
 endif
 endif
 
+DTC_FLAGS_kunit += -@
+obj-$(CONFIG_OF_KUNIT) += kunit.dtbo.o
+obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
+
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/base.c b/drivers/of/base.c
index ac6fde53342f..090c5d7925e4 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -16,13 +16,16 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/align.h>
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_fdt.h>
 #include <linux/of_graph.h>
+#include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -163,10 +166,90 @@ void __of_phandle_cache_inv_entry(phandle handle)
 		phandle_cache[handle_hash] = NULL;
 }
 
+#ifdef CONFIG_OF_KUNIT
+static int __init of_kunit_add_data(void)
+{
+	void *kunit_fdt;
+	void *kunit_fdt_align;
+	struct device_node *kunit_node = NULL, *np;
+	/*
+	 * __dtbo_kunit_begin[] and __dtbo_kunit_end[] are magically
+	 * created by cmd_dt_S_dtbo in scripts/Makefile.lib
+	 */
+	extern uint8_t __dtbo_kunit_begin[];
+	extern uint8_t __dtbo_kunit_end[];
+	const int size = __dtbo_kunit_end - __dtbo_kunit_begin;
+	int rc;
+	void *ret;
+
+	if (!size) {
+		pr_warn("kunit.dtbo is empty\n");
+		return -ENODATA;
+	}
+
+	kunit_fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
+	if (!kunit_fdt)
+		return -ENOMEM;
+
+	kunit_fdt_align = PTR_ALIGN(kunit_fdt, FDT_ALIGN_SIZE);
+	memcpy(kunit_fdt_align, __dtbo_kunit_begin, size);
+
+	ret = of_fdt_unflatten_tree(kunit_fdt_align, NULL, &kunit_node);
+	if (!ret) {
+		pr_warn("unflatten KUnit tree failed\n");
+		kfree(kunit_fdt);
+		return -ENODATA;
+	}
+	if (!kunit_node) {
+		pr_warn("KUnit tree is empty\n");
+		kfree(kunit_fdt);
+		return -ENODATA;
+	}
+
+	of_overlay_mutex_lock();
+	rc = of_resolve_phandles(kunit_node);
+	if (rc) {
+		pr_err("Failed to resolve KUnit phandles (rc=%i)\n", rc);
+		of_overlay_mutex_unlock();
+		return -EINVAL;
+	}
+
+	if (!of_root) {
+		of_root = kunit_node;
+		of_chosen = of_find_node_by_path("/chosen");
+	} else {
+		/* attach the sub-tree to live tree */
+		np = kunit_node->child;
+		while (np) {
+			struct device_node *next = np->sibling;
+
+			np->parent = of_root;
+			of_test_attach_node_and_children(np);
+			np = next;
+		}
+	}
+
+	if (!of_aliases)
+		of_aliases = of_find_node_by_path("/aliases");
+
+	of_overlay_mutex_unlock();
+
+	return 0;
+}
+#else
+static inline int __init of_kunit_add_data(void) { return 0; }
+#endif
+
 void __init of_core_init(void)
 {
 	struct device_node *np;
+	int ret;
 
+	ret = of_kunit_add_data();
+	if (ret) {
+		pr_err("failed to add kunit test data\n");
+		return;
+	}
 
 	/* Create the kset, and register existing nodes */
 	mutex_lock(&of_mutex);
@@ -1879,6 +1962,105 @@ int of_update_property(struct device_node *np, struct property *newprop)
 	return rc;
 }
 
+#if defined(CONFIG_OF_UNITTEST) || defined (CONFIG_KUNIT)
+/**
+ * update_node_properties - adds the properties of np into dup node (present in
+ * live tree) and updates parent of children of np to dup.
+ *
+ * @np: node whose properties are being added to the live tree
+ * @dup: node present in live tree to be updated
+ */
+static void __init update_node_properties(struct device_node *np,
+					struct device_node *dup)
+{
+	struct property *prop;
+	struct property *save_next;
+	struct device_node *child;
+	int ret;
+
+	for_each_child_of_node(np, child)
+		child->parent = dup;
+
+	/*
+	 * "unittest internal error: unable to add testdata property"
+	 *
+	 *    If this message reports a property in node '/__symbols__' then
+	 *    the respective unittest overlay contains a label that has the
+	 *    same name as a label in the live devicetree.  The label will
+	 *    be in the live devicetree only if the devicetree source was
+	 *    compiled with the '-@' option.  If you encounter this error,
+	 *    please consider renaming __all__ of the labels in the unittest
+	 *    overlay dts files with an odd prefix that is unlikely to be
+	 *    used in a real devicetree.
+	 */
+
+	/*
+	 * open code for_each_property_of_node() because of_add_property()
+	 * sets prop->next to NULL
+	 */
+	for (prop = np->properties; prop != NULL; prop = save_next) {
+		save_next = prop->next;
+		ret = of_add_property(dup, prop);
+		if (ret) {
+			if (ret == -EEXIST && !strcmp(prop->name, "name"))
+				continue;
+			pr_err("unittest internal error: unable to add testdata property %pOF/%s",
+			       np, prop->name);
+		}
+	}
+}
+
+/**
+ * of_test_attach_node_and_children - attaches nodes and its children to live tree.
+ * @np:	Node to attach to live tree
+ *
+ * CAUTION: misleading function name - if node @np already exists in
+ * the live tree then children of @np are *not* attached to the live
+ * tree.  This works for the current test devicetree nodes because such
+ * nodes do not have child nodes.
+ */
+void __init of_test_attach_node_and_children(struct device_node *np)
+{
+	struct device_node *next, *dup, *child;
+	unsigned long flags;
+	const char *full_name;
+
+	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+
+	if (!strcmp(full_name, "/__local_fixups__") ||
+	    !strcmp(full_name, "/__fixups__")) {
+		kfree(full_name);
+		return;
+	}
+
+	dup = of_find_node_by_path(full_name);
+	kfree(full_name);
+	if (dup) {
+		update_node_properties(np, dup);
+		return;
+	}
+
+	child = np->child;
+	np->child = NULL;
+
+	mutex_lock(&of_mutex);
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	np->sibling = np->parent->child;
+	np->parent->child = np;
+	of_node_clear_flag(np, OF_DETACHED);
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_attach_node_sysfs(np);
+	mutex_unlock(&of_mutex);
+
+	while (child) {
+		next = child->sibling;
+		of_test_attach_node_and_children(child);
+		child = next;
+	}
+}
+#endif
+
 static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 			 int id, const char *stem, int stem_len)
 {
diff --git a/drivers/of/kunit.dtso b/drivers/of/kunit.dtso
new file mode 100644
index 000000000000..d512057df98d
--- /dev/null
+++ b/drivers/of/kunit.dtso
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	/* Container node where KUnit tests can load overlays */
+	kunit_bus: kunit-bus {
+		compatible = "simple-bus";
+	};
+};
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index fb6792d381a6..2151a28ca234 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -96,6 +96,12 @@ static inline void of_overlay_mutex_lock(void) {};
 static inline void of_overlay_mutex_unlock(void) {};
 #endif
 
+#if defined(CONFIG_OF_UNITTEST) || defined (CONFIG_KUNIT)
+void __init of_test_attach_node_and_children(struct device_node *np);
+#else
+static inline void __init of_test_attach_node_and_children(struct device_node *np) {}
+#endif
+
 #if defined(CONFIG_OF_UNITTEST) && defined(CONFIG_OF_OVERLAY)
 extern void __init unittest_unflatten_overlay_base(void);
 #else
diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
new file mode 100644
index 000000000000..a4d70ac344ad
--- /dev/null
+++ b/drivers/of/of_test.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for OF APIs
+ */
+#include <linux/kconfig.h>
+#include <linux/of.h>
+
+#include <kunit/test.h>
+
+/*
+ * Test that the root node / exists.
+ */
+static void dtb_root_node_exists(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/"));
+}
+
+/*
+ * Test that the /__symbols__ node exists.
+ */
+static void dtb_symbols_node_exists(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_find_node_by_path("/__symbols__"));
+}
+
+static struct kunit_case dtb_test_cases[] = {
+	KUNIT_CASE(dtb_root_node_exists),
+	KUNIT_CASE(dtb_symbols_node_exists),
+	{}
+};
+
+/*
+ * Test suite to confirm a live DTB is loaded.
+ */
+static struct kunit_suite dtb_suite = {
+	.name = "dtb",
+	.test_cases = dtb_test_cases,
+};
+
+kunit_test_suites(
+	&dtb_suite,
+);
+MODULE_LICENSE("GPL");
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index b5a7a31d8bd2..99164305582e 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1321,105 +1321,6 @@ static void __init of_unittest_platform_populate(void)
 	of_node_put(np);
 }
 
-/**
- *	update_node_properties - adds the properties
- *	of np into dup node (present in live tree) and
- *	updates parent of children of np to dup.
- *
- *	@np:	node whose properties are being added to the live tree
- *	@dup:	node present in live tree to be updated
- */
-static void update_node_properties(struct device_node *np,
-					struct device_node *dup)
-{
-	struct property *prop;
-	struct property *save_next;
-	struct device_node *child;
-	int ret;
-
-	for_each_child_of_node(np, child)
-		child->parent = dup;
-
-	/*
-	 * "unittest internal error: unable to add testdata property"
-	 *
-	 *    If this message reports a property in node '/__symbols__' then
-	 *    the respective unittest overlay contains a label that has the
-	 *    same name as a label in the live devicetree.  The label will
-	 *    be in the live devicetree only if the devicetree source was
-	 *    compiled with the '-@' option.  If you encounter this error,
-	 *    please consider renaming __all__ of the labels in the unittest
-	 *    overlay dts files with an odd prefix that is unlikely to be
-	 *    used in a real devicetree.
-	 */
-
-	/*
-	 * open code for_each_property_of_node() because of_add_property()
-	 * sets prop->next to NULL
-	 */
-	for (prop = np->properties; prop != NULL; prop = save_next) {
-		save_next = prop->next;
-		ret = of_add_property(dup, prop);
-		if (ret) {
-			if (ret == -EEXIST && !strcmp(prop->name, "name"))
-				continue;
-			pr_err("unittest internal error: unable to add testdata property %pOF/%s",
-			       np, prop->name);
-		}
-	}
-}
-
-/**
- *	attach_node_and_children - attaches nodes
- *	and its children to live tree.
- *	CAUTION: misleading function name - if node @np already exists in
- *	the live tree then children of @np are *not* attached to the live
- *	tree.  This works for the current test devicetree nodes because such
- *	nodes do not have child nodes.
- *
- *	@np:	Node to attach to live tree
- */
-static void attach_node_and_children(struct device_node *np)
-{
-	struct device_node *next, *dup, *child;
-	unsigned long flags;
-	const char *full_name;
-
-	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
-
-	if (!strcmp(full_name, "/__local_fixups__") ||
-	    !strcmp(full_name, "/__fixups__")) {
-		kfree(full_name);
-		return;
-	}
-
-	dup = of_find_node_by_path(full_name);
-	kfree(full_name);
-	if (dup) {
-		update_node_properties(np, dup);
-		return;
-	}
-
-	child = np->child;
-	np->child = NULL;
-
-	mutex_lock(&of_mutex);
-	raw_spin_lock_irqsave(&devtree_lock, flags);
-	np->sibling = np->parent->child;
-	np->parent->child = np;
-	of_node_clear_flag(np, OF_DETACHED);
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	__of_attach_node_sysfs(np);
-	mutex_unlock(&of_mutex);
-
-	while (child) {
-		next = child->sibling;
-		attach_node_and_children(child);
-		child = next;
-	}
-}
-
 /**
  *	unittest_data_add - Reads, copies data from
  *	linked tree and attaches it to the live tree
@@ -1496,7 +1397,7 @@ static int __init unittest_data_add(void)
 
 		np->parent = of_root;
 		/* this will clear OF_DETACHED in np and children */
-		attach_node_and_children(np);
+		of_test_attach_node_and_children(np);
 		np = next;
 	}
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

