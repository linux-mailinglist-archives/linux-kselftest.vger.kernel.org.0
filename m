Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912BD182623
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 01:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgCLAOq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 20:14:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44331 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbgCLAOq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 20:14:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so1865778plo.11
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSkV57xAM19GJmI8YrDbY1cYrE1gi4b9h0yfhbibZtk=;
        b=E2N6tUHVQzH6leI62KcUiv6XAAsSHxJMoHRbFwoBdH5CV8PWxufppc7kmLSg9KFtSR
         O8fFxet/X9uevAdSBbosxOWOxB5F1NoodEgZOzF8MnuZDn4NnLJoic4FGHGJMtEwc0na
         uWEzQ6qk7JZDDpIBYRXKOkW3xLTwvViGkZ0oE5Bd+sd/R0mIeN71qIWNS4VSPZMF7L04
         za2mfyu0TX7rdfROkietl7xVySojKaY2TZQpwcp5WeR5c/j/Cb545v1Lv63anWy10MPF
         cuF9fkQV6fswOTzbwgv/oZSJ0Y+QRZMCgwOP/pkG/cTXrudw9Bv2Ek1wJcu2fVNfeUGJ
         qJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSkV57xAM19GJmI8YrDbY1cYrE1gi4b9h0yfhbibZtk=;
        b=Yilca6leNNxdNlB/FD+nq9zvUXxlSG9WxvHMfYmXNvArZ3meQh6TLrZNawSqiunThq
         jeogvwUA11moskJjarx3E/urukA3KMJAxLiGJuNFqxd/ZSLqnODDTlkMPWPUEnHySLTC
         eVIs5uCWaTuSl7kOgm46UkcbQmYci9pkY98Y+ay7JBJD61ln3t8qf4gVbfDFUU0C2E1P
         tUdp547np/F0dRCKlf7ioAl/Bpi1c7ck6K8KlMhkmUE11Y5sZX++kH4JyotibKcFChPM
         elk7Tiz4cPHE4jwLCsMASeQm5VRPpcW7d1DHHP6ey3jgF23bYUwisz3KsjybVyIV7TVJ
         p3gA==
X-Gm-Message-State: ANhLgQ3be71Idllz70aacHbXw2P8GJ/4NEGDM3n0irhqxims/mu5dBSC
        CCXhXCJ7tJpd5dLqsfv9vOAa2sSy/sGdinn5XEw25w==
X-Google-Smtp-Source: ADFU+vuYtQTQUJbh5KWvpRAYgeZM3UbcVKTyGE6HVFwYVRkSK/JuY/NLsl/yFBVNTqPPQNaKHZ0tFYqijAEAA99nVvY=
X-Received: by 2002:a17:90b:d8d:: with SMTP id bg13mr710864pjb.29.1583972083908;
 Wed, 11 Mar 2020 17:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <1583251361-12748-1-git-send-email-alan.maguire@oracle.com> <1583251361-12748-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1583251361-12748-2-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Mar 2020 17:14:32 -0700
