Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DAF438037
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Oct 2021 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJVWbv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 18:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhJVWbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 18:31:51 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE86C061766
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:29:33 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p142so7343153iod.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0I6ArbAhhNdNEp+I53V5vpvPkH843VTEFXnr/8X5aoQ=;
        b=c2sp6XsWq+jrahPURRuQiXwepzbeuixSwZTY2yMfKUEF//XBYB41meRu9gowwn403a
         lunZkE/7lgpIeSNIYxWI4+f8ZY4p1sDWTzxrIXi0RF86arSn7b9Y2vh1WbS2fkaf6mbJ
         VZrpPsG+p0TsLCgIZE3JIbxYsiwysqiyDJZlrGZ5tZ46iqoR/eqipTJC3tX1Z+Lwob57
         6hdeYv1IBfVfwbGkvTFU/0E/ge3mtNuIcig92ye2qcufkzLu5HZJvFhvZETbgiZXBhKD
         hqTfHt6pmto8n8/QnqKLhq1eRA7lOLFWic8kcAo+UuR7lj969eu81TngnCeKNMsd5HHH
         ymFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0I6ArbAhhNdNEp+I53V5vpvPkH843VTEFXnr/8X5aoQ=;
        b=yqqKNgBM9GC+tQ544tZv/qsDsbmckGyey0UvnEuoQcgXwOEegMchYb4IXa7G02zNxN
         ttXKfhw/w3YjzTOEOabFYTGKPyBF1K6fZg9tapbCbiD+xCEu1FWqm56aqddXNgqIvhsX
         5qwKOc9AlY2nr3A4sSiduAyVAMMGmnouLWw1kTxwqs5eZ5SgIs9sZw2jr1baDgnWA39G
         V8+5AoUFx002/SpU/1DA3q15MRMTku3O56luxBYod+BEhGwVwt6ImfENyql+H9pgOUT2
         +SBvtajKlCNKSopVh1zU6nd562La2AbRGpsyzdJztwXQDiHMjYX+7CD/J5GIJNI/GOjX
         CmsQ==
X-Gm-Message-State: AOAM531yCr3bYl3KyHejnBhrgUkUs7msvcYFQgkR6rjCGZVBE5a32eCp
        lH+LoZYMi3sERUlikjzbhaPOYgW/SX6R3xVYh/KHLQ==
X-Google-Smtp-Source: ABdhPJy34YDrRm7d+wrZ2LrT8TYQVvhsPEgYjgee4qWc35C67rd76drncCN/OQLiECa6uTKu32wufDGYPhiY8nLB1rc=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr1496853ion.52.1634941772719;
 Fri, 22 Oct 2021 15:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com> <20211021062819.1313964-2-davidgow@google.com>
 <CAGS_qxpPVEcVOBJ_rbFCswq_2iFHTD5o1endx904wFmU1Vjerg@mail.gmail.com> <CABVgOSkgvgD4QC4dYknEdTgr2GdeoTEkZJT+k8cqOr8B4txsGg@mail.gmail.com>
In-Reply-To: <CABVgOSkgvgD4QC4dYknEdTgr2GdeoTEkZJT+k8cqOr8B4txsGg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 22 Oct 2021 15:29:17 -0700
Message-ID: <CAGS_qxp-bvWHZo7CqkBzZR4Bz85itQKXgiyEBb9RjHWOspEpTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Report test parameter results as (K)TAP subtests
To:     David Gow <davidgow@google.com>
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

