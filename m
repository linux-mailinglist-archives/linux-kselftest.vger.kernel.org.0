Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7773B23B892
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHDKPy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHDKPx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 06:15:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB64C06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 03:15:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g33so4425843pgb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Um50ihNeDQB6+aszuU29p3PtU3YChYqBX24eKbUCnk4=;
        b=pZim17LZBM3wySRRMsF6aDmyq+TSxKMls5RRiOlHrx1HkgutXpacGITAj6dI/LphCb
         jVe/BNGTr5hHcXLSxPZtt45ODz7iZHuIvC/ByuYsn+YuSQ9NwwzJ8q8mbZ0XU7RKLUIM
         24IIL+8g/baiTpt3peKEqAeQ1xkm4s3nSybu8VAWBo8y+zxyPFtsXm5zVAOKEp0jxYji
         QZsFMGpvVbmYg5QZCQdatPuON7jc81vj6rLbYjnMEJYfIphhc0pziOMArjvkFPeSWQl8
         yTTydXJFISPKsKpEGrm4GIoVoEVdAQaexl87Mw9Jls1zXmxBwbHIjRF4seYCvQ1JtQLd
         te3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Um50ihNeDQB6+aszuU29p3PtU3YChYqBX24eKbUCnk4=;
        b=JZT6tLmhU9Ee0exNIFEpRNv+FaiV47qYcJZYrVFcSFCMIGm6/prQnNkA8BOm6RWvXD
         Hc2ynMKHnWvT4NafxWH/1SHjxNMO9IJGqHUfBSuQIpOCjLpbupSEfLwCwbeDzOXZzK12
         mp9qlrtTU+RAKVpG/u+Ta/qz6vfdatDJv8C6I0zGSp3p1pOuNdZWP690WABU9OUe1dF1
         tRnY2wF31HY1jpTkWubaCupHaLK9CHcwNQ/AhpooFD6rioVh/HYHzUYj387egK+Zd5gM
         Fc17WUFulOdfzitQ5I7oWHcK2RyfyCYK7E9CbLKYTDHfBVlr1nqy9JP1OKEWkIgrmAW6
         vOrQ==
X-Gm-Message-State: AOAM530em6DzbiE2EQTSPY64fgvx4cI/ygAoVg8iNEKcOX+nEaWtzC7z
        e/z6rKtIpAsMabKfF+PypOxhZ77YYWDCCnX2UHzb3Q==
X-Google-Smtp-Source: ABdhPJzjggbXC4YGvbft2HUHTlUOAC+uoBbsxLwKnczJcYAnFCGvifYIj1HmkZJoFQJZY6aPHRtETw1voDVz6xBbn+E=
X-Received: by 2002:aa7:97a3:: with SMTP id d3mr19768182pfq.178.1596536152759;
 Tue, 04 Aug 2020 03:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com> <20200801070924.1786166-4-davidgow@google.com>
 <CABVgOSnpsnYw=0mAks4Xr2rGe07ER1041TKCCY1izeCfT8TcBQ@mail.gmail.com>
In-Reply-To: <CABVgOSnpsnYw=0mAks4Xr2rGe07ER1041TKCCY1izeCfT8TcBQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Aug 2020 12:15:41 +0200
Message-ID: <CAAeHK+y5KBuAfpeO90X0rxyZmPj4OQGUF=L-q3GAgQUTFNxdsQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KASAN: Port KASAN Tests to KUnit
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
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

On Tue, Aug 4, 2020 at 12:59 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, Aug 1, 2020 at 3:10 PM David Gow <davidgow@google.com> wrote:
> >
> > From: Patricia Alfonso <trishalfonso@google.com>
> >
> > Transfer all previous tests for KASAN to KUnit so they can be run
> > more easily. Using kunit_tool, developers can run these tests with their
> > other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> > report instead of needing to parse each KASAN report to test KASAN
> > functionalities. All KASAN reports are still printed to dmesg.
> >
> > Stack tests do not work properly when KASAN_STACK is enabled so
> > those tests use a check for "if IS_ENABLED(CONFIG_KASAN_STACK)" so they
> > only run if stack instrumentation is enabled. If KASAN_STACK is not
> > enabled, KUnit will print a statement to let the user know this test
> > was not run with KASAN_STACK enabled.
> >
> > copy_user_test and kasan_rcu_uaf cannot be run in KUnit so there is a
> > separate test file for those tests, which can be run as before as a
> > module.
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > ---
> >  lib/Kconfig.kasan       |  22 +-
> >  lib/Makefile            |   7 +-
> >  lib/kasan_kunit.c       | 770 ++++++++++++++++++++++++++++++++
> >  lib/test_kasan.c        | 946 ----------------------------------------
> >  lib/test_kasan_module.c | 111 +++++
> >  5 files changed, 902 insertions(+), 954 deletions(-)
> >  create mode 100644 lib/kasan_kunit.c
> >  delete mode 100644 lib/test_kasan.c
> >  create mode 100644 lib/test_kasan_module.c
>
> Whoops -- this patch had a few nasty whitespace issues make it
> through. I'll send out a new version with those fixed.
>
> I'm pondering splitting it up to do the file rename
> (test_kasan.c->kasan_kunit.c) separately as well, as git's rename
> detection is not particularly happy with it.

Maybe also name it kunit_kasan.c? Probably in the future we'll have
kunit_kmsan.c, etc.
