Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2571F815F
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jun 2020 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgFMGvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Jun 2020 02:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgFMGvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Jun 2020 02:51:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748DC03E96F
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 23:51:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so9775526wmd.5
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2zPWpPgFCMzXv5H7CN4nHl1Vt07w4Zt5NmeJ7/bUCA=;
        b=rMtVs683HPlLLOFlVhjVcDVlYVmGasM8ozFdy/f5+pa33hTK5ttBbNDNQkr7xwcsPd
         CffXa5L8vQ1RkR5PqNChV5JxQ4XyzsRgbsUFFxbCAgiblv7aIRXRDAVd+uzhRuYAe3lc
         pmROpJ7KT0UJCwlr4mQdSiG/+gWTfeh2ScsCiTAXwmuNkABxTSue8q39l5fmkHXYzxmL
         yzZr6d3FI8wPO7PlVWDR7p1Mi4RQWe3Ccn4taALFciVADixLATLqlnGj3u2eUFkf/0as
         AKWPsSLUFY24BjhnQRnn2xsHZDage4MkcAvgf/VAa6gzhIDc6wBAUn9JkbTR+RerONya
         LBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2zPWpPgFCMzXv5H7CN4nHl1Vt07w4Zt5NmeJ7/bUCA=;
        b=j18SsARiVnnhigE/tu948oryplKOtr6ASJN2qO5rc7N9ZLdnsvU/EXPfGPJVW/A4D8
         q+gdS3kuKsNyasBi3auKFCAL/hDvixuipz+BxnvGQ6+nqwlQODc2mcOTRYp5JWT6tFzR
         P5q2ynI+3AOezjUKo3PC2ZlXSNGKhBCcufDIvZ/g8Mo9KZNSUatNE0E9uYC0kugOwP5V
         q3dRfHLb2Y8JQd+CJEyqHOndHqU00xw4XaXZIpD0TrM4XZjYLPRKr00pzxlNKE26AsNr
         UE3ZHBLipnuKL/C0d4XzUzwEWReFwFAygaFcxH5cmtTD1gEmJTCh7K20+QymNj3XDdu1
         sTDQ==
X-Gm-Message-State: AOAM530Jr5QDB/8xhM0dTo+h9sX8hAnLQ9bT43GPh08RHFGbCMiJvrHL
        GLUN2ydGvSd2HSDht/yJunadZuUH38vYZ8Bpp2Lygw==
X-Google-Smtp-Source: ABdhPJwp4vYyLNyPc7dAZwXRGNHbZSLMreeiEAQArBBrLSn4fidZhTSshA3r2HpEW54ArY/tdXxmPtEluW3yrNB6Iro=
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr2467771wmj.87.1592031088802;
 Fri, 12 Jun 2020 23:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org> <202006121403.CF8D57C@keescook>
In-Reply-To: <202006121403.CF8D57C@keescook>
From:   David Gow <davidgow@google.com>
Date:   Sat, 13 Jun 2020 14:51:17 +0800
Message-ID: <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
To:     Kees Cook <keescook@chromium.org>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux@rasmusvillemoes.dk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 13, 2020 at 6:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 11, 2020 at 06:55:01PM -0300, Vitor Massaru Iha wrote:
> > This adds the convertion of the runtime tests of check_*_overflow fuctions,
> > from `lib/test_overflow.c`to KUnit tests.
> >
> > The log similar to the one seen in dmesg running test_overflow can be
> > seen in `test.log`.
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  lib/Kconfig.debug         |  17 ++
> >  lib/Makefile              |   1 +
> >  lib/kunit_overflow_test.c | 590 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 608 insertions(+)
> >  create mode 100644 lib/kunit_overflow_test.c
>
> What tree is this based on? I can't apply it to v5.7, linux-next, nor
> Linus's latest. I've fixed it up to apply to linux-next for now. :)

This applies to the kselftest/kunit branch for me.

