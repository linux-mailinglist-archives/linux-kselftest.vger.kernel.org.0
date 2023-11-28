Return-Path: <linux-kselftest+bounces-696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D7A7FB29E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 08:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77985B20E06
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BFB134AE;
	Tue, 28 Nov 2023 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDSpIpnd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C082D4D
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 23:24:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03c5ae220so4678965276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 23:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701156265; x=1701761065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dvx2P3RlbyRadhNqdVh/rq/P7n3DUdzfAYi6/zso4eU=;
        b=EDSpIpndYxcQnE/+ALcHOFLIJSTX13TbdW/tJYXvWQBX4IZ3+fKbzIVT2AYoVJh7Py
         QfVA06aAQ81/oqv77USWIY0B+Fk2Gcq5SuaUmcBN9/xDBTfmXlwWnacXLmvM8VFwpjID
         RU2iqhf8xvWrBM6MsXbKnAFPd5FCPV2uQWX84oMNjhqvQkXz5BEjt1JwkbtgV2BIRCMY
         EBLFc8afttcyWoBVOTsxfWlKEamf63C4w0KLxWBoZCK8G6mKhBSs/0NFqksW/uiBAVxh
         yXXEIFU+CpYwivuQ3jZdZlrcGdehebycP6sZ6AH1nwAGMVScRuClE648EsKmWRndyOLW
         6r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156265; x=1701761065;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvx2P3RlbyRadhNqdVh/rq/P7n3DUdzfAYi6/zso4eU=;
        b=Q4daGut/FEPSFY8Y/AN+bAQpsdsFQDcxqm87m0cmCblwHniy+kF71ZDolPf+SCVIrc
         wSIqGvrAb+WE8sUha/YGAbmbZZ1FVTo6huMioWqwxAimGpBlpS3XXukW2Jq6z1wjGmuh
         XZpvxiYfPJsPD7DZeeCoWUNhLPsE6eNPteGxAYbfxOWL2tzbLGfLfqlPea1enULl7Bkw
         pZq20ien96SAqpZdu+roOx0YCgQYJQOiR5QrtFEoHfMxoosVqW7rm2FwbGeJMr5Rl1c2
         9pWZa7K0yW4kGMYU/J6eeoZzdBv5JmGiHTZt/MUVh/k//CzZw1M2qJalZBPQHdeyGJOZ
         wu7Q==
X-Gm-Message-State: AOJu0Yx7ORzdphniNaU2xu193CGU9XoO+e+UD6n/9wmTBQvK2W1jtfHf
	LXRNg/UzM4J3ZcnkK7CZx2hP/Z20Vb7wHg==
X-Google-Smtp-Source: AGHT+IFCWZKfFAeCOUzJQoMqiA3WNtBjsLMP38UcQK2Ohu2ghv3SrS0a6Zu87OoFuUvbxbOdjliN7STeoHt5sw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:6949:0:b0:da0:c924:4fdc with SMTP id
 e70-20020a256949000000b00da0c9244fdcmr614120ybc.6.1701156265389; Mon, 27 Nov
 2023 23:24:25 -0800 (PST)
Date: Tue, 28 Nov 2023 15:24:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128072410.952662-1-davidgow@google.com>
Subject: [PATCH v2 1/3] kunit: Add a macro to wrap a deferred action function
From: David Gow <davidgow@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, dlatypov@google.com
Cc: David Gow <davidgow@google.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

KUnit's deferred action API accepts a void(*)(void *) function pointer
which is called when the test is exited. However, we very frequently
want to use existing functions which accept a single pointer, but which
may not be of type void*. While this is probably dodgy enough to be on
the wrong side of the C standard, it's been often used for similar
callbacks, and gcc's -Wcast-function-type seems to ignore cases where
the only difference is the type of the argument, assuming it's
compatible (i.e., they're both pointers to data).

However, clang 16 has introduced -Wcast-function-type-strict, which no
longer permits any deviation in function pointer type. This seems to be
because it'd break CFI, which validates the type of function calls.

This rather ruins our attempts to cast functions to defer them, and
leaves us with a few options. The one we've chosen is to implement a
macro which will generate a wrapper function which accepts a void*, and
casts the argument to the appropriate type.

For example, if you were trying to wrap:
void foo_close(struct foo *handle);
you could use:
KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_foo_close,
			    foo_close,
			    struct foo *);

