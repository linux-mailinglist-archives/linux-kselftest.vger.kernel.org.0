Return-Path: <linux-kselftest+bounces-43196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E7BDE95B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3699548451E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236632C331;
	Wed, 15 Oct 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3mrvmUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558632A3D8;
	Wed, 15 Oct 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533141; cv=none; b=RvBqnAoC8uSUT2m1MdfYdYC/TgW5wS3MMeN1XNPz816zNBQsy5uIBFu+auaUN++0nRVxeDezKDDSmS5t/+Kz7HotdAxpI2+0O10jfOcPiqHtSGHhQFa+4eRcrmqq8WXv3EuKBHFhw3/sTXKx5jdHfNbmEEm26QtF5VWL77IrmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533141; c=relaxed/simple;
	bh=tAuylQj+jXMT0ulfEEiUYEaHrJIDwHN10sPhMMvpM2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvQJmjvzjxOm4SulsG4qzhHuDMEdbA8gGR2OecPzUsizMS/Gnt9WeiQJq+SmUSpk4mxOXbUrwuy2tn4lp0DsX8hfHtHOVPzarPE7PrI2kqSmn8gyQ5877Xn7nG/+OJnIhPu1C9BebRN6Sp50PIxn396oRDMYw34JMxzt+gqHa+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3mrvmUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AB4C116D0;
	Wed, 15 Oct 2025 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533141;
	bh=tAuylQj+jXMT0ulfEEiUYEaHrJIDwHN10sPhMMvpM2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a3mrvmUq8OILXUrWHusIPjsq34F1FxWcWaEPk9dhrulUeBin5wPdro/JeUunimAuj
	 FWIf8fyUsAyCvw27St/V56fChcGgVFFp1C7LvScX8/iYsAsajNf5ubE7iJKA+eG3GN
	 2m3olklq4x2678/OthFXHSD0y39Zw3I21LyYCi1Pw9ROEMz8u9F0Mt/4oBfvtv8MeG
	 shM2C/XBCmcPWlcyfZWeqGbewo2xO7VWyVyb3J0+D7sh/daeXROAsjpfCCkOppa3e7
	 iGDVBdGLVUeXRtCh23sSCCf6XeHSWZU9b3V3P+yanJennDcCDPMrZjaRNbpoqH9UCZ
	 kQGYt4aSH81Tg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:49:10 +0100
Subject: [PATCH v22 6/8] selftests/clone3: Factor more of main loop into
 test_clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clone3-shadow-stack-v22-6-a8c8da011427@kernel.org>
References: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
In-Reply-To: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 CarlosO'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Rich Felker <dalias@libc.org>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3987; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tAuylQj+jXMT0ulfEEiUYEaHrJIDwHN10sPhMMvpM2c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75pjfQ2D++L0pXfWB0RXIC5VTjj7yviEjJ6JY
 PmCoSO06XKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+aYwAKCRAk1otyXVSH
 0GIbB/wIAZBNc18z6EWOOlp6pWgZ3VszqpS0OWXnTL30mEDU1hJkeXS15tGzev2PEVKAC/ICS+7
 /eZxRN2UDbvBMKyNrV2T4MaC0MIIS1tz+oDzApK9AT7i6sk51RQW298CNmHiGMtZXhcvPrnD3I1
 +P4BeyVjTSWe/+v6I/zxmCIA3HzYMMbZDE0WqPE2/WIASXlA0tV1svijmi1QEZWl7WoiB7CUnoZ
 Do7ppxb+1EgOJk7gfmkVLcr1KM+N+oGABwWUfx2cMdeyXbjUaK9VSSvbPmHelcN9hpVe0EQdATH
 DCaLhAZpng81ezg0hiAtfvIab82J0iUv3M/wUQ0+6gvOsbvn
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
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
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
2.47.2


