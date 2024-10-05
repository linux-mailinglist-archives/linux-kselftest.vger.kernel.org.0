Return-Path: <linux-kselftest+bounces-19097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0413991617
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4608AB22D5E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5546C14B955;
	Sat,  5 Oct 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZZU0CaJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299141494BB;
	Sat,  5 Oct 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124401; cv=none; b=NoPW5YqyXY5WBXx4lspeWcIb67Pnh8ohY9g0+ZfAUXEJytEh5PqIFlw1Xn8RmIuHvbqwSgIVLVnFkFYhEdtvIQaoNZW3uryPjLciLk5eLShwtPiJIgqoo4NOclgIA+EOfavDZhyoO6G2a9svr7UqpVwNY5V9fVstaSjeql2nZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124401; c=relaxed/simple;
	bh=LVU4JnnFHFfKZn1aEt9WAigE6w0bsSGfbUSfCpk5ySk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYqO/NP9kH+VNLsmhNJEbJDtvbp6XKuO5BkAo3/O0xbO6ECcgvz1YH72w/1afvBtPdVknyQgeildvJwpltEWWsQOTC0l7rpdlmO1svpW23kOusTELqUDwjW7yfMPEPcHH8SbhPWmM2WqLabh5wgYTU1ZVORz0QMhE+KszgBsgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZZU0CaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4324C4CED0;
	Sat,  5 Oct 2024 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124400;
	bh=LVU4JnnFHFfKZn1aEt9WAigE6w0bsSGfbUSfCpk5ySk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CZZU0CaJP2ew4t7MuxgIQKW6bSouDYCLI3l8B1pYyE9WtJlKiZHRpUCukfKduH1QG
	 k0ZuOxJGM//cpOFF1DchQwDGtPnEYqEzsnBTHJePM8tAfWtwnAHPViFZw9uiySeqT1
	 /8mB0erbeX9L2iNsas+rjdMJdiKlp76ajtcZIqKxJRqunRZPqMH+lx7z5e8qOJmm8c
	 yAGcVWA2M8SpQ/XGn2o+IaYvegUoFqC2DcDNCsoTt8n750XV4oqFV+QjFJ2ecwWyuG
	 dQNlvaesfg47RYI+rMn+JFEjH887ww6auzTjpIg4nSA9rY2WuswjCIw/V5ogW5Tz5Z
	 ZCui7XedNRjRw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:31:33 +0100
Subject: [PATCH RFT v11 6/8] selftests/clone3: Factor more of main loop
 into test_clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-clone3-shadow-stack-v11-6-2a6a2bd6d651@kernel.org>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
In-Reply-To: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
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
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LVU4JnnFHFfKZn1aEt9WAigE6w0bsSGfbUSfCpk5ySk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARW/VhhjUlbX0fxRUJgMvr+uR0UKHQSJCU74PU08
 zIB0tWSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEVvwAKCRAk1otyXVSH0Hw/B/
 9M9BeGoI+88rQnmdjz/ISliuB6oBHtfxhf5WK5KN75ApcnsrpA5XilHXkIBjRMMAe+1fbd7BKa5IQR
 5t8AanP1Oqjp51i1OLO1DmLfun7keM3MWqZF/UZydMyt9rAh1mEVcMBQ98XrTWSHf5FDHs+PeBtQui
 UR8ISvw7EK9Q7cc7Bu3cnOLPY4cgNrW6oYq4UHJWAuUyttCpd+ThHhBkTuo6uFB2KsGc4Z1HYG2Iu/
 whz1p4rSF897DbvbgSNmXfXsIjcnGiomHf5UgHgrJHQDDYf0syvUCKUvRY7QyiipGqr3lWq7nf3zkK
 8s43dfIjjI6zTsi8hpCXn4CWujFb3F
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 77 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e61f07973ce5e27aff30047b35e03b1b51875c15..e066b201fa64eb17c55939b7cec18ac5d109613b 100644
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
2.39.2