This would create a new kunit_action_foo_close() function, of type
kunit_action_t, which could be passed into kunit_add_action() and
similar functions.

In addition to defining this macro, update KUnit and its tests to use
it.

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---

Thanks everyone for testing v1 of this: this update only changes
documentation.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20231110200830.1832556-1-davidgow@google.com/
- Update the usage.rst documentation (Thanks, Nathan)
- Add a better doc comment for KUNIT_DEFINE_ACTION_WRAPPER()

---
 Documentation/dev-tools/kunit/usage.rst | 10 +++++++---
 include/kunit/resource.h                | 21 +++++++++++++++++++++
 lib/kunit/kunit-test.c                  |  5 +----
 lib/kunit/test.c                        |  6 ++++--
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c27e1646ecd9..9db12e91668e 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -651,12 +651,16 @@ For example:
 	}
 
 Note that, for functions like device_unregister which only accept a single
-pointer-sized argument, it's possible to directly cast that function to
-a ``kunit_action_t`` rather than writing a wrapper function, for example:
+pointer-sized argument, it's possible to automatically generate a wrapper
+with the ``KUNIT_DEFINE_ACTION_WRAPPER()`` macro, for example:
 
 .. code-block:: C
 
-	kunit_add_action(test, (kunit_action_t *)&device_unregister, &dev);
+	KUNIT_DEFINE_ACTION_WRAPPER(device_unregister, device_unregister_wrapper, struct device *);
+	kunit_add_action(test, &device_unregister_wrapper, &dev);
+
+You should do this in preference to manually casting to the ``kunit_action_t`` type,
+as casting function pointers will break Control Flow Integrity (CFI).
 
 ``kunit_add_action`` can fail if, for example, the system is out of memory.
 You can use ``kunit_add_action_or_reset`` instead which runs the action
diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index c7383e90f5c9..4ad69a2642a5 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -390,6 +390,27 @@ void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 /* A 'deferred action' function to be used with kunit_add_action. */
 typedef void (kunit_action_t)(void *);
 
+/**
+ * KUNIT_DEFINE_ACTION_WRAPPER() - Wrap a function for use as a deferred action.
+ *
+ * @wrapper: The name of the new wrapper function define.
+ * @orig: The original function to wrap.
+ * @arg_type: The type of the argument accepted by @orig.
+ *
+ * Defines a wrapper for a function which accepts a single, pointer-sized
+ * argument. This wrapper can then be passed to kunit_add_action() and
+ * similar. This should be used in preference to casting a function
+ * directly to kunit_action_t, as casting function pointers will break
+ * control flow integrity (CFI), leading to crashes.
+ */
+#define KUNIT_DEFINE_ACTION_WRAPPER(wrapper, orig, arg_type)	\
+	static void wrapper(void *in)				\
+	{							\
+		arg_type arg = (arg_type)in;			\
+		orig(arg);					\
+	}
+
+
 /**
  * kunit_add_action() - Call a function when the test ends.
  * @test: Test case to associate the action with.
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 99d2a3a528e1..3e9c5192d095 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -538,10 +538,7 @@ static struct kunit_suite kunit_resource_test_suite = {
 #if IS_BUILTIN(CONFIG_KUNIT_TEST)
 
 /* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
-static void kfree_wrapper(void *p)
-{
-	kfree(p);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
 
 static void kunit_log_test(struct kunit *test)
 {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f2eb71f1a66c..0308865194bb 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -772,6 +772,8 @@ static struct notifier_block kunit_mod_nb = {
 };
 #endif
 
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_action_wrapper, kfree, const void *)
+
 void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 {
 	void *data;
@@ -781,7 +783,7 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 	if (!data)
 		return NULL;
 
-	if (kunit_add_action_or_reset(test, (kunit_action_t *)kfree, data) != 0)
+	if (kunit_add_action_or_reset(test, kfree_action_wrapper, data) != 0)
 		return NULL;
 
 	return data;
@@ -793,7 +795,7 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 	if (!ptr)
 		return;
 
-	kunit_release_action(test, (kunit_action_t *)kfree, (void *)ptr);
+	kunit_release_action(test, kfree_action_wrapper, (void *)ptr);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


