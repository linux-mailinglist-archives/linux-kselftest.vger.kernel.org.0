Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD91C804F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 05:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgEGDIY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 May 2020 23:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGDIY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 May 2020 23:08:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88FAC061A41
        for <linux-kselftest@vger.kernel.org>; Wed,  6 May 2020 20:08:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so4532607wrt.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 May 2020 20:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsgt81MlDlEnto/Qdmhwfg0yKkYAEa0cqpBxi8rVFIU=;
        b=SbDfHNsVlfwga5HlZsXZUndrMHRULtSgVl0BqdUggNtB1qsob5uD0JyX829hO72zkR
         cm/8xweeLd9jJO9m8puEA2KdLib1VQ8BLx8ALUobrhsRbyeEeyjETYOtW5+bFoF5iASD
         ZE4hLHneOrzNo6QZ0kX0rw/CbBvg4b1fGD/G/3feDX49Cpyoi5nam9lIu9+edv+nA5DJ
         aVR9G0FQKBxNogFDiSnECeq6gY1+oJEO2TuLnmCjUul/GzJfl2sMBspUtT4Bq/q3n53X
         TKwTLnjHEybyfrEWSfTE+5M4PQMfS4uyumllO9W/XOePZvv7yo84bDog271sy0t6z9Im
         yJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsgt81MlDlEnto/Qdmhwfg0yKkYAEa0cqpBxi8rVFIU=;
        b=s9/0ZomTZn3ChXZzQdcq6cUU1DIuP4XDf6EFa77p7AaeW708ekKh+zNf80wAw2C7Y1
         LgfHmY7+u0zlrVvZLatspeLA3mOo36SJEcxh5n0PImNf2VIr5u5UXF8o4Tr7PgKA6Qpg
         CuQfJqIPx9uhbtXn4t++1tGJfUbSF2sznNghmGGsM6Lt6JM6jL3E/JN7vb6TGVM9fNjF
         k1sOQC3tK4yAa5tT6R08dvO7+G0XAgryT9Bixf3PXrhGSSbxAX7dM37QzK1PA3VVLu0Y
         RcDNxpTln3lZqlzJ5UEcVsXCID3f5BPWnyzdo5Yesf/eBLG7utulplukTn9mFalUnSMk
         hLXw==
X-Gm-Message-State: AGi0Puan23iJbXY4QGcG2e4cofs1G+daPrq2gp1CoYmdkl9yjMcth2WT
        MizUEdoaRZOt/dtZQaq17fCQbbkZyh99xKdTVpJGtg==
X-Google-Smtp-Source: APiQypJYBc+4MO14/l2sBXNv+eueA8YQH/AYbiQD4bmsfXP2t3f539TUHGl8HMJof9KUOufQG4S/sjUHWHRGOiOP17E=
X-Received: by 2002:adf:fe51:: with SMTP id m17mr12501816wrs.414.1588820901909;
 Wed, 06 May 2020 20:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102700.7912-1-anders.roxell@linaro.org>
 <CABVgOS=awiwi7APWr5HgU6Eht-VAygWPeQyNsCnAF09OLpR46A@mail.gmail.com> <CADYN=9Jdwd=3Rh=wyzO7eOxtyTSm+JqjF385iQjfMocpz1A3YA@mail.gmail.com>
In-Reply-To: <CADYN=9Jdwd=3Rh=wyzO7eOxtyTSm+JqjF385iQjfMocpz1A3YA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 May 2020 11:08:10 +0800
Message-ID: <CABVgOSndkMOd0U+p=fMy0q-KdN29XERheY=3-3+dgVoeWf9m5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 6, 2020 at 6:33 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Hi David,
>
> Thank you for the review.
>
> On Wed, 6 May 2020 at 07:08, David Gow <davidgow@google.com> wrote:
> >
> > On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > Make it easier to enable all KUnit fragments.  This is needed for kernel
> > > test-systems, so its easy to get all KUnit tests enabled and if new gets
> > > added they will be enabled as well.  Fragments that has to be builtin
> > > will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
> > >
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > >  lib/kunit/Kconfig | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > > index 95d12e3d6d95..537f37bc8400 100644
> > > --- a/lib/kunit/Kconfig
> > > +++ b/lib/kunit/Kconfig
> > > @@ -41,4 +41,10 @@ config KUNIT_EXAMPLE_TEST
> > >           is intended for curious hackers who would like to understand how to
> > >           use KUnit for kernel development.
> > >
> > > +config KUNIT_RUN_ALL
> > > +       tristate "KUnit run all test"
> >
> > I'm not 100% sure about this name and description. It only actually
> > "runs" the tests if they're builtin (as modules, they'll only run when
> > loaded).
> >
> > Would KUNIT_BUILD_ALL or KUNIT_ALL_TESTS
>
> I would like to go with KUNIT_ALL_TESTS if no one objects.
>

Personally, I'm fine with that.

Brendan, thoughts?

> > or similar be better?
> >
> > It also, as mentioned, only really runs all available (i.e., with
> > dependencies met in the current .config) tests (as distinct from the
> > --alltests flag to kunit.py, which builds UML with allyesconfig), it
> > might be good to add this to the description or help.
> >
> > Something like "Enable all KUnit tests" or "Enable all available KUnit
> > tests" (or even something about "all KUnit tests with satisfied
> > dependencies") might be clearer.
>
> I like "All KUnit tests with satisfied dependencies".
>
> >
> > > +       help
> > > +         Enables all KUnit tests, if they can be enabled.
> > > +         That depends on if KUnit is enabled as a module or builtin.
> > > +
> > I like the first line here, but the second one could use a bit more
> > explanation. Maybe copy some of the boilerplate text from other tests,
> > e.g.:
> >
> >           KUnit tests run during boot and output the results to the debug log
> >          in TAP format (http://testanything.org/). Only useful for kernel devs
> >          running the KUnit test harness, and not intended for inclusion into a
> >          production build.
> >
> >          For more information on KUnit and unit tests in general please refer
> >          to the KUnit documentation in Documentation/dev-tools/kunit/.
> >
> >          If unsure, say N.
>
> Makes much more sense, thanks.
>
> >
> > >  endif # KUNIT
> > > --
> > > 2.20.1
> > >
> >
> > Otherwise, this is looking good. I've done some quick testing, and it
> > all seems to work for me. As long as it's clear what the difference
> > between this and other ways of running "all tests" (like the
> > --alltests kunit.py option),
>
> Do you think it should be made clearer in some way?
>

I think the changes above should do it.

-- David
