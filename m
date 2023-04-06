Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5E6D98CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbjDFN6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbjDFN55 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 09:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C31A5C6;
        Thu,  6 Apr 2023 06:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B44B60DBF;
        Thu,  6 Apr 2023 13:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20FAC433D2;
        Thu,  6 Apr 2023 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680789441;
        bh=a79oajkhQYVRaB6DwXBTM0ag0IUaHV1EBWHADnz2lHk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ELrykX2bdSssJi10V3rL9ckMK0huAvl1wMVY8P31xTyyYCK/jwq9s2vMazoCjluFK
         IMWh/f1AVCNvPC1g0buxk4hdVTGKWE6ASgMh4XxEFfIKetCM47fFDgZnM8U6AHKlWd
         zls10d3p0kADlG4uRfshgYilSQkUsK9EeC6LYQ7y0dF2ulTUpCBKhegizv0wCNDRrf
         FMi4PCKjyMShrswQy7K/mi8s3+Y1y+3fsGSeV2HffKRidErv6+TXILq3GY2iN9ZOig
         SrxuprHt1n+NkJ68+0uxPmpw+b3hHO8Z6vEkV100rqD1f6V386xjjxFoMhW08FbslF
         Jm2tfBSrz4ZUQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 06 Apr 2023 14:56:29 +0100
Subject: [PATCH 1/2] kselftest: Support nolibc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-kselftest-nolibc-v1-1-63fbcd70b202@kernel.org>
References: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
In-Reply-To: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=11785; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a79oajkhQYVRaB6DwXBTM0ag0IUaHV1EBWHADnz2lHk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkLs+7erwrk7RnEeNVoFpLU3iXhOt2tuhANaHD45/y
 QLSxDb6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZC7PuwAKCRAk1otyXVSH0Lq+B/
 43w6CkOjngdTrY09nlmgjf6DFUrZkA6qawnyCIqH8OG5gy2LUg0VofMP28j+hXCZzp68Ha4nOzVmwj
 zq4MbAEIDgG5iTLjXKJKp3LB+P1QUAns4pZz8EYVf+UADOdxzwSbleMOCkkXHClVVTPqc7KxdrzAQF
 0eTWs7S3J+yXDXqP+Qqg9av1J0w1Gg4RX+1vvMoUWqEbyOQCzyyObsxLFqVdgt8/jNbuT53LhwNU1f
 1AF6o7+wDvJfcwFk5tHD8s/GFZPkIhsEyQoNqT1r6t6ROGcm/9krEFc4nVUybhyAZppWkt9nEOaLQm
 UNzEfyRrMFOXpQ9Qa88Wwiw+g7ORjB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

At present the kselftest header can't be used with nolibc since it makes
use of vprintf() which is not available in nolibc and seems like it would
be inappropriate to implement given the minimal system requirements and
environment intended for nolibc. This has resulted in some open coded
kselftests which use nolibc to test features that are supposed to be
controlled via libc and therefore better exercised in an environment with
no libc.

Rather than continue this let's factor out the I/O routines in kselftest.h
into a separate header file and provide a nolibc implementation which only
allows simple strings to be provided rather than full printf() support.
This is limiting but a great improvement on sharing no code at all.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kselftest-nolibc.h |  93 ++++++++++++++++++
 tools/testing/selftests/kselftest-std.h    | 151 +++++++++++++++++++++++++++++
 tools/testing/selftests/kselftest.h        | 149 +++-------------------------
 3 files changed, 255 insertions(+), 138 deletions(-)

