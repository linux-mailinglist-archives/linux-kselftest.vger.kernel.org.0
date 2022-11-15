Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103DB62A299
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 21:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKOUSS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 15:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKOUSR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 15:18:17 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92D32A275
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 12:18:16 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so6137995otl.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZiqQC2TRqYGpQqGxX8IDQ4zinlxzUTLpJAlXiYH1J0=;
        b=Dxk9+zyh+ju+7dKfW2cS/OHh5GFrbRzVCZJZTtmDwZeNSIXtoUSUOoeDOUH5GKT2ws
         G+8U3QXH0WTrxvShd0AOUtxLrjM4LgxVqJIWdO/WEZsjhVOKG6Vfh8usk2r2nqSl6pxf
         rpuCxVxF5PtFe53s+Twm0exZx0DFoSkdxmUZ2nkjDSidKlq5XAeAaMzio1qoG9D7geSg
         rhms5VDYd2MT2uZX0qWxUDuZLdtgTDAkZIxfigsTyoHkI57S/tuedsLqL4NSGDP2HlUj
         tpvHszpqXGxH5BqJ0X/vbe/Nk01179ayZhRZ1ZnpcZGhVsZwvpp/I+t56KLLxBjPPFTt
         reyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZiqQC2TRqYGpQqGxX8IDQ4zinlxzUTLpJAlXiYH1J0=;
        b=zppmVzbptrvQ++e2zu9QuvDneyppw8f3cZLmaNoozPv6G5Sp1u1+s+XLK2LIYN2iBK
         C59nXKOB+8zK2++IWRJqejt0dujjG/RJ6lBIEVs0M0WkW2hsKTzHA0qyhaHdMF6jTkNl
         r6mYIYc6RUdBHRe5l61+527qR7KOA+2E/coSFLYxBrQ5POOGxVeJ/8z3/YGqaqLDVCzM
         58CLk4qF1wIN97PKXjKAi+UCC17+Lus4t8lYA05kBNSlmGUaVO2GB+bJyGX5I6j/W/kS
         P+XmqdoxbUlZk4KD+UulARjhBkKBo9VymfDGNp45XHnUGDMtFU3t4td5xmj7hW6pZg91
         ubnA==
X-Gm-Message-State: ANoB5pnniWteQs5kB8V80aKb+Qjaw/6EEvM/MF2JBeaYaAoIDbJb9hKS
        y9QM+Or6SFXOnExcG2i1RiRF4GleKLXKBWkKVpZoTQ==
X-Google-Smtp-Source: AA0mqf4unY4f49bA7zDs3HC05f2t2jJOz4dZl+RxJc2M6cr4lj3FCThq8PKi6q6f7iPSTfE5w3TBK5qUFz5yQmryeBg=
X-Received: by 2002:a05:6830:14f:b0:668:73ff:e96 with SMTP id
 j15-20020a056830014f00b0066873ff0e96mr9398940otp.256.1668543495841; Tue, 15
 Nov 2022 12:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com> <CABVgOSnUDNvs6mYwVtzXq3+PmO62HG1pP=d_6EQiwOKF_9D6XA@mail.gmail.com>
In-Reply-To: <CABVgOSnUDNvs6mYwVtzXq3+PmO62HG1pP=d_6EQiwOKF_9D6XA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 15 Nov 2022 15:18:03 -0500
Message-ID: <CA+GJov4uUfp_a7FzCEMGivQJx3VGNOx=x+E_eN-9a46EsS2Ygg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: improve KTAP compliance of KUnit test output
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
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

On Tue, Nov 15, 2022 at 2:27 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, Nov 5, 2022 at 3:48 AM Rae Moar <rmoar@google.com> wrote:
> >
> > Change KUnit test output to comply with KTAP version 1 specifications
> > found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> > 1) Use "KTAP version 1" instead of "TAP version 14" as test output header
> > 2) Remove '-' between test number and test name on test result lines
> > 2) Add KTAP version lines to each subtest header as well
> >
> > Original output:
> >
> >  TAP version 14
> >  1..1
> >    # Subtest: kunit-test-suite
> >    1..3
> >    ok 1 - kunit_test_1
> >    ok 2 - kunit_test_2
> >    ok 3 - kunit_test_3
> >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> >  # Totals: pass:3 fail:0 skip:0 total:3
> >  ok 1 - kunit-test-suite
> >
> > New output:
> >
> >  KTAP version 1
> >  1..1
> >    # Subtest: kunit-test-suite
> >    KTAP version 1
> >    1..3
> >    ok 1 kunit_test_1
> >    ok 2 kunit_test_2
> >    ok 3 kunit_test_3
> >  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
> >  # Totals: pass:3 fail:0 skip:0 total:3
> >  ok 1 kunit-test-suite
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> Thanks very much for doing this. It's always been slightly
> embarrassing that we weren't perfectly following our own spec!
>
> I think this series is good enough, but have a minor suggestion: could
> we swap the order of these two patches?
> I'd rather have the parser changes go in first.

