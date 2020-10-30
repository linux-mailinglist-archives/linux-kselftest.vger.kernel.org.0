Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0932A10FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgJ3WkX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJ3WkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 18:40:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B39C0613D7
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 15:40:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s7so9095721iol.12
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPiHiPR7+ri0iS+ZKcEuF5v+EX92UMPdQOzhZido+90=;
        b=V+1Ed5WWxhUEd2T+xYfgrxQLcLBRp/fDTNPqWMqBJRbP37K0HXQmGkreqcmY1+e6xy
         cwz6NoS0bV1KK1rY4bDZ7/+JjvS63QyzVAbG6gra9eCDQVHYnIKP79aR6If622aUK9Qt
         g7+lI2LEEXI2vsA70xU/sPxJX6bDBNLl1Xo1rgWnM8h0kmXaNHMf/mY5Nkv7j0p20YIZ
         9tvrBCXDDlbtNBdq37yVVuZ9suuxTgAJBny88Pt2VmozIff6pGdHNMN/2JyU2wgoJzTu
         jJ8Py3pgSbyldg6SBtlougxENzmSYMuUap4glz86k/Mj5GBRZ4UiPGrhQTGeMaZ3Xt2s
         FTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPiHiPR7+ri0iS+ZKcEuF5v+EX92UMPdQOzhZido+90=;
        b=EIj8n3T08iJjod0gytCGEHMJ94M+qPRxY7MDKi31mBUkS1XHYPCAWieKNl5FuFJbwg
         iLJbl8EIxm5tXBQV54OrvbTZ303OmDD5QgNdpxpOVThgM/7ch3PkDZYEcBU7VGg/RSpX
         9WFKI05HfxcVHat4u8jKc0RxGy9hrdxcuxs/FHKJoxgGjkNFUoOZd3bxPLGnE6hROHb+
         YpEJ51zWx0af5zFaEgTIFA0xnsUaYvxeJSNDQRvCeYbq1AAhfPgG9MEz4+hP/VikMQLG
         1GrzWMLxd5Bsblq9JvaPvIXATLAl25KWVoSK+HNvvjcEHpQbwm1MieJmp+2aQuCavyh1
         mN5A==
X-Gm-Message-State: AOAM533uKxWYIiqf/tOhIErU1im7dOqhSkasbceEb4lIpYeJ0D6QyS2A
        c5lflxJeFszpQlkNiqdqTgmusNMX7gJ5CrJPVuJGlZU0PR3bgA==
X-Google-Smtp-Source: ABdhPJycj4MjGkAuGF0rlZv4n/ZCRZtVJcarw1o17K1FczKhw3FxWPknw794sFF0U+P4iN2gyyj2p5UhWHkK0YqstfE=
X-Received: by 2002:a05:6602:235b:: with SMTP id r27mr3557242iot.123.1604097621978;
 Fri, 30 Oct 2020 15:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201020233219.4146059-1-dlatypov@google.com> <CABVgOSnPpC=j7MrcmDpvvG6i_voiFQe4137ieyYX+-9B4=G39w@mail.gmail.com>
 <CAGS_qxpp5ZwA_fWuSG0_P2azS2PpojQDQjzQrwWqYoNNZYs7tg@mail.gmail.com> <CABVgOSkbq+t919Bf6z_Ua=WSmOuCCRPy5fe+sseR2R65QtyrCg@mail.gmail.com>
