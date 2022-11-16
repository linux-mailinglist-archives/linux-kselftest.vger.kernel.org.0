Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80162CDAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 23:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiKPWa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 17:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiKPWaW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 17:30:22 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E92656ED8
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 14:30:13 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso11342666otr.9
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SV3uKtw9a8vN8yUmKx3X+E8DjkwYVURzpTYzGnpG9LQ=;
        b=O2WJQwZhVNsc9oob3fiv7On6XAXAzUk/x70nTp0Hz1tt/eRiQZ+k5+/0CTvE9qc9cQ
         lFkxj8SLVSY4BP5YbC3CQVJQ4kdL8v0P1lgDdbhPNFQZRiRWZ7vBXhNyNz0kK4XoK1RT
         3An4bCKdtoE6Y8q0Dpnpobw9RvwctbzQY1bWmc0mcKAcue2GDA6ne9GLIoifFtbbo8F+
         B2jiwW0wzR78GuXoDnfGULLVq4OwkfIxP6wwLaEwggFYSmnIiUYg4qJe2QmBOqF63fNX
         vdhfI0cyVOnfv+93Irx9eMG6g2v6Al0GNJyzfOip+go+TNbBVEpHejp854sMSCf60vCj
         dLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV3uKtw9a8vN8yUmKx3X+E8DjkwYVURzpTYzGnpG9LQ=;
        b=h28vHrYOr0M4ySWz8wGyY3hT/iTK7ZKI6LcBJYKXSMyZJ3MYzLEQMtnZKtMq/8dXMc
         g/nXl30MYK/aY4we4eAl0tVob7OK/xpCkCb0TnY55p+EGpgaTK3ojqWOhSsktWC42nwj
         WQNwAgvw6G8zER63huaC4SL3fBx11ASEZklhR/ZjKAfVQ4I9AG9m7Vlx1Of+I3p9/kyk
         oDu7trnHr84r2TysCoc4d4O3lVOtO+/pnxbdwxcsd+Bq34oIJ03kd9yIbVGhxlMjpP3D
         5GOiwJ6aP06toZkRMZm0FRsBVw5zI0iXh22nn0v5jDeBv4mw2D94oBJZ7Ff5t6Chrfi0
         1wlw==
X-Gm-Message-State: ANoB5pl6y41yRCbEw+W5u19f9oTx02XF5+0of8O6EyXdjzWkP7xvqxoS
        jTRaOgxmNf6CT87Ug7CoN/ZTm2KuP+sLiUTtvkp5JQ==
X-Google-Smtp-Source: AA0mqf4kjRY9+AOr7lJMwpjgLCuJDtEo22o/x+DJmA14pLlViHfgrBHEyBmkTC5Y75tAqCDigjMAkX7tytffXyS3DzA=
X-Received: by 2002:a9d:7344:0:b0:66c:3ca7:1e4f with SMTP id
 l4-20020a9d7344000000b0066c3ca71e4fmr91779otk.322.1668637812351; Wed, 16 Nov
 2022 14:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <CABVgOSnUDNvs6mYwVtzXq3+PmO62HG1pP=d_6EQiwOKF_9D6XA@mail.gmail.com>
 <CA+GJov4uUfp_a7FzCEMGivQJx3VGNOx=x+E_eN-9a46EsS2Ygg@mail.gmail.com> <CAGS_qxqa6NW5EKA0y3Szp_6rEMfam5urSVRHaGVRZUHgmab8SA@mail.gmail.com>
In-Reply-To: <CAGS_qxqa6NW5EKA0y3Szp_6rEMfam5urSVRHaGVRZUHgmab8SA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 16 Nov 2022 17:30:00 -0500
Message-ID: <CA+GJov6Ot9KeMtk_L_qX=k2rwFgpPZG7gLG6HFQ+uhnLjDEFVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: improve KTAP compliance of KUnit test output
To:     Daniel Latypov <dlatypov@google.com>
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

