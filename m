Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486B67F562
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jan 2023 08:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjA1HKT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Jan 2023 02:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjA1HKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Jan 2023 02:10:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB9C83948
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 23:10:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o1-20020a252801000000b0080b8600bdc9so7672712ybo.3
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jan 2023 23:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/EMH0Ldd1TRcRRXQQGs+U4ISuantkAcuRVQFaojJ8SY=;
        b=OpvNC/nRRZIMomGzk0lV9qkMFIz3snFXRTRU1Z0PL2k2g6gRfkf9cjnDCML6v1ZX4M
         8wlTdTcayRsvkmccl05flVx7GALL3v3j5hp8l8A8Hmnh4RYq5GvJHVzC5dMlz3KgcQGB
         aXtKLYMsJWyLfgMaN/nFhyRJERf4d1tpVHk+9JvqIL/Oy4MDFPsrP9tXLKKVPS62h+rS
         /OjqsHj5L0VnvIlphp2wq94ZYy2H6Z9lyBWSOISgg7iNdCQTUlbxavBu7BZlHcHR63uz
         aHnHBW/JFY0W0jfr80l/q0jD2zwPnbK5ZmZQFvd3siuB0K+PKkKBs1NXOrDwFOyN0Zge
         2foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EMH0Ldd1TRcRRXQQGs+U4ISuantkAcuRVQFaojJ8SY=;
        b=Emlgl3GTPlpgCMeoKJ1ZRb6PCLmwV/zVAD0/57bXGtGE6AiTFy+cUgCBl3/FNCA1O2
         rrmMKh4qhzWTMCJ1wH25hftdshCdlACY5FKKx6PtxermAVTHdhv/XjzGIC4DmCKRzmmO
         ixWlEXGOWOAR8GW+EPBbmXxmhCNQAA+IQFIDNOd7c52KeFvVM6V/1JeE74vr4VVK+oV5
         0OnN1cpg8xpG4m5rpuCtp0tPP2HpY7mT8srNo8nHUmruPjXkmrCqx5/vgEspszR/iC2v
         xj3aDgNacfQ+1KuBDwUXGEXFfZI8V2nU5fvvKPz/qXe82PV8VPVPUkvvOGVg0nbndPTe
         FZew==
X-Gm-Message-State: AO0yUKWl8S7/n0M8AVBjP32qk+JW3l0xbdF3r28Prt1OvZZwF6A4dXZu
        Sx7D7zb6aYfKXbq//K0DHlM4DE9hbvDmQQ==
X-Google-Smtp-Source: AK7set+1rky1lVKTiFPCK30v3Mavdt0T1E/d05fs4/WI6IJc+Ftidyq+1yW6ePNKUAhyI3TodUOxqiMEXiilJQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d346:0:b0:50f:929a:878e with SMTP id
 v67-20020a0dd346000000b0050f929a878emr39453ywd.217.1674889814763; Fri, 27 Jan
 2023 23:10:14 -0800 (PST)
Date:   Sat, 28 Jan 2023 15:10:07 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230128071007.1134942-1-davidgow@google.com>
Subject: [PATCH] kunit: Add "hooks" to call into KUnit when it's built as a module
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

KUnit has several macros and functions intended for use from non-test
code. These hooks, currently the kunit_get_current_test() and
kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.

In order to support this case, the required functions and static data
need to be available unconditionally, even when KUnit itself is not
built-in. The new 'hooks.c' file is therefore always included, and has
both the static key required for kunit_get_current_test(), and a table
of function pointers in struct kunit_hooks_table. This is filled in with
the real implementations by kunit_install_hooks(), which is kept in
hooks-impl.h and called when the kunit module is loaded.

This can  be extended for future features which require similar
"hook" behaviour, such as static stubs, by simply adding new entries to
the struct, and the appropriate code to set them.
Signed-off-by: David Gow <davidgow@google.com>
---

This is basically a prerequisite for the stub features working when
KUnit is built as a module, and should nicely make a few other tests
work, too.

