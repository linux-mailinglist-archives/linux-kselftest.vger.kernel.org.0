Return-Path: <linux-kselftest+bounces-5576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529E386BDCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8331B1C24313
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A69D4085A;
	Thu, 29 Feb 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy8WOSgp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A013EA88;
	Thu, 29 Feb 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168374; cv=none; b=oQkRg8vtAKJwvcRrOP0OCU9b8cOdd5nTa0DxR2QBd2/SbQ8rh9aApVO1yV+DcCGI7ccXU3vrPMYWthNs8ETCNn+VWCxkqK2k58Rq1RxH4dF271IZgwRDtxEmDO5faS53FluPcSrWShr1zjlMn2rOw7m2lCtMxNZQECc/O2DGVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168374; c=relaxed/simple;
	bh=jwhW1TkA3MbOALZnEwQYVt60KQ7UyC35+HlF5r2Rhao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPy+uFOzFwcGua0Al2gJ3WVh88LKc2bZ+D2cPowGexBTvtvHhGaScJ6EDkW+UuXsp2xYlUXt5J9MvHE8PEJiWY1iwMefriXN7E1LQMBcLUFybsrYL9bKdCMDcPOBglDrRGYWelDN5XlP6B44vXROCOYq+TCSGJ4J7962zzW4GDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy8WOSgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210EFC43390;
	Thu, 29 Feb 2024 00:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168373;
	bh=jwhW1TkA3MbOALZnEwQYVt60KQ7UyC35+HlF5r2Rhao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fy8WOSgpTofaV0Ijy0uCQVHKP1ygyaNp5Z5DIkD6YYtiXzLbaDaW5e8y8OsNJB0cF
	 9RGmQ3wLkqN22pbdIIkQ9Q+JZ6mtFC46juyLY84G1L552VRSUJwnbaJVbHuBEFssWJ
	 aiVJw61NktxzfWBj4DepkAXPAcd6mg2zFz8Fg9+qwCPf8wDsJRMAoI4RotPsrmmLRj
	 OUa78ve1vjpsmr0T2EeU2Zz07BjkVKJD6YwS8l5jN1RPAgZ4f/JsTA20EizXv5WKyd
	 HvY0/jt+6mh8peb7w0F4HsRCUbVtB4DxZtHCqvdq4dLcXfVxMWIg9GImW4BqqLtxf4
	 mhVvmTR3ZAB0w==
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
Subject: [PATCH v4 11/12] selftests: kselftest_harness: support using xfail
Date: Wed, 28 Feb 2024 16:59:18 -0800
Message-ID: <20240229005920.2407409-12-kuba@kernel.org>
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

Currently some tests report skip for things they expect to fail
e.g. when given combination of parameters is known to be unsupported.
This is confusing because in an ideal test environment and fully
featured kernel no tests should be skipped.

Selftest summary line already includes xfail and xpass counters,
e.g.:

  Totals: pass:725 fail:0 xfail:0 xpass:0 skip:0 error:0

but there's no way to use it from within the harness.

Add a new per-fixture+variant combination list of test cases
we expect to fail.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3: change the paradigm to declarative
---
 tools/testing/selftests/kselftest_harness.h | 49 ++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b643a577f9e1..634be793ad58 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -803,6 +803,37 @@ struct __fixture_metadata {
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
 
@@ -817,6 +848,7 @@ static inline void __register_fixture(struct __fixture_metadata *f)
 struct __fixture_variant_metadata {
 	const char *name;
 	const void *data;
+	struct __test_xfail *xfails;
 	struct __fixture_variant_metadata *prev, *next;
 };
 
@@ -866,6 +898,11 @@ static inline void __register_test(struct __test_metadata *t)
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
@@ -941,7 +978,9 @@ void __wait_for_test(struct __test_metadata *t)
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
@@ -1110,6 +1149,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __fixture_variant_metadata *variant,
 		struct __test_metadata *t)
 {
+	struct __test_xfail *xfail;
 	char test_name[LINE_MAX];
 	const char *diagnostic;
 
@@ -1141,6 +1181,13 @@ void __run_test(struct __fixture_metadata *f,
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
2.43.2


