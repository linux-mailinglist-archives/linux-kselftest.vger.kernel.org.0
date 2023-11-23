Return-Path: <linux-kselftest+bounces-476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EADE7F5CC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 11:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43541F20F08
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA322337;
	Thu, 23 Nov 2023 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI/Xmvpd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9E21359
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F69C433CA;
	Thu, 23 Nov 2023 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700736361;
	bh=f9ztNUYk0shaQOX+D23ktWQugMWIRfK4+eA+oTSsXGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eI/XmvpdUGIKVIljR1uNg7lSHWoUbl5bJR0mHGl4rwF1AP5ZXT1IiNHUrQ5IW3QQO
	 JD0JkR5AwR+gsIoZqo58gzLzD82MCFCTGu9XAUYK6iEnW0QgMeiDc7YmcyTCkeWzE+
	 XsB8VL3APR8qtSykPR6QKQnGlbNzxnZYwYi97YnwFAgX80ujQYQXGMu3CvhmeiBAqC
	 hlaNy295jJuYyaBKT96rRPtr74mpum6kebrElNJ9Qn0BKLLfyOUwLwnEgO3U0xaGo2
	 F6D9VUOnsiwh8gv0L1GH+PJa4dQvwsBLDrdarg7Q9KI4uecJS8vj6sOCPC4R26YnCI
	 8303Qcnf5UGGg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 23 Nov 2023 10:45:47 +0000
Subject: [PATCH 1/3] kselftest/vDSO: Make test name reporting for
 vdso_abi_test tooling friendly
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-kselftest-vdso-test-name-v1-1-1b30441c422b@kernel.org>
References: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
In-Reply-To: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6296; i=broonie@kernel.org;
 h=from:subject:message-id; bh=f9ztNUYk0shaQOX+D23ktWQugMWIRfK4+eA+oTSsXGU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXy1kG3DQ6TV+c1qw4FsNHIPg58Uw/Cx4iRvul
 tx/bsQhG5OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV8tZAAKCRAk1otyXVSH
 0At/B/42TjILXbyY8E1rRvJ5D96OjQqagGrgBmJA7LhtJ3SEGmEyR7QdmSyMubkCEqOHisghGmX
 CPfEkzAyjE78nHVa94OpZ5x6MVgqQGorCGqvQOoGV8mms+Pat/7Kig44EVGQCv23M/ONtqba9ev
 sPA4OJkABYAtMHx0KuDgWPdAeUV6vWBYKbFF5Tn6lCvYAA4chN68yvqORYawLDfNk3q8AcIrbv/
 a8P+2R9Ed4H6NzSnbumrHLA5UfRipRnF+gCz6LWWnHr7NUlSmVvmLlO+Q2+mnZXR0RGy4oyLfae
 apnrTghMtWRaNQlqGMEN47nAdAjf1OnlBnT6qCMUJCOCo1V+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The test results from vdso_abi_test are all formatted using a series of
macros:

  #define VDSO_TEST_PASS_MSG()	"\n%s(): PASS\n", __func__
  #define VDSO_TEST_FAIL_MSG(x)	"\n%s(): %s FAIL\n", __func__, x
  #define VDSO_TEST_SKIP_MSG(x)	"\n%s(): SKIP: Could not find %s\n", __func__, x

which don't play nicely with automated KTAP parsers since the actual KTAP
lines are in the form

   ok 1

with no test name and we get an additional log line such as

  vdso_test_gettimeofday(): PASS

with no preceeding # as KTAP requires. The lack of a test name means that
many automation systems will have a hard time distinguishing between the
different tests or correlating results between runs, the lack of # is less
severe but could potentially cause confusion.

Fix these issues by rewriting all the result reporting to include both the
vDSO function name being tested and (where there is one) the name of the
clock being tested in the main KTAP line. Since we have tests both with and
without a specific clock we abandon the helper macros and just put the
format strings used directly in the ksft_ API calls. When we fail to look
up the relevant vDSO symbol we add a separate print statement explaining
why the skip is being done. This gives output such as:

  ok 1 __vdso_gettimeofday
  # clock_id: CLOCK_REALTIME
  # The time is 1700673118.58091596
  ok 2 __vdso_clock_gettime CLOCK_REALTIME

which is much easier for test automation to work with.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 66 +++++++++++++++-------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 883ca85424bc..b304abae6e8f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -33,9 +33,20 @@ typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
 
