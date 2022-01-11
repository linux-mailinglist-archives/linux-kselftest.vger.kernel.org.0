Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5748A7F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 07:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiAKGvF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 01:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiAKGvF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 01:51:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F12C061748
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 22:51:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso766662wma.4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 22:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vT2k1n7N736WcMD+Y2JPRqDITvGAMoT7Xaf5u2iFGf0=;
        b=qNPY9a2pfTc7Qf5oACfviMxwgFUfifitnksqKmJJ/0rUQhDkU19U2Qf6LFyiEk8QtF
         y0eCW43nA3hvVRJbYLnWknpuAwVbmtdCT43jLLpMASCMJ7u0vLShTteK9xRolxD4e/tY
         D5NJlvPtdw6Wq8dZFLN2ChUSt/LwVgHA3xiqxDQTEhRB94OiTJyV8UvHdoTAUPntgcp4
         biub/6CI+xXQOnLRQqBq2KcDwD7t1HZavYvRbz9x79HiEJkxFN8RxU9tJ91Wxj4NejGT
         tNKfFY37lzlDhVfKfSetR6XmQqjbp5ubi5hHuj7H+ZaPjWwpC+B00+8ryzCTA53kgHkk
         S/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vT2k1n7N736WcMD+Y2JPRqDITvGAMoT7Xaf5u2iFGf0=;
        b=rtvJ3yrq/Fxj04icH5D0Z/V+Zkq80FOq4ZmZ/B6267pTxkZASZSOM+ttfwuIk4j5T/
         b/qHwYMONW/aHu56+nSRA9JrAXz18Y7sXVykDYtw7pgeVhiTcZWElzn7e2ty97Ohzagd
         l5nFsrXLwUP0SJPPvdIS+Pn2PlyL9F/NqbawM/fr2Dt48s1eDE02lYJ2sdTUJqArBwbN
         RYcePMmmJ2lTsZAby+AdD9zIb1BAeYv4Oeu1TSF6KqybRqcnXrwl4bcVtjyxrch2hnzI
         f5fryK3lbEEGZewf9iTfqeH8bDW+vVUsUlfq69oavX7XzfYDJhBqHjJCC+1DkrGsa2Of
         Cqzg==
X-Gm-Message-State: AOAM533Qx1HuIrpBFO2szMRDX4OUlp8UhRHcR5BH/W7aL5XhIYgaaOM0
        BFUF/hrKH+LBwaWWY8ff05Z8OZ4r/TgdzmJPUgZa5g==
X-Google-Smtp-Source: ABdhPJwwVF6RtYoCTBdDgDVgO6jwikF88PLjqTmQjVwQ9odoEaUPxzkSdhTfELkwMciHTvZzHLFxCW1oU4jNCMryW8g=
X-Received: by 2002:a1c:721a:: with SMTP id n26mr1053701wmc.39.1641883863554;
 Mon, 10 Jan 2022 22:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-2-dlatypov@google.com>
In-Reply-To: <20220108012304.1049587-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 11 Jan 2022 14:50:51 +0800
Message-ID: <CABVgOS=-KS8kdEsDFRuFM672KSvRGYEjtToA2J_-UeHLqcTH1Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: add example test case showing off all the
 expect macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 8, 2022 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, these macros are only really documented near the bottom of
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.KUNIT_FAIL.
>
> E.g. it's likely someone might just not realize that
> KUNIT_EXPECT_STREQ() exists and instead use KUNIT_EXPECT_FALSE(strcmp())
> or similar.
>
> This can also serve as a basic smoketest that the KUnit assert machinery
> still works for all the macros.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I think this is a great idea. I will note that this definitely isn't a
full test _of_ the assertion macros (in that it only exercises the
success case), so keeping it as an example is probably best.

A few possible ideas below, but I'm happy enough with this as-is regardless.

Reviewed-by: David Gow <davidgow@google.com>

>  lib/kunit/kunit-example-test.c | 46 ++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 51099b0ca29c..182a64c12541 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -69,6 +69,51 @@ static void example_mark_skipped_test(struct kunit *test)
>         /* This line should run */
>         kunit_info(test, "You should see this line.");
>  }
> +
> +/*
> + * This test shows off all the KUNIT_EXPECT macros.
> + */
> +static void example_all_expect_macros_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, true);
> +       KUNIT_EXPECT_FALSE(test, false);

_Maybe_ it's worth having a comment for each of these groups ('boolean
assertions', 'integer assertions', 'pointer assertions', etc)?

> +
> +       KUNIT_EXPECT_EQ(test, 1, 1);
> +       KUNIT_EXPECT_GE(test, 1, 1);
> +       KUNIT_EXPECT_LE(test, 1, 1);
> +       KUNIT_EXPECT_NE(test, 1, 0);
> +       KUNIT_EXPECT_GT(test, 1, 0);
> +       KUNIT_EXPECT_LT(test, 0, 1);
> +
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
> +       KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
> +       KUNIT_EXPECT_PTR_NE(test, test, NULL);
> +
> +       KUNIT_EXPECT_STREQ(test, "hi", "hi");
> +       KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
> +
> +       /*
> +        * There are also _MSG variants of all of the above that let you include
> +        * additional text on failure.
> +        */

There are also the ASSERT vs EXPECT variations. While it may be
excessive to also include all of these, particularly in an example, it
might be worth mentioning them in a comment somewhere?

Alternatively, if this is bloating the example too much, we could have
only one example each of the ASSERT and _MSG variants.

> +       KUNIT_EXPECT_TRUE_MSG(test, true, "msg");
> +       KUNIT_EXPECT_FALSE_MSG(test, false, "msg");

Part of me feels that a better message than "msg" would be nice to
have here, but I can't think of a good one. Maybe (particularly for
the less obvious integer/string/pointer macros below), having a
description of what's being asserted?



> +
> +       KUNIT_EXPECT_EQ_MSG(test, 1, 1, "msg");
> +       KUNIT_EXPECT_GE_MSG(test, 1, 1, "msg");
> +       KUNIT_EXPECT_LE_MSG(test, 1, 1, "msg");
> +       KUNIT_EXPECT_NE_MSG(test, 1, 0, "msg");
> +       KUNIT_EXPECT_GT_MSG(test, 1, 0, "msg");
> +       KUNIT_EXPECT_LT_MSG(test, 0, 1, "msg");
> +
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, test, "msg");
> +       KUNIT_EXPECT_PTR_EQ_MSG(test, NULL, NULL, "msg");
> +       KUNIT_EXPECT_PTR_NE_MSG(test, test, NULL, "msg");
> +
> +       KUNIT_EXPECT_STREQ_MSG(test, "hi", "hi", "msg");
> +       KUNIT_EXPECT_STRNEQ_MSG(test, "hi", "bye", "msg");
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test suite
>   * below.
> @@ -83,6 +128,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_simple_test),
>         KUNIT_CASE(example_skip_test),
>         KUNIT_CASE(example_mark_skipped_test),
> +       KUNIT_CASE(example_all_expect_macros_test),
>         {}
>  };
>
> --
> 2.34.1.575.g55b058a8bb-goog
>
