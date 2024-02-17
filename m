Return-Path: <linux-kselftest+bounces-4902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4838858C9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669581F22010
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED2219FC;
	Sat, 17 Feb 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAOa4fi4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DC21112;
	Sat, 17 Feb 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131963; cv=none; b=uIsQBiCmGM3StojGfCjgMquuorQ82bKQr0lVz1qxjzG/adnq/vZP9n4Hr34epCfwoo4JVz1TccCWg95TJ9upTS8+0GimjvQiBF4zVPWqjRmHWCmpP16eghHO4S63eeSZsFT1XNqabuFlomwsMK0h3oFrlvKO4SsYCyS3txKBneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131963; c=relaxed/simple;
	bh=J3WMalAjgz0rnHbmeT8QD4FpP4dD0hu4Yj+NzkEppQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoYrz9lO0oishzan+DgenCRJe2Xzc/3NpM1q4L+THlZXVmhNRSwZIkIi1tP0bBXZaa/5/hpUjvSZr6Ba3R8FG0j6z5Sr6OtfJxz7LqcwSAv9uPvIBA6SZz/uuT+Z39n344FcsoqvawWxbpslx9lOYbhmFAGoxUq0AzXsq7X7yRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAOa4fi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE8DC433A6;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131963;
	bh=J3WMalAjgz0rnHbmeT8QD4FpP4dD0hu4Yj+NzkEppQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAOa4fi46Q5W6L0e8l/qgg64ROvD783Ms6lXCLYZpxVg35KK7iz4ZOPqJG55vnPGq
	 3UeRnJKaA3I3cKg6k8nOeUWz9METclLEOdD2v/vwKpzE0krhoMDcnzcf32fLp60VJM
	 TsuqeU8cRg0jhmjmGbtWhR66ChQwQ7qIhwKmEc6mNkXVzW0mVxPXvpIFCOvDJP4Ug0
	 5GQ1D1ccdPvjJlEHgSowFvSe0mQgCZKbefm6SWMC5Ip+4IplYU/9M+WdLtT1NdVNNg
	 COT3rSgSj0bQbQPCU6igti603mJcNcGUWeyv11PFrXku2BBWdb9jKivpvYiB0ZyZVU
	 Kkj8/nueN6ZGw==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>
Subject: [PATCH v4 7/7] of: Add KUnit test to confirm DTB is loaded
Date: Fri, 16 Feb 2024 17:05:56 -0800
Message-ID: <20240217010557.2381548-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
root node, and that the of_have_populated_dt() API works properly. We
skip the test when CONFIG_OF_EARLY_FLATREE=n because in that case we
know architecture code hasn't called unflatten_(and_copy_)?device_tree()
which would populate some sort of root node.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/.kunitconfig |  3 +++
 drivers/of/Kconfig      |  9 +++++++
 drivers/of/Makefile     |  2 ++
 drivers/of/of_test.c    | 57 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 drivers/of/.kunitconfig
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
index d738fbad9c36..dd726c7056bf 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -36,6 +36,15 @@ config OF_UNITTEST
 
 	  If unsure, say N here. This option is not safe to enable.
 
+config OF_KUNIT_TEST
+	tristate "Devicetree KUnit Test" if !KUNIT_ALL_TESTS
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
index df305348d1cb..251d33532148 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -19,4 +19,6 @@ obj-y	+= kexec.o
 endif
 endif
 
+obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
+
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
new file mode 100644
index 000000000000..a9301d293f01
--- /dev/null
+++ b/drivers/of/of_test.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for OF APIs
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <kunit/test.h>
+
+/*
+ * Test that the root node "/" can be found by path.
+ */
+static void of_dtb_root_node_found_by_path(struct kunit *test)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_path("/");
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
+	of_node_put(np);
+}
+
+/*
+ * Test that the 'of_root' global variable is always populated when DT code is
+ * enabled. Remove this test once of_root is removed from global access.
+ */
+static void of_dtb_root_node_populates_of_root(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_root);
+}
+
+static struct kunit_case of_dtb_test_cases[] = {
+	KUNIT_CASE(of_dtb_root_node_found_by_path),
+	KUNIT_CASE(of_dtb_root_node_populates_of_root),
+	{}
+};
+
+static int of_dtb_test_init(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
+		kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE");
+
+	return 0;
+}
+
+/*
+ * Test suite to confirm a DTB is loaded.
+ */
+static struct kunit_suite of_dtb_suite = {
+	.name = "of_dtb",
+	.test_cases = of_dtb_test_cases,
+	.init = of_dtb_test_init,
+};
+
+kunit_test_suites(
+	&of_dtb_suite,
+);
+MODULE_LICENSE("GPL");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


