Return-Path: <linux-kselftest+bounces-46997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE40CA32BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 11:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84CA8300CBBF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DB2652AF;
	Thu,  4 Dec 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ZDVaWn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6972AD2B;
	Thu,  4 Dec 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843056; cv=none; b=uvMk1ZCmizPITpJ3e5Dc0jzzXbFeL2YrDSBkYiCqC1MS2CR8wYu53TLBUXNLNKEacwEQrfePRBUlEPDF3SbP2Y6MjkUBlnixr8cSoO0BvELv0B23NTVj1vJo22XNK2h4TbOv99Fh2v4CpxQIB44PwGSQc2v386Gajrv3SvOoATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843056; c=relaxed/simple;
	bh=W+clS00rh6o+CK8dUNq6CJ6eReX7flO1Jmkfq14wJZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OwRZgnli/h6CrjYrQcwQmRjdWBjcbehBgFzEpv/DWd5ygAdZEOil4QCXS+pP8A/xsiR3Bjj0pmZ/23roAZK8twVbZJFqEQXqrw9TwyYLdJH8C6KAlxTgwD2lFaVVDv07yr/K/ir4bFJbPBJhOs8Lzzoz3acPrAD3Nc7VJpDrB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ZDVaWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B11C4CEFB;
	Thu,  4 Dec 2025 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764843055;
	bh=W+clS00rh6o+CK8dUNq6CJ6eReX7flO1Jmkfq14wJZk=;
	h=From:To:Cc:Subject:Date:From;
	b=J2ZDVaWnMDisjRydrDibRGX23R+cAn/4+744Zrw5kk2bgh8z/hJTjzQFd2g2zj6wr
	 JkUcHtlpHon3k7KklPEH8WJsALonW2ceAJnvSwoZ5iYzXqssmWulrI/qsRUCqDSdmp
	 nbH1Hr8OHAVxZ76S+CziDoTewXiRCem10d5n+laI2cM9csRX+IxLP64MjgHrPoY4yo
	 s4nRlOJ1vNeAIxPDDKVlxfz+Y1yj9Veyvx5LnUTqegjn0WZftTByE5n9tbS4FrjGa2
	 vPOjRWmIPEqPlpKJ33IcCIIkbuhR4j/plpKm1sNZSq/uXFIpVBwRX3B44COL9FdWvv
	 dH14PVSCbHPhw==
From: Arnd Bergmann <arnd@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rae Moar <raemoar63@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Marie Zhussupova <marievic@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Carlos Llamas <cmllamas@google.com>,
	Ujwal Jain <ujwaljain@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: reduce stack usage in kunit_run_tests()
Date: Thu,  4 Dec 2025 11:10:46 +0100
Message-Id: <20251204101050.1035801-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Some of the recent changes to the kunit framework caused the stack usage
for kunit_run_tests() to grow higher than most other kernel functions,
which triggers a warning when CONFIG_FRAME_WARN is set to a relatively
low value:

lib/kunit/test.c: In function 'kunit_run_tests':
lib/kunit/test.c:801:1: error: the frame size of 1312 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Split out the inner loop into a separate function to ensure that each
function remains under the limit, and pass the kunit_result_stats
structures by reference to avoid excessive copies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sending it now as I ran into the build failure while testing 6.18.
I only build-tested this, so please test it properly before applying.
---
 lib/kunit/test.c | 221 ++++++++++++++++++++++++-----------------------
 1 file changed, 115 insertions(+), 106 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 62eb529824c6..c5fce199d880 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -94,7 +94,7 @@ struct kunit_result_stats {
 	unsigned long total;
 };
 
-static bool kunit_should_print_stats(struct kunit_result_stats stats)
+static bool kunit_should_print_stats(struct kunit_result_stats *stats)
 {
 	if (kunit_stats_enabled == 0)
 		return false;
@@ -102,11 +102,11 @@ static bool kunit_should_print_stats(struct kunit_result_stats stats)
 	if (kunit_stats_enabled == 2)
 		return true;
 
-	return (stats.total > 1);
+	return (stats->total > 1);
 }
 
 static void kunit_print_test_stats(struct kunit *test,
-				   struct kunit_result_stats stats)
+				   struct kunit_result_stats *stats)
 {
 	if (!kunit_should_print_stats(stats))
 		return;
@@ -115,10 +115,10 @@ static void kunit_print_test_stats(struct kunit *test,
 		  KUNIT_SUBTEST_INDENT
 		  "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
 		  test->name,
-		  stats.passed,
-		  stats.failed,
-		  stats.skipped,
-		  stats.total);
+		  stats->passed,
+		  stats->failed,
+		  stats->skipped,
+		  stats->total);
 }
 
 /* Append formatted message to log. */
