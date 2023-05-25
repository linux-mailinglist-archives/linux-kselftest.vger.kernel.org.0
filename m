Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94AE710400
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 06:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjEYEVu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 00:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjEYEVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 00:21:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73322C0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 21:21:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb3528ce5so258849276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 21:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684988504; x=1687580504;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AzhuR3J+H4HFebNt/N57B/j04YG/pocBv90fNAbkUCY=;
        b=IS/pR4Lfg6tJdqnwx0zkrMqQFFgH9Q/OcSNENpXFfUqMFniAtPOlRWvVO4QtPqO8Vh
         STl9RlY/WhcQ4Iv0Ldu3NvzCBxR0VeymIFoZfNULzH9PaGOqiMPaEd5eZTbwgRToXOXA
         su6MzgMRcn8T9YotczPhgbYd9YHV8r54coctevewfsw/oVkHr6cp3I3fntsoQOcNexZR
         HDy0ybx7nuWrymF+AhqT4jQGISY8f0dgo/HV8P5eRgqMtCZ8dn9wnzAq+GV1U9a6aT+V
         hOvqJxlLaSfuuvjYsVWhsse/ce0WIeq8fNGpdFOKJTYxEpH+HtkK96wOLBbeG3KW+Cg2
         RIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684988504; x=1687580504;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzhuR3J+H4HFebNt/N57B/j04YG/pocBv90fNAbkUCY=;
        b=autTCbMwhtdt53CZ/qqBH6bVTcOkYNCGspxsDtk4MBtQRZnMoj/V3s2u1wXaYwZIRd
         kcsrt4LAP6BkGeftOAhdv3PYaR8qGnUUFAUISt0stjH1x7uk2rtJeNVer9jFeYHukFeC
         Bt1yxnr7MUW/5mXEPKOIIQuVSMAP9ykH41MaEzTKgYzy6QwB/XGNoJI3WK7y7WjPL5ID
         WQmukIsRvk/de75vbkXwu5xyFeS9RxyiEhAoYWDXNRJ4ILtxWY5hmUCrdsOzan0cZ7OC
         chKGn+mrZ65U4cyl4Z8b8QJKj3Y+rKnHvZW+Zs0l5+BMTIWRTEVpxudmM0N03RZJkSHQ
         wrJw==
X-Gm-Message-State: AC+VfDw3wVyL5AV8lLPM+J+2e+nBRwzj91wtoiG91NKeCxGMIEfOQdDj
        4QTYEh2nNp7KOkVPiRsfyeqNujn5/vxZzQ==
X-Google-Smtp-Source: ACHHUZ7QcDJYmWYP4UN3fqOfctGeoIxcp1XlUl9nn8DEsEqY8wMD74O1rY7XW37X+88h5tZBF/XAXGiXlUAvRA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:118e:b0:ba7:5bec:7772 with SMTP
 id m14-20020a056902118e00b00ba75bec7772mr1023398ybu.5.1684988504660; Wed, 24
 May 2023 21:21:44 -0700 (PDT)
Date:   Thu, 25 May 2023 12:21:28 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230525042133.212534-1-davidgow@google.com>
Subject: [PATCH v3 1/4] kunit: Add kunit_add_action() to defer a call until
 test exit
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Many uses of the KUnit resource system are intended to simply defer
calling a function until the test exits (be it due to success or
failure). The existing kunit_alloc_resource() function is often used for
this, but was awkward to use (requiring passing NULL init functions, etc),
and returned a resource without incrementing its reference count, which
-- while okay for this use-case -- could cause problems in others.

Instead, introduce a simple kunit_add_action() API: a simple function
(returning nothing, accepting a single void* argument) can be scheduled
to be called when the test exits. Deferred actions are called in the
opposite order to that which they were registered.

This mimics the devres API, devm_add_action(), and also provides
kunit_remove_action(), to cancel a deferred action, and
kunit_release_action() to trigger one early.

This is implemented as a resource under the hood, so the ordering
between resource cleanup and deferred functions is maintained.

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v2:
https://lore.kernel.org/linux-kselftest/20230518083849.2631178-1-davidgow@google.com/

