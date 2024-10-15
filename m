Return-Path: <linux-kselftest+bounces-19770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF0699F481
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778A11C22ECA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAD2281F1;
	Tue, 15 Oct 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4lzcSy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C91FAF00;
	Tue, 15 Oct 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014868; cv=none; b=IoSbUYMJF0zOWYxgMMTzApHcmFK9sXsMCx+aY7jQMFZd1tTxkv+jEpnekt/HgAKgvuBpSi1TdWUxYLiD/u5M/j3/7Ztzuj+JOQiOuE55lrP+hQmRTDVT3rwxddL8OfSPVtmKg5VCcsI9T1t+C/VCqB9SmVraipvBmNV5h86FRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014868; c=relaxed/simple;
	bh=+5y1um4gitXtylrMffYca0ktxuX6uSb/9QDvMPQdSFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ohw5gUgo3tmXyz2Gf0HawovwapVigQM+sKPTvdPT8ai+rEWgkj/76EqG7dWHU5AMvFV7yohHTA+J8ukJv3S8mjIEQphOD+7Bc+b6hqIH0LepT22+jmSC0SjIfHo6NhICss1KLFVKTIm4E3wIORPpXB97JNqliONMEQ++PNgOe7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4lzcSy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35735C4CED5;
	Tue, 15 Oct 2024 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014868;
	bh=+5y1um4gitXtylrMffYca0ktxuX6uSb/9QDvMPQdSFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4lzcSy6i79Wom+pv+6s2P2i6bYMcG7Nytm2ZVcIpvbvyj4OzDLielOBUIofnAKNF
	 U7OWoBscoDYa5BrM03l8S593Wc8K+kuK8b5LjpVqNaFq9Dt2CvvQjeazjbhNdPTJ+P
	 e/HoNuKk6YdF6WmHd+YdwGC5BfPk0Opt7HVeq9cakKqLRgx+tY6I1URfS63q73dBIz
	 dDDHU7s6PovCqRo5CK/9wY8VHtWNJiVhGQA3u1/VZW0s31VUMZJY+W1Usz5xBW9Hn2
	 bW4FAmQ5Vrd7LPLEOyCplGqU4aNnVCG97BRUJE+vfUQNLY6+Krt5viH/WZn6w3nU4+
	 GnLLUsIxV676Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] mm/damon: remove DAMON debugfs interface kunit tests
Date: Tue, 15 Oct 2024 10:54:11 -0700
Message-Id: <20241015175412.60563-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015175412.60563-1-sj@kernel.org>
References: <20241015175412.60563-1-sj@kernel.org>
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
index 35b72f88983a..5ee5e62c0a1e 100644
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
index d2ecfcc8db86..000000000000
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
-#endif /* _DAMON_TEST_H */
-
-#endif	/* CONFIG_DAMON_KUNIT_TEST */
-- 
2.39.5


