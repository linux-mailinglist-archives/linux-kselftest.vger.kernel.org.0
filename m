Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D0350067
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhCaMdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhCaMdL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 08:33:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7115C06174A
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 05:33:10 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so18738589oty.12
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2AUmQQuU10DnwHLe3j88zasAy4fwJf13uqVDHeKF6c=;
        b=dMoq/sx5t1QGdWz5mTYVbtcbABRgM77PzP4Pt01l7AzVneg2FZGmwBCFUhIPg13pZ0
         R619RV7rjyIwhw5y6lVdlrOdBwndHm4XiOVOHkGdmfWiebKt0dk4gJkSv+ZqujYccdk1
         /Y9YUnUSj7EaYfCx4xSDb8WZXyAwY2BQYjCLWh/2BQ7A8YdPpd0RTCwD0ajhFfvFREy6
         8KaYkaqq+Obvx6/ePJpZLkWM8F7nHI2VRFTELT4G7dijwVkjF7wjpCvxPW6gxRuAnniL
         UURsS9hiUCAws+mhBJ1hPy3MFGmAiuLzrd7NwoGC1DlVfrl/kvwiEwz4DVaEIK/NAQyY
         B5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2AUmQQuU10DnwHLe3j88zasAy4fwJf13uqVDHeKF6c=;
        b=tRN7DhHX5/4i4pdc8wF1GSIptEyroQY4Q0N5SpQbo8SnqMKxm/R+Qg/OfZDOqDGyUu
         VT/T166/HOUWnWATty4N6LuNrD3GHsRat12nMFninzX1DroHDPUPbO9qnU8lUBp7lydo
         djLaohG/V8CsvH07Bx3kIIcmOZitTtdtJ38dmAl0os9P0jPQnPE1YaLBrNXJxCfNte64
         DnZ1g1GrFuNE9QMHrh48Bt+XZr1zZetYAMa7knnC9rXk50+Kb4y1nafVfxgRitKeeXBz
         sQ/tmGPU5aw0LY+cXM5bGMiK4ckQAWf1PWWa5OHIwhyQMf9Z+BHy6eWJuoFY1qCsEgHZ
         q5LQ==
X-Gm-Message-State: AOAM531mjbpu9BqImuRfQzVe0ggrUaUWRc5/yF7bt85piGlWu7b1lVyb
        G2UndSTUyl/xTFceCZGCzuhfLzmYTJ5RU9lIRsewMw==
X-Google-Smtp-Source: ABdhPJx6YDqVXlG9dIvGvuotdIeqBs0jLh1oYI6fps8tuotAwF3xJLdVe9L4RGLJ/HPVeJgnUb4aEQgH994pcSTpmPk=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr2553279oth.233.1617193990006;
 Wed, 31 Mar 2021 05:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com> <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
In-Reply-To: <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 31 Mar 2021 14:32:58 +0200
Message-ID: <CANpmjNOPJNhJ2L7cxrvf__tCZpy=+T1nBotKmzr2xMJypd-oJQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 Mar 2021 at 14:07, Peter Zijlstra <peterz@infradead.org> wrote:

> (and we might already have a problem on some architectures where there
> can be significant time between these due to not having
> arch_irq_work_raise(), so ideally we ought to double check current in
> your case)

I missed this bit -- just to verify: here we want to check that
event->ctx->task == current, in case the the irq_work runs when the
current task has already been replaced. Correct?

Thanks,
-- Marco
