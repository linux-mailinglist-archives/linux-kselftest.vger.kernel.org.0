Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091A166E0A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 15:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjAQO3c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjAQO2r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 09:28:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32040BDD
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 06:27:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k204-20020a256fd5000000b007b8b040bc50so32122880ybc.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q97VF8NLGEs9PE4UKeXR3rbvcRcYjN9CJM8wH6ofy84=;
        b=FmoV5WYz0qwnePwBFdlNoK4CUtnyyRuRxawHl+0vkISi8NdBWuzt49tLUlbs23zHWp
         sITaxDfma4AMyNdWqKRiUb54ldWHCL73OIftRlNJ4UAHVtvy6S3axPzQx8y5IeYRwDhQ
         HXtBnp0VdMjklIwTyNhJcygHYZgUT10p2dbUxbGgYjUvCtC7Er6VIoPDV3LVU4TGjOFD
         e/SMiUzzz/zvgIUxJxKPdMEP9KRzmBI9kG/lsjwN7tvCFmezIsaDgem1IgG+Ey7XUBgM
         STNPPToOTXgE9Az7GmsIExprYkAQ0LN4FHJdqUh32qG4t0IRGbufj7rhjLrdZR/3z+Y7
         Jdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q97VF8NLGEs9PE4UKeXR3rbvcRcYjN9CJM8wH6ofy84=;
        b=qwtZyxGNNlAHqc5eLt8iPc9UR3KMuHc+tt9fAi5Meq9jFwiQihnRVoVyC1RLsj8WAq
         EV4kJNRBAyKsAflObtPcmbN6dbwi615VmEAa0QlPR4SnqJimCiybHJ0f2dMcZnvxUCXH
         BTX9P9KnfvGU6ZoVpFd869BOiDyzyoE0bRzgcUb1Ybutq+SIbwMiRNdUaNZlqPHmVJlR
         1kA01Ptm/5fmQyejOGj7mBG4s+mqfJXTMW+v9BEMCt+YKYPPddZ5fXg9u3qOAyqiBfYN
         3CHZzhTl2jzWz8639Rcie2yJ+ouaQsu2U/yP94jAZbuQkTVYWVCAktncxDB43GUfKDHK
         +nIw==
X-Gm-Message-State: AFqh2krNPrAFZhqgQ0L8vtOaGZ76aSu9EaU37O/t2ZZK0qySvOt0u1+Z
        YMjV9kJE1NL5bYH324AVLfSDEK7nCiVsdg==
X-Google-Smtp-Source: AMrXdXsC3yFeKWSdjSmrrXevJVoKd6MCUmYT8lIE0srFZnKm4kaw/HfGVYMQ3a/x9eKNqyaGrCoCHFzwnvgR7g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:683:b0:7e3:553a:11fb with SMTP
 id i3-20020a056902068300b007e3553a11fbmr321620ybt.387.1673965666393; Tue, 17
 Jan 2023 06:27:46 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:27:37 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230117142737.246446-1-davidgow@google.com>
Subject: [RFC PATCH] kunit: Add "hooks" to call into KUnit when it's built as
 a module
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit has several macros and functions intended for use from non-test
code. These hooks, currently the kunit_get_current_test() and
kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.

In order to support this case, the required functions and static data
need to be available unconditionally, even when KUnit itself is not
built-in. The new 'hooks.c' file is therefore always included, and has
both the static key required for kunit_get_current_test(), and a
function pointer to the real implementation of
__kunit_fail_current_test(), which is populated when the KUnit module is
loaded.

This can then be extended for future features which require similar
"hook" behaviour, such as static stubs:
https://lore.kernel.org/all/20221208061841.2186447-1-davidgow@google.com/

Signed-off-by: David Gow <davidgow@google.com>
---

This is basically a prerequisite for the stub features working when
KUnit is built as a module, and should nicely make a few other tests
work then, too.

I'm not 100% sold on the whole "fill in a table of function pointers
when kunit.ko is loaded" trick: it is basically just working around the
sensible limitations on depending on modules. I think it should be safe
here, as the functions/macros all have fallback behaviour when no test
is running, and this is just another case of that.

Similarly, I'm sure there must be a better way to compile hooks.o in
when KUNIT=y or KUNIT=m, but the trick of adding it separately as an
obj-y in the lib/ Makefile, then having an #if IS_ENABLED() check in the
file is the only one I've been able to come up with using my meagre
knowledge of Kbuild. Better suggestions welcome!
---
 Documentation/dev-tools/kunit/usage.rst | 14 ++++++--------
 include/kunit/test-bug.h                | 15 ++++++++-------
 lib/Makefile                            |  4 ++++
 lib/kunit/Makefile                      |  3 +++
 lib/kunit/hooks.c                       | 23 +++++++++++++++++++++++
 lib/kunit/test.c                        | 10 ++++------
 6 files changed, 48 insertions(+), 21 deletions(-)
 create mode 100644 lib/kunit/hooks.c

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 48f8196d5aad..6424493b93cb 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -648,10 +648,9 @@ We can do this via the ``kunit_test`` field in ``task_struct``, which we can
 access using the ``kunit_get_current_test()`` function in ``kunit/test-bug.h``.
 
 ``kunit_get_current_test()`` is safe to call even if KUnit is not enabled. If
-KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
-running in the current task, it will return ``NULL``. This compiles down to
-either a no-op or a static key check, so will have a negligible performance
-impact when no test is running.
+KUnit is not enabled, or if no test is running in the current task, it will
+return ``NULL``. This compiles down to either a no-op or a static key check,
+so will have a negligible performance impact when no test is running.
 
 The example below uses this to implement a "mock" implementation of a function, ``foo``:
 
@@ -726,8 +725,7 @@ structures as shown below:
 	#endif
 
 ``kunit_fail_current_test()`` is safe to call even if KUnit is not enabled. If
-KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
-running in the current task, it will do nothing. This compiles down to either a
-no-op or a static key check, so will have a negligible performance impact when
-no test is running.
+KUnit is not enabled, or if no test is running in the current task, it will do
+nothing. This compiles down to either a no-op or a static key check, so will
+have a negligible performance impact when no test is running.
 
diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index c1b2e14eab64..122f50198903 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * KUnit API allowing dynamic analysis tools to interact with KUnit tests
+ * KUnit API providing hooks for non-test code to interact with tests.
  *
  * Copyright (C) 2020, Google LLC.
  * Author: Uriel Guajardo <urielguajardo@google.com>
@@ -9,7 +9,7 @@
 #ifndef _KUNIT_TEST_BUG_H
 #define _KUNIT_TEST_BUG_H
 
-#if IS_BUILTIN(CONFIG_KUNIT)
+#if IS_ENABLED(CONFIG_KUNIT)
 
 #include <linux/jump_label.h> /* For static branch */
 #include <linux/sched.h>
@@ -43,20 +43,21 @@ static inline struct kunit *kunit_get_current_test(void)
  * kunit_fail_current_test() - If a KUnit test is running, fail it.
  *
  * If a KUnit test is running in the current task, mark that test as failed.
- *
- * This macro will only work if KUnit is built-in (though the tests
- * themselves can be modules). Otherwise, it compiles down to nothing.
  */
 #define kunit_fail_current_test(fmt, ...) do {					\
 		if (static_branch_unlikely(&kunit_running)) {			\
+			/* Guaranteed to be non-NULL when kunit_running true*/	\
 			__kunit_fail_current_test(__FILE__, __LINE__,		\
 						  fmt, ##__VA_ARGS__);		\
 		}								\
 	} while (0)
 
 
-extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
-						    const char *fmt, ...);
+/* Function pointer defined as a hook in hooks.c, and implemented in test.c */
+typedef __printf(3, 4) void kunit_hook_fn_fail_current_test(const char *file,
+							    int line,
+							    const char *fmt, ...);
+extern kunit_hook_fn_fail_current_test *__kunit_fail_current_test;
 
 #else
 
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..9031de6ca73c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -126,6 +126,10 @@ CFLAGS_test_fpu.o += $(FPU_CFLAGS)
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
 obj-$(CONFIG_KUNIT) += kunit/
+# Include the KUnit hooks unconditionally. They'll compile to nothing if
+# CONFIG_KUNIT=n, otherwise will be a small table of static data (static key,
+# function pointers) which need to be built-in even when KUnit is a module.
+obj-y += kunit/hooks.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 29aff6562b42..deeb46cc879b 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -11,6 +11,9 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
 
+# KUnit 'hooks' are built-in even when KUnit is built as a module.
+lib-y +=				hooks.o
+
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 
 # string-stream-test compiles built-in only.
diff --git a/lib/kunit/hooks.c b/lib/kunit/hooks.c
new file mode 100644
index 000000000000..48189567a774
--- /dev/null
+++ b/lib/kunit/hooks.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit 'Hooks' implementation.
+ *
+ * This file contains code / structures which should be built-in even when
+ * KUnit itself is built as a module.
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+/* This file is always built-in, so make sure it's empty if CONFIG_KUNIT=n */
+#if IS_ENABLED(CONFIG_KUNIT)
+
+#include <kunit/test-bug.h>
+
+DEFINE_STATIC_KEY_FALSE(kunit_running);
+EXPORT_SYMBOL(kunit_running);
+
+/* Function pointers for hooks. */
+kunit_hook_fn_fail_current_test *__kunit_fail_current_test;
+EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
+#endif
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9ebf975e56b..711fdcce6de8 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -20,13 +20,10 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
-DEFINE_STATIC_KEY_FALSE(kunit_running);
-
-#if IS_BUILTIN(CONFIG_KUNIT)
 /*
  * Fail the current test and print an error message to the log.
  */
-void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
+void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
 {
 	va_list args;
 	int len;
@@ -53,8 +50,6 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
 	kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
 	kunit_kfree(current->kunit_test, buffer);
 }
-EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
-#endif
 
 /*
  * Enable KUnit tests to run.
@@ -777,6 +772,9 @@ EXPORT_SYMBOL_GPL(kunit_cleanup);
 
 static int __init kunit_init(void)
 {
+	/* Install the KUnit hook functions. */
+	__kunit_fail_current_test = __kunit_fail_current_test_impl;
+
 	kunit_debugfs_init();
 #ifdef CONFIG_MODULES
 	return register_module_notifier(&kunit_mod_nb);
-- 
2.39.0.314.g84b9a713c41-goog

