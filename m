Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF149F4C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 08:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiA1Hyo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 02:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiA1Hyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 02:54:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F51C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 23:54:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u15so9255955wrt.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMKYzLK/6pMHna39bnqgb+94Tea1KXoRE9gNct5ZTWI=;
        b=iGTtN5sZWqTcyIuaoOXPaB1YNKxEJcZxHCzPK8nP9Y6D0cmwAHyboajCX1nbf46Xt9
         4Oh+aCnXDmmwv+MvOZ5gwCY5AVwWq2PBW62JxHkIG0pxBsxqJ5jLxBMfg95JZZ0TmQyW
         1ejW65O+I9uMb3TwCFJgYwq2JXIeJkXiW+bFtSwD2rC0wk3F4CcbbzMDQVkH3iYTqWTF
         O/EL/SSMJq94Q/6NYPmSu87UPcP3fInM7OK1eMfy8qVc6Gd5xewZbh3Eorpr+53rW4Lb
         lx6cGYszo9rfiXFa1zrR3FsUSZ/CbamTiOmc7MnBt3XpUXZe2esmp0flM1Iz4rzDF1JX
         XWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMKYzLK/6pMHna39bnqgb+94Tea1KXoRE9gNct5ZTWI=;
        b=nIsviLvjzV6dBBerXZ5B0ex+TnOzk442EMZ3/lk+MCMzHdjga+xRqLhNXcNPa3JxKg
         2yZE09cVZ8M4kb38qaqhhutCW5ZUubUz1G18/gb5fIdZMvB8oeIJp0lhBiy3ByQB7kR3
         3CuUUXAeA4IE/RFzJBxWodIusJR5Fg/kF/BY0B6uE32HfnUumIcA2Lf5PhMtUWbE5ZFA
         G88CAmn4WjxNZF4nQ3bCxvY/9fymMHgIo9ikuvzRIJsQVrWy3jWgibss87cHYj63NQdi
         yMjMHGfYMrdoQxC6qtIYFCjb9SzEROflJNoT0yW102+GebhFgdLYqcpOHqQbXCgmTaES
         cmrg==
X-Gm-Message-State: AOAM531gQzJ8uCc6UfJkP4RjxxF53PNYMaTS58UEAwzjyYknAaWy6635
        SuJFw3qGsWA3QOynHgXUXFb+GBOj/4ZSbPQl3BxtoQ==
X-Google-Smtp-Source: ABdhPJwkOhtkpCwoM6gH4l1ikkXHk78P4xDW8ie0dLzFFa9vdmSqo4WaQunM2vY7ZFniQBiabGZpouo2XLIFH7S6/D4=
X-Received: by 2002:adf:e60f:: with SMTP id p15mr5975505wrm.177.1643356482050;
 Thu, 27 Jan 2022 23:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
 <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
 <CAFd5g46HN9pBcQhgEBGW6b=DR7ds48+Pggf0Y_d7804YO1aiKg@mail.gmail.com>
 <af2793322ce99c2bfa9e7dc35884a103b67f48b5.camel@codeconstruct.com.au>
 <CABVgOSn8fJ1YkFSwfNDoh93ve0r2Xom-RjiWvdwttvxqx39UEQ@mail.gmail.com>
 <e5fa413ed59083ca63f3479d507b972380da0dcf.camel@codeconstruct.com.au> <CABVgOSnpyAd-nmxB4VGahCoYep4HXmQ_YQWb=5EgyJpirCNT0w@mail.gmail.com>
