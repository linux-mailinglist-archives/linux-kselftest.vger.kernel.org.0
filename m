Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3716A78F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCBBic (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCBBia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:38:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9B2313F;
        Wed,  1 Mar 2023 17:38:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE89A61544;
        Thu,  2 Mar 2023 01:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CCFC4339E;
        Thu,  2 Mar 2023 01:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677721105;
        bh=kuvw9W5FZhpfWvxyQ40xAiL1cU8qQButV6bl0j/U8CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvFYRxNcF/h2bnEXB525WG0BYTbbsmT9V2JIlTtAcKJCeL3H6/rVztATelYl8ioT3
         0ofMBzrOcsfG3jfXxGqc7LCrD2YNMMqIo5SpU+i/A79tZVpSEFRDLLKMZQ5jfrZUev
         dprzZA6j8c+VRmLyzIqz+Aj5eJ6Hf5T0TMd66jeOhvQd1SCzBrHTNYpVxjHrHdwFI/
         Ckz1aUqKMUxLyWqWvE9UqkclchocVqKZEl54ZtQ07ngMVTH2WbRcyQvM1XmvXVDW5S
         rY/yDUvP8okVyFHcE6u2F4m1kE7bY6HMkrOETWHIC0QqFzla4Ox7fUfV6VJvu82m6r
         Pz3tBMtJCmjGg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
Date:   Wed,  1 Mar 2023 17:38:15 -0800
Message-Id: <20230302013822.1808711-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
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

To fully exercise common clk framework code in KUnit we need to
associate 'struct device' pointers with 'struct device_node' pointers so
that things like clk_get() can parse DT nodes for 'clocks' and so that
clk providers can use DT to provide clks; the most common mode of
operation for clk providers.

Adding support to KUnit so that it loads a DTB is fairly simple after
commit b31297f04e86 ("um: Add devicetree support"). We can simply pass a
pre-compiled deviectree blob (DTB) on the kunit.py commandline and UML
will load it. The problem is that tests won't know that the commandline
has been modified, nor that a DTB has been loaded. Take a different
approach so that tests can skip if a DTB hasn't been loaded.

Reuse the Makefile logic from the OF unittests to build a DTB into the
kernel. This DTB will be for the mythical machine "linux,kunit", i.e.
the devicetree for the KUnit "board". In practice, it is a dtsi file
that will gather includes for kunit tests that rely in part on a
devicetree being loaded. The devicetree should only be loaded if
CONFIG_OF_KUNIT=y. Make that a choice config parallel to the existing
CONFIG_OF_UNITTEST so that only one devicetree can be loaded in the
system at a time. Similarly, the kernel commandline option to load a
DTB is ignored if CONFIG_OF_KUNIT is enabled so that only one DTB is
loaded at a time.

Add a simple unit test to confirm that the DTB loading worked. Future
tests will add to the kunit.dtsi file to include their specific test
nodes.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/kernel/dtb.c            | 29 +++++++++++++++--
 drivers/of/Kconfig              | 26 ++++++++++++++++
 drivers/of/Makefile             |  1 +
 drivers/of/kunit/.kunitconfig   |  4 +++
 drivers/of/kunit/Makefile       |  4 +++
 drivers/of/kunit/kunit.dtsi     |  8 +++++
 drivers/of/kunit/kunit.dtso     |  4 +++
 drivers/of/kunit/uml_dtb_test.c | 55 +++++++++++++++++++++++++++++++++
 8 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 drivers/of/kunit/.kunitconfig
 create mode 100644 drivers/of/kunit/Makefile
 create mode 100644 drivers/of/kunit/kunit.dtsi
 create mode 100644 drivers/of/kunit/kunit.dtso
 create mode 100644 drivers/of/kunit/uml_dtb_test.c

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 484141b06938..ee63951b12df 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -15,9 +15,32 @@ void uml_dtb_init(void)
 	long long size;
 	void *area;
 
-	area = uml_load_file(dtb, &size);
-	if (!area)
-		return;
+	if (IS_ENABLED(CONFIG_OF_KUNIT)) {
+		/*
+		 * __dtbo_kunit_begin[] and __dtbo_kunit_end[] are magically
+		 * created by cmd_dt_S_dtbo in scripts/Makefile.lib from the
+		 * drivers/of/kunit/kunit.dtsi file.
+		 */
+		extern uint8_t __dtbo_kunit_begin[];
+		extern uint8_t __dtbo_kunit_end[];
+
+		size = __dtbo_kunit_end - __dtbo_kunit_begin;
+		if (!size) {
+			pr_warn("%s: kunit testcases is empty\n", __func__);
+			return;
+		}
+
+		/* creating copy */
+		area = memblock_alloc(size, 8);
+		if (!area)
+			return;
+
+		memcpy(area, __dtbo_kunit_begin, size);
+	} else {
+		area = uml_load_file(dtb, &size);
+		if (!area)
+			return;
+	}
 
 	if (!early_init_dt_scan(area)) {
 		pr_err("invalid DTB %s\n", dtb);
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..1f968b6a3dde 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -12,6 +12,20 @@ menuconfig OF
 
 if OF
 
+choice
+	prompt "Devicetree Runtime Tests"
+	default OF_UNITTEST
+
+config OF_KUNIT
+	bool "Devicetree KUnit support" if KUNIT
+	depends on UML
+	select IRQ_DOMAIN
+	select OF_EARLY_FLATTREE
+	help
+	  This option builds in KUnit test cases that rely on device tree infrastructure.
+	  A fake Device Tree Blob (DTB) is loaded on the UML kernel running KUnit so that
+	  KUnit tests can test device tree dependent code.
+
 config OF_UNITTEST
 	bool "Device Tree runtime unit tests"
 	depends on !SPARC
@@ -25,6 +39,18 @@ config OF_UNITTEST
 
 	  If unsure, say N here, but this option is safe to enable.
 
+endchoice
+
+config OF_DTB_KUNIT_TEST
+	tristate "Devicetree KUnit DTB Test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds unit tests for the "linux,kunit" DTB built into
+	  the UML kernel image.
+
+	  If unsure, say N here, but this option is safe to enable.
+
 config OF_ALL_DTBS
 	bool "Build all Device Tree Blobs"
 	depends on COMPILE_TEST
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..16eef3fdf60a 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -19,4 +19,5 @@ obj-y	+= kexec.o
 endif
 endif
 
+obj-y += kunit/
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/kunit/.kunitconfig b/drivers/of/kunit/.kunitconfig
new file mode 100644
index 000000000000..1def0ad30d29
--- /dev/null
+++ b/drivers/of/kunit/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_OF=y
+CONFIG_OF_KUNIT=y
+CONFIG_OF_DTB_KUNIT_TEST=y
diff --git a/drivers/of/kunit/Makefile b/drivers/of/kunit/Makefile
new file mode 100644
index 000000000000..ffe0447e1ac7
--- /dev/null
+++ b/drivers/of/kunit/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_OF_KUNIT) += kunit.dtbo.o
+
+obj-$(CONFIG_OF_DTB_KUNIT_TEST) += uml_dtb_test.o
diff --git a/drivers/of/kunit/kunit.dtsi b/drivers/of/kunit/kunit.dtsi
new file mode 100644
index 000000000000..82f6c3e2b8d5
--- /dev/null
+++ b/drivers/of/kunit/kunit.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	model = "KUnit UML";
+	compatible = "linux,kunit";
+};
+
+/* Include testcase dtsi files below */
diff --git a/drivers/of/kunit/kunit.dtso b/drivers/of/kunit/kunit.dtso
new file mode 100644
index 000000000000..50187e8d1422
--- /dev/null
+++ b/drivers/of/kunit/kunit.dtso
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "kunit.dtsi"
diff --git a/drivers/of/kunit/uml_dtb_test.c b/drivers/of/kunit/uml_dtb_test.c
new file mode 100644
index 000000000000..8966c9ebf51f
--- /dev/null
+++ b/drivers/of/kunit/uml_dtb_test.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for DTB loading on UML
+ */
+#include <linux/kconfig.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+#include <kunit/test.h>
+
+/*
+ * Test that of_machine_is_compatible() returns positive int when loaded DTB
+ * matches.
+ */
+static void uml_dtb_of_machine_compatible_test(struct kunit *test)
+{
+	KUNIT_EXPECT_GT(test, of_machine_is_compatible("linux,kunit"), 0);
+}
+
+/*
+ * Test that of_flat_dt_get_machine_name() returns the expected 'model' from the
+ * loaded DTB.
+ */
+static void uml_dtb_of_flat_dt_get_machine_name_test(struct kunit *test)
+{
+	KUNIT_EXPECT_STREQ(test, of_flat_dt_get_machine_name(), "KUnit UML");
+}
+
+static struct kunit_case uml_dtb_test_cases[] = {
+	KUNIT_CASE(uml_dtb_of_machine_compatible_test),
+	KUNIT_CASE(uml_dtb_of_flat_dt_get_machine_name_test),
+	{}
+};
+
+static int uml_dtb_test_init(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_OF_KUNIT))
+		kunit_skip(test, "requires CONFIG_OF_KUNIT");
+
+	return 0;
+}
+
+/*
+ * Test suite to confirm DTB is loaded on UML.
+ */
+static struct kunit_suite uml_dtb_suite = {
+	.name = "uml_dtb",
+	.init = uml_dtb_test_init,
+	.test_cases = uml_dtb_test_cases,
+};
+
+kunit_test_suites(
+	&uml_dtb_suite,
+);
+MODULE_LICENSE("GPL");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