-#define VDSO_TEST_PASS_MSG()	"\n%s(): PASS\n", __func__
-#define VDSO_TEST_FAIL_MSG(x)	"\n%s(): %s FAIL\n", __func__, x
-#define VDSO_TEST_SKIP_MSG(x)	"\n%s(): SKIP: Could not find %s\n", __func__, x
+const char *vdso_clock_name[12] = {
+	"CLOCK_REALTIME",
+	"CLOCK_MONOTONIC",
+	"CLOCK_PROCESS_CPUTIME_ID",
+	"CLOCK_THREAD_CPUTIME_ID",
+	"CLOCK_MONOTONIC_RAW",
+	"CLOCK_REALTIME_COARSE",
+	"CLOCK_MONOTONIC_COARSE",
+	"CLOCK_BOOTTIME",
+	"CLOCK_REALTIME_ALARM",
+	"CLOCK_BOOTTIME_ALARM",
+	"CLOCK_SGI_CYCLE",
+	"CLOCK_TAI",
+};
 
 static void vdso_test_gettimeofday(void)
 {
@@ -44,7 +55,8 @@ static void vdso_test_gettimeofday(void)
 		(vdso_gettimeofday_t)vdso_sym(version, name[0]);
 
 	if (!vdso_gettimeofday) {
-		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[0]));
+		ksft_print_msg("Couldn't find %s\n", name[0]);
+		ksft_test_result_skip("%s\n", name[0]);
 		return;
 	}
 
@@ -54,9 +66,9 @@ static void vdso_test_gettimeofday(void)
 	if (ret == 0) {
 		ksft_print_msg("The time is %lld.%06lld\n",
 			       (long long)tv.tv_sec, (long long)tv.tv_usec);
-		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
+		ksft_test_result_pass("%s\n", name[0]);
 	} else {
-		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[0]));
+		ksft_test_result_fail("%s\n", name[0]);
 	}
 }
 
@@ -67,7 +79,9 @@ static void vdso_test_clock_gettime(clockid_t clk_id)
 		(vdso_clock_gettime_t)vdso_sym(version, name[1]);
 
 	if (!vdso_clock_gettime) {
-		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[1]));
+		ksft_print_msg("Couldn't find %s\n", name[1]);
+		ksft_test_result_skip("%s %s\n", name[1],
+				      vdso_clock_name[clk_id]);
 		return;
 	}
 
@@ -77,9 +91,11 @@ static void vdso_test_clock_gettime(clockid_t clk_id)
 	if (ret == 0) {
 		ksft_print_msg("The time is %lld.%06lld\n",
 			       (long long)ts.tv_sec, (long long)ts.tv_nsec);
-		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
+		ksft_test_result_pass("%s %s\n", name[1],
+				      vdso_clock_name[clk_id]);
 	} else {
-		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[1]));
+		ksft_test_result_fail("%s %s\n", name[1],
+				      vdso_clock_name[clk_id]);
 	}
 }
 
@@ -90,7 +106,8 @@ static void vdso_test_time(void)
 		(vdso_time_t)vdso_sym(version, name[2]);
 
 	if (!vdso_time) {
-		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[2]));
+		ksft_print_msg("Couldn't find %s\n", name[2]);
+		ksft_test_result_skip("%s\n", name[2]);
 		return;
 	}
 
@@ -99,9 +116,9 @@ static void vdso_test_time(void)
 	if (ret > 0) {
 		ksft_print_msg("The time in hours since January 1, 1970 is %lld\n",
 				(long long)(ret / 3600));
-		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
+		ksft_test_result_pass("%s\n", name[2]);
 	} else {
-		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[2]));
+		ksft_test_result_fail("%s\n", name[2]);
 	}
 }
 
@@ -114,7 +131,9 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 		(vdso_clock_getres_t)vdso_sym(version, name[3]);
 
 	if (!vdso_clock_getres) {
-		ksft_test_result_skip(VDSO_TEST_SKIP_MSG(name[3]));
+		ksft_print_msg("Couldn't find %s\n", name[3]);
+		ksft_test_result_skip("%s %s\n", name[3],
+				      vdso_clock_name[clk_id]);
 		return;
 	}
 
@@ -137,27 +156,14 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 		clock_getres_fail++;
 
 	if (clock_getres_fail > 0) {
-		ksft_test_result_fail(VDSO_TEST_FAIL_MSG(name[3]));
+		ksft_test_result_fail("%s %s\n", name[3],
+				      vdso_clock_name[clk_id]);
 	} else {
-		ksft_test_result_pass(VDSO_TEST_PASS_MSG());
+		ksft_test_result_pass("%s %s\n", name[3],
+				      vdso_clock_name[clk_id]);
 	}
 }
 
-const char *vdso_clock_name[12] = {
-	"CLOCK_REALTIME",
-	"CLOCK_MONOTONIC",
-	"CLOCK_PROCESS_CPUTIME_ID",
-	"CLOCK_THREAD_CPUTIME_ID",
-	"CLOCK_MONOTONIC_RAW",
-	"CLOCK_REALTIME_COARSE",
-	"CLOCK_MONOTONIC_COARSE",
-	"CLOCK_BOOTTIME",
-	"CLOCK_REALTIME_ALARM",
-	"CLOCK_BOOTTIME_ALARM",
-	"CLOCK_SGI_CYCLE",
-	"CLOCK_TAI",
-};
-
 /*
  * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
  * with different values for clock_id.

-- 
2.39.2


