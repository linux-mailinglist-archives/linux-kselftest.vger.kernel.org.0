Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5CC3824CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 May 2021 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhEQGyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 02:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhEQGyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 02:54:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50675C061573;
        Sun, 16 May 2021 23:52:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s19so2029727pfe.8;
        Sun, 16 May 2021 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVCa0hmWpkwkTGf73se5+D4y141i/19PSQZ8UiPfJ/M=;
        b=TBdGyzMMDwvS5OT7Z4XISKlDvgSrLrXHy7AEAMRlN7N53TRxqZ8SmA1rjvZOQ9HjIY
         Z/f3nskWkuSAT3v4GxOB7UoJg0QfhCQqilS84jBGtFRaWVsbiPl+kdlrhV6oSHD06UD+
         UAwny6YZKU/GBQtCP7a94a+6dirUHQIjA5f04MLcAhdQY/0VDgBvWPPVdpipKwx8GgPy
         DdNV5gTsn2ADCGAXCBBgS7sQat2JwDKzh4QtVo23Mafz9nNjQWIy3GuIe/04RACHjTIW
         JphqH/IQDEI4FdWD0Su6SK+EE2yGuV7Q2IRV/oSdHmRfe8S/EmBr0rRbp1RYN1Ho1zvN
         c2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVCa0hmWpkwkTGf73se5+D4y141i/19PSQZ8UiPfJ/M=;
        b=EKfpQ2XwvjZoSjX89C+NMb2Hkgx8lsidbawkgcka+QCW7tpCdq9WNYCphdDcXrQ8Jn
         qMmyoH11NyYLm5Yb8Z1eS9NdAKg9y420WjDMX9lHTmmqDJxB6Vf+Lq6R5zeLODkJT6Nd
         CRpmOjd3oQ4l5EEnrIGIOCoqqXBszHFXshZL9oMJRYD70FfSPKs/4LlVN1gkCKQLeSU2
         EOLMdJQpfHqaugqtL2j/+Sf2QP1FiGhC3QByTjB+9YaJHp/5XrhW0/m0qNuGtJ7CSmns
         VMZbYqPmi5015bwC022X0PmQmfvfzqt/31YAK/QCmZcAIlLfRvmkUEskwWM2b6OIxE+D
         jtcg==
X-Gm-Message-State: AOAM533p4OQntpa5ShT9xTI16AgP3Ffijw0OtHM4ZuaNF7271T9eI1P8
        hkGDCn5JqJae9FsnCw6KftRkxcxP13Rw0xOJgUJb01ZrJcQ=
X-Google-Smtp-Source: ABdhPJwMADGLeEf9tXmzQvLIhEr3xBv/TW6mJJf01CNg1gixRSdcTSdJdaSZFmwQ8feMaCA6OgY/h0kLAleKAko67Vk=
X-Received: by 2002:a63:4145:: with SMTP id o66mr36934761pga.4.1621234363775;
 Sun, 16 May 2021 23:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-10-davidgow@google.com>
In-Reply-To: <20210513193204.816681-10-davidgow@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 May 2021 09:52:27 +0300
Message-ID: <CAHp75VcJ0tJw_FuNWoFWuNBsE5H4CiLUT6RsUtLwk-S7JW-vnA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] lib/cmdline_kunit: Remove a cast which are
 no-longer required
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 14, 2021 at 2:32 AM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, a cast in cmdline_kunit is no longer required.
>
> Remove the unnecessary cast, using NULL instead of (int *) to make it
> clearer.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: David Gow <davidgow@google.com>
> ---
> This should be a no-op functionality wise, and while it depends on the
> first couple of patches in this series, it's otherwise independent from
> the others. I think this makes the test more readable, but if you
> particularly dislike it, I'm happy to drop it.
>
>  lib/cmdline_kunit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
> index 018bfc8113c4..a72a2c16066e 100644
> --- a/lib/cmdline_kunit.c
> +++ b/lib/cmdline_kunit.c
> @@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
>                             n, e[0], r[0]);
>
>         p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
> -       KUNIT_EXPECT_PTR_EQ_MSG(test, p, (int *)0, "in test %u at %u out of bound", n, p - r);
> +       KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
>  }
>
>  static void cmdline_test_range(struct kunit *test)
> --
> 2.31.1.751.gd2f1c929bd-goog
>


-- 
With Best Regards,
Andy Shevchenko
