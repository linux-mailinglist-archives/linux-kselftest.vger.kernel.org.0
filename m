Return-Path: <linux-kselftest+bounces-8641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69D8AD903
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732FD2829D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1945970;
	Mon, 22 Apr 2024 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4h5Fj6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CE45948;
	Mon, 22 Apr 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828248; cv=none; b=Zu+WYaKXEDVBkHH0WvnblW4/Cp1PIBp5AIoZ4z0EdFHWpBW8DdLaywO+OvDf/7nU5jaH/6tfHwzRnJ04TgmFMQdnd1UYnQVuPGDXiQSuSQWLCFqy3kMPZM5F8gb8PTq6viAu4eq4PYfDqKNmUR8o4QwUAhIzOQJl5O3KRrkKJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828248; c=relaxed/simple;
	bh=RhgBYQ/jwdi1c/nCIzi+HG9YSv7lRWKVXMsqPbXSBH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh+jVUrs3ujWMHHs4GbRS9XizjKUlIYfWasfeB3MJyNzLwLYEGoGixD2Iqo75KYfnlEcO1Eh/X7DDMCBL38CPmJ/rIqwIvm5IVgXGfXP4fGucCENynJYoD2vDL4Kf75REkGT+L4tbeTjbTNTgHUItDn1z3McKrie+x2OKEmFvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4h5Fj6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D223AC32782;
	Mon, 22 Apr 2024 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828247;
	bh=RhgBYQ/jwdi1c/nCIzi+HG9YSv7lRWKVXMsqPbXSBH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4h5Fj6Ni7nws9ihZfaTstAcUvyZgG+Ib5kkIF3xiI/82HqM4SR9BETIai838XQm6
	 8Gt7wk6uRqxLSdbujN/byH2+fug75oSNKrCAZ3eeKOe/cm8WTM9//fk7KuQYU3JF1N
	 dZa87oyjGkcpefbem//md1yhe6aVumM/5GSbdctPZtYPwU9t68iPxaJDuyWp+CzGdj
	 GDtTTfl4shHBL2b2uxxH6Lw0fdRnswJAkn1CC+tC9Rwgl1b5t3YQ3WT2O4giL93PGc
	 S1lcE+kp+K8sVGjiQ/4kLPI6McNjQyW/yxfs3c+k+9l6S0DzDcZ2O3YzggKO1WQOvu
	 qhlw5jByDsaEg==
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
Subject: [PATCH v4 01/10] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
Date: Mon, 22 Apr 2024 16:23:54 -0700
Message-ID: <20240422232404.213174-2-sboyd@kernel.org>
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
Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/dev-tools/kunit/api/index.rst | 11 +++
 Documentation/dev-tools/kunit/api/of.rst    | 13 +++
 drivers/of/Makefile                         |  1 +
 drivers/of/of_kunit.c                       | 99 +++++++++++++++++++++
 include/kunit/of.h                          | 94 +++++++++++++++++++
 5 files changed, 218 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/of.rst
 create mode 100644 drivers/of/of_kunit.c
 create mode 100644 include/kunit/of.h

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 2d8f756aab56..282befa17edf 100644
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
@@ -25,3 +29,10 @@ Documentation/dev-tools/kunit/api/resource.rst
 Documentation/dev-tools/kunit/api/functionredirection.rst
 
  - Documents the KUnit Function Redirection API
+
+Driver KUnit API
+================
+
+Documentation/dev-tools/kunit/api/of.rst
+
+ - Documents the KUnit device tree (OF) API
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
index 251d33532148..0dfd05079313 100644
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
index 000000000000..f63527268a51
--- /dev/null
+++ b/drivers/of/of_kunit.c
@@ -0,0 +1,99 @@
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
+static void of_overlay_fdt_apply_kunit_exit(void *ovcs_id)
+{
+	of_overlay_remove(ovcs_id);
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
+ * Return: 0 on success, negative errno on failure
+ */
+int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
+			       u32 overlay_fdt_size, int *ovcs_id)
+{
+	int ret;
+	int *copy_id;
+
+	if (!IS_ENABLED(CONFIG_OF_OVERLAY))
+		kunit_skip(test, "requires CONFIG_OF_OVERLAY");
+	if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
+		kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE for root node");
+
+	copy_id = kunit_kmalloc(test, sizeof(*copy_id), GFP_KERNEL);
+	if (!copy_id)
+		return -ENOMEM;
+
+	ret = of_overlay_fdt_apply(overlay_fdt, overlay_fdt_size,
+				   ovcs_id, NULL);
+	if (ret)
+		return ret;
+
+	*copy_id = *ovcs_id;
+
+	return kunit_add_action_or_reset(test, of_overlay_fdt_apply_kunit_exit,
+					 copy_id);
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
+ * Return: 0 on success, negative errno on failure
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
+/**
+ * of_node_put_kunit() - Test managed of_node_put()
+ * @test: test context
+ * @node: node to pass to `of_node_put()`
+ *
+ * Just like of_node_put(), except the node is managed by the test case and is
+ * automatically put with of_node_put() after the test case concludes.
+ */
+void of_node_put_kunit(struct kunit *test, struct device_node *node)
+{
+	if (kunit_add_action(test, (kunit_action_t *)&of_node_put, node)) {
+		KUNIT_FAIL(test,
+			   "Can't allocate a kunit resource to put of_node\n");
+	}
+}
+EXPORT_SYMBOL_GPL(of_node_put_kunit);
diff --git a/include/kunit/of.h b/include/kunit/of.h
new file mode 100644
index 000000000000..9981442ba578
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
+ * Return: 0 on success, negative errno on failure.
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


