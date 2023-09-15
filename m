Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527407A14FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 07:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjIOFBv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 01:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOFBu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 01:01:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E2270C
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 22:01:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0327b75dso10538997b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 22:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694754103; x=1695358903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9rCph9Ke3trsfRl0d5Mycw1TxfealFq99Kh2f8hpgHs=;
        b=3qOjYjACdSIb1+QDn3UmOeWXOfpfh8/kLKA+KVgTVFDaGhKa0UGeAIIjrUoqv5GnFQ
         gwEghF6e525pKbq/Aio0EUh3bMb/8rVbAz2YXuoJU2NqpJnmX6FzDy3pwbeYAeezHDf3
         hsLWpUKazeYjOYzOukdW1Zk07rrwMdN1laEYhpsEask3kpPJcVCm9qu8Q9PUruM+HjtN
         H3Rl1Weufigo5wXrTd9uvuYFRoj8Z2VXXkSj1hvcYxYK4VPjTFZ5foOfaLQFWLmvclMQ
         +eQSRdZWvQZlQxhQml14GS0JKKnIb3NNHRZMcGFLllPcEKiYTjP82vy7sOoaLkX3j9vM
         9S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694754103; x=1695358903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rCph9Ke3trsfRl0d5Mycw1TxfealFq99Kh2f8hpgHs=;
        b=TPDhqf6qWrZthuOGQZgz8lRoz8Lwy4wwUIVxWRUXDjqTNaQ6szI+Cm6Etg/6bVaXOI
         Ma25vJL0Xm1DaZb0+F4/VRNph4U42KJHWZRBbMlJaLVswKBZcXhGyDduAuj6M4I4gPXW
         /QM8Um3OqCX8y34GT57/sLolAFWJWNoURCUMZXUya13RnaoTOc09SlZxsWHvPNxkv5IX
         vlWPtRZFVc9elI+x1MFxq7zhhT7eJe+w44nXeKX9D/CJVxV3sLE+QMSR711dvjzT2YIh
         24L0ZvwSnBIZSWwxZ/zABYW/HTqWsfs8bh0DRZ6Hw72AG4kLi6FE3U4gyadwV2acnBWZ
         7wdw==
X-Gm-Message-State: AOJu0Ywu8w/g7WfyGaHaMedCRDh83o1HKm2cuqWIWovN9tmtivc6tYN6
        2PImeiF8TcGp5OxNpEjoVt++A0o8GPws7w==
X-Google-Smtp-Source: AGHT+IH5zlAB2HKrUfKZ3gto/cPG2gsfk0RtuOfBjG670gz/zKlu5ZCu6/j8d0kg3b2lpF9qSe5ELncZZj3OVA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:b312:0:b0:d0b:c67:de3b with SMTP id
 l18-20020a25b312000000b00d0b0c67de3bmr7744ybj.13.1694754103676; Thu, 14 Sep
 2023 22:01:43 -0700 (PDT)
Date:   Fri, 15 Sep 2023 13:01:23 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915050125.3609689-1-davidgow@google.com>
Subject: [RFC PATCH] kunit: Add a macro to wrap a deferred action function
From:   David Gow <davidgow@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, dlatypov@google.com
Cc:     David Gow <davidgow@google.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
leaves us with a few options:
1. Stick our fingers in our ears an ignore the warning. (It's worked so
   far, but probably isn't the right thing to do.)
2. Find some horrible way of casting which fools the compiler into
   letting us do the cast. (It'd still break CFI, though.)
3. Disable the warning, and CFI for this function. This isn't optimal,
   but may make sense for test-only code. However, I think we'd have to
   do this for every function called, not just the caller, so maybe it's
   not practical.
4. Manually write wrappers around any such functions. This is ugly (do
   we really want two copies of each function, one of which has no type
   info and just forwards to the other). It could get repetitive.
5. Generate these wrappers with a macro. That's what this patch does.

I'm broadly okay with any of the options above, though whatever we go
with will no doubt require some bikeshedding of details (should these
wrappers be public, do we dedupe them, etc).

Thoughts?

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Signed-off-by: David Gow <davidgow@google.com>
---

I finally got around to setting up clang 16 to look into these warnings:

   lib/kunit/test.c:764:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
           if (kunit_add_action_or_reset(test, (kunit_action_t *)kfree, data) != 0)
                                               ^~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/test.c:776:29: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
           kunit_release_action(test, (kunit_action_t *)kfree, (void *)ptr);
                                      ^~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.

It's probably something which needs fixing with wrappers, not with the
"just keep casting things until the compiler forgets" strategy.

There are few enough uses of kunit_add_action() that now's the time to
change things if we want to fix these warnings (and, I guess, work with
CFI). This patch uses an ugly macro, but we're definitely still at the
point where doing this by hand might make more sense.

Don't take this exact patch too seriously: it's mostly a discussion
starter so we can decide on a plan.

Cheers,
-- David

---
 include/kunit/resource.h  | 9 +++++++++
 lib/kunit/executor_test.c | 7 +++----
 lib/kunit/test.c          | 6 ++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

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
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index b4f6f96b2844..14ac64f4f71b 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -256,9 +256,8 @@ kunit_test_suites(&executor_test_suite);
 
 /* Test helpers */
 
-/* Use the resource API to register a call to kfree(to_free).
- * Since we never actually use the resource, it's safe to use on const data.
- */
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_action_wrapper, kfree, const void *)
+/* Use the resource API to register a call to kfree(to_free). */
 static void kfree_at_end(struct kunit *test, const void *to_free)
 {
 	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
@@ -266,7 +265,7 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 		return;
 
 	kunit_add_action(test,
-			(kunit_action_t *)kfree,
+			kfree_action_wrapper,
 			(void *)to_free);
 }
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f13981412..41b7d9a090fb 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -804,6 +804,8 @@ static struct notifier_block kunit_mod_nb = {
 };
 #endif
 
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_action_wrapper, kfree, const void *)
+
 void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 {
 	void *data;
@@ -813,7 +815,7 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 	if (!data)
 		return NULL;
 
-	if (kunit_add_action_or_reset(test, (kunit_action_t *)kfree, data) != 0)
+	if (kunit_add_action_or_reset(test, kfree_action_wrapper, data) != 0)
 		return NULL;
 
 	return data;
@@ -825,7 +827,7 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 	if (!ptr)
 		return;
 
-	kunit_release_action(test, (kunit_action_t *)kfree, (void *)ptr);
+	kunit_release_action(test, kfree_action_wrapper, (void *)ptr);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
-- 
2.42.0.459.ge4e396fd5e-goog

