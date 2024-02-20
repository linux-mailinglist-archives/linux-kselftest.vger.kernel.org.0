Return-Path: <linux-kselftest+bounces-5069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B4A85C4B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291191F25279
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16FC14F9DB;
	Tue, 20 Feb 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnSZVadW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB614F9D1;
	Tue, 20 Feb 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456972; cv=none; b=u56Q1bOGPhtdrwQRWzLZ3M3jW8sXbSvzudCW86yaf4aGNsOt0M7S9wsa914b20AqdvaXMixRBvcEMoK6jgKkAg09o05fGtvyCZwAqtvpTkA9LSWV0arTx74ahPzZr7bfCnOdmsN781rF8zUHkhr5RUBAJKjSph9H/1/9kGUzAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456972; c=relaxed/simple;
	bh=iaTH+1eL2/uaHAafS7u7tUseHm4TKZG3irvM72NEE70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0CqWHLvuVJMpOzcujPg2fgQp9bziy1cLacZBP+p9qT/8k5QsrqNymXNx3R/XDNNoazJUPMp0p/pwVOZCNMRjvoxFQUyLHCGxKc/EpsK6xJgtCx38edzQmRS7tiXOtXm+a6CjZc/Byy8XKCEJlImMWlFxXXUX3f3GzG87iFbX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnSZVadW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F99C433F1;
	Tue, 20 Feb 2024 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456972;
	bh=iaTH+1eL2/uaHAafS7u7tUseHm4TKZG3irvM72NEE70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnSZVadWji5OkYzZQTP7VCnbRbccg5d67G7P3fM9hYE3evZ1Cmq63VmEfOnRpBQyh
	 8okX26jifCJfo0OVWrKliWzXZGLufAc989+0wwBc0llm0pE7Nh4Ifo0F+lhlqA7zfb
	 3lNlh765Veli1etyB2PLx5CcNOtmmbM+xkO/IQXpR7FesoPmmMo5hAROsF3GhdgxaU
	 DDU0aPKh8lIfx7TH1IrCjE+aF4qkPuxtsZFhmzA37EvHruu+dE7jtKd5uZ1S+L0/c4
	 h9cwWX3oBtGSRzQhYh1BTB1ZPO9cxH30qkKWZMmcTTDQ0XS3kAbiQPMgErW/LgWnQc
	 2IhkwHPf3jqYA==
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
Subject: [PATCH net-next v3 10/11] selftests: kselftest_harness: support using xfail
Date: Tue, 20 Feb 2024 11:22:34 -0800
Message-ID: <20240220192235.2953484-11-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently some tests report skip for things they expect to fail
e.g. when given combination of parameters is known to be unsupported.
This is confusing because in an ideal test environment and fully
featured kernel no tests should be skipped.

Selftest summary line already includes xfail and xpass counters,
e.g.:

but there's no way to use it from within the harness.

Add a new per-fixture+variant combination list of test cases
we expect to fail.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3: change the paradigm to declarative
---
 tools/testing/selftests/kselftest_harness.h | 49 ++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 7c3d19bf4220..1ade9fac0b5f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -800,6 +800,37 @@ struct __fixture_metadata {
 	.prev = &_fixture_global,
 };
 
+struct __test_xfail {
+	struct __fixture_metadata *fixture;
+	struct __fixture_variant_metadata *variant;
+	struct __test_metadata *test;
+	struct __test_xfail *prev, *next;
+};
+
+/**
+ * XFAIL_ADD() - mark variant + test case combination as expected to fail
+ * @fixture_name: name of the fixture
+ * @variant_name: name of the variant
+ * @test_name: name of the test case
+ *
+ * Mark a combination of variant + test case for a given fixture as expected
+ * to fail. Tests marked this way will report XPASS / XFAIL return codes,
+ * instead of PASS / FAIL,and use respective counters.
+ */
+#define XFAIL_ADD(fixture_name, variant_name, test_name) \
+	static struct __test_xfail \
+		_##fixture_name##_##variant_name##_##test_name##_xfail = \
+	{ \
+		.fixture = &_##fixture_name##_fixture_object, \
+		.variant = &_##fixture_name##_##variant_name##_object, \
+		.test = &_##fixture_name##_##test_name##_object, \
+	}; \
+	static void __attribute__((constructor)) \
+		_register_##fixture_name##_##variant_name##_##test_name##_xfail(void) \
+	{ \
+		__register_xfail(&_##fixture_name##_##variant_name##_##test_name##_xfail); \
+	}
+
 static struct __fixture_metadata *__fixture_list = &_fixture_global;
 static int __constructor_order;
 
@@ -814,6 +845,7 @@ static inline void __register_fixture(struct __fixture_metadata *f)
 struct __fixture_variant_metadata {
 	const char *name;
 	const void *data;
+	struct __test_xfail *xfails;
 	struct __fixture_variant_metadata *prev, *next;
 };
 
@@ -864,6 +896,11 @@ static inline void __register_test(struct __test_metadata *t)
 	__LIST_APPEND(t->fixture->tests, t);
 }
 
+static inline void __register_xfail(struct __test_xfail *xf)
+{
+	__LIST_APPEND(xf->variant->xfails, xf);
+}
+
 static inline int __bail(int for_realz, struct __test_metadata *t)
 {
 	/* if this is ASSERT, return immediately. */
@@ -942,7 +979,9 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		if (WEXITSTATUS(status) == KSFT_SKIP) {
+		if (WEXITSTATUS(status) == KSFT_SKIP ||
+		    WEXITSTATUS(status) == KSFT_XPASS ||
+		    WEXITSTATUS(status) == KSFT_XFAIL) {
 			t->exit_code = WEXITSTATUS(status);
 		} else if (t->termsig != -1) {
 			t->exit_code = KSFT_FAIL;
@@ -1112,6 +1151,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __fixture_variant_metadata *variant,
 		struct __test_metadata *t)
 {
+	struct __test_xfail *xfail;
 	char test_name[LINE_MAX];
 	const char *diagnostic;
 
@@ -1145,6 +1185,13 @@ void __run_test(struct __fixture_metadata *f,
 	ksft_print_msg("         %4s  %s\n",
 		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
+	/* Check if we're expecting this test to fail */
+	for (xfail = variant->xfails; xfail; xfail = xfail->next)
+		if (xfail->test == t)
+			break;
+	if (xfail)
+		t->exit_code = __test_passed(t) ? KSFT_XPASS : KSFT_XFAIL;
+
 	if (t->results->reason[0])
 		diagnostic = t->results->reason;
 	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
-- 
2.43.0


