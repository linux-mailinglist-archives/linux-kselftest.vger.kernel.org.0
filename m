Return-Path: <linux-kselftest+bounces-8647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90C8AD91C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D58B2559D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDFC15531E;
	Mon, 22 Apr 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsC0UHNJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5544C8F;
	Mon, 22 Apr 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828255; cv=none; b=Z7OvcNm3ZPN2u6cbUTGOIg2PyxBNqgYJArSf6Bvaf5SUytXdcvg3paSChzMUGIaHB+mm5bthzN+DgLVYcjtPZCOfxBCLkWRkvdtsJ9Fyiw8lF9AXXSS0HT8gSHfC8loSyFXVJfJWexyEjeTdAIo6TSmxXClhwhqj8Dlmy/k/rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828255; c=relaxed/simple;
	bh=dwipR/iNF4TmV0O812aSzS3OFXVfjDjh4Z1JXGd/+yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAAbfLZhC5m+hyd6CU0rytphDS7PK+BFKfHqZr/3hEQ9aXwaKiPNsOw48KFQZl1WkMy3ViTgjqaWa+jO2Y7I4eGzQ5KqccSU/6th/H8mLRnyXUjFPYCbtCum7KcnthmVMJQc7l4RdeIZ2uiaPCkJ5vsKYcqVHR73DEPOzy+kWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsC0UHNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BDCC4AF09;
	Mon, 22 Apr 2024 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828254;
	bh=dwipR/iNF4TmV0O812aSzS3OFXVfjDjh4Z1JXGd/+yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsC0UHNJFvkQgSYyu9zIUBT+P12VsYKr3fc6y5u/4rDuy6PdAq08ONtV5YzOS3MDy
	 lY7Vf+DgFKM32JCNlfSfTPlz7xG6/y3QBWoRx4Yh6uNFxO4b7ThNEMrAahAYOCfCgk
	 yXXl2anGC75Xdl98hSSVdQvQ5mO+ThtbkpiYBt+o7UoHbBEeFeawByBzQ5ukt9uJ4c
	 zassrXeI4b6TflPaYoaKEfSUgVNuv/X69y7MFhrS7I2xgg6eSrLwh/9yQP1LBaPAbC
	 YnxGME922Y8mSqbkC+foP3g0aESjqEUxFAj4e+fnLP39CWfl4wy5h+v7sIEZaddMIC
	 KQZBXKWrYJxgw==
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
Subject: [PATCH v4 07/10] clk: Add test managed clk provider/consumer APIs
Date: Mon, 22 Apr 2024 16:24:00 -0700
Message-ID: <20240422232404.213174-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240422232404.213174-1-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unit tests are more ergonomic and simpler to understand if they don't
have to hoist a bunch of code into the test harness init and exit
functions. Add some test managed wrappers for the clk APIs so that clk
unit tests can write more code in the actual test and less code in the
harness.

Only add APIs that are used for now. More wrappers can be added in the
future as necessary.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/dev-tools/kunit/api/clk.rst   |  10 +
 Documentation/dev-tools/kunit/api/index.rst |   5 +
 drivers/clk/Makefile                        |   5 +
 drivers/clk/clk_kunit.c                     | 198 ++++++++++++++++++++
 include/kunit/clk.h                         |  28 +++
 5 files changed, 246 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/clk.rst
 create mode 100644 drivers/clk/clk_kunit.c
 create mode 100644 include/kunit/clk.h

diff --git a/Documentation/dev-tools/kunit/api/clk.rst b/Documentation/dev-tools/kunit/api/clk.rst
new file mode 100644
index 000000000000..badd87a35f9e
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/clk.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+Clk API
+========
+
+The KUnit clk API is used to test clk providers and clk consumers.
+
+.. kernel-doc:: drivers/clk/clk_kunit.c
+   :export:
diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 02b26f5e8750..5cdb552a0808 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -9,6 +9,7 @@ API Reference
 	test
 	resource
 	functionredirection
+	clk
 	of
 	platformdevice
 
@@ -34,6 +35,10 @@ Documentation/dev-tools/kunit/api/functionredirection.rst
 Driver KUnit API
 ================
 
+Documentation/dev-tools/kunit/api/clk.rst
+
+ - Documents the KUnit clk API
+
 Documentation/dev-tools/kunit/api/of.rst
 
  - Documents the KUnit device tree (OF) API
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 14fa8d4ecc1f..1fd74658a801 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -18,6 +18,11 @@ ifeq ($(CONFIG_OF), y)
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
index 000000000000..ba14f7f5908d
--- /dev/null
+++ b/drivers/clk/clk_kunit.c
@@ -0,0 +1,198 @@
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
+/**
+ * clk_prepare_enable_kunit() - Test managed clk_prepare_enable()
+ * @test: The test context
+ * @clk: clk to prepare and enable
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int clk_prepare_enable_kunit(struct kunit *test, struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	return kunit_add_action_or_reset(test,
+					 (kunit_action_t *)&clk_disable_unprepare,
+					 clk);
+}
+EXPORT_SYMBOL_GPL(clk_prepare_enable_kunit);
+
+static struct clk *__clk_get_kunit(struct kunit *test, struct clk *clk)
+{
+	int ret;
+
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = kunit_add_action_or_reset(test, (kunit_action_t *)&clk_put, clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk;
+}
+
+/**
+ * clk_get_kunit() - Test managed clk_get()
+ * @test: The test context
+ * @dev: device for clock "consumer"
+ * @con_id: clock consumer ID
+ *
+ * Just like clk_get(), except the clk is managed by the test case and is
+ * automatically put with clk_put() after the test case concludes.
+ *
+ * Return: new clk consumer or ERR_PTR on failure.
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
+ * Just like of_clk_get(), except the clk is managed by the test case and is
+ * automatically put with clk_put() after the test case concludes.
+ *
+ * Return: new clk consumer or ERR_PTR on failure.
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
+ * Just like clk_hw_get_clk(), except the clk is managed by the test case and
+ * is automatically put with clk_put() after the test case concludes.
+ *
+ * Return: new clk consumer or ERR_PTR on failure.
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
+ * Just like
+ *
+ * .. code-block:: c
+ *
+ *	struct clk *clk = clk_hw_get_clk(...);
+ *	clk_prepare_enable(clk);
+ *
+ * except the clk is managed by the test case and is automatically disabled and
+ * unprepared with clk_disable_unprepare() and put with clk_put() after the
+ * test case concludes.
+ *
+ * Return: new clk consumer that is prepared and enabled or ERR_PTR on failure.
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
+/**
+ * clk_hw_register_kunit() - Test managed clk_hw_register()
+ * @test: The test context
+ * @dev: device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Just like clk_hw_register(), except the clk registration is managed by the
+ * test case and is automatically unregistered after the test case concludes.
+ *
+ * Return: 0 on success or a negative errno value on failure.
+ */
+int clk_hw_register_kunit(struct kunit *test, struct device *dev, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return kunit_add_action_or_reset(test, (kunit_action_t *)&clk_hw_unregister, hw);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_kunit);
+
+/**
+ * of_clk_hw_register_kunit() - Test managed of_clk_hw_register()
+ * @test: The test context
+ * @node: device_node of device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Just like of_clk_hw_register(), except the clk registration is managed by
+ * the test case and is automatically unregistered after the test case
+ * concludes.
+ *
+ * Return: 0 on success or a negative errno value on failure.
+ */
+int of_clk_hw_register_kunit(struct kunit *test, struct device_node *node, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ret;
+
+	return kunit_add_action_or_reset(test, (kunit_action_t *)&clk_hw_unregister, hw);
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


