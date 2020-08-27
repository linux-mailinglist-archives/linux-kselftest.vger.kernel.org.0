Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C352254D0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Aug 2020 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgH0S2T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgH0S2Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 14:28:16 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00890C06121B
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 11:28:15 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id y30so1452776ooj.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxlbWvka+07kHZPf01+EUiW1alBItC8Pr3Tn8LbFklQ=;
        b=peXan55M41airQcwalxfGsmf4nrB+F5Ll5GMwX64kU3Vo+5HB9b0f6CVxw1o5JIs3q
         qZ1b9XUIpYjcqMCSHU5FYiwzFopbgLt5b5goPNP3CJiLS26g40+KVQQHRs19X8ec+wXI
         Xvr5EvMmOs1yZkUPeL/kQlKWiXmXba5jtBQAySYJNjc4Rm/i1YZoaPMdb2vMwvr+/FTw
         x0tessMx4QzIUMHJHQ+JdDglMcj79qIbKsnVSgvYulpOR68h2/iijrZIV/E9/izUpTwq
         CUOXq35T8mtWgQFiElp3fpAP2sfUGIMa427iA9whE8zHrop8cZewgZmKWf2O3h3R4MSx
         vtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxlbWvka+07kHZPf01+EUiW1alBItC8Pr3Tn8LbFklQ=;
        b=nPxxZLnT+Egn0mzTWSdkjD2RuZCiBWxdZ+D84/3nb+Aj3amgIiKrIFRNUo11U+4ej9
         m0q4YiF8JdGoapE1e/857XQBEGB8PlMVRFKtyewOhPDaB9CHmidka0az1ZFywbH5LFVa
         gcUb5SLTVm+29k+b6CGpF423F4symQkKxnl3FyqpPP7Cm1543iqdFGriJttyrczHZsXM
         v4M2PjdLG/nOp+U4lfBA3LhlNm5xlzPSvGRssc7DQKdK7lPnKK1eqz9szLdGRk6HHH0E
         ORRtBehnSisDT8MS8GxjR4IQnGf5j4SPFC5RfRvjoqtzIvr0g5KqEFtyB7PshxDFFIu5
         Ur+g==
X-Gm-Message-State: AOAM532b8p/WlNH89hg+/EWbdltCHVfzAE2WOPxgyKKRVcZ95+QEGX92
        B2f21jwqTjgEXmfjDU9vV/hwbeqb0Mzb3rXtq8gjkw==
X-Google-Smtp-Source: ABdhPJyZof+lv2Rdb068ddJIG0Fuq/ptEYfL7PHggKV923EZOQ/WvcqDXzxtwSckF1WY8r2ySti4FCh5wtjONGhRl3g=
X-Received: by 2002:a05:6820:24c:: with SMTP id b12mr15207106ooe.36.1598552894223;
 Thu, 27 Aug 2020 11:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200702071416.1780522-1-davidgow@google.com> <20200827131438.GA3597431@elver.google.com>
 <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
In-Reply-To: <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 27 Aug 2020 20:28:03 +0200
Message-ID: <CANpmjNP0mGdEEFj5u-Crsvj0iaWvnt3OS+ioJNeZNjg=s0kpLQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 27 Aug 2020 at 18:17, David Gow <davidgow@google.com> wrote:
[...]
> > First of all, thanks for the talk yesterday! I only looked at this
> > because somebody pasted the LKML link. :-)
>
> No worries! Clearly this document needed linking -- even I was
> starting to suspect the reason no-one was complaining about this was
> that no-one had read it. :-)
[...]
> >
> > While I guess this ship has sailed, and *_kunit.c is the naming
> > convention now, I hope this is still just a recommendation and names of
> > the form *-test.c are not banned!
>
> The ship hasn't technically sailed until this patch is actually
> accepted. Thus far, we hadn't had any real complaints about the
> _kunit.c idea, though that may have been due to this email not
> reaching enough people. If you haven't read the discussion in
> https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
> it's worthwhile: the _kunit.c name is discussed, and Kees lays out
> some more detailed rationale for it as well.

Thanks, I can see the rationale. AFAIK the main concern was "it does
not distinguish it from other tests".

