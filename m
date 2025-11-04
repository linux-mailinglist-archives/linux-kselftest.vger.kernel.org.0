Return-Path: <linux-kselftest+bounces-44701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9074C30739
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 229623439F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523B02D249A;
	Tue,  4 Nov 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reaWINw9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACA315D42
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251447; cv=none; b=NRA9I7WooI/JYBgmO/IKLR1nCyxFxPj2clJmJqXJxhvkiUFW31nFpn19aBphdcSlcPXRzQzC/K7NNckOovnl1eR72l8q1myecJHFi+xz7Ci2Hs6yPRwOrZbEJJEZHmTBiqC6DBxHg2/Vj7Q5kcRvU7j1QCJUSB5fNGBdVldWT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251447; c=relaxed/simple;
	bh=+vAkhX2GPwYds5GzN4RuhsoXYalDXmGVFwjBr8fTTgQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TVNDIsUwpmefeWi2HASC0F8+aaj+K4xC5qRcxvM9tvZDhnWh5e1N4fhVkL0vW90/LdBzO9j38YXEXi5PJyVYC9hQW9ztqoLzlMI67UfkPui34v+cgzOvQz47TBplwBnAgP0AaX4f4suCcVT8FlQA4VcjBApCX/Z7uR6UlONtjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reaWINw9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eddiephillips.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956a694b47so32460435ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762251444; x=1762856244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N5A8l31/M7+am0u9EmygIdlCANYboKtWMm6IOfkh/p4=;
        b=reaWINw95VAE8gumLWdnYzYMZI954CoKed+dtbftK9h07G86i1vdgquNA3hEZNXoDa
         OAPNIEHmcJpqEM4+zlxLyFpMoNv1RHA8Sl7pZQVFkpCNHpEAqQZzPpP8R0/7+c0aqguN
         XO5YPvSVVLpw3ZOOJknYTT1bjrd7nQZH1qRdGhhcZzSXLPZgb/XxAtGTOLPrhkcWHI/h
         NSpW6ahWuyl4r51TcFZEzdpEUbXkIDLLGVAq7Hr6FJ0zexZXMTXk/EK2F8w9bSJFlXAj
         gUxrJDzQHTck5CpMLLH5OuVeMXlJT8rgCzmdUiJRbvsce96xHziZtcSrTgNPOLFCaEcy
         KGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251444; x=1762856244;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5A8l31/M7+am0u9EmygIdlCANYboKtWMm6IOfkh/p4=;
        b=j2OLsNQQEp9EjiZESSo9n5/ccTGl+pMeoxOvTc5S/wg+VkfdQeLEbyFrQPXM0MmVG9
         lLbk6MqbnoMX52hM4rvLaP/d+zbRSy1bx7VTt9raBm+Olb4ua9IBOIF4JBmVgnbRgxzT
         FAmfseApeP33Dy10eVOe02nW04zfHe8KI75Nk3j/BQtiRXRhbDuezI4Fe+HudeVPEDzB
         AH6v5zeXWuMWzZHCzBebp6Egmat4QOdHYs5favJmkKNroogsauJwywpzwIC+vspBNDcv
         MJ0N63UNM5fxz1p4WOyYZJDQwjsmMiXwl/1zGA1HL1tA1ILd3c9yVyuLJAwiq5GCBseT
         MBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw4wsw95dRBHR6TCKHdw8OlKLbtGRoclaeDkSLkrFrDUyQxFHT3yFNsL9eeSb3QlaSXEtaE97k49jRKeBBJ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmAk3otq9ZYRKeTdRsb9IJhrbEl6sU4IQzZZBemQRL5WS6z99b
	8lkTbacJWHMgNPJskQ9mOZ2QtudQBG9cNOa382FwATDCSESFnO1MJCB52OIrzYCrMAyckBCp9pe
	WDvyupDq2A0yj4B2KCiv4VIQnGQaz2FM2sg==
