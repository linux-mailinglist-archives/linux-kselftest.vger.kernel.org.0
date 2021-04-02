Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07533530AA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 23:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDBVVo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBVVm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 17:21:42 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C8C061788
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 14:21:41 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b127so6394181qkf.19
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ThhIgavQ3QZpAEeMwPl7LU8s6Fn+Ol8Um9bHUZC1FIM=;
        b=SqrIDiRXnjF7eFV3iokLp4OlLrQ9awzearwLVc02Kd4yRB2i+L41Dd34XfSKGo4Nvz
         gSAq6bsTlDwgL59uAOL7OBWT/l9Z51Wfz+YpmThfitH9RD5WNSatgh/F+ljt04RuWerW
         D/dzRJb/AFPXQOwRRrNQKxwC+aoFUWRfs/nu1LHtsl1LpDKqvMDhf44tiHX9cTC7Q+TN
         JE38LnzT2ed76DdQmpvbPwxg6eevo6/ICU5VFGhUNolcYzYNT+tNi3ytz8MQQqwxKVol
         U+4e2bJMKvksPyA8kugC4nnQA/POo7yniixfiCmodriX2UDJ2WpemdroRpxXTh/DK2oq
         jw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ThhIgavQ3QZpAEeMwPl7LU8s6Fn+Ol8Um9bHUZC1FIM=;
        b=USs65U0GQ2sXNTFAqFAvfPQiKkw/9gPKVV28pQYkaZhwmYs6rEEylAtGaQ5iRUtuPj
         XdNq2jbWKal68DULj0C/4RgI+FuffnxupPHusinOz+K8uKfgNx4881hMeayurWnu3oKM
         DECW+6v3++6Hmqgvwlpn/w+O3BCmIpYwHmHbF8wX1wHUgum92gpFO9rCfA4O7VlOMCjS
         uMjDwZHON/jWkjBZzoyepOoV3v5Gu7IwnizZO58eW5q3Ce8kyZmCuu3dXLB1FAdExTUi
         y/rYPzW96Wf6KnVCRe2X8wo9606El/i7E5iLs33foZB3pRnGSYkq/2orDfJTb2b2YvYR
         RU0A==
X-Gm-Message-State: AOAM533AIBXtCMsPapvMCR480dzFAtZGv6AwqiuPBEKbRz7hnPxSHIqz
        Ip5GA/Aun6TFrjrXi9M32Djjwg1NZsKolg==
X-Google-Smtp-Source: ABdhPJyHj02EBT41rUXRBbVkAHQsbz9IqMWxVYMlFUZYvEvuDsJjHnDsCqnBygwKcuypOJqT6TFCtAQ59PgD7g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:51c4:ce05:b8c5:b26b])
 (user=dlatypov job=sendgmr) by 2002:a0c:fd41:: with SMTP id
 j1mr14586328qvs.29.1617398500212; Fri, 02 Apr 2021 14:21:40 -0700 (PDT)
Date:   Fri,  2 Apr 2021 14:21:30 -0700
In-Reply-To: <20210402212131.835276-1-dlatypov@google.com>
Message-Id: <20210402212131.835276-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210402212131.835276-1-dlatypov@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 1/2] kunit: support failure from dynamic analysis tools
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, alan.maguire@oracle.com,
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
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test-bug.h | 29 +++++++++++++++++++++++++++++
 lib/kunit/test.c         | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
new file mode 100644
index 000000000000..ce6f6edc7801
--- /dev/null
+++ b/include/kunit/test-bug.h
@@ -0,0 +1,29 @@
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
+#if IS_BUILTIN(CONFIG_KUNIT)
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
+#endif /* _KUNIT_TEST_BUG_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..2f6cc0123232 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
@@ -16,6 +17,40 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+#if IS_BUILTIN(CONFIG_KUNIT)
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
+#endif
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -273,9 +308,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = test;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
 
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
@@ -624,9 +657,7 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = NULL;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
-- 
2.31.0.208.g409f899ff0-goog

