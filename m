Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C331F706C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFKWkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 18:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKWkf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853CCC08C5C1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2891619plo.7
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xrEmoJ2HANJq2pVV7su7gEAYovMisFRPydaVaSLcslY=;
        b=YdqUcRqshrV3hTSfk5FyqH8OeZjcF51jaAGKETs6CFkhNLsMH+YhSNAGfP50LqZPTV
         f7JLUnqjwCbkFhWwLyu/2p9ulKE2BffT0oPRL8PaMcP0st4o83B1NkkMlR4jMpBfcpUR
         5NsNgeNDuDJ2Gag9F84HARRU+HaQ5YHLnmUgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xrEmoJ2HANJq2pVV7su7gEAYovMisFRPydaVaSLcslY=;
        b=VYdioS6YigwuYStqwgwoCJoCWAfTRotkZAwEIMsOcun1ODC+wDi4y0Bjbr4Ygoll+J
         rpJE0byxxKBEDgA2rO2dQfrTi6RA3gO/A8dfXG09OOlp6ubDE2VQs1PGnYPy/h+q/Tw7
         orZ8/KXDr06ED8uNB2eUSFcbwn+OV7WTWUFHXxTGKcLMR5kjwj1N23l6GNYbggallHIN
         rqLxypHpr9m0hKhhnywIHRS74P8NvCgRB+rdvgHFCSagWQuIpLZOxu0ZXKkzpa5koiyK
         XeiSMo0+TsX5J0GAck7CO8BRzVvzhPlxl4mcyHO6YAnKSmDoTVqAyO4QMnVJleZOzkMe
         TjQQ==
X-Gm-Message-State: AOAM530H1UZsJfbP+lXL14fwU9+Ue5r6MQIIjDLuR69TMoSJ5/KGLMzq
        YErxPKGISdQBzQHz45lgFY98Qg==
X-Google-Smtp-Source: ABdhPJzcsbdkSdiBs6DWddZ1aILv0BfJ42BCN5k32FTTR22ozpTSNlCMceYX08+OcGjE9eUQ5XvnOg==
X-Received: by 2002:a17:90b:1013:: with SMTP id gm19mr10193710pjb.231.1591915234095;
        Thu, 11 Jun 2020 15:40:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b5sm3515676pjz.34.2020.06.11.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:40:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] selftests: Add header documentation and helpers
Date:   Thu, 11 Jun 2020 15:40:25 -0700
Message-Id: <20200611224028.3275174-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611224028.3275174-1-keescook@chromium.org>
References: <20200611224028.3275174-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add "how to use this API" documentation to kselftest.h, and include some
addition helpers and notes to make things easier to use.

Additionally removes the incorrect "Bail out!" line from the standard exit
path. The TAP13 specification says that "Bail out!"  should be used when
giving up before all tests have been run. For a "normal" execution run,
the selftests should not report "Bail out!".

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest.h | 60 ++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 0ac49d91a260..5716cbb9eecc 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -6,6 +6,36 @@
  * Copyright (c) 2014 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *
+ * Using this API consists of first counting how many tests your code
+ * has to run, and then starting up the reporting:
+ *
+ *     ksft_print_header();
+ *     ksft_set_plan(total_number_of_tests);
+ *
+ * For each test, report any progress, debugging, etc with:
+ *
+ *     ksft_print_msg(fmt, ...);
+ *
+ * and finally report the pass/fail/skip state of the test with one of:
+ *
+ *     ksft_test_result(condition, fmt, ...);
+ *     ksft_test_result_pass(fmt, ...);
+ *     ksft_test_result_fail(fmt, ...);
+ *     ksft_test_result_skip(fmt, ...);
+ *     ksft_test_result_error(fmt, ...);
+ *
+ * When all tests are finished, clean up and exit the program with one of:
+ *
+ *    ksft_exit(condition);
+ *    ksft_exit_pass();
+ *    ksft_exit_fail();
+ *
+ * If the program wants to report details on why the entire program has
+ * failed, it can instead exit with a message (this is usually done when
+ * the program is aborting before finishing all tests):
+ *
+ *    ksft_exit_fail_msg(fmt, ...);
+ *
  */
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
@@ -74,7 +104,7 @@ static inline void ksft_print_cnts(void)
 	if (ksft_plan != ksft_test_num())
 		printf("# Planned tests != run tests (%u != %u)\n",
 			ksft_plan, ksft_test_num());
-	printf("# Pass %d Fail %d Xfail %d Xpass %d Skip %d Error %d\n",
+	printf("# Totals: pass:%d fail:%d xfail:%d xpass:%d skip:%d error:%d\n",
 		ksft_cnt.ksft_pass, ksft_cnt.ksft_fail,
 		ksft_cnt.ksft_xfail, ksft_cnt.ksft_xpass,
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
@@ -120,6 +150,20 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 	va_end(args);
 }
 
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
+/* TODO: add ksft_test_result_xfail() */
+
 static inline void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -134,6 +178,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	va_end(args);
 }
 
+/* TODO: how does "error" differ from "fail" or "skip"? */
 static inline void ksft_test_result_error(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -156,11 +201,22 @@ static inline int ksft_exit_pass(void)
 
 static inline int ksft_exit_fail(void)
 {
-	printf("Bail out!\n");
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
 }
 
+/**
+ * ksft_exit() - Exit selftest based on truth of condition
+ *
+ * @condition: if true, exit self test with success, otherwise fail.
+ */
+#define ksft_exit(condition) do {	\
+	if (!!(condition))		\
+		ksft_exit_pass();	\
+	else				\
+		ksft_exit_fail();	\
+	} while (0)
+
 static inline int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
-- 
2.25.1

