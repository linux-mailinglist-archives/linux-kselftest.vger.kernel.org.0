Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA154E394E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiCVHIa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 03:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiCVHIW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 03:08:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212145748E
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Mar 2022 00:06:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x34so19347909ede.8
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Mar 2022 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74AEUdctc3ZeeBqiC+ypczzjJ82s4XY5TZ4m0+nyhR8=;
        b=MaSdtgUtMm1stk7+jnTEYcU+1TIquX0e5Ii9hArhNZVJ/Z7qmSa91QZED0TySgz4Ge
         TH0+EPa9gDmojjJ+ucSsmED9linlopH3/bR7R2yBTdeJHAe1SBuPYXl48y2myXEjCUHD
         7R70NhaSsp/Rk2j4/1H7Q3GaK3lWnmgSZaVZ6ZUha71D0UeSFuZ+kiimRxMVIf6oAbUb
         8gCE1D2du7YMeDz93VpxaXOMp2QvBZalmxddHSUiUw8kG+YZ5bsUiUn5+YoJcCcHS8Nu
         hw/Idoxi9LpaH+HtoPaOIa5TtqI8LPVCtDu2Q4dgdK+mroBDOtnu78Malcqf7AidyvC0
         4SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74AEUdctc3ZeeBqiC+ypczzjJ82s4XY5TZ4m0+nyhR8=;
        b=rgoMN3qa7lUGxG6VnkQbLaAGqizxs7MR7LJKCWidc68MHlvH3+00BkdSZDj0U09644
         eTKiZdcdH0jI1G4wKgMsC8meDC5UHLF9cUl3pPsUO4cVK6eBhx3LLoQi7AD1HLDRBgwa
         maL5S05ZXFe5YlJ1/k23mBkqFVp8FmgvxJtJOGU9CJgnp46TVcej9531DCxhCsrg9WXQ
         WVeZyovKIqwIG9Qxaok/KXHRWG0qVcmUlqIGSwJ7p7U4qRSMFYJgxyPjksU1QJ39wwTi
         de0XFIrsungJARkoBl11KftzcF5PNM7wS+Y1M01FOKiyoBcIM9M7IHQgzjmrQ/gy93Yo
         whdg==
X-Gm-Message-State: AOAM5311mCqmFYkut9bwtPy5dlw0vfrlU+f2ZLEaX2phlvW+mbwvNof0
        DA3lLCpFEh0f4JNsEERWsxB1nSpBgeUewxTLAw85Ug==
X-Google-Smtp-Source: ABdhPJw5t5dAxPGHTaI+GD+LzXDLXi7+MvMqy9BPlDFTQ159KmNOHeVo5nttIyS8szCt9wVbtVW6O5THdVcNT4AjBtM=
X-Received: by 2002:aa7:d947:0:b0:419:3e8d:3e37 with SMTP id
 l7-20020aa7d947000000b004193e8d3e37mr8909466eds.247.1647932812900; Tue, 22
 Mar 2022 00:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220319055600.3471875-1-davidgow@google.com> <CAGS_qxpqcc8O2HpmF3qB-uzXZrDNg9=h3nE_f7si=aOxXkRA+Q@mail.gmail.com>
 <CABVgOS=sKWiDLN=GgyXQGOdmRn6t35mEA_0C7GrZyEApjVg1Pw@mail.gmail.com>
