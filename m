Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA6315A35
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 00:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhBIXqH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 18:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhBIWR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1544C0613D6
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Feb 2021 14:14:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so72488ybq.8
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Feb 2021 14:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FksUH3gzUTnxzcXLhXFHDpBYlwkRQKcQhX6p2RM3I1E=;
        b=ZI3fF92XQ/c/7Argvkffd5cGw44JDHvSJrw+3zY1VEVrdR8k3c79CxuhqnhWbPf9qd
         IsvfT36N1aymovSX16Q93384NfoQ5yc8q2ydqht0kCn0B0ecs7Xe/8cLWP7HBSrmzvp8
         +Nxno6ruYlQuSjXqTeZprJjGOuGofmIaIXt6syiNT1hKJVZG5Q1x8w8dFchXL05Cm5KK
         tjeMGlCCoaUzijeSwDn8L2Sviu0nmRqmfHAbzaY8+kwGNRGZzs2UbClhfTSSC23rNm6j
         5mz95hXRgGNPjYZhN2Ki9A6M6qiWOXHgM3XtuPqQoXS+iUgLowmqo/TUown5/xlN/S4l
         rnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FksUH3gzUTnxzcXLhXFHDpBYlwkRQKcQhX6p2RM3I1E=;
        b=X21U/kqazFvByVmNKx2IKqITjr2ClsTJkJXoaPxCZNSShrVLDtcvsPGdrATmAWrOVz
         rSmrMs1jYpKNsyZRlh1xJVf8zCtXfrz2u/KOU9cWI7n99w6K0kxfDRDysRa68RD3CeIh
         zauFZKusEl1Kmuie0zDknjzKt6dF3rUahYQbrwrSZ4P+vMKxxh9HYTM7dtGVr5gE7bLS
         SK57l/zuVRI79uHo/wC8/1eA7lvITpYDmrSMrY9NUTDz4+FhoYHmlp6UH8T2yk/rCv8r
         HbxuHm6CZDrKQncbfiGs/IJ1GvgNmaY8E3G+StJ3xskyoyv8SECPQOo927VsNYxWLc/H
         9+PA==
X-Gm-Message-State: AOAM532WPgYsPxPIqEZCfjM7JYE4Mc9buxduflYVZTHtsv5htSttJ3ip
        A8W92+eo7jHUN9M75J5JxQddJZDpWP1tCA==
X-Google-Smtp-Source: ABdhPJyKpESoZGnG9Agt2u+k8o+dn1uygyQcZvrmGpStiXqKFG8cbIg1NF/T5P4xg271BDjT3rsyRwf2cmFqmw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7dd9:967f:92f4:2aae])
 (user=dlatypov job=sendgmr) by 2002:a25:2e12:: with SMTP id
 u18mr31120ybu.486.1612908898193; Tue, 09 Feb 2021 14:14:58 -0800 (PST)
Date:   Tue,  9 Feb 2021 14:14:42 -0800
In-Reply-To: <20210209221443.78812-1-dlatypov@google.com>
Message-Id: <20210209221443.78812-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210209221443.78812-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 1/2] kunit: support failure from dynamic analysis tools
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
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

* Declare the helper function for nice __printf() warnings about mismatched
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
 lib/kunit/test.c         | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
new file mode 100644
index 000000000000..18b1034ec43a
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
+	__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+#if IS_ENABLED(CONFIG_KUNIT)
+
+extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
+						    const char *fmt, ...);
+
+#else
+
+static __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
+						    const char *fmt, ...)
+{
+}
+
+#endif
+
+
+#endif /* _KUNIT_TEST_BUG_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..5794059505cf 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
@@ -16,6 +17,38 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+/*
+ * Fail the current test and print an error message to the log.
+ */
+void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
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
+EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -273,9 +306,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = test;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
 
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
@@ -624,9 +655,7 @@ void kunit_cleanup(struct kunit *test)
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

