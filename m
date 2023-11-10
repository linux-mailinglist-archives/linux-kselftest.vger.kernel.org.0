Return-Path: <linux-kselftest+bounces-9-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6D7E8376
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABA8B20E29
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602613B7B3;
	Fri, 10 Nov 2023 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tE8oHGWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67D3B792
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 20:08:41 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518BAE9
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 12:08:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da2b87dd614so3117571276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699646918; x=1700251718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4YunHZgtb5nkD4PkAgnIRkW9gO+ZcmaQMUyBJXXvNgg=;
        b=tE8oHGWZbUBGyyJNmf7x2wgf8HTQb2oxOBTGnjdTnkGDx2nRbo2SIvZAE6KJgAyyjF
         gc9EF7wUYm8f4ZlCg9yrCarKo/GJyAt5lnOFWBXfM/SJulEMMGWJxZ9eyl0yhiqasprV
         Il5CQ2yO1Jd5szCNxfBiSfNdR97iric9T85I2R9xkXfRH0Hu85OVEV8gQVpYq79exny3
         fFIaihfN5sTGPbEzdQNOkvRPii7SboB1CJoSeXWXdbol+5/6Kd+UJ6haQ+sK4vMfN8H5
         fIXp6OoacNCkCfDiT5HqWrfP9jQoExEldZFUV76EvrzXVYzaVDLs9YayU5pFJjZPKb8N
         3u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646918; x=1700251718;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YunHZgtb5nkD4PkAgnIRkW9gO+ZcmaQMUyBJXXvNgg=;
        b=BgOeo4L3xsHF0Bau959UfZkdX57nl0H4/AeKvg2YoRLXbhjc947Aer7avq0/TrPsrn
         oyG7I5TeLTAIb5QqVKD5bVpI8y1RSP2EaTwmAbw839fJ2Z496sNhVCpbdO0/iIDClFeg
         7h92JUI9jru6+Z0LpM8P+s2REj6Q1DQXO0SPyi3OeenTn1AqQVYPIVnCZbPZfc76OyWd
         +rQrjEjik2E7ApnwFsFGWFXbA68WJneF+GJpQiTWukQWgcwv6rCblxIBkEvfkv1F931S
         NfHf6b4m4QK8wMZKHc/fom3JPR3Ldg+1l8So+w/qIjfcZnWLSejfiwW814QBzW33q8cP
         DaDg==
X-Gm-Message-State: AOJu0YzE0iD57iGl6lJqS2XFPzKYfkTrhRK87TYtY3zCYcxEdWeFViN8
	7uVzP7ysRZr8t+WZnShCwTNl5bZZXlke7w==
X-Google-Smtp-Source: AGHT+IHpA8elPSDmxOHqJghOs6XywJyufpnZHYdeTgE8gm6TvPMzYUyvszmAZYiKI4lKiyHTNGpdXhSKe/S/Cw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d849:0:b0:d9a:f3dc:7d18 with SMTP id
 p70-20020a25d849000000b00d9af3dc7d18mr3271ybg.13.1699646918475; Fri, 10 Nov
 2023 12:08:38 -0800 (PST)
Date: Sat, 11 Nov 2023 04:08:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110200830.1832556-1-davidgow@google.com>
Subject: [PATCH 1/3] kunit: Add a macro to wrap a deferred action function
From: David Gow <davidgow@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, dlatypov@google.com, 
	Maxime Ripard <mripard@kernel.org>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mairacanal@riseup.net>, Sami Tolvanen <samitolvanen@google.com>, 
	kunit-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
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
Signed-off-by: David Gow <davidgow@google.com>
---

This is a follow-up to the RFC here:
https://lore.kernel.org/linux-kselftest/20230915050125.3609689-1-davidgow@google.com/

There's no difference in the macro implementation, just an update to the
KUnit tests to use it. This version is intended to complement:
https://lore.kernel.org/all/20231106172557.2963-1-rf@opensource.cirrus.com/

There are also two follow-up patches in the series to use this macro in
various DRM tests.

Hopefully this will solve any CFI issues that show up with KUnit.

Thanks,
-- David

---
 include/kunit/resource.h | 9 +++++++++
 lib/kunit/kunit-test.c   | 5 +----
 lib/kunit/test.c         | 6 ++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index c7383e90f5c9..4110e13970dc 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -390,6 +390,15 @@ void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 /* A 'deferred action' function to be used with kunit_add_action. */
 typedef void (kunit_action_t)(void *);
 
+/* We can't cast function pointers to kunit_action_t if CFI is enabled. */
+#define KUNIT_DEFINE_ACTION_WRAPPER(wrapper, orig, arg_type) \
+	static void wrapper(void *in) \
+	{ \
+		arg_type arg = (arg_type)in; \
+		orig(arg); \
+	}
+
+
 /**
  * kunit_add_action() - Call a function when the test ends.
  * @test: Test case to associate the action with.
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index de2113a58fa0..ee6927c60979 100644
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
2.42.0.869.gea05f2083d-goog


