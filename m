Return-Path: <linux-kselftest+bounces-23809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5ED9FF503
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 22:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EFC161A5C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E431E500C;
	Wed,  1 Jan 2025 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfmiU+x5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14181E5019;
	Wed,  1 Jan 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735767342; cv=none; b=FJ53HxobSoVDBnmtchXJ16Hjvr9REHu7vyugaepwSulD4MymHMpsz9jeRvMJPQzMBVJiItWwNdQt3MsHJciXbHDPLQfXiBwPBhzyGKxcybfkAWezl4W7WvdJzcdfmaHwnxUfFKMAqKF1U5KuE3l2rr2LwBE5NBTGLeDDSFfje9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735767342; c=relaxed/simple;
	bh=6FG97a2QCkNzbJZKIVGLLC/WiWRcYRT8nrNZYRnHJGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/0ehwW2W9lrF+gMQW9yQll6SyszNZn5q5VWIJybKYuiMCpPyqSZH9Vaf3fegc+1HQxggRRq3UqsLd8bo5ELv9+FN8cHeu3cqU2vxwzlIbUfEuQ5AcKWqevyDGaeeXCL9c/sfOcp/+0YARYxa9zFmEegq/ezJcObgwlIEaiSmfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfmiU+x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAC8C4CECE;
	Wed,  1 Jan 2025 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735767342;
	bh=6FG97a2QCkNzbJZKIVGLLC/WiWRcYRT8nrNZYRnHJGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfmiU+x53jG0P2hkwOLeJFVcJzHVBEXfJOtZ7ZHtL0QGphXvJ7hChiXdUtQEI6gKh
	 iGHSSkCjlQ2XYrrQbxhovBS80RTyAWV1U2mwMN7jUs6Ikl8J/rMMPyKNF3BQzdT6t6
	 7jrNIYWMHc0ENW3QRCzVLdg5JZg5nA7QPhk4StNU91ZfJeV04T+0iiEFzw4t2ShShc
	 FgddVLy7XaT+djzpLJIxK8dOMWjy5Hou6jJmxndNwgsnPLx0NObN7cgal64/nYEQtU
	 uMknyqLl8NuP3oLbd+X33NiUodQ09gmDPVe9daQQHgVO3EIh4f3q1FHM0zmWMq5Dqk
	 NvgNaj2KwnTIg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] mm/damon: remove DAMON debugfs interface kunit tests
Date: Wed,  1 Jan 2025 13:35:26 -0800
Message-Id: <20250101213527.74203-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250101213527.74203-1-sj@kernel.org>
References: <20250101213527.74203-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove kunit tests for the interface, to prevent unnecessary test
failures.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig             |  12 ---
 mm/damon/dbgfs.c             |   2 -
 mm/damon/tests/.kunitconfig  |   7 --
 mm/damon/tests/dbgfs-kunit.h | 173 -----------------------------------
 4 files changed, 194 deletions(-)
 delete mode 100644 mm/damon/tests/dbgfs-kunit.h

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index d0357f3e9372..db0d92624e8b 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -89,18 +89,6 @@ config DAMON_DBGFS
 	default y
 	depends on DAMON_DBGFS_DEPRECATED
 
-config DAMON_DBGFS_KUNIT_TEST
-	bool "Test for damon debugfs interface" if !KUNIT_ALL_TESTS
-	depends on DAMON_DBGFS && KUNIT=y
-	default KUNIT_ALL_TESTS
-	help
-	  This builds the DAMON debugfs interface Kunit test suite.
-
-	  For more information on KUnit and unit tests in general, please refer
-	  to the KUnit documentation.
-
-	  If unsure, say N.
-
 config DAMON_RECLAIM
 	bool "Build DAMON-based reclaim (DAMON_RECLAIM)"
 	depends on DAMON_PADDR
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index b4213bc47e44..5664c2cb0a5e 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -1144,5 +1144,3 @@ static int __init damon_dbgfs_init(void)
 }
 
 module_init(damon_dbgfs_init);
-
-#include "tests/dbgfs-kunit.h"
diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
index a73be044fc9b..36a450f57b58 100644
--- a/mm/damon/tests/.kunitconfig
+++ b/mm/damon/tests/.kunitconfig
@@ -13,10 +13,3 @@ CONFIG_DAMON_VADDR_KUNIT_TEST=y
 CONFIG_SYSFS=y
 CONFIG_DAMON_SYSFS=y
 CONFIG_DAMON_SYSFS_KUNIT_TEST=y
