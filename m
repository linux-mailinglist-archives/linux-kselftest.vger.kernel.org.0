Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A61254A66
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Aug 2020 18:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH0QRw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgH0QRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00051C06121B
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 09:17:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r15so5906127wrp.13
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1R0Eitpm/wfF2mpTHMtEGL35ys7GJDbdS2QGVwDMQI=;
        b=S9yZaO9q3OFbVJleiK2Lh0XJ3wXSbGHd69Y/+rl97Fa0Z20UtiJhzev7aCitAAbWlh
         qh1SqYNN1tMyiXZZpkw2Va+DOgeq0gwkIk9h3M8w8QP0Cmd6TeogGYUzAgNZ9DlPHvsd
         WMSxAIZw/Jaz3vnLCwUzuO2OviaJdPNAUl1sJ7bAsorY5S6p4j7wkf7oj5qcVeudCAJU
         2jGIpAQ7dJ7h3XMGOcYdaDp5gXrWltzsnVid+8kzrLqDQ6deoG9CHVEZJpkN5hGwYJqJ
         dwAzH2WK23C4V4Ctd2lTTfTIq4nnt69tsE1+Dy5ZzJljKbE/8PwSx6hJfiZSZDjO82fG
         ir0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1R0Eitpm/wfF2mpTHMtEGL35ys7GJDbdS2QGVwDMQI=;
        b=Mf255HXRt9LfFJohuU0k4XnfLGadVFtbFa7TkPIdAVZqr91cndktBPEGdkPKF9riRj
         k9ge9AXxYpSMAZOv5PBOFISS59rQLMxNbPp+GWgEsqqRU8vht826P0XsmhzN3+W9qCUk
         +nZuvLvueWUZOyIEnT/+6Mw9K1i2JNdCS24jvbRnfPZq0DIYzXuCvh67VDEGPLq1xqEt
         k2hcDmuEmubyKr9tXNY5ZMf2QFV5HyrvJ8zRbofugRjzOdx8rYgpqJILpijiv+pGpYVP
         f/A45Tknqv0xGrwip4wCBFAlZQGC1tB1U1IRsQ3QmNrR0bNVezA/e2ZmhCbJXhGfGQla
         /xCA==
X-Gm-Message-State: AOAM530D5KbvAK9uQmkui8+CaNw6blMzrMumBUyIfgNKsYik5i/OYAwg
        Sf1CCfb1kdypTrAEkVPpCLtS7tcka3DACacDGa1SoQ==
X-Google-Smtp-Source: ABdhPJz+qS2IlmoSQerSgtkhmdhPyC7fKeZC2vUG4R/ZcSpRjX9T1O4Frk+oWtBfj/bPoeFDP68P9DgICyjYHlGo/Yo=
X-Received: by 2002:adf:ba05:: with SMTP id o5mr20964356wrg.7.1598545040079;
 Thu, 27 Aug 2020 09:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200702071416.1780522-1-davidgow@google.com> <20200827131438.GA3597431@elver.google.com>
In-Reply-To: <20200827131438.GA3597431@elver.google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 28 Aug 2020 00:17:05 +0800
Message-ID: <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     Marco Elver <elver@google.com>
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

On Thu, Aug 27, 2020 at 9:14 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Jul 02, 2020 at 12:14AM -0700, David Gow wrote:
> > As discussed in [1], KUnit tests have hitherto not had a particularly
> > consistent naming scheme. This adds documentation outlining how tests
> > and test suites should be named, including how those names should be
> > used in Kconfig entries and filenames.
> >
> > [1]:
> > https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> ...
> > +An example Kconfig entry:
> > +
> > +.. code-block:: none
> > +
> > +        config FOO_KUNIT_TEST
> > +                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
> > +                depends on KUNIT
> > +                default KUNIT_ALL_TESTS
> > +                help
> > +                    This builds unit tests for foo.
> > +
> > +                    For more information on KUnit and unit tests in general, please refer
> > +                    to the KUnit documentation in Documentation/dev-tools/kunit
> > +
> > +                    If unsure, say N
> > +
> > +
> > +Test Filenames
> > +==============
> > +
> > +Where possible, test suites should be placed in a separate source file in the
> > +same directory as the code being tested.
> > +
> > +This file should be named ``<suite>_kunit.c``. It may make sense to strip
> > +excessive namespacing from the source filename (e.g., ``firmware_kunit.c`` instead of
> > +``<drivername>_firmware.c``), but please ensure the module name does contain the
> > +full suite name.
>
> First of all, thanks for the talk yesterday! I only looked at this
> because somebody pasted the LKML link. :-)

