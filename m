Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D412049F48A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 08:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiA1Hle (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 02:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346989AbiA1Hla (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 02:41:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C457C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 23:41:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso7534328wmj.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 23:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43bLScNKVpKzM2is+f4rueHSArCjCAEeeZMg/i7o1iY=;
        b=niYIaduHLR0vE0FmDJbF44eN8pFZ6AULIHn5EMvFWcfB/J/2wqFLCtBEjMtjjKl0AS
         m4DtV3eKE00WClkMn8+IG0vpVHyl0vcsx4J2P0Yt+oVM5IEfqqdM3g/NUPRbwdO677jv
         0Xo73VQkNI6w6n72ulk04Fs4Ike8Y+lq2D7omqnSsUamKD8lrd6R/0yiebNnYU9adYRw
         kcWP4ZsYU0JjiXsyc8lPvhmXWdeJ2oDpsysp1LYAgzBT8VpYzWmy9pRj2i0TZrJeaLLM
         h9yieNQ9I0eO4X+NEJ0svO/nINjEqVrMzI9gKClYoOyjjqPZYPmG2r89JZwLFHZHo06m
         GVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43bLScNKVpKzM2is+f4rueHSArCjCAEeeZMg/i7o1iY=;
        b=3EAvQe+8DEPwtQ+trlptf9H40UF4AsDr8Km5L8Lj7iyrwEx/Ij4STx6F6qlSwpNljH
         Si454dNbjRVOu8zQ4uQCb6bDrvAOO+ldtLygc+usrbcb1FM0+nn0s8nLnYTGYuMtVp3F
         o+983kowwAKj5rrp0314t5qelU4VQL8mIou4cVgr4OwjGgZ5NLaH2EKbjLGK8YqLUAGp
         VCHTun/VbYBchyP/7XH2aKkcadJIHgwV8UWTg9NKn4h/tvUy+AbR6ljC2rpwB0fwvW+7
         U0l+CZE8H20ik4F9yR5k/qBsEwq/cjz/BC9MAbe69U9PMl9qmDAfKNU1kuYy22PGyJl3
         4RXg==
X-Gm-Message-State: AOAM53114Irj8XXTtD1WwCHvGwS0JgB3KG9sSc2woqO2MvJmXZuhLsk8
        1GVqeRf7H9cph2ogytyjJ4iA6r+lYQP4KDcDt4gbfs9le70ubA==
X-Google-Smtp-Source: ABdhPJwX1B759PSyKr9EBgtgGw05L/CDMaIhCQSoSckIbYkLj55FNVQyC/+S38ho05G4TtLrPPBwGdyEmE66Jp/qw1E=
X-Received: by 2002:a1c:4645:: with SMTP id t66mr14243711wma.39.1643355687925;
 Thu, 27 Jan 2022 23:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
 <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
 <CAFd5g46HN9pBcQhgEBGW6b=DR7ds48+Pggf0Y_d7804YO1aiKg@mail.gmail.com>
 <af2793322ce99c2bfa9e7dc35884a103b67f48b5.camel@codeconstruct.com.au>
 <CABVgOSn8fJ1YkFSwfNDoh93ve0r2Xom-RjiWvdwttvxqx39UEQ@mail.gmail.com> <e5fa413ed59083ca63f3479d507b972380da0dcf.camel@codeconstruct.com.au>
In-Reply-To: <e5fa413ed59083ca63f3479d507b972380da0dcf.camel@codeconstruct.com.au>
From:   David Gow <davidgow@google.com>
Date:   Fri, 28 Jan 2022 15:41:16 +0800
Message-ID: <CABVgOSnpyAd-nmxB4VGahCoYep4HXmQ_YQWb=5EgyJpirCNT0w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 6, 2022 at 6:53 PM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> Hi all,
>
> Happy new year! I'm just picking up this thread again, after having a
> bunch of other things come up at the end of December. I've since
> implemented some of the direct feedback on the patch, but wanted to
> clarify some overall direction too:

Thanks for reaching back out -- and sorry for the delay. I've dusted
everything off post-LCA now, and had another look over this.

I'm CCing both the KUnit mailing list and Daniel Latypov on this
thread so we can avoid (or track) any potential conflicts with things
like:
https://lore.kernel.org/linux-kselftest/20211013191320.2490913-1-dlatypov@google.com/


>
> > One idea I've had in the past is to keep such a list around of "test
> > suites to be run when KUnit is ready". This is partly because it's
> > much nicer to have all the test suites run together as part of a
> > single (K)TAP output, so this could be a way of implementing (at least
> > part of) that.
>
> I had a look at implementing this, but it doesn't seem to win us much
> with the current structure: since we kunit_run_all_tests() before a
> filesystem is available, kunit will always be "ready" (and the tests
> run) before we've had a chance to load modules, which may contain
> further tests.

I think the benefit of something like this isn't really with test
modules so much as with built-in tests which are run manually. The
thunderbolt test, for instance, currently initialises and runs tests
itself[1,2], rather than via the KUnit executor, so that it can ensure
some proportion of the stack is properly initialised. If there's a way
of coalescing those into the same TAP output as other built-in tests,
that'd be useful.

Thinking about it, though, I think it's a separate problem from module
support, so not worth shoehorning in at this stage.
>
> One option would be to defer kunit_run_all_tests() until we think we
> have the full set of tests, but there's no specific point at which we
> know that all required modules are loaded. We could defer this to an
> explicit user-triggered "run the tests now" interface (debugfs?), but
> that might break expectations of the tests automatically executing on
> init.

Yeah, while I do think it'd be neat to have an interface to explicitly
run (or re-run) tests, I think having tests run on module load is
still the most sensible thing, particularly since that's what people
are expecting at the moment (especially with tests which were ported
from standalone modules to KUnit).

There was a plan to allow test suites to be triggered from debugfs
individually at some point, but I think it got derailed as tests
weren't working if run twice, or some builtin-only tests having
problems if run after a userland was brought up.

In any case, I think we should get test suites in modules running on
module load, and leave any debugfs-related shenanigans for a future
patchset.

> Alternatively, I could properly split the TAP output, and just run tests
> whenever they're probed - either from the built-in set or as modules are
> loaded at arbitrary points in the future. However, I'm not sure of what
> the expectations on the consumer-side of the TAP output might be.

At the moment, the KUnit tooling will stop parsing after the first
full TAP output, so if suites are outputting TAP separately, only the
first one will be handled properly by kunit_tool. Of course,
kunit_tool doesn't really handle modules by itself at the moment, so
as long as the output is provided to kunit_tool one at a time, it's
still possible to use it. (And the possibility of adding a way for
kunit_tool to handle multiple TAP outputs in the same file is
something we plan to look into.)

So, I think this isn't a problem for modules at the moment, though
again it could be a bit painful for things like the thunderbolt test
where there are multiple TAP documents from built-ins.

Note that the updated KTAP[3] spec does actually leave the option open
for TAP output to effectively be "streaming" and to not state the
total number of tests in advance, but I don't think that's the ideal
way of handling it here.

> Are there any preferences on the approach here?

So, after all that, I think the original plan makes the most sense,
and if we find any cases which are particularly annoying we can either
change things then, or (better still) adapt the tooling to handle them
better.

Thanks again for looking into this!
-- David

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thunderbolt/test.c#n2730
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thunderbolt/domain.c#n881
[3]: https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
