Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2505F391F18
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhEZSas (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhEZSar (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 14:30:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E9C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 11:29:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o10so1747999ilm.13
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmhlWA1tcmd7i5WpuGzdloktFmGN5uwrhIb1Qmrmdq8=;
        b=eujV0BV0nOL+dAmq0I+fW3ZDP1ywprfFUR13/hpuElx7AmBAs7QBrYGxfUDU55/Z6K
         rDag5m1igx9H8jp53Ay34Y6dLDmb8fbMqlXjakwkJVrAd2oCmBhRGbGiTpeSjDhyTwT9
         jZFDrwqhn0AYSVRVTllg0kc+t+gBExetxtVemJtoOGvig+baW4kpuVdGLS/T3UTwo/rq
         Ku3at9oUpH4A2G86VByEu41gpafCs/CqWDdakg1Gr1sZsz2FzlW69XsN4olGsE1lBPU7
         sxdGkeCwrgPSRiMutxIRrLFrVkCAko3x9WYVrPIfFwg+mJuOjyfdml07p+/ACQ0Jxz6v
         +Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmhlWA1tcmd7i5WpuGzdloktFmGN5uwrhIb1Qmrmdq8=;
        b=NrWFqxWlLL1obt53sdcFeIyb8rYKfq/2k1Ua4PFxKOGmGrklRkFHn4zdpdgrn8jqVq
         1L5949+b2KXYMaCK+EbyEVVdU76XGRYKlx507Gp6W1gZGHHD5OVj3HfClkQ//8++4++I
         +eqQx7xD371KL4DEAt8In0h1iT0s0lWV4gCWCKX3AaI3dpRNw1HCjbEbMsfdCgEWNe3+
         EQyN7BtLIENRA/Kz2Sqz9kUVbOEYETPDMRWtmEIoWqJltPY/tFVsG2Dz19jpibLvja44
         F6EAK/cTkTo81Gs9IH6I/zf2LXzN2jf118MsZgNiP7jHP2KUdXP9dWciydSIBRK1kdQt
         kzlg==
X-Gm-Message-State: AOAM530xO9XOW7U3kf6czJgFt/hsroLf3FnipjtWJvOUS08Hj7KHDIxM
        umcC5fbiCC1EYnDy0l1r+qO41FPF/09nyDILbQTXVQ==
X-Google-Smtp-Source: ABdhPJyQxhvNJ1T571Xy4x9pQnOTA36skTI7ksgiynb0ysIu58FsLu8vxkO9i44GwrTY+q6YCOQDSM2tYdZ1MSOaz0A=
X-Received: by 2002:a92:c70b:: with SMTP id a11mr30705547ilp.136.1622053755188;
 Wed, 26 May 2021 11:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <20210526081112.3652290-3-davidgow@google.com>
 <YK4NRlyrYJ8ktsWQ@elver.google.com>
In-Reply-To: <YK4NRlyrYJ8ktsWQ@elver.google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 May 2021 11:29:03 -0700
Message-ID: <CAGS_qxp=EV1iy5tCs+YpxH-Pug=MDTBXo3jSc13-h7HJnzBnDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: test: Add example_skip test suite which is
 always skipped
To:     Marco Elver <elver@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 26, 2021 at 1:56 AM 'Marco Elver' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> > Add a new KUnit test suite which contains tests which are always
> > skipped. This is used as an example for how to write tests which are
> > skipped, and to demonstrate the difference between kunit_skip() and
> > kunit_mark_skipped().
> >
> > Because these tests do not pass (they're skipped), they are not enabled
> > by default, or by the KUNIT_ALL_TESTS config option: they must be
> > enabled explicitly by setting CONFIG_KUNIT_EXAMPLE_SKIP_TEST=y in either
> > a .config or .kunitconfig file.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  lib/kunit/Kconfig                   | 15 +++++++++
> >  lib/kunit/Makefile                  |  2 ++
> >  lib/kunit/kunit-example-skip-test.c | 52 +++++++++++++++++++++++++++++
> >  3 files changed, 69 insertions(+)
> >  create mode 100644 lib/kunit/kunit-example-skip-test.c
>
> I don't know if this test is useful for a user of KUnit. Given it's not
> testing KUnit functionality (I see you added tests that the feature
> works in patch 1/3), but rather a demonstration and therefore dead code.
> I don't think the feature is difficult to understand from the API doc
> text.
>
> Instead, would it be more helpful to add something to
> Documentation/dev-tools/kunit? Or perhaps just add something to
> lib/kunit/kunit-example-test.c? It'd avoid introducing more Kconfig

I'm in favor of putting it in kunit-example-test.c as well.

But I hear there was pushback to have a non-passing test in the example?
I guess the fear is that someone will see something that doesn't say
"passed" in the example output and think something has gone wrong?

Hence this more conservative change.
But I hope that in the absence of any replies in opposition, we can
just keep one example-test.c

> options at least.
>
> Thanks,
> -- Marco
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/YK4NRlyrYJ8ktsWQ%40elver.google.com.
