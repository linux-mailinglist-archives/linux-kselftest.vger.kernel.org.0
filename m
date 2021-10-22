Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F8436F4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 03:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhJVBSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 21:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhJVBSA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 21:18:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48BAC061766
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 18:15:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d125so3341631iof.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 18:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=se2Hob/9s9qlp6mZs7wND8UWEgMe1GSBE9lVYRwfwtg=;
        b=gn+OrZNvRuOmU2zIEBRirBuj3nfGk+kyMfgwm1nhvQWSZvaGUgQEoFXmD1vDiMhVxr
         T2UybgoUupkaSNANTG9eKFyr3o1GdF1mlP8+QWjvX8EKbFBOOd2zM702M4ua0PrLX713
         U+ymeX2dE7u5Iiq0E++oiF+LUHC8EQ7kIyjpce39TM0C9OeqJ3SHxmY3kMNlSuJANAQx
         nksqyu3Q618dzG5++x5aZ8qVnD4HfA9z37OU0z+EfUYUgfTKaNcWwe/3cZ5Ogvy0HC0G
         KN+Y9xdyd6qeuIIZlk0P/iYPZ+Gh96Q+C/61QP+EH4mguHIfYA/EcJ6sQFcSiioYs9pp
         kLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=se2Hob/9s9qlp6mZs7wND8UWEgMe1GSBE9lVYRwfwtg=;
        b=BrY/yF3PAqxdrux1PsyT4VBD0Z/5aIUI95Dqg4hUS/7EWTRZ3qpktN6GyuSaI/O6Xj
         3rRflY4u/KWTmLLPKWmQ1bsaKwGGz496jjjBSUPDvozhCiYrM3G8QqQibGUkIZYwkDtI
         3aBpD3e6Od8fnpY6N/rjxMQl1VACqGwMTUXHYxdB3LNOZ/R0aQG9gsp04fB/tnS9rdgZ
         OnOjhXDhG5008wqONvvTGuF04qnnje7D1g6tq5V9AhnY4xXFz29K5X9OxGaZXzLV0BKi
         MJN2QTpUAutA1s8rt8krb3IVfJPcKjkQC7TRoYSE09FNxoYYo/Pbzf94Wgg40BMqCmyd
         +gRA==
X-Gm-Message-State: AOAM531dQiP1q7NOfudg6GQ+g1txg0LNqF323FFNW4IUlUeVF4mDNBXR
        f8DEOKsY83OePknAsXc7BGtHmpUklSxcFeEsCLyoBQ==
X-Google-Smtp-Source: ABdhPJxuGXVMaIL176Fcqm1QbDAnFwKy92SQ65G4ZRAscLghp/1th5/wtDo9ONq01jaKOKVrFu9cStgAw9QB9G6lROE=
X-Received: by 2002:a5e:de46:: with SMTP id e6mr6703046ioq.62.1634865342968;
 Thu, 21 Oct 2021 18:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com> <20211021062819.1313964-2-davidgow@google.com>
In-Reply-To: <20211021062819.1313964-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 21 Oct 2021 18:15:31 -0700
Message-ID: <CAGS_qxpPVEcVOBJ_rbFCswq_2iFHTD5o1endx904wFmU1Vjerg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Report test parameter results as (K)TAP subtests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 20, 2021 at 11:28 PM David Gow <davidgow@google.com> wrote:
>
> Currently, the results for individial parameters in a parameterised test
> are simply output as (K)TAP diagnostic lines. However, the plan was
> always[1] to make these (K)TAP subtests when kunit_tool supported them.
>
> With [2], these are now supported. (v5 will print out an error about the
> missing plan line, but this can safely be ignored, and will hopefully be

Should this commit description be updated?

> changed). As a result, individual test parameter results are parsed,
> displayed in the formatted results, and counted for test statistics.

This works for me.

One concern I have for the future is if showing all the parameters by
default might become too verbose?
Should there eventually be a verbosity/test-level flag that controls
how deep we go?
We could elect to only print FAILED subtests after we hit the depth limit.

Testing this out with:
$ ./tools/testing/kunit/kunit.py --kunitconfig=fs/fat

