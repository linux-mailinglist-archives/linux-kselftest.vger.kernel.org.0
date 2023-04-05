Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC56D75CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 09:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDEHsN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 03:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDEHsL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 03:48:11 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722730E2
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 00:48:09 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id h34so24997365uag.4
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 00:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680680888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UiE6uTcWLxP5L6FOtMfR9QYnBc5+5v469wlPF5gRWYA=;
        b=ThIwAP0Qgniw1bi9q5rubcDtg6fxMHDVlu5vuO9mVjoaSgANyQ0/ahWVSX5Vd8lYku
         tMWUXNqImc44mydznAWPvZt2FA4yKtikQEdU9AlqQB4PnED+NsGB44QBhzMZpPHW4vNk
         43dPHDnKK1Y9xuJS1EzRkJDKP9jQ7AxhlJJZIbY3Q3J25+U6e34jrxf/zP0cHrCWgiIH
         F8dNH7IfqtryPMTKfv0qUzvSKOHheUncQkHDkjWaaukAhFwimPIL0VoELguMPPskIaJ+
         IBGCBLgEbdamVjR0wFgWkIGC9PcV8xM3IRuCrAxRJu7dSpjSKxI9qhJeU5RLVyzTUOJJ
         irZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680680888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiE6uTcWLxP5L6FOtMfR9QYnBc5+5v469wlPF5gRWYA=;
        b=hCTYBSIQ4s8kdriE30LYqjqnLQ1qiAGue11n/PeI0DdFbPyWAXgEHrqpuF75edRZJ7
         m4KOQBXKKvA16FeyGqFE8hvgcVdCmw4kz8U5RMwfteaZxLTP9tsjzWlZ7bv6GR98hVId
         BDnbuc76gE5w/6G6f2N2Q52ghZCFq1zEJBKBmOZ7PQnh0qVFj/prBlqBVEIWouCCuXBW
         TlqOvct+l+rgQZLzrLHgw8OTOxgLBFp0fL5I1vbctXvr+YP+x2knzMZAjH9qCBVlkcPI
         8AZ3xGh9Qky/mJi3wLidYhB6IESplriHNnAj034mMkkVGwLKPpwPwvJrnoUxnR+HgVCj
         /YtQ==
X-Gm-Message-State: AAQBX9daPomuRtuL+D3NCPsCEpldTpl3hiqWIWmxqduB45JaB3rmEzkh
        M1ENZhRIZrkiy4Byw8cYbmA2cZzHGbSgNbUQoFJVKg==
X-Google-Smtp-Source: AKy350Y+VJZpz3yo4slqQL/Ptp8BZLJ3SyjFNWG186gYvoU1c4yJ/xEMXMbmPWO8IBBjoF4nQnVQK36DPuAPw63JXl8=
X-Received: by 2002:a1f:a7c4:0:b0:40e:fee9:667a with SMTP id
 q187-20020a1fa7c4000000b0040efee9667amr4075028vke.3.1680680888141; Wed, 05
 Apr 2023 00:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com> <20230331080411.981038-2-davidgow@google.com>
 <20230404133231.ingzo7xy7lejpqqb@houat>