In-Reply-To: <CABVgOSkbq+t919Bf6z_Ua=WSmOuCCRPy5fe+sseR2R65QtyrCg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 30 Oct 2020 15:40:10 -0700
Message-ID: <CAGS_qxo75FDOpG3e3eskWMx3CoveiyG+ujM-sxuLWw4+7myh5g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix extra trailing \n in parsed test output
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 30, 2020 at 12:22 AM David Gow <davidgow@google.com> wrote:
>
> On Fri, Oct 30, 2020 at 1:41 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Thu, Oct 29, 2020 at 7:34 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Wed, Oct 21, 2020 at 7:32 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > >
> > > > For simplcity, strip all trailing whitespace from parsed output.
> > > > I imagine no one is printing out meaningful trailing whitespace via
> > > > KUNIT_FAIL() or similar, and that if they are, they really shouldn't.
> > > >
> > > > At some point, the lines from `isolate_kunit_output()` started having
> > > > trailing \n, which results in artifacty output like this:
> > > >
> > > > $ ./tools/testing/kunit/kunit.py run
> > > > [16:16:46] [FAILED] example_simple_test
> > > > [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > > >
> > > > [16:16:46]     Expected 1 + 1 == 3, but
> > > >
> > > > [16:16:46]         1 + 1 == 2
> > > >
> > > > [16:16:46]         3 == 3
> > > >
> > > > [16:16:46]     not ok 1 - example_simple_test
> > > >
> > > > [16:16:46]
> > > >
> > > > After this change:
> > > > [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > > > [16:16:46]     Expected 1 + 1 == 3, but
> > > > [16:16:46]         1 + 1 == 2
> > > > [16:16:46]         3 == 3
> > > > [16:16:46]     not ok 1 - example_simple_test
> > > > [16:16:46]
> > > >
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > ---
> > >
> > > Thanks! This is a long-overdue fix, and it worked well for me.
> > >
> > > Tested-by: David Gow <davidgow@google.com>
> > >
> > > One comment below:
> > >
> > > >  tools/testing/kunit/kunit_parser.py | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > > > index 8019e3dd4c32..e68b1c66a73f 100644
> > > > --- a/tools/testing/kunit/kunit_parser.py
> > > > +++ b/tools/testing/kunit/kunit_parser.py
> > > > @@ -342,7 +342,8 @@ def parse_run_tests(kernel_output) -> TestResult:
> > > >         total_tests = 0
> > > >         failed_tests = 0
> > > >         crashed_tests = 0
> > > > -       test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
> > > > +       test_result = parse_test_result(list(
> > > > +            l.rstrip() for l in isolate_kunit_output(kernel_output)))
> > >
> > > Could we do this inside isolate_kunit_output() instead? That seems
> > > like it'd be a more logical place for it (removing the newline is a
> > > sort of isolating the output), and it'd avoid making this line quite
> > > as horrifyingly nested.
> >
> > Good point.
> > We could either do it on each yield (messy), or before, i.e.
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py
> > b/tools/testing/kunit/kunit_parser.py
> > index 8019e3dd4c32..14d35deb96cd 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -54,6 +54,7 @@ kunit_end_re = re.compile('(List of all partitions:|'
> >  def isolate_kunit_output(kernel_output):
> >         started = False
> >         for line in kernel_output:
> > +               line = line.rstrip()  # line always has a trailing \n
> >                 if kunit_start_re.search(line):
> >                         prefix_len = len(line.split('TAP version')[0])
> >                         started = True
> >
> > I had some vague concerns about this as
> >   kunit_start_re = re.compile(r'TAP version [0-9]+$')
> > has that anchor at the end.
> >
> > This could ostensibly make it match more things than before.
> > Since I'm using rstrip() out of laziness, that means strings like
> >   '<prefix we allow for some reason>TAP version 42\t\n'
> > will now also match.
> >
> > I don't really think that's an issue, but I'd sent this as a more
> > conservative change initially.
> > I can send the diff above as a replacement for this patch.
>
> I prefer this if it works. From my cursory testing, it does (though
> the kunt_tool_tests.py tests will need updating). At the very least,
> I'm able to get it to work with --alltests / allyesconfig (with a few
> options tactically disabled), which was the main reason we needed
> isolate_kunit_output() in the first place.
>
> So, unless anyone can find a real-world case where this breaks
> something, let's go with this.

Sounds good.
Sent https://lore.kernel.org/linux-kselftest/20201030223853.554597-1-dlatypov@google.com

>
> Cheers,
> -- David
>
> >
> > >
> > > >         if test_result.status == TestStatus.NO_TESTS:
> > > >                 print(red('[ERROR] ') + yellow('no tests run!'))
> > > >         elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
> > > >
> > > > base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
> > > > --
> > > > 2.29.0.rc1.297.gfa9743e501-goog
> > > >
