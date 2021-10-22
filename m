Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0087343719F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 08:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhJVGSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 02:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJVGSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 02:18:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2953FC061764
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 23:16:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 62-20020a1c0241000000b0032ca21cffeeso419159wmc.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 23:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLXl3oeTe1efiLZoUCveE/wuKMtLeqacytfUu8ReO5s=;
        b=gPbon9pBPKUC0egAwfmPY1BvIO8kOIZXpiPL17dAmT0toMyGbdhjn5B2iU/lsUzCXJ
         pRlMZwbIMv7HCgmmJ55lQGufDM8WO7yztnQwBkIzg5gqQ4GiJQ3mXf8E1d5nDpgzqYs1
         uRPgMiH7gtJP5K4ws047EUNHH78MNY+js9UZQSHIoqBNyzQlXz5QN0WSif2Lr1auiK7q
         +zIsbLtHyJc+J1tztwrQXfjLdBwLw7UsXhRhoVw6PJ5DiruHl9jmT6XSQKOTZIT/EA4j
         u20ATEPRqEibZDldbFqrANG5Tqq+KDYQHFflDwRcRX/+J1F4dZ0f/GOIxvQq1dhPEgNi
         DjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLXl3oeTe1efiLZoUCveE/wuKMtLeqacytfUu8ReO5s=;
        b=SphsUXukGUIVwiQcLmbYtS9XPfN6AdfHZ9at4kJlXQtfb+ngcbR5DC1UjVWiifPOYn
         P9y7eUlQfIVIzIRgZDt7DivRnOdA++CssPSo/7DJI6nmybMzSpsa6mdiLqqEzAwl0jNG
         Y6YQz2lAUw7rvBmkW/RWAB65JVSg1Z3Q5dbWsZ/3JMzjaSRuSbclUWbIWd0RsWJ8lSLU
         tTjcxR7VHBJE1iqIGbqik6Zrpt/nxIrOFu3mhnAui5d7U9l2syOMX2g5askiUrpZ4cDi
         Adyaj/5KnXnMxVTn6qkINhsCghu/fyP93soZrEbPRpnt3TlaK8D9nZO3sLDhJg09LKBL
         eccg==
X-Gm-Message-State: AOAM533vIg5PBqpHFWzcX1FfqHvwMaHaYOks08bAOecWmbYswrMVUo49
        ZE2VUA/p0F32FUJWOBcVMdGASoCdLkdZJsRkb+fVjQ==
X-Google-Smtp-Source: ABdhPJwozrODVuZ17vOF0HE6ovQZb5E81JJRvq1uBNoVlS0lIX+fwHL6CRfcojrWGR7pxr8gFsxZSWVZmEqJAJcWi90=
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr11628094wmc.7.1634883385571;
 Thu, 21 Oct 2021 23:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com> <20211021062819.1313964-2-davidgow@google.com>
 <CAGS_qxpPVEcVOBJ_rbFCswq_2iFHTD5o1endx904wFmU1Vjerg@mail.gmail.com>
In-Reply-To: <CAGS_qxpPVEcVOBJ_rbFCswq_2iFHTD5o1endx904wFmU1Vjerg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Oct 2021 14:16:14 +0800
Message-ID: <CABVgOSkgvgD4QC4dYknEdTgr2GdeoTEkZJT+k8cqOr8B4txsGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Report test parameter results as (K)TAP subtests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 22, 2021 at 9:15 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 11:28 PM David Gow <davidgow@google.com> wrote:
> >
> > Currently, the results for individial parameters in a parameterised test
> > are simply output as (K)TAP diagnostic lines. However, the plan was
> > always[1] to make these (K)TAP subtests when kunit_tool supported them.
> >
> > With [2], these are now supported. (v5 will print out an error about the
> > missing plan line, but this can safely be ignored, and will hopefully be
>
> Should this commit description be updated?
>

Whoops, yup. I didn't want to change anything without making this a
v2, but I'll definitely update it now.

> > changed). As a result, individual test parameter results are parsed,
> > displayed in the formatted results, and counted for test statistics.
>
> This works for me.
>
> One concern I have for the future is if showing all the parameters by
> default might become too verbose?
> Should there eventually be a verbosity/test-level flag that controls
> how deep we go?
> We could elect to only print FAILED subtests after we hit the depth limit.

Totally agree with this. A --depth option is definitely going to
become necessary here, and I think that printing FAILED subtests after
that limit is sensible default behaviour for it.

