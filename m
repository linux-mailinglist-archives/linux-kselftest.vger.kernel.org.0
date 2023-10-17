Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A207CB83C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 04:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQCJF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 22:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQCJF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 22:09:05 -0400
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1C4CB0;
        Mon, 16 Oct 2023 19:09:01 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9652decb9290-04aeb;
        Tue, 17 Oct 2023 10:08:58 +0800 (CST)
X-RM-TRANSID: 2ee9652decb9290-04aeb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7652decb9424-35455;
        Tue, 17 Oct 2023 10:08:58 +0800 (CST)
X-RM-TRANSID: 2ee7652decb9424-35455
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests:modify the incorrect print format
Date:   Mon, 16 Oct 2023 19:08:56 -0700
Message-Id: <20231017020856.7003-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

when the argument type is 'unsigned int',printf '%u'
in format string

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