In-Reply-To: <CABVgOS=sKWiDLN=GgyXQGOdmRn6t35mEA_0C7GrZyEApjVg1Pw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 22 Mar 2022 02:06:41 -0500
Message-ID: <CAGS_qxobBt2gH3FB79m7sfQZ9thKXQ5exQEa_1GcQOmXFFEv1A@mail.gmail.com>
Subject: Re: [PATCH] kunit: Rework kunit_resource allocation policy
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 21, 2022 at 11:10 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Mar 22, 2022 at 9:57 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > On Sat, Mar 19, 2022 at 12:56 AM David Gow <davidgow@google.com> wrote:
> > >
> > > KUnit's test-managed resources can be created in two ways:
> > > - Using the kunit_add_resource() family of functions, which accept a
> > >   struct kunit_resource pointer, typically allocated statically or on
> > >   the stack during the test.
> > > - Using the kunit_alloc_resource() family of functions, which allocate a
> > >   struct kunit_resource using kzalloc() behind the scenes.
> > >
> > > Both of these families of functions accept a 'free' function to be
> > > called when the resource is finally disposed of.
> > >
> > > At present, KUnit will kfree() the resource if this 'free' function is
> > > specified, and will not if it is NULL. However, this can lead
> > > kunit_alloc_resource() to leak memory (if no 'free' function is passed
> > > in), or kunit_add_resource() to incorrectly kfree() memory which was
> > > allocated by some other means (on the stack, as part of a larger
> > > allocation, etc), if a 'free' function is provided.
> >
> > Trying it with this:
> >
> > static void noop_free_resource(struct kunit_resource *) {}
> >
> > struct kunit_resource global_res;
> >
> > static void example_simple_test(struct kunit *test)
> > {
> >         kunit_add_resource(test, NULL, noop_free_resource, &global_res, test);
> > }
> >
> > Running then with
> > $ run_kunit --kunitconfig=lib/kunit --arch=x86_64
> > --build_dir=kunit_x86/ --kconfig_add=CONFIG_KASAN=y
> >
> > Before:
> > BUG: KASAN: double-free or invalid-free in kunit_cleanup+0x51/0xb0
> >
> > After:
> > Passes
> >
>
> Phew! :-)
> I'm glad it works.
>
> > >
> > > Instead, always kfree() if the resource was allocated with
> > > kunit_alloc_resource(), and never kfree() if it was passed into
> > > kunit_add_resource() by the user. (If the user of kunit_add_resource()
> > > wishes the resource be kfree()ed, they can call kfree() on the resource
> > > from within the 'free' function.
> > >
> > > This is implemented by adding a 'should_free' member to
> >
> > nit: would `should_kfree` be a bit better?
> > `should_free` almost sounds like "should we invoke res->free" (as
> > nonsensical as that might be)
> >
>
> I think I had it as should_kfree at some point. I agree it's a little
> clearer. I'll rename it back.
>
> The other option I considered was to have a "flags" member, of which
> SHOULD_KFREE could be one. Though I eventually decided to leave that
> until we needed another flag.
>
> > > struct kunit_resource and setting it appropriately. To facilitate this,
> > > the various resource add/alloc functions have been refactored somewhat,
> > > making them all call a __kunit_add_resource() helper after setting the
> > > 'should_free' member appropriately. In the process, all other functions
> > > have been made static inline functions.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > Tested-by: Daniel Latypov <dlatypov@google.com>
> >
> >
> > > ---
> > >  include/kunit/test.h | 135 +++++++++++++++++++++++++++++++++++--------
> > >  lib/kunit/test.c     |  65 +++------------------
> > >  2 files changed, 120 insertions(+), 80 deletions(-)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 00b9ff7783ab..5a3aacbadda2 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -36,11 +36,14 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
> > >   * struct kunit_resource - represents a *test managed resource*
> > >   * @data: for the user to store arbitrary data.
> > >   * @name: optional name
> > > - * @free: a user supplied function to free the resource. Populated by
> > > - * kunit_resource_alloc().
> > > + * @free: a user supplied function to free the resource.
> > >   *
> > >   * Represents a *test managed resource*, a resource which will automatically be
> > > - * cleaned up at the end of a test case.
> > > + * cleaned up at the end of a test case. This cleanup is performed by the 'free'
> > > + * function. The resource itself is allocated with kmalloc() and freed with
> > > + * kfree() if created with kunit_alloc_{,and_get_}resource(), otherwise it must
> > > + * be freed by the user, typically with the 'free' function, or automatically if
> > > + * it's allocated on the stack.
> >
> > I'm not a fan of this complexity, but I'm not sure if we have a way
> > around it, esp. w/ stack-allocated data.
> >
> The other option is to make all resources allocated with
> kunit_alloc_resource() require a non-NULL 'free' function which calls
> kfree() itself. This is much simpler on the KUnit side, but does put
> some of that burden on the user (and may prevent a free() function
> from being shared between allocated and non-allocated resources).

Overall, I'm ambivalent.

To be honest, I'm not sure how real the user burden would be (it's
basically 0 right now).

This would only add about 6 more lines to add a kfree version:
static void free_stack_resource(struct kunit_resource *res) { ... }

static void free_heap_resource(struct kunit_resource *res)
{
   free_stack_resource(res);
   kfree(res);
}

So far, this function is only ever used w/ non-NULL free functions
(even in the under-review stubbing patches).
So now would be the time to make such a change.

But I'm slightly against such a change.
It slightly complicates the "resources as storage" usecase in favor of
simplifying the "resources as memory wranglers".
Maybe it'd be fine if we added a helper they could use, e.g.
  void kunit_resource_default_free(struct kunit_resource *res) { kfree(res); }
