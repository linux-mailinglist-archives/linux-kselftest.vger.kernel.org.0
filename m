Return-Path: <linux-kselftest+bounces-5060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9385C497
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67046B25596
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875BD14A4F2;
	Tue, 20 Feb 2024 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSf2H14R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582BA14A4EA;
	Tue, 20 Feb 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456967; cv=none; b=WMtASy8T+SEOYTKg3l58XU0qCpGsRCmWpftlNbB5AB1/h1Gj2UXNATvS7fNfTHqlSGQeCaw+UY049TgwHK5sbVg3Q5M3HpqphfA+gAERay1uebYqpmbPKIkM1r1BBU2cxcafL3kluALEXTAzNclCQzu8Rl6MiW9ObQL8SZGzrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456967; c=relaxed/simple;
	bh=QFefN2pMJk3wF8CJAX8FXQUW7G2GGo/zUOy3/fKo+Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uo7Rf5YReXukZC3kz+UfcD28orZ+sMbmrmDuIasdKUI5syU/Mth0bKPJ/nsT02DjppJv4SJc6jFGV8VU+W94kFBp4BYVHkCaWo2HV4ba8TIKEjG/28r5bgq65WBQCDliR2aCBH/WvBWJ4nA65/PRCZioDMfNjVMmzNIMrgclvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSf2H14R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FF2C433F1;
	Tue, 20 Feb 2024 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456966;
	bh=QFefN2pMJk3wF8CJAX8FXQUW7G2GGo/zUOy3/fKo+Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSf2H14R17b9wRAMRCwaQoK+jbbx2y3e+w5Tbf9VJWWb01idSvCdAmZhRrVcNjNVP
	 53XUW4IwJajjIVl+Br3A2gD0lDYB7UkDvloq31KYtO+qC4W192NjM0N58eOBpcXLLu
	 GkPCW1ahPTAcMsu1Dm9JChB9GfJL2r3O2Z5RJ1ak03jaCQW/1rVed7MvjYW/+8f9Xn
	 J4Rgj6mm3tWdXG1gc58dsZujxzgqxIr5mWnysBjwStQH34MK6Xr7M6ZafOzH/si971
	 RT1gpFcQ4tjPOpFBgXFyF1oTjPAAzkNVp9oYVC7586gIa3YNvVGk+8uxlijXo0s65V
	 n16xlKAX/LeCg==
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
	Jakub Kicinski <kuba@kernel.org>,
	luto@amacapital.net,
	wad@chromium.org
Subject: [PATCH net-next v3 01/11] selftests: kselftest_harness: pass step via shared memory
Date: Tue, 20 Feb 2024 11:22:25 -0800
Message-ID: <20240220192235.2953484-2-kuba@kernel.org>
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

Commit 0ef67a888375 ("selftests/harness: Report skip reason")
added shared memory to communicate between harness and test.
Use that instead of exit codes to send the failing step back
to the harness. The exit codes are limited and because of
the step passing we can't use the full range of KSFT_* exit
codes.

Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mic@digikod.net
CC: luto@amacapital.net
CC: wad@chromium.org
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: linux-security-module@vger.kernel.org
---
 tools/testing/selftests/kselftest_harness.h | 21 ++++++++++-----------
 tools/testing/selftests/landlock/common.h   |  5 ++---
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index e05ac8261046..98bdedf9a53a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -101,8 +101,8 @@
  * ASSERT_* number for which the test failed.  This behavior can be enabled by
  * writing `_metadata->no_print = true;` before the check sequence that is
  * unable to print.  When an error occur, instead of printing an error message
- * and calling `abort(3)`, the test process call `_exit(2)` with the assert
- * number as argument, which is then printed by the parent process.
+ * and calling `abort(3)`, the test process call `_exit(2)` and pass the error
+ * to be printed to the parent process via shared memory.
  */
 #define TH_LOG(fmt, ...) do { \
 	if (TH_LOG_ENABLED) \
@@ -695,9 +695,8 @@
 			__bail(_assert, _metadata))
 
 #define __INC_STEP(_metadata) \
-	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
-	if (_metadata->passed && _metadata->step < 253) \
-		_metadata->step++;
+	if (_metadata->passed) \
+		_metadata->results->step++;
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
 
@@ -784,6 +783,7 @@
 
 struct __test_results {
 	char reason[1024];	/* Reason for test result */
+	unsigned int step;	/* Test step reached without failure */
 };
 
 struct __test_metadata;
@@ -837,7 +837,6 @@ struct __test_metadata {
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
-	__u8 step;
 	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool setup_completed; /* did setup finish? */
@@ -875,7 +874,7 @@ static inline void __test_check_assert(struct __test_metadata *t)
 {
 	if (t->aborted) {
 		if (t->no_print)
-			_exit(t->step);
+			_exit(1);
 		abort();
 	}
 }
@@ -960,7 +959,7 @@ void __wait_for_test(struct __test_metadata *t)
 				fprintf(TH_LOG_STREAM,
 					"# %s: Test failed at step #%d\n",
 					t->name,
-					WEXITSTATUS(status));
+					t->results->step);
 			}
 		}
 	} else if (WIFSIGNALED(status)) {
@@ -1114,9 +1113,9 @@ void __run_test(struct __fixture_metadata *f,
 	t->passed = 1;
 	t->skip = 0;
 	t->trigger = 0;
-	t->step = 1;
 	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
+	t->results->step = 1;
 
 	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
@@ -1137,8 +1136,8 @@ void __run_test(struct __fixture_metadata *f,
 		/* Pass is exit 0 */
 		if (t->passed)
 			_exit(0);
-		/* Something else happened, report the step. */
-		_exit(t->step);
+		/* Something else happened. */
+		_exit(1);
 	} else {
 		__wait_for_test(t);
 	}
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index e64bbdf0e86e..c15e22abdca6 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -50,13 +50,13 @@
 				_exit(255); \
 			if (_metadata->passed) \
 				_exit(0); \
-			_exit(_metadata->step); \
+			_exit(1); \
 		} \
 		if (child != waitpid(child, &status, 0)) \
 			abort(); \
 		if (WIFSIGNALED(status) || !WIFEXITED(status)) { \
 			_metadata->passed = 0; \
-			_metadata->step = 1; \
+			_metadata->results->step = 1; \
 			return; \
 		} \
 		switch (WEXITSTATUS(status)) { \
@@ -69,7 +69,6 @@
 			break; \
 		default: \
 			_metadata->passed = 0; \
-			_metadata->step = WEXITSTATUS(status); \
 			break; \
 		} \
 	} \
-- 
2.43.0


