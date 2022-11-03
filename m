Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80A3618BBC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 23:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKCWnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCWnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 18:43:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D88F48
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 15:43:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v27so5256896eda.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd+95pRwcxrkU7i1WeLZFk3609cHUQanlEr+O+q7AMU=;
        b=grrkGLHOekYBsmHndxCLb6hE0OliZNO5wAlD8xOsrsP1ncvaankQT1gTaCzYsYikIA
         OA8+Zq35gDDBq/O6YYSSHKScSoi7pg8FZnmVh+A4QlR47spxZU3E8MEWNlxMkGeFvs1i
         zXPUDoRRXv2WSFbKQYvMZk/SZujrw3ec910EczbL9HPeNTgNH4Mhc7wsJXf3GCbr7+Gr
         0SedSc1JXD/unfbHC//mABUr4U5CMy/4Qu2LtsWuK6aOYtshSA+9S/XR0jX+M6h1XD40
         Isui5KHSnRmzoAeMH0bVtONoB1x5oLEUHBhiK6VF7CX1N0Z4d0WtS86rXan4hlM07ISD
         dAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jd+95pRwcxrkU7i1WeLZFk3609cHUQanlEr+O+q7AMU=;
        b=WjcDG1cL5PfL4mj5w1+uvIThMBxnMVDOr9OTN1cTqJ2tMvgxF+83ynveyYZWtww7Un
         gQfElRREV+Wywmg6txB1M93qsxyihqEc4tXEnZue50RZSvjb4bOqxrFrlW7bGQT/fUne
         9h8QPsQULYAAJwhLEU3AxcUAgTZRUYMudiVIRmOkrANJfP9ahW79nC9uNhjqr4la48FN
         zOPaVku7HHig0Unf9Zjiw5HgG07kMjTc5YGsBUm0w6sfZgGtNQbDjkUZizE+uUuOS5ZI
         LcFshn+sI8xHQzYPUrnoWrcCxu9OXNZavoeB8BTjZXMKSCz55ta7gBukoeV1j8HmEDch
         BAlQ==
X-Gm-Message-State: ACrzQf3IDoUnozzih5jJ8ygnWbZZs+MK9aN8RquhrBP6GKx+ZXQegG97
        jaRDa/5iYFXjFOTganFbb1oDKpMH+4i2OLK0yJKkzQ==
X-Google-Smtp-Source: AMsMyM4P5EPNGyKAV9BwY25QNww4Tk4zDnHIOI4H3gjcC4OyRqgzOFC6PQLtEE9yS06pIhe1CWXZj9L09CViGexYAWM=
X-Received: by 2002:aa7:cfda:0:b0:461:9d22:3484 with SMTP id
 r26-20020aa7cfda000000b004619d223484mr33563202edy.142.1667515417834; Thu, 03
 Nov 2022 15:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221103162302.4ba62d72@maurocar-mobl2>
In-Reply-To: <20221103162302.4ba62d72@maurocar-mobl2>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 3 Nov 2022 15:43:26 -0700
Message-ID: <CAGS_qxr1=PLFzM8bGjdowZwdOXMEPiJEnffPUGQvwdhYVJJNvA@mail.gmail.com>
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

On Thu, Nov 3, 2022 at 8:23 AM Mauro Carvalho Chehab
<mauro.chehab@linux.intel.com> wrote:
>
> Hi,
>
> I'm facing a couple of issues when testing KUnit with the i915 driver.
>
> The DRM subsystem and the i915 driver has, for a long time, his own
> way to do unit tests, which seems to be added before KUnit.
>
> I'm now checking if it is worth start using KUnit at i915. So, I wrote
> a RFC with some patches adding support for the tests we have to be
> reported using Kernel TAP and KUnit.
>
> There are basically 3 groups of tests there:
>
> - mock tests - check i915 hardware-independent logic;
> - live tests - run some hardware-specific tests;
> - perf tests - check perf support - also hardware-dependent.
>
> As they depend on i915 driver, they run only on x86, with PCI
> stack enabled, but the mock tests run nicely via qemu.
>
> The live and perf tests require a real hardware. As we run them
> together with our CI, which, among other things, test module
> unload/reload and test loading i915 driver with different
> modprobe parameters, the KUnit tests should be able to run as
> a module.
>
> While testing KUnit, I noticed a couple of issues:
>
> 1. kunit.py parser is currently broken when used with modules
>
> the parser expects "TAP version xx" output, but this won't
> happen when loading the kunit test driver.
>
> Are there any plans or patches fixing this issue?

Partially.
Note: we need a header to look for so we can strip prefixes (like timestamps).

But there is a patch in the works to add a TAP header for each
subtest, hopefully in time for 6.2.
This is to match the KTAP spec:
https://kernel.org/doc/html/latest/dev-tools/ktap.html

That should fix it so you can parse one suite's results at a time.
I'm pretty sure it won't fix the case where there's multiple suites
and/or you're trying to parse all test results at once via

$ find /sys/kernel/debug/kunit/ -type f | xargs cat |
./tools/testing/kunit/kunit.py parse

I think that in-kernel code change + some more python changes could
make the above command work, but no one has actively started looking
at that just yet.
Hopefully we can pick this up and also get it done for 6.2 (unless I'm
underestimating how complicated this is).

>
> 2. current->mm is not initialized
>
> Some tests do mmap(). They need the mm user context to be initialized,
> but this is not happening right now.
>
> Are there a way to properly initialize it for KUnit?

Right, this is a consequence of how early built-in KUnit tests are run
after boot.
I think for now, the answer is to make the test module-only.

I know David had some ideas here, but I can't speak to them.

>
> 3. there's no test filters for modules
>
> In order to be able to do proper CI automation, it is needed to
> be able to control what tests will run or not. That's specially
> interesting at development time where some tests may not apply
> or not run properly on new hardware.
>
> Are there any plans to add support for it at kunit_test_suites()
> when the driver is built as module? Ideally, the best would be to
> export a per-module filter_glob parameter on such cases.

I think this is a good idea and is doable. (I think I said as much on
the other thread).

The thinking before was that people would make group tests together in modules.
But if you want to share a single module for many tests, this becomes
more useful.

This has some potential merge conflicts w/ other pending work.
I was also prototyping the ability to tell KUnit "run tests #2 - #5",
so that also touches the filtering code very heavily.
(The goal there is to have kunit.py able to shard up tests and boot
multiple kernels concurrently.)

>
> 4. there are actually 3 levels of tests on i915:
>         - Level 1: mock, live, perf
>         - Level 2: test group (mmap, fences, ...)
>         - Level 3: unit tests
>
> Currently, KUnit seems to have just two levels (test suite and tests).
> Are there a way to add test groups there?

Parameterized tests are the closest we have to a third-level of tests.
But other than that, the answer is no.

I'd need to get more familiar with the existing tests, but I'm pretty
sure parameters won't work for you.

And I don't know if this will get done.

Note: the kunit_parser.py code should be able to handle arbitrary
levels of tests in the output.
This restriction is purely in the in-kernel code.

I had brought up the idea of more layers of tests before.
It would also be useful for
a) sharing expensive setup between multiple tests
b) allowing more granular scope for cleanups (kunit_kmalloc and others)
c) more flexibility in dynamically generating subtests than
parameterized testing

There's some precedent in other unit testing frameworks, for example:
https://pkg.go.dev/testing#T.Run

Daniel
