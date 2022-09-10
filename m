Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697B5B4A48
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Sep 2022 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiIJVf1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Sep 2022 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIJVfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Sep 2022 17:35:09 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC286451
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Sep 2022 14:29:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 2-20020a17090a0b8200b001fdb8fd5f29so2444890pjr.8
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Sep 2022 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=AQSKyyxRM/1kBel8Rm51NXzepcXl8uNiWvzYLoszy5E=;
        b=n8OGXovB5FHB+F5y6rDvwNqMdhfVoc1TSoNm0hOcpRnXTtlPzq2bayYdR+A9cMdZio
         KzyfVxHd48bdOQBiBR6VMQl/YshnLy4Nt08kEGf4tXpgHmJKz0kji3szP+cs4QEY/7T5
         vMMTXKIaMxuGLG8F+Qvxn6bEgP54oMvFXngPhfAJC61y8MvABZ8TN8OInHiGys5UqzmD
         ZJkC11cu/9/nAL7vaiOOGl+kPhcDxwLB0+81dPY9BNES9qz0IM4Ffoz1siCz4I/uOQ4+
         2Lr5zelrdp3ZS9ZJ/fc4e2RAgEkSusp+mb3plWyFIvnCafW5NRMYRRQhPa+ky2lZBVyA
         NjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=AQSKyyxRM/1kBel8Rm51NXzepcXl8uNiWvzYLoszy5E=;
        b=DOvCvi6mVhn+a6dYLM7PZ2bu6As+nxgryp+FTsCOPu1ddgbvVAIpGDyn3ylHESoHLa
         wezt4veD19EWFa1HZ5Y2kY9mhNQ3ie3KhYqks+bvHh6zycrtvJFZe8dihAJfZ5Y383O9
         hBNCbKu7XgrG7Ygc7Y2cwFnYEs/GRB6SDdFtGE3NHBc3G1vPgMRTgkGGIacaQFGf2L2b
         mlyDcpmBVJqbZnL3F9TZ7DATNzLQLxlczZQTOaMlWgrhbyuStyWNzpUwPKxAgProHi2c
         1dRhqvH3JpAwAFOYy9RBcz5MjmCMCFMrvWxaCxyt3la9VRqcCfFp61nqKdi1r3ibd3BE
         N4LQ==
X-Gm-Message-State: ACgBeo3JuaHqns9eUqBpcsfJvHvuDp88V0WDpZHArPqfu0sZSC2kpFvf
        expZq6zem1zKx4zFevHcGG4fI2z5cnj6iA==
X-Google-Smtp-Source: AA6agR5UOnOMtfBD2Sy2mmTQLFHHhyx4dWygs7y/DUkF0UU+Tvj4ZAiQ9ZW9GNd+yLu6S9cS/z5liRDBLG640w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:7602:b0:172:a064:4a2f with SMTP
 id k2-20020a170902760200b00172a0644a2fmr19529716pll.56.1662845303343; Sat, 10
 Sep 2022 14:28:23 -0700 (PDT)
Date:   Sun, 11 Sep 2022 05:28:03 +0800
In-Reply-To: <20220910212804.670622-1-davidgow@google.com>
Mime-Version: 1.0
References: <20220910212804.670622-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220910212804.670622-2-davidgow@google.com>
Subject: [RFC PATCH v2 1/2] kunit: Expose 'static stub' API to redirect functions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>
Cc:     Steve Muckle <smuckle@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
and return.)

Calls to the real function can be redirected to a replacement using:

	kunit_activate_static_stub(test, real_fn, replacement_fn);

The redirection will only affect calls made from within the kthread of
the current test, and will be automatically disabled when the test
completes. It can also be manually disabled with
kunit_deactivate_static_stub().

The 'example' KUnit test suite has a more complete example.

This is intended to be an alternative to ftrace-based stubbing (see the
next patch), with different tradeoffs.

In particular:
- 'static stubs' work on all architectures, and don't have any
  dependencies.
  - There's no separate Kconfig option to enable them, they always
    exist.
- They must be explicitly opted-into by the function being replaced
  (which can be good or bad depending on your POV)
- They have a greater performance penalty when not in active use (as
  every call to the real function must check to see if the stub is
  enabled)
- They could more easily be extended to pass additional context to
  replacement functions.

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since RFC v1:
https://lore.kernel.org/lkml/20220318021314.3225240-2-davidgow@google.com/
- Use typecheck_fn() to fix typechecking in some cases (thanks Brendan)

---
 include/kunit/static_stub.h    | 106 ++++++++++++++++++++++++++++
 lib/kunit/Makefile             |   1 +
 lib/kunit/kunit-example-test.c |  38 ++++++++++
 lib/kunit/static_stub.c        | 125 +++++++++++++++++++++++++++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 include/kunit/static_stub.h
 create mode 100644 lib/kunit/static_stub.c

diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
new file mode 100644
index 000000000000..7417ba8efdbb
--- /dev/null
+++ b/include/kunit/static_stub.h
@@ -0,0 +1,106 @@
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
+#if !IS_REACHABLE(CONFIG_KUNIT)
+
+/* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
+#define KUNIT_TRIGGER_STATIC_STUB(real_fn_name, args...) do {} while (0)
+
+#else
+
+#include <kunit/test.h>
+
+#include <linux/compiler.h> /* for {un,}likely() */
+#include <linux/sched.h> /* for task_struct */
+
+/* Returns the address of the replacement function. */
+void *__kunit_get_static_stub_address(struct kunit *test, void *real_fn_addr);
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
+ *	int real_func(int n)
+ *	{
+ *		KUNIT_STATIC_STUB_REDIRECT(real_func, n);
+ *		return 0;
+ *	}
+ *
+ *	void replacement_func(int n)
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
+	struct kunit *current_test = current->kunit_test;		\
+									\
+	if (likely(!current_test))					\
+		break;							\
+									\
+	KUNIT_ASSERT_STREQ_MSG(current_test, __func__, #real_fn_name,	\
+			       "Static stub function name mismatch");	\
+									\
+	replacement = __kunit_get_static_stub_address(current_test,	\
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
+void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr);
+
+#endif
+#endif
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 29aff6562b42..78d9d3414b67 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
 					resource.o \
+					static_stub.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index f8fe582c9e36..a065dd0ae332 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/static_stub.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -123,6 +124,42 @@ static void example_all_expect_macros_test(struct kunit *test)
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
@@ -138,6 +175,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_skip_test),
 	KUNIT_CASE(example_mark_skipped_test),
 	KUNIT_CASE(example_all_expect_macros_test),
+	KUNIT_CASE(example_static_stub_test),
 	{}
 };
 
diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
new file mode 100644
index 000000000000..b06b88f82dd7
--- /dev/null
+++ b/lib/kunit/static_stub.c
@@ -0,0 +1,125 @@
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
+/* Returns the address of the replacement function. */
+void *__kunit_get_static_stub_address(struct kunit *test, void *real_fn_addr)
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
+EXPORT_SYMBOL_GPL(__kunit_get_static_stub_address);
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
+
+
-- 
2.37.2.789.g6183377224-goog

