Return-Path: <linux-kselftest+bounces-4037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7EF847A12
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDE71F268E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8166D81734;
	Fri,  2 Feb 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD5VFquk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514BA8172B;
	Fri,  2 Feb 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903953; cv=none; b=rM2W+fA71SMaSpNQ9i6EFOmd8KRrX1UrSNgBjw7u/yo1qbmgrfEGSvODvA9i017yGKbZqzw2amRuGzRl40Y3l2QfQpoDSkR+zT8TMLJgmsMB/4EUx1oTLneX3r/OTBowRkPDBTXaAzzWMKuf9tTvDCk/ILiRLJNdjDp6nyF7X7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903953; c=relaxed/simple;
	bh=t4kGvcZAyPHW38f5oPy9NpKLy61UGodk/h/wXqd7kZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epMgpyn/SwIzI9G0sctzNT0dPVmgTofS+/TcjistdbiLTc2R/IBoRr9HsWy3OXyBGVFFVIbDHWMeZD05E3IhUUhZR2IOoh7/8YYr6FHn7VTg2GRJV0+Ny/pr1jg5nZC4s8f6OuhJLuTSA68vTX8iiLYgaNxpkYn2aHrUaiH0INI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD5VFquk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B3FC433B2;
	Fri,  2 Feb 2024 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903952;
	bh=t4kGvcZAyPHW38f5oPy9NpKLy61UGodk/h/wXqd7kZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XD5VFqukR7gqnIKSizGUPqXYHzgBeBJKgezSNDvrQQLwE+RLJIVEvo9kg+1ZLkSFP
	 Rf0j8e4dZ8e02j/OJ5AF4IKu2oYfj4c8jDUeRGvFIMdBTpsYyfnzMC72xo89VizRmV
	 t3LOQEwJvqHf6mlYvPdgQA2Yh4DPd2t+pbBTM6SNAfTuU4RZen6SmDT78SLYhCMS8B
	 Ov9qHuZmwYX/g+HGG+LunPPZ5umeevN1FE6zIf04gXUwOz6ZmiiGCICGMhwCrom4DE
	 en1VjYRQ68hjitBZfGCLeJCu5Lux1RHGhwzNeoD5fd7gERQzCKm+5crygydWH43/z3
	 MvLbg0Q3I5rXw==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/7] of: Create of_root if no dtb provided by firmware
Date: Fri,  2 Feb 2024 11:59:03 -0800
Message-ID: <20240202195909.3458162-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202195909.3458162-1-sboyd@kernel.org>
References: <20240202195909.3458162-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Rowand <frowand.list@gmail.com>

When enabling CONFIG_OF on a platform where 'of_root' is not populated
by firmware, we end up without a root node. In order to apply overlays
and create subnodes of the root node, we need one. Create this root node
by unflattening an empty builtin dtb.

If firmware provides a flattened device tree (FDT) then the FDT is
unflattened via setup_arch(). Otherwise, the call to
unflatten(_and_copy)?_device_tree() will create an empty root node.

We make of_have_populated_dt() return true only if the DTB was loaded by
firmware so that existing callers don't change behavior after this
patch. The call in the of platform code is removed because it prevents
overlays from creating platform devices when the platform bus isn't
fully initialized.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>
[sboyd@kernel.org: Update of_have_populated_dt() to treat this empty dtb
as not populated. Drop setup_of() initcall]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/Kconfig        |  2 +-
 drivers/of/Makefile       |  2 +-
 drivers/of/empty_root.dts |  6 ++++++
 drivers/of/fdt.c          | 32 +++++++++++++++++++++++++++++++-
 drivers/of/platform.c     |  3 ---
 include/linux/of.h        | 25 +++++++++++++++----------
 6 files changed, 54 insertions(+), 16 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index da9826accb1b..17733285b415 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -54,7 +54,7 @@ config OF_FLATTREE
 	select CRC32
 
 config OF_EARLY_FLATTREE
