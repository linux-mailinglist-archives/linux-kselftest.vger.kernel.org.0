Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA30260C4E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiJYHTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 03:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiJYHT0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 03:19:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E11013
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 00:19:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367dc159c2fso110945647b3.19
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSSlU0WBF0cN+y9B6p4hl7aqwNlQFVfaKcc/sTiVTfk=;
        b=E3PupdkStZtJB4puC3t+1GP+0h5T91gRco+SuJL2Nn9UlYfQn3vEADEUzpLKj99yAV
         wsQJJv5DrRAjuD5O6Lv3b4s7WfP2Rd6UPWgtZHWiv9LZSrLOUVrlJTvkePyLP0EUZTcp
         iBsyGqpKBPHFcwsj2H5GsWT0t6fZRoFC7qIBuB4nnKD+/Rj49giGUB/dcIihCs0taa14
         noAYF9r2FlZEMPEiYV5oeCAI0TS9HTqz/LQBm+yvMY6QUMkJaeDr+2P/RJnGOOJlwWG5
         cXHXdJIv0fwgaBR0jTEEf4PqBPouf1hGx39el2Bk9A3NyD7j+LtCP/0WF5qbst2k/jDi
         SVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSSlU0WBF0cN+y9B6p4hl7aqwNlQFVfaKcc/sTiVTfk=;
        b=AznkerzoRYKhlOwEeZwTmzqFjsMOeS/JfPH8sU+KfRFncGTmYb0NPQryBFPWYgeiuT
         L91ngbE2PNSRcUfOqtDkRQf78G4bx8pP2kH+myyNlSeyQ5j9qAl2YDUXf5aMMRU8gxo2
         nlOhdBKgYoq1DdZCisO95WFbV5ff+bH+QzWSW2aBkaLHaWy0PTFlu8MwtpR0CRsCOH7G
         eGxhxXqkE2xe9nJ//6tc0+y0mxJFp5K6/QSnsnxhe/KcTgGzM6QiG/vqLXVMiMmt3jS4
         pv+ighF/gQ7TEMcLFwVinBxJznxkBAVjt7JchQuoOOJ7wYarL2+M9io1biM060L+chvA
         X7kg==
X-Gm-Message-State: ACrzQf1wNPNnZONfvqcE/lCdn0W9VQB4V1XmNsshwBjZZLQnES9xqJdA
        2DSbzdv6sNkYGOFNOXKpsmxJ+MGclZfryw==
X-Google-Smtp-Source: AMsMyM6hNNuzHALoBFLZ84Pekxx+FlgGWyUSoVqgmLCbI0lJ8nexXeM1yBZx8g9SsnU1cHrZ4PFi0Xd1CdmYFg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:f205:0:b0:6af:ffab:9cfd with SMTP id
 i5-20020a25f205000000b006afffab9cfdmr33741860ybe.256.1666682364912; Tue, 25
 Oct 2022 00:19:24 -0700 (PDT)
Date:   Tue, 25 Oct 2022 15:19:06 +0800
In-Reply-To: <20221025071907.1251820-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221025071907.1251820-1-davidgow@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025071907.1251820-2-davidgow@google.com>
Subject: [PATCH v2 2/3] kunit: Use the static key when retrieving the current test
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

If CONFIG_KUNIT=n, this compiles away to nothing. If CONFIG_KUNIT=y, it
will compile down to a NOP (on most architectures) if no KUnit test is
currently running. kunit_fail_current_test() does not work if KUnit
itself is built as a module, though this is a pre-existing limitation.

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
 Documentation/dev-tools/kunit/usage.rst | 24 +++++++----
 include/kunit/test-bug.h                | 56 ++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 2737863ef365..05786564b968 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -625,17 +625,20 @@ as shown in next section: *Accessing The Current Test*.
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
+``kunit_get_current_test`` is safe to call even if KUnit is not enabled. If KUnit
+is disabled, or no test is running in the current task, it will quickly return ``NULL``.
+
+The example below uses this to implement a "mock" implementation of a function, ``foo``:
 
 .. code-block:: c
 
-	#include <linux/sched.h> /* for current */
+	#include <kunit/test-bug.h> /* for kunit_get_current_test */
 
 	struct test_data {
 		int foo_result;
@@ -644,7 +647,7 @@ The example below includes how to implement "mocking":
 
 	static int fake_foo(int arg)
 	{
-		struct kunit *test = current->kunit_test;
+		struct kunit *test = kunit_get_current_test();
 		struct test_data *test_data = test->priv;
 
 		KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
@@ -675,7 +678,7 @@ Each test can have multiple resources which have string names providing the same
 flexibility as a ``priv`` member, but also, for example, allowing helper
 functions to create resources without conflicting with each other. It is also
 possible to define a clean up function for each resource, making it easy to
-avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
+avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/resource.rst.
 
 Failing The Current Test
 ------------------------
@@ -703,3 +706,6 @@ structures as shown below:
 	static void my_debug_function(void) { }
 	#endif
 
+Note that ``kunit_fail_current_test`` requires KUnit be built-in to the kernel, i.e.
+``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
+or no test is currently running, but will do nothing.
\ No newline at end of file
diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 5fc58081d511..85b085030a7a 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -9,16 +9,68 @@
 #ifndef _KUNIT_TEST_BUG_H
 #define _KUNIT_TEST_BUG_H
 
-#define kunit_fail_current_test(fmt, ...) \
-	__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+#if IS_ENABLED(CONFIG_KUNIT)
+
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
+#else
+
+static inline struct kunit *kunit_get_current_test(void) { return NULL; }
+
+#endif
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
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
 
+/* We define this with an empty helper function so format string warnings work */
+#define kunit_fail_current_test(fmt, ...) \
+		__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
 static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
 							    const char *fmt, ...)
 {
-- 
2.38.0.135.g90850a2211-goog

