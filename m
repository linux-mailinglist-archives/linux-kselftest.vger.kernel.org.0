Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AF61A0C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 20:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKDTUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 15:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDTUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 15:20:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53A47308
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 12:20:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so15806197ejc.4
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh1KWYON5mjuQI+J8O7TTZWfdQmfVuD5Iq8KiixC6i8=;
        b=ltvb1UQyJl6pGWW2XNH5fo2PPAS3YXLxwSj/fm2FswI/J2BfkT/CK8YTBbVJMRj+P9
         TjTzaZKQ4wr6kBfgOtLw/TwlrLy6hnO6ZduizB6fD5LHFVUfbYsQSYn8clXV9LPa1Ehp
         x4VQ3UtkaPfNVqDUEhjmr2jyOZgsj1XdKKS037E2Xi1RSJME6pokkzaj/VM6fjACLOdb
         63p+BmrgVnj+wTOpkzpyWsr5b2yMCGMg1n4pA2bITYtxV+USzqAA765354oCUJxgVdmr
         O/KJ82QhL/3dlNqT+s+sIUczprHXfR5N3b6mPM/BTtuDYTZhsfn0/mGCBh+mH2d96sZM
         ee+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh1KWYON5mjuQI+J8O7TTZWfdQmfVuD5Iq8KiixC6i8=;
        b=yqEDx6z2dor7dcsCmTctJfNxgYyk+TPMq63JV700oK08fMvN5qQdgnV0YXfDWjTzyi
         zWNlfOCRAnCwLWdJQ4JMRGrOxj1emkSPqaMQNp3WVyb5GCKRbc2jyCtajZwokfCjahgA
         QvxQa+KMUUU+HVw4RmSugU0j0h4xMUTRxIIvW08DeEhPAg34a/3B0oESWzpYUcGjO+BC
         7srE6veN67e8J6u74fp0gI+T+4sZxz5Gxzr4//n26Al0dJ853/jDRJWn0kDw7WPVcyXy
         q/Ai05vNLjxBM6r1rDRsNAu/l8NadDCFTh6iDI0eEwKlOidm9pcn5lrxgT78tIuqOLJt
         bLqQ==
X-Gm-Message-State: ACrzQf2MRP44MQ1i7BYWr0wQIJgWwP7F5vXS3KAkPjNsUav0h0Bhy4Py
        GNulKc+w1XzRKoi9D3plfuWRwVxSryx8aeKV0F7XEQ==
X-Google-Smtp-Source: AMsMyM4DrcCYYQKEDdArtGjulTTfS/ZrzcU7d3blYwfP0xOs9GkV6Pjm6sVQHlKD4m8iOcJgGtw4ixgzyK0xTxJ7Zs8=
X-Received: by 2002:a17:906:1c52:b0:7ad:c6c5:eae8 with SMTP id
 l18-20020a1709061c5200b007adc6c5eae8mr30084404ejg.439.1667589647564; Fri, 04
 Nov 2022 12:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221103162302.4ba62d72@maurocar-mobl2> <CAGS_qxr1=PLFzM8bGjdowZwdOXMEPiJEnffPUGQvwdhYVJJNvA@mail.gmail.com>
 <20221104084955.4e6e1093@maurocar-mobl2>
In-Reply-To: <20221104084955.4e6e1093@maurocar-mobl2>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 4 Nov 2022 12:20:36 -0700
Message-ID: <CAGS_qxp3mmhdxKY1PreGRzVW=+4LVQKBRAAJT3VH8APTFtKJxw@mail.gmail.com>
Subject: Re: KUnit issues - Was: [igt-dev] [PATCH RFC v2 8/8] drm/i915: check
 if current->mm is not NULL
To:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 4, 2022 at 12:50 AM Mauro Carvalho Chehab
<mauro.chehab@linux.intel.com> wrote:
>
> On Thu, 3 Nov 2022 15:43:26 -0700
> Daniel Latypov <dlatypov@google.com> wrote:
>
> > On Thu, Nov 3, 2022 at 8:23 AM Mauro Carvalho Chehab
> > <mauro.chehab@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > I'm facing a couple of issues when testing KUnit with the i915 driver.
> > >
> > > The DRM subsystem and the i915 driver has, for a long time, his own
> > > way to do unit tests, which seems to be added before KUnit.
> > >
> > > I'm now checking if it is worth start using KUnit at i915. So, I wrote
> > > a RFC with some patches adding support for the tests we have to be
> > > reported using Kernel TAP and KUnit.
> > >
> > > There are basically 3 groups of tests there:
> > >
> > > - mock tests - check i915 hardware-independent logic;
> > > - live tests - run some hardware-specific tests;
> > > - perf tests - check perf support - also hardware-dependent.
> > >
> > > As they depend on i915 driver, they run only on x86, with PCI
> > > stack enabled, but the mock tests run nicely via qemu.
> > >
> > > The live and perf tests require a real hardware. As we run them
> > > together with our CI, which, among other things, test module
> > > unload/reload and test loading i915 driver with different
> > > modprobe parameters, the KUnit tests should be able to run as
> > > a module.
> > >
> > > While testing KUnit, I noticed a couple of issues:
> > >
> > > 1. kunit.py parser is currently broken when used with modules
> > >
> > > the parser expects "TAP version xx" output, but this won't
> > > happen when loading the kunit test driver.
> > >
> > > Are there any plans or patches fixing this issue?
> >
> > Partially.
> > Note: we need a header to look for so we can strip prefixes (like timestamps).
> >
> > But there is a patch in the works to add a TAP header for each
> > subtest, hopefully in time for 6.2.
>
> Good to know.
>
> > This is to match the KTAP spec:
> > https://kernel.org/doc/html/latest/dev-tools/ktap.html
>
> I see.
>
> > That should fix it so you can parse one suite's results at a time.
> > I'm pretty sure it won't fix the case where there's multiple suites
> > and/or you're trying to parse all test results at once via
> >
> > $ find /sys/kernel/debug/kunit/ -type f | xargs cat |
> > ./tools/testing/kunit/kunit.py parse
>
> Could you point me to the changeset? perhaps I can write a followup
> patch addressing this case.

rmoar@google.com was working on them and should hopefully be able to
send them out real soon.
You should get CC'd on those.

I think the follow-up work is just crafting an example parser input
file and iterating until
  $ ./tools/testing/kunit/kunit.py parse < /tmp/example_input
produces our desired results.

>
> > I think that in-kernel code change + some more python changes could
> > make the above command work, but no one has actively started looking
> > at that just yet.
> > Hopefully we can pick this up and also get it done for 6.2 (unless I'm
> > underestimating how complicated this is).
> >
> > >
> > > 2. current->mm is not initialized
> > >
> > > Some tests do mmap(). They need the mm user context to be initialized,
> > > but this is not happening right now.
> > >
> > > Are there a way to properly initialize it for KUnit?
> >
> > Right, this is a consequence of how early built-in KUnit tests are run
> > after boot.
> > I think for now, the answer is to make the test module-only.
> >
> > I know David had some ideas here, but I can't speak to them.
>
> This is happening when test-i915 is built as module as well.

Oh, I didn't expect that at all.

>
> I suspect that the function which initializes it is mm_alloc() inside
> kernel/fork.c:
>
>         struct mm_struct *mm_alloc(void)
>         {
>                 struct mm_struct *mm;
>
>                 mm = allocate_mm();
>                 if (!mm)
>                         return NULL;
>
>                 memset(mm, 0, sizeof(*mm));
>                 return mm_init(mm, current, current_user_ns());
>         }
>
> As modprobing a test won't fork until all tests run, this never runs.
>
> It seems that the normal usage is at fs/exec.c:
>
>         fs/exec.c:      bprm->mm = mm = mm_alloc();
>
> but other places also call it:
>
>         arch/arm/mach-rpc/ecard.c:      struct mm_struct * mm = mm_alloc();
>         drivers/dma-buf/dma-resv.c:     struct mm_struct *mm = mm_alloc();
>         include/linux/sched/mm.h:extern struct mm_struct *mm_alloc(void);
>         mm/debug_vm_pgtable.c:  args->mm = mm_alloc();
>
> Probably the solution would be to call it inside kunit executor code,
> adding support for modules to use it.

I know basically nothing about the mm code.
I think I vaguely recall there being issues with this on UML or
something, but I could be totally wrong.

I'll wait for David to chime in when he can.