@@ -600,26 +600,26 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 }
 
 static void kunit_print_suite_stats(struct kunit_suite *suite,
-				    struct kunit_result_stats suite_stats,
-				    struct kunit_result_stats param_stats)
+				    struct kunit_result_stats *suite_stats,
+				    struct kunit_result_stats *param_stats)
 {
 	if (kunit_should_print_stats(suite_stats)) {
 		kunit_log(KERN_INFO, suite,
 			  "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
 			  suite->name,
-			  suite_stats.passed,
-			  suite_stats.failed,
-			  suite_stats.skipped,
-			  suite_stats.total);
+			  suite_stats->passed,
+			  suite_stats->failed,
+			  suite_stats->skipped,
+			  suite_stats->total);
 	}
 
 	if (kunit_should_print_stats(param_stats)) {
 		kunit_log(KERN_INFO, suite,
 			  "# Totals: pass:%lu fail:%lu skip:%lu total:%lu",
-			  param_stats.passed,
-			  param_stats.failed,
-			  param_stats.skipped,
-			  param_stats.total);
+			  param_stats->passed,
+			  param_stats->failed,
+			  param_stats->skipped,
+			  param_stats->total);
 	}
 }
 
@@ -681,13 +681,106 @@ static void kunit_init_parent_param_test(struct kunit_case *test_case, struct ku
 	}
 }
 
