Return-Path: <linux-kselftest+bounces-15015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5694B8D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D9E1C2420F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08B189F47;
	Thu,  8 Aug 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AatM9F6b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678A13A257;
	Thu,  8 Aug 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105046; cv=none; b=ik9mPatcVglIpRZxtJu0MjwRuUQggpUilFU8kx2S7CLfpt79VZb+T1UpX04tVcCoygv5e/Pv3y99vJH91PYmUIV93ogPmaB47iguWR8RrT7ZkD0DMvnZ7AV5eG0LpIZxhjAvpfbKHhmB9ipoth6DYja2ZxJV5ngK12KOuIXAC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105046; c=relaxed/simple;
	bh=7/H/C/HH1SlOixEC1xQKfbpAfSVTyHxGoHTFJYjOHFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJXSkGPK3hHCDRVyv+TuUE9MzwtXnkPlE7Gtjx24HSWitHbEjhq+1oeTAAUDEmrpLUW6dbxiUYsnSGfe1ZTaSPr4/mmU3jbUGVynW91ciW/b5NC7oi+eWriZMRhp2CNT8LCGQk8+8tlMdh51yZkUvLxhMKQyolRKK1knQMofVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AatM9F6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC00CC4AF0E;
	Thu,  8 Aug 2024 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105045;
	bh=7/H/C/HH1SlOixEC1xQKfbpAfSVTyHxGoHTFJYjOHFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AatM9F6bCADmFPxDYcw3fPa1prj4qk1v31nd9m0WoEBnSPDULGz2JM0GKcupTknaA
	 GwiJi4NW3+gT40+G5PtAtF/T9ZVPmo9JpI42t4mzWyTLsfuEl3akjMCXlQ8gmbUeKN
	 jx/kcOBFXKZ3QH2T7rCPcXPLGGx95ERTma5ND0nn8poJtCyWOaoUkWw6HVgpF5cHxG
	 hNvlSJc20/rLDwqHzdx9gwW9+xnCjF2XqzxEqM6X7rJRM3v8s4OhUFyGCaQZbH7890
	 T7BvSTccwUpRSPG8weCDwOBzLFgRsGus1t9P/juENW1QI7S4lttS0RLj4wkQjudv8p
	 d3I6SAyHOQGzA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:27 +0100
Subject: [PATCH RFT v8 6/9] selftests/clone3: Factor more of main loop into
 test_clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-6-0acf37caf14c@kernel.org>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
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
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7/H/C/HH1SlOixEC1xQKfbpAfSVTyHxGoHTFJYjOHFU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7OMIOFhZcKbpqWyVPtzy49PCLYFvlCTzKuX
 SFQ1V7DpHGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+zgAKCRAk1otyXVSH
 0C+IB/95vcpDhMNfYhPu4Jtz5ePuw1yFBHLrvHKojGre7hCSZHKQSitYqpizhcZTZtbDRUnS7dm
 cROfKCw18JFdQCzINVF7GhF6EJfF/81bQAXhyo4xY2leQ3sE3XxXgXAfksiNJpUsu3icPco038i
 cTNOlNq7kTSikxuryipDMkAmYBEjuavhgHbpHmjdf0Lw3TqW+vOAcUN0zQKGhi+LAkc4gK+GIWt
 5fxLiDrYenqnvNnPVze/OOHYH83DaPsx4yRTpZKT6ZAh6V4TJkYc731ta4TGEZeVekqliz9gtwP
 mJ11Ze0tXJagBjO4Bn1gV4c3HzpolgEhP06xK+DdNhFfUMRS
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
2.39.2