Message-ID: <CAFd5g44+uAs0pJQi=d0z7ZwYwjq4-U3+6SXvpshpMHyQEiJFVg@mail.gmail.com>
Subject: Re: [RFC PATCH kunit-next 1/2] kunit: generalize kunit_resource API
 beyond allocated resources
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 3, 2020 at 8:03 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> In its original form, the kunit resources API - consisting the
> struct kunit_resource and asscociated functions - was focused on
> adding allocated resources during test operation that would be
> automatically cleaned up on test completion.
>
> The recent RFC patch proposing converting KASAN tests to KUnit [1]
> showed another potential model - where outside of test context,
> but with a pointer to the test state, we wish to access/update
> test-related data, but expressly want to avoid allocations.
>
> It turns out we can generalize the kunit_resource to support
> static resources where the struct kunit_resource * is passed
> in and initialized for us. As part of this work, we also
> change the "allocation" field to the more general "data" name,
> as instead of associating an allocation, we can associate a
> pointer to static data.  Static data is distinguished by a NULL
> free functions.  A test is added to cover using kunit_add_resource()
> with a static resource and data.
>
> Finally we also make use of the kernel's krefcount interfaces
> to manage reference counting of KUnit resources.  The motivation
> for this is simple; if we have kernel threads accessing and
> using resources (say via kunit_find_resource()) we need to
> ensure we do not remove said resources (or indeed free them
> if they were dynamically allocated) until the reference count
> reaches zero.  A new function - kunit_put_resource() - is
> added to handle this.
>
> A cosmetic change here also; I've tried moving to
> kunit_[action]_resource() as the format of function names
> for consistency and readability.
>
> [1] https://lkml.org/lkml/2020/2/26/1286
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/kunit/test.h      | 107 +++++++++++++++++++-------
>  lib/kunit/kunit-test.c    |  66 +++++++++++-----
>  lib/kunit/string-stream.c |  14 ++--
>  lib/kunit/test.c          | 187 ++++++++++++++++++++++++++++++----------------
>  4 files changed, 251 insertions(+), 123 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 2dfb550..11c80f5 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/kref.h>
>
>  struct kunit_resource;
>
> @@ -23,13 +24,19 @@
>
>  /**
>   * struct kunit_resource - represents a *test managed resource*
> - * @allocation: for the user to store arbitrary data.
> + * @data: for the user to store arbitrary data.
>   * @free: a user supplied function to free the resource. Populated by
> - * kunit_alloc_resource().
> + * kunit_resource_alloc().
>   *
>   * Represents a *test managed resource*, a resource which will automatically be
>   * cleaned up at the end of a test case.
>   *
> + * Resources are reference counted so if a resource is retrieved via
> + * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
> + * to call kunit_put_resource() to reduce the resource reference count
> + * when finished with it.  Note that kunit_alloc_resource() does not require a
> + * kunit_resource_put() because it does not retrieve the resource itself.
> + *
>   * Example:
>   *
>   * .. code-block:: c
> @@ -42,9 +49,9 @@
>   *     static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
>   *     {
>   *             struct kunit_kmalloc_params *params = context;
> - *             res->allocation = kmalloc(params->size, params->gfp);
> + *             res->data = kmalloc(params->size, params->gfp);
>   *
> - *             if (!res->allocation)
> + *             if (!res->data)
>   *                     return -ENOMEM;
>   *
>   *             return 0;
> @@ -52,30 +59,28 @@
>   *
>   *     static void kunit_kmalloc_free(struct kunit_resource *res)
>   *     {
> - *             kfree(res->allocation);
> + *             kfree(res->data);
>   *     }
>   *
>   *     void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
>   *     {
>   *             struct kunit_kmalloc_params params;
> - *             struct kunit_resource *res;
>   *
>   *             params.size = size;
>   *             params.gfp = gfp;
>   *
> - *             res = kunit_alloc_resource(test, kunit_kmalloc_init,
> + *             return kunit_alloc_resource(test, kunit_kmalloc_init,
>   *                     kunit_kmalloc_free, &params);
> - *             if (res)
> - *                     return res->allocation;
> - *
> - *             return NULL;
>   *     }

Interesting. So it looks like, unless someone intentionally grabs a
reference, it behaves exactly the same as the old kunit_resource API.
Is that correct?

> + *

nit: unnecessary newline.

>   */
>  struct kunit_resource {
> -       void *allocation;
> +       void *data;
> +       kunit_resource_init_t init;

I don't think you use this `init` field anywhere; I only see it passed
as a parameter.

>         kunit_resource_free_t free;

I think `free` should go under the private comment directly below, no?

>
>         /* private: internal use only. */
> +       struct kref refcount;
>         struct list_head node;
>  };
>
> @@ -251,6 +256,32 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
>                                                     void *context);
>
>  /**
> + * kunit_put_resource() - When caller is done with retrieved resource,
> + *                       kunit_put_resource() should be called to drop
> + *                       reference count.  The resource list maintains
> + *                       a reference count on resources, so if no users
> + *                       are utilizing a resource and it is removed from
> + *                       the resource list, it will be freed via the
> + *                       associated free function (if any).  Only
> + *                       needs to be used if we alloc_and_get() or
> + *                       find() resource.
> + * @res: resource
> + */
> +void kunit_put_resource(struct kunit_resource *res);
> +
> +/**
> + * kunit_add_resource() - Add a *test managed resource*.
> + * @test: The test context object.
> + * @init: a user-supplied function to initialize the result (if needed).  If
> + *        none is supplied, the resource data value is simply set to @data.
> + *       If an init function is supplied, @data is passed to it instead.
> + * @free: a user-supplied function to free the resource (if needed).
> + * @data: value to pass to init function or set in resource data field.
> + */
> +int kunit_add_resource(struct kunit *test, kunit_resource_init_t init,
> +                      kunit_resource_free_t free, struct kunit_resource *res,
> +                      void *data);