Changes since v1:
https://lore.kernel.org/linux-kselftest/20230421084226.2278282-2-davidgow@google.com/
- Some small documentation updates (Thanks Daniel)
- Reinstate a typedef for the action function.
  - This time, it's called kunit_action_t
  - Thanks Maxime!

Changes since RFC v2:
https://lore.kernel.org/linux-kselftest/20230331080411.981038-2-davidgow@google.com/
- Got rid of internal_gfp
  - everything uses GFP_KERNEL now
  - This includes kunit_kzalloc() and friends, which still allocate the
    returned memory with the provided GFP, but use GFP_KERNEL for
    internal bookkeeping data.
  - Thanks Maxime & Benjamin!
- Got rid of cancellation tokens.
  - kunit_add_action() now returns 0 on success, otherwise an error
  - Note that this can quite easily lead to a memory leak, so look at
    kunit_add_action_or_reset()
  - Thanks Maxime & Benjamin!
- Added kunit_add_action_or_reset
  - Matches devm_add_action_or_reset()
  - Returns 0 on success.
  - Thanks Maxime & Benjamin!
- Got rid of the kunit_defer_func_t typedef.
  - I liked it, but it is probably pushing the boundaries of kernel
    style.
  - Use (void (*)(void *)) instead.

Changes since RFC v1:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow@google.com/
- Rename functions to better match the devm_* APIs. (Thanks Maxime)
- Embed the kunit_resource in struct kunit_action_ctx to avoid an extra
  allocation (Thanks Benjamin)
- Use 'struct kunit_action_ctx' as the type for cancellation tokens
  (Thanks Benjamin)
- Add tests.


---
 include/kunit/resource.h | 92 +++++++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c   | 88 ++++++++++++++++++++++++++++++++++-
 lib/kunit/resource.c     | 99 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index c0d88b318e90..b64eb783b1bc 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -387,4 +387,96 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
  */
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 
+/* A 'deferred action' function to be used with kunit_add_action. */
+typedef void (kunit_action_t)(void *);
+
+/**
+ * kunit_add_action() - Call a function when the test ends.
+ * @test: Test case to associate the action with.
+ * @func: The function to run on test exit
+ * @ctx: Data passed into @func
+ *
+ * Defer the execution of a function until the test exits, either normally or
+ * due to a failure.  @ctx is passed as additional context. All functions
+ * registered with kunit_add_action() will execute in the opposite order to that
+ * they were registered in.
+ *
+ * This is useful for cleaning up allocated memory and resources, as these
+ * functions are called even if the test aborts early due to, e.g., a failed
+ * assertion.
+ *
+ * See also: devm_add_action() for the devres equivalent.
+ *
+ * Returns:
+ *   0 on success, an error if the action could not be deferred.
+ */
+int kunit_add_action(struct kunit *test, kunit_action_t *action, void *ctx);
+
+/**
+ * kunit_add_action_or_reset() - Call a function when the test ends.
+ * @test: Test case to associate the action with.
+ * @func: The function to run on test exit
+ * @ctx: Data passed into @func
+ *
+ * Defer the execution of a function until the test exits, either normally or
+ * due to a failure.  @ctx is passed as additional context. All functions
+ * registered with kunit_add_action() will execute in the opposite order to that
+ * they were registered in.
+ *
+ * This is useful for cleaning up allocated memory and resources, as these
+ * functions are called even if the test aborts early due to, e.g., a failed
+ * assertion.
+ *
+ * If the action cannot be created (e.g., due to the system being out of memory),
+ * then action(ctx) will be called immediately, and an error will be returned.
+ *
+ * See also: devm_add_action_or_reset() for the devres equivalent.
+ *
+ * Returns:
+ *   0 on success, an error if the action could not be deferred.
+ */
+int kunit_add_action_or_reset(struct kunit *test, kunit_action_t *action,
+			      void *ctx);
+
+/**
+ * kunit_remove_action() - Cancel a matching deferred action.
+ * @test: Test case the action is associated with.
+ * @func: The deferred function to cancel.
+ * @ctx: The context passed to the deferred function to trigger.
+ *
+ * Prevent an action deferred via kunit_add_action() from executing when the
+ * test terminates.
+ *
+ * If the function/context pair was deferred multiple times, only the most
+ * recent one will be cancelled.
+ *
+ * See also: devm_remove_action() for the devres equivalent.
+ */
+void kunit_remove_action(struct kunit *test,
+			 kunit_action_t *action,
+			 void *ctx);
+
+/**
+ * kunit_release_action() - Run a matching action call immediately.
+ * @test: Test case the action is associated with.
+ * @func: The deferred function to trigger.
+ * @ctx: The context passed to the deferred function to trigger.
+ *
+ * Execute a function deferred via kunit_add_action()) immediately, rather than
+ * when the test ends.
+ *
+ * If the function/context pair was deferred multiple times, it will only be
+ * executed once here. The most recent deferral will no longer execute when
+ * the test ends.
+ *
+ * kunit_release_action(test, func, ctx);
+ * is equivalent to
+ * func(ctx);
+ * kunit_remove_action(test, func, ctx);
+ *
+ * See also: devm_release_action() for the devres equivalent.
+ */
+void kunit_release_action(struct kunit *test,
+			  kunit_action_t *action,
+			  void *ctx);
 #endif /* _KUNIT_RESOURCE_H */
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 42e44caa1bdd..83d8e90ca7a2 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -112,7 +112,7 @@ struct kunit_test_resource_context {
 	struct kunit test;
 	bool is_resource_initialized;
 	int allocate_order[2];
-	int free_order[2];
+	int free_order[4];
 };
 
 static int fake_resource_init(struct kunit_resource *res, void *context)
