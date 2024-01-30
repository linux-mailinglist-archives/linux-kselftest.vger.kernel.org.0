Return-Path: <linux-kselftest+bounces-3722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B638417C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221E11C21766
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488B374C9;
	Tue, 30 Jan 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzGOXf0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617D3716F;
	Tue, 30 Jan 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575515; cv=none; b=kE+xAXOnLgozS9uHXvZlFkRTCGpECq8K6RvW/Z+BBwsd7461/0TzulTNxXS9bxBebdEVG/2gS4GtCVsYJR2zbwmZbasRNsJzO0zYYbqEPnNyUPRIn0bRQ88zhjJotEpVRNDqVIMV8WEpFRnAhucnyMufWVkN0fAyVHXzhZ2Y+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575515; c=relaxed/simple;
	bh=PiweXFroDHF7yXaa82SMFRXH/FDbm1RzgiHTih6bLA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVlxJzGg/RC1xTQiLKm8w98HNxbY/KrcpkoLEA5heqfwXizIuwy3U+waXDa0/X0PRxhisHMGHaAv4KQ83j6v/7+DwJ5zFVfsj0bR/TrGDezEPgCauRPOjvvSomJQyFMMcV1eneDWZemjRdjC+VY42mNirJGlTTp2AhvUHw62U7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzGOXf0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6E4C43609;
	Tue, 30 Jan 2024 00:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575515;
	bh=PiweXFroDHF7yXaa82SMFRXH/FDbm1RzgiHTih6bLA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TzGOXf0xtEnuBMKuXJA6vqerJOp0D0uIDNQFWdGOH3l33XbaHnYJ9I3mYGODL2xxv
	 FvYYJep2tflHq4V0UcqCEB2qc3z3xiIyVM65MQ8F12kGMHIq0zhX5iTNd0OwzHK3uJ
	 +D5rvAm5GRr5SPCQ7vSVXDIJvzCWbXCZx1R6KdhL5mC8W37TCpLc6jZVKmF9iSNWQJ
	 QLggfDM/lA5RPUFdkYhPg/HyXl5R+4b4rdKWSsuxduScfg/a0lFoiNIhC2yqRQoXdj
	 ajXgXI0puNc540MbLYhob5cDaQwc0mvu8sBP/DHUYcm2YixEL2Rpls3ikHYNE9Xsnw
	 cWSsF2qgM1ovg==
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
Subject: [PATCH v2 7/7] of: Add KUnit test to confirm DTB is loaded
Date: Mon, 29 Jan 2024 16:45:06 -0800
Message-ID: <20240130004508.1700335-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130004508.1700335-1-sboyd@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
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
 drivers/of/.kunitconfig |  3 +++
 drivers/of/Kconfig      |  9 ++++++++
 drivers/of/Makefile     |  2 ++
 drivers/of/of_test.c    | 48 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
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
index 17733285b415..53d1b5dd89e8 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -37,6 +37,15 @@ config OF_UNITTEST
 
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
index 000000000000..71a767b42b43
--- /dev/null
+++ b/drivers/of/of_test.c
@@ -0,0 +1,48 @@
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
+ * Test that the 'of_root' global variable is always populated when DT code is
+ * enabled.
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
+ * Test suite to confirm a DTB is loaded.
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
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


