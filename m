Return-Path: <linux-kselftest+bounces-21254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE29B836C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D497C281D01
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797C1CBEBE;
	Thu, 31 Oct 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpVdezNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC121CBEA2;
	Thu, 31 Oct 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402771; cv=none; b=hQjgKoUdvuK+EZrWxNRtJxm4gnmudAzGJb/yE5DP3MwAz1HpMUXuah0z2Vu2OZdZjBzG4vGYV1tfWX8kmtBVcKd/wF1ug5HMMYs7FR+AcJkX4UjiXBxZg0oHOumeR5KLCOhYKciLzanRsK5dZN+aocQ3BvpjBgGKKWONfJly3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402771; c=relaxed/simple;
	bh=j9jnwN7QIwF8Sa670vD35tXnU821uhBBphCN7GNFItM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzd+lZyVkZhx2+YTmJXwJLnWcDLZMPyuoW/IXZX18xCwanp8s+wcIM6acGepNouegXLgHRM8CLNjgP0DeLW9I95LSMZVDAUWsfXgAy9RGYQJNMI4tFdK2fv01S232RiDuu+VC5e3Xcwb3czL0SkkbcuR/njBOBJPdDoY8SwDEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpVdezNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D25C4CED3;
	Thu, 31 Oct 2024 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402771;
	bh=j9jnwN7QIwF8Sa670vD35tXnU821uhBBphCN7GNFItM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hpVdezNiMUnkkHrXjvBCdIxDi2u4WTg1aQLS8xfaZu4PP2S5HUfty0PdjKhjOMFKj
	 HmmuQn3nKVA4PhctWFJvK7dXUGEznVI+YZRjcqyPtcsfYoJxzqGHsi5KzoBCpKLGCl
	 pm9qSBX2IdSm032mFUdR9S53PwQszGDkj5PSs9zQPyiuEuCs7GjPuW33+7epQBNSeR
	 VLRnBVSzc6+iLHxaKBKo4VK1rLgh4jZSuIdFt4vmxzpr8D+3q52aRLl1wEsFIrGFZE
	 AW29zlaMTNlYAyI0KB0Ro4fC5KGXM8md6JKUs2fN1Bka0wicSu/EVNgDhS4kMWvUpa
	 AxUlIfA4wfYIQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Oct 2024 19:25:07 +0000
Subject: [PATCH RFT v12 6/8] selftests/clone3: Factor more of main loop
 into test_clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-clone3-shadow-stack-v12-6-7183eb8bee17@kernel.org>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
In-Reply-To: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3987; i=broonie@kernel.org;
 h=from:subject:message-id; bh=j9jnwN7QIwF8Sa670vD35tXnU821uhBBphCN7GNFItM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnI9mmgavjqECBvaqHz1kIJVkO2qm1nFyXgABfHk5I
 kgj9NM+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyPZpgAKCRAk1otyXVSH0N/DB/
 9ATVoF3alwt3eVmQ8Um8Suzz0YvrXLrmgecAt2r6G3mVTAAJUozg3I0u40tS8MBo7uNuJ0QzHo0c0v
 5cLXhodFNsA0eXsc0YQ/deCrAzjSBPCuNmgYUz7F3H8Q7Xm/e97w3ztB8/N1DVwhUEt3tETKlqVCv9
 6+YcQMB6i6kWMFbOIC70avUG+pmZoyZi6JNUDqnUXG7MhKqgFnQxDquUJjmQSpyzXpkoyAsTjjythw
 qM98KjG7JX692xoMeU8+QW/b2cSy3w5jvngle2E5+zEhdB7mamqqh1YI55/JSzYt2pCGUDBuSpSQ3M
 xlj160BcevKOgvTRJd1fJh3ClHScRc
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