-int kunit_run_tests(struct kunit_suite *suite)
+static int kunit_run_one_test(struct kunit_suite *suite, struct kunit_case *test_case,
+			      struct kunit_result_stats *suite_stats,
+			      struct kunit_result_stats *total_stats)
 {
+	struct kunit test = { .param_value = NULL, .param_index = 0 };
+	struct kunit_result_stats param_stats = { 0 };
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
+	const void *curr_param;
+
+	kunit_init_test(&test, test_case->name, test_case->log);
+	if (test_case->status == KUNIT_SKIPPED) {
+		/* Test marked as skip */
+		test.status = KUNIT_SKIPPED;
+		kunit_update_stats(&param_stats, test.status);
+	} else if (!test_case->generate_params) {
+		/* Non-parameterised test. */
+		test_case->status = KUNIT_SKIPPED;
+		kunit_run_case_catch_errors(suite, test_case, &test);
+		kunit_update_stats(&param_stats, test.status);
+	} else {
+		kunit_init_parent_param_test(test_case, &test);
+		if (test_case->status == KUNIT_FAILURE) {
+			kunit_update_stats(&param_stats, test.status);
+			goto test_case_end;
+		}
+		/* Get initial param. */
+		param_desc[0] = '\0';
+		/* TODO: Make generate_params try-catch */
+		curr_param = test_case->generate_params(&test, NULL, param_desc);
+		test_case->status = KUNIT_SKIPPED;
+		kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+			  "KTAP version 1\n");
+		kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+			  "# Subtest: %s", test_case->name);
+		if (test.params_array.params &&
+		    test_case->generate_params == kunit_array_gen_params) {
+			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT
+				  KUNIT_SUBTEST_INDENT "1..%zd\n",
+				  test.params_array.num_params);
+		}
+
+		while (curr_param) {
+			struct kunit param_test = {
+				.param_value = curr_param,
+				.param_index = ++test.param_index,
+				.parent = &test,
+			};
+			kunit_init_test(&param_test, test_case->name, NULL);
+			param_test.log = test_case->log;
+			kunit_run_case_catch_errors(suite, test_case, &param_test);
+
+			if (param_desc[0] == '\0') {
+				snprintf(param_desc, sizeof(param_desc),
+					 "param-%d", param_test.param_index);
+			}
+
+			kunit_print_ok_not_ok(&param_test, KUNIT_LEVEL_CASE_PARAM,
+					      param_test.status,
+					      param_test.param_index,
+					      param_desc,
+					      param_test.status_comment);
+
+			kunit_update_stats(&param_stats, param_test.status);
+
+			/* Get next param. */
+			param_desc[0] = '\0';
+			curr_param = test_case->generate_params(&test, curr_param,
+								param_desc);
+		}
+		/*
+		 * TODO: Put into a try catch. Since we don't need suite->exit
+		 * for it we can't reuse kunit_try_run_cleanup for this yet.
+		 */
+		if (test_case->param_exit)
+			test_case->param_exit(&test);
+		/* TODO: Put this kunit_cleanup into a try-catch. */
+		kunit_cleanup(&test);
+	}
+test_case_end:
+	kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
+
+	kunit_print_test_stats(&test, &param_stats);
+
+	kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case->status,
+			      kunit_test_case_num(suite, test_case),
+			      test_case->name,
+			      test.status_comment);
+
+	kunit_update_stats(suite_stats, test_case->status);
+	kunit_accumulate_stats(total_stats, param_stats);
+
+	return 0;
+}
+
+
+int kunit_run_tests(struct kunit_suite *suite)
+{
 	struct kunit_case *test_case;
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
-	const void *curr_param;
 
 	/* Taint the kernel so we know we've run tests. */
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
@@ -703,97 +796,13 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	kunit_print_suite_start(suite);
 
-	kunit_suite_for_each_test_case(suite, test_case) {
-		struct kunit test = { .param_value = NULL, .param_index = 0 };
-		struct kunit_result_stats param_stats = { 0 };
-
-		kunit_init_test(&test, test_case->name, test_case->log);
-		if (test_case->status == KUNIT_SKIPPED) {
-			/* Test marked as skip */
-			test.status = KUNIT_SKIPPED;
-			kunit_update_stats(&param_stats, test.status);
-		} else if (!test_case->generate_params) {
-			/* Non-parameterised test. */
-			test_case->status = KUNIT_SKIPPED;
-			kunit_run_case_catch_errors(suite, test_case, &test);
-			kunit_update_stats(&param_stats, test.status);
-		} else {
-			kunit_init_parent_param_test(test_case, &test);
-			if (test_case->status == KUNIT_FAILURE) {
-				kunit_update_stats(&param_stats, test.status);
-				goto test_case_end;
-			}
-			/* Get initial param. */
-			param_desc[0] = '\0';
-			/* TODO: Make generate_params try-catch */
-			curr_param = test_case->generate_params(&test, NULL, param_desc);
-			test_case->status = KUNIT_SKIPPED;
-			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-				  "KTAP version 1\n");
-			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-				  "# Subtest: %s", test_case->name);
-			if (test.params_array.params &&
-			    test_case->generate_params == kunit_array_gen_params) {
-				kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT
-					  KUNIT_SUBTEST_INDENT "1..%zd\n",
-					  test.params_array.num_params);
-			}
-
-			while (curr_param) {
-				struct kunit param_test = {
-					.param_value = curr_param,
-					.param_index = ++test.param_index,
-					.parent = &test,
-				};
-				kunit_init_test(&param_test, test_case->name, NULL);
-				param_test.log = test_case->log;
-				kunit_run_case_catch_errors(suite, test_case, &param_test);
-
-				if (param_desc[0] == '\0') {
-					snprintf(param_desc, sizeof(param_desc),
-						 "param-%d", param_test.param_index);
-				}
-
-				kunit_print_ok_not_ok(&param_test, KUNIT_LEVEL_CASE_PARAM,
-						      param_test.status,
-						      param_test.param_index,
-						      param_desc,
-						      param_test.status_comment);
-
-				kunit_update_stats(&param_stats, param_test.status);
-
-				/* Get next param. */
-				param_desc[0] = '\0';
-				curr_param = test_case->generate_params(&test, curr_param,
-									param_desc);
-			}
-			/*
-			 * TODO: Put into a try catch. Since we don't need suite->exit
-			 * for it we can't reuse kunit_try_run_cleanup for this yet.
-			 */
-			if (test_case->param_exit)
-				test_case->param_exit(&test);
-			/* TODO: Put this kunit_cleanup into a try-catch. */
-			kunit_cleanup(&test);
-		}
-test_case_end:
-		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
-
-		kunit_print_test_stats(&test, param_stats);
-
-		kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case->status,
-				      kunit_test_case_num(suite, test_case),
-				      test_case->name,
-				      test.status_comment);
-
-		kunit_update_stats(&suite_stats, test_case->status);
-		kunit_accumulate_stats(&total_stats, param_stats);
-	}
+	kunit_suite_for_each_test_case(suite, test_case)
+		kunit_run_one_test(suite, test_case, &suite_stats, &total_stats);
 
 	if (suite->suite_exit)
 		suite->suite_exit(suite);
 
-	kunit_print_suite_stats(suite, suite_stats, total_stats);
+	kunit_print_suite_stats(suite, &suite_stats, &total_stats);
 suite_end:
 	kunit_print_suite_end(suite);
 
-- 
2.39.5


