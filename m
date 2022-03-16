Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB444DB5F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiCPQUm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiCPQUl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 12:20:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E7E32ECB
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 09:19:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a8so5269211ejc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9R+r1ohG1xCnpzC1qrsRmiSwShPkfg0ZOVxajhsdBXQ=;
        b=qi9FqeLpLieqgQ59FaHOoa+yZmTX88lHcN3nvMY9vttgnNQqJJFXReFu54ETu5sZhG
         ol+10DgD84IYFTcb6bqne0P4eM47tjCOXAFSakQRAMKrLnZ0JcLIVD9d6JTKAUlOqQxC
         i4H4ax9AxxtyaSAgVGLgmqLDVbV0d2ZgeFqYeYX4BsqoQtbbE7wZtXvcKEZO1gJletKa
         BUEsCy8Y10vn5Y21uOm4eV2GcQCMoMGAuT84ujf6vEq5pWjBlUobUwBaROrHHwWt/iIt
         GlDlteycpbqQSDQL31WqLIHl5cqYeZnoVPDjwp3ZXGvwFrFEs9kEQ9sWL3jxykiYAPsx
         7wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9R+r1ohG1xCnpzC1qrsRmiSwShPkfg0ZOVxajhsdBXQ=;
        b=vjoMNSG0Vkvkc26ub8BCFCzQbAZQE6UKY+8K6GUGfQpcLOvovAxXK8zBMV7+C7hxSE
         B7CGDbdVwhOkbtKWeM+TpWsEJ37CwV5rAIEw+ipY3SZP49DQcbQNPfipycyJDy7VUarW
         kffEpXYhPUOAPHP5Pa7VQYqqD9r8T3mNqiTQ6NP3CguBUROsx0KAkH6v62PTmKQ8sv7t
         a2TiiE5wEiMTaDfiZ+n2QPHg7m41RHboLJkuzXNDqYOF+QNct4LLjS/VqQzMMnE24LKL
         T7DuKgHrYJ1iMs4aOY7GpCOWCyM7bOjHrEJ3EkDOORU731/qxedDBgWa3b6r94JZO2TP
         gwFA==
X-Gm-Message-State: AOAM532FvE8DrzrGN38jmO76Hig0FfSpzjsgmdU8oOoq0XTK8PjYwdD/
        pAfRErupEbtEPe4necE2AR24VBCBGgNmV7LXpy6c8Q==
X-Google-Smtp-Source: ABdhPJzkyHYoHaQHM8GNWqhExHqyYScznfMyfLqJcNZrFrej94rfPlOBntdNphvEe68f7Vztb+3Wp8jOrmKfnkef6sU=
X-Received: by 2002:a17:907:1609:b0:6db:b385:d13b with SMTP id
 hb9-20020a170907160900b006dbb385d13bmr608694ejc.542.1647447554142; Wed, 16
 Mar 2022 09:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220316024432.1454366-1-dlatypov@google.com> <CABVgOSkvmuiHfG11VRsQhigOLw_-5HYWjJrQrA4Vy18MvUpW9w@mail.gmail.com>
In-Reply-To: <CABVgOSkvmuiHfG11VRsQhigOLw_-5HYWjJrQrA4Vy18MvUpW9w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 16 Mar 2022 11:19:02 -0500
Message-ID: <CAGS_qxpCoyr0_xpRVpjMwAALn49iShGAs-MuBrYHwrEJhKcZUA@mail.gmail.com>
Subject: Re: [PATCH] kunit: split resource API from test.h into new resource.h
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
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

On Wed, Mar 16, 2022 at 12:41 AM David Gow <davidgow@google.com> wrote:
>
> On Wed, Mar 16, 2022 at 10:44 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Background:
> > Currently, a reader looking at kunit/test.h will find the file is quite
> > long, and the first meaty comment is a doc comment about struct
> > kunit_resource.
> >
> > Most users will not ever use the KUnit resource API directly.
> > They'll use kunit_kmalloc() and friends, or decide it's simpler to do
> > cleanups via labels (it often can be) instead of figuring out how to use
> > the API.
> >
>
> A depressing (but probably not untrue) thought. I think that, even if

