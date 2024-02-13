Return-Path: <linux-kselftest+bounces-4559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EDB8534F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BBB284F15
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FAA5EE76;
	Tue, 13 Feb 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHYIjHv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84D5DF3E;
	Tue, 13 Feb 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839059; cv=none; b=AIxQcayzKXvQx02R0/F4akwrL57ViIf4iE1aVoEjTHzK8O6RR7YVGpPiRX2RCOjWZSQ9B8RgAi9nlmNanUnxYE0z/vlYlVGCDp9SlWZ0cCtIJX9iKhWyFLOz0CxriUdPsbaTF1OpJg/m52LoLBUEFkwONRj7bny8gQ66KQicWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839059; c=relaxed/simple;
	bh=A4stWhVYZw83iY951xolcCHwnpmC0wLzkKsYX7l+EgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cqt+qiyWcsAA1ekCczgAKeUOjXHBoxPhHxfiVNCaLfB+Wth78QV2CkUvuDu+1TdzSmpJJn/8L7dH5sZvrOVHe56DsEGrWRxHUEOVLoeJYzYz5nIXkvP0EByHLE0AEiHeD/RKXfS4amuJKflGJpamglkEq6ofgwcuvRrebHg5fKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHYIjHv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AC4C433B2;
	Tue, 13 Feb 2024 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839059;
	bh=A4stWhVYZw83iY951xolcCHwnpmC0wLzkKsYX7l+EgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHYIjHv5yYJjOSKCB8TbQ30wTTvdbat9SCuyaqHEU78BQYJq8iC6r6w3tYD1npxEU
	 BxS0ddfBJRVe0095ZG1EEpDKlhYzF3nzF3DgzHxjX7pOZgAD499mQauT737ozyI4Y5
	 zcKBhoK+kCQAljKeLS69jftXJ5DSWUTL9zaWs05SbCwtNRc7xzJ2p+PpKwkuFYNEVX
	 HOIrxz90XBEbYijO6hRI9VlFc6iL2gVC4sPbmV6NQhKFRfGHzCKG840lpVmcDLYft8
	 7cNcMwttGlXbEDGDLsI9RYYD2aj0MNsfq7A8z0yDXOVOBEQFEQb+KY9t9S8onxBlYZ
	 wgffBoZjhTRYw==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] selftests: kselftest_harness: pass step via shared memory
Date: Tue, 13 Feb 2024 07:44:13 -0800
Message-ID: <20240213154416.422739-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213154416.422739-1-kuba@kernel.org>
References: <20240213154416.422739-1-kuba@kernel.org>
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


