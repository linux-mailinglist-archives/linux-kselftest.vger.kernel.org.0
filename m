Return-Path: <linux-kselftest+bounces-4825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F677857287
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA99028457B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8DDF4E;
	Fri, 16 Feb 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Y80cjI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF4DDC9;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043188; cv=none; b=nyqvpLYcEm0UymvxU89zWZGSeOJVbFVk1SlqlUKjHEd99nk2Dpn+vAotLs/7wY5xqI0dXPBUq1CXdvPZNKRdpQaXAWT90S6JoXuNDNNrznq6J8zqvVoeWbVvQsWbXNA7PPM7NDNihx+HdG3WGGLo5bF5c9EeXxe8SFD+B65ijIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043188; c=relaxed/simple;
	bh=q0xfZYAcm1JrBc0ZtQu1vUugWevh4kl+g+bxVxnZu5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdrPw4YC9TxhlEmFEYLbpLzeVQtqViXx9WSdYfEKjuXwTc1Fh6W+H4wyoLDRNjaHjeq75KyM6t4jFAkuBJzRnQkfd3Oel8LFuIBv5bI/ECCczOKYcQxRCi2yp/ipDE9KDsbS3agJAjQk+7F6dm5N7AQgv4q2M83dNhyC0IWwnyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Y80cjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A742C433C7;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708043187;
	bh=q0xfZYAcm1JrBc0ZtQu1vUugWevh4kl+g+bxVxnZu5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0Y80cjIpEEgB014f4Ifqv8iDjMEahxahTbzHblWOCBlPIQ71jBMY15QVlNc5RQkG
	 pGgghWoqFD49hW3s7pemcCORtT0RjfuDKjbsntjnPip5KkXm+QrAcmQpw36JMAJ9Ws
	 VhOBRXXrSSUjJRZj0gB68UJTLIGA4P9M2VLnuXGpxou5HadGW5OgXVmbuywrJJs1sx
	 9NZ2l25c6EgD2maNYTCOY9hIAPPG7Cai3AU8yE52f0iaJSHnER+dbDULSsk3pBPPKK
	 2hu9MFDIkCc7yueQ/+AM6ChGAkGNVbxTod7RAjCwCOb/hcmrhYZPBBIcWaYohgb+Db
	 pXPg0Q2mMXAfg==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/4] selftests: kselftest_harness: support using xfail
Date: Thu, 15 Feb 2024 16:26:18 -0800
Message-ID: <20240216002619.1999225-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216002619.1999225-1-kuba@kernel.org>
References: <20240216002619.1999225-1-kuba@kernel.org>
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

Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: fix alignment of the reason (remove one space after XFAIL)
---
 tools/testing/selftests/kselftest_harness.h | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 618b41eac749..04177813930b 100644
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
+		fprintf(TH_LOG_STREAM, "#      XFAIL     %s\n", \
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