diff --git a/tools/testing/selftests/kselftest-nolibc.h b/tools/testing/selftests/kselftest-nolibc.h
new file mode 100644
index 000000000000..3dea10cc5490
--- /dev/null
+++ b/tools/testing/selftests/kselftest-nolibc.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * kselftest-nolibc	Cut down nolibc based kselftest output functions
+ *
+ * Copyright (c) 2014 Shuah Khan <shuahkh@osg.samsung.com>
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ */
+
+#ifndef __KSELFTEST_H
+#error This file should never be included directly, always include kselftest.h
+#endif
+
+static inline void ksft_print_msg(const char *msg)
+{
+	printf("# %s", msg);
+}
+
+static inline void ksft_test_result_pass(const char *msg)
+{
+	ksft_cnt.ksft_pass++;
+
+	printf("ok %d %s", ksft_test_num(), msg);
+}
+
+static inline void ksft_test_result_fail(const char *msg)
+{
+	ksft_cnt.ksft_fail++;
+
+	printf("not ok %d %s", ksft_test_num(), msg);
+}
+
+/**
+ * ksft_test_result() - Report test success based on truth of condition
+ *
+ * @condition: if true, report test success, otherwise failure.
+ */
+#define ksft_test_result(condition, fmt) do {	\
+	if (!!(condition))				\
+		ksft_test_result_pass(fmt);\
+	else						\
+		ksft_test_result_fail(fmt);\
+	} while (0)
+
+static inline void ksft_test_result_xfail(const char *msg)
+{
+	ksft_cnt.ksft_xfail++;
+
+	printf("ok %d # XFAIL %s", ksft_test_num(), msg);
+}
+
+static inline void ksft_test_result_skip(const char *msg)
+{
+	ksft_cnt.ksft_xskip++;
+
+	printf("ok %d # SKIP %s", ksft_test_num(), msg);
+}
+
+static inline void ksft_test_result_error(const char *msg)
+{
+	ksft_cnt.ksft_error++;
+
+	printf("not ok %d # error %s", ksft_test_num(), msg);
+}
+
+static inline int ksft_exit_fail_msg(const char *msg)
+{
+	printf("Bail out! %s", msg);
+
+	ksft_print_cnts();
+	exit(KSFT_FAIL);
+}
+
+static inline int ksft_exit_skip(const char *msg)
+{
+	/*
+	 * FIXME: several tests misuse ksft_exit_skip so produce
+	 * something sensible if some tests have already been run
+	 * or a plan has been printed.  Those tests should use
+	 * ksft_test_result_skip or ksft_exit_fail_msg instead.
+	 */
+	if (ksft_plan || ksft_test_num()) {
+		ksft_cnt.ksft_xskip++;
+		printf("ok %d # SKIP ", 1 + ksft_test_num());
+	} else {
+		printf("1..0 # SKIP ");
+	}
+	if (msg)
+		printf("%s", msg);
+	if (ksft_test_num())
+		ksft_print_cnts();
+	exit(KSFT_SKIP);
+}
diff --git a/tools/testing/selftests/kselftest-std.h b/tools/testing/selftests/kselftest-std.h
new file mode 100644
index 000000000000..b57c515f6dda
--- /dev/null
+++ b/tools/testing/selftests/kselftest-std.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * kselftest-std.h:	Full stdio based kselftest output functions
+ *
+ * Copyright (c) 2014 Shuah Khan <shuahkh@osg.samsung.com>
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ */
+
+#ifndef __KSELFTEST_H
+#error This file should never be included directly, always include kselftest.h
+#endif
+
+static inline void ksft_print_msg(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	va_start(args, msg);
+	printf("# ");
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
+static inline void ksft_test_result_pass(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_pass++;
+
+	va_start(args, msg);
+	printf("ok %d ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
+static inline void ksft_test_result_fail(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_fail++;
+
+	va_start(args, msg);
+	printf("not ok %d ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
+/**
+ * ksft_test_result() - Report test success based on truth of condition
+ *
+ * @condition: if true, report test success, otherwise failure.
+ */
+#define ksft_test_result(condition, fmt, ...) do {	\
+	if (!!(condition))				\
+		ksft_test_result_pass(fmt, ##__VA_ARGS__);\
+	else						\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
+	} while (0)
+
+static inline void ksft_test_result_xfail(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_xfail++;
+
+	va_start(args, msg);
+	printf("ok %d # XFAIL ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
+static inline void ksft_test_result_skip(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_xskip++;
+
+	va_start(args, msg);
+	printf("ok %d # SKIP ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
+/* TODO: how does "error" differ from "fail" or "skip"? */
+static inline void ksft_test_result_error(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_error++;
+
+	va_start(args, msg);
+	printf("not ok %d # error ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
+static inline int ksft_exit_fail_msg(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	va_start(args, msg);
+	printf("Bail out! ");
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+
+	ksft_print_cnts();
+	exit(KSFT_FAIL);
+}
+
+static inline int ksft_exit_skip(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	va_start(args, msg);
+
+	/*
+	 * FIXME: several tests misuse ksft_exit_skip so produce
+	 * something sensible if some tests have already been run
+	 * or a plan has been printed.  Those tests should use
+	 * ksft_test_result_skip or ksft_exit_fail_msg instead.
+	 */
+	if (ksft_plan || ksft_test_num()) {
+		ksft_cnt.ksft_xskip++;
+		printf("ok %d # SKIP ", 1 + ksft_test_num());
+	} else {
+		printf("1..0 # SKIP ");
+	}
+	if (msg) {
+		errno = saved_errno;
+		vprintf(msg, args);
+		va_end(args);
+	}
+	if (ksft_test_num())
+		ksft_print_cnts();
+	exit(KSFT_SKIP);
+}
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 33a0dbd26bd3..10fb6f7c4ae2 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -26,6 +26,10 @@
  *     ksft_test_result_xfail(fmt, ...);
  *     ksft_test_result_error(fmt, ...);
  *
+ * If building with nolibc then only a string may be provided, va_args
+ * arre not supported and format characters within the string will not be
+ * interpreted.
+ *
  * When all tests are finished, clean up and exit the program with one of:
  *
  *    ksft_finished();
@@ -43,11 +47,13 @@
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
 
+#ifndef NOLIBC
 #include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
 #include <stdio.h>
+#endif
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -132,100 +138,11 @@ static inline void ksft_print_cnts(void)
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
 }
 
-static inline void ksft_print_msg(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	va_start(args, msg);
-	printf("# ");
-	errno = saved_errno;
-	vprintf(msg, args);
-	va_end(args);
-}
-
-static inline void ksft_test_result_pass(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	ksft_cnt.ksft_pass++;
-
-	va_start(args, msg);
-	printf("ok %d ", ksft_test_num());
-	errno = saved_errno;
-	vprintf(msg, args);
-	va_end(args);
-}
-
-static inline void ksft_test_result_fail(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	ksft_cnt.ksft_fail++;
-
-	va_start(args, msg);
-	printf("not ok %d ", ksft_test_num());
-	errno = saved_errno;
-	vprintf(msg, args);
-	va_end(args);
-}
-
-/**
- * ksft_test_result() - Report test success based on truth of condition
- *
- * @condition: if true, report test success, otherwise failure.
- */
-#define ksft_test_result(condition, fmt, ...) do {	\
-	if (!!(condition))				\
-		ksft_test_result_pass(fmt, ##__VA_ARGS__);\
-	else						\
-		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
-	} while (0)
-
-static inline void ksft_test_result_xfail(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	ksft_cnt.ksft_xfail++;
-
-	va_start(args, msg);
-	printf("ok %d # XFAIL ", ksft_test_num());
-	errno = saved_errno;
-	vprintf(msg, args);
-	va_end(args);
-}
-
-static inline void ksft_test_result_skip(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	ksft_cnt.ksft_xskip++;
-
-	va_start(args, msg);
-	printf("ok %d # SKIP ", ksft_test_num());
-	errno = saved_errno;
-	vprintf(msg, args);
-	va_end(args);
-}
-
-/* TODO: how does "error" differ from "fail" or "skip"? */
-static inline void ksft_test_result_error(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	ksft_cnt.ksft_error++;
-
-	va_start(args, msg);
-	printf("not ok %d # error ", ksft_test_num());
-	errno = saved_errno;
-	vprintf(msg, args);
-	va_end(args);
-}
+#ifdef NOLIBC
+#include "kselftest-nolibc.h"
+#else
+#include "kselftest-std.h"
+#endif
 
 static inline int ksft_exit_pass(void)
 {
@@ -260,21 +177,6 @@ static inline int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline int ksft_exit_fail_msg(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	va_start(args, msg);
-	printf("Bail out! ");
-	errno = saved_errno;
-	vprintf(msg, args);
-	va_end(args);
-
-	ksft_print_cnts();
-	exit(KSFT_FAIL);
-}
-
 static inline int ksft_exit_xfail(void)
 {
 	ksft_print_cnts();
@@ -287,33 +189,4 @@ static inline int ksft_exit_xpass(void)
 	exit(KSFT_XPASS);
 }
 
-static inline int ksft_exit_skip(const char *msg, ...)
-{
-	int saved_errno = errno;
-	va_list args;
-
-	va_start(args, msg);
-
-	/*
-	 * FIXME: several tests misuse ksft_exit_skip so produce
-	 * something sensible if some tests have already been run
-	 * or a plan has been printed.  Those tests should use
-	 * ksft_test_result_skip or ksft_exit_fail_msg instead.
-	 */
-	if (ksft_plan || ksft_test_num()) {
-		ksft_cnt.ksft_xskip++;
-		printf("ok %d # SKIP ", 1 + ksft_test_num());
-	} else {
-		printf("1..0 # SKIP ");
-	}
-	if (msg) {
-		errno = saved_errno;
-		vprintf(msg, args);
-		va_end(args);
-	}
-	if (ksft_test_num())
-		ksft_print_cnts();
-	exit(KSFT_SKIP);
-}
-
 #endif /* __KSELFTEST_H */

-- 
2.30.2

