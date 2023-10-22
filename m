Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5657D260D
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 23:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjJVVHo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjJVVHn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 17:07:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B95DD;
        Sun, 22 Oct 2023 14:07:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD8AC433CC;
        Sun, 22 Oct 2023 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698008861;
        bh=pX1A2S2gjU4x1dZfHy4yT2f4Z5R5IGs3hrXsH8uj4kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPtzbp9DR4GYqSWrxjplHnqJMaf8/XbHf1DVh34biZk0X9atCutXLtohCsYEpmIgb
         oSE/M3l9smu1CM0WYj9uYDQeSuEjy7QE4+XhQhpqfKg7yZS7/Yc37r9tj6ofHumFQ8
         y9e3/u3flDUEJ0m+lxithcFLhD+TPhUMXZ7PUNzF85LMMhoVMKvHzc+Eh+SZ+fjlzO
         wB9gdtBvAmnLkNztpD5YMAhv2kEjvzx9Cw3IwwoPvFwuvVT1TnioVRFrlZvkq9Uh/+
         OuVGuIPTla6+EdOxYKPFZvpwWyqfL31jkE55HGMylFl0h2wZexvWGsrvRnNdvMhDUU
         9LNIgOocj9Ayg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()
Date:   Sun, 22 Oct 2023 21:07:34 +0000
Message-Id: <20231022210735.46409-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022210735.46409-1-sj@kernel.org>
References: <20231022210735.46409-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

damon_sysfs_set_targets() had a bug that can result in unexpected memory
usage and monitoring overhead increase.  The bug has fixed by a previous
commit.  Add a unit test for avoiding a similar bug of future.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig      | 12 ++++++
 mm/damon/sysfs-test.h | 86 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c      |  2 +
 3 files changed, 100 insertions(+)
 create mode 100644 mm/damon/sysfs-test.h

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 436c6b4cb5ec..29f43fbc2eff 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -59,6 +59,18 @@ config DAMON_SYSFS
 	  This builds the sysfs interface for DAMON.  The user space can use
 	  the interface for arbitrary data access monitoring.
 
+config DAMON_SYSFS_KUNIT_TEST
+	bool "Test for damon debugfs interface" if !KUNIT_ALL_TESTS
+	depends on DAMON_SYSFS && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the DAMON sysfs interface Kunit test suite.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation.
+
+	  If unsure, say N.
+
 config DAMON_DBGFS
 	bool "DAMON debugfs interface (DEPRECATED!)"
 	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
diff --git a/mm/damon/sysfs-test.h b/mm/damon/sysfs-test.h
new file mode 100644
index 000000000000..73bdce2452c1
--- /dev/null
+++ b/mm/damon/sysfs-test.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Access Monitor Unit Tests
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#ifdef CONFIG_DAMON_SYSFS_KUNIT_TEST
+
+#ifndef _DAMON_SYSFS_TEST_H
+#define _DAMON_SYSFS_TEST_H
+
+#include <kunit/test.h>
+
+static unsigned int nr_damon_targets(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	unsigned int nr_targets = 0;
+
+	damon_for_each_target(t, ctx)
+		nr_targets++;
+
+	return nr_targets;
+}
+
+static int __damon_sysfs_test_get_any_pid(int min, int max)
+{
+	struct pid *pid;
+	int i;
+
+	for (i = min; i <= max; i++) {
+		pid = find_get_pid(i);
+		if (pid) {
+			put_pid(pid);
+			return i;
+		}
+	}
+	return -1;
+}
+
+static void damon_sysfs_test_set_targets(struct kunit *test)
+{
+	struct damon_sysfs_targets *sysfs_targets;
+	struct damon_sysfs_target *sysfs_target;
+	struct damon_ctx *ctx;
+
+	sysfs_targets = damon_sysfs_targets_alloc();
+	sysfs_targets->nr = 1;
+	sysfs_targets->targets_arr = kmalloc_array(1,
+			sizeof(*sysfs_targets->targets_arr), GFP_KERNEL);
+
+	sysfs_target = damon_sysfs_target_alloc();
+	sysfs_target->pid = __damon_sysfs_test_get_any_pid(12, 100);
+	sysfs_target->regions = damon_sysfs_regions_alloc();
+	sysfs_targets->targets_arr[0] = sysfs_target;
+
+	ctx = damon_new_ctx();
+
+	damon_sysfs_set_targets(ctx, sysfs_targets);
+	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
+
+	sysfs_target->pid = __damon_sysfs_test_get_any_pid(
+			sysfs_target->pid + 1, 200);
+	damon_sysfs_set_targets(ctx, sysfs_targets);
+	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
+
+	damon_destroy_ctx(ctx);
+	kfree(sysfs_targets->targets_arr);
+	kfree(sysfs_targets);
+	kfree(sysfs_target);
+}
+
+static struct kunit_case damon_sysfs_test_cases[] = {
+	KUNIT_CASE(damon_sysfs_test_set_targets),
+	{},
+};
+
+static struct kunit_suite damon_sysfs_test_suite = {
+	.name = "damon-sysfs",
+	.test_cases = damon_sysfs_test_cases,
+};
+kunit_test_suite(damon_sysfs_test_suite);
+
+#endif /* _DAMON_SYSFS_TEST_H */
+
+#endif /* CONFIG_DAMON_SYSFS_KUNIT_TEST */
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5268e8503722..d13e353bee52 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1804,3 +1804,5 @@ static int __init damon_sysfs_init(void)
 	return err;
 }
 subsys_initcall(damon_sysfs_init);
+
+#include "sysfs-test.h"
-- 
2.34.1

