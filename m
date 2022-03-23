Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE44E5C0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 00:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbiCWXxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 19:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbiCWXxH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 19:53:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAD73FD82
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:51:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u26so3689429eda.12
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki2n6Qz/XFIPEOMiE4aANqyu6w6m1Klwn+ORu/krnhM=;
        b=IzZK7Aq+TzUq3EtZ+DoEiDDVUaz99N2AMqhG5DFFxKXnbDEE/G7/AOXa1+qUGXUz2r
         GJ1gYUxTgPhGa6uZqJhOWjNsUO43RS0yZJBk4ka5t7VSgSgVe+Qi0MlX9iCHk0++cNSM
         vQqr/WCOA542elAvDQwEyK6O4cIPjFM8KkNlEjnqZBOFkKfnD7Nj15RsvBsvt8vZINGM
         neMIXCME2yTVZ/EzyFj+2ViIitW0aS7mmbaJpF7HkcBOSbq6w19JPa/f9+cPu5GVi4mN
         bZ/en89/of+2pOtWluF73BKiNWGwqoZPbuHTHAUyaNQmwM9KVcE46msF9886C2Y6cTc7
         77GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki2n6Qz/XFIPEOMiE4aANqyu6w6m1Klwn+ORu/krnhM=;
        b=ymLb1eP2UDIW1iMRDZsS912Gr6U9HGGcXqIp/UtSTNGoBUwAl15LHKg5wr6G/c7hP2
         rbkqSQA6eFTAwdWvV5ge7LQ6KRI2S9CaiiL4QHnrgjQC9YoF+3HEfCLKGbwmPuEoLZ3F
         VjJNvY2KJ8bJPhXLd2Gp+eHgGYl4zIi7MQ3e0+p0l9qHWGCOX6sIjZcR3KlUBaz65tSx
         vL4kD076nGaO7H2quICUWJRV6dPypAl9UPSP2BtATWIN0OR1Pk9i0x8fhaHul37KpP1n
         dYjWxvG2sEUwMfyNzYlSKTxvc7/J7m2343sQAk5Q/Wl0AJaHl7T0kNtBVuQ4dkVlgLiL
         ebLg==
X-Gm-Message-State: AOAM531/XuaHG4k0lM1Qdoa5zXUUrf2/CIdQidz7c3aVxkYznZqTLevl
        BrJtqsnKZC05Dssdyf/t3VmItgyIEVFIoZjORh7LgQ==
X-Google-Smtp-Source: ABdhPJxJO0tJfgmmO8q/dSudHVU9Akr8p72LdVK3FTiwSJpBPn/aZV4HmNCS8Gc5Og/2ztcGYnRuH3m2AJsFcaZVUgk=
X-Received: by 2002:a05:6402:4388:b0:419:443d:b4e9 with SMTP id
 o8-20020a056402438800b00419443db4e9mr3409290edc.149.1648079494776; Wed, 23
 Mar 2022 16:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220316024432.1454366-1-dlatypov@google.com> <CABVgOSkvmuiHfG11VRsQhigOLw_-5HYWjJrQrA4Vy18MvUpW9w@mail.gmail.com>
 <CAGS_qxpCoyr0_xpRVpjMwAALn49iShGAs-MuBrYHwrEJhKcZUA@mail.gmail.com>
