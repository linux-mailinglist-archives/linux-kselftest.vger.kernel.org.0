Return-Path: <linux-kselftest+bounces-5572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF586BDC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E39C1C241FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7253B19C;
	Thu, 29 Feb 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf+2pKiz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808403A8F9;
	Thu, 29 Feb 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168371; cv=none; b=WOLB6XAKBaaicOGm/eOa3TgkUGSrYDZgMIt4y+lC6lWevSpgoacAWAGyfuQe8U/gojxHQXsDNKBxTxpZTIBff3KvSrWu3hmpCez7bchFHQILVbcOqO/FBrHhMjKUpZaSIrQe850OziuatfHwsJLKkU40jONPkRhYlmUttK9iQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168371; c=relaxed/simple;
	bh=EFt0aBxDIBf/bWE08iMZghTHjUVAl3MKx8jWmqCjZsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfC1asc0OK4AH+/52Zfw6QMUmmomTwEv2oZc0uRd5o6tEfpWvWCotM49bza492bEPDD/UdkfUExZkZTUyU42mXucUUuq71Fo96eaeFX2EdBSZn5LT20rkBfhaHLS/0j8xIpmFTJnmfEsijRTI9owKDyiOz+3E6wmFmJDhlJwfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf+2pKiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED8C433B1;
	Thu, 29 Feb 2024 00:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168371;
	bh=EFt0aBxDIBf/bWE08iMZghTHjUVAl3MKx8jWmqCjZsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cf+2pKizrwbkG3cr0ZCWseXEGscV9O0MuU/aQ1TUB/F95v5PyHmzOytK3KXdugXDZ
	 x2jQ7r//KNtWD4Uj9tn2xeD50uArOeLZND7gIMBpVuWKRq7COz1qfDbAXyQNjMpnNW
	 r8Z8WAP35MvitAxLeanpE7wgH8yDfp80a/Ci54Sz7Q7KqqHJO4s/ceQSj4hVBQEwMW
	 IgeiCyv5z+kx07tY7YVaizEENIFIXu787FYqMz3YYzYYKV9dBIFbugaVd/ryCl55M2
	 7L2rSkfhWSQBqGr9IcL9NgRN5N0Y2SX0qaenUX6pT8jPvRlzFCKXsVegbPHR8p036o
	 +1WIStHGF+CNw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v4 07/12] selftests: kselftest: add ksft_test_result_code(), handling all exit codes
Date: Wed, 28 Feb 2024 16:59:14 -0800
Message-ID: <20240229005920.2407409-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For generic test harness code it's more useful to deal with exit
codes directly, rather than having to switch on them and call
the right ksft_test_result_*() helper. Add such function to kselftest.h.

Note that "directive" and "diagnostic" are what ktap docs call
those parts of the message.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest.h         | 39 +++++++++++++++++++++
 tools/testing/selftests/kselftest_harness.h |  9 +++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index a781e6311810..12ad7f8dfe3a 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -25,6 +25,7 @@
  *     ksft_test_result_skip(fmt, ...);
  *     ksft_test_result_xfail(fmt, ...);
  *     ksft_test_result_error(fmt, ...);
+ *     ksft_test_result_code(exit_code, test_name, fmt, ...);
  *
  * When all tests are finished, clean up and exit the program with one of:
  *
@@ -254,6 +255,44 @@ static inline __printf(1, 2) void ksft_test_result_error(const char *msg, ...)
 	va_end(args);
 }
 
+static inline __printf(2, 3)
+void ksft_test_result_code(int exit_code, const char *msg, ...)
+{
+	const char *tap_code = "ok";
+	const char *directive = "";
+	int saved_errno = errno;
+	va_list args;
+
+	switch (exit_code) {
+	case KSFT_PASS:
+		ksft_cnt.ksft_pass++;
+		break;
+	case KSFT_XFAIL:
+		directive = " # XFAIL ";
+		ksft_cnt.ksft_xfail++;
+		break;
+	case KSFT_XPASS:
+		directive = " # XPASS ";
+		ksft_cnt.ksft_xpass++;
+		break;
+	case KSFT_SKIP:
+		directive = " # SKIP ";
+		ksft_cnt.ksft_xskip++;
+		break;
+	case KSFT_FAIL:
+	default:
+		tap_code = "not ok";
+		ksft_cnt.ksft_fail++;
+		break;
+	}
+
+	va_start(args, msg);
+	printf("%s %u%s", tap_code, ksft_test_num(), directive);
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
 static inline int ksft_exit_pass(void)
 {
 	ksft_print_cnts();
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5a48177c8c00..4fb30fcc7774 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1111,6 +1111,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __test_metadata *t)
 {
 	char test_name[LINE_MAX];
+	const char *diagnostic;
 
 	/* reset test struct */
 	t->exit_code = KSFT_PASS;
@@ -1140,9 +1141,13 @@ void __run_test(struct __fixture_metadata *f,
 	ksft_print_msg("         %4s  %s\n",
 		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
+	if (t->results->reason[0])
+		diagnostic = t->results->reason;
+	else
+		diagnostic = "unknown";
+
 	if (t->exit_code == KSFT_SKIP)
-		ksft_test_result_skip("%s\n", t->results->reason[0] ?
-					t->results->reason : "unknown");
+		ksft_test_result_code(t->exit_code, "%s\n", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.2


