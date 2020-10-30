Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF33629FD6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 06:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgJ3FvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 01:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgJ3FvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 01:51:03 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EB5C0613D2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 22:41:10 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k1so5477078ilc.10
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHipm2XujaINtvFS+rrII56nB/BYuCRUdfDAjG82cBQ=;
        b=Vp61Rc9wuxy8fhr3qgcAwZUOiVQotxZLWmpHP0u/iY9r2p+upp0njZN5FDS977qjW9
         wEERFCcZNXzPoynCOD6jqo/btcMRtx1l5bTDFr55CzPLi5ip3+5vzK4hNhz830RQMecU
         CMc2UmCKjsEDW6xNh3dr1/QeD4MA4vwMlJq6hBmtTydr4bajny2GEl4CPYrc+0qIUKkI
         HJa5dMkYe645EiCdxrU7UVvDWs5mQH2Geg6o4rQywKFCpDffNue7GbqSMiw/E1FwH7iI
         WjR7DabQ1w2DI8SbOx8pugi64VLkdkosN3a43EPXHabw4lJg+RbMFiEZSX9h7NUT2gJ1
         R/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHipm2XujaINtvFS+rrII56nB/BYuCRUdfDAjG82cBQ=;
        b=qEX/yrFjzoDTjg5PBjOuB3tqkTt/0jWRensaEWwXtf7S+hKn4/iDiQYxJ9MTUnM2Qa
         pVlT/wJCJlnVv8n2tPUvSruf0B12eDRQ2yP1H/GtfCJ+R0Kud8kfEvcpVnQ2kIBb+ljn
         p+iYnmnQFtptb8vztpKjo0QP/aV3oWgRag8HDg2RXAvZ1cuCs70lbJGH0uddjRFH/hI6
         9Tlhe2ER9OMeqJm7sUqeHNjitKESqi56tjqwT600gOoWwNZDnAd7/FWfVYkmCsVp78hJ
         uKjxOQDB5NJrrZJdbvxQCXJMHElYY/0YBnYRRl6J4wtmSWoGhY7gOjBFFhWdu3+wtmlV
         621w==
X-Gm-Message-State: AOAM532xGo9Bn0jgeH/Wj1P5SHReSwDViZFOQujepwvt8jOPKOF8YgwC
        EnK06q8iSW4Rh76Wlq/CHGNSP64l6yLgWgi/E8wAyA==
X-Google-Smtp-Source: ABdhPJyA5SIb0JNBWxVgZWVTFJ3rMbrPUGW1KSxc3lgsNoII7j0FjkRZgxw5Szdhk0JmHQek6YfrOb6C36D+i5HA7AM=
X-Received: by 2002:a92:8bc6:: with SMTP id i189mr589001ild.253.1604036469916;
 Thu, 29 Oct 2020 22:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201020233219.4146059-1-dlatypov@google.com> <CABVgOSnPpC=j7MrcmDpvvG6i_voiFQe4137ieyYX+-9B4=G39w@mail.gmail.com>
In-Reply-To: <CABVgOSnPpC=j7MrcmDpvvG6i_voiFQe4137ieyYX+-9B4=G39w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 29 Oct 2020 22:40:58 -0700
Message-ID: <CAGS_qxpp5ZwA_fWuSG0_P2azS2PpojQDQjzQrwWqYoNNZYs7tg@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 7:34 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Oct 21, 2020 at 7:32 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > For simplcity, strip all trailing whitespace from parsed output.
> > I imagine no one is printing out meaningful trailing whitespace via
> > KUNIT_FAIL() or similar, and that if they are, they really shouldn't.
> >
> > At some point, the lines from `isolate_kunit_output()` started having
> > trailing \n, which results in artifacty output like this:
> >
> > $ ./tools/testing/kunit/kunit.py run
> > [16:16:46] [FAILED] example_simple_test
> > [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> >
> > [16:16:46]     Expected 1 + 1 == 3, but
> >
> > [16:16:46]         1 + 1 == 2
> >
> > [16:16:46]         3 == 3
> >
> > [16:16:46]     not ok 1 - example_simple_test
> >
> > [16:16:46]
> >
> > After this change:
> > [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > [16:16:46]     Expected 1 + 1 == 3, but
> > [16:16:46]         1 + 1 == 2
> > [16:16:46]         3 == 3
> > [16:16:46]     not ok 1 - example_simple_test
> > [16:16:46]
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Thanks! This is a long-overdue fix, and it worked well for me.
>
> Tested-by: David Gow <davidgow@google.com>
>
> One comment below:
>
> >  tools/testing/kunit/kunit_parser.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index 8019e3dd4c32..e68b1c66a73f 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -342,7 +342,8 @@ def parse_run_tests(kernel_output) -> TestResult:
> >         total_tests = 0
> >         failed_tests = 0
> >         crashed_tests = 0
> > -       test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
> > +       test_result = parse_test_result(list(
> > +            l.rstrip() for l in isolate_kunit_output(kernel_output)))
>
> Could we do this inside isolate_kunit_output() instead? That seems
> like it'd be a more logical place for it (removing the newline is a
> sort of isolating the output), and it'd avoid making this line quite
> as horrifyingly nested.

Good point.
We could either do it on each yield (messy), or before, i.e.

diff --git a/tools/testing/kunit/kunit_parser.py
b/tools/testing/kunit/kunit_parser.py
index 8019e3dd4c32..14d35deb96cd 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -54,6 +54,7 @@ kunit_end_re = re.compile('(List of all partitions:|'
 def isolate_kunit_output(kernel_output):
        started = False
        for line in kernel_output:
+               line = line.rstrip()  # line always has a trailing \n
                if kunit_start_re.search(line):
                        prefix_len = len(line.split('TAP version')[0])
                        started = True

I had some vague concerns about this as
  kunit_start_re = re.compile(r'TAP version [0-9]+$')
has that anchor at the end.

This could ostensibly make it match more things than before.
Since I'm using rstrip() out of laziness, that means strings like
  '<prefix we allow for some reason>TAP version 42\t\n'
will now also match.

I don't really think that's an issue, but I'd sent this as a more
conservative change initially.
I can send the diff above as a replacement for this patch.

>
> >         if test_result.status == TestStatus.NO_TESTS:
> >                 print(red('[ERROR] ') + yellow('no tests run!'))
> >         elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
> >
> > base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
> > --
> > 2.29.0.rc1.297.gfa9743e501-goog
> >
