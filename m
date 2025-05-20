Return-Path: <linux-kselftest+bounces-33371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2CABD1D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AED94A29BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECB264F9C;
	Tue, 20 May 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMit0kiO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44386264F81;
	Tue, 20 May 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729517; cv=none; b=pbJN/ntFFynQCunJARlMVD0PJiz7dfdyGcLxjfRTFOdRSQyrYZZI8L3/DY8QlJI26rpdn0QHidHe6C7H6P0B7Vtb3mq/NZipuFBWQDfkDVtJOjrXZUjQfiqxTpqBg30WFqkNetu2VK2mmkyk1n9c8zIVC8/pSGWJMZAp5O+Cpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729517; c=relaxed/simple;
	bh=7Gqk9JjSJ/fG63XRlpdt6ZRfS4huFSCyqSgLScQXexo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/Xh5UrXd5Vd0YauT0HDgSAEDVBiAHdTA69CDm8CtJHFktfGkBbaLGr6dUaCwfGC6q352JaU0jpow8EGy70d6Xoy+vPhN5CxKZmH3fwqvBODfC8ibDByXnbzjfWb5D/oIVQvZyPlxHYOrJ/QBhLOq3oJxcXyxxEVwiO8OoLmwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMit0kiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AB6C4CEEF;
	Tue, 20 May 2025 08:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729516;
	bh=7Gqk9JjSJ/fG63XRlpdt6ZRfS4huFSCyqSgLScQXexo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMit0kiOEB2436VZRhaAyPfwuGQI592EUgAsBXHXPCcKrKRPSE4tjz5DFYy3QQOTl
	 isndEA+qHni+Eo4sn/Hzd7sH0AJyd18tEwwptvTbRydhR2bL3DhMBM8mH52ZKi6Lzi
	 kdze5DomGgJqMntYHrRTvnTuXP016katxJBlx8REouhhIkWd+2gkS+FbFJGGrVqTmF
	 fnxQsaQuJCDiLm4/UW3YBEyi4glUfI8ZbveQcX+OJRiCrGj4TzaAxlTduX29Kr881U
	 KEGsFaCqh9CkVzOVxy2uXsusJzWOvlicrqdHOEJXsoWiWfX/YJOVQAEhhVjyMUmQLg
	 H7qjnDnqvhDXA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	brendan.higgins@linux.dev,
	davidgow@google.com
Cc: tzungbi@kernel.org,
	rmoar@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Latypov <dlatypov@google.com>
Subject: [RFC PATCH 1/7] kunit: expose ftrace-based API for stubbing out functions during tests
Date: Tue, 20 May 2025 08:24:28 +0000
Message-ID: <20250520082435.2255639-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <20250520082435.2255639-1-tzungbi@kernel.org>
References: <20250520082435.2255639-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Latypov <dlatypov@google.com>

Allow function redirection using ftrace and kernel livepatch. This is
basically equivalent to the static_stub support in the previous patch,
but does not require the function being replaced to be modified (save
for the addition of KUNIT_STUBBABLE/noinline).

This is hidden behind the CONFIG_KUNIT_FTRACE_STUBS option, and has a
number of dependencies, including ftrace, livepatch and
CONFIG_KALLSYMS_ALL. As a result, it only works on architectures where
these are available.

You can run the KUnit example tests with the following:
$ ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit/stubs_example.kunitconfig --arch=x86_64

To the end user, replacing a function is very simple, e.g.
  KUNIT_STUBBABLE void real_func(int n);
  void replacement_func(int n);

  /* in tests */
  kunit_activate_ftrace_stub(test, real_func, replacement_func);

The implementation is inspired by Steven's snippet here [1].

Some more details:
* stubbing is automatically undone at the end of tests
* it can also be manually undone with kunit_deactive_ftrace_stub()
* stubbing only applies when current->kunit_test == test
  * note: currently can't have more than one test running at a time
* KUNIT_STUBBABLE marks tests as noinline when CONFIG_KUNIT_STUBS is set
  * this ensures we can actually stub all calls
* KUNIT_STUBBABLE_TRAMPOLINE is a version that evaluates to
  __always_inline when stubbing is not enabled
  * This may need to be used with a wrapper function.
  * See the doc comment for more details.

Sharp-edges:
* kernel livepatch only works on some arches (not UML)
* if you don't use noinline/KUNIT_STUBBABLE, functions might be inlined
  and thus none of this works:
  * if it's always inlined, at least the attempt to stub will fail
  * if it's sometimes inlined, then the stub silently won't work

