Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD3F825F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2019 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfKKVlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Nov 2019 16:41:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38805 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfKKVlv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Nov 2019 16:41:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so11617301pfp.5
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2019 13:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3he+QtfifQ3bgJ/yyvcxgVo2dz6VZH6CuJDagxiiqO0=;
        b=YK0y7OEXAYek4HKT2x2A9HNewczn8bgLVljRK6e4KmPjx4AqMZIvtBam+zJFOT2l+2
         C2pjfCq8g4vfa4HJoCjQPQhHmsM/kllaeSAjPbCZ5uSdhRnwJtZW8XPxvh+yrj5Y2eVm
         SDfw0p9t4EBgCGs9SaDPGasYcX77jUscvVv7C/u+vELVsmZccSYTOqf7E7nOuIf6kCeg
         u+zr3b4JWLm5EhI/cH/UZhJTJn7MGeE3e+OoBui2rDS2XFhLFQL3aRb4drS+YfW4MAP/
         y2PLKLByUnJK3/wROWHrKpDXCC15u8JV4ZT0+3NnJVYT/yezNGl+cUHhOlsD02L8Lkz5
         grzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3he+QtfifQ3bgJ/yyvcxgVo2dz6VZH6CuJDagxiiqO0=;
        b=d/rP666Jytdi8yBbPZJdHqaGUqKCqtBBDyvpF5mC8ysYnypjjkvDd+q1s2n5+pDLTO
         48P/dj1AsLdfd2hGJbHF3jdPcEUSEbPDCsuCLn1lSUwae7YdM1WIfsF0IRe/Vbc0rCmJ
         075nFZSZj33E/JiBic3IbkdTKyxXX7cFYjhnrXyMv67pV2AhrH+ZFdpF1DfXJBC2h6fe
         aykK3WZqLU/BMWyysiuoCdvxoVzsVPDax68NBfOVh4xkzT5JXDt3W8RdTV58z0WS4LYq
         wR3d49Xy+mwO0qcUWsI0oZmZw2X0YCilamsBvOueaV2z9ZenHr4ft1tg75dsHVlIX2tD
         rukA==
X-Gm-Message-State: APjAAAVVosaEhVACiuRYDDTPMQjJeQ8n1tbKuzBeF9KIrUDPR4vjgCB0
        4RFivhdj6UIXGYs0BR95PGqJkTOC4p7V0gPu86wE/w==
X-Google-Smtp-Source: APXvYqzy/af2x31SqiZ0T4qLxwoFESxbRuTnuVa7dS8IFhRlfQ+werW7nPW6tbVH+2zxkAxDA/t/GlVa72LeUDHx9dI=
X-Received: by 2002:a63:712:: with SMTP id 18mr20831195pgh.384.1573508510293;
 Mon, 11 Nov 2019 13:41:50 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
 <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
 <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com> <alpine.LRH.2.20.1911081520550.24027@dhcp-10-175-178-67.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.1911081520550.24027@dhcp-10-175-178-67.vpn.oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 11 Nov 2019 13:41:38 -0800
Message-ID: <CAFd5g44vYUkLQmJFq_vQ5ruvBC_1vrkSd9DeW3oQ_vLzrNcpgQ@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Stephen Boyd - since he is more of an expert on the hung task timer than I am.

