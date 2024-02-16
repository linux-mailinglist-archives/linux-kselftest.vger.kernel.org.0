Return-Path: <linux-kselftest+bounces-4829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2F78572AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68961B232FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9537465;
	Fri, 16 Feb 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNajKiMw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EA610B;
	Fri, 16 Feb 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044090; cv=none; b=T5+eI3aPfRBKSWOpYfwlxz5X3SMhXLYe+LpJo+2iL3q6EzpYZx8IV3X/zFGVijWyJWnPCXDTfH9Q0Af7B0a6/bWnz9nUqNmyHokH5ABt1Vcclw2zdFwvtXApK7XeOAlrDpEp3/sJCIOVytYaX9ERIJRSA7G/JR2QG4sRZrFpR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044090; c=relaxed/simple;
	bh=e2kuTBmsiR1D/FUlHCgPsqYtv10XyO1EUJ92wvA5Gxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRO537uPp46lAMMerw4ERo54RkFH5hpPfRY9MmbO13Ji4UaBLLHYiYiwMQsHMI2wocRVBa1kzQijVE8UNU7QaLh2HN7qZj4zedoRQ4pZxRBuQ5qVdIvFWj0wHQhZLDSjl6BmAwJSWGnc//sWgTvSfZwI7wXRtWQ0xNDbxTjAfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNajKiMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31641C433F1;
	Fri, 16 Feb 2024 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044089;
	bh=e2kuTBmsiR1D/FUlHCgPsqYtv10XyO1EUJ92wvA5Gxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNajKiMwLHNJlBid360VpDgrYxD3/v5WYmVRy3a6asDQEoeWFl524xxYqQP4003i5
	 +q1ltiToBpdiiyQ2EfrW+3BeA8Kcv1mD1YwcGZCBWWyD846dhD6GPVluAXKO1uJWtD
	 p/dHfqRUD9dv74IQmXTm9rr5zjtD8ZZplQPn1TslkF8RprcaKJmhhj7nAADb+w4VJk
	 wZDNrd6O9Iltqthe230jsAjg8d271XqbPDc9AlDRXeZEbXrEaxsgLrrn4nwat7IbUK
	 kIXWwnjwg7AdlEFTLeEenBX7s7VZ2vbZPVDZ6XTVRP3WOK3oqp0Q2JyY0waNg9ZA4o
	 OChjR58ghUSAw==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 2/7] selftests: kselftest_harness: save full exit code in metadata
Date: Thu, 15 Feb 2024 16:41:17 -0800
Message-ID: <20240216004122.2004689-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216004122.2004689-1-kuba@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of tracking passed = 0/1 rename the field to exit_code
and invert the values so that they match the KSFT_* exit codes.
This will allow us to fold SKIP / XFAIL into the same value.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 52 ++++++++++++---------
 tools/testing/selftests/net/tls.c           |  2 +-
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b271cb721b81..70366864ffd9 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -136,7 +136,7 @@
 		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
-	_metadata->passed = 1; \
+	_metadata->exit_code = KSFT_PASS; \
 	_metadata->skip = 1; \
 	_metadata->trigger = 0; \
 	statement; \
@@ -163,7 +163,7 @@
 		fprintf(TH_LOG_STREAM, "#      XFAIL     %s\n", \
 			_metadata->results->reason); \
 	} \
-	_metadata->passed = 1; \
+	_metadata->exit_code = KSFT_PASS; \
 	_metadata->xfail = 1; \
 	_metadata->trigger = 0; \
 	statement; \
@@ -416,7 +416,7 @@
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-                       if (!_metadata->passed || _metadata->skip) \
+			if (!__test_passed(_metadata) || _metadata->skip) \
 				return; \
 			_metadata->setup_completed = true; \
 			fixture_name##_##test_name(_metadata, &self, variant->data); \
@@ -723,7 +723,7 @@
 			__bail(_assert, _metadata))
 
 #define __INC_STEP(_metadata) \
-	if (_metadata->passed) \
+	if (__test_passed(_metadata))	\
 		_metadata->results->step++;
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
@@ -769,7 +769,7 @@
 			break; \
 			} \
 		} \
-		_metadata->passed = 0; \
+		_metadata->exit_code = KSFT_FAIL; \
 		/* Ensure the optional handler is triggered */ \
 		_metadata->trigger = 1; \
 	} \
@@ -781,7 +781,7 @@
 	if (_assert) __INC_STEP(_metadata); \
 	if (!(strcmp(__exp, __seen) _t 0))  { \
 		__TH_LOG("Expected '%s' %s '%s'.", __exp, #_t, __seen); \
-		_metadata->passed = 0; \
+		_metadata->exit_code = KSFT_FAIL; \
 		_metadata->trigger = 1; \
 	} \
 } while (0); OPTIONAL_HANDLER(_assert)
