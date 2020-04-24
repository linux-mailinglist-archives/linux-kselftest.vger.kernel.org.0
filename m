Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72BC1B6E3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 08:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDXGhC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 02:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbgDXGhC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 02:37:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEADC09B045
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:37:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so9185239wma.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Apr 2020 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Nl042EYhQkNdGgGpL0PjYS28b3/nSBEMCyC0XuhXcY=;
        b=T3WvB9ZktxtKUFHZ4fn4bJrekvXMv5L0WjMsvkfzHvN3QFdGzUWUsLB/s/gpxzo8B8
         c6u7vRd1abf2esEI0zaqL64FZhh/yBpz6GIb/TYnXFMj70BIzGV+U9GDhGksQs1x3Xp8
         GHTDOI3SBEGflHKHNpuj8K/MipYao2Zz0mvyJnmtIMX2Dk270CoKX0Ug+oWGISPKXp6V
         Hwu0YN1lmyWKmDFhs7mUa3sflRRX/6b03twFl6DB6VIgjo8t2R32x/QQxDO+d2MnFT+Q
         2gzzqg0AZPgYowryahbt0CwianpNJaM2HiUbvb7ug3ukvlwpdIRmNvUHw0T/fQYAJU3X
         sjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Nl042EYhQkNdGgGpL0PjYS28b3/nSBEMCyC0XuhXcY=;
        b=Qs8ZnYscD9Er9oXNJH79P5XP9hlgrnu1SQ8YPdqAF/tcSYpwTTYxMs1Vh+oNxy5hk/
         9f0MbS+I2h03kRn52qS++aFmTAF359y9TbwwxZIjAElinujj/vKm21V4zcAqEDbdpONE
         HVWwtKl7lORKXV5fbkNJaEqiK6Dp6qmqgce/GolT1EWv7MdBaX/aFdVL28MSDt7w9R4I
         8FSXPkAL7/j0jxdgK7qd4GMQ4hEXfcy1+TFSsIiDjASxVsDighOGepTcot2Bg5DiZ8Sz
         dNb/+b86dms90d8zvdtX9dlbVXVaeL4LaM0HFNmhyvslA5iI8O3ho2UvLS7n5HxZcupt
         axDw==
X-Gm-Message-State: AGi0PuZRbXK4Kg96gtHWdAruFEECvB+MDznNrhGHdVi6HCOV1oCtINoC
        nB6zJQ5+JfOYqsDAsAeqmLPpmAI0kaZNQWV2ZrE7ng==
X-Google-Smtp-Source: APiQypKMkY07NawNGwqDN/zJwXiWw1DxsM8Vl7RhgQHchO6nUWhs8EYKruSMVBR4h3l/hhGbDF2hnMbzJTvnl82TqiE=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr7973525wme.138.1587710219940;
 Thu, 23 Apr 2020 23:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com> <alpine.LRH.2.21.2004181619110.12187@localhost>
In-Reply-To: <alpine.LRH.2.21.2004181619110.12187@localhost>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Apr 2020 14:36:48 +0800
Message-ID: <CABVgOS=k2eCMwt-Tz46=mCXg1Kxjb54sD1kW-R=mchFQiCgYTQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] KUnit-KASAN Integration
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

On Sat, Apr 18, 2020 at 11:28 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
>
> On Fri, 17 Apr 2020, David Gow wrote:
>
> > This patchset contains everything needed to integrate KASAN and KUnit.
> >
> > KUnit will be able to:
> > (1) Fail tests when an unexpected KASAN error occurs
> > (2) Pass tests when an expected KASAN error occurs
> >
> > Convert KASAN tests to KUnit with the exception of copy_user_test
> > because KUnit is unable to test those.
> >
>
> I tried building and running and things look good but I am
> still seeing the three failures I reported before, even with
> CONFIG_AMD_MEM_ENCRYPT not set.  My config is attached if you
> want to try and reproduce at your end.  Oddly this config was
> working before IIRC (once CONFIG_AMD_MEM_ENCRYPT was not set).
>
> Here's the failures:
>
>    # kasan_memchr: EXPECTATION FAILED at lib/test_kasan.c:545
>     Expected fail_data.report_expected == fail_data.report_found, but
>         fail_data.report_expected == 1
>         fail_data.report_found == 0
>     not ok 31 - kasan_memchr
>     # kasan_memcmp: EXPECTATION FAILED at lib/test_kasan.c:566
>     Expected fail_data.report_expected == fail_data.report_found, but
>         fail_data.report_expected == 1
>         fail_data.report_found == 0
>     not ok 32 - kasan_memcmp

I was able to reproduce these (along with a kasan_strings) failure,
and the cause seems to be some combination of __builtin functions
being inlined by the compiler and potentially dead code elimination,
as fixed by Daniel Axtens here:
https://lkml.org/lkml/2020/4/23/708

I've sent out v7 of the patchset[1], which I've rebased on top of
Daniel's patches, and can no longer reproduce those test failures with
your .config.

Cheers,
-- David

[1]: https://lkml.org/lkml/2020/4/24/80
