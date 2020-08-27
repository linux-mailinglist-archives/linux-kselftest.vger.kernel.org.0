Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3D25444C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Aug 2020 13:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgH0L3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgH0LQi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 07:16:38 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009CC06121B
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 03:54:31 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y134so2715767yby.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kL50AETAxFQ/Z0PEcxjtY/mje72xQ1KRsR0dYMPRn0c=;
        b=K6Cc/U/vzKW4aV2SdSpKnLr1XjzAN1/VEe0yjjqGP3KsKhratD7w7onOLADM18p/Qs
         AcGr9a1+s5Q7xa5Opw8DuDF/ohYNjtntk4ddMwwhWH0EWIckOG8814MLnXDsf6VVw3oJ
         uQ08O9VvQWDytcc2Msrf4hcSDGA1xGcEohd9UfQ8oHMeCFl7SMwRpi/Gbv5/TXcjCyL7
         Q3Sd/ItaMD3/1kENtjVpfSpfaBIwFE80iGsGwJkZRidMiEeqGY4KFrN3VJNdS3hwvHcT
         rwqmRSMs2cp0fcQBUyAprlc0Ry+xBeTo/mS1kmWmDqkB/nZpb9HFDXyWjd3lBUAriq7+
         QD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kL50AETAxFQ/Z0PEcxjtY/mje72xQ1KRsR0dYMPRn0c=;
        b=UcwmM8VkFO9VEYKTJLW5SncldYqSiMys90Cms449yL6SQ7EQSFIBU5MJt6N8PX8h6r
         AIPG+vuO15lpvm1p8IY+B78aSWAX8Tf6ihF8nE4xEiOHKCphssTxv7slYG6KKjFGIjeZ
         JOS22HUmxeaFe3kSvmyQOVsB3p6r5XttWdFhJwAwIrpAsV16+irgKeN2IiOXIzhucmCA
         GeAN0hnRNCA7efmveoo2qPihNCnK/teepJXcJijbApcvssZAI9L+6NwNAVw7/imLSW6L
         yjkobWydSOi2FFQQPy+M7RBw96EfvD/QmCe9GOPMyDn4pR39Wm9xEbXFqA4oktdTzvbw
         YRwQ==
X-Gm-Message-State: AOAM532NqEd7X1UpkV6t6wEqZYVYRHOBbk8ckzww4ux2ZtCjBCi7U7wD
        gaaLWMam9z0X3A6G75QkYqrUXVYpL8wRocXs+d4RAQ==
X-Google-Smtp-Source: ABdhPJxVB9AdgiqMEazYyTVnGYST+nW3/Chayz5MJ7mUKthRW3swWaa3QBpMH158AtV1ihmZErHV2SAtA9bYT3wjE3E=
X-Received: by 2002:a25:f42:: with SMTP id 63mr28803335ybp.348.1598525669597;
 Thu, 27 Aug 2020 03:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200729192357.477350-1-vitor@massaru.org> <20200827102333.GA3564678@elver.google.com>
In-Reply-To: <20200827102333.GA3564678@elver.google.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 27 Aug 2020 07:53:53 -0300
Message-ID: <CADQ6JjVzx=kPsF4Lcek1HtGU7bGW3H62UoN0XDUHDrTxKt3FVg@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add list_sort test conversion to KUnit
To:     Marco Elver <elver@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        geert@linux-m68k.org, paul.gortmaker@windriver.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        arnd@arndb.de, elfring@users.sourceforge.net, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 27, 2020 at 7:23 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, Jul 29, 2020 at 04:23PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of test_list_sort,
> > from `lib/test_list_sort.c` to KUnit tests.
> >
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
> >
> > Code Style Documentation: [0]
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
> > ---
> >  lib/Kconfig.debug                           | 29 +++++---
> >  lib/Makefile                                |  2 +-
> >  lib/{test_list_sort.c => list_sort_kunit.c} | 73 +++++++++++----------
> >  3 files changed, 58 insertions(+), 46 deletions(-)
> >  rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 9ad9210d70a1..de4fd020a4af 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1854,16 +1854,6 @@ config LKDTM
> >       Documentation on how to use the module can be found in
> >       Documentation/fault-injection/provoke-crashes.rst
> >
> > -config TEST_LIST_SORT
> > -     tristate "Linked list sorting test"
> > -     depends on DEBUG_KERNEL || m
> > -     help
> > -       Enable this to turn on 'list_sort()' function test. This test is
> > -       executed only once during system boot (so affects only boot time),
> > -       or at module load time.
> > -
> > -       If unsure, say N.
> > -
> >  config TEST_MIN_HEAP
> >       tristate "Min heap test"
> >       depends on DEBUG_KERNEL || m
> > @@ -2173,6 +2163,25 @@ config LIST_KUNIT_TEST
> >
> >         If unsure, say N.
> >
> > +config LIST_SORT_KUNIT
> > +     tristate "KUnit Linked list sorting test"
> > +     depends on KUNIT
> > +     depends on DEBUG_KERNEL || m
>
> I think the style [0] you linked suggests '*_KUNIT_TEST' for config
> variables.
>
> Only noticed this because I was doing a
>
>         git grep 'config.*TEST'
>
> to find tests in the kernel + new tests floating on the LKML.

Thanks, I'll fix it.

>
> Apologies for picking this patch to comment on, but if it's still
> changeable it might be worth adjusting.

No problem.


> > +     help
> > +       Enable this to turn on 'list_sort()' function test. This test is
> > +       executed only once during system boot (so affects only boot time),
> > +       or at module load time.
> > +
> > +          KUnit tests run during boot and output the results to the debug log
> > +       in TAP format (http://testanything.org/). Only useful for kernel devs
> > +       running the KUnit test harness, and not intended for inclusion into a
> > +       production build.
>
> Not a big deal, but I'm not sure if summarizing KUnit here is useful.
> You already link to the documentation below.

Sure, I'll remove this.

> > +       For more information on KUnit and unit tests in general please refer
> > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> ...
>
> Thanks,
> -- Marco

Thanks for the review.