In-Reply-To: <20230404133231.ingzo7xy7lejpqqb@houat>
From:   David Gow <davidgow@google.com>
Date:   Wed, 5 Apr 2023 15:47:55 +0800
Message-ID: <CABVgOS=SM0NaS4aUTfv06jFWcD4K2k-dU297ssdfT0gZHQnfoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000058eb7305f8920372"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000058eb7305f8920372
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Apr 2023 at 21:32, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi David,
>
> Looks great, thanks for sending a second version
>
> On Fri, Mar 31, 2023 at 04:04:09PM +0800, David Gow wrote:
> > Many uses of the KUnit resource system are intended to simply defer
> > calling a function until the test exits (be it due to success or
> > failure). The existing kunit_alloc_resource() function is often used for
> > this, but was awkward to use (requiring passing NULL init functions, etc),
> > and returned a resource without incrementing its reference count, which
> > -- while okay for this use-case -- could cause problems in others.
> >
> > Instead, introduce a simple kunit_add_action() API: a simple function
> > (returning nothing, accepting a single void* argument) can be scheduled
> > to be called when the test exits. Deferred actions are called in the
> > opposite order to that which they were registered.
> >
> > This mimics the devres API, devm_add_action(), and also provides
> > kunit_remove_action(), to cancel a deferred action, and
> > kunit_release_action() to trigger one early.
> >
> > This is implemented as a resource under the hood, so the ordering
> > between resource cleanup and deferred functions is maintained.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Changes since RFC v1:
> > https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow@google.com/
> > - Rename functions to better match the devm_* APIs. (Thanks Maxime)
> > - Embed the kunit_resource in struct kunit_action_ctx to avoid an extra
> >   allocation (Thanks Benjamin)
> > - Use 'struct kunit_action_ctx' as the type for cancellation tokens
> >   (Thanks Benjamin)
> > - Add tests.
> >
> > ---
> >  include/kunit/resource.h |  89 ++++++++++++++++++++++++++++
> >  lib/kunit/kunit-test.c   | 123 ++++++++++++++++++++++++++++++++++++++-
> >  lib/kunit/resource.c     |  99 +++++++++++++++++++++++++++++++
> >  3 files changed, 310 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> > index c0d88b318e90..15efd8924666 100644
> > --- a/include/kunit/resource.h
> > +++ b/include/kunit/resource.h
> > @@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
> >   */
> >  void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
> >
> > +typedef void (*kunit_defer_function_t)(void *ctx);
> > +
> > +/* An opaque token to a deferred action. */
> > +struct kunit_action_ctx;
> > +
> > +/**
> > + * kunit_add_action() - Defer an 'action' (function call) until the test ends.
> > + * @test: Test case to associate the action with.
> > + * @func: The function to run on test exit
> > + * @ctx: Data passed into @func
> > + * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
> > + *
> > + * Defer the execution of a function until the test exits, either normally or
> > + * due to a failure.  @ctx is passed as additional context. All functions
> > + * registered with kunit_add_action() will execute in the opposite order to that
> > + * they were registered in.
> > + *
> > + * This is useful for cleaning up allocated memory and resources.
> > + *
> > + * Returns:
> > + *   An opaque "cancellation token", or NULL on error. Pass this token to
> > + *   kunit_remove_action_token() in order to cancel the deferred execution of
> > + *   func().
> > + */
> > +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defer_function_t func,
> > +                   void *ctx, gfp_t internal_gfp);
>
> Do we expect any other context than GFP_KERNEL?
>
> If so, then maybe we can have kunit_add_action() assume GFP_KERNEL and
> add a variant for the odd case where we would actually need a different
> GFP flag.
>

That'd be fine. The only cases which don't directly pass GFP_KERNEL in
are in the kunit_kmalloc() functions, which themselves accept a gfp to
pass down to kmalloc(). We didn't want to add an extra GFP_KERNEL
allocation there.

This definitely could be relegated to a separate variant of the
function, though (or we could keep using the old implementation of
kunit_kmalloc_array() which creates resources manually). Trying to
match the devm_add_action() API, which assumed GFP_KERNEL probably
makes sense...

> > +/**
> > + * kunit_remove_action_token() - Cancel a deferred action.
> > + * @test: Test case the action is associated with.
> > + * @cancel_token: The cancellation token returned by kunit_add_action()
> > + *
> > + * Prevent an action deferred using kunit_add_action() from executing when the
> > + * test ends.
> > + *
> > + * You can also use the (test, function, context) triplet to remove an action
> > + * with kunit_remove_action().
> > + */
> > +void kunit_remove_action_token(struct kunit *test, struct kunit_action_ctx *cancel_token);
>
> It's not clear to me why we still need the token. If
> kunit_remove_action() works fine, why would we need to store the token?
>
> Can't we just make kunit_add_action() return an int to indicate whether
> it failed or not, and that's it?
>

