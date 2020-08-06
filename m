Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB823E33F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Aug 2020 22:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgHFUhy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUhx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 16:37:53 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00FC061574;
        Thu,  6 Aug 2020 13:37:53 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p13so13120947ilh.4;
        Thu, 06 Aug 2020 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EUQnG2l6qLmqDOtR01uNvp1OtWUBbv6CVlH5VJ/upA=;
        b=P2gEUSsMof7b6ViogZD3uCFVls5nvq48VK5f43Z803L0yET33De0snU8QwhvEUD6jZ
         LNR6Phk87IzjP9m63CEx7i0Vl3JIgiNmaftlP8CcJ2kvQLrg5GVPVvyS44fGT8TA5nMw
         493YKRu4aZMSl5RZgeLLi6VEbTdD9a7MHadyLFQUiaO2QQ/0jpZBcFs42EerbWyC1oM4
         tlICyYpt6QpPHsQMAZwf7S+xt4FdEe7rwcPn+qXEVnJl6LNFZGmb/ZgSZmlTdmlhhb0z
         KWgRelHdl2jgX985FY/rasAD/FKOYBbhlDiVlPKZxGxXOc7kZdj4y94amZkO0NrIehxN
         925w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EUQnG2l6qLmqDOtR01uNvp1OtWUBbv6CVlH5VJ/upA=;
        b=H0kt9EtbQA1W8HjRrg1CyHwGWwc3+ujcuFyF9j6nO8Gu+DJS142LoqR5U22Nm2o6g1
         n+nBTUIlgLig/Javw5u4P7t45p4w/jooxG6EL9mUHzcbKUQ3Ou3cmI4VP4JrI1xwVpkt
         Mr4Ku57hEdXtZBL6ULfNgraQkwdvXV9wPKQNRP3yJM3yr6+i7loY38vfVa9iM/NnGxg7
         M0pLMS+/9Yw7AX8OCDO+ttP0S9ETl+1OmKA/F3yGaMj8rhJg+R/oju7Wga3qDIxL5X5q
         xNZLRbiUXDtMkHUAdcDE5ahdaI3KaSJVe30GGcJGuUFDCXgqJXz33MyM7oNBEra0oI/g
         xE/Q==
X-Gm-Message-State: AOAM530KJR4mtfzRHV1VShCIwuywfr7VHfH9qM/S4EPJHrqQKArxTLRg
        5IL9xNEtm81gytPV/QiWv/c=
X-Google-Smtp-Source: ABdhPJxduj7u+Yg2hpoz2CG1rr2Wdw7xb72k4gFDEdDT3fWpRLg8zaMww4XHzfoQBwbnVt67egcjsw==
X-Received: by 2002:a92:d40f:: with SMTP id q15mr882407ilm.208.1596746272969;
        Thu, 06 Aug 2020 13:37:52 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id g15sm4198666ilb.37.2020.08.06.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 13:37:52 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     urielguajardo@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: added lockdep support
Date:   Thu,  6 Aug 2020 20:37:37 +0000
Message-Id: <20200806203737.3636830-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

KUnit tests will now fail if lockdep detects an error during a test
case.

The idea comes from how lib/locking-selftest [1] checks for lock errors: we
first if lock debugging is turned on. If not, an error must have
occurred, so we fail the test and restart lockdep for the next test case.

Like the locking selftests, we also fix possible preemption count
corruption from lock bugs.

Depends on kunit: support failure from dynamic analysis tools [2]

[1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137

[2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 lib/kunit/test.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d8189d827368..0838ececa005 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,8 @@
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/lockdep.h>
+#include <linux/debug_locks.h>
 
 #include "debugfs.h"
 #include "string-stream.h"
@@ -22,6 +24,26 @@ void kunit_fail_current_test(void)
 		kunit_set_failure(current->kunit_test);
 }
 
+static inline void kunit_check_locking_bugs(struct kunit *test,
+					    unsigned long saved_preempt_count)
+{
+	preempt_count_set(saved_preempt_count);
+#ifdef CONFIG_TRACE_IRQFLAGS
+	if (softirq_count())
+		current->softirqs_enabled = 0;
+	else
+		current->softirqs_enabled = 1;
+#endif
+#if IS_ENABLED(CONFIG_LOCKDEP)
+	local_irq_disable();
+	if (!debug_locks) {
+		kunit_set_failure(test);
+		lockdep_reset();
+	}
+	local_irq_enable();
+#endif
+}
+
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -289,6 +311,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit *test = ctx->test;
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
+	unsigned long saved_preempt_count = preempt_count();
 
 	current->kunit_test = test;
 
@@ -298,7 +321,8 @@ static void kunit_try_run_case(void *data)
 	 * thread will resume control and handle any necessary clean up.
 	 */
 	kunit_run_case_internal(test, suite, test_case);
-	/* This line may never be reached. */
+	/* These lines may never be reached. */
+	kunit_check_locking_bugs(test, saved_preempt_count);
 	kunit_run_case_cleanup(test, suite);
 }
 
-- 
2.28.0.236.gb10cc79966-goog