nit: I have a preference for each parameter to have it's own line in
long parameter lists like this. See elsewhere in the original file.

> +/**
>   * kunit_alloc_resource() - Allocates a *test managed resource*.
>   * @test: The test context object.
>   * @init: a user supplied function to initialize the resource.
> @@ -262,7 +293,7 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
>   * cleaned up at the end of a test case. See &struct kunit_resource for an
>   * example.
>   *
> - * NOTE: KUnit needs to allocate memory for each kunit_resource object. You must

Has the truth of this statement changed? It looks like you still
always allocate memory when this function is called. (Well as long as
the kzalloc doesn't fail :-) )

> + * If KUnit needs to allocate memory for a kunit_resource object, you must
>   * specify an @internal_gfp that is compatible with the use context of your
>   * resource.
>   */
> @@ -274,54 +305,72 @@ static inline void *kunit_alloc_resource(struct kunit *test,
>  {
>         struct kunit_resource *res;
>
> -       res = kunit_alloc_and_get_resource(test, init, free, internal_gfp,
> -                                          context);
> +       res = kzalloc(sizeof(*res), internal_gfp);
> +       if (!res)
> +               return NULL;
>
> -       if (res)
> -               return res->allocation;
> +       if (!kunit_add_resource(test, init, free, res, context))
> +               return res->data;
>
>         return NULL;
>  }
>
>  typedef bool (*kunit_resource_match_t)(struct kunit *test,
> -                                      const void *res,
> +                                      struct kunit_resource *res,
>                                        void *match_data);
>
>  /**
>   * kunit_resource_instance_match() - Match a resource with the same instance.
>   * @test: Test case to which the resource belongs.
> - * @res: The data stored in kunit_resource->allocation.
> + * @res: The resource.
>   * @match_data: The resource pointer to match against.
>   *
>   * An instance of kunit_resource_match_t that matches a resource whose
>   * allocation matches @match_data.
>   */
>  static inline bool kunit_resource_instance_match(struct kunit *test,
> -                                                const void *res,
> +                                                struct kunit_resource *res,
>                                                  void *match_data)
>  {
> -       return res == match_data;
> +       return res->data == match_data;
>  }
>
>  /**
> - * kunit_resource_destroy() - Find a kunit_resource and destroy it.
> + * kunit_find_resource() - Find a resource using match function/data.
> + * @test: Test case to which the resource belongs.
> + * @match: match function to be applied to resources/match data.
> + * @match_data: data to be used in matching.
> + */
> +struct kunit_resource *kunit_find_resource(struct kunit *test,
> +                                          kunit_resource_match_t match,
> +                                          void *match_data);
> +
> +/**
> + * kunit_destroy_resource() - Find a kunit_resource and destroy it.
>   * @test: Test case to which the resource belongs.
>   * @match: Match function. Returns whether a given resource matches @match_data.
> - * @free: Must match free on the kunit_resource to free.
>   * @match_data: Data passed into @match.
>   *
> - * Free the latest kunit_resource of @test for which @free matches the
> - * kunit_resource_free_t associated with the resource and for which @match
> - * returns true.
> - *
>   * RETURNS:
>   * 0 if kunit_resource is found and freed, -ENOENT if not found.
>   */
> -int kunit_resource_destroy(struct kunit *test,
> +int kunit_destroy_resource(struct kunit *test,
>                            kunit_resource_match_t match,
> -                          kunit_resource_free_t free,
>                            void *match_data);
>
> +
> +/**
> + * kunit_remove_resource: remove resource from resource list associated with
> + *                       test.
> + * @test: The test context object.
> + * @res: The resource to be removed.
> + *
> + * Note that the resource will not be immediately freed since it is likely
> + * the caller has a reference to it via alloc_and_get() or find();
> + * in this case a final call to kunit_put_resource() is required.
> + */
> +void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
> +
>  /**
>   * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
>   * @test: The test context object.
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index ccb8d2e..b8bf36d 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -118,14 +118,14 @@ static int fake_resource_init(struct kunit_resource *res, void *context)
>  {
>         struct kunit_test_resource_context *ctx = context;
>
> -       res->allocation = &ctx->is_resource_initialized;
> +       res->data = &ctx->is_resource_initialized;
>         ctx->is_resource_initialized = true;
>         return 0;
>  }
>
>  static void fake_resource_free(struct kunit_resource *res)
>  {
> -       bool *is_resource_initialized = res->allocation;
> +       bool *is_resource_initialized = res->data;
>
>         *is_resource_initialized = false;
>  }
> @@ -154,9 +154,11 @@ static void kunit_resource_test_alloc_resource(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
>         KUNIT_EXPECT_PTR_EQ(test,
>                             &ctx->is_resource_initialized,
> -                           (bool *) res->allocation);
> +                           (bool *) res->data);
>         KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
>         KUNIT_EXPECT_PTR_EQ(test, free, res->free);
> +
> +       kunit_put_resource(res);

Alright, I am confused.

So I think when a `struct kunit` falls out of scope (a test case
ends), the refcount on the kunit_resource should go down by one, which
if no one has grabbed a reference, it should go down from one to zero
and be deallocated. In other words, I think the reference counting
shouldn't change the behavior of kunit_resources unless someone
(outside of the kunit internals) intentionally grabs a reference. From
some of the above code, I thought this is what was happening, but now
I am not sure. Can you please explain this?

>  }
>
>  static void kunit_resource_test_destroy_resource(struct kunit *test)
> @@ -169,11 +171,12 @@ static void kunit_resource_test_destroy_resource(struct kunit *test)
>                         GFP_KERNEL,
>                         ctx);
>
> +       kunit_put_resource(res);
> +
>         KUNIT_ASSERT_FALSE(test,
> -                          kunit_resource_destroy(&ctx->test,
> +                          kunit_destroy_resource(&ctx->test,
>                                                   kunit_resource_instance_match,
> -                                                 res->free,
> -                                                 res->allocation));
> +                                                 res->data));
>
>         KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
>         KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
> @@ -191,6 +194,7 @@ static void kunit_resource_test_cleanup_resources(struct kunit *test)
>                                                             fake_resource_free,
>                                                             GFP_KERNEL,
>                                                             ctx);
> +               kunit_put_resource(resources[i]);
>         }
>
>         kunit_cleanup(&ctx->test);
> @@ -221,14 +225,14 @@ static int fake_resource_2_init(struct kunit_resource *res, void *context)
>
>         KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
>
> -       res->allocation = ctx;
> +       res->data = ctx;
>
>         return 0;
>  }
>
>  static void fake_resource_2_free(struct kunit_resource *res)
>  {
> -       struct kunit_test_resource_context *ctx = res->allocation;
> +       struct kunit_test_resource_context *ctx = res->data;
>
>         KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
>  }
> @@ -236,23 +240,26 @@ static void fake_resource_2_free(struct kunit_resource *res)
>  static int fake_resource_1_init(struct kunit_resource *res, void *context)
>  {
>         struct kunit_test_resource_context *ctx = context;
> +       struct kunit_resource *res2;
>
> -       kunit_alloc_and_get_resource(&ctx->test,
> -                                    fake_resource_2_init,
> -                                    fake_resource_2_free,
> -                                    GFP_KERNEL,
> -                                    ctx);
> +       res2 = kunit_alloc_and_get_resource(&ctx->test,
> +                                           fake_resource_2_init,
> +                                           fake_resource_2_free,
> +                                           GFP_KERNEL,
> +                                           ctx);
>
>         KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
>
> -       res->allocation = ctx;
> +       res->data = ctx;
> +
> +       kunit_put_resource(res2);
>
>         return 0;
>  }
>
>  static void fake_resource_1_free(struct kunit_resource *res)
>  {
> -       struct kunit_test_resource_context *ctx = res->allocation;
> +       struct kunit_test_resource_context *ctx = res->data;
>
>         KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
>  }
> @@ -265,13 +272,14 @@ static void fake_resource_1_free(struct kunit_resource *res)
>  static void kunit_resource_test_proper_free_ordering(struct kunit *test)
>  {
>         struct kunit_test_resource_context *ctx = test->priv;
> +       struct kunit_resource *res;
>
>         /* fake_resource_1 allocates a fake_resource_2 in its init. */
> -       kunit_alloc_and_get_resource(&ctx->test,
> -                                    fake_resource_1_init,
> -                                    fake_resource_1_free,
> -                                    GFP_KERNEL,
> -                                    ctx);
> +       res = kunit_alloc_and_get_resource(&ctx->test,
> +                                          fake_resource_1_init,
> +                                          fake_resource_1_free,
> +                                          GFP_KERNEL,
> +                                          ctx);
>
>         /*
>          * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
> @@ -281,6 +289,8 @@ static void kunit_resource_test_proper_free_ordering(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
>         KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
>
> +       kunit_put_resource(res);
> +
>         kunit_cleanup(&ctx->test);
>
>         /*
> @@ -292,6 +302,21 @@ static void kunit_resource_test_proper_free_ordering(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
>  }
>
> +static void kunit_resource_test_static(struct kunit *test)
> +{
> +       struct kunit_test_resource_context ctx;
> +       struct kunit_resource res;
> +
> +       KUNIT_EXPECT_EQ(test, kunit_add_resource(test, NULL, NULL, &res, &ctx),
> +                       0);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, res.data, (void *)&ctx);
> +
> +       kunit_cleanup(test);
> +
> +       KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
> +}

Nice!

> +
>  static int kunit_resource_test_init(struct kunit *test)
>  {
>         struct kunit_test_resource_context *ctx =
> @@ -320,6 +345,7 @@ static void kunit_resource_test_exit(struct kunit *test)
>         KUNIT_CASE(kunit_resource_test_destroy_resource),
>         KUNIT_CASE(kunit_resource_test_cleanup_resources),
>         KUNIT_CASE(kunit_resource_test_proper_free_ordering),
> +       KUNIT_CASE(kunit_resource_test_static),
>         {}
>  };
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 3503920..141789c 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -33,14 +33,14 @@ static int string_stream_fragment_init(struct kunit_resource *res,
>         if (!frag->fragment)
>                 return -ENOMEM;
>
> -       res->allocation = frag;
> +       res->data = frag;
>
>         return 0;
>  }
>
>  static void string_stream_fragment_free(struct kunit_resource *res)
>  {
> -       struct string_stream_fragment *frag = res->allocation;
> +       struct string_stream_fragment *frag = res->data;
>
>         list_del(&frag->node);
>         kunit_kfree(frag->test, frag->fragment);
> @@ -65,9 +65,8 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
>
>  static int string_stream_fragment_destroy(struct string_stream_fragment *frag)
>  {
> -       return kunit_resource_destroy(frag->test,
> +       return kunit_destroy_resource(frag->test,
>                                       kunit_resource_instance_match,
> -                                     string_stream_fragment_free,
>                                       frag);
>  }
>
> @@ -179,7 +178,7 @@ static int string_stream_init(struct kunit_resource *res, void *context)
>         if (!stream)
>                 return -ENOMEM;
>
> -       res->allocation = stream;
> +       res->data = stream;
>         stream->gfp = ctx->gfp;
>         stream->test = ctx->test;
>         INIT_LIST_HEAD(&stream->fragments);
> @@ -190,7 +189,7 @@ static int string_stream_init(struct kunit_resource *res, void *context)
>
>  static void string_stream_free(struct kunit_resource *res)
>  {
> -       struct string_stream *stream = res->allocation;
> +       struct string_stream *stream = res->data;
>
>         string_stream_clear(stream);
>  }
> @@ -211,8 +210,7 @@ struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
>
>  int string_stream_destroy(struct string_stream *stream)
>  {
> -       return kunit_resource_destroy(stream->test,
> +       return kunit_destroy_resource(stream->test,
>                                       kunit_resource_instance_match,
> -                                     string_stream_free,
>                                       stream);
>  }

Alright, this all seems to match what I expect.

> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 9242f93..132e9bf 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -8,6 +8,7 @@
>
>  #include <kunit/test.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/sched/debug.h>
>
>  #include "string-stream.h"
> @@ -323,11 +324,67 @@ int kunit_run_tests(struct kunit_suite *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_run_tests);
>
> +/* Called when refcount reaches zero. */
> +void kunit_release_resource(struct kref *kref)
> +{
> +       struct kunit_resource *res = container_of(kref, struct kunit_resource,
> +                                                 refcount);
> +
> +       /* If free function is defined, resource was dynamically allocated. */
> +       if (res->free) {
> +               res->free(res);
> +               kfree(res);
> +       }
> +}
> +
> +static void kunit_get_resource(struct kunit_resource *res)
> +{
> +       kref_get(&res->refcount);
> +}
> +
> +void kunit_put_resource(struct kunit_resource *res)
> +{
> +       kref_put(&res->refcount, kunit_release_resource);
> +}
> +EXPORT_SYMBOL_GPL(kunit_put_resource);
> +
> +/*
> + * Used for static resources and once dynamic kunit_resource * has been

I think "dynamic" is a bit misleading; here you mean "created via
kunit_alloc_resource", right?

> + * allocated.  When an init function is supplied, @data is passed into the init
> + * function; otherwise, we simply set the resource data field to the data
> + * value passed in.
> + */
> +int kunit_add_resource(struct kunit *test, kunit_resource_init_t init,
> +                      kunit_resource_free_t free, struct kunit_resource *res,
> +                      void *data)
> +{
> +       int ret = 0;
> +
> +       res->init = init;
> +       res->free = free;
> +       kref_init(&res->refcount);
> +
> +       if (init) {
> +               ret = init(res, data);
> +               if (ret)
> +                       return ret;
> +       } else
> +               res->data = data;
> +
> +       spin_lock(&test->lock);
> +       list_add_tail(&res->node, &test->resources);
> +       /* refcount for list is established by kref_init() */
> +       spin_unlock(&test->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(kunit_add_resource);
> +
>  struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
>                                                     kunit_resource_init_t init,
>                                                     kunit_resource_free_t free,
>                                                     gfp_t internal_gfp,
> -                                                   void *context)
> +                                                   void *data)
>  {
>         struct kunit_resource *res;
>         int ret;
> @@ -336,77 +393,67 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
>         if (!res)
>                 return NULL;
>
> -       ret = init(res, context);
> -       if (ret)
> -               return NULL;
> -
> -       res->free = free;
> -       spin_lock(&test->lock);
> -       list_add_tail(&res->node, &test->resources);
> -       spin_unlock(&test->lock);
> -
> -       return res;
> +       ret = kunit_add_resource(test, init, free, res, data);
> +       if (!ret) {
> +               /*
> +                * bump refcount for get; kunit_resource_put() should be called
> +                * when done.
> +                */
> +               kunit_get_resource(res);
> +               return res;
> +       }
> +       return NULL;
>  }
>  EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
>
> -static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
> -{
> -       res->free(res);
> -       kfree(res);
> -}
> -
> -static struct kunit_resource *kunit_resource_find(struct kunit *test,
> -                                                 kunit_resource_match_t match,
> -                                                 kunit_resource_free_t free,
> -                                                 void *match_data)
> +struct kunit_resource *kunit_find_resource(struct kunit *test,
> +                                          kunit_resource_match_t match,
> +                                          void *match_data)
>  {
> -       struct kunit_resource *resource;
> +       struct kunit_resource *res, *found = NULL;
>
> -       lockdep_assert_held(&test->lock);
> +       spin_lock(&test->lock);
>
> -       list_for_each_entry_reverse(resource, &test->resources, node) {
> -               if (resource->free != free)
> -                       continue;
> -               if (match(test, resource->allocation, match_data))
> -                       return resource;
> +       list_for_each_entry_reverse(res, &test->resources, node) {
> +               if (match(test, res, (void *)match_data)) {
> +                       found = res;
> +                       kunit_get_resource(found);
> +                       break;
> +               }
>         }
>
> -       return NULL;
> +       spin_unlock(&test->lock);
> +
> +       return found;
>  }
> +EXPORT_SYMBOL_GPL(kunit_find_resource);
>
> -static struct kunit_resource *kunit_resource_remove(
> -               struct kunit *test,
> -               kunit_resource_match_t match,
> -               kunit_resource_free_t free,
> -               void *match_data)
> +void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
>  {
> -       struct kunit_resource *resource;
> -
>         spin_lock(&test->lock);
> -       resource = kunit_resource_find(test, match, free, match_data);
> -       if (resource)
> -               list_del(&resource->node);
> +       list_del(&res->node);
>         spin_unlock(&test->lock);
> -
> -       return resource;
> +       kunit_put_resource(res);
>  }
> +EXPORT_SYMBOL_GPL(kunit_remove_resource);
>
> -int kunit_resource_destroy(struct kunit *test,
> -                          kunit_resource_match_t match,
> -                          kunit_resource_free_t free,
> +int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
>                            void *match_data)
>  {
> -       struct kunit_resource *resource;
> -
> -       resource = kunit_resource_remove(test, match, free, match_data);
> +       struct kunit_resource *res = kunit_find_resource(test, match,
> +                                                        match_data);
>
> -       if (!resource)
> +       if (!res)
>                 return -ENOENT;
>
> -       kunit_resource_free(test, resource);
> +       kunit_remove_resource(test, res);
> +
> +       /* We have a reference also via _find(); drop it. */
> +       kunit_put_resource(res);
> +
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(kunit_resource_destroy);
> +EXPORT_SYMBOL_GPL(kunit_destroy_resource);
>
>  struct kunit_kmalloc_params {
>         size_t size;
> @@ -417,8 +464,8 @@ static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
>  {
>         struct kunit_kmalloc_params *params = context;
>
> -       res->allocation = kmalloc(params->size, params->gfp);
> -       if (!res->allocation)
> +       res->data = kmalloc(params->size, params->gfp);
> +       if (!res->data)
>                 return -ENOMEM;
>
>         return 0;
> @@ -426,7 +473,7 @@ static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
>
>  static void kunit_kmalloc_free(struct kunit_resource *res)
>  {
> -       kfree(res->allocation);
> +       kfree(res->data);
>  }
>
>  void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> @@ -446,20 +493,25 @@ void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
>
>  void kunit_kfree(struct kunit *test, const void *ptr)
>  {
> -       int rc;
> +       struct kunit_resource *res;
>
> -       rc = kunit_resource_destroy(test,
> -                                   kunit_resource_instance_match,
> -                                   kunit_kmalloc_free,
> -                                   (void *)ptr);
> +       res = kunit_find_resource(test, kunit_resource_instance_match,
> +                                 (void *)ptr);
> +
> +       /*
> +        * Removing the resource from the list of resources drops the
> +        * reference count to 1; the final put will trigger the free.
> +        */
> +       kunit_remove_resource(test, res);
> +
> +       kunit_put_resource(res);
>
> -       WARN_ON(rc);
>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>
>  void kunit_cleanup(struct kunit *test)
>  {
> -       struct kunit_resource *resource;
> +       struct kunit_resource *res;
>
>         /*
>          * test->resources is a stack - each allocation must be freed in the
> @@ -476,13 +528,16 @@ void kunit_cleanup(struct kunit *test)
>                         spin_unlock(&test->lock);
>                         break;
>                 }
> -               resource = list_last_entry(&test->resources,
> -                                          struct kunit_resource,
> -                                          node);
> -               list_del(&resource->node);
> +               res = list_last_entry(&test->resources,
> +                                     struct kunit_resource,
> +                                     node);
> +               /*
> +                * Need to unlock here as a resource may remove another
> +                * resource, and this can't happen if the test->lock
> +                * is held.
> +                */
>                 spin_unlock(&test->lock);
> -
> -               kunit_resource_free(test, resource);
> +               kunit_remove_resource(test, res);
>         }
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);

Overall, this seems like a pretty good idea to me.

At first I was a bit hesitant because I thought it might make things
too difficult for some users to understand, but after reading it, I
don't think that is true. Also, if I understand correctly, it still
has the same behavior unless you start grabbing references either for
static allocations or because you are doing multithreaded stuff, which
in either case, I think a user doing that has signed themselves up for
extra work.
