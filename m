Return-Path: <linux-kselftest+bounces-13509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0792D9D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D2B1F225DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46621990D1;
	Wed, 10 Jul 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFwB8m4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C91990C2;
	Wed, 10 Jul 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642372; cv=none; b=GZ1YEpi35B6w8qvsfyPNcgS0Uz9qBbAWu661qEkxsDhN85pGsyqXJt+zmYxAQoer3U2v2zOSV6CAS+VjkzkJT/JDx+3n7DMkPdv95RAIqO0P0TnBcepju1FHHyHlAWDjP+KrF/L9U64gcdTnvbIuZGMcHF35OfIKWphh//n6RpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642372; c=relaxed/simple;
	bh=fgE5nfmRa0quNByQlLoYGH1NusyNpretNKDfVnCcd5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8272QXUqWwT0esPeE6oERYiSGuOEiI4U8x7gUTGP/ov2SHnUDE2/3eJhYVJ067hUzEsixhPm6uQI4tv3XqHCcX2wRrvCOChOUwIs3u/A62E8viYeG/ig1xf8LXOghGNH8EHpHPs5RP1WDFctQLL8nTnban13bFHzdS+d1so214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFwB8m4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233FFC32781;
	Wed, 10 Jul 2024 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720642372;
	bh=fgE5nfmRa0quNByQlLoYGH1NusyNpretNKDfVnCcd5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFwB8m4BL1R8C0vT2Er/tAg+ZhlhM02gF5xRfFbKPDFvxtYgKjbhSyWXeDoesDPpL
	 iZDd8D8JyrtxnZXESryfjzoGmhbe/UxUEAUQn5EnNVwuWranffld+S9Q6xptNnuujJ
	 v7K8nBRzudsoaGMhIgSq4/Ne2V+D4zQQZe5uXstvy4Yt7HePE6ylA2nOad+Hzm3AyR
	 r/wI8LqAzKKudrCwp85mfNhhysNpJl1Fcmmmb7I9Qqkc15rbxtEwQsHdqs3YZTbn94
	 KAE9FSfemYwS1ddSZTutGdoyctSs4YZb2mszxt4SN6JanEqNInJxnSTfuPnmWnvNsf
	 wMYxQCa+N4oVQ==
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
Subject: [PATCH v7 4/8] of: Add a KUnit test for overlays and test managed APIs
Date: Wed, 10 Jul 2024 13:12:40 -0700
Message-ID: <20240710201246.1802189-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240710201246.1802189-1-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the KUnit test managed overlay APIs. Confirm that platform devices
are created and destroyed properly. This provides us confidence that the
test managed APIs work correctly and can be relied upon to provide tests
with fake platform devices and device nodes via overlays compiled into
the kernel image.

Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Reviewed-by: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/.kunitconfig            |   1 +
 drivers/of/Kconfig                 |  10 +++
 drivers/of/Makefile                |   1 +
 drivers/of/kunit_overlay_test.dtso |   9 +++
 drivers/of/overlay_test.c          | 115 +++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+)
 create mode 100644 drivers/of/kunit_overlay_test.dtso
 create mode 100644 drivers/of/overlay_test.c

diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
index 5a8fee11978c..4c53d2c7a275 100644
--- a/drivers/of/.kunitconfig
+++ b/drivers/of/.kunitconfig
@@ -1,3 +1,4 @@
 CONFIG_KUNIT=y
 CONFIG_OF=y
 CONFIG_OF_KUNIT_TEST=y
+CONFIG_OF_OVERLAY_KUNIT_TEST=y
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dd726c7056bf..0e2d608c3e20 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -107,6 +107,16 @@ config OF_OVERLAY
 	  While this option is selected automatically when needed, you can
 	  enable it manually to improve device tree unit test coverage.
 