On Thu, Oct 21, 2021 at 11:16 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Oct 22, 2021 at 9:15 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Wed, Oct 20, 2021 at 11:28 PM David Gow <davidgow@google.com> wrote:
> > >
> > > Currently, the results for individial parameters in a parameterised test
> > > are simply output as (K)TAP diagnostic lines. However, the plan was
> > > always[1] to make these (K)TAP subtests when kunit_tool supported them.
> > >
> > > With [2], these are now supported. (v5 will print out an error about the
> > > missing plan line, but this can safely be ignored, and will hopefully be
> >
> > Should this commit description be updated?
> >
>
> Whoops, yup. I didn't want to change anything without making this a
> v2, but I'll definitely update it now.
>
> > > changed). As a result, individual test parameter results are parsed,
> > > displayed in the formatted results, and counted for test statistics.
> >
> > This works for me.
> >
> > One concern I have for the future is if showing all the parameters by
> > default might become too verbose?
> > Should there eventually be a verbosity/test-level flag that controls
> > how deep we go?
> > We could elect to only print FAILED subtests after we hit the depth limit.
>
> Totally agree with this. A --depth option is definitely going to
> become necessary here, and I think that printing FAILED subtests after
> that limit is sensible default behaviour for it.
>
> >
> > Testing this out with:
> > $ ./tools/testing/kunit/kunit.py --kunitconfig=fs/fat
> >
> > Before:
> > [17:55:48] Starting KUnit Kernel (1/1)...
> > [17:55:48] ============================================================
> > [17:55:51] ================== fat_test (3 subtests) ===================
> > [17:55:51] [PASSED] fat_checksum_test
> > [17:55:51] [PASSED] fat_time_fat2unix_test
> > [17:55:51] [PASSED] fat_time_unix2fat_test
> > [17:55:51] ==================== [PASSED] fat_test =====================
> > [17:55:51] ============================================================
> > [17:55:51] Testing complete. Passed: 3, Failed: 0, Crashed: 0,
> > Skipped: 0, Errors: 0
> > [17:55:51] Elapsed time: 7.784s total, 0.001s configuring, 4.790s
> > building, 2.877s running
> >
> > [17:56:22] Starting KUnit Kernel (1/1)...
> > [17:56:22] ============================================================
> > [17:56:25] ================== fat_test (3 subtests) ===================
> > [17:56:25] [PASSED] fat_checksum_test
> > [17:56:25] ================== fat_time_fat2unix_test ==================
> > [17:56:25] [PASSED] Earliest possible UTC (1980-01-01 00:00:00)
> > [17:56:25] [PASSED] Latest possible UTC (2107-12-31 23:59:58)
> > [17:56:25] [PASSED] Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
> > [17:56:25] [PASSED] Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
> > [17:56:25] [PASSED] Leap Day / Year (1996-02-29 00:00:00)
> > [17:56:25] [PASSED] Year 2000 is leap year (2000-02-29 00:00:00)
> > [17:56:25] [PASSED] Year 2100 not leap year (2100-03-01 00:00:00)
> > [17:56:25] [PASSED] Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
> > [17:56:25] [PASSED] Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
> > [17:56:25] [PASSED] VFAT odd-second resolution (1999-12-31 23:59:59)
> > [17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
> > [17:56:25] ============= [PASSED] fat_time_fat2unix_test ==============
> > [17:56:25] ================== fat_time_unix2fat_test ==================
> > [17:56:25] [PASSED] Earliest possible UTC (1980-01-01 00:00:00)
> > [17:56:25] [PASSED] Latest possible UTC (2107-12-31 23:59:58)
> > [17:56:25] [PASSED] Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
> > [17:56:25] [PASSED] Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
> > [17:56:25] [PASSED] Leap Day / Year (1996-02-29 00:00:00)
> > [17:56:25] [PASSED] Year 2000 is leap year (2000-02-29 00:00:00)
> > [17:56:25] [PASSED] Year 2100 not leap year (2100-03-01 00:00:00)
> > [17:56:25] [PASSED] Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
> > [17:56:25] [PASSED] Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
> > [17:56:25] [PASSED] VFAT odd-second resolution (1999-12-31 23:59:59)
> > [17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
> > [17:56:25] ============= [PASSED] fat_time_unix2fat_test ==============
> > [17:56:25] ==================== [PASSED] fat_test =====================
> > [17:56:25] ============================================================
> > [17:56:25] Testing complete. Passed: 23, Failed: 0, Crashed: 0,
> > Skipped: 0, Errors: 0
> > [17:56:25] Elapsed time: 7.733s total, 0.001s configuring, 4.740s
> > building, 2.915s running
> >
> > Looks similar when run with --kunitconfig=fs/ext4.
> >
> > This "inverted" nesting of PASSED looks a bit "wrong" at first.
> >
> > [17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
> > [17:56:25] ============= [PASSED] fat_time_unix2fat_test ==============
> > [17:56:25] ==================== [PASSED] fat_test =====================
> >
> > But I know it's so that we can show results as incrementally as
> > possible, so I'm fine with it.
> > (I imagine our users won't necessarily make that connection, however.)
> >
>
> Yeah, this is definitely something for which there's no "perfect" way
> of handling it. The fact that the number of '=' signs is based on the
> length of the name means that even that might not look consistent.
> I'm sure there are things we could experiment with to make this
> clearer, e.g. indenting or swapping out the '=' for '-' on subtests
> (though there's definitely a limit to how deep we could go with
> something like that).

To be clear, I don't think we need to do anything about it at this moment.
Just noting that it might cause confusion (and if it causes enough
later on, then maybe we should revisit it).

>
> > >
> > > [1]: https://lore.kernel.org/linux-kselftest/CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com/
> > > [2]: https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> >
>
> (Was this supposed to be a Tested-by or Reviewed-by or something?)

Oops, muscle memory kicked in since I had just typed a Signed-off-by
recently....

Reviewed-by: Daniel Latypov <dlatypov@google.com>

>
> > > ---
> > >
> > > Note that this was previously posted as:
> > > https://lore.kernel.org/all/20211006071112.2206942-1-davidgow@google.com/
> > >
> > > No changes have been made, save for a trivial rebase on the current
> > > kselftest/kunit branch.
> > >
> > >  lib/kunit/test.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index 3bd741e50a2d..85265f9a66a1 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -508,6 +508,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> > >                         /* Get initial param. */
> > >                         param_desc[0] = '\0';
> > >                         test.param_value = test_case->generate_params(NULL, param_desc);
> > > +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> > > +                                 "# Subtest: %s", test_case->name);
> > >                 }
> > >
> > >                 do {
> > > @@ -520,9 +522,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> > >                                 }
> > >
> > >                                 kunit_log(KERN_INFO, &test,
> > > -                                         KUNIT_SUBTEST_INDENT
> > > -                                         "# %s: %s %d - %s",
> > > -                                         test_case->name,
> > > +                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> > > +                                         "%s %d - %s",
> > >                                           kunit_status_to_ok_not_ok(test.status),
> > >                                           test.param_index + 1, param_desc);
> > >
> > > --
> > > 2.33.0.1079.g6e70778dc9-goog
> > >