So the distinction here is that the (function, context) pair doesn't
uniquely identify an action, as you can add the same action multiple
times, with other actions interleaved. A token encodes _which_ of
these actions is being triggered/cancelled: the non-token variants
always cancel the most recent matching function. Without the token,
there's no way of removing an action "further down the stack".

Take, for example, two functions, add_one() and double(), which are
(*ctx)++ and (*ctx) *= 2, respectively.
int var = 0;
tok1 = kunit_add_action(test, add_one, &var);
kunit_add_action(test, double, &var);
tok3 = kunit_add_action(test, add_one, &var);

// The call:
kunit_remove_action(test, add_one, &var);
// is equivalent to
kunit_remove_action_token(test, tok3);
// and gives var = 1 as a final result

// If instead we want to remove the first add_one, we use:
kunit_remove_action_token(test, tok1);
// which cannot be done using kunit_remove_action()
// gives var = 2 instead.


There's also a (minor) performance benefit to using the token
versions, as we don't need to do a (currently O(n)) search through the
list of KUnit resources to find the matching entry. I doubt too many
tests will defer enough to make this a problem.


That being said, given no-one actually needs this behaviour yet, it's
definitely something we could add later if it becomes necessary. I
doubt it'd be useful for most of the normal resource management
use-cases.

> > +/**
> > + * kunit_release_action_token() - Trigger a deferred action immediately.
> > + * @test: Test case the action is associated with.
> > + * @cancel_token: The cancellation token returned by kunit_add_action()
> > + *
> > + * Execute an action immediately, instead of waiting for the test to end.
> > + *
> > + * You can also use the (test, function, context) triplet to trigger an action
> > + * with kunit_release_action().
> > + */
> > +void kunit_release_action_token(struct kunit *test, struct kunit_action_ctx *cancel_token);
> > +
> > +/**
> > + * kunit_remove_action() - Cancel a matching deferred action.
> > + * @test: Test case the action is associated with.
> > + * @func: The deferred function to cancel.
> > + * @ctx: The context passed to the deferred function to trigger.
> > + *
> > + * Prevent an action deferred via kunit_add_action() from executing when the
> > + * test terminates..
> > + * Unlike kunit_remove_action_token(), this takes the (func, ctx) pair instead of
> > + * the cancellation token. If that function/context pair was deferred multiple
> > + * times, only the most recent one will be cancelled.
> > + */
> > +void kunit_remove_action(struct kunit *test,
> > +                      kunit_defer_function_t func,
> > +                      void *ctx);
> > +
> > +/**
> > + * kunit_release_action() - Run a matching action call immediately.
> > + * @test: Test case the action is associated with.
> > + * @func: The deferred function to trigger.
> > + * @ctx: The context passed to the deferred function to trigger.
> > + *
> > + * Execute a function deferred via kunit_add_action()) immediately, rather than
> > + * when the test ends.
> > + * Unlike kunit_release_action_token(), this takes the (func, ctx) pair instead of
> > + * the cancellation token. If that function/context pair was deferred multiple
> > + * times, it will only be executed once here. The most recent deferral will
> > + * no longer execute when the test ends.
> > + *
> > + * kunit_release_action(test, func, ctx);
> > + * is equivalent to
> > + * func(ctx);
> > + * kunit_remove_action(test, func, ctx);
> > + */
> > +void kunit_release_action(struct kunit *test,
> > +                       kunit_defer_function_t func,
> > +                       void *ctx);
> >  #endif /* _KUNIT_RESOURCE_H */
> > diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> > index b63595d3e241..eaca1b133922 100644
> > --- a/lib/kunit/kunit-test.c
> > +++ b/lib/kunit/kunit-test.c
> > @@ -111,7 +111,7 @@ struct kunit_test_resource_context {
> >       struct kunit test;
> >       bool is_resource_initialized;
> >       int allocate_order[2];
> > -     int free_order[2];
> > +     int free_order[4];
> >  };
> >
> >  static int fake_resource_init(struct kunit_resource *res, void *context)
> > @@ -402,6 +402,123 @@ static void kunit_resource_test_named(struct kunit *test)
> >       KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
> >  }
> >
> > +static void increment_int(void *ctx)
> > +{
> > +     int *i = (int *)ctx;
> > +     (*i)++;
> > +}
> > +
> > +static void kunit_resource_test_action(struct kunit *test)
> > +{
> > +     int num_actions = 0;
> > +
> > +     kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 0);
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 1);
> > +
> > +     /* Once we've cleaned up, the action queue is empty. */
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 1);
> > +
> > +     /* Check the same function can be deferred multiple times. */
> > +     kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 3);
> > +}
> > +static void kunit_resource_test_remove_action(struct kunit *test)
> > +{
> > +     int num_actions = 0;
> > +     struct kunit_action_ctx *cancel_token;
> > +     struct kunit_action_ctx *cancel_token2;
> > +
> > +     cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 0);
> > +
> > +     kunit_remove_action_token(test, cancel_token);
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 0);
> > +
> > +     /* Check calls from the same function/context pair can be cancelled independently*/
> > +     cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     cancel_token2 = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     kunit_remove_action_token(test, cancel_token);
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 1);
> > +
> > +     /* Also check that we can cancel just one of the identical function/context pairs. */
> > +     cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     cancel_token2 = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     kunit_remove_action(test, increment_int, &num_actions);
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 2);
> > +}
> > +static void kunit_resource_test_release_action(struct kunit *test)
> > +{
> > +     int num_actions = 0;
> > +     struct kunit_action_ctx *cancel_token;
> > +     struct kunit_action_ctx *cancel_token2;
> > +
> > +     cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 0);
> > +     /* Runs immediately on trigger. */
> > +     kunit_release_action_token(test, cancel_token);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 1);
> > +
> > +     /* Doesn't run again on test exit. */
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 1);
> > +
> > +     /* Check calls from the same function/context pair can be triggered independently*/
> > +     cancel_token = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     cancel_token2 = kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     kunit_release_action_token(test, cancel_token);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 2);
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 3);
> > +
> > +     /* Also check that we can trigger just one of the identical function/context pairs. */
> > +     kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> > +     kunit_release_action(test, increment_int, &num_actions);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 4);
> > +     kunit_cleanup(test);
> > +     KUNIT_EXPECT_EQ(test, num_actions, 5);
> > +}
> > +static void action_order_1(void *ctx)
> > +{
> > +     struct kunit_test_resource_context *res_ctx = (struct kunit_test_resource_context *)ctx;
> > +
> > +     KUNIT_RESOURCE_TEST_MARK_ORDER(res_ctx, free_order, 1);
> > +     kunit_log(KERN_INFO, current->kunit_test, "action_order_1");
> > +}
> > +static void action_order_2(void *ctx)
> > +{
> > +     struct kunit_test_resource_context *res_ctx = (struct kunit_test_resource_context *)ctx;
> > +
> > +     KUNIT_RESOURCE_TEST_MARK_ORDER(res_ctx, free_order, 2);
> > +     kunit_log(KERN_INFO, current->kunit_test, "action_order_2");
> > +}
> > +static void kunit_resource_test_action_ordering(struct kunit *test)
> > +{
> > +     struct kunit_test_resource_context *ctx = test->priv;
> > +     struct kunit_action_ctx *cancel_token;
> > +
> > +     kunit_add_action(test, action_order_1, ctx, GFP_KERNEL);
> > +     cancel_token = kunit_add_action(test, action_order_2, ctx, GFP_KERNEL);
> > +     kunit_add_action(test, action_order_1, ctx, GFP_KERNEL);
> > +     kunit_add_action(test, action_order_2, ctx, GFP_KERNEL);
> > +     kunit_remove_action(test, action_order_1, ctx);
> > +     kunit_release_action_token(test, cancel_token);
> > +     kunit_cleanup(test);
> > +
> > +     /* [2 is triggered] [2], [(1 is cancelled)] [1] */
> > +     KUNIT_EXPECT_EQ(test, ctx->free_order[0], 2);
> > +     KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
> > +     KUNIT_EXPECT_EQ(test, ctx->free_order[2], 1);
> > +}
> > +
> >  static int kunit_resource_test_init(struct kunit *test)
> >  {
> >       struct kunit_test_resource_context *ctx =
> > @@ -433,6 +550,10 @@ static struct kunit_case kunit_resource_test_cases[] = {
> >       KUNIT_CASE(kunit_resource_test_proper_free_ordering),
> >       KUNIT_CASE(kunit_resource_test_static),
> >       KUNIT_CASE(kunit_resource_test_named),
> > +     KUNIT_CASE(kunit_resource_test_action),
> > +     KUNIT_CASE(kunit_resource_test_remove_action),
> > +     KUNIT_CASE(kunit_resource_test_release_action),
> > +     KUNIT_CASE(kunit_resource_test_action_ordering),
> >       {}
> >  };
> >
> > diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
> > index c414df922f34..824cf91e306d 100644
> > --- a/lib/kunit/resource.c
> > +++ b/lib/kunit/resource.c
> > @@ -77,3 +77,102 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_destroy_resource);
> > +
> > +struct kunit_action_ctx {
> > +     struct kunit_resource res;
> > +     kunit_defer_function_t func;
> > +     void *ctx;
> > +};
> > +
> > +static void __kunit_action_free(struct kunit_resource *res)
> > +{
> > +     struct kunit_action_ctx *action_ctx = container_of(res, struct kunit_action_ctx, res);
> > +
> > +     action_ctx->func(action_ctx->ctx);
> > +}
> > +
> > +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defer_function_t func,
> > +                                      void *ctx, gfp_t internal_gfp)
> > +{
> > +     struct kunit_action_ctx *action_ctx;
> > +
> > +     KUNIT_ASSERT_NOT_NULL_MSG(test, func, "Tried to action a NULL function!");
> > +
> > +     action_ctx = kzalloc(sizeof(*action_ctx), internal_gfp);
> > +     if (!action_ctx)
> > +             return NULL;
> > +
> > +     action_ctx->func = func;
> > +     action_ctx->ctx = ctx;
> > +
> > +     action_ctx->res.should_kfree = true;
> > +     /* As init is NULL, this cannot fail. */
> > +     __kunit_add_resource(test, NULL, __kunit_action_free, &action_ctx->res, action_ctx);
> > +
> > +     return action_ctx;
> > +}
>
> One thing worth pointing is that if kunit_add_action() fails, the
> cleanup function passed as an argument won't run.
>
> So, if the kzalloc call ever fails, patch 2 will leak its res->data()
> resource for example.
>
> devm (and drmm) handles this using a variant called
> devm_add_action_or_reset, we should either provide the same variant or
> just go for that behavior by default.
>

Excellent point.

I think I'll add a kunit_add_action_or_reset() variant to the next
revision. If we've gone this far to match the devm_ API, continuing to
do so probably is the best way of handling it.

Cheers,
-- David

--00000000000058eb7305f8920372
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAE
1GPlfUJ7+Vqe9ALQNYRNnpeFINXPxj9INFn2ydFAETAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MDUwNzQ4MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAV7S5PNML1RnhQ8ISNu3W
wZDa67DHRRLHiVGNtM1RvG+JEFtCN1saCEJU41F7p+fYf+CZq6wFEQE469JV73aaZ3rTnBJWqGij
9udyHNEpFoVjJcxEP/n6H3tzoA8aPgEaL5TE0tXpHhXPu9CUoPJWVBersDSCYaKnhW6LlQQhVqaM
BO18YDuqKZqiQkR3B5PmN0ax/9zTUGphCk0u5OF+q/ygA/3FvfYbawwG/NwOo9zVDmvKtwiXUwiD
B4VteJCjC48OQAKhYeW4nBrpNS/I45/CvggM0nFpW1TXOq4haJMngFIHMYAWrqZM1oMZGEdRKcA1
BXDfX2IXQG70AKiq3g==
--00000000000058eb7305f8920372--
