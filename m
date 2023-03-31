Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670C96D194C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCaIEc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCaIEb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:04:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B21B371
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v67-20020a254846000000b00b8189f73e94so837851yba.12
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680249868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5m1UzqN9dan9Fve/v01UII7j8R+V4PUOKPhCOFOqZlI=;
        b=YwdzYxAsk7Si/YO5GQUMvPrVDiG4J+fxLLPwbvHl57cxrSeecolFBi3d5osEAqyYPn
         7wivCX1t15lDPIQS3daejsY2Ry9IJwuUWQiaMY2AY4jfuf6m2RpaVoVF/ZmTQd7s4wbn
         QCChXbK5L94jmXnB8vb0WSYPWo0oCpiEJoNh8d/zMg4898jgpCMV/3891mGr5N8Xrs6M
         IiA3jjEsJpDF3rev0Gk2mqu/m8tKPy9uIZJ3lPzbHq0wwuWo5kDlKp9FNruZerMe2j4A
         LilM9v+8MYXQeyHkWymFm0IIKv9vdPj4IpXF33adYpPAly+0ATXumhEGSi3dOz0moqmc
         8Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680249868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5m1UzqN9dan9Fve/v01UII7j8R+V4PUOKPhCOFOqZlI=;
        b=F9AyuAi/61Ax1X2nvvxvJ8QwMvpjNcn2BE7+kODvmhmuj1mYx9PfmUdKSJt90/0E6P
         b8aFTU67O78RI8ps7FHV7ZijNNfmC9040LK9E9w/VuhrFQ41R2XFz6RLc3jds69wNo6c
         TfL75SnHjkYVFQkAF8CLpt5366PqHh6AVhMJyJIBVmQebvR+A9CgMKeUWcLBprQjCqnf
         KD8P3bFVT8xBcsEtvTXcpzk0XpdwESgZA3y9p/q+UNtWswKMqyMZXcAg4KSLkbsi2kT6
         dGxOUBlCeux2BnWz+58uJvoKKE7KvtBOaUlu8bY+ZmatkZpKUZnMXxNc7qf2ZQRmR7hU
         cwHA==
X-Gm-Message-State: AAQBX9dYLdOe2fFzw7wioJxud9INiszlPjUKFDi/KuFh8UUdYyNZApER
        0OEg9ZxVzjmXoPOtEsZe1JuLpXcMWu7cIA==
X-Google-Smtp-Source: AKy350aiUDc6/VjBElfTfy1aXKjmIdyKG1Wto7JKNEu1O8ztf3OVZ1kuZC2wE4tLE4Dd3YFXnJubYtoMgaQjmA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:48c4:0:b0:b26:884:c35e with SMTP id
 v187-20020a2548c4000000b00b260884c35emr4623486yba.4.1680249868180; Fri, 31
 Mar 2023 01:04:28 -0700 (PDT)
Date:   Fri, 31 Mar 2023 16:04:09 +0800
In-Reply-To: <20230331080411.981038-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331080411.981038-2-davidgow@google.com>
Subject: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since RFC v1:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow@google.com/
- Rename functions to better match the devm_* APIs. (Thanks Maxime)
- Embed the kunit_resource in struct kunit_action_ctx to avoid an extra
  allocation (Thanks Benjamin)
- Use 'struct kunit_action_ctx' as the type for cancellation tokens
  (Thanks Benjamin)
- Add tests.