X-Google-Smtp-Source: AGHT+IEc5Mg+yN92hQ4fYhXXnF0jJZYvBkCNqO01yULkKsuhvrTDSIS/lBBF0iDBsfr7u/26VQeL3hIxWO6Vw1YLcY6h
X-Received: from pllq3.prod.google.com ([2002:a17:902:7883:b0:296:18d:ea1b])
 (user=eddiephillips job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da82:b0:295:3ad7:948a with SMTP id d9443c01a7336-2953ad7963cmr190803355ad.16.1762251444467;
 Tue, 04 Nov 2025 02:17:24 -0800 (PST)
Date: Tue,  4 Nov 2025 10:16:21 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251104101621.3977468-1-eddiephillips@google.com>
Subject: [PATCH] kunit: Implement ftrace-based stubbing
From: Eddie Phillips <eddiephillips@google.com>
To: davidgow@google.com
Cc: brendan.higgins@linux.dev, rmoar@google.com, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Eddie Phillips <eddiephillips@google.com>, 
	Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow function redirection using ftrace. This is basically
equivalent to the static_stub support in the previous patch,
but does not require the function being replaced to be modified (save
for the addition of KUNIT_STUBBABLE/noinline).

This is hidden behind the CONFIG_KUNIT_FTRACE_STUBS option, and has a
number of dependencies, including ftrace and CONFIG_KALLSYMS_ALL.
As a result, it only works on architectures where these are available.

You can run the KUnit example tests with the following: $
./tools/testing/kunit/kunit.py run --kunitconfig
lib/kunit/stubs_example.kunitconfig --arch=x86_64

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

[1]
https://lore.kernel.org/lkml/20220224091550.2b7e8784@gandalf.local.home

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Eddie Phillips <eddiephillips@google.com>
---

Link to original: https://lore.kernel.org/all/20220910212804.670622-3-davidgow@google.com/

 include/kunit/ftrace_stub.h         |  84 ++++++++++++++++
 lib/kunit/Kconfig                   |  11 +++
 lib/kunit/Makefile                  |   4 +
 lib/kunit/ftrace_stub.c             | 146 ++++++++++++++++++++++++++++
 lib/kunit/kunit-example-test.c      |  29 +++++-
 lib/kunit/stubs_example.kunitconfig |  10 ++
 6 files changed, 282 insertions(+), 2 deletions(-)
 create mode 100644 include/kunit/ftrace_stub.h
 create mode 100644 lib/kunit/ftrace_stub.c
 create mode 100644 lib/kunit/stubs_example.kunitconfig

diff --git a/include/kunit/ftrace_stub.h b/include/kunit/ftrace_stub.h
new file mode 100644
index 000000000000..bfd57ea6289c
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
+ * are not inlined. This macro eavlautes to noinline when stubbing support is
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
+ *		kunit_active_ftrace_stub(test, real_func, replacement_func);
+ *		KUNIT_EXPECT_EQ(test, real_func(1), 42);
+ *	}
+ *
+ */
+#define kunit_activate_ftrace_stub(test, real_fn_addr, replacement_addr) do { \
+	typecheck_fn(typeof(&replacement_addr), real_fn_addr);			\
+	__kunit_activate_ftrace_stub(test, #real_fn_addr, real_fn_addr, replacement_addr); \
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
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 7a6af361d2fc..8a629017b917 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -70,6 +70,17 @@ config KUNIT_ALL_TESTS
 
 	  If unsure, say N.
 
+config KUNIT_FTRACE_STUBS
+	bool "Support for stubbing out functions in KUnit tests with ftrace and kernel livepatch"
+	depends on FTRACE=y && FUNCTION_TRACER=y && MODULES=y && DEBUG_KERNEL=y && KALLSYMS_ALL=y
+	help
+	  Builds support for stubbing out functions for the duration of KUnit
+	  test cases or suites using ftrace.
+	  See KUNIT_EXAMPLE_TEST for an example.
+
+	  NOTE: this does not work on all architectures (like UML) and
+	  relies on a lot of magic (see the dependencies list).
+
 config KUNIT_DEFAULT_ENABLED
 	bool "Default value of kunit.enable"
 	default y
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 656f1fa35abc..f04f6ea4d6a8 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -29,3 +29,7 @@ obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 endif
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+
+ifeq ($(CONFIG_KUNIT_FTRACE_STUBS),y)
+kunit-objs +=				ftrace_stub.o
+endif
\ No newline at end of file
diff --git a/lib/kunit/ftrace_stub.c b/lib/kunit/ftrace_stub.c
new file mode 100644
index 000000000000..b19eaa35f5ed
--- /dev/null
+++ b/lib/kunit/ftrace_stub.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/ftrace_stub.h>
+#include <kunit/test.h>
+
+#include <linux/typecheck.h>
+
+#include <linux/ftrace.h>
+#include <linux/livepatch.h>
+#include <linux/sched.h>
+
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
+static bool __kunit_static_stub_resource_match(struct kunit *test,
+						struct kunit_resource *res,
+						void *match_real_fn_addr)
+{
+	/* This pointer is only valid if res is a static stub resource. */
+	struct kunit_ftrace_stub_ctx *ctx = res->data;
+
+	/* Make sure the resource is a static stub resource. */
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
+				  __kunit_static_stub_resource_match,
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
+		KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION,
+			"%s ip is invalid: not a function, or is marked notrace or inline", name);
+
+	/* Allocate the stub context, which contains pointers to the replacement
+	 * function and the test object. It's also registered as a KUnit
+	 * resource which can be looked up by address (to deactivate manually)
+	 * and is destroyed automatically on test exit.
+	 */
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_PTR_NE_MSG(test, ctx, NULL, "failed to allocate kunit stub for %s", name);
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
+		KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION,
+				     "failed to set filter ip for %s: %d", name, ret);
+	}
+
+	ret = register_ftrace_function(&ctx->ops);
+	if (ret) {
+		kfree(ctx);
+		if (ret == -EBUSY)
+			KUNIT_FAIL_ASSERTION(
+				test, KUNIT_ASSERTION,
+				"failed to register stub (-EBUSY) for %s, likely due to already stubbing it?",
+				name);
+		KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION,
+				     "failed to register stub for %s: %d", name,
+				     ret);
+	}
+
+	kunit_alloc_resource(test, NULL,
+			     __kunit_ftrace_stub_resource_free,
+			     GFP_KERNEL, ctx);
+}
+EXPORT_SYMBOL_GPL(__kunit_activate_ftrace_stub);
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 9452b163956f..676ad552ae7b 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -6,8 +6,9 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/test.h>
+#include <kunit/ftrace_stub.h>
 #include <kunit/static_stub.h>
+#include <kunit/test.h>
 
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
@@ -221,6 +222,29 @@ static void example_static_stub_using_fn_ptr_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, add_one(1), 2);
 }
 
+/*
+ * This test shows the use of dynamic stubs.
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
 static const struct example_param {
 	int value;
 } example_params_array[] = {
@@ -506,6 +530,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
 	KUNIT_CASE(example_static_stub_using_fn_ptr_test),
+	KUNIT_CASE(example_ftrace_stub_test),
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, kunit_array_gen_params,
diff --git a/lib/kunit/stubs_example.kunitconfig b/lib/kunit/stubs_example.kunitconfig
new file mode 100644
index 000000000000..20af4da9bc75
--- /dev/null
+++ b/lib/kunit/stubs_example.kunitconfig
@@ -0,0 +1,10 @@
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
-- 
2.51.1.851.g4ebd6896fd-goog