Hi David!
Yes, I agree. I think it does make more sense to provide KTAP
compatibility with the parser before changing the test output. This
would also help to solve the issue that Daniel brought up on this
patch about the "KTAP version 1" line and test plan being stored
in the test.log as random kernel output. I will swap the patches in
the v2 of this patch series.

>
> I'd also be curious to see if this is likely to break anyone else's
> (K)TAP parsers.
>
> +Isabella, Anders: do these changes break the IGT or LKFT TAP/KTAP
> parsing? From a quick look at [1] and [2], we're probably okay??
>
> [1]: https://gitlab.freedesktop.org/isinyaaa/igt-gpu-tools/-/commit/1a84306425e975377eb79c031bf1de147bd44e46
> [2]: https://github.com/Linaro/test-definitions/blob/master/automated/linux/kunit/kunit.sh
>
> I also looked into the possibility of moving or removing the Subtest
> line, but upon further thought (see below), it's probably best to keep
> it as-is here for now. That should be the closest to the current spec,
> and we can possibly find a better way to provide the name in KTAPv2.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  lib/kunit/executor.c | 6 +++---
> >  lib/kunit/test.c     | 5 +++--
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 9bbc422c284b..74982b83707c 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
> >  {
> >         size_t num_suites = suite_set->end - suite_set->start;
> >
> > -       pr_info("TAP version 14\n");
> > +       pr_info("KTAP version 1\n");
> >         pr_info("1..%zu\n", num_suites);
> >
> >         __kunit_test_suites_init(suite_set->start, num_suites);
> > @@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
> >         struct kunit_suite * const *suites;
> >         struct kunit_case *test_case;
> >
> > -       /* Hack: print a tap header so kunit.py can find the start of KUnit output. */
> > -       pr_info("TAP version 14\n");
> > +       /* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
> > +       pr_info("KTAP version 1\n");
> >
> >         for (suites = suite_set->start; suites < suite_set->end; suites++)
> >                 kunit_suite_for_each_test_case((*suites), test_case) {
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 90640a43cf62..b541d59a05c3 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -151,6 +151,7 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
> >  {
> >         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
> >                   suite->name);
> > +       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
>
> Would it make sense to have the Subtest line _after_ the KTAP line here?
>
> Given KTAP doesn't specify the "Subtest" line at all, I guess it doesn't matter.
>
> A part of me feels that the "KTAP version 1" line should be the
> _first_ line of the subtest output, but that would introduce a line
> between it and the test plan, which goes against the spec.
>
> We could also just get rid of the "Subtest" line, given it's not
> technically required, though having the test name before the results
> is really useful.
>
> Having tried all three options while writing this email, I think it's
> probably best to leave this patch as is (with the Subtest line
> followed by the KTAP line), and discuss standardising something
> similar as part of the KTAP v2 spec.
>

I also struggle to decide how the "Subtest" line should be handled. Since
the current KTAP v1 spec does not provide a way to declare the name of
a test with subtests prior to the results, I think it is important to continue
to include this Subtest line because it provides that functionality.
Additionally,
the line is not expected to be very disruptive for other parsers because it
is read as a diagnostic line.

The location of the "Subtest" line before the KTAP version line is potentially
not the most optimal but it seems to be the best choice while ensuring
compatibility with the current KTAP v1 spec. I recommend that we discuss
a standardized replacement for this "Subtest" line in the KTAP v2 spec.

>
> >         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
> >                   kunit_suite_num_test_cases(suite));
> >  }
> > @@ -175,13 +176,13 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
> >          * representation.
> >          */
> >         if (suite)
> > -               pr_info("%s %zd - %s%s%s\n",
> > +               pr_info("%s %zd %s%s%s\n",
> >                         kunit_status_to_ok_not_ok(status),
> >                         test_number, description, directive_header,
> >                         (status == KUNIT_SKIPPED) ? directive : "");
> >         else
> >                 kunit_log(KERN_INFO, test,
> > -                         KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
> > +                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
> >                           kunit_status_to_ok_not_ok(status),
> >                           test_number, description, directive_header,
> >                           (status == KUNIT_SKIPPED) ? directive : "");
> >
> > base-commit: 6fe1ad4a156095859721fef85073df3ed43081d4
> > --
> > 2.38.1.431.g37b22c650d-goog
> >
