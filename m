Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29362AE75
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 23:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKOWlu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 17:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKOWlS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 17:41:18 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56443DE90
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 14:41:17 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-381662c78a9so70383497b3.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6PHQLoSpI9ieMb01SGmNV+k3baSXTLXsQJ3u3XtAP4Q=;
        b=eVMDaIyDnRoiBZbS3qpDVHFwht2msUL46zFdpPNpNUUOI6VJNt9S8COXwpm+D13UgQ
         SMSUVDTkiQmT8YV/KO65wI4YPvoRUVhAh8uxBJa+N57pOC/+qMUEpK7QZwZBbBLYdlyS
         gBZUA6x/2d+GIG7NJ39CDWc5fmPWHTyCq2FF7AKVwux1JSWUNSJdgOCLBJQYtryKQ1PP
         y/wZ42KVK/ffbwstcO7g/qw6nMHWJYjA9apW1XotOiplRgNAgwU6U6VkzTw2dlPuRTXM
         vEIYRtWQPe0KCHlRepvSqBV6gXGyxZZqhuLsR29XxT+/xEtM7BVuVrdylL1DOy2HXBX9
         tDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PHQLoSpI9ieMb01SGmNV+k3baSXTLXsQJ3u3XtAP4Q=;
        b=HTUbML6UCaXCN/3DDFtTUl+7V37DodEn1iu8MTS3zmZIhwIitBQkl1aHBdCp5su/Kn
         PAeLNzVX89IOCrdZJFJOOtNEx2ooZwfS0DuqnyQk7wnTHPhkhT06SDeDq04Jru+vQTrS
         DKTUyIul7nD1hD6C5lFMYRFppTIfFp3WhVZ8ukli5bGJcXBHCpMnIcrSKYb55NGp0F1/
         uOf3jt5SNNv91//Yy+PIdw50+mjmtybvcc302E4JyaQiLHbTk9VXFXSBsTaihWTOA4FB
         sr6gb+UfRu0H1KpsyXUFt5PdQMobqDjXUEK1P470GXIY/UY9nDwG83TZtNrS3Gg92RTF
         239Q==
X-Gm-Message-State: ANoB5pkxwWSwMqnJmwdMLa3hhpRZSU0knotzljXdCQrRqvvUO6U9rERl
        ZlBoqlG0+kOfiFIjS8kqfZ75+1Rae3Fb/7rNktQrhQ==
X-Google-Smtp-Source: AA0mqf5t66GapSerW6ciaSUVTlYlP07ofM3pS23X8mgEZHL5nydMPobMYst+uTfw0VFXedMfhtdvplNRpTuCF6i4pMs=
X-Received: by 2002:a81:52ca:0:b0:388:dd9b:f3ee with SMTP id
 g193-20020a8152ca000000b00388dd9bf3eemr2260245ywb.164.1668552076399; Tue, 15
 Nov 2022 14:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <CABVgOSnUDNvs6mYwVtzXq3+PmO62HG1pP=d_6EQiwOKF_9D6XA@mail.gmail.com>
 <CA+GJov4uUfp_a7FzCEMGivQJx3VGNOx=x+E_eN-9a46EsS2Ygg@mail.gmail.com>
In-Reply-To: <CA+GJov4uUfp_a7FzCEMGivQJx3VGNOx=x+E_eN-9a46EsS2Ygg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 15 Nov 2022 14:41:05 -0800
Message-ID: <CAGS_qxqa6NW5EKA0y3Szp_6rEMfam5urSVRHaGVRZUHgmab8SA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: improve KTAP compliance of KUnit test output
To:     Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Isabella Basso <isabbasso@riseup.net>,
        Anders Roxell <anders.roxell@linaro.org>
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

