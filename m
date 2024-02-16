Return-Path: <linux-kselftest+bounces-4823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBC857283
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CF01C22C81
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75257D299;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSYkKIRa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E413D27A;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043187; cv=none; b=FGidxqBLfSNRG5YDA/R1ZXZuVgsxrUXmkl1OwCBp4JiPxFSZD8vw69FCGfmLJdGairyKZLQGuSb8OrxOpOsriNv2dSIdf8NvXZrpy8fQJra9VSddWDKtZS9XzogBNg5NC72bdvKcHoRca8We/OBSEwSSp4OA+M3vNs5h+Pb2JDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043187; c=relaxed/simple;
	bh=kwKiBDztizT5PCVWWAAG283qr1ciUc48zykcpGO4k4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swe8nB3pX8RAXlvmOibcbh4jg0/651dcKVm8P1wRgYJ/eYsv+Eo816Loy13Vz2RDoqVEvPaQWv1tdJMwKkyE+ZCg7Yis+zSCiwKmXfCffe2l2Qrfq+0OTqgkMEEcd8wpJwcRtbPycFKB9+jtOOg6cLISmQzrZDOclJxlZjzFN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSYkKIRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88186C43394;
	Fri, 16 Feb 2024 00:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708043186;
	bh=kwKiBDztizT5PCVWWAAG283qr1ciUc48zykcpGO4k4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSYkKIRamH3krFkv7JiYq7zq6EXz05FkTvsaxvObNuMKfib8usTRH3ulz5iAubYlm
	 IHDmdM9z6vAjXUDDAjQmuZP3dQl8/Sv0gH6S7DpmntPKluo2HjUz7Now4Ut9Bcxpe+
	 kkER8qSC1rpGMbLSZPJUM2gbwK78thmPmPiBufw0Ij+pNlkj3MtgOX5HrlibajoH9K
	 8640IMFWLpTSbpfhdl7HwOBKYmx/64lUrC+UvkFXBAxObNoHZryx0vP6aQHJbcUr7c
	 EULIfzlq6Fr96b+vJSBogYWn/O9Z6qHzRpVdsxI6xJ+5fAz6xpiA9B+8CMpDfeOsYC
	 TmdfNvijMm2+g==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/4] selftests: kselftest_harness: pass step via shared memory
Date: Thu, 15 Feb 2024 16:26:16 -0800
Message-ID: <20240216002619.1999225-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216002619.1999225-1-kuba@kernel.org>
References: <20240216002619.1999225-1-kuba@kernel.org>
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
 tools/testing/selftests/kselftest_harness.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

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
-- 
2.43.0


