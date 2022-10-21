Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEFA60711A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJUHbb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJUHbW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 03:31:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363612475FC
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 00:31:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t17-20020a257811000000b006c509f9a16dso2381021ybc.10
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ukwd+W4yUObSSiJHNA3xBbGR2xkY62jRsxgv2DCjeM=;
        b=DDR1FZmXOPfNnIahF64Yl1WnL3w1ledFOway/UOkPmf59UO0S5M9JKyLb7LqsKBBpd
         SwCMN0yvBUeC/7w6TJ/3PGjpiP95babhe9PQdsYTzelfzTyOU7DqeUaiETnnKY4BmoOL
         w1/dLB+J3w06ZKSH6j+WQOc0tqOZVs/2oOSujKZManwU/mRZV7yVmh25nMuPRpQaajRx
         BjhLvJcwjN0tpVo/o6/yVDkW8ra/Bh1EoJPZsLTgtXWbUVLc4RD+8HlEe4wkDhP05eST
         71o0FtYoGrDlSlJYzSlgdegNH1hj2tS69LxMbieFLlSq+l2LMQe9IPxh2VkXIIxTrwv7
         KrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ukwd+W4yUObSSiJHNA3xBbGR2xkY62jRsxgv2DCjeM=;
        b=68e7HxYoQzvaXtTZ/TVGo1P9uy2Oh+qK3j8wDt0PuS1ub3/qWFPdZ3XqYgTzgUOHXq
         HC7PXekk6AYKNLZZqnCjxWg7nqIDcvjqhoH/610Crm7oC0KYZX0tx1/SAvFtUtoX8s8P
         TSVYQzQfpQZNxBX3SHDMAcZx8KXrj4Z/kJspMTCvLqNQlOO5PNfstfwm5L+v2hGNZj+C
         XiZ46VpFjyG+Y1zL3EdHbG2/7arCC878QdkphmZylTVm63JhE6Rj2segGhB/kXLMmsM/
         WcKlpvJd3s08mMo+TDjejumFLbR0gnVYh592uhCZptFPZh0jSzVXd6oYH227OoAtblG8
         YQkw==
X-Gm-Message-State: ACrzQf0GTU9J/chnR2RCiHDwUqYSKM576gO1dcwjJmt77n9Pz/GkW9sZ
        CSb+ARqJjfdDv9OAEguwjAKHWwsEOiHawQ==
X-Google-Smtp-Source: AMsMyM5R/AzkN9cwYEhav+L0OEzaKWiS2EE//NDTf7ZoZct9r8qpgWiVgwQhkG3Pyp7lj414XFyXnh8scXZ0jA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1003:b0:6bf:3ae4:7d31 with SMTP
 id w3-20020a056902100300b006bf3ae47d31mr15179638ybt.48.1666337474473; Fri, 21
 Oct 2022 00:31:14 -0700 (PDT)
Date:   Fri, 21 Oct 2022 15:28:55 +0800
In-Reply-To: <20221021072854.333010-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221021072854.333010-1-davidgow@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021072854.333010-2-davidgow@google.com>
Subject: [PATCH 2/2] kunit: Use the static key in kunit_fail_current_test()
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Speed up the case where kunit_fail_current_test() is called when no test
is running. This should make it convenient for code to call this
unconditionally in some error paths, without fear of causing a
performance problem.

If CONFIG_KUNIT=n, this compiles away to nothing. If CONFIG_KUNIT=y, it
will compile down to a NOP (on most architectures) if no KUnit test is
currently running. kunit_fail_current_test() does not work if KUnit
itself is built as a module, though this is a pre-existing limitation.

Note that the definition of kunit_fail_current_test() still wraps an
empty, inline function if KUnit is not built-in. This is to ensure that
the printf format string __attribute__ will still work.

Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test-bug.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 5fc58081d511..ba9558a9f9c0 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -9,16 +9,29 @@
 #ifndef _KUNIT_TEST_BUG_H
 #define _KUNIT_TEST_BUG_H
 
-#define kunit_fail_current_test(fmt, ...) \
-	__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
-
 #if IS_BUILTIN(CONFIG_KUNIT)
 
+#include <linux/jump_label.h> /* For static branch */
+
+/* Static key if KUnit is running any tests. */
+extern struct static_key_false kunit_running;
+
+#define kunit_fail_current_test(fmt, ...) do {					\
+	if (static_branch_unlikely(&kunit_running)) {				\
+		__kunit_fail_current_test(__FILE__, __LINE__,			\
+					  fmt, ##__VA_ARGS__);			\
+	} while (0)
+
+
 extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
 						    const char *fmt, ...);
 
 #else
 
+/* We define this with an empty helper function so format string warnings work */
+#define kunit_fail_current_test(fmt, ...) \
+		__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
 static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
 							    const char *fmt, ...)
 {
-- 
2.38.0.135.g90850a2211-goog

