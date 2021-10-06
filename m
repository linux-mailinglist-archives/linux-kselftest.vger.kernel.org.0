Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937854247F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhJFUe2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhJFUe2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:34:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16123C061753
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 13:32:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j2so4120239ilo.10
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVNksAJFkBNnt0Itxo70/XTASUaBIQQiHVWmEPi7rxo=;
        b=RFoOw8QExdkGjA0wn1/2YVuVQUbUfz/hRVOoZLQ6vlu07nA1YMNcUtlg181gUhmgGj
         ANPIav51r7JYTLqVcJvRGOlUOnOTWoGz4UCxVJ4cZCdOuKJHiPXp9lTFoOzHHV9a5oiu
         zrvCmZt9/FvemSwpszyQdBnzu/RxVM7NI4nGLe3seL6OPZaeLwAvhbyUuv675BanK1oG
         JtmiNlInrscS/tUq1C3wThQgUvjJm1nM75r6QfX6Xj0PT1lpZ8tzaXBPV1y8BcwphK90
         Sb5tcmoUTaiU49fUxDRs8TbXPeErLsa92OkxOpswCJoXyLarj+SIq2STZbR3/Ba8xp/d
         gg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVNksAJFkBNnt0Itxo70/XTASUaBIQQiHVWmEPi7rxo=;
        b=IQiq5Wn8LJkTMGnT2cLJHS2Fa0/Zzs5nywfl2NinjUoyBhnsghQ6NWVmvgmFbPvJ8c
         Q78oXrchK3ikKlYLtBZ3qn0duAjwa9SfLmrGkim1tnJsvP2gy6kc+ObwVxDAILTVMn9X
         NEmWekXJ+JKE4lJzlGfxAjTXWJfQAT9XwIa4ixgsKzc0Vjg3XBvEXiBWDRsckKQDd/Bp
         E0J1H+dHwL2qwl1baHb22RxD7ZqdK8Df7dGv5/hD8QoHjfLZq9G+uz1fP470D3XO0Y1s
         5jrWeS2mghbTEZPY/MUAGJikZ0rL3o4zJoRuB5+NQoUsPQtGFkN9IhwPw/zC/88pgVKm
         qHTQ==
X-Gm-Message-State: AOAM533NXnLTkX+72fHKYje2L8setFt57jp8UDbdGLj0lHC17kWFpUXj
        /zvGxor2Q+MNWZW9B8a1laiM3mbPjCX82U+Gk53RxA==
X-Google-Smtp-Source: ABdhPJzzxRZmUdYUtBAhBxJNdmbWg0ZnTg8SLkNRfVXpL8VlqmDAYxWZUZmyk677RKIQ5RASHpmhOwk8hvEvb3KhjRM=
X-Received: by 2002:a92:b301:: with SMTP id p1mr185432ilh.10.1633552355347;
 Wed, 06 Oct 2021 13:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211006071112.2206942-1-davidgow@google.com>
In-Reply-To: <20211006071112.2206942-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 6 Oct 2021 13:32:24 -0700
Message-ID: <CAGS_qxodEp+HwWJCEaz39T-QEOxhev5a0KjLx+nUfbuM-ZLOcg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Report test parameter results as (K)TAP subtests
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

On Wed, Oct 6, 2021 at 12:11 AM David Gow <davidgow@google.com> wrote:
>
> Currently, the results for individial parameters in a parameterised test
> are simply output as (K)TAP diagnostic lines. However, the plan was
> always[1] to make these (K)TAP subtests when kunit_tool supported them.
>
> With [2], these are now supported. (v5 will print out an error about the
> missing plan line, but this can safely be ignored, and will hopefully be
> changed). As a result, individual test parameter results are parsed,

Hmm, I'd rather not condition users to ignore warnings.
It's possible we can get this all fixed up in time for 5.16, but we
have quite a bit we're trying to get in already, so I'm not sure.


> displayed in the formatted results, and counted for test statistics.
>
> [1]: https://lore.kernel.org/linux-kselftest/CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/kunit/test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f246b847024e..02a9fdadcae2 100644
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
> 2.33.0.800.g4c38ced690-goog
>
