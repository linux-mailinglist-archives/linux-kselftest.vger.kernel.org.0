Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960744136EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 18:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhIUQGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhIUQGR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 12:06:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BEFC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:04:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t7so7522423wrw.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coWrcKNQXUcAkW6e4seTKxWfYWVGPQPXp8yLL94hyig=;
        b=sSUX9iegwh2LgqDqAq8CnLIvs0UJd5YQCegAmQ4wVeQakoLpU321n0oNmJdHcwGJKl
         vqHMq07lz5kBVj4gn2Zh6sCfYtvING96kGBwHTc+1/9+zjBuZXvVgU3YvcHjcfJPOlJt
         cSJ6GRK9L+CevrFyjJZtGiE5XiC/bH+vOOoFCFvmvpc/5gRFNqVsogLtMGo4MXlFc8h5
         MqucXdQn8y3RoDv6SFHun3zjQpbdPofMa0zjsm6MF90iOUfzF4X+0uPrAVdNfR2k8oej
         QEZMMpbHUhL6dC2VKGcSGceoQiCYI7uBTqlP853DHTQi1HEcq5GCh8EZd1pruF9Ge1ZH
         Vqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coWrcKNQXUcAkW6e4seTKxWfYWVGPQPXp8yLL94hyig=;
        b=t6BypbcMvcAhnBTiwHeAKzsm2TwbVYX8oLEkc0fKtjUkQ92m/WjrR0RyS52lW/TIIc
         EBXqAOi0R3G+S5ZTSU0wbRB4mVCrInmBDFCrTG2Zuos/9y8JSUF+zPfJHLTCgAqnoDpM
         CzCt38DS/TubKGgL10PMyrYzjF0e9PyxPi9z70TzxI/ngFr1L28hhLyNRzSbZdSx7Pev
         Th2zFT3tv4TMPnL6o5Z/U6QS8eFv+DJrpnhWqhqk87FDfV/WL5eTuJSFfbb4LHiPeFE+
         Fk1lbuufYUplKDoQXjjtsEQua4Rl2mWVXDY2jm/T/WCuKeyWfw4WKv1zpbyt5aXDucQ8
         8EgQ==
X-Gm-Message-State: AOAM5308ZcU/SpDFMNUwaGZKUeLOokO0vN2D1AVQO0HQSZBQ3wKDogaF
        9mm55IptUqyzhR9XL50Had8hvaMe/4cXJK+zKw3kMqqvwRJxMg==
X-Google-Smtp-Source: ABdhPJxHeUUHc47TNWqkz7pxGlYFmPjPwxe2J7+GFiMiO8H6tcoRNwnXA3Iu2bbG5z+UBZYHrgUHfN0nl119ga2ofmM=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr5465741wmi.7.1632240286357;
 Tue, 21 Sep 2021 09:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210914210348.717392-1-dlatypov@google.com>
In-Reply-To: <20210914210348.717392-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 22 Sep 2021 00:04:35 +0800
Message-ID: <CABVgOSkZiT7K1d_hAdfSNVbTV1usE-NAbTgPom01PjLB=r_MFw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kunit: drop assumption in kunit-log-test about
 current suite
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 15, 2021 at 5:03 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This test assumes that the declared kunit_suite object is the exact one
> which is being executed, which KUnit will not guarantee [1].
>
> Specifically, `suite->log` is not initialized until a suite object is
> executed. So if KUnit makes a copy of the suite and runs that instead,
> this test dereferences an invalid pointer and (hopefully) segfaults.
>
> N.B. since we no longer assume this, we can no longer verify that
> `suite->log` is *not* allocated during normal execution.
>
> An alternative to this patch that would allow us to test that would
> require exposing an API for the current test to get its current suite.
> Exposing that for one internal kunit test seems like overkill, and
> grants users more footguns (e.g. reusing a test case in multiple suites
> and changing behavior based on the suite name, dynamically modifying the
> setup/cleanup funcs, storing/reading stuff out of the suite->log, etc.).
>
> [1] In a subsequent patch, KUnit will allow running subsets of test
> cases within a suite by making a copy of the suite w/ the filtered test
> list. But there are other reasons KUnit might execute a copy, e.g. if it
> ever wants to support parallel execution of different suites, recovering
> from errors and restarting suites
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
Thanks for fixing this.

I do think that using "fake" tests/suites like this in more cases will
unlock testing other parts of KUnit as well.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/kunit-test.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index d69efcbed624..555601d17f79 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -415,12 +415,15 @@ static struct kunit_suite kunit_log_test_suite = {
>
>  static void kunit_log_test(struct kunit *test)
>  {
> -       struct kunit_suite *suite = &kunit_log_test_suite;
> +       struct kunit_suite suite;
> +
> +       suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
>
>         kunit_log(KERN_INFO, test, "put this in log.");
>         kunit_log(KERN_INFO, test, "this too.");
> -       kunit_log(KERN_INFO, suite, "add to suite log.");
> -       kunit_log(KERN_INFO, suite, "along with this.");
> +       kunit_log(KERN_INFO, &suite, "add to suite log.");
> +       kunit_log(KERN_INFO, &suite, "along with this.");
>
>  #ifdef CONFIG_KUNIT_DEBUGFS
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> @@ -428,12 +431,11 @@ static void kunit_log_test(struct kunit *test)
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>                                      strstr(test->log, "this too."));
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite->log, "add to suite log."));
> +                                    strstr(suite.log, "add to suite log."));
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> -                                    strstr(suite->log, "along with this."));
> +                                    strstr(suite.log, "along with this."));
>  #else
>         KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
> -       KUNIT_EXPECT_PTR_EQ(test, suite->log, (char *)NULL);
>  #endif
>  }
>
>
> base-commit: 316346243be6df12799c0b64b788e06bad97c30b
> --
> 2.33.0.309.g3052b89438-goog
>