but it

>
> > Perhaps this would be a bit easier to read if we tweaked it a bit like:
> > "freed with kfree() if allocated by KUnit (via kunit_alloc..."
> >
> > Maybe we can drop the "or automatically, if it's allocated on the
> > stack" as well.
>
> Yeah: I'm not 100% happy with that wording. I wanted to make it clear
> that there are cases where no automatic freeing is needed, but I agree
> it's really just making things more confusing.
> >
> > A bigger way to simplify: perhaps we should get rid of
> > kunit_alloc_and_get_resource() first?
> > It's only used in KUnit's tests for itself.
> > They could instead use kunit_alloc_resource() +
> > kunit_find_resource(test, kunit_resource_instance_match, data).
> > We could even define the helper with the same name in kunit-test.c
> > (the only place it's used).
> >
> > Alternatively, we could make it an internal helper and define
> > kunit_alloc_resource() as
> >
> > void *kunit_alloc_resource(...)
> > {
> >    struct kunit_resource *res = _kunit_alloc_and_get_resource(...)
> >    if (res) return res->data;
> >    return NULL;
> > }
> >
> > ?
> >
>
> I was thinking about this a bit this morning, and I think we should do
> the opposite: get rid of kunit_alloc_resource() and leave only
> kunit_alloc_and_get_resource().
> Then, split the resource system basically in two:
> - The system for managing "findable" resources, whose main purpose is
> for cases like the KASAN integration and the stub stuff where main
> goal is tying some named bit of data to a test, and reference counting
> it so it can safely be retrieved and used throughout the kernel if
> need be.
> - The simpler "free this on test exit" system, which could be as
> simple as a kunit_defer(func, context) function built on top of the
> former. This wouldn't need detailed tracking of reference counts, etc,

Agree that there's two distinct usecases here.
One wants a replacement for global variables (which thus need
"finding") and the other just wants to ensure some function like
kfree() gets called.

The latter ~never need to get "found" (e.g. kunit_kmalloc() users).
The one exception: when people use kunit_kfree() to free things early,
which requires us to "find" these resources we otherwise wouldn't care
about.

So I don't know how we can split the API unless we get rid of kunit_kfree().
Its presence means kunit_kmalloc() and friends need refcounting.

Can we drop it? Maybe.
Looking at the uses of kunit_kfree(), they're all internal to kunit except one.

   111  static void
ne_misc_dev_test_merge_phys_contig_memory_regions(struct kunit *test)
   112  {
...
   117          phys_contig_mem_regions.regions = kunit_kcalloc(test,
MAX_PHYS_REGIONS,
   118
sizeof(*phys_contig_mem_regions.regions),
   119                                                          GFP_KERNEL);
...
   140
   141          kunit_kfree(test, phys_contig_mem_regions.regions);
   142  }

Hmm, that looks redundant since it's right before the end of the test case.
We can drop that call, I think.

But I think kunit_kfree() can serve a purpose.
E.g. for short-lived allocations where assertions are used.
  buf = kunit_kzalloc(test, sizeof(*buf), GFP_KERNEL);
  KUNIT_ASSERT_EQ(test, do_stuff(buf), 0);
  KUNIT_EXPECT_EQ(test, <something about buf>);
  kunit_kfree(buf);
  // do more stuff

Sure we can drop kunit_kfree() and have `buf` stick around longer than needed.
Or we could rewrite it like
  buf = kzalloc(sizeof(*buf), GFP_KERNEL);
  if (do_stuff(buf)) {
    KUNIT_FAIL(test, "do_stuff() failed");
  } else {
     KUNIT_EXPECT_EQ(test, <something about buf>);
  }
  kfree(buf);
 but I think the kunit_kfree() code is cleaner.

>
> (tl;dr: I think that kunit_alloc_resource() is broken, refcount-wise,
> if we're trying to implement the first kind of system, but useful for
> the second, and this is quite confusing. So kunit_alloc_resource()
> probably shouldn't be used alongside kunit_find_resource(), as there
> could be a potential race condition. Now, this shouldn't happen in
> practice, as most tests are single threaded and none are doing fancy
> things with kunit_remove_resource(), but
> kunit_alloc_and_get_resource() should be safer, as you're not playing
> with a resource you don't have a reference to according to the
> refcount.)
>
> That's a more complicated refactor and redesign of the resources
> system, though, so I'd rather fix this first.
>
> Cheers,
> -- David