-
-# for DAMON debugfs interface
-CONFIG_DEBUG_FS=y
-CONFIG_DAMON_PADDR=y
-CONFIG_DAMON_DBGFS_DEPRECATED=y
-CONFIG_DAMON_DBGFS=y
-CONFIG_DAMON_DBGFS_KUNIT_TEST=y
diff --git a/mm/damon/tests/dbgfs-kunit.h b/mm/damon/tests/dbgfs-kunit.h
deleted file mode 100644
index 087e53f641a8..000000000000
--- a/mm/damon/tests/dbgfs-kunit.h
+++ /dev/null
@@ -1,173 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * DAMON Debugfs Interface Unit Tests
- *
- * Author: SeongJae Park <sj@kernel.org>
- */
-
-#ifdef CONFIG_DAMON_DBGFS_KUNIT_TEST
-
-#ifndef _DAMON_DBGFS_TEST_H
-#define _DAMON_DBGFS_TEST_H
-
-#include <kunit/test.h>
-
-static void damon_dbgfs_test_str_to_ints(struct kunit *test)
-{
-	char *question;
-	int *answers;
-	int expected[] = {12, 35, 46};
-	ssize_t nr_integers = 0, i;
-
-	question = "123";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
-	KUNIT_EXPECT_EQ(test, 123, answers[0]);
-	kfree(answers);
-
-	question = "123abc";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
-	KUNIT_EXPECT_EQ(test, 123, answers[0]);
-	kfree(answers);
-
-	question = "a123";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
-	kfree(answers);
-
-	question = "12 35";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
-	for (i = 0; i < nr_integers; i++)
-		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
-	kfree(answers);
-
-	question = "12 35 46";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)3, nr_integers);
-	for (i = 0; i < nr_integers; i++)
-		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
-	kfree(answers);
-
-	question = "12 35 abc 46";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
-	for (i = 0; i < 2; i++)
-		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
-	kfree(answers);
-
-	question = "";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
-	kfree(answers);
-
-	question = "\n";
-	answers = str_to_ints(question, strlen(question), &nr_integers);
-	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
-	kfree(answers);
-}
-
-static void damon_dbgfs_test_set_targets(struct kunit *test)
-{
-	struct damon_ctx *ctx = dbgfs_new_ctx();
-	char buf[64];
-
-	if (!damon_is_registered_ops(DAMON_OPS_PADDR)) {
-		dbgfs_destroy_ctx(ctx);
-		kunit_skip(test, "PADDR not registered");
-	}
-
-	/* Make DAMON consider target has no pid */
-	damon_select_ops(ctx, DAMON_OPS_PADDR);
-
-	dbgfs_set_targets(ctx, 0, NULL);
-	sprint_target_ids(ctx, buf, 64);
-	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
-
-	dbgfs_set_targets(ctx, 1, NULL);
-	sprint_target_ids(ctx, buf, 64);
-	KUNIT_EXPECT_STREQ(test, (char *)buf, "42\n");
-
-	dbgfs_set_targets(ctx, 0, NULL);
-	sprint_target_ids(ctx, buf, 64);
-	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
-
-	dbgfs_destroy_ctx(ctx);
-}
-
-static void damon_dbgfs_test_set_init_regions(struct kunit *test)
-{
-	struct damon_ctx *ctx = damon_new_ctx();
-	/* Each line represents one region in ``<target idx> <start> <end>`` */
-	char * const valid_inputs[] = {"1 10 20\n 1   20 30\n1 35 45",
-		"1 10 20\n",
-		"1 10 20\n0 39 59\n0 70 134\n  1  20 25\n",
-		""};
-	/* Reading the file again will show sorted, clean output */
-	char * const valid_expects[] = {"1 10 20\n1 20 30\n1 35 45\n",
-		"1 10 20\n",
-		"0 39 59\n0 70 134\n1 10 20\n1 20 25\n",
-		""};
-	char * const invalid_inputs[] = {"3 10 20\n",	/* target not exists */
-		"1 10 20\n 1 14 26\n",		/* regions overlap */
-		"0 10 20\n1 30 40\n 0 5 8"};	/* not sorted by address */
-	char *input, *expect;
-	int i, rc;
-	char buf[256];
-
-	if (!damon_is_registered_ops(DAMON_OPS_PADDR)) {
-		damon_destroy_ctx(ctx);
-		kunit_skip(test, "PADDR not registered");
-	}
-
-	damon_select_ops(ctx, DAMON_OPS_PADDR);
-
-	dbgfs_set_targets(ctx, 3, NULL);
-
-	/* Put valid inputs and check the results */
-	for (i = 0; i < ARRAY_SIZE(valid_inputs); i++) {
-		input = valid_inputs[i];
-		expect = valid_expects[i];
-
-		rc = set_init_regions(ctx, input, strnlen(input, 256));
-		KUNIT_EXPECT_EQ(test, rc, 0);
-
-		memset(buf, 0, 256);
-		sprint_init_regions(ctx, buf, 256);
-
-		KUNIT_EXPECT_STREQ(test, (char *)buf, expect);
-	}
-	/* Put invalid inputs and check the return error code */
-	for (i = 0; i < ARRAY_SIZE(invalid_inputs); i++) {
-		input = invalid_inputs[i];
-		pr_info("input: %s\n", input);
-		rc = set_init_regions(ctx, input, strnlen(input, 256));
-		KUNIT_EXPECT_EQ(test, rc, -EINVAL);
-
-		memset(buf, 0, 256);
-		sprint_init_regions(ctx, buf, 256);
-
-		KUNIT_EXPECT_STREQ(test, (char *)buf, "");
-	}
-
-	dbgfs_set_targets(ctx, 0, NULL);
-	damon_destroy_ctx(ctx);
-}
-
-static struct kunit_case damon_test_cases[] = {
-	KUNIT_CASE(damon_dbgfs_test_str_to_ints),
-	KUNIT_CASE(damon_dbgfs_test_set_targets),
-	KUNIT_CASE(damon_dbgfs_test_set_init_regions),
-	{},
-};
-
-static struct kunit_suite damon_test_suite = {
-	.name = "damon-dbgfs",
-	.test_cases = damon_test_cases,
-};
-kunit_test_suite(damon_test_suite);
-
-#endif /* _DAMON_DBGFS_TEST_H */
-
-#endif	/* CONFIG_DAMON_KUNIT_TEST */
-- 
2.39.5

