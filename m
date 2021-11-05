Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57A44697F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 21:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhKEUSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhKEUSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 16:18:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420DCC061714
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 13:15:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g3so16808715ljm.8
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqHVphJRsOg0vKmfYa1jZpyPe0YWBaEezxPZReK1I2E=;
        b=q3+yzE4Ow/m3lzoIN5PdiNgUFMQTre/b366H7VJROVrX586YFvc+IpOpRL+A1pvhyC
         7hT0LiAUOMJwChlqcl/K6n31dpkV9ts/wlePBoiCsRsaV1LqAlXVOR/1/WPoo51Rvhcg
         25YUDAfVHtUI0aGA9g0d89LOb62SYS2YcBB1kQi7M61dwdUD+TbLCtvbhgLh0x2e1XyM
         UtWDhCigDX7keyPmOeCyzCrQM1v9girHXVB8oLtgV7YhVsNBRGjpi/ZXiEyU8NNkWyqO
         nuWtoSWyypnCpWS3ZCepa1wAk6daF1uj1hm/+E8zU9Sot8GUO0ELieZQ+rsibt7Ssski
         mkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqHVphJRsOg0vKmfYa1jZpyPe0YWBaEezxPZReK1I2E=;
        b=TbXrTuEk6Bm0iVWGU245OCtbtDmpnWDpjQNbMpfGQM04PRxK8LjeM+tkGWVHxRGnN5
         N6LreGaC04pF0p5Pyxpbav/2bNqudkBMr37CI8EuNlTKfeYxiR34/1/2P0lI2JUeSBIM
         6oPvxDCMdK9HYpdJZ6tt5Alnh40fIQXcknLXj9+lLpb2CdC3kdWy9nI0VDC2zP2taMS/
         uouU957E516bPT0+7S6g006NwMje6Smvanno601rNb7MxkJnlwCCsNEwOZFhJbhWNhyT
         e6Nwn5iJ1pZ+iZM3fESJ+32zNFVlydyTm53VkNghYO0rSBVtInMSNtDuH0OdSBUFd5Cf
         GLUw==
X-Gm-Message-State: AOAM530hZLzFdwGB+U/Km8uf30Q/IBzQsH20oL8Gr3CJkz6143PtM9x4
        ud0sDSItbfG+TRxEf++tj3JUWAObSMvmhMbMKgEIQQ==
X-Google-Smtp-Source: ABdhPJwZ2tz6jaVRxkOgVp+jl8s6Gk3iTKD+Q0XS0ogAGfwSz3i/LFHq01irNF29i/MrlLZz7O3KVOKoMYGqjyS7zVw=
X-Received: by 2002:a05:651c:889:: with SMTP id d9mr63754997ljq.198.1636143328368;
 Fri, 05 Nov 2021 13:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211105162530.3307666-1-anders.roxell@linaro.org> <20211105162530.3307666-2-anders.roxell@linaro.org>
In-Reply-To: <20211105162530.3307666-2-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:15:17 -0700
Message-ID: <CAKwvOd=Qdt7Wd1fL-vhheZjcNonqBaxbJwVamG3Q-eMy+A=2KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: cgroup: use function 'labs()' over 'abs()'
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, christian@brauner.io, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 9:25 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/cgroup with clang, the compiler warn about the
> function abs() see below:
>
> In file included from test_memcontrol.c:21:
> ./cgroup_util.h:16:9: warning: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
>         return abs(a - b) <= (a + b) / 100 * err;
>                ^
> ./cgroup_util.h:16:9: note: use function 'labs' instead
>         return abs(a - b) <= (a + b) / 100 * err;
>                ^~~
>                labs
>
> The note indicates what to do, Rework to use the function 'labs()'.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
>  tools/testing/selftests/cgroup/test_kmem.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
> index 82e59cdf16e7..76b35d9dffb5 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -13,7 +13,7 @@
>   */
>  static inline int values_close(long a, long b, int err)
>  {
> -       return abs(a - b) <= (a + b) / 100 * err;
> +       return labs(a - b) <= (a + b) / 100 * err;
>  }
>
>  extern int cg_find_unified_root(char *root, size_t len);
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index 22b31ebb3513..d65bb8fe876a 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -192,7 +192,7 @@ static int test_kmem_memcg_deletion(const char *root)
>                 goto cleanup;
>
>         sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
> -       if (abs(sum - current) < MAX_VMSTAT_ERROR) {
> +       if (labs(sum - current) < MAX_VMSTAT_ERROR) {
>                 ret = KSFT_PASS;
>         } else {
>                 printf("memory.current = %ld\n", current);
> @@ -383,7 +383,7 @@ static int test_percpu_basic(const char *root)
>         current = cg_read_long(parent, "memory.current");
>         percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
>
> -       if (current > 0 && percpu > 0 && abs(current - percpu) <
> +       if (current > 0 && percpu > 0 && labs(current - percpu) <
>             MAX_VMSTAT_ERROR)
>                 ret = KSFT_PASS;
>         else
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
