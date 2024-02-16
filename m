Return-Path: <linux-kselftest+bounces-4831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2D8572B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF75286A05
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C7BE5E;
	Fri, 16 Feb 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UquN38Jy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA52946F;
	Fri, 16 Feb 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044090; cv=none; b=tGDUu+MdMeIEsA7mVb0Lt636xp7jaEW3oM/1Ev9+O/4P6VaWR3ww8EXCfCGkO0QlLZ7m4Tcp0o2AGBsnS7Mwa5HvOW/IyYBIfr85GwmsrFu4+b6/WQCeA2dmFo43ceGRS5SqLgmUVkZMc6UhcBdqxlYPsB7hllH0zFAgvIxva4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044090; c=relaxed/simple;
	bh=20msBFwZRtEP1FinTrpQIFSjg5lTxL3Pw4Rt2jZCeq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1iyS4KH9ZlzGq1ot7jbCkfN7KyfpknzwJQQK5gICcT/GMncQHlRC2noCyJ3fCeudE6at81lwlZx+MtqexSKEYKp81PYEUV8OKtb1O780GfYJFIZen2oKpB46rK9LV1qFi6HhOizGcfpAjYFJFLF1u7KsQx5lsZIQhL6/mMmq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UquN38Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33489C43399;
	Fri, 16 Feb 2024 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044090;
	bh=20msBFwZRtEP1FinTrpQIFSjg5lTxL3Pw4Rt2jZCeq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UquN38Jy3QZ/UEqBwJiDkNUuVivDG7bfxQrGpXk6O7geaMZt95w2/HQFH8WCf263f
	 4CN85HIaixARms0x7xj2/4+9MKAaIrbd4Ok1/1jv5O73pO1u02NLW3MdNvzo4EfVHk
	 1LXcSJChMmxCmMG5/WtDi297QukyXqTy8DpWfyugu+2zYUXKuBSJj5xjrrvsUZZd0y
	 nny9i1xwBBolw5IPqrLX31mB49eUtzaVu+zwGyNjIGsFabaEzTvfJppsURGehJh0IU
	 pjSa/3/HDOgQL3wnVRXqTnyH7kXeFKeOtcEzicayjDPkCna1s+rq3cOVGqBrVBsVN7
	 iVYu0ySVDxpQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 4/7] selftests: kselftest: add ksft_test_result_code(), handling all exit codes
Date: Thu, 15 Feb 2024 16:41:19 -0800
Message-ID: <20240216004122.2004689-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216004122.2004689-1-kuba@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest.h         | 39 +++++++++++++++++++++
 tools/testing/selftests/kselftest_harness.h | 14 ++++----
 2 files changed, 47 insertions(+), 6 deletions(-)

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
index 6923cd7060fc..79a3fec0cefa 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1140,6 +1140,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __test_metadata *t)
 {
 	char test_name[LINE_MAX];
+	const char *diagnostic;
 
 	/* reset test struct */
 	t->exit_code = KSFT_PASS;
@@ -1171,12 +1172,13 @@ void __run_test(struct __fixture_metadata *f,
 	ksft_print_msg("         %4s  %s\n",
 		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
-	if (t->exit_code == KSFT_SKIP)
-		ksft_test_result_skip("%s\n", t->results->reason[0] ?
-					t->results->reason : "unknown");
-	else if (t->exit_code == KSFT_XFAIL)
-		ksft_test_result_xfail("%s\n", t->results->reason[0] ?
-				       t->results->reason : "unknown");
+	if (t->results->reason[0])
+		diagnostic = t->results->reason;
+	else
+		diagnostic = "unknown";
+
+	if (t->exit_code == KSFT_SKIP || t->exit_code == KSFT_XFAIL)
+		ksft_test_result_code(t->exit_code, "%s\n", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.0