No worries! Clearly this document needed linking -- even I was
starting to suspect the reason no-one was complaining about this was
that no-one had read it. :-)

> The example about excessive namespacing seems confusing. Was it supposed
> to be
>
>         [...] firmware_kunit.c`` instead of ``<drivername>_firmware_kunit.c [...]
>
> ?

Whoops, yes. I'll fix that.

>
> While I guess this ship has sailed, and *_kunit.c is the naming
> convention now, I hope this is still just a recommendation and names of
> the form *-test.c are not banned!

The ship hasn't technically sailed until this patch is actually
accepted. Thus far, we hadn't had any real complaints about the
_kunit.c idea, though that may have been due to this email not
reaching enough people. If you haven't read the discussion in
https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
it's worthwhile: the _kunit.c name is discussed, and Kees lays out
some more detailed rationale for it as well.

> $> git grep 'KUNIT.*-test.o'
>         drivers/base/power/Makefile:obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
>         drivers/base/test/Makefile:obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
>         fs/ext4/Makefile:obj-$(CONFIG_EXT4_KUNIT_TESTS)         += ext4-inode-test.o
>         kernel/Makefile:obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
>         lib/Makefile:obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=          kunit-test.o
>         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_TEST) +=          string-stream-test.o
>         lib/kunit/Makefile:obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=  kunit-example-test.o
>
> $> git grep 'KUNIT.*_kunit.o'
> # Returns nothing
>

This was definitely something we noted. Part of the goal of having
_kunit.c as a filename suffix (and, perhaps more importantly, the
_kunit module name suffix) was to have a way of both distinguishing
KUnit tests from non-KUnit ones (of which there are quite a few
already with -test names), and to have a way of quickly determining
what modules contain KUnit tests. That really only works if everyone
is using it, so the plan was to push this as much as possible. This'd
probably include renaming most of the existing test files to match,
which is a bit of a pain (particularly when converting non-KUnit tests
to KUnit and similar), but is a one-time thing.

>
> Just an idea: Maybe the names are also an opportunity to distinguish
> real _unit_ style tests and then the rarer integration-style tests. I
> personally prefer using the more generic *-test.c, at least for the
> integration-style tests I've been working on (KUnit is still incredibly
> valuable for integration-style tests, because otherwise I'd have to roll
> my own poor-man's version of KUnit, so thank you!). Using *_kunit.c for
> such tests is unintuitive, because the word "unit" hints at "unit tests"
> -- and having descriptive (and not misleading) filenames is still
> important. So I hope you won't mind if *-test.c are still used where
> appropriate.

As Brendan alluded to in the talk, the popularity of KUnit for these
integration-style tests came as something of a surprise (more due to
our lack of imagination than anything else, I suspect). It's great
that it's working, though: I don't think anyone wants the world filled
with more single-use test "frameworks" than is necessary!

I guess the interesting thing to note is that we've to date not really
made a distinction between KUnit the framework and the suite of all
KUnit tests. Maybe having a separate file/module naming scheme could
be a way of making that distinction, though it'd really only appear
when loading tests as modules -- there'd be no indication in e.g.,
suite names or test results. The more obvious solution to me (at
least, based on the current proposal) would be to have "integration"
or similar be part of the suite name (and hence the filename, so
_integration_kunit.c or similar), though even I admit that that's much
uglier. Maybe the idea of having the subsystem/suite distinction be
represented in the code could pave the way to having different suites
support different suffixes like that.

Do you know of any cases where something has/would have both
unit-style tests and integration-style tests built with KUnit where
the distinction needs to be clear?

Brendan, Kees: do you have any thoughts?


> Thanks,
> -- Marco


Cheers,
-- David
