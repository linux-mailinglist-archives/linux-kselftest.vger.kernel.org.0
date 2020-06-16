Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3671FA9E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFPHZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 03:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPHZw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 03:25:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F70C05BD43
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 00:25:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so1936833wmt.4
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReLB56qZ10jMbfd/XwLbE+h7u1s6t2N5AHB2LA9HRJc=;
        b=YOX7/R/ntGwim1rdWb8oqA+cfePSWRXCc6mgR3bbKFfMWozcJ7QFF+SVhrvCw2LRJX
         aiPn8bIqWvkLrQHgzCfGrBzf7fKHRcfMp7sIeyaQciU5B+yeoJU0PYmDUZ4oNISJwAJF
         KnQm1aH123aD6OXJawdbqLzK77KbJsaCw0VcxIOXOSik85dEBVvM3R36CQ5VFWRrmWZ1
         RHEkrEJSrHNDGiP7rX1+is38scpC6L4UKRM7nfT3pqoVaCORf/qgguvfT/Cic+WZL1g+
         gNe5pv67t0XHQRv43ZWtck5Fw3vkKvihbDqc6p2404tcCx0TzwRX9L8RvmOB29IqLDNV
         /yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReLB56qZ10jMbfd/XwLbE+h7u1s6t2N5AHB2LA9HRJc=;
        b=czag8+pvHGCvfa1ae+Zazv2Yt3LudcNxY2s7mxamPh3sULBmDL3PCcQEmua7hL1LP5
         HuZURqn3BdObroCxgYXRC/zZvIqmGqPiw0puR4ab+uzaW2GFmZclxaY+azsxH8TThFRC
         F1AnYQvZxABOI/veVvkFWqfxFEm4J10SU5sR9euEYAU78VubT/Eq//5hS0UXFDo9EFVY
         3PrWLvr2h3lKJWNzqGmQJMZWz51LoRy2yA1nJsd3YzhoipwFFv+hGFRWHa1gkegwYk+T
         b4ROC3RDCiUKyR83nLXUaS2YPAOv0UaSra9kGpWRRILjY4FzsdrHj5rT6+5yg1ftw5MM
         3Jvw==
X-Gm-Message-State: AOAM530PUih7V76YSdBlt1VuJLNbQBM9ey59/Zbmo12Ea/hISsLdsccw
        MOM1BcWLXKwWPMa86AFvAMQUmcAysUKrNlY42dKO1w==
X-Google-Smtp-Source: ABdhPJx8hfklJQFGauIXQMrvBedVYDMViCMV7Z1aaLNUVEWy8S9I85zMzuC778fhDQ5NgHUPVgD908IIPoD7OhoU/XY=
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr1671828wmj.87.1592292350896;
 Tue, 16 Jun 2020 00:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org> <202006121403.CF8D57C@keescook>
 <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com> <202006141005.BA19A9D3@keescook>
In-Reply-To: <202006141005.BA19A9D3@keescook>
From:   David Gow <davidgow@google.com>
Date:   Tue, 16 Jun 2020 15:25:39 +0800
Message-ID: <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
Subject: Re: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
To:     Kees Cook <keescook@chromium.org>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CONFIG_PM_QOS_KUNIT_TESTOn Mon, Jun 15, 2020 at 1:48 AM Kees Cook
<keescook@chromium.org> wrote:
>
> On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:
> > Yeah, _KUNIT_TEST was what we've sort-of implicitly decided on for
> > config names, but the documentation does need to happen.
>
> That works for me. It still feels redundant, but all I really want is a
> standard name. :)
>
> > We haven't put as much thought into standardising the filenames much, though.
>
> I actually find this to be much more important because it is more
> end-user-facing (i.e. in module naming, in build logs, in scripts, on
> filesystem, etc -- CONFIG is basically only present during kernel build).
> Trying to do any sorting or greping really needs a way to find all the
> kunit pieces.
>

Certainly this is more of an issue now we support building KUnit tests
as modules, rather than having them always be built-in.