[1] https://lore.kernel.org/lkml/20220224091550.2b7e8784@gandalf.local.home
[2] https://lore.kernel.org/linux-kselftest/CAGS_qxqtMpjKX+CMF6eBUWfsc-TKR9-Bk+hYM=PHa0_wUtQQuA@mail.gmail.com/

Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
[tzungbi:
  * Resolve contextual conflicts for rebasing.
  * klp_arch_set_pc() -> ftrace_regs_set_instruction_pointer().
  * Fix type check in kunit_activate_ftrace_stub() just like what has
    been done in kunit_activate_static_stub().
  * Include <kunit/ftrace_stub.h> in lib/kunit/ftrace_stub.c.
  * Fix typo in include/kunit/ftrace_stub.h as pointed out in [2].
    * eavlautes -> evaluates.
    * active -> activate.
  * Fix typo in kunit-example-test.c and ftrace_stub.c.
    * static -> ftrace.
  * EXPORT_SYMBOL_IF_KUNIT() for ftrace_location() as
    lib/kunit/ftrace_stub.c uses it.  If CONFIG_KUNIT=m, it can't find
    the symbol ftrace_location().
  * KUNIT_ASSERT_FAILURE() -> KUNIT_FAIL_AND_ABORT() due to
    7d4087b01389.
]
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
 kernel/trace/ftrace.c               |   3 +
 lib/kunit/Kconfig                   |  11 +++
 lib/kunit/Makefile                  |   4 +
 lib/kunit/ftrace_stub.c             | 139 ++++++++++++++++++++++++++++
 lib/kunit/kunit-example-test.c      |  27 +++++-
 lib/kunit/stubs_example.kunitconfig |  11 +++
 7 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/ftrace_stub.h
 create mode 100644 lib/kunit/ftrace_stub.c
 create mode 100644 lib/kunit/stubs_example.kunitconfig

diff --git a/include/kunit/ftrace_stub.h b/include/kunit/ftrace_stub.h
new file mode 100644
index 000000000000..79c496b51ac5
--- /dev/null
+++ b/include/kunit/ftrace_stub.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KUNIT_FTRACE_STUB_H
+#define _KUNIT_FTRACE_STUB_H
+
+/** KUNIT_STUBBABLE - marks a function as stubbable when stubbing support is
+ * enabled.
+ *
+ * Stubbing uses ftrace internally, so we can only stub out functions when they
+ * are not inlined. This macro evaluates to noinline when stubbing support is
+ * enabled to thus make it safe.
+ *
+ * If you cannot add this annotation to the function, you can instead use
+ * KUNIT_STUBBABLE_TRAMPOLINE, which is the same, but evaluates to
+ * __always_inline when stubbing is not enabled.
+ *
+ * Consider copy_to_user, which is marked as __always_inline:
+ *
+ * .. code-block:: c
+ *	static KUNIT_STUBBABLE_TRAMPOLINE unsigned long
+ *	copy_to_user_trampoline(void __user *to, const void *from, unsigned long n)
+ *	{
+ *		return copy_to_user(to, from, n);
+ *	}
+ *
+ * Then we simply need to update our code to go through this function instead
+ * (in the places where we want to stub it out).
+ */
+#if IS_ENABLED(CONFIG_KUNIT_FTRACE_STUBS)
+#define KUNIT_STUBBABLE noinline
+#define KUNIT_STUBBABLE_TRAMPOLINE noinline
+#else
+#define KUNIT_STUBBABLE
+#define KUNIT_STUBBABLE_TRAMPOLINE __always_inline
+#endif
+
+struct kunit;
+
+/**
+ * kunit_activate_ftrace_stub() - makes all calls to @func go to @replacement during @test.
+ * @test: The test context object.
+ * @func: The function to stub out, must be annotated with KUNIT_STUBBABLE.
+ * @replacement: The function to replace @func with.
+ *
+ * All calls to @func will instead call @replacement for the duration of the
+ * current test. If called from outside the test's thread, the function will
+ * not be redirected.
+ *
+ * The redirection can be disabled again with kunit_deactivate_ftrace_stub().
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *	KUNIT_STUBBABLE int real_func(int n)
+ *	{
+ *		pr_info("real_func() called with %d", n);
+ *		return 0;
+ *	}
+ *
+ *	void replacement_func(int n)
+ *	{
+ *		pr_info("replacement_func() called with %d", n);
+ *		return 42;
+ *	}
+ *
+ *	void example_test(struct kunit *test)
+ *	{
+ *		kunit_activate_ftrace_stub(test, real_func, replacement_func);
+ *		KUNIT_EXPECT_EQ(test, real_func(1), 42);
+ *	}
+ *
+ */
+#define kunit_activate_ftrace_stub(test, func, replacement) do { \
+	typecheck_fn(typeof(&func), replacement); \
+	__kunit_activate_ftrace_stub(test, #func, func, replacement); \
+} while (0)
+
+void __kunit_activate_ftrace_stub(struct kunit *test,
+				  const char *name,
+				  void *real_fn_addr,
+				  void *replacement_addr);
+
+
+void kunit_deactivate_ftrace_stub(struct kunit *test, void *real_fn_addr);
+#endif  /* _KUNIT_STUB_H */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a48aedb5255..7e86bc57d462 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -36,6 +36,8 @@
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
 
