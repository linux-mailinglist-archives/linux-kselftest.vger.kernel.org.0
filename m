Return-Path: <linux-kselftest+bounces-346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463F7F21C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDF4282350
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5053B797;
	Mon, 20 Nov 2023 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbNb1lAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926D3B78E;
	Mon, 20 Nov 2023 23:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18A9C43395;
	Mon, 20 Nov 2023 23:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524545;
	bh=bhar0tJdOqw54YK6iRyaAGbYhafIqhucm+rmgUHLm6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sbNb1lAPsl6sDP/tWTQu1Rz0P0N22caWVrWtkm3Aupuki5R4MDTEbkjYRahtzKnOp
	 TS49D15rjqBO0dPJbSNGnGxF5WjrIm1DaF5b3wz0fjJzxf4EGe2kvzjAnxutMwAQre
	 qMpXITiZa0Ph1fxYBdtmvH5ZC0BAn5zjNqzFHDpJKryoPazMVvrGBpFG385YEStdGm
	 3NuQQFBvOAoKPmuWRe1zOB7/vOjL92hbyR3zYD73bZcnnOjR6TTe+j0hCCzNFZzhD9
	 G+2y/dBRXHDY27ZToDMrBXHB3Y46mDlUNgekAxTuQReGSZMnHo2OiCi5/0p2G3QPM8
	 Gxa/esUVawgAQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 20 Nov 2023 23:54:31 +0000
Subject: [PATCH RFT v3 3/5] selftests/clone3: Factor more of main loop into
 test_clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-clone3-shadow-stack-v3-3-a7b8ed3e2acc@kernel.org>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
In-Reply-To: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 jannh@google.com, bsegall@google.com, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bhar0tJdOqw54YK6iRyaAGbYhafIqhucm+rmgUHLm6s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlW/HgP5b6BhRuIr5G+HNtIoh396YxC2fEVDwlQCIA
 cfRuecyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVvx4AAKCRAk1otyXVSH0PX3CA
 CCEnfkUPFFpPUROq1L+Sp+FJRBtKQh0aJtXZwE3SQa+n2gOmuE3MpcL3rJcHB235Z0jZslOsN9gJyx
 OJVFm3V3YY+HKUAXtH8DnZrmDui9hTfX3WgmIyBvSvq0Ygg08gWSb8SghG5HJjzGaejdY6DpUwcrnC
 sIuxAZqX4FDzlS4VOM8ngVUsFhetDIsLIYTRYjW2fc4MCMwhmzyyRg251AaNOfiyCC/JQ3tpzc3uym
 jo+P8kQHpoNzsBPMgyNIJX+EO/xQjz5+caORTxjYNSJin+eQZzAV6ByNPtgdNxV+LdB3vpOCSzJ++Z
 rKJV3rfuFANlis6xKG1tYF5s/ZI5NN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to make it easier to add more configuration for the tests and
more support for runtime detection of when tests can be run pass the
structure describing the tests into test_clone3() rather than picking
the arguments out of it and have that function do all the per-test work.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 77 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 3c9bf0cd82a8..1108bd8e36d6 100644
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
@@ -104,30 +117,40 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
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
@@ -155,16 +178,6 @@ static size_t page_size_plus_8(void)
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
@@ -314,24 +327,8 @@ int main(int argc, char *argv[])
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
2.30.2