In-Reply-To: <CAGS_qxpCoyr0_xpRVpjMwAALn49iShGAs-MuBrYHwrEJhKcZUA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:51:23 -0400
Message-ID: <CAFd5g46N6kbcknJxAug3nkEqe5Q+UuqYAfh8AhPkfPzeQFX8PA@mail.gmail.com>
Subject: Re: [PATCH] kunit: split resource API from test.h into new resource.h
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Wed, Mar 16, 2022 at 12:19 PM 'Daniel Latypov' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Wed, Mar 16, 2022 at 12:41 AM David Gow <davidgow@google.com> wrote:
> >
> > On Wed, Mar 16, 2022 at 10:44 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > Background:
> > > Currently, a reader looking at kunit/test.h will find the file is quite
> > > long, and the first meaty comment is a doc comment about struct
> > > kunit_resource.
> > >
> > > Most users will not ever use the KUnit resource API directly.
> > > They'll use kunit_kmalloc() and friends, or decide it's simpler to do
> > > cleanups via labels (it often can be) instead of figuring out how to use
> > > the API.
> > >
> >
> > A depressing (but probably not untrue) thought. I think that, even if
>
> I'm not sure it's that depressing.
> Without some compiler support (e.g. GCC's `cleanup`), I can see there
> being a number of one-off things that don't warrant formalizing into a
> resource.
>
> More detail:
> It works OK when there's one pointer parameter, e.g. [1], but I feel
> like you'd normally need to capture at least one more local variable.
> So then you need to define a new struct to hold all the values, which
> is where I'd draw the line personally.
>
> [1] https://elixir.bootlin.com/linux/v5.17-rc8/source/lib/kunit/executor_test.c#L182
>
> > most people were to use the resource API, having it in test.h makes it
> > harder, as having the resource functions separate makes it easier to
> > understand as well.
> >
> > > It's also logically separate from everything else in test.h.
> > > Removing it from the file doesn't cause any compilation errors (since
> > > struct kunit has `struct list_head resources` to store them).
> > >
> > > This commit:
> > > Let's move it into a kunit/resource.h file and give it a separate page
> > > in the docs, kunit/api/resource.rst.
> >
> > Yay! This makes a lot of sense to me, as I've wasted a lot of time
> > scrolling through test.h.
> >
> > >
> > > We include resource.h at the bottom of test.h since
> > > * don't want to force existing users to add a new include if they use the API
> > > * it accesses `lock` inside `struct kunit` in a inline func
> > >   * so we can't just forward declare, and the alternatives require
> > >     uninlining the func, adding hepers to lock/unlock, or other more
> > >     invasive changes.
> >
> > I don't like this, but still think it's an improvement on what we have
> > now. Ultimately, I think adding helpers to lock/unlock or similar and
>
> Yes, I can see us maybe needing this in the future.
> Right now, outside of test.c, there's only one callsite for each (in
> resource.h).

Another alternative workaround is to split even more stuff out into
other header files.

Personally I would prefer not to wrap the lock/unlock functions; I
like seeing the kind of locking that's happening. Plus, such a helper
would be pretty gross:

void kunit_lock(struct kunit *test, unsigned long* flags) {...}

It wouldn't actually clean up the call site, just facilitate breaking
out code into a header.

> > making users include this separately is probably the right thing to
> > do, as nesting the headers like this is a bit ugly, but I won't lose
> > sleep over leaving it till later.
>
> Ack, I can add a TODO to indicate we want to clean this up?

I am fine with this.

> It's a bit annoying right now, but it'll only get more annoying in the future.
>
> >
> > >
> > > Now the first big comment in test.h is about kunit_case, which is a lot
> > > more relevant to what a new user wants to know.
> > >
> > > A side effect of this is git blame won't properly track history by
> > > default, users need to run
> > > $ git blame -L ,1 -C17 include/kunit/resource.h
> >
> > This is a pain, but is probably worth it. Thanks for including the
> > command in the commit message, which should mitigate it slightly.
> >
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > This was starting to annoy me, too, as it was a pain to read through
> > everything in test.h. It'll be a bit of short-term pain,
> > merge-conflict wise if we have other changes to the resource system
> > (which I fear is likely), but is worth it.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > -- David
> >
> > >
> > > NOTE: this file doesn't split out code from test.c to a new resource.c
> > > file.
> > > I'm primarily concerned with users trying to read the headers, so I
> > > didn't think messing up git blame (w/ default settings) was worth it.
> > > But I can make that change if it feels appropriate (it might also be
> > > messier).
> >
> > Personally, I think it's probably worth splitting this out as well.
> > And the sooner we do it, the less history we'll obscure. :-)
>
> Yeah, that was my thought.
> But if you think this would help users, then I think we have a case to
> make this change.
>
> Should I send a v2 with resource.c split out?
> Brendan (and any others who have an opinion), what's your preference?

I personally don't think test.c is so huge that it is a problem to
understand, but I can see it getting there.

If it's going to happen, sooner is probably better.

> >
> > But I agree, it's less of an issue as it only directly affects people
> > working on KUnit itself. Though making it easier for users to find and
> > read the implementation of these functions could help them understand
> > API "gotchas", so I think it's worthwhile.
> >
> > >
> > > ---
> > >  Documentation/dev-tools/kunit/api/index.rst   |   5 +
> > >  .../dev-tools/kunit/api/resource.rst          |  13 +
> > >  include/kunit/resource.h                      | 319 ++++++++++++++++++
> > >  include/kunit/test.h                          | 301 +----------------
> > >  4 files changed, 339 insertions(+), 299 deletions(-)
> > >  create mode 100644 Documentation/dev-tools/kunit/api/resource.rst
> > >  create mode 100644 include/kunit/resource.h
> > >
> > <...snip...>
