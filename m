Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08CB1A8D34
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 23:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633557AbgDNVEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633574AbgDNVB5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 17:01:57 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE65C061A0E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 14:01:56 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x190so840261pgx.19
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZT9uearJKSnBiqdjC5QhzgxpTglsuQMI/wN8PXUX9eU=;
        b=mb2PRhSeg1kyS8eXbE+AHB8pbDmwauqFv3Af67l0qf34soIrNE2+PWJOVmY4xCLD1M
         ZLtTcCqfWh9mRht24aCgrcUfedC5EV2jeNL7+jyl1j9v5wwt+P3S7ANJ6cxqO/VziGgC
         zmj8gSM9CvaA2/VZSRFSRY09dktytU1aPnSIOnTPGtEYBla4CzZzLH1W4OgRFnvfc8Nr
         TlSjYxMZV3HjTQXRQ5zc6IeWqJkwLzQBS5eEZaxWrQXwNflqtNJZ0xc1uOy/gSb9eBrq
         MMh8L8QmGi3ECF5n2tOY2luFyZxoi8q5E1h19B0c5gaI4ahhu6iWY5Lak7lX+7Jh9/zl
         kysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZT9uearJKSnBiqdjC5QhzgxpTglsuQMI/wN8PXUX9eU=;
        b=WQHzQGC/95p4HLwfu0xP+xkatnIiDonsCTaE5pWjEv19mQ83jlRNiyG0U6FGkjwVFP
         MwPiarMPM6J7ViYNdnj4+hg2Igfym5xLpg/czf5qOVR+C0dJoawYn1JnmbzTTPhs6SZ5
         gpE0MLLinxu7g27VuQlmGyPyIu5WFZlsgeL6uoHB2ulMBdZzYmEFwc3At83hnQkzUMAK
         it4VrqWfIymVZAPXpBBMN1XlCfqopbSZQFx5fhvsvXgtNhh6mJwiOwujJi1lkmKecJ9M
         hKXXLAr4EVQOZou1tjz4RbWTruRGIBVeuBI+BLyp8/SwXpN7enxWGW6Noy5Aqj2Y24RL
         1ViA==
X-Gm-Message-State: AGi0PuYlO/TCKiryjDGlpG0FixDsTFaJ88hMI4VTQE57e4XG9e3nXzmu
        aYrrKMckBS0tepkpNXAKpR5tB71fbBnC0EQJUQgLaQ==
X-Google-Smtp-Source: APiQypJk6hNUQUA3Bisgo76EBfo2lDVWAGKtRAaH5IY81miVwxuR5o6DC3Snabvte1Vdaw+giAxDZtEfV7zCyd0/4I1tmg==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr2318668pjk.142.1586898116262;
 Tue, 14 Apr 2020 14:01:56 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:01:42 -0700
Message-Id: <20200414210142.191327-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [RFC v1] software: node: test: add test to exercise parent child add/remove
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test which adds a tree of software_nodes, checks that the nodes
exist, and then removes the tree. This exercises a bug reported by
Naresh Kamboju <naresh.kamboju@linaro.org>, and pretty much just takes a
test case from the test_printf Kselftest module and refocusses it on
adding and then removing a tree of software_nodes.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---

I am not sure if this should be rolled into the property entry test, or
should be moved somewhere else; nevertheless, testing the software node
API seems like a good idea and this seems like a good place to start.

---
 drivers/base/test/Kconfig              | 14 ++++++++
 drivers/base/test/Makefile             |  2 ++
 drivers/base/test/software-node-test.c | 46 ++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 drivers/base/test/software-node-test.c

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 305c7751184a..b42f385fe233 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -11,3 +11,17 @@ config TEST_ASYNC_DRIVER_PROBE
 config KUNIT_DRIVER_PE_TEST
 	bool "KUnit Tests for property entry API"
 	depends on KUNIT=y
+config KUNIT_DRIVER_SOFTWARE_NODE_TEST
+	bool "KUnit Tests for software node API"
+	depends on KUNIT=y
+	help
+	  This builds the software node API tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  and are not for inclusion into a production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 3ca56367c84b..63325e8a5288 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
+
+obj-$(CONFIG_KUNIT_DRIVER_SOFTWARE_NODE_TEST) += software-node-test.o
diff --git a/drivers/base/test/software-node-test.c b/drivers/base/test/software-node-test.c
new file mode 100644
index 000000000000..0609cbd9aa0a
--- /dev/null
+++ b/drivers/base/test/software-node-test.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+// Unit tests for software node API
+//
+// Copyright 2020 Google LLC.
+
+#include <kunit/test.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+static void software_node_test_register_nodes(struct kunit *test)
+{
+	const struct software_node softnodes[] = {
+		{ .name = "first", },
+		{ .name = "second", .parent = &softnodes[0], },
+		{ .name = "third", .parent = &softnodes[1], },
+		{}
+	};
+	const char * const full_name = "first/second/third";
+	char *buf;
+
+	buf = kunit_kzalloc(test, strlen(full_name), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	KUNIT_ASSERT_EQ(test, software_node_register_nodes(softnodes), 0);
+
+	/* Check that all the nodes exist. */
+	KUNIT_ASSERT_EQ(test,
+			(size_t)sprintf(buf, "%pfw",
+					software_node_fwnode(&softnodes[2])),
+			strlen(full_name));
+	KUNIT_EXPECT_STREQ(test, buf, full_name);
+
+	software_node_unregister_nodes(softnodes);
+}
+
+static struct kunit_case software_node_test_cases[] = {
+	KUNIT_CASE(software_node_test_register_nodes),
+	{}
+};
+
+static struct kunit_suite software_node_test_suite = {
+	.name = "software-node",
+	.test_cases = software_node_test_cases,
+};
+
+kunit_test_suite(software_node_test_suite);

base-commit: 8632e9b5645bbc2331d21d892b0d6961c1a08429
-- 
2.26.0.110.g2183baf09c-goog

