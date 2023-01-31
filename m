Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99B96824CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 07:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjAaGsD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 01:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjAaGsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 01:48:01 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AEE30E2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 22:47:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4bdeb1bbeafso155764877b3.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 22:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C0lSF9+6BB2p8q7DVk8Ve6aQbQV5kmgfstM+8LP0Hig=;
        b=kzge/Fqh+dwX3TGXj53ds/bCavN8kLQjhXhEQKgYToQ4f2YQtchcpSp42CsGVzS/Kz
         U5bNbYuDC803JiqusZUYvF/rrfwCMKNyo55/LuPsXz5Sh6l65I8yYdCJoQQpqT1S3VYy
         BHmlvd8OyXWEUNdJjPiBtS3d76qE2WGhFNpnUOSpq9DFZH8LH43/w4WzP4pXdbx3dPhH
         Rvn3CLPjDyyzU8vhMiviI7xaGZGh2UmW/6lW2skNeAJQwOSwudHMnM7i8c3TdkWhr2eA
         NX7rzvQlgZ5HXpk/zOc346/aH8IH0mJEVGrsXpYplprgLhh3luAWMoIB87hyY0q6wQqh
         gqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0lSF9+6BB2p8q7DVk8Ve6aQbQV5kmgfstM+8LP0Hig=;
        b=D/2Se7ygtVIeOvH6PUVKxzTyIwou0Ymf2d9x1KvV1TuGf96xlz1xVXZJbsUPTnwswl
         /5enBJp+5HMeOE930/FnuUKBatmhHKyCej7VhgU+/ZiSyDzniwvf0aIbbPiasqBSxrO+
         soZx23fg8Vm+HFrq9WBDvkgbNScc4AMJ7+PPkNswX7+DI56EmmyGVkXYxoXpq27n9wbO
         jHzypppdS0y42mMssVvI99UcZmczzfJa3pjr1PtklSdLrptgfCjoV8eU+Hpkc0ObUTCL
         1b/XcK6b10j6VweyLUZj4FbpjGMF24L0mYzmziDQyMKHpyaGdA0+BapEd9ExAwKB2fn9
         o6hA==
X-Gm-Message-State: AO0yUKWNN205XBdB6X4aVzyDPkmIAlD86E7jBBKKH5264o2F9vRSjAZm
        CG4TE6SAUSn1ZacKIS/p9GaoYt1NDIWzJA==
X-Google-Smtp-Source: AK7set+hC0kNgKrySR/qqfRNAl+0BibchiXkAw2G1e7MEVhfMNVvTkeLQvVnapxpl6EB+4Dv/8Z0mPe5U3kMYQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ca97:0:b0:80b:d8f7:af56 with SMTP id
 a145-20020a25ca97000000b0080bd8f7af56mr2508780ybg.611.1675147609557; Mon, 30
 Jan 2023 22:46:49 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:46:40 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131064641.1912756-1-davidgow@google.com>
Subject: [PATCH v3 1/2] kunit: Expose 'static stub' API to redirect functions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
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

Add a simple way of redirecting calls to functions by including a
special prologue in the "real" function which checks to see if the
replacement function should be called (and, if so, calls it).

To redirect calls to a function, make the first (non-declaration) line
of the function:

	KUNIT_STATIC_STUB_REDIRECT(function_name, [function arguments]);

(This will compile away to nothing if KUnit is not enabled, otherwise it
will check if a redirection is active, call the replacement function,
and return. This check is protected by a static branch, so has very
little overhead when there are no KUnit tests running.)

Calls to the real function can be redirected to a replacement using:

	kunit_activate_static_stub(test, real_fn, replacement_fn);

The redirection will only affect calls made from within the kthread of
the current test, and will be automatically disabled when the test
completes. It can also be manually disabled with
kunit_deactivate_static_stub().

The 'example' KUnit test suite has a more complete example.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

This patch depends upon the 'hooks' implementation in
https://lore.kernel.org/linux-kselftest/20230128071007.1134942-1-davidgow@google.com/

