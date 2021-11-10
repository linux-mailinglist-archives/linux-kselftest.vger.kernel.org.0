Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688544CA2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhKJUMm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 15:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhKJUMl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415DCC061764
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Nov 2021 12:09:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c32so8778173lfv.4
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Nov 2021 12:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00x68YJ2x4xVsec0dOpuJh55/HKY/Kh+2U/BGdfsf1Q=;
        b=cMqbSJKg3qxVw3peYwsclKf0J6UCOPkoa+aWA8rG5txwG0c4Y6hTlI8M8mG/UVj39j
         ruueogZTvPJQD6/U+xIHXTYmwu9OSc69VrL57h2cGM0Ifu11QSEYpEwhSU45pbH3oXUM
         SFvllwF1g7nkYdblB6zZOal3Vhy195Vv27OJwVrJM6EaGgv6BQD4rn4itkjb+FxiV/74
         s2CCFRwq76gtLAc0QHdj3FsdHtrSYCvhyT+WJG2od4uLFnQhCFZtaQWRbGSv+WwAhwHu
         WN44mBTo8aSZgA8q21MrtLXrpYnTHviFbQKaaqHTn+tcm/otuIU7U7kZVRa864HmB9iL
         0lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00x68YJ2x4xVsec0dOpuJh55/HKY/Kh+2U/BGdfsf1Q=;
        b=XNqGwSfZs3+tzT8qZGl6DFSRhJlVjont145B+1gf098o/82rAAkKHIS17Nqn7jC6Aa
         /3+j2BCBxlj/zR9jmDx9LywwWTOUKgs9DcZDGFfhR5/hgFaWRizmt8Rligjv4SFNk6YD
         dPfQcIDfmOG1tvB+zrU3RGiUgGPTROvqDMiRCTS4TSAnR5cW/wRmYOb6bwxffz/WNnt7
         MbWcHLk0Ylc8Rtg4uQQAdjUen2m/Ryvs2v6VfG5M9Xrqu1/H9EvM5n5T4/VVND6MNJnm
         WwFBV+4hJaev/0UmPs+nNqcFWuLovYN4qKwD3rPHkrLzAPuYfnYjNSxQKif4fQdHt6St
         RBPA==
X-Gm-Message-State: AOAM530R0pSj+wyzDe3HkVnb3B6mO+fRYwTe516FYZO3qwkfCWrYzjrN
        KoRlEJeNZJ+g3gWjuWgsWMTRzLZU1J1wJ0QHmOcEgg==
X-Google-Smtp-Source: ABdhPJyT/wr//p2Nn+W3WcilQKAdqjpq4N7/38Ue/cFfN6ynx6DLK6GrO+vauBVcPHNm8RQI7TrE8+Qw3320smkxI50=
X-Received: by 2002:a05:6512:3b9c:: with SMTP id g28mr1625162lfv.651.1636574991415;
 Wed, 10 Nov 2021 12:09:51 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
 <20211110180359.2338349-1-anders.roxell@linaro.org>
In-Reply-To: <20211110180359.2338349-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 12:09:40 -0800
Message-ID: <CAKwvOdkoKvjecTfxbRwZ=BYirvy-Jq64pHtHuct8oWgExv1xPw@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: timens: exec: use 'labs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 10, 2021 at 10:04 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/timens with clang, the compiler warn about the
> function abs() see below:
>
> exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
>                         if (abs(tst.tv_sec - now.tv_sec) > 5)
>                             ^
> exec.c:33:8: note: use function 'labs' instead
>                         if (abs(tst.tv_sec - now.tv_sec) > 5)
>                             ^~~
>                             labs
>
> Rework to store the time difference in a 'long long' and pass that to
> llabs(), since the variable can be an 'int', 'long' or 'long long'
> depending on the architecture and C library.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/timens/exec.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
> index e40dc5be2f66..04439e6ac8a2 100644
> --- a/tools/testing/selftests/timens/exec.c
> +++ b/tools/testing/selftests/timens/exec.c
> @@ -21,6 +21,7 @@
>  int main(int argc, char *argv[])
>  {
>         struct timespec now, tst;
> +       long long timediff;
>         int status, i;
>         pid_t pid;
>
> @@ -30,7 +31,8 @@ int main(int argc, char *argv[])
>
>                 for (i = 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec) > 5)
> +                       timediff = tst.tv_sec - now.tv_sec;
> +                       if (llabs(timediff) > 5)
>                                 return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
>                 }
>                 return 0;
> @@ -50,7 +52,8 @@ int main(int argc, char *argv[])
>
>         for (i = 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now.tv_sec) > 5)
> +               timediff = tst.tv_sec - now.tv_sec;
> +               if (llabs(timediff) > 5)
>                         return pr_fail("%ld %ld\n",
>                                         now.tv_sec, tst.tv_sec);
>         }
> @@ -70,7 +73,8 @@ int main(int argc, char *argv[])
>                 /* Check that a child process is in the new timens. */
>                 for (i = 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
> +                       timediff = tst.tv_sec - now.tv_sec - OFFSET;
> +                       if (llabs(timediff) > 5)
>                                 return pr_fail("%ld %ld\n",
>                                                 now.tv_sec + OFFSET, tst.tv_sec);
>                 }
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
