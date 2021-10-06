Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC2424416
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhJFR2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFR2a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 13:28:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A0EC061746
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 10:26:37 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y197so3656685iof.11
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jM95yKFhV2qB0CLFdficrXk+L5A5ZWpI+xeKTC4LLR4=;
        b=MN6d1YTVj88nQqwDa53hJ5/h9IC/CoxXaMUX4gfp/8cq6fsmWh367DWJ2CcrpUkBoX
         /p/OmZ4kyKc+hjLw54ZIXZcLn015XLX/Yb9Eg1vBp+abb53a914LDDLFTiHdvxKQmcCA
         vZWArFMYnMkvp05TwqqFzwipPcYbQUbKFkqWiTYnKLOMvOPwauWxhP3XNPzEN2u3yiVv
         27e5QJDSrNZI0B6EFca/YgUPNzMLc7TOizQbNzUB59qACGmBIU2hgRywH5x39X6xH6jw
         0r+qbqPIilq7gPTroe7HrljiGydi/ykjidOyzC/lSbLWoYLK6JRaPjFmNvMxPBB7boRw
         PAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM95yKFhV2qB0CLFdficrXk+L5A5ZWpI+xeKTC4LLR4=;
        b=0ILSdHsLkTxvMlnmA6WGL7YPit+AkG0Mdnev2sPEyqAlLcKflUs8yoeq0Uo9OAz4mj
         Uukd0EpjR3w/7/x/bws0BrTqcM31Ep6/7NBSIP9sSu3otWdqElGi0t0o+QbqpZrvTQts
         8lX5kOqmVTTIuW4IgnG6uNGfWNmH0i/z32nDiizJVZKgU6IVwn2nrBUHMdGMfb73VyTV
         L9vMpn9rB9b/Cu8rNeTU8FIZrxHWdv8HwcG8RL8TAuz2I7ODfS8FPse04G4G2rxDkXaA
         a6BSFd2KWdLJfFhfkmOHOlyLIUIC8CzR46JbwCGK1WkWeGEtk4y112gBcIlvBe1Bg8aK
         3Q5Q==
X-Gm-Message-State: AOAM532dC13zrsE7rmEfacIonneGIbbK/mA2Bk5J0250SDelZjwG1XCA
        SGcMGtM5oiS5G5+qFwkRLDbOuHZuJvKHhmAUSmAcPg==
X-Google-Smtp-Source: ABdhPJzEbMp3ZvpKDgLtQu4wNxWAFrTqBeWqX6Aqj/xmtY9q+wfg++PSyhzP6c+xMWBunYmJCykjfQ77LGBkgUnCKv8=
X-Received: by 2002:a02:cbc2:: with SMTP id u2mr8073356jaq.96.1633541197109;
 Wed, 06 Oct 2021 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-5-dlatypov@google.com>
 <CABVgOS=SVHSrnTaa0hYsyn8KV_A7FCTaAmDx5ST6Jb2k4TXWSg@mail.gmail.com> <CAFd5g45qD0H1sO2n-NcgpVKm-QRRBVSHXLyMRr9mmJxKDgpWMw@mail.gmail.com>
In-Reply-To: <CAFd5g45qD0H1sO2n-NcgpVKm-QRRBVSHXLyMRr9mmJxKDgpWMw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 6 Oct 2021 10:26:25 -0700
Message-ID: <CAGS_qxqoGN50GL+TRV0rBUth+EEeS4USfH5AergZKBBV+oCEoA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kunit: tool: support running each suite/test separately
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 6, 2021 at 10:23 AM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Thu, Sep 30, 2021 at 4:05 PM David Gow <davidgow@google.com> wrote:
> >
> > On Fri, Oct 1, 2021 at 6:21 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > The new --run_isolated flag makes the tool boot the kernel once per
> > > suite or test, preventing leftover state from one suite to impact the
> > > other. This can be useful as a starting point to debugging test
> > > hermeticity issues.
> > >
> > > Note: it takes a lot longer, so people should not use it normally.
> > >
> > > Consider the following very simplified example:
> > >
> > >   bool disable_something_for_test = false;
> > >   void function_being_tested() {
> > >     ...
> > >     if (disable_something_for_test) return;
> > >     ...
> > >   }
> > >
> > >   static void test_before(struct kunit *test)
> > >   {
> > >     disable_something_for_test = true;
> > >     function_being_tested();
> > >     /* oops, we forgot to reset it back to false */
> > >   }
> > >
> > >   static void test_after(struct kunit *test)
> > >   {
> > >     /* oops, now "fixing" test_before can cause test_after to fail! */
> > >     function_being_tested();
> > >   }
> > >
> > > Presented like this, the issues are obvious, but it gets a lot more
> > > complicated to track down as the amount of test setup and helper
> > > functions increases.
> > >
> > > Another use case is memory corruption. It might not be surfaced as a
> > > failure/crash in the test case or suite that caused it. I've noticed in
> > > kunit's own unit tests, the 3rd suite after might be the one to finally
> > > crash after an out-of-bounds write, for example.
> > >
> > > Example usage:
> > >
> > > Per suite:
> > > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> > > ...
> > > Starting KUnit Kernel (1/7)...
> > > ============================================================
> > > ======== [PASSED] kunit_executor_test ========
> > > ....
> > > Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> > > Starting KUnit Kernel (2/7)...
> > > ============================================================
> > > ======== [PASSED] kunit-try-catch-test ========
> > > ...
> > >
> > > Per test:
> > > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> > > Starting KUnit Kernel (1/23)...
> > > ============================================================
> > > ======== [PASSED] kunit_executor_test ========
> > > [PASSED] parse_filter_test
> > > ============================================================
> > > Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> > > Starting KUnit Kernel (2/23)...
> > > ============================================================
> > > ======== [PASSED] kunit_executor_test ========
> > > [PASSED] filter_subsuite_test
> > > ...
> > >
> > > It works with filters as well:
> > > $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> > > ...
> > > Starting KUnit Kernel (1/1)...
> > > ============================================================
> > > ======== [PASSED] example ========
> > > ...
> > >
> > > It also handles test filters, '*.*skip*' runs these 3 tests:
> > >   kunit_status.kunit_status_mark_skipped_test
> > >   example.example_skip_test
> > >   example.example_mark_skipped_test
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > Reviewed-by: David Gow <davidgow@google.com>
> > > ---
> >
> > Thanks -- this version works for me.
> >
> > I think the requirement that test and suite names contain neither full
> > stops nor spaces is a reasonable one. There aren't any current tests
> > which would break it, as far as I know.
>
> I agree. Is this currently codified in the test naming conventions document?

https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html

We have
  Test suites are named after the subsystem they are part of. If a
subsystem contains several suites, the specific area under test should
be appended to the subsystem name, separated by an underscore.
  As tests are C functions, they should be named and written in
accordance with the kernel coding style.

So nothing is explicitly stated for test suites.
Just a preference for underscores, sorta implying you shouldn't use
spaces or other delimiters like periods.

>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAFd5g45qD0H1sO2n-NcgpVKm-QRRBVSHXLyMRr9mmJxKDgpWMw%40mail.gmail.com.
