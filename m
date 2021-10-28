Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9343F2A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 00:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhJ1WXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJ1WXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 18:23:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7BC061745
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 15:21:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h81so1338159iof.6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OB5iyvsQZRGpy5tFYsZx8Gnk3OXs+5ecQAO2u6+yIE0=;
        b=OoVDgPTl7ZhmRZ1tG6wP15y/AQaJCXDOrb1AFO8bAWvIXsp3R9UBK0cfFZSla1ZYgu
         S7o6OJ5fJ++5HmmLbxYyzPyndUZcizJ1gZ/9L7t7wYxMb+oSaDEK3bKDmncOVN9IhOyl
         oi6RT8IH/YPsFxlc4CRnZbd99G4oQdsjKn5AVB9LUXUaDNJdbugn0RfJEtEBZAeNEOHN
         4BtL1g7lCIL/JUKx+of5ulLfZsAWjUhkc8v2QDsBqknxMQRjqHqiwJcQespLt3eGNo0q
         2VH1088aXYbga19PHrNaXzKU4/GeEx7zgSacmMIYmzyS460b/L/EGLuTlW2+VQQlDMGQ
         E6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OB5iyvsQZRGpy5tFYsZx8Gnk3OXs+5ecQAO2u6+yIE0=;
        b=Uw7VdBzBhnfuANFcSqBlVKPRCFDE5xalPnvHkSs5h7yTWpFsQ9FkJNeIjBj4SeSNMS
         Ed6o9PjP94KxjTpiz/587NTxDJ17rF/D02tTCyvoE3mDZ2S80mjBteFDaDAhyEf/Fl3U
         dGL8dHBtllQk33HgjwdErkZiAuf2BcfvIEOFcR4n4ZBTrjGpwqxkq63zm9aK5EZV+BYt
         LhU91mVWW/Sx8M7F6ST9l54QqiAtTk4tKFY9TWYAQUXNRTQdDROFHuX55ihFkMda1v10
         JIcYskopaOL4ZbW9t2BUi+MyuiDR0FJ4Rhqft+GpyaXCHLHdbINlZtnnX2TFMY6aMAI4
         Q9iw==
X-Gm-Message-State: AOAM531v6Z6IWQk+isxbuyplBzHwqLcMJDMqarC+iQoLR44wKf0zpyw4
        s/QFoN8wFwe3RgMypT5/xYPp9DQTYodNqpsEcHH4+w==
X-Google-Smtp-Source: ABdhPJyNYb2lqLKl/zgacwnUpmKC5pyJpELsieMm2hsFUR/icGAEyJw8RJ03g/C49/unwqlglzmZhUdYOb+cbF4sMj0=
X-Received: by 2002:a6b:f614:: with SMTP id n20mr5149554ioh.134.1635459682871;
 Thu, 28 Oct 2021 15:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211028064154.2301049-1-davidgow@google.com> <20211028064154.2301049-3-davidgow@google.com>
In-Reply-To: <20211028064154.2301049-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 28 Oct 2021 15:21:11 -0700
Message-ID: <CAGS_qxp5KLKqFOBT2zyjw3R5fqcVnzFjTVTnqxKt=X9ZJ-oREQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kunit: Don't crash if no parameters are generated
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

On Wed, Oct 27, 2021 at 11:42 PM David Gow <davidgow@google.com> wrote:
>
> It's possible that a parameterised test could end up with zero
> parameters. At the moment, the test function will nevertheless be called
> with NULL as the parameter. Instead, don't try to run the test code, and
> just mark the test as SKIPped.
>
> Reported-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

There's a small bug in this patch noted below, we just need to move
the "# Subtest" change into the child patch.
If/when we make that change, I have an optional suggestion about
flipping the if/else branch.

But other than that, this looks good to me.

> ---
>
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20211027013702.2039566-3-davidgow@google.com/
> - Rework to not share the loop between the parameterised and
>   non-parameterised test cases.
>   - Suggested by Daniel Latypov.
>   - Avoids using a magic non-zero pointer value.
>
>  lib/kunit/test.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 3bd741e50a2d..dfe1127aacfd 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -508,12 +508,12 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] = '\0';
>                         test.param_value = test_case->generate_params(NULL, param_desc);
> -               }
> +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> +                                 "# Subtest: %s", test_case->name);

It looks like this change accidentally made its way into this patch as
opposed to the child.

This commit itself gives me a traffic light (red/yellow/green statuses):

[ERROR] Test inode_test_xtimestamp_decoding: 0 tests run!
====== [NO TESTS RUN] inode_test_xtimestamp_decoding =======
================= [PASSED] ext4_inode_test =================
============================================================

The problem is the output becomes this:
    # Subtest: ext4_inode_test
    1..1
        # Subtest: inode_test_xtimestamp_decoding
    # inode_test_xtimestamp_decoding: ok 1 - 1901-12-13 Lower bound of
32bit < 0 timestamp, no extra bits
   ...

>
> -               do {
> -                       kunit_run_case_catch_errors(suite, test_case, &test);
> +                       while (test.param_value) {
> +                               kunit_run_case_catch_errors(suite, test_case, &test);
>
> -                       if (test_case->generate_params) {
>                                 if (param_desc[0] == '\0') {
>                                         snprintf(param_desc, sizeof(param_desc),
>                                                  "param-%d", test.param_index);
> @@ -530,11 +530,15 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                 param_desc[0] = '\0';
>                                 test.param_value = test_case->generate_params(test.param_value, param_desc);
>                                 test.param_index++;
> -                       }
>
> +                               kunit_update_stats(&param_stats, test.status);
> +                       }
> +               } else {

I have a very slight preference for having the order of these branches swapped.
i.e.

if (!test_case->generate_params) {
  /* Non-parameterised test */
} else { ... }

I prefer this because I think it's more readable for a few reasons:
* I like having the "normal" branch come first. This is likely the
code path a reader would care more about.
* I prefer having the shorter branch come first. It makes it easier to
read it through and see "oh, so this branch is just that one but with
XYZ"

> +                       /* Non-parameterised test. */
> +                       kunit_run_case_catch_errors(suite, test_case, &test);
>                         kunit_update_stats(&param_stats, test.status);
> +               }
>
> -               } while (test.param_value);
>
>                 kunit_print_test_stats(&test, param_stats);
>
> --
> 2.33.0.1079.g6e70778dc9-goog
>