Before:
[17:55:48] Starting KUnit Kernel (1/1)...
[17:55:48] ============================================================
[17:55:51] ================== fat_test (3 subtests) ===================
[17:55:51] [PASSED] fat_checksum_test
[17:55:51] [PASSED] fat_time_fat2unix_test
[17:55:51] [PASSED] fat_time_unix2fat_test
[17:55:51] ==================== [PASSED] fat_test =====================
[17:55:51] ============================================================
[17:55:51] Testing complete. Passed: 3, Failed: 0, Crashed: 0,
Skipped: 0, Errors: 0
[17:55:51] Elapsed time: 7.784s total, 0.001s configuring, 4.790s
building, 2.877s running

[17:56:22] Starting KUnit Kernel (1/1)...
[17:56:22] ============================================================
[17:56:25] ================== fat_test (3 subtests) ===================
[17:56:25] [PASSED] fat_checksum_test
[17:56:25] ================== fat_time_fat2unix_test ==================
[17:56:25] [PASSED] Earliest possible UTC (1980-01-01 00:00:00)
[17:56:25] [PASSED] Latest possible UTC (2107-12-31 23:59:58)
[17:56:25] [PASSED] Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
[17:56:25] [PASSED] Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
[17:56:25] [PASSED] Leap Day / Year (1996-02-29 00:00:00)
[17:56:25] [PASSED] Year 2000 is leap year (2000-02-29 00:00:00)
[17:56:25] [PASSED] Year 2100 not leap year (2100-03-01 00:00:00)
[17:56:25] [PASSED] Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
[17:56:25] [PASSED] Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
[17:56:25] [PASSED] VFAT odd-second resolution (1999-12-31 23:59:59)
[17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
[17:56:25] ============= [PASSED] fat_time_fat2unix_test ==============
[17:56:25] ================== fat_time_unix2fat_test ==================
[17:56:25] [PASSED] Earliest possible UTC (1980-01-01 00:00:00)
[17:56:25] [PASSED] Latest possible UTC (2107-12-31 23:59:58)
[17:56:25] [PASSED] Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
[17:56:25] [PASSED] Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
[17:56:25] [PASSED] Leap Day / Year (1996-02-29 00:00:00)
[17:56:25] [PASSED] Year 2000 is leap year (2000-02-29 00:00:00)
[17:56:25] [PASSED] Year 2100 not leap year (2100-03-01 00:00:00)
[17:56:25] [PASSED] Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
[17:56:25] [PASSED] Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
[17:56:25] [PASSED] VFAT odd-second resolution (1999-12-31 23:59:59)
[17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
[17:56:25] ============= [PASSED] fat_time_unix2fat_test ==============
[17:56:25] ==================== [PASSED] fat_test =====================
[17:56:25] ============================================================
[17:56:25] Testing complete. Passed: 23, Failed: 0, Crashed: 0,
Skipped: 0, Errors: 0
[17:56:25] Elapsed time: 7.733s total, 0.001s configuring, 4.740s
building, 2.915s running

Looks similar when run with --kunitconfig=fs/ext4.

This "inverted" nesting of PASSED looks a bit "wrong" at first.

[17:56:25] [PASSED] VFAT 10ms resolution (1980-01-01 00:00:00:0010)
[17:56:25] ============= [PASSED] fat_time_unix2fat_test ==============
[17:56:25] ==================== [PASSED] fat_test =====================

But I know it's so that we can show results as incrementally as
possible, so I'm fine with it.
(I imagine our users won't necessarily make that connection, however.)

>
> [1]: https://lore.kernel.org/linux-kselftest/CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
>
> Signed-off-by: David Gow <davidgow@google.com>

Signed-off-by: Daniel Latypov <dlatypov@google.com>

> ---
>
> Note that this was previously posted as:
> https://lore.kernel.org/all/20211006071112.2206942-1-davidgow@google.com/
>
> No changes have been made, save for a trivial rebase on the current
> kselftest/kunit branch.
>
>  lib/kunit/test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 3bd741e50a2d..85265f9a66a1 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -508,6 +508,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] = '\0';
>                         test.param_value = test_case->generate_params(NULL, param_desc);
> +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> +                                 "# Subtest: %s", test_case->name);
>                 }
>
>                 do {
> @@ -520,9 +522,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 }
>
>                                 kunit_log(KERN_INFO, &test,
> -                                         KUNIT_SUBTEST_INDENT
> -                                         "# %s: %s %d - %s",
> -                                         test_case->name,
> +                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> +                                         "%s %d - %s",
>                                           kunit_status_to_ok_not_ok(test.status),
>                                           test.param_index + 1, param_desc);
>
> --
> 2.33.0.1079.g6e70778dc9-goog
>
