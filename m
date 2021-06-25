Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A713B41FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFYKyu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYKyu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 06:54:50 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB079C061760
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 03:52:28 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id v11-20020a4a8c4b0000b029024be8350c45so2404205ooj.12
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHkVJi5PUgd4dGkz/e/ZMJIraqqu+hSTTUd8BwkusHs=;
        b=ENM+I6bst47g6xp0fxa3wu1HXqWJrJUkjYCHBFgG+0/DP5W/uyjzlNBQhsDH2+cLEK
         4rtiUKRBvDC3Qmwa1En4rPnjnGyxG9DNyWhCu8u85yBB9+aRO+48WBREtJqcX0r8eSh+
         035BZJb5tjCPHIia06lG+YZys+es+yDgcQjrHtqbaa9+xYO+WgQ42GJeI40lwH0OC1dh
         gUrfv45YS+ZdmxSWl9LiYepcEbq/crdhksx4v1+Uuu/uz1kAjk8fcLsNkCYXv9FMozGL
         7TofufL/ECZqzaEfeHfTvvDCTmIuejXIoDBi/dGc7XVWVa74w8TrJ5bHmmPraU+iRtaU
         JXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHkVJi5PUgd4dGkz/e/ZMJIraqqu+hSTTUd8BwkusHs=;
        b=K33g+dTC6IzvnKHXH32GylucgednoHrDo530CJ1JDQ5qtomcwQA9UN9vS3W8s4Mfv1
         z65MtketrRpWyFvJyl1z6BcUElk+2q+Kb20lV7fd+6+WUrjXWR9Z0t+/84XlzOaWLG6r
         /P8/5j9kh+07vhgJ6SFZ1ACyIIGcPEFZ20Ewk0kRgtebHrL3QzPt2jf8+xMe7DLVFShX
         uxYRelN+T6nXezw7fKe+QOy52JPMlxg+Sd/GleV0OcgTt8l1EkjLF34w6ZUB0X6a3aK4
         wQ5tWOPkD+Ldilo69kShQ//MMoozpGaidG6SUfhWsz3+nAkY+nKRt54Ak3ATPFFn3pn6
         5PVw==
X-Gm-Message-State: AOAM530EFp4pjiiM2dy1rh3VXTMnq2bT3TUEfa2s/M/yV/bf7+caxpr/
        pXaWA56/VW8srf7bWPIwjS176q65xNhYRBzvtMQ0LA==
X-Google-Smtp-Source: ABdhPJwQvR7nr/9k9nUvttiDTU6+VyHuKlXbHY7w2j8RwsPiDhordBvFljONCyEjoOkwdD6o6W7gDCGMCToeD0QXfVk=
X-Received: by 2002:a4a:9406:: with SMTP id h6mr8636435ooi.36.1624618347906;
 Fri, 25 Jun 2021 03:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210625065815.322131-1-davidgow@google.com> <20210625065815.322131-3-davidgow@google.com>
In-Reply-To: <20210625065815.322131-3-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 25 Jun 2021 12:52:16 +0200
Message-ID: <CANpmjNOA8rRzdt-AXsshVff3909TXBx=hHVUkfqX55677EnJFg@mail.gmail.com>
Subject: Re: [PATCH kunit-fixes v5 3/4] kunit: test: Add example tests which
 are always skipped
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Jun 2021 at 08:58, David Gow <davidgow@google.com> wrote:
>
> Add two new tests to the example test suite, both of which are always
> skipped. This is used as an example for how to write tests which are
> skipped, and to demonstrate the difference between kunit_skip() and
> kunit_mark_skipped().
>
> Note that these tests are enabled by default, so a default run of KUnit
> will have two skipped tests.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>
> No changes since v4:
> https://lore.kernel.org/linux-kselftest/20210611070802.1318911-3-davidgow@google.com/
>
> No changes since v3:
> https://lore.kernel.org/linux-kselftest/20210608065111.610297-1-davidgow@google.com/
>
> No changes since v2:
> https://lore.kernel.org/linux-kselftest/20210528075932.347154-3-davidgow@google.com/
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20210526081112.3652290-3-davidgow@google.com/
> - These tests are now part of the example test suite.
> - Use kunit_info() instead of kunit_log(KERN_INFO, ...)
> - Use KUNIT_FAIL() to assert the test is not executing for skip_test
>
>  lib/kunit/kunit-example-test.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index be1164ecc476..51099b0ca29c 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -40,6 +40,35 @@ static int example_test_init(struct kunit *test)
>         return 0;
>  }
>
> +/*
> + * This test should always be skipped.
> + */
> +static void example_skip_test(struct kunit *test)
> +{
> +       /* This line should run */
> +       kunit_info(test, "You should not see a line below.");
> +
> +       /* Skip (and abort) the test */
> +       kunit_skip(test, "this test should be skipped");
> +
> +       /* This line should not execute */
> +       KUNIT_FAIL(test, "You should not see this line.");
> +}
> +
> +/*
> + * This test should always be marked skipped.
> + */
> +static void example_mark_skipped_test(struct kunit *test)
> +{
> +       /* This line should run */
> +       kunit_info(test, "You should see a line below.");
> +
> +       /* Skip (but do not abort) the test */
> +       kunit_mark_skipped(test, "this test should be skipped");
> +
> +       /* This line should run */
> +       kunit_info(test, "You should see this line.");
> +}
>  /*
>   * Here we make a list of all the test cases we want to add to the test suite
>   * below.
> @@ -52,6 +81,8 @@ static struct kunit_case example_test_cases[] = {
>          * test suite.
>          */
>         KUNIT_CASE(example_simple_test),
> +       KUNIT_CASE(example_skip_test),
> +       KUNIT_CASE(example_mark_skipped_test),
>         {}
>  };
>
> --
> 2.32.0.93.g670b81a890-goog
>
