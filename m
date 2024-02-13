Return-Path: <linux-kselftest+bounces-4561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F3A8534FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10828282CB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E05F472;
	Tue, 13 Feb 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HobfjhiS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCD5EE99;
	Tue, 13 Feb 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839060; cv=none; b=m1g9LwPJ64pVwyRWBqDsFwpGE7vDkBkBT7rw4UkeV/4eBjAT5niGNnPgMafbUDrRaxdq+gS/J8ioo/chc7LBKcKxR3wTOLmPjgN03Xsl3MrMIaCXa5In/GC+QEzG4pyV7hhceuUZXDe9js4tIM50b0IBjZhaSDanmVT+Pi/CANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839060; c=relaxed/simple;
	bh=66lbYemSeo/z/BA8V+4KaUAc3y7UkVFfQzDup/HIMJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjB3gDAuFN1wHVHgWvL5pzQ0a3gVMieKRqFt8zaEDhSDD/DWVvwkwZTPE3aCVHIiPWDkFn8nyK+Lhu3/GCKFggMChNgWHp7VvPLrTEWu8K95vqeaGGxJjPXRGrxwN8quEVV/X48u2eLFhNjKd8Dhtuwbrl/MI7dp57V/yoi6//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HobfjhiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2041EC43142;
	Tue, 13 Feb 2024 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839060;
	bh=66lbYemSeo/z/BA8V+4KaUAc3y7UkVFfQzDup/HIMJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HobfjhiSo8VKk5y5IdW6aAAbsAQEg5yVBwQ7647ntZ2lQS3/UxNEwRbo7Oco7Kow4
	 job6poI0rvA+ghR7LU9CqOmAZPKpnV0LUowNHfiGEMV72zW5xfKQd5h/0xSDGbhUUj
	 DzeO3hPy+EWR55EricgzS4BWqUz8VK1Relm8DuE0a3QsLrNV7h40Jn4WqMwA9UHHAT
	 ur4bhu+2nqqrfluXM7J1aSDK+HFB+gzKpZIVR1Lj5n3+qhOXWUSTEKoyE8mpm2xWlT
	 zM37YebpdBJ4um8aZFSeGEK9pF7s77OHNf5w6y/ynjE53xt1RHvxDfcT02XAtH1D8g
	 DkkQ2OuhxQcxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] selftests: kselftest_harness: support using xfail
Date: Tue, 13 Feb 2024 07:44:15 -0800
Message-ID: <20240213154416.422739-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213154416.422739-1-kuba@kernel.org>
References: <20240213154416.422739-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Selftest summary includes XFAIL but there's no way to use
it from within the harness. Support it in a similar way to skip.

Currently tests report skip for things they expect to fail
e.g. when given combination of parameters is known to be unsupported.
This is confusing because in an ideal environment and fully featured
kernel no tests should be skipped.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 618b41eac749..561a817117f9 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -141,6 +141,33 @@
 	statement; \
 } while (0)
 
+/**
+ * XFAIL()
+ *
+ * @statement: statement to run after reporting XFAIL
+ * @fmt: format string
+ * @...: optional arguments
+ *
+ * .. code-block:: c
+ *
+ *     XFAIL(statement, fmt, ...);
+ *
+ * This forces a "pass" after reporting why something is expected to fail,
+ * and runs "statement", which is usually "return" or "goto skip".
+ */
+#define XFAIL(statement, fmt, ...) do { \
+	snprintf(_metadata->results->reason, \
+		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
+	if (TH_LOG_ENABLED) { \
+		fprintf(TH_LOG_STREAM, "#      XFAIL      %s\n", \
+			_metadata->results->reason); \
+	} \
+	_metadata->passed = 1; \
+	_metadata->xfail = 1; \
+	_metadata->trigger = 0; \
+	statement; \
+} while (0)
+
 /**
  * TEST() - Defines the test function and creates the registration
  * stub
@@ -834,6 +861,7 @@ struct __test_metadata {
 	int termsig;
 	int passed;
 	int skip;	/* did SKIP get used? */
+	int xfail;	/* did XFAIL get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
@@ -941,6 +969,9 @@ void __wait_for_test(struct __test_metadata *t)
 			/* SKIP */
 			t->passed = 1;
 			t->skip = 1;
+		} else if (WEXITSTATUS(status) == KSFT_XFAIL) {
+			t->passed = 1;
+			t->xfail = 1;
 		} else if (t->termsig != -1) {
 			t->passed = 0;
 			fprintf(TH_LOG_STREAM,
@@ -1112,6 +1143,7 @@ void __run_test(struct __fixture_metadata *f,
 	/* reset test struct */
 	t->passed = 1;
 	t->skip = 0;
+	t->xfail = 0;
 	t->trigger = 0;
 	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
@@ -1133,6 +1165,8 @@ void __run_test(struct __fixture_metadata *f,
 		t->fn(t, variant);
 		if (t->skip)
 			_exit(KSFT_SKIP);
+		if (t->xfail)
+			_exit(KSFT_XFAIL);
 		if (t->passed)
 			_exit(KSFT_PASS);
 		/* Something else happened. */
@@ -1146,6 +1180,9 @@ void __run_test(struct __fixture_metadata *f,
 	if (t->skip)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
 					t->results->reason : "unknown");
+	else if (t->xfail)
+		ksft_test_result_xfail("%s\n", t->results->reason[0] ?
+				       t->results->reason : "unknown");
 	else
 		ksft_test_result(t->passed, "%s%s%s.%s\n",
 			f->name, variant->name[0] ? "." : "", variant->name, t->name);
-- 
2.43.0