> Looking at linux-next, though, I am reminded of my agony over naming:
>
> obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += kunit_overflow_test.o
>
> *-test
> test_*
> *_test
>
> This has to get fixed now, and the naming convention needs to be
> documented. For old tests, the preferred naming was test_*. For kunit, I
> think it should be kunit_* (and no trailing _test; that's redundant).
>
> For for this bikeshed, I think it should be kunit_overflow.c
>
> For the CONFIG name, it seems to be suggested in docs to be
> *_KUNIT_TEST:
>
> ...
> menuconfig). From there, you can enable any KUnit tests you want: they usually
> have config options ending in ``_KUNIT_TEST``.
> ...

Yeah, _KUNIT_TEST was what we've sort-of implicitly decided on for
config names, but the documentation does need to happen.
We haven't put as much thought into standardising the filenames much, though.

Both of these are slightly complicated by cases like this where tests
are being ported from a non-KUnit test to KUnit. There's a small
argument there for trying to keep the name the same, though personally
I suspect consistency is more important.

> I think much stronger language needs to be added to "Writing your first
> test" (which actually recommends the wrong thing: "config
> MISC_EXAMPLE_TEST"). And then doesn't specify a module file name, though
> it hints at one:
>
> ...
>         obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
> ...
>
> So, please, let's get this documented: we really really need a single
> naming convention for these.
>
> For Kconfig in the tree, I see:
>
> drivers/base/Kconfig:config PM_QOS_KUNIT_TEST
> drivers/base/test/Kconfig:config KUNIT_DRIVER_PE_TEST
> fs/ext4/Kconfig:config EXT4_KUNIT_TESTS
> lib/Kconfig.debug:config SYSCTL_KUNIT_TEST
> lib/Kconfig.debug:config OVERFLOW_KUNIT_TEST
> lib/Kconfig.debug:config LIST_KUNIT_TEST
> lib/Kconfig.debug:config LINEAR_RANGES_TEST
> lib/kunit/Kconfig:menuconfig KUNIT
> lib/kunit/Kconfig:config KUNIT_DEBUGFS
> lib/kunit/Kconfig:config KUNIT_TEST
> lib/kunit/Kconfig:config KUNIT_EXAMPLE_TEST
> lib/kunit/Kconfig:config KUNIT_ALL_TESTS
>
> Which is:
>
> *_KUNIT_TEST
> KUNIT_*_TEST
> KUNIT_*_TESTS
> *_TEST
>
> Nooooo. ;)
>
> If it should all be *_KUNIT_TEST, let's do that. I think just *_KUNIT
> would be sufficient (again, adding the word "test" to "kunit" is
> redundant). And it absolutely should not be a prefix, otherwise it'll
> get sorted away from the thing it's named after. So my preference is
> here would be CONFIG_OVERFLOW_KUNIT. (Yes the old convention was
> CONFIG_TEST_*, but those things tended to be regression tests, not unit
> tests.)
>
> Please please, can we fix this before we add anything more?

Alas, the plans to document test coding style / conventions kept
getting pre-empted: I'll drag it back up to the top of the to-do list,
and see if we can't prioritise it. I think we'd hoped to be able to
catch these in review, but between a bit of forgetfulness and a few
tests going upstream without our seeing them has made it obvious that
doesn't work.

Once something's documented (and the suitable bikeshedding has
subsided), we can consider renaming existing tests if that seems
worthwhile.

My feeling is we'll go for:
- Kconfig name: ~_KUNIT_TEST
- filename: ~-test.c

At least for the initial draft documentation, as those seem to be most
common, but I think a thread on that would probably be the best place
to add it.
This would also be a good opportunity to document the "standard" KUnit
boilerplate help text in the Kconfig options.

> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 1f4ab7a2bdee..72fcfe1f24a4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2075,6 +2075,23 @@ config SYSCTL_KUNIT_TEST
> >
> >         If unsure, say N.
> >
> > +config OVERFLOW_KUNIT_TEST
> > +     tristate "KUnit test for overflow" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT
> > +     default KUNIT_ALL_TESTS
> > +     help
> > +       This builds the overflow KUnit tests.
> > +
> > +       KUnit tests run during boot and output the results to the debug log
> > +       in TAP format (http://testanything.org/). Only useful for kernel devs
> > +       running KUnit test harness and are not for inclusion into a production
> > +       build.
> > +
> > +       For more information on KUnit and unit tests in general please refer
> > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +       If unsure, say N.
> > +
> >  config LIST_KUNIT_TEST
> >       tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
> >       depends on KUNIT
>
> Regarding output:
>
> [   36.611358] TAP version 14
> [   36.611953]     # Subtest: overflow
> [   36.611954]     1..3
> ...
> [   36.622914]     # overflow_calculation_test: s64: 21 arithmetic tests
> [   36.624020]     ok 1 - overflow_calculation_test
> ...
> [   36.731096]     # overflow_shift_test: ok: (s64)(0 << 63) == 0
> [   36.731840]     ok 2 - overflow_shift_test
> ...
> [   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> ...
> [   36.805350]     # overflow_allocation_test: devm_kzalloc detected saturation
> [   36.807763]     ok 3 - overflow_allocation_test
> [   36.807765] ok 1 - overflow
>
> A few things here....

Tim Bird has just sent out an RFC for a "KTAP" specification, which
we'll hope to support in KUnit:
https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/#u

That's probably where we'll end up trying to hash out exactly what
this format should be. Fortunately, I don't think any of these will
require any per-test work, just changes to the KUnit implementation.

> - On the outer test report, there is no "plan" line (I was expecting
>   "1..1"). Technically it's optional, but it seems like the information
>   is available. :)

There's work underway to support this, but it's hit a few minor snags:
https://lkml.org/lkml/2020/2/27/2155

> - The subtest should have its own "TAP version 14" line, and it should
>   be using the diagnostic line prefix for the top-level test (this is
>   what kselftest is doing).

Alas, TAP itself hasn't standardised subtests. Personally, I think it
doesn't fundamentally matter which way we do this (I actually prefer
the way we're doing it currently slightly), but converging with what
kselftest does would be ideal.

> - There is no way to distinguish top-level TAP output from kernel log
>   lines. I think we should stick with the existing marker, which is
>   "# ", so that kernel output has no way to be interpreted as TAP
>   details -- unless it intentionally starts adding "#"s. ;)

At the moment, we're doing this in KUnit tool by stripping anything
before "TAP version 14" (e.g., the timestamp), and then only incuding
lines which parse correctly (are a test plan, result, or a diagnostic
line beginning with '#').
This has worked pretty well thus far, and we do have the ability to
get results from debugfs instead of the kernel log, which won't have
the same problems.

It's worth considering, though, particularly since our parser should
handle this anyway without any changes.

> - There is no summary line (to help humans). For example, the kselftest
>   API produces a final pass/fail report.

Currently, we're relying on the kunit.py script to produce this, but
it shouldn't be impossible to add to the kernel, particularly once the
"KUnit Executor" changes mentioned above land.

> Taken together, I was expecting the output to be:
>
> [   36.611358] # TAP version 14
> [   36.611953] # 1..1
> [   36.611958] # # TAP version 14
> [   36.611954] # # 1..3
> ...
> [   36.622914] # # # overflow_calculation_test: s64: 21 arithmetic tests
> [   36.624020] # # ok 1 - overflow_calculation_test
> ...
> [   36.731096] # # # overflow_shift_test: ok: (s64)(0 << 63) == 0
> [   36.731840] # # ok 2 - overflow_shift_test
> ...
> [   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> ...
> [   36.805350] # # # overflow_allocation_test: devm_kzalloc detected saturation
> [   36.807763] # # ok 3 - overflow_allocation_test
> [   36.807763] # # # overflow: PASS
> [   36.807765] # ok 1 - overflow
> [   36.807767] # # kunit: PASS
>
> But I assume there are threads on this that I've not read... :)
>

These discussions all seem to be coming to a head now, so this is
probably just the kick we need to prioritise this a bit more. The KTAP
thread hasn't covered all of these (particularly the subtest stuff)
yet, so I confess I hadn't realised the extent of the divergence
between KUnit and kselftest here.

Cheers,
-- David
