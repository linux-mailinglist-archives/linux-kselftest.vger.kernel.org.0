Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717496C8ADD
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 05:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjCYEbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 00:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjCYEb0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 00:31:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F21A976
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 21:31:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so3632520yba.11
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679718680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvsBLzafDFRdEeFlhtCKfSPH7Z58gGOcQ/NMYd5XVas=;
        b=Dkx+4oPW0lddcPp4uMCQo6pmYmmbn0VU/J6ph6FIZMvJHQ04WSJmMD7xcIcZLJ6PdN
         mzLHDd4+oVvLMi1Zcdmmen6ZKzyf+g1GWgtWOeOuWYuo4GIJOr/0XBgAc273lDPvOxyn
         x/DczHXGxTwgZwYMHRELVpV4Toxy+2KxrL1CRJni3/TMk9xGSF+B6Ixg0Qh2jk842ljw
         rlDf4yUosLnhwdKudLfaiffDtlBTk7P4a9n3NnW6nlLUy3fEX7Q/qxKKYau9bO29v/Ww
         aJhM3eN9NL0dDmMVQAe0W1p9zzom/gVxfE5CItxvv4NN8JpOss79ZwU5ox4G1jGQ9ykB
         S25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvsBLzafDFRdEeFlhtCKfSPH7Z58gGOcQ/NMYd5XVas=;
        b=zHFdnk+WtFlEC5d3+zv66h3UVAOthJUi/f3XTBLKSKQWvevJthqIm7nnyh4W3jMvb3
         KB63iFLABT5t1TLbwm5EGkMwHZYpYDkYcaxnu+4ibwNKZtOzgJmBdkijUHmclNu4b87z
         foZn3gj8eWo8VzPF6kjKnQco3zCVdm++6oFDwvC57StfFfjS22+Z2quaFLmrJKTn05KU
         F8jHQn8wf/OP68X1wWx8fNbU/R9C7ljn2uoa3agpcXP1r3wvDC408Rom+GJC6UeFgKsc
         HWo9YXY/d2eZb+T1EC6qO2PfB4rwpUJcnJaUFlA3Xo6rXGq/L6pg3wzuppNErf1yUwPw
         p+Nw==
X-Gm-Message-State: AAQBX9dE8uieamv96sOW51cAdFnr8bwhIMs2/PvV1LGla3kn9x/LLjY8
        nFlLjman91RBbWRFI6o9BoY3Zq2QwsVv/A==
X-Google-Smtp-Source: AKy350aAmbbgvFfbZgCOgJD0jK2dcqvaJW7t4SFAmuugOJrv8Crpejpj64U5SmpXoebmhM46ApGf7S32uVGC0Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:ac64:0:b0:544:b9b2:5c32 with SMTP id
 z36-20020a81ac64000000b00544b9b25c32mr2114854ywj.7.1679718679808; Fri, 24 Mar
 2023 21:31:19 -0700 (PDT)
Date:   Sat, 25 Mar 2023 12:31:03 +0800
In-Reply-To: <20230325043104.3761770-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230325043104.3761770-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230325043104.3761770-2-davidgow@google.com>
Subject: [RFC PATCH 1/2] kunit: resource: Add kunit_defer() functionality
From:   David Gow <davidgow@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

Instead, introduce a simple kunit_defer() API: a simple function
(returning nothing, accepting a single void* argument) can be scheduled
to be called when the test exits. Deferred functions are called in the
opposite order to that which they were registered.

