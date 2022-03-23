Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36134E4D44
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 08:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiCWHYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiCWHYU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 03:24:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0A73068
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 00:22:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d10so983063eje.10
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjYbB0p0LrOcfIL6of6QwuQD3Wj+3lAuUT/c+K+uL4c=;
        b=J33sJ4aXRwY5OJw1KjvnEiLsfiBDLstAfNOLvJnbAWozJc6BmnqeMXNwVNQrT26Y53
         OwaDtr3Y8Nl0dPXsEFdX8101O4zBr0gJHpM+4d3q5DBd4xXEVPfwyHtwbYxojPtCvvgM
         UpCSvrnlB5CCrSH9dKKZ0XLrOPPJkLguzMdHd8rC0Sho5ltZ/wDyj7j6YOVKLAbK++Ec
         RS/JMFHCpbtdPVpADlGVPgCbZnrl7dJRKubPF8ItijMDKJOoK1ikl8fgwHXOBxrnyU2n
         1ueWHxZ4Hzi3J4XUvmErTcRuUn63L5a2yZ6rN3K1fz/CH5HkDqnsP8BeRdlxx3h9qgzB
         92wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjYbB0p0LrOcfIL6of6QwuQD3Wj+3lAuUT/c+K+uL4c=;
        b=sSJ9uX4y1R2rtME11jZegCw7GjWVHqFLHZUIgd4QeWkRmoOcGvg1zEfX3iG4bcuecu
         I5V2WTDoG94X+YE4RDGrT/7eQieoVmMwyVCCzJqj3epxp35cgykVBLkLTz85ywuJ6vec
         Ped8dxBUB8QxZ597SJfrkKSs5zXyN400HovPJyv6PaO9+5gBMZGQc00YXC3Xn/KmQIta
         8vO1dQQtdjF8ddIAQSnHSQB/VxcEh8mPKJXn3Whp6m0ewxoGhKU+4Z/nUMyU/iY2ydZu
         fy4holEQ06UpxM4D4Rb1TLOpDJ5JtZJSYA+QDBXRhFQOmQ3H/kohtTwlkscLlRUQU1NC
         JUjQ==
X-Gm-Message-State: AOAM53382dD/Wk99uz3PN4FpwvbdVXFgAl3zfCRBiv6X86mxArz/FtKu
        PeW0zrQ7Ez1cA7FmN0Q0ilj5sUphRpCgg5kZcTmWRw==
X-Google-Smtp-Source: ABdhPJyMha7ML20/oSGDyIKQrditBXLYvAclp4IynFPWsl5e7TkIX9R4OA82kgKrb6PZM+y5VWpbJxlbXLgdgKjsXe8=
X-Received: by 2002:a17:906:c14b:b0:6da:b30d:76a0 with SMTP id
 dp11-20020a170906c14b00b006dab30d76a0mr29276258ejc.279.1648020169255; Wed, 23
 Mar 2022 00:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220319055600.3471875-1-davidgow@google.com> <CAGS_qxpqcc8O2HpmF3qB-uzXZrDNg9=h3nE_f7si=aOxXkRA+Q@mail.gmail.com>
 <CABVgOS=sKWiDLN=GgyXQGOdmRn6t35mEA_0C7GrZyEApjVg1Pw@mail.gmail.com> <CAGS_qxobBt2gH3FB79m7sfQZ9thKXQ5exQEa_1GcQOmXFFEv1A@mail.gmail.com>
