Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903C8617C17
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 13:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKCMB5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 08:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiKCMB4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 08:01:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC812A87;
        Thu,  3 Nov 2022 05:01:54 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N32MZ654kzpWB0;
        Thu,  3 Nov 2022 19:58:18 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 20:01:52 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shuah@kernel.org>, Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next] selftests: Add color to keywords of results report
Date:   Thu, 3 Nov 2022 19:58:28 +0800
Message-ID: <20221103115828.49391-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For ksft_test_result_*()/ksft_exit_*(), we could add color to some
keywords like:

function	color
*pass*		green
*fail*		red
*skip*		yellow
*error*		magenta

And it is hoped to improve the readability of the output.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 tools/testing/selftests/kselftest.h | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 33a0dbd26bd3..8c53a7520578 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -75,6 +75,18 @@
 #define KSFT_XPASS 3
 #define KSFT_SKIP  4

+#define COLOR_RED	"\033[1;31m"
+#define COLOR_GREEN	"\033[1;32m"
+#define COLOR_YELLOW	"\033[1;33m"
+#define COLOR_MAGENTA	"\033[1;35m"
+
+#define RESET		"\033[0m"
+
+#define RED(msg) COLOR_RED msg RESET
+#define GREEN(msg) COLOR_GREEN msg RESET
+#define YELLOW(msg) COLOR_YELLOW msg RESET
+#define MAGENTA(msg) COLOR_MAGENTA msg RESET
+
 /* counters */
 struct ksft_count {
 	unsigned int ksft_pass;
@@ -152,7 +164,7 @@ static inline void ksft_test_result_pass(const char *msg, ...)
 	ksft_cnt.ksft_pass++;

 	va_start(args, msg);
-	printf("ok %d ", ksft_test_num());
+	printf(GREEN("ok %d "), ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -166,7 +178,7 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 	ksft_cnt.ksft_fail++;

 	va_start(args, msg);
-	printf("not ok %d ", ksft_test_num());
+	printf(RED("not ok %d "), ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -192,7 +204,7 @@ static inline void ksft_test_result_xfail(const char *msg, ...)
 	ksft_cnt.ksft_xfail++;

 	va_start(args, msg);
-	printf("ok %d # XFAIL ", ksft_test_num());
+	printf(RED("ok %d # XFAIL "), ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -206,7 +218,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	ksft_cnt.ksft_xskip++;

 	va_start(args, msg);
-	printf("ok %d # SKIP ", ksft_test_num());
+	printf(YELLOW("ok %d # SKIP "), ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -221,7 +233,7 @@ static inline void ksft_test_result_error(const char *msg, ...)
 	ksft_cnt.ksft_error++;

 	va_start(args, msg);
-	printf("not ok %d # error ", ksft_test_num());
+	printf(MAGENTA("not ok %d # error "), ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -266,7 +278,7 @@ static inline int ksft_exit_fail_msg(const char *msg, ...)
 	va_list args;

 	va_start(args, msg);
-	printf("Bail out! ");
+	printf(RED("Bail out! "));
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -302,9 +314,9 @@ static inline int ksft_exit_skip(const char *msg, ...)
 	 */
 	if (ksft_plan || ksft_test_num()) {
 		ksft_cnt.ksft_xskip++;
-		printf("ok %d # SKIP ", 1 + ksft_test_num());
+		printf(YELLOW("ok %d # SKIP "), 1 + ksft_test_num());
 	} else {
-		printf("1..0 # SKIP ");
+		printf(YELLOW("1..0 # SKIP "));
 	}
 	if (msg) {
 		errno = saved_errno;
--
2.17.1