Note that checkpatch.pl does warn about control flow in the
KUNIT_STATIC_STUB_REDIRECT() macro. This is an intentional design choice
(we think it makes the feature easier to use), though if there are
strong objections, we can of course reconsider.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20230128074918.1180523-1-davidgow@google.com/
- The example comment for KUNIT_STATIC_STUB_REDIRECT() now uses the
  correct 'int' return type. (Thanks, Brendan)

Changes since v1:
https://lore.kernel.org/all/20221208061841.2186447-2-davidgow@google.com/
- Adapted to use the "hooks" mechanism
  - See: https://lore.kernel.org/linux-kselftest/20230128071007.1134942-1-davidgow@google.com/
  - Now works when KUnit itself is compiled as a module (CONFIG_KUNIT=m)

Changes since RFC v2:
https://lore.kernel.org/linux-kselftest/20220910212804.670622-2-davidgow@google.com/
- Now uses the kunit_get_current_test() function, which uses the static
  key to reduce overhead.
  - Thanks Kees for the suggestion.
  - Note that this does prevent redirections from working when
    CONFIG_KUNIT=m -- this is a restriction of kunit_get_current_test()
    which will be removed in a future patch.
- Several tidy-ups to the inline documentation.

Changes since RFC v1:
https://lore.kernel.org/lkml/20220318021314.3225240-2-davidgow@google.com/
- Use typecheck_fn() to fix typechecking in some cases (thanks Brendan)

---
 include/kunit/static_stub.h    | 113 ++++++++++++++++++++++++++++++
 include/kunit/test-bug.h       |   1 +
 lib/kunit/Makefile             |   1 +
 lib/kunit/hooks-impl.h         |   2 +
 lib/kunit/kunit-example-test.c |  38 ++++++++++
 lib/kunit/static_stub.c        | 123 +++++++++++++++++++++++++++++++++
 6 files changed, 278 insertions(+)
 create mode 100644 include/kunit/static_stub.h
 create mode 100644 lib/kunit/static_stub.c

diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
new file mode 100644
index 000000000000..9b80150a5d62
--- /dev/null
+++ b/include/kunit/static_stub.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit function redirection (static stubbing) API.
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+#ifndef _KUNIT_STATIC_STUB_H
+#define _KUNIT_STATIC_STUB_H
+
+#if !IS_ENABLED(CONFIG_KUNIT)
+
+/* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
+#define KUNIT_TRIGGER_STATIC_STUB(real_fn_name, args...) do {} while (0)
+
+#else
+
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+
+#include <linux/compiler.h> /* for {un,}likely() */
+#include <linux/sched.h> /* for task_struct */
+
+
+/**
+ * KUNIT_STATIC_STUB_REDIRECT() - call a replacement 'static stub' if one exists
+ * @real_fn_name: The name of this function (as an identifier, not a string)
+ * @args: All of the arguments passed to this function
+ *
+ * This is a function prologue which is used to allow calls to the current
+ * function to be redirected by a KUnit test. KUnit tests can call
+ * kunit_activate_static_stub() to pass a replacement function in. The
+ * replacement function will be called by KUNIT_TRIGGER_STATIC_STUB(), which
+ * will then return from the function. If the caller is not in a KUnit context,
+ * the function will continue execution as normal.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	int real_func(int n)
+ *	{
+ *		KUNIT_STATIC_STUB_REDIRECT(real_func, n);
+ *		return 0;
+ *	}
+ *
+ *	int replacement_func(int n)
+ *	{
+ *		return 42;
+ *	}
+ *
+ *	void example_test(struct kunit *test)
+ *	{
+ *		kunit_activate_static_stub(test, real_func, replacement_func);
+ *		KUNIT_EXPECT_EQ(test, real_func(1), 42);
+ *	}
+ *
+ */
+#define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...)		\
+do {									\
+	typeof(&real_fn_name) replacement;				\
+	struct kunit *current_test = kunit_get_current_test();		\
+									\
+	if (likely(!current_test))					\
+		break;							\
+									\
+	replacement = kunit_hooks.get_static_stub_address(current_test,	\
+							&real_fn_name);	\
+									\
+	if (unlikely(replacement))					\
+		return replacement(args);				\
+} while (0)
+
+/* Helper function for kunit_activate_static_stub(). The macro does
+ * typechecking, so use it instead.
+ */
+void __kunit_activate_static_stub(struct kunit *test,
+				  void *real_fn_addr,
+				  void *replacement_addr);
+
+/**
+ * kunit_activate_static_stub() - replace a function using static stubs.
+ * @test: A pointer to the 'struct kunit' test context for the current test.
+ * @real_fn_addr: The address of the function to replace.
+ * @replacement_addr: The address of the function to replace it with.
+ *
+ * When activated, calls to real_fn_addr from within this test (even if called
+ * indirectly) will instead call replacement_addr. The function pointed to by
+ * real_fn_addr must begin with the static stub prologue in
+ * KUNIT_TRIGGER_STATIC_STUB() for this to work. real_fn_addr and
+ * replacement_addr must have the same type.
+ *
+ * The redirection can be disabled again with kunit_deactivate_static_stub().
+ */
+#define kunit_activate_static_stub(test, real_fn_addr, replacement_addr) do {	\
+	typecheck_fn(typeof(&real_fn_addr), replacement_addr);			\
+	__kunit_activate_static_stub(test, real_fn_addr, replacement_addr);	\
+} while (0)
+
+
+/**
+ * kunit_deactivate_static_stub() - disable a function redirection
+ * @test: A pointer to the 'struct kunit' test context for the current test.
+ * @real_fn_addr: The address of the function to no-longer redirect
+ *
+ * Deactivates a redirection configured with kunit_activate_static_stub(). After
+ * this function returns, calls to real_fn_addr() will execute the original
+ * real_fn, not any previously-configured replacement.
+ */
+void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr);
+
+#endif
+#endif
diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 2b505a95b641..30ca541b6ff2 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -20,6 +20,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 /* Hooks table: a table of function pointers filled in when kunit loads */
 extern struct kunit_hooks_table {
 	__printf(3, 4) void (*fail_current_test)(const char*, int, const char*, ...);
+	void *(*get_static_stub_address)(struct kunit *test, void *real_fn_addr);
 } kunit_hooks;
 
 /**
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index deeb46cc879b..da665cd4ea12 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
 					resource.o \
+					static_stub.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
index d911f40f76db..ec745a39832c 100644
--- a/lib/kunit/hooks-impl.h
+++ b/lib/kunit/hooks-impl.h
@@ -16,12 +16,14 @@
 
 /* List of declarations. */
 void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...);
+void *__kunit_get_static_stub_address_impl(struct kunit *test, void *real_fn_addr);
 
 /* Code to set all of the function pointers. */
 static inline void kunit_install_hooks(void)
 {
 	/* Install the KUnit hook functions. */
 	kunit_hooks.fail_current_test = __kunit_fail_current_test_impl;
+	kunit_hooks.get_static_stub_address = __kunit_get_static_stub_address_impl;
 }
 
 #endif /* _KUNIT_HOOKS_IMPL_H */
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 66cc4e2365ec..cd8b7e51d02b 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/static_stub.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -130,6 +131,42 @@ static void example_all_expect_macros_test(struct kunit *test)
 	KUNIT_ASSERT_GT_MSG(test, sizeof(int), 0, "Your ints are 0-bit?!");
 }
 
+/* This is a function we'll replace with static stubs. */
+static int add_one(int i)
+{
+	/* This will trigger the stub if active. */
+	KUNIT_STATIC_STUB_REDIRECT(add_one, i);
+
+	return i + 1;
+}
+
+/* This is used as a replacement for the above function. */
+static int subtract_one(int i)
+{
+	/* We don't need to trigger the stub from the replacement. */
+
+	return i - 1;
+}
+
+/*
+ * This test shows the use of static stubs.
+ */
+static void example_static_stub_test(struct kunit *test)
+{
+	/* By default, function is not stubbed. */
+	KUNIT_EXPECT_EQ(test, add_one(1), 2);
+
+	/* Replace add_one() with subtract_one(). */
+	kunit_activate_static_stub(test, add_one, subtract_one);
+
+	/* add_one() is now replaced. */
+	KUNIT_EXPECT_EQ(test, add_one(1), 0);
+
+	/* Return add_one() to normal. */
+	kunit_deactivate_static_stub(test, add_one);
+	KUNIT_EXPECT_EQ(test, add_one(1), 2);
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -145,6 +182,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_skip_test),
 	KUNIT_CASE(example_mark_skipped_test),
 	KUNIT_CASE(example_all_expect_macros_test),