I'm not sure it's that depressing.
Without some compiler support (e.g. GCC's `cleanup`), I can see there
being a number of one-off things that don't warrant formalizing into a
resource.

More detail:
It works OK when there's one pointer parameter, e.g. [1], but I feel
like you'd normally need to capture at least one more local variable.
So then you need to define a new struct to hold all the values, which
is where I'd draw the line personally.

[1] https://elixir.bootlin.com/linux/v5.17-rc8/source/lib/kunit/executor_test.c#L182

> most people were to use the resource API, having it in test.h makes it
> harder, as having the resource functions separate makes it easier to
> understand as well.
>
> > It's also logically separate from everything else in test.h.
> > Removing it from the file doesn't cause any compilation errors (since
> > struct kunit has `struct list_head resources` to store them).
> >
> > This commit:
> > Let's move it into a kunit/resource.h file and give it a separate page
> > in the docs, kunit/api/resource.rst.
>
> Yay! This makes a lot of sense to me, as I've wasted a lot of time
> scrolling through test.h.
>
> >
> > We include resource.h at the bottom of test.h since
> > * don't want to force existing users to add a new include if they use the API
> > * it accesses `lock` inside `struct kunit` in a inline func
> >   * so we can't just forward declare, and the alternatives require
> >     uninlining the func, adding hepers to lock/unlock, or other more
> >     invasive changes.
>
> I don't like this, but still think it's an improvement on what we have
> now. Ultimately, I think adding helpers to lock/unlock or similar and

Yes, I can see us maybe needing this in the future.
Right now, outside of test.c, there's only one callsite for each (in
resource.h).

> making users include this separately is probably the right thing to
> do, as nesting the headers like this is a bit ugly, but I won't lose
> sleep over leaving it till later.

Ack, I can add a TODO to indicate we want to clean this up?
It's a bit annoying right now, but it'll only get more annoying in the future.

>
> >
> > Now the first big comment in test.h is about kunit_case, which is a lot
> > more relevant to what a new user wants to know.
> >
> > A side effect of this is git blame won't properly track history by
> > default, users need to run
> > $ git blame -L ,1 -C17 include/kunit/resource.h
>
> This is a pain, but is probably worth it. Thanks for including the
> command in the commit message, which should mitigate it slightly.
>
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This was starting to annoy me, too, as it was a pain to read through
> everything in test.h. It'll be a bit of short-term pain,
> merge-conflict wise if we have other changes to the resource system
> (which I fear is likely), but is worth it.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> -- David
>
> >
> > NOTE: this file doesn't split out code from test.c to a new resource.c
> > file.
> > I'm primarily concerned with users trying to read the headers, so I
> > didn't think messing up git blame (w/ default settings) was worth it.
> > But I can make that change if it feels appropriate (it might also be
> > messier).
>
> Personally, I think it's probably worth splitting this out as well.
> And the sooner we do it, the less history we'll obscure. :-)

Yeah, that was my thought.
But if you think this would help users, then I think we have a case to
make this change.

Should I send a v2 with resource.c split out?
Brendan (and any others who have an opinion), what's your preference?
>
> But I agree, it's less of an issue as it only directly affects people
> working on KUnit itself. Though making it easier for users to find and
> read the implementation of these functions could help them understand
> API "gotchas", so I think it's worthwhile.
>
> >
> > ---
> >  Documentation/dev-tools/kunit/api/index.rst   |   5 +
> >  .../dev-tools/kunit/api/resource.rst          |  13 +
> >  include/kunit/resource.h                      | 319 ++++++++++++++++++
> >  include/kunit/test.h                          | 301 +----------------
> >  4 files changed, 339 insertions(+), 299 deletions(-)
> >  create mode 100644 Documentation/dev-tools/kunit/api/resource.rst
> >  create mode 100644 include/kunit/resource.h
> >
> <...snip...>