Having some halfway consistent config-name <-> filename <-> test suite
name could be useful down the line, too. Unfortunately, not
necessarily a 1:1 mapping, e.g.:
- CONFIG_KUNIT_TEST compiles both kunit-test.c and string-stream-test.c
- kunit-test.c has several test suites within it:
kunit-try-catch-test, kunit-resource-test & kunit-log-test.
- CONFIG_EXT4_KUNIT_TESTS currently only builds ext4-inode-test.c, but
as the plural name suggests, might build others later.
- CONFIG_SECURITY_APPARMOR_KUNIT_TEST doesn't actually have its own
source file: the test is built into policy_unpack.c
- &cetera

Indeed, this made me quickly look up the names of suites, and there
are a few inconsistencies there:
- most have "-test" as a suffix
- some have "_test" as a suffix
- some have no suffix

(I'm inclined to say that these don't need a suffix at all.)

Within test suites, we're also largely prefixing all of the tests with
a suite name (even if it's not actually the specified suite name). For
example, CONFIG_PM_QOS_KUNIT_TEST builds
drivers/base/power/qos-test.c which contains a suite called
"qos-kunit-test", with tests prefixed "freq_qos_test_". Some of this
clearly comes down to wanting to namespace things a bit more
("qos-test" as a name could refer to a few things, I imagine), but
specifying how to do so consistently could help.

> > Both of these are slightly complicated by cases like this where tests
> > are being ported from a non-KUnit test to KUnit. There's a small
> > argument there for trying to keep the name the same, though personally
> > I suspect consistency is more important.
>
> Understood. I think consistency is preferred too, especially since the
> driving reason to make this conversions is to gain consistency with the
> actual tests themselves.

We'll go with that until someone objects: from what I recall, this is
largely what people have been doing anyway.

> > Alas, the plans to document test coding style / conventions kept
> > getting pre-empted: I'll drag it back up to the top of the to-do list,
> > and see if we can't prioritise it. I think we'd hoped to be able to
> > catch these in review, but between a bit of forgetfulness and a few
> > tests going upstream without our seeing them has made it obvious that
> > doesn't work.
> >
> > Once something's documented (and the suitable bikeshedding has
> > subsided), we can consider renaming existing tests if that seems
> > worthwhile.
>
> Yes please! :)
>

I'll see if I can find time to draft something this week, then. No
promises, but hopefully there'll at least be something to build on.

> > My feeling is we'll go for:
> > - Kconfig name: ~_KUNIT_TEST
>
> As mentioned, I'm fine with this, but prefer ~_KUNIT
>
> > - filename: ~-test.c
>
> I really don't like this. Several reasons reasons:
>
> - it does not distinguish it from other tests -- there is no way to
>   identify kunit tests from non-kunit tests from directory listings,
>   build log greps, etc.
>
> - the current "common" naming has been with a leading "test", ignoring
>   kunit, tools/, and samples/:
>
>         53 test_*.c
>         27 *_test.c
>         19 *[a-z0-9]test.c
>         19 selftest*.c
>         16 test-*.c
>         11 *-test.c
>         11 test[a-z0-9]*.c
>          8 *-tests.c
>          5 *-selftest.c
>          4 *_test_*.c
>          1 *_selftest_*.c
>          1 *_selftests.c
>
> (these counts might be a bit off -- my eyes started to cross while
> constructing regexes)
>
> - dashes are converted to _ in module names, leading to some confusion
>   between .c file and .ko file.
>
> I'd strongly prefer ~_kunit.c, but could live with _kunit_test.c (even
> though it's redundant).
>

I suggested -test.c largely because it's seemed to be most popular out
of existing KUnit tests (and certainly out of the ones that already
had-KUNIT_TEST config suffixes), but I definitely see your points.
I think that trying to stick to a "common" test naming is a bit
contradictory with trying to distinguish KUnit tests from other tests,
and I'm leaning to the side of distinguishing them, so I definitely
could be converted to ~_kunit.c.

Brendan, any thoughts?

> > At least for the initial draft documentation, as those seem to be most
> > common, but I think a thread on that would probably be the best place
> > to add it.
>
> I'm ready! :) (Subject updated)
>
> > This would also be a good opportunity to document the "standard" KUnit
> > boilerplate help text in the Kconfig options.
>
> Ah yeah, good idea.
>
> --
> Kees Cook

Cheers,
-- David
