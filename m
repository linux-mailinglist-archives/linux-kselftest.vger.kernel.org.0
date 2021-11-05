Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE84469A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 21:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhKEU3n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 16:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhKEU3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 16:29:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C56C061205
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 13:27:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 1so16894698ljv.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wyUo/ZQtCQyVodL9pugyYugqUauw4Uj0CoamGRaoTo=;
        b=jDVwGOof8/gm/IIUo7XhzEjXEtnollc06Ebj3pcM+qgJ3GUFaKtvAHx5MtjHxwLSh7
         RqVxjAMaKz7jc3OnM33zlboH5YsD3D0dlSufzoc9KmJ4MCY0X7fu4xuo5UMJmmkWgA5X
         jM+TNwOVDhcOmez5CXM0vck43rEdQQ5YLqx21u342gnRHhpvwiWbsBO8Vj82mBgrvl2m
         Lq90Gxff2LKTw9L/BmpkKg21+Bp2ADNb9LhC1V2B7PWkp405StxP7Ax3XYodwwa9+O4s
         iIq307MIXAeGJX2svn0y+u8SO4VVcF/SbR4oryd52a4pitv21E4htnP31gP9R25jU00A
         rZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wyUo/ZQtCQyVodL9pugyYugqUauw4Uj0CoamGRaoTo=;
        b=E2n57KvZfZzS+iNfVTjc9DhInicgqk1MAiVQkDxtSOfWcp+w4qbV13L2NzWG9NEHes
         b+Z4Agx5XArUH1I2AjogEZL6KsqLlHgxRoFjhbmk9NAMmBikQh6+ga9vU6P1liVw3HRw
         MMFUGOE3Pxkt6pvXKbU/HfjQuLoW0gpub8N2/c79URvUK9+uwBfC68Sx8zI6B+G/Wys3
         TuJayZZpof0dMzVpx9iJPOWGMda4QTmjUB1sHyYZreej2inJiqAL1tO0n/CMIphFhXB1
         rJJ0jiQEQtNv+r15Wh8gZ8Z+6Sl1pqTDkGrBoCkmCLLwqziWoGCL0a1+K/PodL57gf7v
         PPow==
X-Gm-Message-State: AOAM530rKIPEfL6IdjYggoDuZrmsL9ay9IIq3MihGUwW2G2zO8Zj8Mox
        jdbyBLkt4oZeo2cqYp2Dvd/Tfikz5g37b4BsoZRTBw==
X-Google-Smtp-Source: ABdhPJyeR/MQfc6Wj3DYsKJsPEiSVQY5rZ/UIDydLAnjBCIuEikkBi11cb68jlY8MjNhmB8Vdb1+AQZeA2azlXDwqv8=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr64381888ljc.338.1636144020678;
 Fri, 05 Nov 2021 13:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211105163137.3324344-1-anders.roxell@linaro.org>
In-Reply-To: <20211105163137.3324344-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:26:49 -0700
Message-ID: <CAKwvOdnge-hBmoFH-CHZmbh7DTq8bQiyhbfEOWkBt447=e6QGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: timens: use 'llabs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 9:31 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/timens with clang, the compiler warn about the
> function abs() see below:
>
> timerfd.c:64:7: error: absolute value function 'abs' given an argument of type 'long long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
>                 if (abs(elapsed - 3600) > 60) {
>                     ^
> timerfd.c:64:7: note: use function 'llabs' instead
>                 if (abs(elapsed - 3600) > 60) {
>                     ^~~
>                     llabs
>
> The note indicates what to do, Rework to use the function 'llabs()'.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/timens/timer.c   | 2 +-
>  tools/testing/selftests/timens/timerfd.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
> index 5e7f0051bd7b..5b939f59dfa4 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime");
>
>                 elapsed = new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>                                               clockid, elapsed);
>                         return 1;
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
> index 9edd43d6b2c1..a4196bbd6e33 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime(%d)", clockid);
>
>                 elapsed = new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>                                               clockid, elapsed);
>                         return 1;
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
