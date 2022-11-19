Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99D630D29
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Nov 2022 09:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiKSINL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Nov 2022 03:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKSINH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Nov 2022 03:13:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25377DED2
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:13:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id f90-20020a17090a706300b0021891e06ac9so1216184pjk.9
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQq0YjZ1txdSpkL6jAisYu5mB9Yl+atKGSU09uhepI4=;
        b=QtwcUhMLxxlhu63SCsIAZikJ2Cdiebecyw7uTINwtFeToqE0Lb06WSDNRW39Qb9VaT
         sri0U30v930zgfNas2Ehhu8wEUyD4634+IIW4XBvcADtCMEj/kAOWnEe2YRAMRZ/z+j7
         rcwduzeq7GDD2QYV/9UEmfvln20obiZruXwKlHwf4R0BKpT/11tHduTVJOXFlxQXL7H7
         fEmqpxkTRIn4LKMBn+T0eDeGYInqOKpNF/4Y8ra0U+e2wb5dlg0+bGIlkmAiG8W9UeZQ
         7tovm0gHb5llKcwh5cPdiCYL9uRRFEM1ZOJA3pAHIW4yMfTYS0Va+cOLdN8ts8g1RJae
         KNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQq0YjZ1txdSpkL6jAisYu5mB9Yl+atKGSU09uhepI4=;
        b=Mh6iqdWnes1chgwMo5TIis99V9LNAVWsQKxJAgtqWQc8PAJTgi+7Af87H22Qo88RAj
         wbOWK+9hCw78uRfS2HyNV9b8I686XjVQb6ueKX/mYm6uXOuQ/92MGW4qfp5PSKXMDyqZ
         m+jE3D+WeOZ05Uv88l2NDL5KqQ8yW19TojkoO6ldLP3mQ0SlxIXxlhAW7HCXcLMgKrgF
         Ard+bQJBPwWTBE/0KNH8H5d0A/4GqwqIc0LMpzDwWWcUh3/lYp+W+1DCgXUnhQXynN3q
         Wece5yn7iLE7+0rlsXwi2MRwYZ8D1NJTOialwJv2MXnc+Hc7DcjIE8janCff+8i/z3lA
         CmrQ==
X-Gm-Message-State: ANoB5pnvKkcLQSlyj6soq48a2tk8QvVOw6b+fDKIJKvtQv95ZJHEdySU
        RjqN+JFp9r+gmmJQ6Ik71N77pCDAK2a3UA==
X-Google-Smtp-Source: AA0mqf78VSvCJWAPNRCcPn1dsdtFg1FE1gaTd9E/VXddYv47AISoGCQreuLzaKBkf9gibnQrFcBIspsXxu+Duw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:3941:b0:215:db2e:bb17 with SMTP
 id oe1-20020a17090b394100b00215db2ebb17mr11493335pjb.166.1668845584292; Sat,
 19 Nov 2022 00:13:04 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:12:51 +0800
In-Reply-To: <20221119081252.3864249-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221119081252.3864249-2-davidgow@google.com>
Subject: [PATCH v3 2/3] kunit: Use the static key when retrieving the current test
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
---

As-is, the only code which will be directly affected by this (via the
kunit_fail_current_test() change) will be UBSAN's KUnit integration.

Patches to port other tests to use kunit_get_current_test() will be sent
separately (other than the SLUB one in patch 3/3). KASAN in particular
are reworking their KUnit tests and integration, so we'll use this in a
follow up to avoid introducing a conflict.

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
 Documentation/dev-tools/kunit/usage.rst | 25 +++++++-----
 include/kunit/test-bug.h                | 53 +++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 2737863ef365..e70014b82350 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -625,17 +625,21 @@ as shown in next section: *Accessing The Current Test*.
 Accessing The Current Test
 --------------------------
 
-In some cases, we need to call test-only code from outside the test file.
-For example, see example in section *Injecting Test-Only Code* or if
-we are providing a fake implementation of an ops struct. Using
-``kunit_test`` field in ``task_struct``, we can access it via
-``current->kunit_test``.
+In some cases, we need to call test-only code from outside the test file,
+for example,  when providing a fake implementation of a function, or to fail
+any current test from within an error handler.
+We can do this via the ``kunit_test`` field in ``task_struct``, which we can
+access using the ``kunit_get_current_test`` function in ``kunit/test-bug.h``.
 
-The example below includes how to implement "mocking":
+``kunit_get_current_test`` requires KUnit be built-in to the kernel, i.e.
+``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
+or no test is currently running, in which case it will quickly return ``NULL``.
+
+The example below uses this to implement a "mock" implementation of a function, ``foo``:
 
 .. code-block:: c
 
-	#include <linux/sched.h> /* for current */
+	#include <kunit/test-bug.h> /* for kunit_get_current_test */
 
 	struct test_data {
 		int foo_result;
@@ -644,7 +648,7 @@ The example below includes how to implement "mocking":
 
 	static int fake_foo(int arg)
 	{
-		struct kunit *test = current->kunit_test;
+		struct kunit *test = kunit_get_current_test();
 		struct test_data *test_data = test->priv;
 
 		KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
@@ -675,7 +679,7 @@ Each test can have multiple resources which have string names providing the same
 flexibility as a ``priv`` member, but also, for example, allowing helper
 functions to create resources without conflicting with each other. It is also
 possible to define a clean up function for each resource, making it easy to
-avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
+avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/resource.rst.
 
 Failing The Current Test
 ------------------------
@@ -703,3 +707,6 @@ structures as shown below:
 	static void my_debug_function(void) { }
 	#endif
 
+Note that ``kunit_fail_current_test`` requires KUnit be built-in to the kernel, i.e.
+``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
+or no test is currently running, but will do nothing.
diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 5fc58081d511..87a953dceeaa 100644
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
+extern struct static_key_false kunit_running;
+
+/**
+ * kunit_get_current_test() - Return a pointer to the currently-running
+ *			      KUnit test.
+ *
+ * If a KUnit test is running in the current task, returns a pointer to
+ * its associated struct kunit, which can then be passed to any KUnit function
+ * or assertion. If no test is running (or a test is running in a different
+ * task), returns NULL.
+ *
+ * This function is safe to call even when KUnit is disabled: it will compile
+ * down to nothing if CONFIG_KUNIT is not enabled, and will be very fast if
+ * no test is running.
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