---
 include/kunit/resource.h |  89 ++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c   | 123 ++++++++++++++++++++++++++++++++++++++-
 lib/kunit/resource.c     |  99 +++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+), 1 deletion(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index c0d88b318e90..15efd8924666 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
  */
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 
+typedef void (*kunit_defer_function_t)(void *ctx);
+
+/* An opaque token to a deferred action. */
+struct kunit_action_ctx;
+
+/**
+ * kunit_add_action() - Defer an 'action' (function call) until the test ends.
+ * @test: Test case to associate the action with.
+ * @func: The function to run on test exit
+ * @ctx: Data passed into @func
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ *
+ * Defer the execution of a function until the test exits, either normally or
+ * due to a failure.  @ctx is passed as additional context. All functions
+ * registered with kunit_add_action() will execute in the opposite order to that
+ * they were registered in.
+ *
+ * This is useful for cleaning up allocated memory and resources.
+ *
+ * Returns:
+ *   An opaque "cancellation token", or NULL on error. Pass this token to
+ *   kunit_remove_action_token() in order to cancel the deferred execution of
+ *   func().
+ */
+struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defer_function_t func,
+		      void *ctx, gfp_t internal_gfp);
+
+/**
+ * kunit_remove_action_token() - Cancel a deferred action.
+ * @test: Test case the action is associated with.
+ * @cancel_token: The cancellation token returned by kunit_add_action()
+ *
+ * Prevent an action deferred using kunit_add_action() from executing when the
+ * test ends.
+ *
+ * You can also use the (test, function, context) triplet to remove an action
+ * with kunit_remove_action().
+ */
+void kunit_remove_action_token(struct kunit *test, struct kunit_action_ctx *cancel_token);
+
+/**
+ * kunit_release_action_token() - Trigger a deferred action immediately.
+ * @test: Test case the action is associated with.
+ * @cancel_token: The cancellation token returned by kunit_add_action()
+ *
+ * Execute an action immediately, instead of waiting for the test to end.
+ *
+ * You can also use the (test, function, context) triplet to trigger an action
+ * with kunit_release_action().
+ */
+void kunit_release_action_token(struct kunit *test, struct kunit_action_ctx *cancel_token);
+
+/**
+ * kunit_remove_action() - Cancel a matching deferred action.
+ * @test: Test case the action is associated with.
+ * @func: The deferred function to cancel.
+ * @ctx: The context passed to the deferred function to trigger.
+ *
+ * Prevent an action deferred via kunit_add_action() from executing when the
+ * test terminates..
+ * Unlike kunit_remove_action_token(), this takes the (func, ctx) pair instead of
+ * the cancellation token. If that function/context pair was deferred multiple
+ * times, only the most recent one will be cancelled.
+ */
+void kunit_remove_action(struct kunit *test,
+			 kunit_defer_function_t func,
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
+ * Unlike kunit_release_action_token(), this takes the (func, ctx) pair instead of
+ * the cancellation token. If that function/context pair was deferred multiple
+ * times, it will only be executed once here. The most recent deferral will
+ * no longer execute when the test ends.
+ *
+ * kunit_release_action(test, func, ctx);
+ * is equivalent to
+ * func(ctx);
+ * kunit_remove_action(test, func, ctx);
+ */
+void kunit_release_action(struct kunit *test,
+			  kunit_defer_function_t func,
+			  void *ctx);
 #endif /* _KUNIT_RESOURCE_H */
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index b63595d3e241..eaca1b133922 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -111,7 +111,7 @@ struct kunit_test_resource_context {
 	struct kunit test;
 	bool is_resource_initialized;
 	int allocate_order[2];
-	int free_order[2];
+	int free_order[4];
 };
 
 static int fake_resource_init(struct kunit_resource *res, void *context)
@@ -402,6 +402,123 @@ static void kunit_resource_test_named(struct kunit *test)
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
+	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Once we've cleaned up, the action queue is empty. */
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Check the same function can be deferred multiple times. */
+	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 3);
+}
+static void kunit_resource_test_remove_action(struct kunit *test)
+{
+	int num_actions = 0;
+	struct kunit_action_ctx *cancel_token;
+	struct kunit_action_ctx *cancel_token2;
+
+	cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+
+	kunit_remove_action_token(test, cancel_token);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+
+	/* Check calls from the same function/context pair can be cancelled independently*/
+	cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	cancel_token2 = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	kunit_remove_action_token(test, cancel_token);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Also check that we can cancel just one of the identical function/context pairs. */
+	cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	cancel_token2 = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	kunit_remove_action(test, increment_int, &num_actions);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 2);
+}
+static void kunit_resource_test_release_action(struct kunit *test)
+{
+	int num_actions = 0;
+	struct kunit_action_ctx *cancel_token;
+	struct kunit_action_ctx *cancel_token2;
+
+	cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	KUNIT_EXPECT_EQ(test, num_actions, 0);
+	/* Runs immediately on trigger. */
+	kunit_release_action_token(test, cancel_token);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Doesn't run again on test exit. */
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 1);
+
+	/* Check calls from the same function/context pair can be triggered independently*/
+	cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	cancel_token2 = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	kunit_release_action_token(test, cancel_token);
+	KUNIT_EXPECT_EQ(test, num_actions, 2);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 3);
+
+	/* Also check that we can trigger just one of the identical function/context pairs. */
+	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
+	kunit_release_action(test, increment_int, &num_actions);
+	KUNIT_EXPECT_EQ(test, num_actions, 4);
+	kunit_cleanup(test);
+	KUNIT_EXPECT_EQ(test, num_actions, 5);
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
+	struct kunit_action_ctx *cancel_token;
+
+	kunit_add_action(test, action_order_1, ctx, GFP_KERNEL);
+	cancel_token = kunit_add_action(test, action_order_2, ctx, GFP_KERNEL);
+	kunit_add_action(test, action_order_1, ctx, GFP_KERNEL);
+	kunit_add_action(test, action_order_2, ctx, GFP_KERNEL);
+	kunit_remove_action(test, action_order_1, ctx);
+	kunit_release_action_token(test, cancel_token);
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
@@ -433,6 +550,10 @@ static struct kunit_case kunit_resource_test_cases[] = {
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
index c414df922f34..824cf91e306d 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -77,3 +77,102 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kunit_destroy_resource);
+
+struct kunit_action_ctx {
+	struct kunit_resource res;
+	kunit_defer_function_t func;
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
+struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defer_function_t func,
+					 void *ctx, gfp_t internal_gfp)
+{
+	struct kunit_action_ctx *action_ctx;
+
+	KUNIT_ASSERT_NOT_NULL_MSG(test, func, "Tried to action a NULL function!");
+
+	action_ctx = kzalloc(sizeof(*action_ctx), internal_gfp);
+	if (!action_ctx)
+		return NULL;
+
+	action_ctx->func = func;
+	action_ctx->ctx = ctx;
+
+	action_ctx->res.should_kfree = true;
+	/* As init is NULL, this cannot fail. */
+	__kunit_add_resource(test, NULL, __kunit_action_free, &action_ctx->res, action_ctx);
+
+	return action_ctx;
+}
+
+void kunit_remove_action_token(struct kunit *test, struct kunit_action_ctx *cancel_token)
+{
+	/* Remove the free function so we don't run the action. */
+	cancel_token->res.free = NULL;
+
+	kunit_remove_resource(test, &cancel_token->res);
+}
+
+void kunit_release_action_token(struct kunit *test, struct kunit_action_ctx *cancel_token)
+{
+	/* Removing the resource should trigger the res->free function. */
+	kunit_remove_resource(test, &cancel_token->res);
+}
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
+			kunit_defer_function_t func,
+			void *ctx)
+{
+	struct kunit_action_ctx match_ctx, *action_ctx;
+	struct kunit_resource *res;
+
+	match_ctx.func = func;
+	match_ctx.ctx = ctx;
+
+	res = kunit_find_resource(test, __kunit_action_match, &match_ctx);
+	if (res) {
+		action_ctx = container_of(res, struct kunit_action_ctx, res);
+		kunit_remove_action_token(test, action_ctx);
+		kunit_put_resource(res);
+	}
+}
+
+void kunit_release_action(struct kunit *test,
+			 kunit_defer_function_t func,
+			 void *ctx)
+{
+	struct kunit_action_ctx match_ctx, *action_ctx;
+	struct kunit_resource *res;
+
+	match_ctx.func = func;
+	match_ctx.ctx = ctx;
+
+	res = kunit_find_resource(test, __kunit_action_match, &match_ctx);
+	if (res) {
+		action_ctx = container_of(res, struct kunit_action_ctx, res);
+		kunit_release_action_token(test, action_ctx);
+		/* We have to put() this here, else free won't be called. */
+		kunit_put_resource(res);
+	}
+}
-- 
2.40.0.348.gf938b09366-goog

