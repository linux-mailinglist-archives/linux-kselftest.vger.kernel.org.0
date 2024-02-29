Return-Path: <linux-kselftest+bounces-5571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C886BDC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82ACA282468
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD823A8F3;
	Thu, 29 Feb 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgAQ9l80"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D83A264;
	Thu, 29 Feb 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168371; cv=none; b=R39PqiRxDRSUF72vNUPAY1P31FpSblccHyyJTkek5I/Tm07taiB298RVvXo7xTMeyHdmrP1S+T7/0NNA/M7jrRydrS8TCdEJTFhutIjESkv9NKi1192ZSOS5W0A2CFi+3h1+DDrN9u708Jq7TX4rtQkImeQMXD4ed52+r4aLF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168371; c=relaxed/simple;
	bh=1uzNaoOrtVsgyeQyEd2SsqCkXw4FwnFerhQ5aFrZi6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5gY1zy8X0n6exy8TlLI3Aff3WQifY/CvqB08nd6P6dsjqGKCUBPVHFtchElC+Fu+My9ldNjso5MCQ3uhRP2JyjBy+9WAQEV3GiFDVpINGoXqsmeVtYsAMIwK8NjtE1yaD8TnazB9EpvxVTxIW3IVQwcRRZUnj73MG1Bc/f8b3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgAQ9l80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D655C433F1;
	Thu, 29 Feb 2024 00:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168370;
	bh=1uzNaoOrtVsgyeQyEd2SsqCkXw4FwnFerhQ5aFrZi6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgAQ9l80B7H03f3KMAw+5/WzafKQAa844T7WyfFYxq1kx/fATm8iAtQaiqPjEExrz
	 2tc660aGzeZIaV4BSsdxjdrQxS/QnlquLivqJ5tW9+n4zWeGOIcpoGw5a1Er94RpXk
	 NtU3qHknYeLvvq6Ba7Os8r9cEGCdi3U+oHz6MDl4kiQ1chbUyOKWmddYfm4aHNoOez
	 DVWQ1UgWgI277apLF02gpnRCDV3TTsxKaQ/B+PJZn0Bu542iw+ivD9wWw8EXs/9dav
	 O9WZmtwdnFD8n56m4RHlU0CGCbUUokZz5wzQAaXrrKxmv3pQKORy6u5XlCGpp3j3V1
	 u8XtOUkCJeWvA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v4 06/12] selftests: kselftest_harness: use exit code to store skip
Date: Wed, 28 Feb 2024 16:59:13 -0800
Message-ID: <20240229005920.2407409-7-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We always use skip in combination with exit_code being 0
(KSFT_PASS). This are basic KSFT / KTAP semantics.
Store the right KSFT_* code in exit_code directly.

This makes it easier to support tests reporting other
extended KSFT_* codes like XFAIL / XPASS.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d90d4a9039ee..5a48177c8c00 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -128,8 +128,7 @@
 		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
-	_metadata->exit_code = KSFT_PASS; \
-	_metadata->skip = 1; \
+	_metadata->exit_code = KSFT_SKIP; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
@@ -387,7 +386,7 @@
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-			if (!__test_passed(_metadata) || _metadata->skip) \
+			if (_metadata->exit_code) \
 				return; \
 			_metadata->setup_completed = true; \
 			/* Use the same _metadata. */ \
@@ -837,7 +836,6 @@ struct __test_metadata {
 	struct __fixture_metadata *fixture;
 	int termsig;
 	int exit_code;
-	int skip;	/* did SKIP get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
@@ -944,9 +942,7 @@ void __wait_for_test(struct __test_metadata *t)
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == KSFT_SKIP) {
-			/* SKIP */
-			t->exit_code = KSFT_PASS;
-			t->skip = 1;
+			t->exit_code = WEXITSTATUS(status);
 		} else if (t->termsig != -1) {
 			t->exit_code = KSFT_FAIL;
 			fprintf(TH_LOG_STREAM,
@@ -1118,7 +1114,6 @@ void __run_test(struct __fixture_metadata *f,
 
 	/* reset test struct */
 	t->exit_code = KSFT_PASS;
-	t->skip = 0;
 	t->trigger = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
@@ -1138,18 +1133,14 @@ void __run_test(struct __fixture_metadata *f,
 	} else if (t->pid == 0) {
 		setpgrp();
 		t->fn(t, variant);
-		if (t->skip)
-			_exit(KSFT_SKIP);
-		if (__test_passed(t))
-			_exit(KSFT_PASS);
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
 	else
-- 
2.43.2