On Fri, Nov 8, 2019 at 7:30 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Thu, 7 Nov 2019, Brendan Higgins wrote:
>
> > On Thu, Oct 17, 2019 at 11:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > Making kunit itself buildable as a module allows for "always-on"
> > > kunit configuration; specifying CONFIG_KUNIT=m means the module
> > > is built but only used when loaded.  Kunit test modules will load
> > > kunit.ko as an implicit dependency, so simply running
> > > "modprobe my-kunit-tests" will load the tests along with the kunit
> > > module and run them.
> > >
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > ---
> > >  lib/kunit/Kconfig     | 2 +-
> > >  lib/kunit/Makefile    | 4 +++-
> > >  lib/kunit/test.c      | 2 ++
> > >  lib/kunit/try-catch.c | 3 +++
> > >  4 files changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > > index 9ebd5e6..065aa16 100644
> > > --- a/lib/kunit/Kconfig
> > > +++ b/lib/kunit/Kconfig
> > > @@ -3,7 +3,7 @@
> > >  #
> > >
> > >  menuconfig KUNIT
> > > -       bool "KUnit - Enable support for unit tests"
> > > +       tristate "KUnit - Enable support for unit tests"
> > >         help
> > >           Enables support for kernel unit tests (KUnit), a lightweight unit
> > >           testing and mocking framework for the Linux kernel. These tests are
> > > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > > index 769d940..8e2635a 100644
> > > --- a/lib/kunit/Makefile
> > > +++ b/lib/kunit/Makefile
> > > @@ -1,4 +1,6 @@
> > > -obj-$(CONFIG_KUNIT) +=                 test.o \
> > > +obj-$(CONFIG_KUNIT) +=                 kunit.o
> > > +
> > > +kunit-objs +=                          test.o \
> > >                                         string-stream.o \
> > >                                         assert.o \
> > >                                         try-catch.o
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index e8b2443..c0ace36 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -523,3 +523,5 @@ void *kunit_find_symbol(const char *sym)
> > >         return ERR_PTR(-ENOENT);
> > >  }
> > >  EXPORT_SYMBOL(kunit_find_symbol);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > > index 1c1e9af..72fc8ed 100644
> > > --- a/lib/kunit/try-catch.c
> > > +++ b/lib/kunit/try-catch.c
> > > @@ -31,6 +31,8 @@ static int kunit_generic_run_threadfn_adapter(void *data)
> > >         complete_and_exit(try_catch->try_completion, 0);
> > >  }
> > >
> > > +KUNIT_VAR_SYMBOL(sysctl_hung_task_timeout_secs, unsigned long);
> >
> > Can you just export sysctl_hung_task_timeout_secs?
> >
> > I don't mean to make you redo all this work for one symbol twice, but
> > I thought we agreed on just exposing this symbol, but in a namespace.
> > It seemed like a good use case for that namespaced exporting thing
> > that Luis was talking about. As I understood it, you would have to
> > export it in the module that defines it, and then use the new
> > MODULE_IMPORT_NS() macro here.
> >
>
> Sure, I can certainly look into that, though I wonder if we should
> consider another possibility - should kunit have its own sysctl table for
> things like configuring timeouts? I can look at adding a patch for that

So on the one hand, yes, I would like to have configurable test
timeouts for KUnit, but that is not what the parameter check is for
here. This is to make sure KUnit times a test case out before the hung
task timer does.

> prior to the module patch so the issues with exporting the hung task
> timeout would go away. Now the reason I suggest this isn't as much a hack
> to solve this specific problem, rather it seems to fit better with the
> longer-term intent expressed by the comment around use of the field (at
> least as I read it, I may be wrong).

Not really. Although I do agree that adding configurability here might
be a good idea, I believe we would need to clamp such a value by
sysctl_hung_task_timeout_secs regardless since we don't want to be
killed by the hung task timer; thus, we still need access to
sysctl_hung_task_timeout_secs either way, and so doing what you are
proposing would be off topic.

> Exporting the symbol does allow us to piggy-back on an existing value, but
> maybe we should support out our own tunable "kunit_timeout_secs" here?
> Doing so would also lay the groundwork for supporting other kunit
> tunables in the future if needed. What do you think?

The goal is not to piggy back on the value as I mentioned above.
Stephen, do you have any thoughts on this? Do you see any other
preferable solution to what Alan is trying to do?

> Many thanks for the review! I've got an updated patchset almost
> ready with the symbol lookup stuff removed; the above is the last issue
> outstanding from my side.

Awesome! No thanks necessary, I appreciate the work you are doing!
There were some other people who mentioned that they wanted this in
the past, so it is a really big help having you do this. I feel bad
that I couldn't get the review back to you faster. :-)

>
> > > +
> > >  static unsigned long kunit_test_timeout(void)
> > >  {
> > >         unsigned long timeout_msecs;
> > > @@ -52,6 +54,7 @@ static unsigned long kunit_test_timeout(void)
> > >          * For more background on this topic, see:
> > >          * https://mike-bland.com/2011/11/01/small-medium-large.html
> > >          */
> > > +       KUNIT_INIT_VAR_SYMBOL(NULL, sysctl_hung_task_timeout_secs);
> > >         if (sysctl_hung_task_timeout_secs) {
> > >                 /*
> > >                  * If sysctl_hung_task is active, just set the timeout to some
> > > --
> > > 1.8.3.1
> > >
> >
