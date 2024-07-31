Return-Path: <linux-kselftest+bounces-14545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE5B942E12
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0921F23C9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9511B3723;
	Wed, 31 Jul 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hznVxISx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A11B1415;
	Wed, 31 Jul 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428380; cv=none; b=G6b3yz+63Wn8ymoixSffIwU0nQDR1560IQhSiJm/YHC5DjGG5SdQr8nXrc7n7xp7c8/vTlL+EELkozG/Bkap9G65BHNSbalyKdl9pynDVLX3xc6mikR2x6I3zebXv+D0WFRtppEVisJrkIlcJcJq8ozrm4VvxS8VXLZffTu4vEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428380; c=relaxed/simple;
	bh=7/H/C/HH1SlOixEC1xQKfbpAfSVTyHxGoHTFJYjOHFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0n8ablWGEXehek6aqiSadbb2C/KvCjtzOfu8isCLbubn9B2gQRt7wn3go6t+Peh4IMZMV4rEq8IChU/TBMCOSgCj8j9KTyBIgyumPDhh+X1p0IzuTAv6++78aw3O+wMe6VVH1iAeidzmuQBV7HxBI4NrDfHphNu9TrAKEviA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hznVxISx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D61C116B1;
	Wed, 31 Jul 2024 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428380;
	bh=7/H/C/HH1SlOixEC1xQKfbpAfSVTyHxGoHTFJYjOHFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hznVxISxqWW13+0irAYMoUjwm1sLRSt42tudUkBu2fsofwAtZ4KLaXXfyRQdIjH/g
	 f04bc+u6nddj8IcHdFgBs08LMFvF1IbBJl2+SLH9QRAgHfKwnfyOIrTKU0Fbtw2g/W
	 /QZE/2z2hUYfIfmi94EK7oTE0CYX3iwecC0OWyoc/rkFWPY36PejU+VPBKZHqq43Ai
	 B5FWEUog3UMvwRBLQbEtvUvsb2E1YJU2FVNCNgalrAzqOvEhtg+ON9QFynvY26Krn9
	 qNuvRrcjbLGLVNmL5s+PsebEENUKbfAHNHq4fVQDcxL3P7ROwDznBWNybbvGHcXVFu
	 4/vBzfX5G3xqw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 13:14:12 +0100
Subject: [PATCH RFT v7 6/9] selftests/clone3: Factor more of main loop into
 test_clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-clone3-shadow-stack-v7-6-a9532eebfb1d@kernel.org>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
In-Reply-To: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
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
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7/H/C/HH1SlOixEC1xQKfbpAfSVTyHxGoHTFJYjOHFU=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrRV2utLpdJ6Nz63cZ/UGP2aOf5oxZEELnbZlNTnL9w5rsvs
 teLrZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmMrmM/a+4bKRorkhj8QaBl49fFS
 1NXh318KPkNxXJajMWPbkUPp+Nagsvv6uZ8bFx+65m3hjedRs+qe0xXVOUJjv74OrnvcIq125KTjE5
 6XaI77Uk+3WTTP8u9U2GipfDlHO8zRWtejymSNoXHbmrcEpHgu/xvZlLLRmX1LCIdzh0mWWdn7pT7z
 rfrcNSrSxrond9C+njCjs8d7uWQlK07v9djt9XftJd/7xy5lOdvB/evGu+LPQTLa+yuKe+qX773cD8
 aBeJd7JXhcL/lItaZGwK9KmUFlcJOOPTopcTFTlPklFG9ZHcvx2PXQ/EMb4trZF8dGud7M+etYZ/mW
 xLK7S3OjUpBNxSWV+30M7veMwjAA==
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


