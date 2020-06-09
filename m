Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9656D1F4710
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbgFITZi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgFITZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 15:25:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D1C03E97C
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Jun 2020 12:25:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so4632928pfx.8
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFFH4rN6KjxMJmlzDoLxm8Mltw2hQsIo+kpRF7qr7R0=;
        b=WhEEqpsffIxSTyIwECrsIuUNt8DhKRax0O18nD8kxqBcEeWnYuCLuX21nciaW6ImnS
         uWjX+8o0+Qi9x+5dxeyD7iyw0vxQo0iE0rdaqg9bfFyTsKmL0sQjxfb6Q8TJQCwV+7Dg
         9kJW/FQtO9ixxD7ec4yUOvVSzDMGQuvAV6DeUgvtgvJmQwaKahKPBvUIxGABr39xfSTX
         adt8xos57naxWdvyWkeSCgcgWDMthybYzOOcbHFA2j8PqYpeiL0W2vcNlnf7INtBrHWi
         ypIQ9cHVrOxLUCRBlthpkC4LVtZQ1bM+0fvce7ExIMhVwnmSb1NwlIfC1wC+ZdO3ouWe
         ioqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFFH4rN6KjxMJmlzDoLxm8Mltw2hQsIo+kpRF7qr7R0=;
        b=iMLeX9TyxqPoJbaqBueYtvl+z5j1Y2MaVQcmGb5rZjpRR+7/a3IIvvFnuq2K29Cxev
         QRG+vgt8bH9NAmhtD65V3u1GhqjGE/Q3ofYFa0cqT1rCsGg57+wKmmLKEDCv1wDtiRg+
         ictLzE5tB4O9AvMA4Hg9UqbPcSEuvD6XVJU+6Z9rTaP4sukR8VGX3hXfFlGMT0/aE9tG
         gfgQ8D/50I4Pgzhv4NTawt9o8d2LcKHVnTf3NdzaxEmEMlJ6ALpkgQPDdMma2QOQ+yn+
         D05V/slxIDbyiBVFGXH0FPCwSXyylC2GcY2Ow/U1bequSgnlTeDBRN5M5aJ2DKIIHD0/
         8Www==
X-Gm-Message-State: AOAM532Urmuck++heprLaKyC4AhTkoXMr1FpxLDTAW98QuG4PZ7SeiQI
        J8OAlGWAoO5aqVzcpiu9c9ByYtGTS9Ho6ZaEg9OSqA==
X-Google-Smtp-Source: ABdhPJxbbAeQHTukROqUecTz68J69iFM6/OzTYcDpD65Sxr8qt+HL2WuQjbTc01I/fKhxYN2fvRpYXWiuWIcBAjtVws=
X-Received: by 2002:a62:6583:: with SMTP id z125mr26502301pfb.106.1591730736382;
 Tue, 09 Jun 2020 12:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com> <20200606040349.246780-5-davidgow@google.com>
In-Reply-To: <20200606040349.246780-5-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jun 2020 12:25:25 -0700
Message-ID: <CAFd5g46Zn6DuDVB+2SLFd=ofc3J9DXEZ1cn9eTva5-EHueRONw@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] KASAN: Testing Documentation
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        andreyknvl@google.com, shuah <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 5, 2020 at 9:04 PM David Gow <davidgow@google.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Include documentation on how to test KASAN using CONFIG_TEST_KASAN_KUNIT
> and CONFIG_TEST_KASAN_MODULE.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