> > $> git grep 'KUNIT.*-test.o'
> >         drivers/base/power/Makefile:obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
> >         drivers/base/test/Makefile:obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
> >         fs/ext4/Makefile:obj-$(CONFIG_EXT4_KUNIT_TESTS)         += ext4-inode-test.o
> >         kernel/Makefile:obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
> >         lib/Makefile:obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> >         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=          kunit-test.o
> >         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=          string-stream-test.o
> >         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=  kunit-example-test.o
> >
> > $> git grep 'KUNIT.*_kunit.o'
> > # Returns nothing
> >
>
> This was definitely something we noted. Part of the goal of having
> _kunit.c as a filename suffix (and, perhaps more importantly, the
> _kunit module name suffix) was to have a way of both distinguishing
> KUnit tests from non-KUnit ones (of which there are quite a few
> already with -test names), and to have a way of quickly determining
> what modules contain KUnit tests. That really only works if everyone
> is using it, so the plan was to push this as much as possible. This'd
> probably include renaming most of the existing test files to match,
> which is a bit of a pain (particularly when converting non-KUnit tests
> to KUnit and similar), but is a one-time thing.

Feel free to ignore the below, but here might be one concern:

I think the problem of distinguishing KUnit tests from non-KUnit tests
is a technical problem (in fact, the Kconfig entries have all the info
we need), but a solution that sacrifices readability might cause
unnecessary friction.

The main issue I foresee is that the _kunit.c name is opaque as to
what the file does, but merely indicates one of its dependencies. Most
of us clearly know that KUnit is a test framework, but it's a level of
indirection nevertheless. (But _kunit_test.c is also bad, because it's
unnecessarily long.) For a dozen tests, that's probably still fine.
But now imagine 100s of tests, people will quickly wonder "what's this
_kunit thing?". And if KUnit tests are eventually the dominant tests,
does it still matter?

I worry that because of the difficulty of enforcing the name, choosing
something unintuitive will also achieve the opposite result:
proliferation of even more diverse names. A generic convention like
"*-test.c" will be close enough to what's intuitive for most people,
and we might actually have a chance of getting everyone to stick to
it.

The problem of identifying all KUnit tests can be solved with a script.

> > Just an idea: Maybe the names are also an opportunity to distinguish
> > real _unit_ style tests and then the rarer integration-style tests. I
> > personally prefer using the more generic *-test.c, at least for the
> > integration-style tests I've been working on (KUnit is still incredibly
> > valuable for integration-style tests, because otherwise I'd have to roll
> > my own poor-man's version of KUnit, so thank you!). Using *_kunit.c for
> > such tests is unintuitive, because the word "unit" hints at "unit tests"
> > -- and having descriptive (and not misleading) filenames is still
> > important. So I hope you won't mind if *-test.c are still used where
> > appropriate.
>
> As Brendan alluded to in the talk, the popularity of KUnit for these
> integration-style tests came as something of a surprise (more due to
> our lack of imagination than anything else, I suspect). It's great
> that it's working, though: I don't think anyone wants the world filled
> with more single-use test "frameworks" than is necessary!
>
> I guess the interesting thing to note is that we've to date not really
> made a distinction between KUnit the framework and the suite of all
> KUnit tests. Maybe having a separate file/module naming scheme could
> be a way of making that distinction, though it'd really only appear
> when loading tests as modules -- there'd be no indication in e.g.,
> suite names or test results. The more obvious solution to me (at
> least, based on the current proposal) would be to have "integration"
> or similar be part of the suite name (and hence the filename, so
> _integration_kunit.c or similar), though even I admit that that's much
> uglier.

Yeah, that's not great either.  Again, in the end it's probably
entirely up to you, but it'd be good if the filenames are descriptive
and readable (vs. a puzzle).

> Maybe the idea of having the subsystem/suite distinction be
> represented in the code could pave the way to having different suites
> support different suffixes like that.

> Do you know of any cases where something has/would have both
> unit-style tests and integration-style tests built with KUnit where
> the distinction needs to be clear?

None I know of, so probably not a big deal.

> Brendan, Kees: do you have any thoughts?
>

> Cheers,
> -- David

Thanks,
-- Marco
