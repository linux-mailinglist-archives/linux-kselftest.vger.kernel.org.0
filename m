Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A0203EED
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgFVSQ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgFVSQ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 14:16:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76269C061796
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so7892252plb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdWdw5uqOY7GNoRF552kmYRxLLZI1VEZdvZJuO73sB8=;
        b=igQ4F2AsBuFMhsCWMOLTwF/H3/kaG0sqGzdY+Wytwuxq6e/uKTWWZnsPI76Km2mz0+
         nEqo+yagADKE9baC5lMW7uN0CdJmGe7IJ5L+lUCPoK0rIzt9/kAfhBglrfoxjhPtrHXo
         KZ53xCkVDM+ShYy4idI6tMiFdg+wComjuCdDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdWdw5uqOY7GNoRF552kmYRxLLZI1VEZdvZJuO73sB8=;
        b=CIBk/Lshn31gjuXw8r3Ph+HvQJMlcV9bwm6hM2Gh05OTKrqhKk3L7BUimmuOMWze05
         BMTNnJtq66OxtPvTaHXpxxLt5axIOhQefvWZZmR7cEDjbbHhCnKkJPmxFxoD33OE3ZjB
         CXoj+S9sP6pyLuJsRd+xvCLi2frwFajVjtE7v8+osNk9CA3KP0hX+GbHhjIvAdxz3jJo
         v5qerZpcEg1ckRo2wBA/XwB6tCM0MMfSsj2e13FP4PZby86l8MR66VmSxxPcXLmQlvah
         liLK1o6Aish4wBqFH7T7b/pkQPokCM7FQy6zHKE7dyEoFdlWnretNaCVIfj4sppToLh3
         UM5w==
X-Gm-Message-State: AOAM533oZjM0yjio3XVy4nuBeXXrIMJXbhhVkRvhAS/eqxS2CkfNtdJ/
        Uv2aZXW7H22DwRTjhnZbpCThbw==
X-Google-Smtp-Source: ABdhPJwq72KZ9gketyAOgkCA0hDWYwYTZcWhMXRJL7/p9uFfjQQpCc2yeF/hOsiB0gysgWFLTeHzhQ==
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr19588058pjb.32.1592849816996;
        Mon, 22 Jun 2020 11:16:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k19sm15346589pfg.153.2020.06.22.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] selftests: Add header documentation and helpers
Date:   Mon, 22 Jun 2020 11:16:47 -0700
Message-Id: <20200622181651.2795217-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest.h | 73 ++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 0ac49d91a260..2cd5eefed4d2 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -6,6 +6,37 @@
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
+ * and finally report the pass/fail/skip/xfail state of the test with one of:
+ *
+ *     ksft_test_result(condition, fmt, ...);
+ *     ksft_test_result_pass(fmt, ...);
+ *     ksft_test_result_fail(fmt, ...);
+ *     ksft_test_result_skip(fmt, ...);
+ *     ksft_test_result_xfail(fmt, ...);
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
@@ -74,7 +105,7 @@ static inline void ksft_print_cnts(void)
 	if (ksft_plan != ksft_test_num())
 		printf("# Planned tests != run tests (%u != %u)\n",
 			ksft_plan, ksft_test_num());
-	printf("# Pass %d Fail %d Xfail %d Xpass %d Skip %d Error %d\n",
+	printf("# Totals: pass:%d fail:%d xfail:%d xpass:%d skip:%d error:%d\n",
 		ksft_cnt.ksft_pass, ksft_cnt.ksft_fail,
 		ksft_cnt.ksft_xfail, ksft_cnt.ksft_xpass,
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
@@ -120,6 +151,32 @@ static inline void ksft_test_result_fail(const char *msg, ...)
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
 static inline void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -134,6 +191,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	va_end(args);
 }
 
+/* TODO: how does "error" differ from "fail" or "skip"? */
 static inline void ksft_test_result_error(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -156,11 +214,22 @@ static inline int ksft_exit_pass(void)
 
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