@@ -403,6 +403,88 @@ static void kunit_resource_test_named(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
 }
 
+static void increment_int(void *ctx)
+{
+	int *i = (int *)ctx;
+	(*i)++;
+}
+
+static void kunit_resource_test_action(struct kunit *test)
+{
+	int num_actions = 0;
+
+	kunit_add_action(test, increment_int, &num_actions);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Once we've cleaned up, the action queue is empty. */
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Check the same function can be deferred multiple times. */
+	kunit_add_action(test, increment_int, &num_actions);
+	kunit_add_action(test, increment_int, &num_actions);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 3);
+}
+static void kunit_resource_test_remove_action(struct kunit *test)
+{
+	int num_actions = 0;
+
+	kunit_add_action(test, increment_int, &num_actions);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+
+	kunit_remove_action(test, increment_int, &num_actions);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+}
+static void kunit_resource_test_release_action(struct kunit *test)
+{
+	int num_actions = 0;
+
+	kunit_add_action(test, increment_int, &num_actions);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+	/* Runs immediately on trigger. */
+	kunit_release_action(test, increment_int, &num_actions);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Doesn't run again on test exit. */
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+}
+static void action_order_1(void *ctx)
+{
+	struct kunit_test_resource_context *res_ctx = (struct kunit_test_resource_context *)ctx;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(res_ctx, free_order, 1);
+	kunit_log(KERN_INFO, current->kunit_test, "action_order_1");
+}
+static void action_order_2(void *ctx)
+{
+	struct kunit_test_resource_context *res_ctx = (struct kunit_test_resource_context *)ctx;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(res_ctx, free_order, 2);
+	kunit_log(KERN_INFO, current->kunit_test, "action_order_2");
+}
+static void kunit_resource_test_action_ordering(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_add_action(test, action_order_1, ctx);
+	kunit_add_action(test, action_order_2, ctx);
+	kunit_add_action(test, action_order_1, ctx);
+	kunit_add_action(test, action_order_2, ctx);
+	kunit_remove_action(test, action_order_1, ctx);
+	kunit_release_action(test, action_order_2, ctx);
+	kunit_cleanup(test);
+
+	/* [2 is triggered] [2], [(1 is cancelled)] [1] */
+	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 2);
+	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
+	KUNIT_EXPECT_EQ(test, ctx->free_order[2], 1);
+}
+
 static int kunit_resource_test_init(struct kunit *test)
 {
 	struct kunit_test_resource_context *ctx =
@@ -434,6 +516,10 @@ static struct kunit_case kunit_resource_test_cases[] = {
 	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
 	KUNIT_CASE(kunit_resource_test_static),
 	KUNIT_CASE(kunit_resource_test_named),
+	KUNIT_CASE(kunit_resource_test_action),
+	KUNIT_CASE(kunit_resource_test_remove_action),
+	KUNIT_CASE(kunit_resource_test_release_action),
+	KUNIT_CASE(kunit_resource_test_action_ordering),
 	{}
 };
 
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
index c414df922f34..f0209252b179 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -77,3 +77,102 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kunit_destroy_resource);
+
+struct kunit_action_ctx {
+	struct kunit_resource res;
+	kunit_action_t *func;
+	void *ctx;
+};
+
+static void __kunit_action_free(struct kunit_resource *res)
+{
+	struct kunit_action_ctx *action_ctx = container_of(res, struct kunit_action_ctx, res);
+
+	action_ctx->func(action_ctx->ctx);
+}
+
+
+int kunit_add_action(struct kunit *test, void (*action)(void *), void *ctx)
+{
+	struct kunit_action_ctx *action_ctx;
+
+	KUNIT_ASSERT_NOT_NULL_MSG(test, action, "Tried to action a NULL function!");
+
+	action_ctx = kzalloc(sizeof(*action_ctx), GFP_KERNEL);
+	if (!action_ctx)
+		return -ENOMEM;
+
+	action_ctx->func = action;
+	action_ctx->ctx = ctx;
+
+	action_ctx->res.should_kfree = true;
+	/* As init is NULL, this cannot fail. */
+	__kunit_add_resource(test, NULL, __kunit_action_free, &action_ctx->res, action_ctx);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_add_action);
+
+int kunit_add_action_or_reset(struct kunit *test, void (*action)(void *),
+			      void *ctx)
+{
+	int res = kunit_add_action(test, action, ctx);
+
+	if (res)
+		action(ctx);
+	return res;
+}
+EXPORT_SYMBOL_GPL(kunit_add_action_or_reset);
+
+static bool __kunit_action_match(struct kunit *test,
+				struct kunit_resource *res, void *match_data)
+{
+	struct kunit_action_ctx *match_ctx = (struct kunit_action_ctx *)match_data;
+	struct kunit_action_ctx *res_ctx = container_of(res, struct kunit_action_ctx, res);
+
+	/* Make sure this is a free function. */
+	if (res->free != __kunit_action_free)
+		return false;
+
+	/* Both the function and context data should match. */
+	return (match_ctx->func == res_ctx->func) && (match_ctx->ctx == res_ctx->ctx);
+}
+
+void kunit_remove_action(struct kunit *test,
+			kunit_action_t *action,
+			void *ctx)
+{
+	struct kunit_action_ctx match_ctx;
+	struct kunit_resource *res;
+
+	match_ctx.func = action;
+	match_ctx.ctx = ctx;
+
+	res = kunit_find_resource(test, __kunit_action_match, &match_ctx);
+	if (res) {
+		/* Remove the free function so we don't run the action. */
+		res->free = NULL;
+		kunit_remove_resource(test, res);
+		kunit_put_resource(res);
+	}
+}
+EXPORT_SYMBOL_GPL(kunit_remove_action);
+
+void kunit_release_action(struct kunit *test,
+			 kunit_action_t *action,
+			 void *ctx)
+{
+	struct kunit_action_ctx match_ctx;
+	struct kunit_resource *res;
+
+	match_ctx.func = action;
+	match_ctx.ctx = ctx;
+
+	res = kunit_find_resource(test, __kunit_action_match, &match_ctx);
+	if (res) {
+		kunit_remove_resource(test, res);
+		/* We have to put() this here, else free won't be called. */
+		kunit_put_resource(res);
+	}
+}
+EXPORT_SYMBOL_GPL(kunit_release_action);
-- 
2.41.0.rc0.172.g3f132b7071-goog