On Tue, Nov 15, 2022 at 5:41 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Nov 15, 2022 at 12:18 PM Rae Moar <rmoar@google.com> wrote:
> > Yes, I agree. I think it does make more sense to provide KTAP
> > compatibility with the parser before changing the test output. This
> > would also help to solve the issue that Daniel brought up on this
> > patch about the "KTAP version 1" line and test plan being stored
> > in the test.log as random kernel output. I will swap the patches in
> > the v2 of this patch series.
> >
> > >
> > > I'd also be curious to see if this is likely to break anyone else's
> > > (K)TAP parsers.
> > >
> > > +Isabella, Anders: do these changes break the IGT or LKFT TAP/KTAP
> > > parsing? From a quick look at [1] and [2], we're probably okay??
> > >
> > > [1]: https://gitlab.freedesktop.org/isinyaaa/igt-gpu-tools/-/commit/1a84306425e975377eb79c031bf1de147bd44e46
> > > [2]: https://github.com/Linaro/test-definitions/blob/master/automated/linux/kunit/kunit.sh
> > >
> > > I also looked into the possibility of moving or removing the Subtest
> > > line, but upon further thought (see below), it's probably best to keep
> > > it as-is here for now. That should be the closest to the current spec,
> > > and we can possibly find a better way to provide the name in KTAPv2.
> > >
> > > Reviewed-by: David Gow <davidgow@google.com>
> > >
> > > Cheers,
> > > -- David
> > >
> > > >  lib/kunit/executor.c | 6 +++---
> > > >  lib/kunit/test.c     | 5 +++--
> > > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > > > index 9bbc422c284b..74982b83707c 100644
> > > > --- a/lib/kunit/executor.c
> > > > +++ b/lib/kunit/executor.c
> > > > @@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
> > > >  {
> > > >         size_t num_suites = suite_set->end - suite_set->start;
> > > >
> > > > -       pr_info("TAP version 14\n");
> > > > +       pr_info("KTAP version 1\n");
> > > >         pr_info("1..%zu\n", num_suites);
> > > >
> > > >         __kunit_test_suites_init(suite_set->start, num_suites);
> > > > @@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
> > > >         struct kunit_suite * const *suites;
> > > >         struct kunit_case *test_case;
> > > >
> > > > -       /* Hack: print a tap header so kunit.py can find the start of KUnit output. */
> > > > -       pr_info("TAP version 14\n");
> > > > +       /* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
> > > > +       pr_info("KTAP version 1\n");
> > > >
> > > >         for (suites = suite_set->start; suites < suite_set->end; suites++)
> > > >                 kunit_suite_for_each_test_case((*suites), test_case) {
> > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > index 90640a43cf62..b541d59a05c3 100644
> > > > --- a/lib/kunit/test.c
> > > > +++ b/lib/kunit/test.c
> > > > @@ -151,6 +151,7 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
> > > >  {
> > > >         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
> > > >                   suite->name);
> > > > +       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> > >
> > > Would it make sense to have the Subtest line _after_ the KTAP line here?
> > >
> > > Given KTAP doesn't specify the "Subtest" line at all, I guess it doesn't matter.
> > >
> > > A part of me feels that the "KTAP version 1" line should be the
> > > _first_ line of the subtest output, but that would introduce a line
> > > between it and the test plan, which goes against the spec.
> > >
> > > We could also just get rid of the "Subtest" line, given it's not
> > > technically required, though having the test name before the results
> > > is really useful.
> > >
> > > Having tried all three options while writing this email, I think it's
> > > probably best to leave this patch as is (with the Subtest line
> > > followed by the KTAP line), and discuss standardising something
> > > similar as part of the KTAP v2 spec.
> > >
> >
> > I also struggle to decide how the "Subtest" line should be handled. Since
> > the current KTAP v1 spec does not provide a way to declare the name of
> > a test with subtests prior to the results, I think it is important to continue
> > to include this Subtest line because it provides that functionality.
> > Additionally,
> > the line is not expected to be very disruptive for other parsers because it
> > is read as a diagnostic line.
>
> Yeah, since it's going to be ignored as a diagnostic line, I think
> we're largely free to put it where we want?
>
> I'm actually leaning towards making things more uniform e.g.
>
> KTAP version 1
> # Subtest: optionally set for the top-level test!
> 1..2
>   KTAP version 1
>   # Subtest: suite1
>   1..1
>   ok 1 - test1
>  ok 1 -suite1
>  // etc.
>
> Then we can simplify the parser by not differentiating (as much)
> between the top-level test and subtests.
> This also simplifies parsing multiple KTAP documents (e.g. for
> supporting modules, etc.)
>
> We'll probably talk about this offline soon, but I wanted to put this out there.
>
> Daniel
>


This was partially discussed off the mailing list. I am still a bit
wary to change the output to this format because it is not strictly
compliant with the KTAP v1 spec which requires the test plan to be the
line directly below the version line. However, I do think that this
location makes much more sense for the "# Subtest" line and since this
is a diagnostic line and likely won't break any existing parsers, I
will be changing to this format in v2 as well as adjusting the parser
to allow for this format instead.

The optional top-level "# Subtest" line was also discussed off the
mailing list. It was generally agreed that this could be useful in the
future but not as an addition for this patch. However, the parser
should be altered such that if the line is present, the parser will
not crash but also not actively print the provided test name.

As discussed previously in this patch series, a test name line could
be helpful to propose for KTAP v2 as a replacement to this "# Subtest"
line, which is present in the TAP version 14 spec.

Rae


>
> >
> > The location of the "Subtest" line before the KTAP version line is potentially
> > not the most optimal but it seems to be the best choice while ensuring
> > compatibility with the current KTAP v1 spec. I recommend that we discuss
> > a standardized replacement for this "Subtest" line in the KTAP v2 spec.