+#include <kunit/visibility.h>
+
 #include <trace/events/sched.h>
 
 #include <asm/sections.h>
@@ -1663,6 +1665,7 @@ unsigned long ftrace_location(unsigned long ip)
 	}
 	return loc;
 }
+EXPORT_SYMBOL_IF_KUNIT(ftrace_location);
 
 /**
  * ftrace_text_reserved - return true if range contains an ftrace location
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index a97897edd964..933fda1df5c3 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -93,4 +93,15 @@ config KUNIT_AUTORUN_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_FTRACE_STUBS
+	bool "Support for stubbing out functions in KUnit tests with ftrace and kernel livepatch"
+	depends on FTRACE=y && FUNCTION_TRACER=y && MODULES=y && DEBUG_KERNEL=y && KALLSYMS_ALL=y && LIVEPATCH=y
+	help
+	  Builds support for stubbing out functions for the duration of KUnit
+	  test cases or suites using ftrace and kernel livepatch.
+	  See KUNIT_EXAMPLE_TEST for an example.
+
+	  NOTE: this does not work on all architectures (like UML, arm64) and
+	  relies on a lot of magic (see the dependencies list).
+
 endif # KUNIT
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 5aa51978e456..0ecb255576e2 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -29,3 +29,7 @@ obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 endif
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+
+ifeq ($(CONFIG_KUNIT_FTRACE_STUBS),y)
+kunit-objs +=				ftrace_stub.o
+endif
diff --git a/lib/kunit/ftrace_stub.c b/lib/kunit/ftrace_stub.c
new file mode 100644
index 000000000000..1cf6edceb19c
--- /dev/null
+++ b/lib/kunit/ftrace_stub.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <kunit/ftrace_stub.h>
+
+#include <linux/typecheck.h>
+
+#include <linux/ftrace.h>
+#include <linux/livepatch.h>
+#include <linux/sched.h>
+
+struct kunit_ftrace_stub_ctx {
+	struct kunit *test;
+	unsigned long real_fn_addr; /* used as a key to lookup the stub */
+	unsigned long replacement_addr;
+	struct ftrace_ops ops; /* a copy of kunit_stub_base_ops with .private set */
+};
+
+static void kunit_stub_trampoline(unsigned long ip, unsigned long parent_ip,
+				  struct ftrace_ops *ops,
+				  struct ftrace_regs *fregs)
+{
+	struct kunit_ftrace_stub_ctx *ctx = ops->private;
+	int lock_bit;
+
+	if (current->kunit_test != ctx->test)
+		return;
+
+	lock_bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	KUNIT_ASSERT_GE(ctx->test, lock_bit, 0);
+
+	ftrace_regs_set_instruction_pointer(fregs, ctx->replacement_addr);
+
+	ftrace_test_recursion_unlock(lock_bit);
+}
+
+static struct ftrace_ops kunit_stub_base_ops = {
+	.func = &kunit_stub_trampoline,
+	.flags = FTRACE_OPS_FL_IPMODIFY |
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+		FTRACE_OPS_FL_SAVE_REGS |
+#endif
+		FTRACE_OPS_FL_DYNAMIC
+};
+
+static void __kunit_ftrace_stub_resource_free(struct kunit_resource *res)
+{
+	struct kunit_ftrace_stub_ctx *ctx = res->data;
+
+	unregister_ftrace_function(&ctx->ops);
+	kfree(ctx);
+}
+
+/* Matching function for kunit_find_resource(). match_data is real_fn_addr. */
+static bool __kunit_ftrace_stub_resource_match(struct kunit *test,
+						struct kunit_resource *res,
+						void *match_real_fn_addr)
+{
+	/* This pointer is only valid if res is a ftrace stub resource. */
+	struct kunit_ftrace_stub_ctx *ctx = res->data;
+
+	/* Make sure the resource is a ftrace stub resource. */
+	if (res->free != &__kunit_ftrace_stub_resource_free)
+		return false;
+
+	return ctx->real_fn_addr == (unsigned long)match_real_fn_addr;
+}
+
+void kunit_deactivate_ftrace_stub(struct kunit *test, void *real_fn_addr)
+{
+	struct kunit_resource *res;
+
+	KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL,
+				"Tried to deactivate a NULL stub.");
+
+	/* Look up the existing stub for this function. */
+	res = kunit_find_resource(test,
+				  __kunit_ftrace_stub_resource_match,
+				  real_fn_addr);
+
+	/* Error out if the stub doesn't exist. */
+	KUNIT_ASSERT_PTR_NE_MSG(test, res, NULL,
+				"Tried to deactivate a nonexistent stub.");
+
+	/* Free the stub. We 'put' twice, as we got a reference
+	 * from kunit_find_resource(). The free function will deactivate the
+	 * ftrace stub.
+	 */
+	kunit_remove_resource(test, res);
+	kunit_put_resource(res);
+}
+EXPORT_SYMBOL_GPL(kunit_deactivate_ftrace_stub);
+
+void __kunit_activate_ftrace_stub(struct kunit *test,
+				  const char *name,
+				  void *real_fn_addr,
+				  void *replacement_addr)
+{
+	unsigned long ftrace_ip;
+	struct kunit_ftrace_stub_ctx *ctx;
+	int ret;
+
+	ftrace_ip = ftrace_location((unsigned long)real_fn_addr);
+	if (!ftrace_ip)
+		KUNIT_FAIL_AND_ABORT(test, "%s ip is invalid: not a function, or is marked notrace or inline", name);
+
+	/* Allocate the stub context, which contains pointers to the replacement
+	 * function and the test object. It's also registered as a KUnit
+	 * resource which can be looked up by address (to deactivate manually)
+	 * and is destroyed automatically on test exit.
+	 */
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ctx, "failed to allocate kunit stub for %s", name);
+
+	ctx->test = test;
+	ctx->ops = kunit_stub_base_ops;
+	ctx->ops.private = ctx;
+	ctx->real_fn_addr = (unsigned long)real_fn_addr;
+	ctx->replacement_addr = (unsigned long)replacement_addr;
+
+	ret = ftrace_set_filter_ip(&ctx->ops, ftrace_ip, 0, 0);
+	if (ret) {
+		kfree(ctx);
+		KUNIT_FAIL_AND_ABORT(test, "failed to set filter ip for %s: %d", name, ret);
+	}
+
+	ret = register_ftrace_function(&ctx->ops);
+	if (ret) {
+		kfree(ctx);
+		if (ret == -EBUSY)
+			KUNIT_FAIL_AND_ABORT(test, "failed to register stub (-EBUSY) for %s, likely due to already stubbing it?", name);
+		KUNIT_FAIL_AND_ABORT(test, "failed to register stub for %s: %d", name, ret);
+	}
+
+	/* Register the stub as a resource with a cleanup function */
+	kunit_alloc_resource(test, NULL,
+			     __kunit_ftrace_stub_resource_free,
+			     GFP_KERNEL, ctx);
+}
+EXPORT_SYMBOL_GPL(__kunit_activate_ftrace_stub);
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d..1974e8d24a50 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -8,6 +8,7 @@
 
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
+#include <kunit/ftrace_stub.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -152,7 +153,7 @@ static void example_all_expect_macros_test(struct kunit *test)
 }
 
 /* This is a function we'll replace with static stubs. */
