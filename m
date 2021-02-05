Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3473119AC
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 04:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBFDP3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 22:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhBFCpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:45:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A651C08ED9B
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:53:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e12so5263232plh.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Z0L4KRAp/unRkOGmt9I23plvEx27DzuKEm7py6O/w2c=;
        b=Q/ylOrtnRFmhjo9UCHitPuV4px2gXSP3MyCkyK+8+ls84iMRRS8OSAZT7cH2+oiC85
         hK620e8iS574lWbuv5JxnZ7APAJf4nZAIWEd43/p/6pAsI/fo1+SAr+zUO2u0laRWBYx
         y2c09NYhhLhhAUKC5VGZI8rQ36+17Mnd62CbFTQ5/8u2Nh47Y9pw49hdyWrKmhfeSWw5
         MbTQc1z+guqOHAqgsPk5cC5eSMkaN/+FhOkN/Cjbnv4tNCqtAeNF1Xe7P00pWgCkToVQ
         zz1WuEZcm1oz39irvTQl2BBHGYwaYsv/lVQnwBKhRBMOEH14m8b9lM/DHYrm2mQ7Jjh/
         3cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z0L4KRAp/unRkOGmt9I23plvEx27DzuKEm7py6O/w2c=;
        b=PtNx0t6nrHXH/TFTlcClypghaKliPqG5SqwprTzOrbOoZun8EOeS8NsoTTYw/HKO8C
         hxqE80Pzwqiynccfoh9cojasn54lRm6NTx7KrWelXH/4AnGTXV0n5cnYcdyxabOzXG0/
         ccay3/1ACqUW0mlsOMqKWB2erpAnVS9RYBPCmMLIKEhBXkGYZcKLBKFsxUkmZuFSCCZJ
         1mxV0enHl9sOrHLeopg479nNhYe9NGoG/36fqd0zixWL6Lh4/b3BB0fTMD+Fb1iJb0aJ
         puGRBqS1R6qd/+0Ll8U2xdJ9V12YIgd8L1iUL9rOMjZ4BrKeecvVZd/cOIyuMwgyYErh
         9cjw==
X-Gm-Message-State: AOAM531w9d1Qi18IkGql8lRXE1L1SuThEoACFkba3DRAVuh6+iF324OW
        9PsnUAQv5NrrN/PtD+EloTO04Hc5MQ3JiQ==
X-Google-Smtp-Source: ABdhPJxBzkKo3NS6X7dAHuQXnMT2IDWsDkdxHihebGkVGPdwlTmzXlj0sYtK7nI74cpy2BCyLE0UvHjzAmgA5w==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a17:902:ab83:b029:e1:6021:dd19 with SMTP
 id f3-20020a170902ab83b02900e16021dd19mr6174824plr.40.1612569190908; Fri, 05
 Feb 2021 15:53:10 -0800 (PST)
Date:   Fri,  5 Feb 2021 15:53:01 -0800
In-Reply-To: <20210205235302.2022784-1-dlatypov@google.com>
Message-Id: <20210205235302.2022784-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210205235302.2022784-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 1/2] kunit: support failure from dynamic analysis tools
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org,
        Uriel Guajardo <urielguajardo@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Add a kunit_fail_current_test() function to fail the currently running
test, if any, with an error message.

This is largely intended for dynamic analysis tools like UBSAN and for
fakes.
E.g. say I had a fake ops struct for testing and I wanted my `free`
function to complain if it was called with an invalid argument, or
caught a double-free. Most return void and have no normal means of
signalling failure (e.g. super_operations, iommu_ops, etc.).

Key points:
* Always update current->kunit_test so anyone can use it.
  * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
  CONFIG_KASAN=y

* Create a new header <kunit/test-bug.h> so non-test code doesn't have
to include all of <kunit/test.h> (e.g. lib/ubsan.c)

* Forward the file and line number to make it easier to track down
failures

* Declare it as a function for nice __printf() warnings about mismatched
format strings even when KUnit is not enabled.

Example output from kunit_fail_current_test("message"):
[15:19:34] [FAILED] example_simple_test
[15:19:34]     # example_simple_test: initializing
[15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
[15:19:34]     not ok 1 - example_simple_test

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
 lib/kunit/test.c         | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
new file mode 100644
index 000000000000..4963ed52c2df
--- /dev/null
+++ b/include/kunit/test-bug.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API allowing dynamic analysis tools to interact with KUnit tests
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Uriel Guajardo <urielguajardo@google.com>
+ */
+
+#ifndef _KUNIT_TEST_BUG_H
+#define _KUNIT_TEST_BUG_H
+
+#define kunit_fail_current_test(fmt, ...) \
+	_kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+#if IS_ENABLED(CONFIG_KUNIT)
+
+extern __printf(3, 4) void _kunit_fail_current_test(const char *file, int line,
+						    const char *fmt, ...);
+
+#else
+
+static __printf(3, 4) void _kunit_fail_current_test(const char *file, int line,
+						    const char *fmt, ...)
+{
+}
+
+#endif
+
+
+#endif /* _KUNIT_TEST_BUG_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..7b16aae0ccae 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
@@ -16,6 +17,37 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+/*
+ * Fail the current test and print an error message to the log.
+ */
+void _kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+	char *buffer;
+
+	if (!current->kunit_test)
+		return;
+
+	kunit_set_failure(current->kunit_test);
+
+	/* kunit_err() only accepts literals, so evaluate the args first. */
+	va_start(args, fmt);
+	len = vsnprintf(NULL, 0, fmt, args) + 1;
+	va_end(args);
+
+	buffer = kunit_kmalloc(current->kunit_test, len, GFP_KERNEL);
+	if (!buffer)
+		return;
+
+	va_start(args, fmt);
+	vsnprintf(buffer, len, fmt, args);
+	va_end(args);
+
+	kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
+	kunit_kfree(current->kunit_test, buffer);
+}
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -273,9 +305,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = test;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
 
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
@@ -624,9 +654,7 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = NULL;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
-- 
2.30.0.478.g8a0d178c01-goog

