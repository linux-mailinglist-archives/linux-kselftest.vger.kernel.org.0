Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D3638566
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKYIna (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 03:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiKYInX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 03:43:23 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF321E3B
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:43:19 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id bw25-20020a056a00409900b0056bdd4f8818so2672374pfb.15
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZjU2MsmtOWFt45ca4T4N4qO/2tLBYtkgkbkS/1130g=;
        b=Jz9X3GqyXfdaQFPAvZus+JfiaUfvrK+PTWtIQ46DEZwX2V1lpUaaEg1rwdRudkxdm/
         2C8Iv/8oOAZdgWfc2j/LWvrirBFeaJ3gusFKX9mamV9+JD+P3jQesXSiTn9AET4ROn+T
         kRojtpdpAp4L9DjnrtlUeiHFjlGiboo33uvFvuSFEe8Kbf0LhOi/JhBMR303thfHs8Vj
         S1nwCJ/j0ItiVr6A1msR9FtXwxUiKSxARW16/qW0bSuJc0CtBCV0U+/BkAieYhNxv2vk
         7qgcvCrZyWjMwRH806FaXWsKERJ63Fv568yLGX/QFo+6Qir5KUmUtX148QYXEtqJ3ELE
         jnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZjU2MsmtOWFt45ca4T4N4qO/2tLBYtkgkbkS/1130g=;
        b=k74ZDRrkv0i4JZMeraCu1FYXZlIEVg75+XyyxigTjpQnjohmrZyVjMdILS4ZesV5xi
         NL+2oLtA6iKG9U1jE9H3GkhsytP0AI8Bmpu4k32fQ/MBOYjoFC0lbz3c1UEFeYojIz4E
         hhYycmCXhKAmkiPt8G0XrC5SRu9IdTHJFm+YV6N5wcvGYw9MelndhCZp+1u/UBsJ1w8O
         eWVh5CM2t6evBcJBqJzb/xwQOHpR5gSj8XTvtlms6PDYwKNtMIiC9acRFayjhdCzO7cz
         /Pa7JP+uedfXHGWSWOv287kLwpp/sjjeyYBPw4t6qLpjkHOvpzVipC3Z7+ayBYbRHphP
         ojZA==
X-Gm-Message-State: ANoB5plIzwVslIIvsXInZ4R0C7qd0cCgqTsllY76yYGSd88NWjlS90d+
        eWXqPUywiLefiNkFnXADOI7tU7ATfdZsEA==
X-Google-Smtp-Source: AA0mqf7wRWDnLzQSS9X/1Ba7Fg7tMnyndVIQZax6r3POD5ez32auMFaLwX+ysZj2EIcjtsaKqOGqh+Jxl611og==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a62:1582:0:b0:563:f32:2c9d with SMTP id
 124-20020a621582000000b005630f322c9dmr17174320pfv.32.1669365799235; Fri, 25
 Nov 2022 00:43:19 -0800 (PST)
Date:   Fri, 25 Nov 2022 16:43:05 +0800
In-Reply-To: <20221125084306.1063074-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221125084306.1063074-1-davidgow@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221125084306.1063074-2-davidgow@google.com>
Subject: [PATCH v4 2/3] kunit: Use the static key when retrieving the current test
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>
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

In order to detect if a KUnit test is running, and to access its
context, the 'kunit_test' member of the current task_struct is used.
Usually, this is accessed directly or via the kunit_fail_current_task()
function.

In order to speed up the case where no test is running, add a wrapper,
kunit_get_current_test(), which uses the static key to fail early.
Equally, Speed up kunit_fail_current_test() by using the static key.

This should make it convenient for code to call this
unconditionally in fakes or error paths, without worrying that this will
slow the code down significantly.

If CONFIG_KUNIT=n (or m), this compiles away to nothing. If
CONFIG_KUNIT=y, it will compile down to a NOP (on most architectures) if
no KUnit test is currently running.

Note that kunit_get_current_test() does not work if KUnit is built as a
module. This mirrors the existing restriction on kunit_fail_current_test().

Note that the definition of kunit_fail_current_test() still wraps an
empty, inline function if KUnit is not built-in. This is to ensure that
the printf format string __attribute__ will still work.

Also update the documentation to suggest users use the new
kunit_get_current_test() function, update the example, and to describe
the behaviour when KUnit is disabled better.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Sadiya Kazi <sadiyakazi@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

As-is, the only code which will be directly affected by this (via the
kunit_fail_current_test() change) will be UBSAN's KUnit integration.

Patches to port other tests to use kunit_get_current_test() will be sent
separately (other than the SLUB one in patch 3/3). KASAN in particular
are reworking their KUnit tests and integration, so we'll use this in a
follow up to avoid introducing a conflict.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20221119081252.3864249-2-davidgow@google.com/
- Use DECLARE_STATIC_KEY_FALSE() -- Thanks Daniel.
- Some documentation rewording to make the behaviour a bit clearer.
  - Thanks Daniel and Sadiya

Changes since v2:
https://lore.kernel.org/all/20221025071907.1251820-2-davidgow@google.com/
- Only add kunit_get_current_test() when KUnit is built-in, as the
  static key isn't available otherwise.
  - I'm going to try to put together some patches to make things like
    this available when CONFIG_KUNIT=m in the future.
  - Also update the documentation to note this.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20221021072854.333010-2-davidgow@google.com/
- Fix a missing '}' which broke everything. Thanks Kees, kernel test
  robot.
- Add the new kunit_get_current_test() function, as most of the cases
  where we retrieve the current test (even to fail it) were accessing
  current->kunit_test directly, not using kunit_fail_current_test().
- Add some documentation comments.
- Update the documentation in usage.rst.
  - The version in tips.rst was not updated, and will be removed:
  https://lore.kernel.org/linux-kselftest/20221025055844.1231592-1-davidgow@google.com/

---
 Documentation/dev-tools/kunit/usage.rst | 30 +++++++++-----
 include/kunit/test-bug.h                | 53 +++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 22416ebb94ab..48f8196d5aad 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -641,17 +641,23 @@ as shown in next section: *Accessing The Current Test*.
 Accessing The Current Test
 --------------------------
 
-In some cases, we need to call test-only code from outside the test file.
-For example, see example in section *Injecting Test-Only Code* or if
-we are providing a fake implementation of an ops struct. Using
-``kunit_test`` field in ``task_struct``, we can access it via
-``current->kunit_test``.
+In some cases, we need to call test-only code from outside the test file.  This
+is helpful, for example, when providing a fake implementation of a function, or
+to fail any current test from within an error handler.
+We can do this via the ``kunit_test`` field in ``task_struct``, which we can
+access using the ``kunit_get_current_test()`` function in ``kunit/test-bug.h``.
 
-The example below includes how to implement "mocking":
+``kunit_get_current_test()`` is safe to call even if KUnit is not enabled. If
+KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
+running in the current task, it will return ``NULL``. This compiles down to
+either a no-op or a static key check, so will have a negligible performance
+impact when no test is running.
+
+The example below uses this to implement a "mock" implementation of a function, ``foo``:
 
 .. code-block:: c
 
-	#include <linux/sched.h> /* for current */
+	#include <kunit/test-bug.h> /* for kunit_get_current_test */
 
 	struct test_data {
 		int foo_result;
@@ -660,7 +666,7 @@ The example below includes how to implement "mocking":
 
 	static int fake_foo(int arg)
 	{
-		struct kunit *test = current->kunit_test;
+		struct kunit *test = kunit_get_current_test();
 		struct test_data *test_data = test->priv;
 
 		KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
@@ -691,7 +697,7 @@ Each test can have multiple resources which have string names providing the same
 flexibility as a ``priv`` member, but also, for example, allowing helper
 functions to create resources without conflicting with each other. It is also
 possible to define a clean up function for each resource, making it easy to
-avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
+avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/resource.rst.
 
 Failing The Current Test
 ------------------------
@@ -719,3 +725,9 @@ structures as shown below:
 	static void my_debug_function(void) { }
 	#endif
 
+``kunit_fail_current_test()`` is safe to call even if KUnit is not enabled. If
+KUnit is not enabled, was built as a module (``CONFIG_KUNIT=m``), or no test is
+running in the current task, it will do nothing. This compiles down to either a
+no-op or a static key check, so will have a negligible performance impact when
+no test is running.
+
diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 5fc58081d511..c1b2e14eab64 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -9,16 +9,63 @@
 #ifndef _KUNIT_TEST_BUG_H
 #define _KUNIT_TEST_BUG_H
 
-#define kunit_fail_current_test(fmt, ...) \
-	__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
-
 #if IS_BUILTIN(CONFIG_KUNIT)
 
+#include <linux/jump_label.h> /* For static branch */
+#include <linux/sched.h>
+
+/* Static key if KUnit is running any tests. */
+DECLARE_STATIC_KEY_FALSE(kunit_running);
+
+/**
+ * kunit_get_current_test() - Return a pointer to the currently running
+ *			      KUnit test.
+ *
+ * If a KUnit test is running in the current task, returns a pointer to its
+ * associated struct kunit. This pointer can then be passed to any KUnit
+ * function or assertion. If no test is running (or a test is running in a
+ * different task), returns NULL.
+ *
+ * This function is safe to call even when KUnit is disabled. If CONFIG_KUNIT
+ * is not enabled, it will compile down to nothing and will return quickly no
+ * test is running.
+ */
+static inline struct kunit *kunit_get_current_test(void)
+{
+	if (!static_branch_unlikely(&kunit_running))
+		return NULL;
+
+	return current->kunit_test;
+}
+
+
+/**
+ * kunit_fail_current_test() - If a KUnit test is running, fail it.
+ *
+ * If a KUnit test is running in the current task, mark that test as failed.
+ *
+ * This macro will only work if KUnit is built-in (though the tests
+ * themselves can be modules). Otherwise, it compiles down to nothing.
+ */
+#define kunit_fail_current_test(fmt, ...) do {					\
+		if (static_branch_unlikely(&kunit_running)) {			\
+			__kunit_fail_current_test(__FILE__, __LINE__,		\
+						  fmt, ##__VA_ARGS__);		\
+		}								\
+	} while (0)
+
+
 extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
 						    const char *fmt, ...);
 
 #else
 
+static inline struct kunit *kunit_get_current_test(void) { return NULL; }
+
+/* We define this with an empty helper function so format string warnings work */
+#define kunit_fail_current_test(fmt, ...) \
+		__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
 static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
 							    const char *fmt, ...)
 {
-- 
2.38.1.584.g0f3c55d4c2-goog