@@ -860,7 +860,7 @@ struct __test_metadata {
 	pid_t pid;	/* pid of test when being run */
 	struct __fixture_metadata *fixture;
 	int termsig;
-	int passed;
+	int exit_code;
 	int skip;	/* did SKIP get used? */
 	int xfail;	/* did XFAIL get used? */
 	int trigger; /* extra handler after the evaluation */
@@ -874,6 +874,12 @@ struct __test_metadata {
 	struct __test_metadata *prev, *next;
 };
 
+static inline bool __test_passed(struct __test_metadata *metadata)
+{
+	return metadata->exit_code != KSFT_FAIL &&
+	       metadata->exit_code <= KSFT_SKIP;
+}
+
 /*
  * Since constructors are called in reverse order, reverse the test
  * list so tests are run in source declaration order.
@@ -941,7 +947,7 @@ void __wait_for_test(struct __test_metadata *t)
 	int status;
 
 	if (sigaction(SIGALRM, &action, &saved_action)) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: unable to install SIGALRM handler\n",
 			t->name);
@@ -953,7 +959,7 @@ void __wait_for_test(struct __test_metadata *t)
 	waitpid(t->pid, &status, 0);
 	alarm(0);
 	if (sigaction(SIGALRM, &saved_action, NULL)) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: unable to uninstall SIGALRM handler\n",
 			t->name);
@@ -962,19 +968,19 @@ void __wait_for_test(struct __test_metadata *t)
 	__active_test = NULL;
 
 	if (t->timed_out) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == KSFT_SKIP) {
 			/* SKIP */
-			t->passed = 1;
+			t->exit_code = KSFT_PASS;
 			t->skip = 1;
 		} else if (WEXITSTATUS(status) == KSFT_XFAIL) {
-			t->passed = 1;
+			t->exit_code = KSFT_PASS;
 			t->xfail = 1;
 		} else if (t->termsig != -1) {
-			t->passed = 0;
+			t->exit_code = KSFT_FAIL;
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test exited normally instead of by signal (code: %d)\n",
 				t->name,
@@ -983,11 +989,11 @@ void __wait_for_test(struct __test_metadata *t)
 			switch (WEXITSTATUS(status)) {
 			/* Success */
 			case KSFT_PASS:
-				t->passed = 1;
+				t->exit_code = KSFT_PASS;
 				break;
 			/* Other failure, assume step report. */
 			default:
-				t->passed = 0;
+				t->exit_code = KSFT_FAIL;
 				fprintf(TH_LOG_STREAM,
 					"# %s: Test failed at step #%d\n",
 					t->name,
@@ -995,13 +1001,13 @@ void __wait_for_test(struct __test_metadata *t)
 			}
 		}
 	} else if (WIFSIGNALED(status)) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		if (WTERMSIG(status) == SIGABRT) {
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test terminated by assertion\n",
 				t->name);
 		} else if (WTERMSIG(status) == t->termsig) {
-			t->passed = 1;
+			t->exit_code = KSFT_PASS;
 		} else {
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test terminated unexpectedly by signal %d\n",
@@ -1144,7 +1150,7 @@ void __run_test(struct __fixture_metadata *f,
 	char test_name[LINE_MAX];
 
 	/* reset test struct */
-	t->passed = 1;
+	t->exit_code = KSFT_PASS;
 	t->skip = 0;
 	t->xfail = 0;
 	t->trigger = 0;
@@ -1164,7 +1170,7 @@ void __run_test(struct __fixture_metadata *f,
 	t->pid = fork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 	} else if (t->pid == 0) {
 		setpgrp();
 		t->fn(t, variant);
@@ -1172,7 +1178,7 @@ void __run_test(struct __fixture_metadata *f,
 			_exit(KSFT_SKIP);
 		if (t->xfail)
 			_exit(KSFT_XFAIL);
-		if (t->passed)
+		if (__test_passed(t))
 			_exit(KSFT_PASS);
 		/* Something else happened. */
 		_exit(KSFT_FAIL);
@@ -1180,7 +1186,7 @@ void __run_test(struct __fixture_metadata *f,
 		__wait_for_test(t);
 	}
 	ksft_print_msg("         %4s  %s\n",
-		       t->passed ? "OK" : "FAIL", test_name);
+		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
 	if (t->skip)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
@@ -1189,7 +1195,7 @@ void __run_test(struct __fixture_metadata *f,
 		ksft_test_result_xfail("%s\n", t->results->reason[0] ?
 				       t->results->reason : "unknown");
 	else
-		ksft_test_result(t->passed, "%s\n", test_name);
+		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
@@ -1237,7 +1243,7 @@ static int test_harness_run(int argc, char **argv)
 				t->results = results;
 				__run_test(f, v, t);
 				t->results = NULL;
-				if (t->passed)
+				if (__test_passed(t))
 					pass_count++;
 				else
 					ret = 1;
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 49c84602707f..046d1ccedcf3 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1882,7 +1882,7 @@ TEST_F(tls_err, poll_partial_rec_async)
 		pfd.events = POLLIN;
 		EXPECT_EQ(poll(&pfd, 1, 20), 1);
 
-		exit(!_metadata->passed);
+		exit(!__test_passed(_metadata));
 	}
 }
 
-- 
2.43.0


