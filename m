Return-Path: <linux-kselftest+bounces-2932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B839382C632
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 21:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E95B22CDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92D17738;
	Fri, 12 Jan 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9/SlA7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E117730;
	Fri, 12 Jan 2024 20:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51766C43394;
	Fri, 12 Jan 2024 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090075;
	bh=ua+X20080YRjcHe0C1o6t3ehjcRZtGl3WAk/t15eQ/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9/SlA7dwlMSfXI4eTDVjMoPuCuC9FE1VqpmUJNPyPwQcZ8vlOb3P4KZF4WInPPrS
	 D8k7Eg93W+UcWyPzE34O9t7/0Rr/Jc5XD6DXkEd93rA65eBuxCnEml4DGbpVStHG91
	 KfzR94Rm5w+TjxilnrPr76MZfQCzXDw0Dnl4o8kaSyQYVsyfxyMT8lW7R/dRKq3C0K
	 4eCSbmy0jRzfvTWgthjDeZ4Q1Knu8TPgS+6KWnQYxLighp/oo63e1pZ3JTdIiz0hea
	 iA41au/DcqhZ+iLg00zV0JqHCZ0cLYgx2ywejUbFVJO4av9lBILwhzoqmlQq8qLy9V
	 uRIv5ur7Xhdug==
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
Subject: [PATCH 6/6] of: Add KUnit test to confirm DTB is loaded
Date: Fri, 12 Jan 2024 12:07:49 -0800
Message-ID: <20240112200750.4062441-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240112200750.4062441-1-sboyd@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
root node, and that the of_have_populated_dt() API works properly.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/.kunitconfig |  3 ++
 drivers/of/Kconfig      |  9 ++++
 drivers/of/Makefile     |  2 +
 drivers/of/of_test.c    | 98 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)
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
index 9628e48baa15..a527ba8451d9 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -37,6 +37,15 @@ config OF_UNITTEST
 
 	  If unsure, say N here. This option is not safe to enable.
 
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
index 000000000000..7609ad3081b9
--- /dev/null
+++ b/drivers/of/of_test.c
@@ -0,0 +1,98 @@
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
+ * Test that the root node "/" exists.
+ */
+static void dtb_root_node_found_by_path(struct kunit *test)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_path("/");
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
+	of_node_put(np);
+}
+
+/*
+ * Test that the of_root global variable is always populated when DT
+ * code is enabled.
+ */
+static void dtb_root_node_populates_of_root(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_root);
+}
+
+static struct kunit_case dtb_test_cases[] = {
+	KUNIT_CASE(dtb_root_node_found_by_path),
+	KUNIT_CASE(dtb_root_node_populates_of_root),
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
+/*
+ * Test that calling of_have_populated_dt() returns false when
+ * the OF_EMPTY_ROOT flag isn't set.
+ */
+static void of_have_populated_dt_false_when_flag_set(struct kunit *test)
+{
+	bool was_set;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);
+
+	was_set = of_node_test_and_set_flag(of_root, OF_EMPTY_ROOT);
+	KUNIT_EXPECT_FALSE(test, of_have_populated_dt());
+
+	if (!was_set)
+		of_node_clear_flag(of_root, OF_EMPTY_ROOT);
+}
+
+/*
+ * Test that calling of_have_populated_dt() returns false when
+ * the OF_EMPTY_ROOT flag isn't set.
+ */
+static void of_have_populated_dt_true_when_flag_clear(struct kunit *test)
+{
+	bool was_set;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);
+
+	was_set = of_node_check_flag(of_root, OF_EMPTY_ROOT);
+	of_node_set_flag(of_root, OF_EMPTY_ROOT);
+	KUNIT_EXPECT_FALSE(test, of_have_populated_dt());
+
+	if (was_set)
+		of_node_set_flag(of_root, OF_EMPTY_ROOT);
+}
+
+static struct kunit_case of_have_populated_dt_test_cases[] = {
+	KUNIT_CASE(of_have_populated_dt_false_when_flag_set),
+	KUNIT_CASE(of_have_populated_dt_true_when_flag_clear),
+	{}
+};
+
+/*
+ * Test suite to confirm behavior of of_have_populated_dt().
+ */
+static struct kunit_suite of_have_populated_dt_suite = {
+	.name = "of_have_populated_dt",
+	.test_cases = of_have_populated_dt_test_cases,
+};
+
+kunit_test_suites(
+	&dtb_suite,
+	&of_have_populated_dt_suite,
+);
+MODULE_LICENSE("GPL");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