In-Reply-To: <CAGS_qxobBt2gH3FB79m7sfQZ9thKXQ5exQEa_1GcQOmXFFEv1A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 03:22:37 -0400
Message-ID: <CAFd5g47ZJq8FmFFnAVdDEc6MKdeYBndrb=jbiiebLBdoG4hvCQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Rework kunit_resource allocation policy
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 22, 2022 at 3:06 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Mar 21, 2022 at 11:10 PM David Gow <davidgow@google.com> wrote:
> >
> > On Tue, Mar 22, 2022 at 9:57 AM 'Daniel Latypov' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > On Sat, Mar 19, 2022 at 12:56 AM David Gow <davidgow@google.com> wrote:
> > > >
> > > > KUnit's test-managed resources can be created in two ways:
> > > > - Using the kunit_add_resource() family of functions, which accept a
> > > >   struct kunit_resource pointer, typically allocated statically or on
> > > >   the stack during the test.
> > > > - Using the kunit_alloc_resource() family of functions, which allocate a
> > > >   struct kunit_resource using kzalloc() behind the scenes.
> > > >
> > > > Both of these families of functions accept a 'free' function to be
> > > > called when the resource is finally disposed of.
> > > >
> > > > At present, KUnit will kfree() the resource if this 'free' function is
> > > > specified, and will not if it is NULL. However, this can lead
> > > > kunit_alloc_resource() to leak memory (if no 'free' function is passed
> > > > in), or kunit_add_resource() to incorrectly kfree() memory which was
> > > > allocated by some other means (on the stack, as part of a larger
> > > > allocation, etc), if a 'free' function is provided.
> > >
> > > Trying it with this:
> > >
> > > static void noop_free_resource(struct kunit_resource *) {}
> > >
> > > struct kunit_resource global_res;
> > >
> > > static void example_simple_test(struct kunit *test)
> > > {
> > >         kunit_add_resource(test, NULL, noop_free_resource, &global_res, test);
> > > }
> > >
> > > Running then with
> > > $ run_kunit --kunitconfig=lib/kunit --arch=x86_64
> > > --build_dir=kunit_x86/ --kconfig_add=CONFIG_KASAN=y
> > >
> > > Before:
> > > BUG: KASAN: double-free or invalid-free in kunit_cleanup+0x51/0xb0
> > >
> > > After:
> > > Passes
> > >
> >
> > Phew! :-)
> > I'm glad it works.
> >
> > > >
> > > > Instead, always kfree() if the resource was allocated with
> > > > kunit_alloc_resource(), and never kfree() if it was passed into
> > > > kunit_add_resource() by the user. (If the user of kunit_add_resource()
> > > > wishes the resource be kfree()ed, they can call kfree() on the resource
> > > > from within the 'free' function.
> > > >
> > > > This is implemented by adding a 'should_free' member to
> > >
> > > nit: would `should_kfree` be a bit better?
> > > `should_free` almost sounds like "should we invoke res->free" (as
> > > nonsensical as that might be)
> > >
> >
> > I think I had it as should_kfree at some point. I agree it's a little
> > clearer. I'll rename it back.
> >
> > The other option I considered was to have a "flags" member, of which
> > SHOULD_KFREE could be one. Though I eventually decided to leave that
> > until we needed another flag.
> >
> > > > struct kunit_resource and setting it appropriately. To facilitate this,
> > > > the various resource add/alloc functions have been refactored somewhat,
> > > > making them all call a __kunit_add_resource() helper after setting the
> > > > 'should_free' member appropriately. In the process, all other functions
> > > > have been made static inline functions.
> > > >
> > > > Signed-off-by: David Gow <davidgow@google.com>
> > >
> > > Tested-by: Daniel Latypov <dlatypov@google.com>
> > >
> > >
> > > > ---
> > > >  include/kunit/test.h | 135 +++++++++++++++++++++++++++++++++++--------
> > > >  lib/kunit/test.c     |  65 +++------------------
> > > >  2 files changed, 120 insertions(+), 80 deletions(-)
> > > >
> > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > index 00b9ff7783ab..5a3aacbadda2 100644
> > > > --- a/include/kunit/test.h
> > > > +++ b/include/kunit/test.h
> > > > @@ -36,11 +36,14 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
> > > >   * struct kunit_resource - represents a *test managed resource*
> > > >   * @data: for the user to store arbitrary data.
> > > >   * @name: optional name
> > > > - * @free: a user supplied function to free the resource. Populated by
> > > > - * kunit_resource_alloc().
> > > > + * @free: a user supplied function to free the resource.
> > > >   *
> > > >   * Represents a *test managed resource*, a resource which will automatically be
> > > > - * cleaned up at the end of a test case.
> > > > + * cleaned up at the end of a test case. This cleanup is performed by the 'free'
> > > > + * function. The resource itself is allocated with kmalloc() and freed with
> > > > + * kfree() if created with kunit_alloc_{,and_get_}resource(), otherwise it must
> > > > + * be freed by the user, typically with the 'free' function, or automatically if
> > > > + * it's allocated on the stack.
> > >
> > > I'm not a fan of this complexity, but I'm not sure if we have a way
> > > around it, esp. w/ stack-allocated data.
> > >
> > The other option is to make all resources allocated with
> > kunit_alloc_resource() require a non-NULL 'free' function which calls
> > kfree() itself. This is much simpler on the KUnit side, but does put
> > some of that burden on the user (and may prevent a free() function
> > from being shared between allocated and non-allocated resources).
>
> Overall, I'm ambivalent.
>
> To be honest, I'm not sure how real the user burden would be (it's
> basically 0 right now).
>
> This would only add about 6 more lines to add a kfree version:
> static void free_stack_resource(struct kunit_resource *res) { ... }
>
> static void free_heap_resource(struct kunit_resource *res)
> {
>    free_stack_resource(res);
>    kfree(res);
> }
>
> So far, this function is only ever used w/ non-NULL free functions
> (even in the under-review stubbing patches).
> So now would be the time to make such a change.
>
> But I'm slightly against such a change.
> It slightly complicates the "resources as storage" usecase in favor of
> simplifying the "resources as memory wranglers".
> Maybe it'd be fine if we added a helper they could use, e.g.
>   void kunit_resource_default_free(struct kunit_resource *res) { kfree(res); }
> but it

I agree. I am not a fan of requiring a non-null free function. I think
the solution is better captured by splitting up the resource API, like
you suggest elsewhere as a long term solution.