>
> > > 3. there's no test filters for modules
> > >
> > > In order to be able to do proper CI automation, it is needed to
> > > be able to control what tests will run or not. That's specially
> > > interesting at development time where some tests may not apply
> > > or not run properly on new hardware.
> > >
> > > Are there any plans to add support for it at kunit_test_suites()
> > > when the driver is built as module? Ideally, the best would be to
> > > export a per-module filter_glob parameter on such cases.
> >
> > I think this is a good idea and is doable. (I think I said as much on
> > the other thread).
> >
> > The thinking before was that people would make group tests together in modules.
> > But if you want to share a single module for many tests, this becomes
> > more useful.
>
> At least for this RFC, I opted to place everything we have already on
> a single module.
>
> Perhaps I could create, instead, 3 separate modules. This way, I would gain
> a "third level" and a poor man's way of filtering what test type
> will run (mock, live or perf).
>
> Yet, we will still need to be able to filter the unit tests, as this
> is where all the fun happens.
>
> > This has some potential merge conflicts w/ other pending work.
> > I was also prototyping the ability to tell KUnit "run tests #2 - #5",
> > so that also touches the filtering code very heavily.
>
> Are you planning to allow this to support such feature also on modules?

I was not expecting to.
The main benefit would be for automation to try sharding up tests
across multiple kernel boots. Human users would continue to use
name-based selection.

So this fits into how kunit.py works w/ UML invocations or QEMU VMs.
I don't see how this would be useful for module-based testing, where
it feels like you want to boot once and pick which modules to
modprobe.

Do you think it would be useful to have this for modules as well?

>
> > (The goal there is to have kunit.py able to shard up tests and boot
> > multiple kernels concurrently.)
> >
> > >
> > > 4. there are actually 3 levels of tests on i915:
> > >         - Level 1: mock, live, perf
> > >         - Level 2: test group (mmap, fences, ...)
> > >         - Level 3: unit tests
> > >
> > > Currently, KUnit seems to have just two levels (test suite and tests).
> > > Are there a way to add test groups there?
> >
> > Parameterized tests are the closest we have to a third-level of tests.
> > But other than that, the answer is no.
> >
> > I'd need to get more familiar with the existing tests, but I'm pretty
> > sure parameters won't work for you.
>
> Our current approach with selftests is that each test can be disabled.
> You can see how it currently works by taking a look at the __run_selftests
> logic (level 2 on the above hierarchy) inside
> drivers/gpu/drm/i915/selftests/i915_selftest.c:
>
>
>         static int __run_selftests(const char *name,
>                                    struct selftest *st,
>                                    unsigned int count,
>                                    void *data)
>         {
> ...
>                 /* Tests are listed in order in i915_*_selftests.h */
>                 for (; count--; st++) {
>                         if (!st->enabled)
>                                 continue;
> ...
>                 pr_info(DRIVER_NAME ": Running %s\n", st->name);
>                 if (data)
>                         err = st->live(data);
>                 else
>                         err = st->mock();
>
> The same also happens at subtests (level 3):
>
>         int __i915_subtests(const char *caller,
>                             int (*setup)(void *data),
>                             int (*teardown)(int err, void *data),
>                             const struct i915_subtest *st,
>                             unsigned int count,
>                             void *data)
>         {
> ...
>                 if (!apply_subtest_filter(caller, st->name))
>                         continue;
> ...
>                 pr_info(DRIVER_NAME ": Running %s/%s\n", caller, st->name);
>                 GEM_TRACE("Running %s/%s\n", caller, st->name);
>
>                 err = teardown(st->func(data), data);

Had a brief look.

Hmm, the idea of dynamically adding subtests wouldn't work well with
this more structured approach.
The filtering right now in KUnit is done directly on the suites/test
case objects before we run them.
We'd need to pass in this extra filter while running the tests, which
would need some thought to do cleanly.

Here's an idea of how you could roughly emulate this in KUnit right now:
1) could have each KUNIT_CASE map to a test group
2) could have some shared test code declare a module param 'subtest_filter'
3) you could check if the subtest name matches 'subtest_filter', and
use kunit_skip() otherwise

You'd be able to plumb in the subtest filter via:
$ kunit.py run --kernel_args 'subtest_filter=foo'

This feels a bit gross, but not as gross as I thought it might.


Daniel

>
> > And I don't know if this will get done.
> >
> > Note: the kunit_parser.py code should be able to handle arbitrary
> > levels of tests in the output.
> > This restriction is purely in the in-kernel code.
> >
> > I had brought up the idea of more layers of tests before.
> > It would also be useful for
> > a) sharing expensive setup between multiple tests
> > b) allowing more granular scope for cleanups (kunit_kmalloc and others)
> > c) more flexibility in dynamically generating subtests than
> > parameterized testing
>
> Yes, it makes sense to me.
>
> > There's some precedent in other unit testing frameworks, for example:
> > https://pkg.go.dev/testing#T.Run
>
> Regards,
> Mauro
