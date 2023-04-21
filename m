Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75446EA616
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 10:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjDUIms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjDUImp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 04:42:45 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69893E4
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a5233699b6so21564875ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682066558; x=1684658558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSu0ZR453Rbs9YQWMYaLMaSYooduUs1pAmSEpyOKMcM=;
        b=C2jKpxn91b/a7wxP4k66C1ZNh5FHjgBnX8MRRKc/d/zoq/Z6Ax2iZvQK/7Yb7kfj5e
         JwHt8yNLl7sxHyi/8IteTfPf8ry40U8uFz/yubuVtbXVD0+fhzpEX3oqrUviAYbaMM9h
         AgVlkpu0GPyrA9bazff0xsb6uV/Bwgq/RBAc6I8fZlSZXvqVS/+sCQeU/Xt/+sUMrzc0
         Ysr2SCeAa0Ie+yKf9YelXdbYprDHV/wFvOD2U2K1GOJyxlqF5q5m94eV+vlvj+Ckssv8
         0oPZuwiutUlaplqhglhMTIKACUkYU7brgCzcCU5IKLs/NTov+VTMDTe/nm9uv7+p4DQe
         Jn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066558; x=1684658558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSu0ZR453Rbs9YQWMYaLMaSYooduUs1pAmSEpyOKMcM=;
        b=hbL0mpwvx9nJPhO8nxzJ2joztCRyTPLwVtr7ellN97Q7L1sMiLhrfiaQIgZLryaUSc
         zoIlovT+NuRVk0IlrcJj1K9le5Z0Zc+8d7flfwDynYhJWMXQp7Cg8A+5vxR4ExepKzRi
         +4OuwdS+vxI+zySKznuu4yXjAW8Kms+Grf//txDTSZRuuWupv9M5cHtwsUwDqj01ye0N
         U2ZtdK/pBybBbfOIWsUtYyCdPvxjD0H4IejWr/Xx5MLFA6l7+j9OOPsUPK83y93ziS2l
         rF0Zjoo1aOThcRTFT5Fspcqs4HHW8Xozt7UOUCZFGYkQgBNAPOiu2kGijWmxJQca/cGe
         fgBQ==
X-Gm-Message-State: AAQBX9c0aJDkpU9gNkiTKOfDRW7+OdwsI6cYhujUZjnKB0G5NNqYuORY
        HTeVxZuZY+DfJTe71xpKqQy0T3fO32hS5w==
X-Google-Smtp-Source: AKy350bxsVJ6UPXu4OLLqgZ+tzMIjr75bj9Qs7vDvkDDyZt+3FlV4zqo4HJEJBtn0KnqSuuMlnPsCb80v9jVxw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:708c:b0:1a5:8a2:5062 with SMTP id
 z12-20020a170902708c00b001a508a25062mr1569902plk.12.1682066558467; Fri, 21
 Apr 2023 01:42:38 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:42:24 +0800
In-Reply-To: <20230421084226.2278282-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230421084226.2278282-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421084226.2278282-2-davidgow@google.com>
Subject: [PATCH v1 1/3] kunit: Add kunit_add_action() to defer a call until
 test exit
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

Signed-off-by: David Gow <davidgow@google.com>
---

Note: there is a checkpatch warning:
"function definition argument 'void *' should also have an identifier name"

I think this is a false-positive, as we're defining a function pointer
struct member, not a specific function.

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

 include/kunit/resource.h | 76 ++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c   | 88 ++++++++++++++++++++++++++++++++++++-
 lib/kunit/resource.c     | 95 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+), 1 deletion(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index c0d88b318e90..6db28cd43e9b 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -387,4 +387,80 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
  */
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 
+
+/**
+ * kunit_add_action() - Defer an 'action' (function call) until the test ends.
+ * @test: Test case to associate the action with.
+ * @func: The function to run on test exit
+ * @ctx: Data passed into @func
+ *
+ * Defer the execution of a function until the test exits, either normally or
+ * due to a failure.  @ctx is passed as additional context. All functions
+ * registered with kunit_add_action() will execute in the opposite order to that
+ * they were registered in.
+ *
+ * This is useful for cleaning up allocated memory and resources.
+ *
+ * Returns:
+ *   0 on success, an error if the action could not be deferred.
+ */
+int kunit_add_action(struct kunit *test, void (*action) (void *), void *ctx);
+
+/**
+ * kunit_add_action_or_reset() - Defer an 'action' (function call) until the test ends.
+ * @test: Test case to associate the action with.
+ * @func: The function to run on test exit
+ * @ctx: Data passed into @func
+ *
+ * Defer the execution of a function until the test exits, either normally or
+ * due to a failure.  @ctx is passed as additional context. All functions
+ * registered with kunit_add_action() will execute in the opposite order to that
+ * they were registered in.
+ *
+ * This is useful for cleaning up allocated memory and resources.
+ *
+ * If the action cannot be created (e.g., due to the system being out of memory),
+ * then action(ctx) will be called immediately, and an error will be returned.
+ *
+ * Returns:
+ *   0 on success, an error if the action could not be deferred.
+ */
+int kunit_add_action_or_reset(struct kunit *test, void (*action)(void *),
+			      void *ctx);
+
+/**
+ * kunit_remove_action() - Cancel a matching deferred action.
+ * @test: Test case the action is associated with.
+ * @func: The deferred function to cancel.
+ * @ctx: The context passed to the deferred function to trigger.
+ *
+ * Prevent an action deferred via kunit_add_action() from executing when the
+ * test terminates..
+ * If the function/context pair was deferred multiple times, only the most
+ * recent one will be cancelled.
+ */
+void kunit_remove_action(struct kunit *test,
+			 void (*action)(void *),
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
+ * If the function/context pair was deferred multiple times, it will only be
+ * executed once here. The most recent deferral will no longer execute when
+ * the test ends.
+ *
+ * kunit_release_action(test, func, ctx);
+ * is equivalent to
+ * func(ctx);
+ * kunit_remove_action(test, func, ctx);
+ */
+void kunit_release_action(struct kunit *test,
+			  void (*action)(void *),
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
index c414df922f34..20b08b9341c9 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -77,3 +77,98 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kunit_destroy_resource);
+
+struct kunit_action_ctx {
+	struct kunit_resource res;
+	void (*func)(void *);
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
+			void (*action)(void *),
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
+
+void kunit_release_action(struct kunit *test,
+			 void (*action)(void *),
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
-- 
2.40.0.634.g4ca3ef3211-goog