In-Reply-To: <CABVgOSnpyAd-nmxB4VGahCoYep4HXmQ_YQWb=5EgyJpirCNT0w@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 28 Jan 2022 15:54:30 +0800
Message-ID: <CABVgOS=3H27ezf0At8aoo1T5XDnoG-uA_QRLinuiw-H52H4Uaw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 28, 2022 at 3:41 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Jan 6, 2022 at 6:53 PM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
> >
> > Hi all,
> >
> > Happy new year! I'm just picking up this thread again, after having a
> > bunch of other things come up at the end of December. I've since
> > implemented some of the direct feedback on the patch, but wanted to
> > clarify some overall direction too:
>
> Thanks for reaching back out -- and sorry for the delay. I've dusted
> everything off post-LCA now, and had another look over this.
>
> I'm CCing both the KUnit mailing list and Daniel Latypov on this
> thread so we can avoid (or track) any potential conflicts with things
> like:
> https://lore.kernel.org/linux-kselftest/20211013191320.2490913-1-dlatypov@google.com/

[Whoops, I'm smart. Actually CCing them this time!]

>
>
> >
> > > One idea I've had in the past is to keep such a list around of "test
> > > suites to be run when KUnit is ready". This is partly because it's
> > > much nicer to have all the test suites run together as part of a
> > > single (K)TAP output, so this could be a way of implementing (at least
> > > part of) that.
> >
> > I had a look at implementing this, but it doesn't seem to win us much
> > with the current structure: since we kunit_run_all_tests() before a
> > filesystem is available, kunit will always be "ready" (and the tests
> > run) before we've had a chance to load modules, which may contain
> > further tests.
>
> I think the benefit of something like this isn't really with test
> modules so much as with built-in tests which are run manually. The
> thunderbolt test, for instance, currently initialises and runs tests
> itself[1,2], rather than via the KUnit executor, so that it can ensure
> some proportion of the stack is properly initialised. If there's a way
> of coalescing those into the same TAP output as other built-in tests,
> that'd be useful.
>
> Thinking about it, though, I think it's a separate problem from module
> support, so not worth shoehorning in at this stage.
> >
> > One option would be to defer kunit_run_all_tests() until we think we
> > have the full set of tests, but there's no specific point at which we
> > know that all required modules are loaded. We could defer this to an
> > explicit user-triggered "run the tests now" interface (debugfs?), but
> > that might break expectations of the tests automatically executing on
> > init.
>
> Yeah, while I do think it'd be neat to have an interface to explicitly
> run (or re-run) tests, I think having tests run on module load is
> still the most sensible thing, particularly since that's what people
> are expecting at the moment (especially with tests which were ported
> from standalone modules to KUnit).
>
> There was a plan to allow test suites to be triggered from debugfs
> individually at some point, but I think it got derailed as tests
> weren't working if run twice, or some builtin-only tests having
> problems if run after a userland was brought up.
>
> In any case, I think we should get test suites in modules running on
> module load, and leave any debugfs-related shenanigans for a future
> patchset.
>
> > Alternatively, I could properly split the TAP output, and just run tests
> > whenever they're probed - either from the built-in set or as modules are
> > loaded at arbitrary points in the future. However, I'm not sure of what
> > the expectations on the consumer-side of the TAP output might be.
>
> At the moment, the KUnit tooling will stop parsing after the first
> full TAP output, so if suites are outputting TAP separately, only the
> first one will be handled properly by kunit_tool. Of course,
> kunit_tool doesn't really handle modules by itself at the moment, so
> as long as the output is provided to kunit_tool one at a time, it's
> still possible to use it. (And the possibility of adding a way for
> kunit_tool to handle multiple TAP outputs in the same file is
> something we plan to look into.)
>
> So, I think this isn't a problem for modules at the moment, though
> again it could be a bit painful for things like the thunderbolt test
> where there are multiple TAP documents from built-ins.
>
> Note that the updated KTAP[3] spec does actually leave the option open
> for TAP output to effectively be "streaming" and to not state the
> total number of tests in advance, but I don't think that's the ideal
> way of handling it here.
>
> > Are there any preferences on the approach here?
>
> So, after all that, I think the original plan makes the most sense,
> and if we find any cases which are particularly annoying we can either
> change things then, or (better still) adapt the tooling to handle them
> better.
>
> Thanks again for looking into this!
> -- David
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thunderbolt/test.c#n2730
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thunderbolt/domain.c#n881
> [3]: https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
