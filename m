Return-Path: <linux-kselftest+bounces-4830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052F8572AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED98AB233DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8B9443;
	Fri, 16 Feb 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guzd6/b0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C28BF6;
	Fri, 16 Feb 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044090; cv=none; b=oc5R4eCMhKoUgXtkKjKJKRf27R243qle6aiaHzz5i0fZSuCcmfkuTnJf0x3kfaqsOYRwONVyWeoi/vqm/nf4dqNAgXwtOgDckTWfy7pDLa07Kp3JVu8maVpoEBMze7pJqgKGK/8tY2f3UDbIYqTsQC4+LSlcK44JjixyzY/QcxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044090; c=relaxed/simple;
	bh=xut8vW9q8UtF2Rvvr2ccXXFedhbCgL5XgKPyM3C/aMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlWXp4cM86zUOinKhxVzVetqFhI3sH87Zs0rL0YfeJ3vpHJirbz0M4yYXMkH60FU/b4I860CghPID72h2kCxd27DSkbb6RfrKmPgMfuhiQkgV6DP8lT/H5b6k4C+aMr+QEnctMHl1LQl8zcKu6TV4GnXEyUa1/2JE+M4li94h8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guzd6/b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6ACC43390;
	Fri, 16 Feb 2024 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044090;
	bh=xut8vW9q8UtF2Rvvr2ccXXFedhbCgL5XgKPyM3C/aMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Guzd6/b0xlm2nC7VJTX/faz0yGWvCGFuKX9Awl1xdZuOzOfTbhmOldUBOE16PeOGX
	 51fFQwXS8c6XT8TK8iUwyOt9EIhm3MXvJ9FzrASMzUX9JZQ9DH57meLLVjxwb2kdZ3
	 qmxwBxN+W4wRQouA1l36efODmrnmPND5uwoL9eaZ5PR6awOPwdgKUxuQk7sv3lMwGq
	 XCWlfcOfdXeSliNIDBwaWO+lrK5hYKJKPM2Gumvnp9XThcjUenwH54Ih18h6Us7LwG
	 7X/WfAM0nxG+usG/5IJ776PCt9yyFfvbVWdNoqGgiuVCfKqe5gzvBz6GsWi7S10boZ
	 lIGit5XMErlRA==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 3/7] selftests: kselftest_harness: use exit code to store skip and xfail
Date: Thu, 15 Feb 2024 16:41:18 -0800
Message-ID: <20240216004122.2004689-4-kuba@kernel.org>
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

We always use skip / xfail with combination of exit_code being 0
(KSFT_PASS). This are just basic KSFT / KTAP semantics.
Store the right KSFT_* code in exit_code directly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 35 ++++++---------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 70366864ffd9..6923cd7060fc 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -136,8 +136,7 @@
 		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
-	_metadata->exit_code = KSFT_PASS; \
-	_metadata->skip = 1; \
+	_metadata->exit_code = KSFT_SKIP; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
@@ -163,8 +162,7 @@
 		fprintf(TH_LOG_STREAM, "#      XFAIL     %s\n", \
 			_metadata->results->reason); \
 	} \
-	_metadata->exit_code = KSFT_PASS; \
-	_metadata->xfail = 1; \
+	_metadata->exit_code = KSFT_XFAIL; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
@@ -416,7 +414,7 @@
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-			if (!__test_passed(_metadata) || _metadata->skip) \
+			if (_metadata->exit_code) \
 				return; \
 			_metadata->setup_completed = true; \
 			fixture_name##_##test_name(_metadata, &self, variant->data); \
@@ -861,8 +859,6 @@ struct __test_metadata {
 	struct __fixture_metadata *fixture;
 	int termsig;
 	int exit_code;
-	int skip;	/* did SKIP get used? */
-	int xfail;	/* did XFAIL get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
@@ -972,13 +968,9 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		if (WEXITSTATUS(status) == KSFT_SKIP) {
-			/* SKIP */
-			t->exit_code = KSFT_PASS;
-			t->skip = 1;
-		} else if (WEXITSTATUS(status) == KSFT_XFAIL) {
-			t->exit_code = KSFT_PASS;
-			t->xfail = 1;
+		if (WEXITSTATUS(status) == KSFT_SKIP ||
+		    WEXITSTATUS(status) == KSFT_XFAIL) {
+			t->exit_code = WEXITSTATUS(status);
 		} else if (t->termsig != -1) {
 			t->exit_code = KSFT_FAIL;
 			fprintf(TH_LOG_STREAM,
@@ -1151,8 +1143,6 @@ void __run_test(struct __fixture_metadata *f,
 
 	/* reset test struct */
 	t->exit_code = KSFT_PASS;
-	t->skip = 0;
-	t->xfail = 0;
 	t->trigger = 0;
 	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
@@ -1174,24 +1164,17 @@ void __run_test(struct __fixture_metadata *f,
 	} else if (t->pid == 0) {
 		setpgrp();
 		t->fn(t, variant);
-		if (t->skip)
-			_exit(KSFT_SKIP);
-		if (t->xfail)
-			_exit(KSFT_XFAIL);
-		if (__test_passed(t))
-			_exit(KSFT_PASS);
-		/* Something else happened. */
-		_exit(KSFT_FAIL);
+		_exit(t->exit_code);
 	} else {
 		__wait_for_test(t);
 	}
 	ksft_print_msg("         %4s  %s\n",
 		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
-	if (t->skip)
+	if (t->exit_code == KSFT_SKIP)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
 					t->results->reason : "unknown");
-	else if (t->xfail)
+	else if (t->exit_code == KSFT_XFAIL)
 		ksft_test_result_xfail("%s\n", t->results->reason[0] ?
 				       t->results->reason : "unknown");
 	else
-- 
2.43.0