+config OF_OVERLAY_KUNIT_TEST
+	tristate "Device Tree overlay KUnit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select OF_OVERLAY
+	help
+	  This option builds KUnit unit tests for the device tree overlay code.
+
+	  If unsure, say N here, but this option is safe to enable.
+
 config OF_NUMA
 	bool
 
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 2ae909adde49..abd9c578343b 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -21,5 +21,6 @@ endif
 
 obj-$(CONFIG_KUNIT) += of_kunit_helpers.o
 obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
+obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) += overlay_test.o kunit_overlay_test.dtbo.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/kunit_overlay_test.dtso b/drivers/of/kunit_overlay_test.dtso
new file mode 100644
index 000000000000..85f20b4b4c16
--- /dev/null
+++ b/drivers/of/kunit_overlay_test.dtso
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	kunit-test {
+		compatible = "test,empty";
+	};
+};
diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
new file mode 100644
index 000000000000..19a292cdeee3
--- /dev/null
+++ b/drivers/of/overlay_test.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for device tree overlays
+ */
+#include <linux/device/bus.h>
+#include <linux/kconfig.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <kunit/of.h>
+#include <kunit/test.h>
+
+static const char * const kunit_node_name = "kunit-test";
+static const char * const kunit_compatible = "test,empty";
+
+/* Test that of_overlay_apply_kunit() adds a node to the live tree */
+static void of_overlay_apply_kunit_apply(struct kunit *test)
+{
+	struct device_node *np;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_overlay_test));
+
+	np = of_find_node_by_name(NULL, kunit_node_name);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
+	of_node_put(np);
+}
+
+/*
+ * Test that of_overlay_apply_kunit() creates platform devices with the
+ * expected device_node
+ */
+static void of_overlay_apply_kunit_platform_device(struct kunit *test)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(test, kunit_overlay_test));
+
+	np = of_find_node_by_name(NULL, kunit_node_name);
+	of_node_put_kunit(test, np);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
+
+	pdev = of_find_device_by_node(np);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, pdev);
+	if (pdev)
+		put_device(&pdev->dev);
+}
+
+static int of_overlay_bus_match_compatible(struct device *dev, const void *data)
+{
+	return of_device_is_compatible(dev->of_node, data);
+}
+
+/* Test that of_overlay_apply_kunit() cleans up after the test is finished */
+static void of_overlay_apply_kunit_cleanup(struct kunit *test)
+{
+	struct kunit fake;
+	struct platform_device *pdev;
+	struct device *dev;
+	struct device_node *np;
+
+	if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
+		kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE for root node");
+
+	kunit_init_test(&fake, "fake test", NULL);
+	KUNIT_ASSERT_EQ(test, fake.status, KUNIT_SUCCESS);
+
+	KUNIT_ASSERT_EQ(test, 0,
+			of_overlay_apply_kunit(&fake, kunit_overlay_test));
+
+	np = of_find_node_by_name(NULL, kunit_node_name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
+	of_node_put_kunit(test, np);
+
+	pdev = of_find_device_by_node(np);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	put_device(&pdev->dev); /* Not derefing 'pdev' after this */
+
+	/* Remove overlay */
+	kunit_cleanup(&fake);
+
+	/* The node and device should be removed */
+	np = of_find_node_by_name(NULL, kunit_node_name);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, np);
+	of_node_put(np);
+
+	dev = bus_find_device(&platform_bus_type, NULL, kunit_compatible,
+			      of_overlay_bus_match_compatible);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
+	put_device(dev);
+}
+
+static struct kunit_case of_overlay_apply_kunit_test_cases[] = {
+	KUNIT_CASE(of_overlay_apply_kunit_apply),
+	KUNIT_CASE(of_overlay_apply_kunit_platform_device),
+	KUNIT_CASE(of_overlay_apply_kunit_cleanup),
+	{}
+};
+
+/*
+ * Test suite for test managed device tree overlays.
+ */
+static struct kunit_suite of_overlay_apply_kunit_suite = {
+	.name = "of_overlay_apply_kunit",
+	.test_cases = of_overlay_apply_kunit_test_cases,
+};
+
+kunit_test_suites(
+	&of_overlay_apply_kunit_suite,
+);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for device tree overlays");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


