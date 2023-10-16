Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387927C9D8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 04:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjJPCyW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 22:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPCyV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 22:54:21 -0400
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2BBDD6;
        Sun, 15 Oct 2023 19:53:45 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4652ca502bbd-fe48d;
        Mon, 16 Oct 2023 10:50:42 +0800 (CST)
X-RM-TRANSID: 2ee4652ca502bbd-fe48d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2652ca500a2c-27a95;
        Mon, 16 Oct 2023 10:50:41 +0800 (CST)
X-RM-TRANSID: 2ee2652ca500a2c-27a95
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests:modify the incorrect print format
Date:   Sun, 15 Oct 2023 19:50:38 -0700
Message-Id: <20231016025038.1677-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

printf %d in format string requires 'int' but the argument type is 'unsigned int'

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/kselftest.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 529d29a35..bec2fae58 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -129,7 +129,7 @@ static inline void ksft_print_header(void)
 static inline void ksft_set_plan(unsigned int plan)
 {
 	ksft_plan = plan;
-	printf("1..%d\n", ksft_plan);
+	printf("1..%u\n", ksft_plan);
 }
 
 static inline void ksft_print_cnts(void)
@@ -137,7 +137,7 @@ static inline void ksft_print_cnts(void)
 	if (ksft_plan != ksft_test_num())
 		printf("# Planned tests != run tests (%u != %u)\n",
 			ksft_plan, ksft_test_num());
-	printf("# Totals: pass:%d fail:%d xfail:%d xpass:%d skip:%d error:%d\n",
+	printf("# Totals: pass:%u fail:%u xfail:%u xpass:%u skip:%u error:%u\n",
 		ksft_cnt.ksft_pass, ksft_cnt.ksft_fail,
 		ksft_cnt.ksft_xfail, ksft_cnt.ksft_xpass,
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
@@ -163,7 +163,7 @@ static inline void ksft_test_result_pass(const char *msg, ...)
 	ksft_cnt.ksft_pass++;
 
 	va_start(args, msg);
-	printf("ok %d ", ksft_test_num());
+	printf("ok %u ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -177,7 +177,7 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 	ksft_cnt.ksft_fail++;
 
 	va_start(args, msg);
-	printf("not ok %d ", ksft_test_num());
+	printf("not ok %u ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -203,7 +203,7 @@ static inline void ksft_test_result_xfail(const char *msg, ...)
 	ksft_cnt.ksft_xfail++;
 
 	va_start(args, msg);
-	printf("ok %d # XFAIL ", ksft_test_num());
+	printf("ok %u # XFAIL ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -217,7 +217,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
-	printf("ok %d # SKIP ", ksft_test_num());
+	printf("ok %u # SKIP ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -232,7 +232,7 @@ static inline void ksft_test_result_error(const char *msg, ...)
 	ksft_cnt.ksft_error++;
 
 	va_start(args, msg);
-	printf("not ok %d # error ", ksft_test_num());
+	printf("not ok %u # error ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
-- 
2.17.1