-	bool
+	def_bool OF && !SPARC
 	select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
 	select OF_FLATTREE
 
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index eff624854575..df305348d1cb 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,7 +2,7 @@
 obj-y = base.o cpu.o device.o module.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
-obj-$(CONFIG_OF_FLATTREE) += fdt.o
+obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root.dtb.o
 obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
 obj-$(CONFIG_OF_PROMTREE) += pdt.o
 obj-$(CONFIG_OF_ADDRESS)  += address.o
diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
new file mode 100644
index 000000000000..cf9e97a60f48
--- /dev/null
+++ b/drivers/of/empty_root.dts
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+/ {
+
+};
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dfeba8b8ce94..e5a385285149 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt)	"OF: fdt: " fmt
 
+#include <linux/acpi.h>
 #include <linux/crash_dump.h>
 #include <linux/crc32.h>
 #include <linux/kernel.h>
@@ -32,6 +33,13 @@
 
 #include "of_private.h"
 
+/*
+ * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created by
+ * cmd_dt_S_dtb in scripts/Makefile.lib
+ */
+extern uint8_t __dtb_empty_root_begin[];
+extern uint8_t __dtb_empty_root_end[];
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
@@ -1343,7 +1351,29 @@ static void *__init copy_device_tree(void *fdt)
  */
 void __init unflatten_device_tree(void)
 {
-	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
+	void *fdt = initial_boot_params;
+
+	/* Don't use the bootloader provided DTB if ACPI is enabled */
+	if (!acpi_disabled)
+		fdt = NULL;
+
+	/*
+	 * Populate an empty root node when ACPI is enabled or bootloader
+	 * doesn't provide one.
+	 */
+	if (!fdt) {
+		fdt = (void *) __dtb_empty_root_begin;
+		/* fdt_totalsize() will be used for copy size */
+		if (fdt_totalsize(fdt) >
+		    __dtb_empty_root_end - __dtb_empty_root_begin) {
+			pr_err("invalid size in dtb_empty_root\n");
+			return;
+		}
+		of_fdt_crc32 = crc32_be(~0, fdt, fdt_totalsize(fdt));
+		fdt = copy_device_tree(fdt);
+	}
+
+	__unflatten_device_tree(fdt, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 126d265aa7d8..20087bb8a46b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -549,9 +549,6 @@ static int __init of_platform_default_populate_init(void)
 
 	device_links_supplier_sync_state_pause();
 
-	if (!of_have_populated_dt())
-		return -ENODEV;
-
 	if (IS_ENABLED(CONFIG_PPC)) {
 		struct device_node *boot_display = NULL;
 		struct platform_device *dev;
diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..52f6ad6a1c8c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -180,11 +180,6 @@ static inline bool is_of_node(const struct fwnode_handle *fwnode)
 			&__of_fwnode_handle_node->fwnode : NULL;	\
 	})
 
-static inline bool of_have_populated_dt(void)
-{
-	return of_root != NULL;
-}
-
 static inline bool of_node_is_root(const struct device_node *node)
 {
 	return node && (node->parent == NULL);
@@ -549,11 +544,6 @@ static inline struct device_node *of_find_node_with_property(
 
 #define of_fwnode_handle(node) NULL
 
-static inline bool of_have_populated_dt(void)
-{
-	return false;
-}
-
 static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
 					const char *compatible)
 {
@@ -1634,6 +1624,21 @@ static inline bool of_device_is_system_power_controller(const struct device_node
 	return of_property_read_bool(np, "system-power-controller");
 }
 
+/**
+ * of_have_populated_dt() - Has DT been populated by bootloader
+ *
+ * Return: True if a DTB has been populated by the bootloader and it isn't the
+ * empty builtin one. False otherwise.
+ */
+static inline bool of_have_populated_dt(void)
+{
+#ifdef CONFIG_OF
+	return of_property_present(of_root, "compatible");
+#else
+	return false;
+#endif
+}
+
 /*
  * Overlay support
  */
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


