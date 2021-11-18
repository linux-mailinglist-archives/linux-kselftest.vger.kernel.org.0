Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C742455892
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 11:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhKRKI7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 05:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbhKRKHT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 05:07:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C68C061764
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 02:03:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so24799655edd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 02:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0iFq7ifdSzsK4y7sUkWjPAAy7rrcYr2QzN82yUpKmac=;
        b=Kh8xlmB2lzGJCuzM6iaOdkgnGbweIXiaqn7Gy2JGCiQ66Fppxin9bBoKYzXKUtT+KJ
         ySyhbnVBgZQqjfmog8sbF34dWA+mxFyujTMbIYvYgf6SG4UcIe8ttoVLzYBHp20PFr1f
         k5BKnr6bG9iCqvPBSNu6ACpnEKzlqy8DjgD4s21hVTjwCOOPSu+43PrUYna7jKXutDZm
         toXdtSa0NkLiNlh/Dv9QvUH1TI+92d9W9JR22GqLCUwTD5gycdUcIDw1CXB4Sw/LTsl4
         3OTFSxQqs4LdZJActtapyG5Zn+8Pld0EgI/FkM/CsOki269qUxVQC+gbr78CVxvIa0yw
         jXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0iFq7ifdSzsK4y7sUkWjPAAy7rrcYr2QzN82yUpKmac=;
        b=7AXoCzKSkuMQvsoVIB6oTZIQFvB2YExMQ2nccOSmiWYPmUA2b/MMTirZXLjSpIahkT
         eEHxyY2X1jt+4Rsy0bxMiLUTOVeXz6h9VxJ0C9kErPZNquyvfJRAACwHb7CpQJA2femb
         4Em9a+OCJxdXZwpl/tFDrv6ifRbucEJk5/BBcHkt5DUynb5RDYElni11Ik7c0CdrKrxL
         7WhAAVKSlpnyNtd9rZosIjD/cwINO0IwkU28/u9uznsAusILH1rfVRCO54Bg+0poXcHt
         /dU0v2UWRL90tta6ZD7wvvD+M1xVahiJtPuCz75L8m5c6Lnu95tyAy4XR1w53s2MJc00
         ReXw==
X-Gm-Message-State: AOAM531ZGkqbEmtXEkjeHzHr/qqS11m2uJHoRqhkj3JL/exvbapOkrV6
        M76ruslWMnVbx2tfh/fNmsXvNSMrZsArutG0XAdxvw==
X-Google-Smtp-Source: ABdhPJwBI7mxelZKKBcU8W/pn7DbUQvvIOqh8OSGE6MA8RbLSnT4MtQfFzNxAXDU/YOmq2pBBt3ZENTt0wLNfKKXsR0=
X-Received: by 2002:a17:906:2f09:: with SMTP id v9mr32434542eji.163.1637229815786;
 Thu, 18 Nov 2021 02:03:35 -0800 (PST)
MIME-Version: 1.0
References: <CADYN=9+_UU9qZX56uahGXxz00iayqJLRAaQrRXh1CMXTvwSbAg@mail.gmail.com>
 <20211118095852.616256-1-anders.roxell@linaro.org> <20211118095852.616256-2-anders.roxell@linaro.org>
In-Reply-To: <20211118095852.616256-2-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 18 Nov 2021 11:03:25 +0100
Message-ID: <CADYN=9+drOj6rVjBhB-jVQ+UXgw3ue0tz04ejHih7qRhL6Km1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests: clone3: simplify return logic in clone3_set_tid()
To:     shuah@kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 18 Nov 2021 at 10:58, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Use ksft_exit_* and exit instead of using goto.
>

I'm sorry, I should have added Nick to this patch, since he suggested it.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>

Cheers,
Anders

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/clone3/clone3_set_tid.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> index a755fcd3af89..1b950c3c3b7c 100644
> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -250,7 +250,8 @@ int main(int argc, char *argv[])
>                  * that all those tests are skipped as non-root.
>                  */
>                 ksft_cnt.ksft_xskip += ksft_plan - ksft_test_num();
> -               goto out;
> +               ksft_exit_skip(
> +                       "Please run the remaining tests as root - Exiting.\n");
>         }
>
>         /* Find the current active PID */
> @@ -371,9 +372,7 @@ int main(int argc, char *argv[])
>         close(pipe_2[1]);
>
>         if (waitpid(ns_pid, &status, 0) < 0) {
> -               ksft_print_msg("Child returned %s\n", strerror(errno));
> -               ret = -errno;
> -               goto out;
> +               ksft_exit_fail_msg("Child returned %s\n", strerror(errno));
>         }
>
>         if (!WIFEXITED(status))
> @@ -390,10 +389,6 @@ int main(int argc, char *argv[])
>                 ksft_test_result_fail(
>                         "PIDs in all namespaces not as expected (%d,%d,%d)\n",
>                         ns3, ns2, ns1);
> -out:
> -       ret = 0;
>
> -       if (ret)
> -               ksft_exit_fail();
>         ksft_exit_pass();
>  }
> --
> 2.33.0
>