In the short term, I like what you did here with the should_kfree.

> > > Perhaps this would be a bit easier to read if we tweaked it a bit like:
> > > "freed with kfree() if allocated by KUnit (via kunit_alloc..."
> > >
> > > Maybe we can drop the "or automatically, if it's allocated on the
> > > stack" as well.
> >
> > Yeah: I'm not 100% happy with that wording. I wanted to make it clear
> > that there are cases where no automatic freeing is needed, but I agree
> > it's really just making things more confusing.
> > >
> > > A bigger way to simplify: perhaps we should get rid of
> > > kunit_alloc_and_get_resource() first?
> > > It's only used in KUnit's tests for itself.
> > > They could instead use kunit_alloc_resource() +
> > > kunit_find_resource(test, kunit_resource_instance_match, data).
> > > We could even define the helper with the same name in kunit-test.c
> > > (the only place it's used).
> > >
> > > Alternatively, we could make it an internal helper and define
> > > kunit_alloc_resource() as
> > >
> > > void *kunit_alloc_resource(...)
> > > {
> > >    struct kunit_resource *res = _kunit_alloc_and_get_resource(...)
> > >    if (res) return res->data;
> > >    return NULL;
> > > }
> > >
> > > ?
> > >
> >
> > I was thinking about this a bit this morning, and I think we should do
> > the opposite: get rid of kunit_alloc_resource() and leave only
> > kunit_alloc_and_get_resource().
> > Then, split the resource system basically in two:
> > - The system for managing "findable" resources, whose main purpose is
> > for cases like the KASAN integration and the stub stuff where main
> > goal is tying some named bit of data to a test, and reference counting
> > it so it can safely be retrieved and used throughout the kernel if
> > need be.
> > - The simpler "free this on test exit" system, which could be as
> > simple as a kunit_defer(func, context) function built on top of the
> > former. This wouldn't need detailed tracking of reference counts, etc,
>
> Agree that there's two distinct usecases here.
> One wants a replacement for global variables (which thus need
> "finding") and the other just wants to ensure some function like
> kfree() gets called.

Agreed.

> The latter ~never need to get "found" (e.g. kunit_kmalloc() users).
> The one exception: when people use kunit_kfree() to free things early,
> which requires us to "find" these resources we otherwise wouldn't care
> about.
>
> So I don't know how we can split the API unless we get rid of kunit_kfree().
> Its presence means kunit_kmalloc() and friends need refcounting.

Do we need to choose between dropping kunit_kfree() and refcounting? I
think this is semantically different from other findable resources,
and I think it fairly obviously entails the complexity of using it.

> Can we drop it? Maybe.
> Looking at the uses of kunit_kfree(), they're all internal to kunit except one.
>
>    111  static void
> ne_misc_dev_test_merge_phys_contig_memory_regions(struct kunit *test)
>    112  {
> ...
>    117          phys_contig_mem_regions.regions = kunit_kcalloc(test,
> MAX_PHYS_REGIONS,
>    118
> sizeof(*phys_contig_mem_regions.regions),
>    119                                                          GFP_KERNEL);
> ...
>    140
>    141          kunit_kfree(test, phys_contig_mem_regions.regions);
>    142  }
>
> Hmm, that looks redundant since it's right before the end of the test case.
> We can drop that call, I think.
>
> But I think kunit_kfree() can serve a purpose.
> E.g. for short-lived allocations where assertions are used.
>   buf = kunit_kzalloc(test, sizeof(*buf), GFP_KERNEL);
>   KUNIT_ASSERT_EQ(test, do_stuff(buf), 0);
>   KUNIT_EXPECT_EQ(test, <something about buf>);
>   kunit_kfree(buf);
>   // do more stuff
>
> Sure we can drop kunit_kfree() and have `buf` stick around longer than needed.
> Or we could rewrite it like
>   buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>   if (do_stuff(buf)) {
>     KUNIT_FAIL(test, "do_stuff() failed");
>   } else {
>      KUNIT_EXPECT_EQ(test, <something about buf>);
>   }
>   kfree(buf);
>  but I think the kunit_kfree() code is cleaner.
>
> >
> > (tl;dr: I think that kunit_alloc_resource() is broken, refcount-wise,
> > if we're trying to implement the first kind of system, but useful for
> > the second, and this is quite confusing. So kunit_alloc_resource()
> > probably shouldn't be used alongside kunit_find_resource(), as there
> > could be a potential race condition. Now, this shouldn't happen in
> > practice, as most tests are single threaded and none are doing fancy
> > things with kunit_remove_resource(), but
> > kunit_alloc_and_get_resource() should be safer, as you're not playing
> > with a resource you don't have a reference to according to the
> > refcount.)
> >
> > That's a more complicated refactor and redesign of the resources
> > system, though, so I'd rather fix this first.
> >
> > Cheers,
> > -- David
