Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E499E29FE5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 08:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJ3HWw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 03:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3HWv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 03:22:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77CC0613D3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 00:22:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i2so5846391ljg.4
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jP/zlBzvvGdT4+2/zjgwcM/I3DRgZiU14M8AdD3umM=;
        b=fYQP+PVeNcV26dBeX7kcma6dzmJlP1Bdz9T9EGXILiNtWKPtioJxVDUK3xDQkI3hew
         IFmrTkedpAa3viOa73NM5n7w7RCSaZbSlrQqE/Xi5sTl/WyqguYMwaZ7LTWDbjwKwsvj
         H0MTBGPQqn3yvEIqlCuuUXkOovuc3gVOEJeJTNFr9KmgxDei87M6e6QW/UOWMJ8BDama
         tCl9snHe4n//f2TVgH4P8I3ZtSuqKwZ9PpAXJS08Y0yR3r+vjD/mF3wVH/8PWDjzl0Gx
         gDOXODl//7VQ1yig4z9izG3Emw1WOusXBa+79Bu0vUtYabZie0hcxjzgwsrPzJxOI6B4
         GOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jP/zlBzvvGdT4+2/zjgwcM/I3DRgZiU14M8AdD3umM=;
        b=SOh3BsV4lXXzeg8Hi2StDknLZjRVfPYw79gYgfJGklSH/k7UY02KJoTUTnUhxjTe4u
         6ZqeOVFP7lmEB1ZyNjPXHaCzfhd9oJdcpCpCV5DsyGHsqvz5I2Csx26cEMeZfH7NaB5h
         9rIGP7XXBzrKm+/CSGAT6UWw7gp3wAFmFinzxKo3IPBLSA7GtJaJrjNuuISobZJVignk
         WEcUsnaK0/t8WG2YNSLkhPkwG4Pd9kZQrjaFYApLG63GNbJRSdNivQ2OP9jT0K6WZca6
         tJP6OzXkLOR0xIs9TATE1HekRYMDRlaY0N97WGigiQ9e2Gww/0mBLvhpm0iSjF0p8ePn
         Tf0g==
X-Gm-Message-State: AOAM5304bCgvvFX66pAarQS4XJvnr0NKnyY4nmKIrmp83GDaW10mGpoW
        v1aSFHbcDv4RJXDsYsYZy4BcLxiYxMGklv9KFJjpBw==
X-Google-Smtp-Source: ABdhPJwXbYJuODsKWa1F8WEroy9dh/4cLqUzXIJJcBF0AmXk7vS4dFSTFr0MRN7h3EW+SxW0YNZH8C07Ba22O1wxMeg=
X-Received: by 2002:a2e:9a89:: with SMTP id p9mr472806lji.363.1604042566041;
 Fri, 30 Oct 2020 00:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201020233219.4146059-1-dlatypov@google.com> <CABVgOSnPpC=j7MrcmDpvvG6i_voiFQe4137ieyYX+-9B4=G39w@mail.gmail.com>
 <CAGS_qxpp5ZwA_fWuSG0_P2azS2PpojQDQjzQrwWqYoNNZYs7tg@mail.gmail.com>
In-Reply-To: <CAGS_qxpp5ZwA_fWuSG0_P2azS2PpojQDQjzQrwWqYoNNZYs7tg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Oct 2020 15:22:34 +0800
Message-ID: <CABVgOSkbq+t919Bf6z_Ua=WSmOuCCRPy5fe+sseR2R65QtyrCg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix extra trailing \n in parsed test output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 30, 2020 at 1:41 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Oct 29, 2020 at 7:34 PM David Gow <davidgow@google.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 7:32 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > For simplcity, strip all trailing whitespace from parsed output.
> > > I imagine no one is printing out meaningful trailing whitespace via
> > > KUNIT_FAIL() or similar, and that if they are, they really shouldn't.
> > >
> > > At some point, the lines from `isolate_kunit_output()` started having
> > > trailing \n, which results in artifacty output like this:
> > >
> > > $ ./tools/testing/kunit/kunit.py run
> > > [16:16:46] [FAILED] example_simple_test
> > > [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > >
> > > [16:16:46]     Expected 1 + 1 == 3, but
> > >
> > > [16:16:46]         1 + 1 == 2
> > >
> > > [16:16:46]         3 == 3
> > >
> > > [16:16:46]     not ok 1 - example_simple_test
> > >
> > > [16:16:46]
> > >
> > > After this change:
> > > [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > > [16:16:46]     Expected 1 + 1 == 3, but
> > > [16:16:46]         1 + 1 == 2
> > > [16:16:46]         3 == 3
> > > [16:16:46]     not ok 1 - example_simple_test
> > > [16:16:46]
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > Thanks! This is a long-overdue fix, and it worked well for me.
> >
> > Tested-by: David Gow <davidgow@google.com>
> >
> > One comment below:
> >
> > >  tools/testing/kunit/kunit_parser.py | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > > index 8019e3dd4c32..e68b1c66a73f 100644
> > > --- a/tools/testing/kunit/kunit_parser.py
> > > +++ b/tools/testing/kunit/kunit_parser.py
> > > @@ -342,7 +342,8 @@ def parse_run_tests(kernel_output) -> TestResult:
> > >         total_tests = 0
> > >         failed_tests = 0
> > >         crashed_tests = 0
> > > -       test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
> > > +       test_result = parse_test_result(list(
> > > +            l.rstrip() for l in isolate_kunit_output(kernel_output)))
> >
> > Could we do this inside isolate_kunit_output() instead? That seems
> > like it'd be a more logical place for it (removing the newline is a
> > sort of isolating the output), and it'd avoid making this line quite
> > as horrifyingly nested.
>
> Good point.
> We could either do it on each yield (messy), or before, i.e.
>
> diff --git a/tools/testing/kunit/kunit_parser.py
> b/tools/testing/kunit/kunit_parser.py
> index 8019e3dd4c32..14d35deb96cd 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -54,6 +54,7 @@ kunit_end_re = re.compile('(List of all partitions:|'
>  def isolate_kunit_output(kernel_output):
>         started = False
>         for line in kernel_output:
> +               line = line.rstrip()  # line always has a trailing \n
>                 if kunit_start_re.search(line):
>                         prefix_len = len(line.split('TAP version')[0])
>                         started = True
>
> I had some vague concerns about this as
>   kunit_start_re = re.compile(r'TAP version [0-9]+$')
> has that anchor at the end.
>
> This could ostensibly make it match more things than before.
> Since I'm using rstrip() out of laziness, that means strings like
>   '<prefix we allow for some reason>TAP version 42\t\n'
> will now also match.
>
> I don't really think that's an issue, but I'd sent this as a more
> conservative change initially.
> I can send the diff above as a replacement for this patch.

I prefer this if it works. From my cursory testing, it does (though
the kunt_tool_tests.py tests will need updating). At the very least,
I'm able to get it to work with --alltests / allyesconfig (with a few
options tactically disabled), which was the main reason we needed
isolate_kunit_output() in the first place.

So, unless anyone can find a real-world case where this breaks
something, let's go with this.

Cheers,
-- David

>
> >
> > >         if test_result.status == TestStatus.NO_TESTS:
> > >                 print(red('[ERROR] ') + yellow('no tests run!'))
> > >         elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
> > >
> > > base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
> > > --
> > > 2.29.0.rc1.297.gfa9743e501-goog
> > >
