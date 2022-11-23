Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9628F63665F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiKWRAC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 12:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiKWRAB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 12:00:01 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E712A781A6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 08:59:58 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3a7081e3b95so76185097b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jayl9XfJvGWwHXVIk+ROjAbiw46GjWkW/kZXLe58Lv4=;
        b=bAt0XaONGIclr0aqlZnlWXU7WcAtPBaQ5FrrIYNBEva6Jb5bPqwC+w5+rVMWD+38sA
         5O1U+AaSKeb7xKFUmDFqD4dSwclkM8zyue2kefPAczf8jJWteKhqTp6wp/fhTvdXT8f9
         BkqQ5SDK4qZfV9rysP9i/DbtuRT5XIyVTCX1/jJG0HYhrHD13j4NyJ8IfZlBlQ5t385s
         T4AvtxZBDX/WmfXKFyP0MHkRWI3EjTJgIFrz+FVFJKJzjqoVvr9J+BJWSa3HSohood2I
         3diHYw4J+uWTqz0ZeJfKYE5iwDz6U23mDdx2Tmrvn8+TDTQGaLo6ntDHMvfXvwDwjbbG
         +hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jayl9XfJvGWwHXVIk+ROjAbiw46GjWkW/kZXLe58Lv4=;
        b=PLb6KNFHY/mpDYgtWZoetUZ7YfbVf/w9S6UH5oIr9nEeF3QOWRgsubrXcNzeoQlDbX
         SI5FCOjHOEwZvJOXqm6f+n/4+bYTT4/2pebDfNGyIKyf4HjD/YA8j1NgodkU0oBDyFoX
         QzPMLdEV9yRkyoIFv6TEVeaale4ZSuYuaqzsjB90gMmTcD68LNz3cwstSYZt8Q52GGXn
         1BMc5At6b36rYZfjucSfYNDbEjQww05z7NiqVnmYi2kqisma2vJ9eh0mrIOtNCRCE+Mm
         JkE7ksfrhVDsX216YNhn1eUjhJ+l/b3XfmDbWOObRSXE87n6DrGrYeisgyiH+eNT8+Ye
         wG9Q==
X-Gm-Message-State: ANoB5plSO7JrotUqEoGilYRl+sDsfCxA49KGkQExxMCft7Y6OKVbn0CO
        Txlwmp9z0KqJMULohfW0AXSHXBUm8DyrEFhUWa/FUg==
X-Google-Smtp-Source: AA0mqf53yzdME7BXpGKNx+IMODOX54r+r4qy38o90rDlX+bZwFqBAw0uj2Qpu8QlnZv7NwlRlxzRIHcWLg3QbQFjdZQ=
X-Received: by 2002:a81:a14d:0:b0:3b1:8de1:e2b7 with SMTP id
 y74-20020a81a14d000000b003b18de1e2b7mr2268062ywg.188.1669222797957; Wed, 23
 Nov 2022 08:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com> <20221119081252.3864249-2-davidgow@google.com>
 <CAGS_qxqAUiMfKe2ksnqQtyWv0BWYLA4_uGqpu76d=Oh42mAUgQ@mail.gmail.com> <CABVgOSmfcJLs76efLe1zXgZwrSXrxKCLPAhSyx3P+WEkzZNR3A@mail.gmail.com>
In-Reply-To: <CABVgOSmfcJLs76efLe1zXgZwrSXrxKCLPAhSyx3P+WEkzZNR3A@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 23 Nov 2022 08:59:46 -0800
Message-ID: <CAGS_qxqCshqURWThsOj+ntBP5kXqOzxhde+A-29Pe2vhr7pBNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Use the static key when retrieving the
 current test
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 21, 2022 at 7:16 PM David Gow <davidgow@google.com> wrote:
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> >
> > Looks good to me, but some small optional nits about the Documentation.
> >
> > I'm a bit sad that the kunit_fail_current_test() macro is now a bit
> > more complicated (has two definitions).
>
> I'm not too happy with it either, but I think it's worth having the
> printf() format string checking, as well as making it possible to
> optimise the call out (without needing LTO), and I can't think of a
> better way of doing that at the moment.
>
> The only other option I can think of would be to have lots of #ifdefs
> for the _contents_ of the functions, and that seemed more ugly to me.

Sorry, I should have been more clear.
I'm fine with it as-is.

It's just a bit sad that it could have remained a single definition,
but that would sacrifice performance.
The version in this patch can avoid the call to
__kunit_fail_current_test() via static key, so that's more important.

>
> > Optional: perhaps it's long enough now that we should have a comment
> > after the #endif, i.e.
> > #endif   /* IS_BUILTIN(CONFIG_KUNIT) */
> >
>
> Makes sense to me. Will add in v3.
>
> > <snip>
> >
> > >
> > > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > > index 2737863ef365..e70014b82350 100644
> > > --- a/Documentation/dev-tools/kunit/usage.rst
> > > +++ b/Documentation/dev-tools/kunit/usage.rst
> > > @@ -625,17 +625,21 @@ as shown in next section: *Accessing The Current Test*.
> > >  Accessing The Current Test
> > >  --------------------------
> > >
> > > -In some cases, we need to call test-only code from outside the test file.
> > > -For example, see example in section *Injecting Test-Only Code* or if
> > > -we are providing a fake implementation of an ops struct. Using
> > > -``kunit_test`` field in ``task_struct``, we can access it via
> > > -``current->kunit_test``.
> > > +In some cases, we need to call test-only code from outside the test file,
> > > +for example,  when providing a fake implementation of a function, or to fail
> >
> > nit: there are two spaces after "for example, "
> >
> > Personal preference: I'd rather keep "For example," as the start of a
> > new sentence.
> >
> > > +any current test from within an error handler.
>
>
> Hmm... I found it a bit ugly to keep "For example" at the start of the
> sentence, as we then have to stick a (possibly duplicated) verb in to
> make it actually a sentence.
>
> How about:
> In some cases, we need to call test-only code from outside the test
> file. For example, this is useful when providing a fake implementation
> of a function, or if we wish to fail the current test from within an
> error handler.