>
> Testing this out with:
> $ ./tools/testing/kunit/kunit.py --kunitconfig=fs/fat
>
> Before:
> [17:55:48] Starting KUnit Kernel (1/1)...
> [17:55:48] ============================================================
> [17:55:51] ================== fat_test (3 subtests) ===================
> [17:55:51] [PASSED] fat_checksum_test
> [17:55:51] [PASSED] fat_time_fat2unix_test
> [17:55:51] [PASSED] fat_time_unix2fat_test
> [17:55:51] ==================== [PASSED] fat_test =====================
> [17:55:51] ============================================================
> [17:55:51] Testing complete. Passed: 3, Failed: 0, Crashed: 0,
> Skipped: 0, Errors: 0
> [17:55:51] Elapsed time: 7.784s total, 0.001s configuring, 4.790s
> building, 2.877s running
>
> [17:56:22] Starting KUnit Kernel (1/1)...
> [17:56:22] ============================================================
> [17:56:25] ================== fat_test (3 subtests) ===================
> [17:56:25] [PASSED] fat_checksum_test
> [17:56:25] ================== fat_time_fat2unix_test ==================
> [17:56:25] [PASSED] Earliest possible UTC (1980-01-01 00:00:00)
> [17:56:25] [PASSED] Latest possible UTC (2107-12-31 23:59:58)
> [17:56:25] [PASSED] Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
> [17:56:25] [PASSED] Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
> [17:56:25] [PASSED] Leap Day / Year (1996-02-29 00:00:00)
> [17:56:25] [PASSED] Year 2000 is leap year (2000-02-29 00:00:00)
> [17:56:25] [PASSED] Year 2100 not leap year (2100-03-01 00:00:00)
> [17:56:25] [PASSED] Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
> [17:56:25] [PASSED] Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
> [17:56:25] [PASSED] VFAT odd-second resolution (1999-12-31 23:59:59)
> [17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
> [17:56:25] ============= [PASSED] fat_time_fat2unix_test ==============
> [17:56:25] ================== fat_time_unix2fat_test ==================
> [17:56:25] [PASSED] Earliest possible UTC (1980-01-01 00:00:00)
> [17:56:25] [PASSED] Latest possible UTC (2107-12-31 23:59:58)
> [17:56:25] [PASSED] Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
> [17:56:25] [PASSED] Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
> [17:56:25] [PASSED] Leap Day / Year (1996-02-29 00:00:00)
> [17:56:25] [PASSED] Year 2000 is leap year (2000-02-29 00:00:00)
> [17:56:25] [PASSED] Year 2100 not leap year (2100-03-01 00:00:00)
> [17:56:25] [PASSED] Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
> [17:56:25] [PASSED] Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
> [17:56:25] [PASSED] VFAT odd-second resolution (1999-12-31 23:59:59)
> [17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
> [17:56:25] ============= [PASSED] fat_time_unix2fat_test ==============
> [17:56:25] ==================== [PASSED] fat_test =====================
> [17:56:25] ============================================================
> [17:56:25] Testing complete. Passed: 23, Failed: 0, Crashed: 0,
> Skipped: 0, Errors: 0
> [17:56:25] Elapsed time: 7.733s total, 0.001s configuring, 4.740s
> building, 2.915s running
>
> Looks similar when run with --kunitconfig=fs/ext4.
>
> This "inverted" nesting of PASSED looks a bit "wrong" at first.
>
> [17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
> [17:56:25] ============= [PASSED] fat_time_unix2fat_test ==============
> [17:56:25] ==================== [PASSED] fat_test =====================
>
> But I know it's so that we can show results as incrementally as
> possible, so I'm fine with it.
> (I imagine our users won't necessarily make that connection, however.)
>

Yeah, this is definitely something for which there's no "perfect" way
of handling it. The fact that the number of '=' signs is based on the
length of the name means that even that might not look consistent.
I'm sure there are things we could experiment with to make this
clearer, e.g. indenting or swapping out the '=' for '-' on subtests
(though there's definitely a limit to how deep we could go with
something like that).

> >
> > [1]: https://lore.kernel.org/linux-kselftest/CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com/
> > [2]: https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>

(Was this supposed to be a Tested-by or Reviewed-by or something?)

> > ---
> >
> > Note that this was previously posted as:
> > https://lore.kernel.org/all/20211006071112.2206942-1-davidgow@google.com/
> >
> > No changes have been made, save for a trivial rebase on the current
> > kselftest/kunit branch.
> >
> >  lib/kunit/test.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 3bd741e50a2d..85265f9a66a1 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -508,6 +508,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                         /* Get initial param. */
> >                         param_desc[0] = '\0';
> >                         test.param_value = test_case->generate_params(NULL, param_desc);
> > +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> > +                                 "# Subtest: %s", test_case->name);
> >                 }
> >
> >                 do {
> > @@ -520,9 +522,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                                 }
> >
> >                                 kunit_log(KERN_INFO, &test,
> > -                                         KUNIT_SUBTEST_INDENT
> > -                                         "# %s: %s %d - %s",
> > -                                         test_case->name,
> > +                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> > +                                         "%s %d - %s",
> >                                           kunit_status_to_ok_not_ok(test.status),
> >                                           test.param_index + 1, param_desc);
> >
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