On Tue, Nov 15, 2022 at 12:18 PM Rae Moar <rmoar@google.com> wrote:
> Yes, I agree. I think it does make more sense to provide KTAP
> compatibility with the parser before changing the test output. This
> would also help to solve the issue that Daniel brought up on this
> patch about the "KTAP version 1" line and test plan being stored
> in the test.log as random kernel output. I will swap the patches in
> the v2 of this patch series.
>
> >
> > I'd also be curious to see if this is likely to break anyone else's
> > (K)TAP parsers.
> >
> > +Isabella, Anders: do these changes break the IGT or LKFT TAP/KTAP
> > parsing? From a quick look at [1] and [2], we're probably okay??
> >
> > [1]: https://gitlab.freedesktop.org/isinyaaa/igt-gpu-tools/-/commit/1a84306425e975377eb79c031bf1de147bd44e46
> > [2]: https://github.com/Linaro/test-definitions/blob/master/automated/linux/kunit/kunit.sh
> >
> > I also looked into the possibility of moving or removing the Subtest
> > line, but upon further thought (see below), it's probably best to keep
> > it as-is here for now. That should be the closest to the current spec,
> > and we can possibly find a better way to provide the name in KTAPv2.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
> >
> > >  lib/kunit/executor.c | 6 +++---
> > >  lib/kunit/test.c     | 5 +++--
> > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > > index 9bbc422c284b..74982b83707c 100644
> > > --- a/lib/kunit/executor.c
> > > +++ b/lib/kunit/executor.c
> > > @@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
> > >  {
> > >         size_t num_suites = suite_set->end - suite_set->start;
> > >
> > > -       pr_info("TAP version 14\n");
> > > +       pr_info("KTAP version 1\n");
> > >         pr_info("1..%zu\n", num_suites);
> > >
> > >         __kunit_test_suites_init(suite_set->start, num_suites);
> > > @@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
> > >         struct kunit_suite * const *suites;
> > >         struct kunit_case *test_case;
> > >
> > > -       /* Hack: print a tap header so kunit.py can find the start of KUnit output. */
> > > -       pr_info("TAP version 14\n");
> > > +       /* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
> > > +       pr_info("KTAP version 1\n");
> > >
> > >         for (suites = suite_set->start; suites < suite_set->end; suites++)
> > >                 kunit_suite_for_each_test_case((*suites), test_case) {
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index 90640a43cf62..b541d59a05c3 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -151,6 +151,7 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
> > >  {
> > >         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
> > >                   suite->name);
> > > +       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> >
> > Would it make sense to have the Subtest line _after_ the KTAP line here?
> >
> > Given KTAP doesn't specify the "Subtest" line at all, I guess it doesn't matter.
> >
> > A part of me feels that the "KTAP version 1" line should be the
> > _first_ line of the subtest output, but that would introduce a line
> > between it and the test plan, which goes against the spec.
> >
> > We could also just get rid of the "Subtest" line, given it's not
> > technically required, though having the test name before the results
> > is really useful.
> >
> > Having tried all three options while writing this email, I think it's
> > probably best to leave this patch as is (with the Subtest line
> > followed by the KTAP line), and discuss standardising something
> > similar as part of the KTAP v2 spec.
> >
>
> I also struggle to decide how the "Subtest" line should be handled. Since
> the current KTAP v1 spec does not provide a way to declare the name of
> a test with subtests prior to the results, I think it is important to continue
> to include this Subtest line because it provides that functionality.
> Additionally,
> the line is not expected to be very disruptive for other parsers because it
> is read as a diagnostic line.

Yeah, since it's going to be ignored as a diagnostic line, I think
we're largely free to put it where we want?

I'm actually leaning towards making things more uniform e.g.

KTAP version 1
# Subtest: optionally set for the top-level test!
1..2
  KTAP version 1
  # Subtest: suite1
  1..1
  ok 1 - test1
 ok 1 -suite1
 // etc.

Then we can simplify the parser by not differentiating (as much)
between the top-level test and subtests.
This also simplifies parsing multiple KTAP documents (e.g. for
supporting modules, etc.)

We'll probably talk about this offline soon, but I wanted to put this out there.

Daniel


>
> The location of the "Subtest" line before the KTAP version line is potentially
> not the most optimal but it seems to be the best choice while ensuring
> compatibility with the current KTAP v1 spec. I recommend that we discuss
> a standardized replacement for this "Subtest" line in the KTAP v2 spec.