I see what you mean. The initial wording is good as-is, I think.
I thought I had some ideas of how to reword it, but they don't sound
so good when I actually write them out.

>
>
> > > +We can do this via the ``kunit_test`` field in ``task_struct``, which we can
> > > +access using the ``kunit_get_current_test`` function in ``kunit/test-bug.h``.
> >
> > Personal preference: kunit_get_current_test()
> > IMO that would make it easier to pick up when the reader is quickly
> > scanning over.
> >
>
> Agreed, will fix in v3.
>
> > >
> > > -The example below includes how to implement "mocking":
> > > +``kunit_get_current_test`` requires KUnit be built-in to the kernel, i.e.
> > > +``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
> > > +or no test is currently running, in which case it will quickly return ``NULL``.
> >
> > I find this sentence a bit confusing.
> >
> > I think it's trying to convey that
> > * it can be called no matter how the kernel is built or what cmdline
> > args are given
> > * but it doesn't work properly for CONFIG_KUNIT=m
> > * for CONFIG_KUNIT=n, it's a static inline func that just returns NULL
> > * when booting with `kunit.enabled=0`, it's fast (thanks to static keys)
> >
>
> Yeah: that's the goal.
>
> > But the current wording basically says "the func requires
> > CONFIG_KUNIT=y" then says it's safe to call it even if CONFIG_KUNIT=n.
> > It feels a bit whiplashy.
> >
> > Should this be reworded to say the function can be used regardless of
> > whether KUnit is enabled but add a `note` block about how it doesn't
> > properly for CONFIG_KUNIT=m?
> >
>
> How about:
> ``kunit_get_current_test()`` is safe to call even if KUnit is not
> enabled. If KUnit is not enabled (or was built as a module), or no
> test is running, it will return NULL.
>
> Or:
> ``kunit_get_current_test()`` is always available, but will only return
> a test if KUnit is built-in to the kernel (i.e, CONFIG_KUNIT=y). In
> all other cases, it will return NULL.
>
> We could add a:
> This will compile to either a no-op or a static key, so will have

*static key check?

> negligible performance impact when no test is running.
>
> Thoughts?
>
> Regardless, the plan is to eventually get rid of the restriction with
> modules, so hopefully that part of the awkwardness won't last too
> long.

I think both of these work, w/ a slight preference to the first.
I think it more clearly explains how the function behaves, even if the
gotcha "this function won't do what you expect with moduels" is not
immediately apparent. But hopefully we can fix that soon so this
becomes a moot point.
I also think it works better for the section down below about
kunit_fail_current_test().

Up to you if you want to include the bit about the static key.
I can see arguments either way.

Daniel

>
> > > +
> > > +The example below uses this to implement a "mock" implementation of a function, ``foo``:
> > >
> > >  .. code-block:: c
> > >
> > > -       #include <linux/sched.h> /* for current */
> > > +       #include <kunit/test-bug.h> /* for kunit_get_current_test */
> > >
> > >         struct test_data {
> > >                 int foo_result;
> > > @@ -644,7 +648,7 @@ The example below includes how to implement "mocking":
> > >
> > >         static int fake_foo(int arg)
> > >         {
> > > -               struct kunit *test = current->kunit_test;
> > > +               struct kunit *test = kunit_get_current_test();
> > >                 struct test_data *test_data = test->priv;
> > >
> > >                 KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
> > > @@ -675,7 +679,7 @@ Each test can have multiple resources which have string names providing the same
> > >  flexibility as a ``priv`` member, but also, for example, allowing helper
> > >  functions to create resources without conflicting with each other. It is also
> > >  possible to define a clean up function for each resource, making it easy to
> > > -avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
> > > +avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/resource.rst.
> >
> > Oops, thanks for cleaning this up.
> > I guess I forgot to update this when splitting out resource.rst or my
> > change raced with the rewrite of this file.
> >
> > >
> > >  Failing The Current Test
> > >  ------------------------
> > > @@ -703,3 +707,6 @@ structures as shown below:
> > >         static void my_debug_function(void) { }
> > >         #endif
> > >
> > > +Note that ``kunit_fail_current_test`` requires KUnit be built-in to the kernel, i.e.
> > > +``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
> > > +or no test is currently running, but will do nothing.
> >
> > This is the same wording as above.
> > I think it's clearer since what it's trying to convey is simpler, so
> > it's probably fine.
> >
> > But if we do end up thinking of a good way to reword the previous bit,
> > we might want to reword it here too.
>
> Yeah: I wrote this one first, then copied it above, so that's why this
> one is a bit simpler. If we come up with something better for the
> first one, we can keep it.
>
> _Maybe_ if we moved things to a .. note block, then we could share
> that between both of these sections, though that has its own issues.