This is implemented as a resource under the hood, so the ordering
between resource cleanup and deferred functions is maintained.

Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/resource.h |  87 +++++++++++++++++++++++++++++++
 lib/kunit/resource.c     | 110 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index cf6fb8f2ac1b..6c4728ca9237 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -387,4 +387,91 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
  */
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 
+typedef void (*kunit_defer_function_t)(void *ctx);
+
+/**
+ * kunit_defer() - Defer a function call until the test ends.
+ * @test: Test case to associate the deferred function with.
+ * @func: The function to run on test exit
+ * @ctx: Data passed into @func
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ *
+ * Defer the execution of a function until the test exits, either normally or
+ * due to a failure.  @ctx is passed as additional context. All functions
+ * registered with kunit_defer() will execute in the opposite order to that
+ * they were registered in.
+ *
+ * This is useful for cleaning up allocated memory and resources.
+ *
+ * RETURNS:
+ *   An opaque "cancellation token", or NULL on error. Pass this token to
+ *   kunit_defer_cancel() in order to cancel the deferred execution of func().
+ */
+void *kunit_defer(struct kunit *test, kunit_defer_function_t func,
+		  void *ctx, gfp_t internal_gfp);
+
+/**
+ * kunit_defer_cancel_token() - Cancel a deferred function call.
+ * @test: Test case the deferred function is associated with.
+ * @cancel_token: The cancellation token returned by kunit_defer()
+ *
+ * Prevent a function deferred using kunit_defer() from executing when the
+ * test ends.
+ *
+ * Prefer using this to kunit_defer_cancel() where possible.
+ */
+void kunit_defer_cancel_token(struct kunit *test, void *cancel_token);
+
+/**
+ * kunit_defer_trigger_token() - Run a deferred function call immediately.
+ * @test: Test case the deferred function is associated with.
+ * @cancel_token: The cancellation token returned by kunit_defer()
+ *
+ * Execute a deferred function call immediately, instead of waiting for the
+ * test to end.
+ *
+ * Prefer using this to kunit_defer_trigger() where possible.
+ */
+void kunit_defer_trigger_token(struct kunit *test, void *cancel_token);
+
+/**
+ * kunit_defer_cancel() - Cancel a matching deferred function call.
+ * @test: Test case the deferred function is associated with.
+ * @func: The deferred function to cancel.
+ * @ctx: The context passed to the deferred function to trigger.
+ *
+ * Prevent a function deferred via kunit_defer() from executing at shutdown.
+ * Unlike kunit_defer_cancel_token(), this takes the (func, ctx) pair instead of
+ * the cancellation token. If that function/context pair was deferred multiple
+ * times, only the most recent one will be cancelled.
+ *
+ * Prefer using kunit_defer_cancel_token() to this where possible.
+ */
+void kunit_defer_cancel(struct kunit *test,
+			kunit_defer_function_t func,
+			void *ctx);
+
+/**
+ * kunit_defer_trigger() - Run a matching deferred function call immediately.
+ * @test: Test case the deferred function is associated with.
+ * @func: The deferred function to trigger.
+ * @ctx: The context passed to the deferred function to trigger.
+ *
+ * Execute a function deferred via kunit_defer() immediately, rather than when
+ * the test ends.
+ * Unlike kunit_defer_trigger_token(), this takes the (func, ctx) pair instead of
+ * the cancellation token. If that function/context pair was deferred multiple
+ * times, it will only be executed once here. The most recent deferral will
+ * no longer execute when the test ends.
+ *
+ * kunit_defer_trigger(test, func, ctx);
+ * is equivalent to
+ * func(ctx);
+ * kunit_defer_cancel(test, func, ctx);
+ *
+ * Prefer using kunit_defer_trigger_token() to this where possible.
+ */
+void kunit_defer_trigger(struct kunit *test,
+			 kunit_defer_function_t func,
+			 void *ctx);
 #endif /* _KUNIT_RESOURCE_H */
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
index c414df922f34..0d0c48054d45 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -77,3 +77,113 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kunit_destroy_resource);
+
+struct kunit_defer_ctx {
+	kunit_defer_function_t func;
+	void *ctx;
+};
+
+static void __kunit_defer_free(struct kunit_resource *res)
+{
+	struct kunit_defer_ctx *defer_ctx = (struct kunit_defer_ctx *)res->data;
+
+	defer_ctx->func(defer_ctx->ctx);
+
+	kfree(res->data);
+}
+
+void *kunit_defer(struct kunit *test, kunit_defer_function_t func,
+				void *ctx, gfp_t internal_gfp)
+{
+	struct kunit_resource *res;
+	struct kunit_defer_ctx *defer_ctx;
+
+	KUNIT_ASSERT_NOT_NULL_MSG(test, func, "Tried to defer a NULL function!");
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	defer_ctx = kzalloc(sizeof(*defer_ctx), internal_gfp);
+	if (!defer_ctx)
+		goto free_res;
+
+	defer_ctx->func = func;
+	defer_ctx->ctx = ctx;
+
+	res->should_kfree = true;
+	__kunit_add_resource(test, NULL, __kunit_defer_free, res, defer_ctx);
+
+	return (void *)res;
+
+free_res:
+	kfree(res);
+	return NULL;
+}
+
+void kunit_defer_cancel_token(struct kunit *test, void *cancel_token)
+{
+	struct kunit_resource *res = (struct kunit_resource *)cancel_token;
+
+	/* Remove the free function so we don't run the deferred function. */
+	res->free = NULL;
+
+	kunit_remove_resource(test, res);
+}
+
+void kunit_defer_trigger_token(struct kunit *test, void *cancel_token)
+{
+	struct kunit_resource *res = (struct kunit_resource *)cancel_token;
+
+	/* Removing the resource should trigger the res->free function. */
+	kunit_remove_resource(test, res);
+}
+
+static bool __kunit_defer_match(struct kunit *test,
+				struct kunit_resource *res, void *match_data)
+{
+	struct kunit_defer_ctx *match_ctx = (struct kunit_defer_ctx *)match_data;
+	struct kunit_defer_ctx *res_ctx = (struct kunit_defer_ctx *)res->data;
+
+	/* Make sure this is a free function. */
+	if (res->free != __kunit_defer_free)
+		return false;
+
+	/* Both the function and context data should match. */
+	return (match_ctx->func == res_ctx->func) && (match_ctx->ctx == res_ctx->ctx);
+}
+
+void kunit_defer_cancel(struct kunit *test,
+			kunit_defer_function_t func,
+			void *ctx)
+{
+	struct kunit_defer_ctx defer_ctx;
+	struct kunit_resource *res;
+
+	defer_ctx.func = func;
+	defer_ctx.ctx = ctx;
+
+	res = kunit_find_resource(test, __kunit_defer_match, &defer_ctx);
+	if (res) {
+		kunit_defer_cancel_token(test, res);
+		kunit_put_resource(res);
+	}
+}
+
+void kunit_defer_trigger(struct kunit *test,
+			 kunit_defer_function_t func,
+			 void *ctx)
+{
+	struct kunit_defer_ctx defer_ctx;
+	struct kunit_resource *res;
+
+	defer_ctx.func = func;
+	defer_ctx.ctx = ctx;
+
+	res = kunit_find_resource(test, __kunit_defer_match, &defer_ctx);
+	if (res) {
+		kunit_defer_trigger_token(test, res);
+		/* We have to put() this here, else free won't be called. */
+		kunit_put_resource(res);
+	}
+}
-- 
2.40.0.348.gf938b09366-goog

