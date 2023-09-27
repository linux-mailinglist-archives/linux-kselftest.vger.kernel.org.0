Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFF67B01A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 12:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjI0KTO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 06:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjI0KTL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 06:19:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C3059DB;
        Wed, 27 Sep 2023 03:19:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23A6C433C8;
        Wed, 27 Sep 2023 10:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695809950;
        bh=q8UFTGCW+PEFQaExarcKjuMastWfb/GcwHIY56H9Tcw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KCp/48UmNhG+JUhenczTWbQ01+AmwHSJ/xcynPmRlgAsXCa4o+g9mRDPbDHUTwFNY
         knZA5sC1MFntWgcmwvXDf7ki3fruJuUFMVRjBGiFx4tB9FDEboR/yuUGWs5h+NmybG
         dpVkqylLX+TvWpAoaIOjtKyl+qKIejaU3ad2fHRq15duc7pF1nDVQDaqRCyABs4+fc
         uF3OBobSRo1FfYDvo8IhFN8FGCvF1ZWurUIrp4q8DD0fMh6JrqhwcJn/hlf8AHxdud
         277wi2XqBg2CkrgJw/Tk4+mnEg+UzcIfK//psyM19om44R9Pl1X25jxlNsWL7LYo7k
         qBvjw4w9aw3qg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 27 Sep 2023 12:18:57 +0200
Subject: [PATCH 1/3] kselftest: Add a ksft_perror() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-ktap-posix-timers-v1-1-399de1cbfbea@kernel.org>
References: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
In-Reply-To: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q8UFTGCW+PEFQaExarcKjuMastWfb/GcwHIY56H9Tcw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFAGYNK6gOtJ44o+Ey79dZT7jaZTXslGQO8ibW
 4QF+xvnPF+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRQBmAAKCRAk1otyXVSH
 0MnuB/0fKCe7L0bWZzezE38N7jQMuQoyEPoFefE9z2hmqRzbaxOlz7qYon9WgdI+eJsZKncV8rh
 ZlKpz5PotKnC6WFxN3zmVoro2yulWq7knYrKKBcP0FQeZ2KdUuEzR2c1+SXfiSI2R0Up1X7JXaO
 6PquwMvoc+z+ElwmKiehj74I7f9rxBuxobQBDwlRpjSlcHTYKVHAFkAvD8tqAtawQaM0dI5ZOxC
 +2A26seWgb7MMnLFFEKGihIBEziLtf539Z78/CmaQ0XuIUSSI6vRtal4H9QaGlurqK4b2sViq0n
 oGbDsaKEjptRXTElzBtZNSydt/u5eTUEgTR5XKSiHzOAeP/Z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The standard library perror() function provides a convenient way to print
an error message based on the current errno but this doesn't play nicely
with KTAP output. Provide a helper which does an equivalent thing in a KTAP
compatible format.

nolibc doesn't have a strerror() and adding the table of strings required
doesn't seem like a good fit for what it's trying to do so when we're using
that only print the errno.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kselftest.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 529d29a35900..af9f1202d423 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -48,6 +48,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <string.h>
 #include <stdio.h>
 #endif
 
@@ -155,6 +156,19 @@ static inline void ksft_print_msg(const char *msg, ...)
 	va_end(args);
 }
 
+static inline void ksft_perror(const char *msg)
+{
+#ifndef NOLIBC
+	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
+#else
+	/*
+	 * nolibc doesn't provide strerror() and it seems
+	 * inappropriate to add one, just print the errno.
+	 */
+	ksft_print_msg("%s: %d)\n", msg, errno);
+#endif
+}
+
 static inline void ksft_test_result_pass(const char *msg, ...)
 {
 	int saved_errno = errno;

-- 
2.39.2

