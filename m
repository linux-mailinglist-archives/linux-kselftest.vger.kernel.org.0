Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6563455F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 04:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCWDK7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 23:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhCWDKh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 23:10:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FECC061763
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Mar 2021 20:10:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so19209922wro.7
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Mar 2021 20:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ij2qTAkV9onciaXLQh2fELQAThocPd0dv9MVIWIx7vM=;
        b=r+uMOdSRgBmRm7NI0thZSGjZ2EFpekvMjsgqPBW2fQQYCqu283OtxYJYa8IpOBUrfq
         sAeC0RkRrvztxa7s3L/B7x52qp3mAeL8tLFy9wls9LDXfKjPvgxuR/yvp3GTFgKZxT+w
         Gfaq6GBmJHMN+HwPfA+zw+WzA7Ja/WTLuWYF2lsS/n+jCz9qvm3Qf9o59mlnDBsuc3zI
         CS/cTs8yZd4a1F9qz7cNDAG6dac2879aPh9+/8q6DhxhboVd8GsfX0yDn400s3yjAjPe
         J+h+KWNAV4UP6N8bW2XNF39BEGBvWcKcDMB/K/4Hnknc7UTzMBxyZzhiYRqoOzyDyL9K
         0pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ij2qTAkV9onciaXLQh2fELQAThocPd0dv9MVIWIx7vM=;
        b=NydLW0MEWc7lkIw/BZZiWnhDi69/5FdON6fMgLcvrDY05dbgvCDsu6o4ccv9K+V0C2
         QRwhRQknUUjX/rDN/zsGv8Daz/cO/kjSP7lSkgrx1ffdl/uyGf4eruqNDiQ1U26xg3OL
         nUPOcyi95Yo70uCgXiaYyk02ZDWVrE94oZ3oyE2/dN/LzfiODO29jKLEpi+YBiGW06oN
         VnwBjIryGPmrbA7xE8mTgyk5CV0ONKR5TBab/VXNVFPeHa66YzgZiAaVgFzecSCvjLOl
         f/nWY3feGY5cq7/koFpRIdGyxwwsZIVf91V5S9SXcVolALKD9DobSugEEg8p3I2yFxqB
         lpSg==
X-Gm-Message-State: AOAM532KNnAcaWhB1QRV++55jWEADqIGUZsidBQPwsEKPfw/X3XS3sea
        sTBoe9XkmdNFysqWliIikMtOugON++HvixJsJ/k6vw==
X-Google-Smtp-Source: ABdhPJzDmmeiCu1efaHZYtsxpK+AONN+FexOeJinR9KuKjtoVcz+vufseyaAN1twehF15gc+9ImRKywiKphcRdDFcek=
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr1545621wry.48.1616469034674;
 Mon, 22 Mar 2021 20:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210310104139.679618-1-elver@google.com> <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
In-Reply-To: <YFiamKX+xYH2HJ4E@elver.google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 22 Mar 2021 20:10:22 -0700
Message-ID: <CAP-5=fW8NnLFbnK8UwLuYFzkwk6Yjvxv=LdOpE8qgXbyL6=CCg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for remove_on_exec
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        viro@zeniv.linux.org.uk, Arnd Bergmann <arnd@arndb.de>,
        christian@brauner.io, Dmitry Vyukov <dvyukov@google.com>,
        jannh@google.com, axboe@kernel.dk,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 22, 2021 at 6:24 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, Mar 10, 2021 at 11:41AM +0100, Marco Elver wrote:
> > Add kselftest to test that remove_on_exec removes inherited events from
> > child tasks.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> To make compatible with more recent libc, we'll need to fixup the tests
> with the below.
>
> Also, I've seen that tools/perf/tests exists, however it seems to be
> primarily about perf-tool related tests. Is this correct?
>
> I'd propose to keep these purely kernel ABI related tests separate, and
> that way we can also make use of the kselftests framework which will
> also integrate into various CI systems such as kernelci.org.

Perhaps there is a way to have both? Having the perf tool spot an
errant kernel feels like a feature. There are also
tools/lib/perf/tests and Vince Weaver's tests [1]. It is possible to
run standalone tests from within perf test by having them be executed
by a shell test.

Thanks,
Ian

[1] https://github.com/deater/perf_event_tests

> Thanks,
> -- Marco
>
> ------ >8 ------
>
> diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
> index e176b3a74d55..f89d0cfdb81e 100644
> --- a/tools/testing/selftests/perf_events/remove_on_exec.c
> +++ b/tools/testing/selftests/perf_events/remove_on_exec.c
> @@ -13,6 +13,11 @@
>  #define __have_siginfo_t 1
>  #define __have_sigval_t 1
>  #define __have_sigevent_t 1
> +#define __siginfo_t_defined
> +#define __sigval_t_defined
> +#define __sigevent_t_defined
> +#define _BITS_SIGINFO_CONSTS_H 1
> +#define _BITS_SIGEVENT_CONSTS_H 1
>
>  #include <linux/perf_event.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
> index 7ebb9bb34c2e..b9a7d4b64b3c 100644
> --- a/tools/testing/selftests/perf_events/sigtrap_threads.c
> +++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
> @@ -13,6 +13,11 @@
>  #define __have_siginfo_t 1
>  #define __have_sigval_t 1
>  #define __have_sigevent_t 1
> +#define __siginfo_t_defined
> +#define __sigval_t_defined
> +#define __sigevent_t_defined
> +#define _BITS_SIGINFO_CONSTS_H 1
> +#define _BITS_SIGEVENT_CONSTS_H 1
>
>  #include <linux/hw_breakpoint.h>
>  #include <linux/perf_event.h>