-static int add_one(int i)
+static KUNIT_STUBBABLE int add_one(int i)
 {
 	/* This will trigger the stub if active. */
 	KUNIT_STATIC_STUB_REDIRECT(add_one, i);
@@ -277,6 +278,29 @@ static void example_slow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * This test shows the use of ftrace stubs.
+ */
+static void example_ftrace_stub_test(struct kunit *test)
+{
+#if !IS_ENABLED(CONFIG_KUNIT_FTRACE_STUBS)
+	kunit_skip(test, "KUNIT_FTRACE_STUBS not enabled");
+#else
+	/* By default, function is not stubbed. */
+	KUNIT_EXPECT_EQ(test, add_one(1), 2);
+
+	/* Replace add_one() with subtract_one(). */
+	kunit_activate_ftrace_stub(test, add_one, subtract_one);
+
+	/* add_one() is now replaced. */
+	KUNIT_EXPECT_EQ(test, add_one(1), 0);
+
+	/* Return add_one() to normal. */
+	kunit_deactivate_ftrace_stub(test, add_one);
+	KUNIT_EXPECT_EQ(test, add_one(1), 2);
+#endif
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -297,6 +321,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
+	KUNIT_CASE(example_ftrace_stub_test),
 	{}
 };
 
diff --git a/lib/kunit/stubs_example.kunitconfig b/lib/kunit/stubs_example.kunitconfig
new file mode 100644
index 000000000000..a47369199fb9
--- /dev/null
+++ b/lib/kunit/stubs_example.kunitconfig
@@ -0,0 +1,11 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_FTRACE_STUBS=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
+
+# Depedencies
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_MODULES=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_LIVEPATCH=y
-- 
2.49.0.1101.gccaa498523-goog