+	KUNIT_CASE(example_static_stub_test),
 	{}
 };
 
diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
new file mode 100644
index 000000000000..92b2cccd5e76
--- /dev/null
+++ b/lib/kunit/static_stub.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit function redirection (static stubbing) API.
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+#include "hooks-impl.h"
+
+
+/* Context for a static stub. This is stored in the resource data. */
+struct kunit_static_stub_ctx {
+	void *real_fn_addr;
+	void *replacement_addr;
+};
+
+static void __kunit_static_stub_resource_free(struct kunit_resource *res)
+{
+	kfree(res->data);
+}
+
+/* Matching function for kunit_find_resource(). match_data is real_fn_addr. */
+static bool __kunit_static_stub_resource_match(struct kunit *test,
+						struct kunit_resource *res,
+						void *match_real_fn_addr)
+{
+	/* This pointer is only valid if res is a static stub resource. */
+	struct kunit_static_stub_ctx *ctx = res->data;
+
+	/* Make sure the resource is a static stub resource. */
+	if (res->free != &__kunit_static_stub_resource_free)
+		return false;
+
+	return ctx->real_fn_addr == match_real_fn_addr;
+}
+
+/* Hook to return the address of the replacement function. */
+void *__kunit_get_static_stub_address_impl(struct kunit *test, void *real_fn_addr)
+{
+	struct kunit_resource *res;
+	struct kunit_static_stub_ctx *ctx;
+	void *replacement_addr;
+
+	res = kunit_find_resource(test,
+				  __kunit_static_stub_resource_match,
+				  real_fn_addr);
+
+	if (!res)
+		return NULL;
+
+	ctx = res->data;
+	replacement_addr = ctx->replacement_addr;
+	kunit_put_resource(res);
+	return replacement_addr;
+}
+
+void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr)
+{
+	struct kunit_resource *res;
+
+	KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL,
+				"Tried to deactivate a NULL stub.");
+
+	/* Look up the existing stub for this function. */
+	res = kunit_find_resource(test,
+				  __kunit_static_stub_resource_match,
+				  real_fn_addr);
+
+	/* Error out if the stub doesn't exist. */
+	KUNIT_ASSERT_PTR_NE_MSG(test, res, NULL,
+				"Tried to deactivate a nonexistent stub.");
+
+	/* Free the stub. We 'put' twice, as we got a reference
+	 * from kunit_find_resource()
+	 */
+	kunit_remove_resource(test, res);
+	kunit_put_resource(res);
+}
+EXPORT_SYMBOL_GPL(kunit_deactivate_static_stub);
+
+/* Helper function for kunit_activate_static_stub(). The macro does
+ * typechecking, so use it instead.
+ */
+void __kunit_activate_static_stub(struct kunit *test,
+				  void *real_fn_addr,
+				  void *replacement_addr)
+{
+	struct kunit_static_stub_ctx *ctx;
+	struct kunit_resource *res;
+
+	KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL,
+				"Tried to activate a stub for function NULL");
+
+	/* If the replacement address is NULL, deactivate the stub. */
+	if (!replacement_addr) {
+		kunit_deactivate_static_stub(test, replacement_addr);
+		return;
+	}
+
+	/* Look up any existing stubs for this function, and replace them. */
+	res = kunit_find_resource(test,
+				  __kunit_static_stub_resource_match,
+				  real_fn_addr);
+	if (res) {
+		ctx = res->data;
+		ctx->replacement_addr = replacement_addr;
+
+		/* We got an extra reference from find_resource(), so put it. */
+		kunit_put_resource(res);
+	} else {
+		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+		ctx->real_fn_addr = real_fn_addr;
+		ctx->replacement_addr = replacement_addr;
+		res = kunit_alloc_resource(test, NULL,
+				     &__kunit_static_stub_resource_free,
+				     GFP_KERNEL, ctx);
+	}
+}
+EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
-- 
2.39.1.456.gfc5497dd1b-goog