This version uses a struct, rather than a bunch of separate function
pointers, to define the list of hooks in one place. It also doesn't use
the macro magic from RFC v2 (which we could reintroduce later if we end
up with enough hooks that it'd make sense). It does get rid of all of
the nasty checkpatch.pl warnings, though, save for:

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#230: FILE: lib/kunit/hooks.c:16:
+EXPORT_SYMBOL(kunit_running);

This is a false-positive, as the EXPORT_SYMBOL() immediately follows the
DEFINE_STATIC_KEY_FALSE() macro, which checkpatch doesn't recognise as a
definition.

Cheers,
-- David

Changes since RFC v2:
https://lore.kernel.org/linux-kselftest/20230124080350.2275652-1-davidgow@google.com/
- Get rid of the macro magic, and keep the function pointers in a
  struct.
  - Also, reset them to NULL using memset, so we don't need to loop
    through all of them manually.
  - Thanks Daniel!
- Properly forward-declare all of the implementations, now in
  "hooks-impl.h", so they can easily be split across different files.
  (Needed for the stubs implementation.)
- Extract the stub installation into a separate function,
  kunit_install_hooks().
  - Thanks Daniel!

Changes since RFC v1:
https://lore.kernel.org/all/20230117142737.246446-1-davidgow@google.com/
- Major refit to auto-generate the hook code using macros.
- (Note that previous Reviewed-by tags have not been added, as this is a
  big enough change it probably needs a re-reviews. Thanks Rae for
  reviewing RFC v1 previously, though!)

---
 Documentation/dev-tools/kunit/usage.rst | 14 ++++++-------
 include/kunit/test-bug.h                | 28 +++++++++----------------
 lib/Makefile                            |  8 +++++++
 lib/kunit/Makefile                      |  3 +++
 lib/kunit/hooks-impl.h                  | 27 ++++++++++++++++++++++++
 lib/kunit/hooks.c                       | 21 +++++++++++++++++++
 lib/kunit/test.c                        | 14 ++++++-------
 7 files changed, 82 insertions(+), 33 deletions(-)
 create mode 100644 lib/kunit/hooks-impl.h
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
index c1b2e14eab64..2b505a95b641 100644
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
@@ -17,6 +17,11 @@
 /* Static key if KUnit is running any tests. */
 DECLARE_STATIC_KEY_FALSE(kunit_running);
 
+/* Hooks table: a table of function pointers filled in when kunit loads */
+extern struct kunit_hooks_table {
+	__printf(3, 4) void (*fail_current_test)(const char*, int, const char*, ...);
+} kunit_hooks;
+
 /**
  * kunit_get_current_test() - Return a pointer to the currently running
  *			      KUnit test.
@@ -43,33 +48,20 @@ static inline struct kunit *kunit_get_current_test(void)
  * kunit_fail_current_test() - If a KUnit test is running, fail it.
  *
  * If a KUnit test is running in the current task, mark that test as failed.
- *
- * This macro will only work if KUnit is built-in (though the tests
- * themselves can be modules). Otherwise, it compiles down to nothing.
  */
 #define kunit_fail_current_test(fmt, ...) do {					\
 		if (static_branch_unlikely(&kunit_running)) {			\
-			__kunit_fail_current_test(__FILE__, __LINE__,		\
+			/* Guaranteed to be non-NULL when kunit_running true*/	\
+			kunit_hooks.fail_current_test(__FILE__, __LINE__,	\
 						  fmt, ##__VA_ARGS__);		\
 		}								\
 	} while (0)
 
-
-extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
-						    const char *fmt, ...);
-
 #else
 
 static inline struct kunit *kunit_get_current_test(void) { return NULL; }
 
-/* We define this with an empty helper function so format string warnings work */
-#define kunit_fail_current_test(fmt, ...) \
-		__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
-
-static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
-							    const char *fmt, ...)
-{
-}
+#define kunit_fail_current_test(fmt, ...) do {} while (0)
 
 #endif
 
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..55fd04a7d0fb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -126,6 +126,14 @@ CFLAGS_test_fpu.o += $(FPU_CFLAGS)
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
 obj-$(CONFIG_KUNIT) += kunit/
+# Include the KUnit hooks unconditionally. They'll compile to nothing if
+# CONFIG_KUNIT=n, otherwise will be a small table of static data (static key,
+# function pointers) which need to be built-in even when KUnit is a module.
+ifeq ($(CONFIG_KUNIT), m)
+obj-y += kunit/hooks.o
+else
+obj-$(CONFIG_KUNIT) += kunit/hooks.o
+endif
 
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
diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
new file mode 100644
index 000000000000..d911f40f76db
--- /dev/null
+++ b/lib/kunit/hooks-impl.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Declarations for hook implementations.
+ *
+ * These will be set as the function pointers in struct kunit_hook_table,
+ * found in include/kunit/test-bug.h.
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#ifndef _KUNIT_HOOKS_IMPL_H
+#define _KUNIT_HOOKS_IMPL_H
+
+#include <kunit/test-bug.h>
+
+/* List of declarations. */
+void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...);
+
+/* Code to set all of the function pointers. */
+static inline void kunit_install_hooks(void)
+{
+	/* Install the KUnit hook functions. */
+	kunit_hooks.fail_current_test = __kunit_fail_current_test_impl;
+}
+
+#endif /* _KUNIT_HOOKS_IMPL_H */
diff --git a/lib/kunit/hooks.c b/lib/kunit/hooks.c
new file mode 100644
index 000000000000..365d98d4953c
--- /dev/null
+++ b/lib/kunit/hooks.c
@@ -0,0 +1,21 @@
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
+
+#include <kunit/test-bug.h>
+
+DEFINE_STATIC_KEY_FALSE(kunit_running);
+EXPORT_SYMBOL(kunit_running);
+
+/* Function pointers for hooks. */
+struct kunit_hooks_table kunit_hooks;
+EXPORT_SYMBOL(kunit_hooks);
+
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9ebf975e56b..51cae59d8aae 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -17,16 +17,14 @@
 #include <linux/sched.h>
 
 #include "debugfs.h"
+#include "hooks-impl.h"
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
-DEFINE_STATIC_KEY_FALSE(kunit_running);
-
-#if IS_BUILTIN(CONFIG_KUNIT)
 /*
- * Fail the current test and print an error message to the log.
+ * Hook to fail the current test and print an error message to the log.
  */
-void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
+void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
 {
 	va_list args;
 	int len;
@@ -53,8 +51,6 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
 	kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
 	kunit_kfree(current->kunit_test, buffer);
 }
-EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
-#endif
 
 /*
  * Enable KUnit tests to run.
@@ -777,6 +773,9 @@ EXPORT_SYMBOL_GPL(kunit_cleanup);
 
 static int __init kunit_init(void)
 {
+	/* Install the KUnit hook functions. */
+	kunit_install_hooks();
+
 	kunit_debugfs_init();
 #ifdef CONFIG_MODULES
 	return register_module_notifier(&kunit_mod_nb);
@@ -788,6 +787,7 @@ late_initcall(kunit_init);
 
 static void __exit kunit_exit(void)
 {
+	memset(&kunit_hooks, 0, sizeof(kunit_hooks));
 #ifdef CONFIG_MODULES
 	unregister_module_notifier(&kunit_mod_nb);
 #endif
-- 
2.39.1.456.gfc5497dd1b-goog

