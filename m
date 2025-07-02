Return-Path: <linux-kselftest+bounces-36306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D1AF12CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D6618988C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E2D260585;
	Wed,  2 Jul 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpOxNU2i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8E25487B;
	Wed,  2 Jul 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453788; cv=none; b=kPbJwIzwuy8HxcQGcByhIsV/Jg3kyjijt2tZnMnIjJMzdkxCnkZ5MworGVqd7Ud/7Q1LCubkthd6sCCjGRTEGjIAxhaaRRAODS9XrTnd4ma4YLRcAX48VE+kYkJwKyMMcenPoHnzpt4qQXK1tLTv4pT7gTInyRsDCr2rt6Mn5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453788; c=relaxed/simple;
	bh=1QQTqlYHUjewASmFh86Dd+jl+m64vZGkDAeB+lVVa3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9iBtf5WDx+bO9syp0fcG7k0CAvVy119E+LnzCzEf1YPpT4IQCquiIBbnwD/huz1ON5+WwslDqavkKf7Po2f4E23yHQ5TtK7m5Rb5nVphTmcWpFnPeNMCVHaESuSCT6iYCnRV81QzGAznDE5nktfSWSDu7Hrj/S+J+d6GcYF/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpOxNU2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6191BC4CEED;
	Wed,  2 Jul 2025 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751453788;
	bh=1QQTqlYHUjewASmFh86Dd+jl+m64vZGkDAeB+lVVa3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LpOxNU2iXlzUMjuDs+pwZoOkqTB/E4QcIqBMSsLbakjG3hsyBxa20RX+C9IXT8fUs
	 Es+pHBjSKppItfEyfevlMG0YSk5TfnX0VqGtJcriImj9JSCwkZXLBXZ3BesgKYc4Tl
	 FDB4rbzewqnK1rvn6G5FuYYRDleDXKSzipH+UJjxLBu08XAV7IDxEadc41VCiAdllk
	 LymXFS0xcd4VZw4ad1d4+91dnb57a6xf6f8LsDU+317YFEhT4kmERoooWzdFYs6bNG
	 nfC0xtOPiQs8HpnCC+yI8+6/yZ3WdwYbyqerk6gI26rufZbSTf7ZcEQ76Wtovu+XIq
	 8YJVSYrLAyPSA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 02 Jul 2025 11:39:11 +0100
Subject: [PATCH v18 6/8] selftests/clone3: Factor more of main loop into
 test_clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-clone3-shadow-stack-v18-6-7965d2b694db@kernel.org>
References: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
In-Reply-To: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1QQTqlYHUjewASmFh86Dd+jl+m64vZGkDAeB+lVVa3I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZRAuvvRb9vSY24fWNYftM0LX9zwuQimD4vpu5
 0gySvY5gNmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGUQLgAKCRAk1otyXVSH
 0FLlB/wO8Lb0XAEZWEHIGsXmrZmZrsbHbT1//ucOkd/A1nqah/KGorfMYY1rzfTftgel7oQflbB
 cHhOs195j/SH7OD1b1V9gyC8/pPltvTYJQGNtsjV+rLNpFD0L9qt1F8oCJF5/0CZUW3ryLVR5yh
 aAee6bLhrZ6bLRT9+V4DwzMQ1PDgR5KJoZ82l+4WvVg9Yx0lfv9dKkArgQpuF9ihWmxnsPV+f/g
 UREtX3aDsgnPytKIxAPxzw15+12ksGNhs4bKnOZHacZAT/+20TEuMFDVPB/qDnybvauWBa1sFaM
 GfhwUg3xgSXz1PCstdkmrXQ7Aklntu9pcJQ6Z2825TbS+5A0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to make it easier to add more configuration for the tests and
more support for runtime detection of when tests can be run pass the
structure describing the tests into test_clone3() rather than picking
the arguments out of it and have that function do all the per-test work.

No functional change.

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 77 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e61f07973ce5..e066b201fa64 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -30,6 +30,19 @@ enum test_mode {
 	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
 };
 
+typedef bool (*filter_function)(void);
+typedef size_t (*size_function)(void);
+
+struct test {
+	const char *name;
+	uint64_t flags;
+	size_t size;
+	size_function size_function;
+	int expected;
+	enum test_mode test_mode;
+	filter_function filter;
+};
+
 static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 {
 	struct __clone_args args = {
@@ -109,30 +122,40 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	return 0;
 }
 
-static bool test_clone3(uint64_t flags, size_t size, int expected,
-			enum test_mode test_mode)
+static void test_clone3(const struct test *test)
 {
+	size_t size;
 	int ret;
 
+	if (test->filter && test->filter()) {
+		ksft_test_result_skip("%s\n", test->name);
+		return;
+	}
+
+	if (test->size_function)
+		size = test->size_function();
+	else
+		size = test->size;
+
+	ksft_print_msg("Running test '%s'\n", test->name);
+
 	ksft_print_msg(
 		"[%d] Trying clone3() with flags %#" PRIx64 " (size %zu)\n",
-		getpid(), flags, size);
-	ret = call_clone3(flags, size, test_mode);
+		getpid(), test->flags, size);
+	ret = call_clone3(test->flags, size, test->test_mode);
 	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
-			getpid(), ret, expected);
-	if (ret != expected) {
+			getpid(), ret, test->expected);
+	if (ret != test->expected) {
 		ksft_print_msg(
 			"[%d] Result (%d) is different than expected (%d)\n",
-			getpid(), ret, expected);
-		return false;
+			getpid(), ret, test->expected);
+		ksft_test_result_fail("%s\n", test->name);
+		return;
 	}
 
-	return true;
+	ksft_test_result_pass("%s\n", test->name);
 }
 
-typedef bool (*filter_function)(void);
-typedef size_t (*size_function)(void);
-
 static bool not_root(void)
 {
 	if (getuid() != 0) {
@@ -160,16 +183,6 @@ static size_t page_size_plus_8(void)
 	return getpagesize() + 8;
 }
 
-struct test {
-	const char *name;
-	uint64_t flags;
-	size_t size;
-	size_function size_function;
-	int expected;
-	enum test_mode test_mode;
-	filter_function filter;
-};
-
 static const struct test tests[] = {
 	{
 		.name = "simple clone3()",
@@ -319,24 +332,8 @@ int main(int argc, char *argv[])
 	ksft_set_plan(ARRAY_SIZE(tests));
 	test_clone3_supported();
 
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (tests[i].filter && tests[i].filter()) {
-			ksft_test_result_skip("%s\n", tests[i].name);
-			continue;
-		}
-
-		if (tests[i].size_function)
-			size = tests[i].size_function();
-		else
-			size = tests[i].size;
-
-		ksft_print_msg("Running test '%s'\n", tests[i].name);
-
-		ksft_test_result(test_clone3(tests[i].flags, size,
-					     tests[i].expected,
-					     tests[i].test_mode),
-				 "%s\n", tests[i].name);
-	}
+	for (i = 0; i < ARRAY_SIZE(tests); i++)
+		test_clone3(&tests[i]);
 
 	ksft_finished();
 }

-- 
2.39.5


