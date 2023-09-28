Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4397B1FDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjI1Oic (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjI1Oi3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 10:38:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5BA136;
        Thu, 28 Sep 2023 07:38:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5255C433C8;
        Thu, 28 Sep 2023 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695911906;
        bh=q8UFTGCW+PEFQaExarcKjuMastWfb/GcwHIY56H9Tcw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BZQIp7cN2GL57vChOU1kT8bhTIHyB461hx5VZi7EQHsucGSvA9HIFgljqIkq95OkW
         IapfOzlVzrqPm3gZkrIYLzry6pCbW8Kc7JGUXZ2DFiZQnrJOxUXcUtEupIgSJZmELh
         9piUigJVyNW4S/Qn23Qz5inxoA++YG7wr/P5dS3S2ypSplxnXdcDo7TFWXslxuoeVX
         kOQqIpdkbBW9/3L0vXy6+tAMfe5otOlq9G8eA4aeZrbDEhOjrqPjxhsC5qLSIdggQF
         iP+QB3U8QFWreajhTBTyT51Urc00S1OlJpdwS8wphP9Vc7KyrTsn6QANcFNfaKFrsu
         e0m8ZBWmcE6cg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 28 Sep 2023 16:38:11 +0200
Subject: [PATCH 1/2] kselftest: Add a ksft_perror() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
In-Reply-To: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q8UFTGCW+PEFQaExarcKjuMastWfb/GcwHIY56H9Tcw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFY/dyR2RkI4Mf3AjCLdtgSIbCYIqcP2/TW/+f
 QjOYN+RisqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRWP3QAKCRAk1otyXVSH
 0LZxB/9rF9qh6VkytpRTD4uzNLpwiQHxuWBhc9JCr9kLoPxnRbAJTvaRe530xMNWvRPC0cIWeDk
 hhw6WbIo53maSZJl56bQngArBk29ZLRxINJrFzslh7L2PqNf2uFuvOAPN9hrej6d8cxWWUR+KMh
 LjCExIZCY8nR+W/+OqzUxP9ZjUv3nhIQ6yl5AkhLKfrPYDO9wP2iTjwuaHK160uXwZcwYCRytgh
 l9Jwk4IupXGCV3vZ6Eggv6zf1fJL1EBkjAc9V40uMaVKwznhKA9ANctrnmLFGnDK/luMYGZc0g8
 fGyy026bp0/uCnZAzkF+UE96ngvOl/uimO47/k9nHs22kiy7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

