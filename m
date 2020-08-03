Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4607423B08F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgHCW7M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Aug 2020 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHCW7L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Aug 2020 18:59:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774BAC06174A
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Aug 2020 15:59:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so30558907wrs.8
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Aug 2020 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVMTuQZIH47WM1WuikLBTLZ1LTQtr65n2lbis/GQnro=;
        b=Q7y3ZvBVs+uNYo2Mb/GjVhFW370VN3GdBcKmK5mr/28yZ6LjoWyp7Mv8xLknRLnc2p
         BNrv0CINGmdsSeO3zTZ7FuvLbsFzdcCbYN9AH81W0h8/Ob7GEjdafkSXLP6PcWEQiEeZ
         gVF4CtKz6ADDdBTrluK5XeHu+zCJSsLHvwwgIV4WFipgSAJPdW+OcDGwEWJ9+Da4pWJo
         PU7uzG5Hl6lgY+Hfhf2LZO5LusUkYOHCRzel2VYM0x17UQSy8lcpdB8pwytWV4f4AHXf
         g3ASsKZsCq3cVMnawJRsyHM22bzRYMmwrqfN9UropwJg1eDQiIvAwDxzIQzMBPOr58Zx
         oxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVMTuQZIH47WM1WuikLBTLZ1LTQtr65n2lbis/GQnro=;
        b=tipyVJJa9eZ7Ncu70waPvjY67BWj7MPSaVNCo7eI0E/gVYR2opT7tz3/OeYKFT9qN7
         SIxFyV+SQ8tjgbY43FPIQAI7JLSNwjlJo8BAkHQx0rUnI5WlQ/REckBpF1Xhj4hcUpRv
         tVae2yNumYzlMW9ROM+72BWF54/qUalu6jPwNjhbde9A1es88OH9auG8loCpz2aa/cr+
         JJITtuhDOkvg4xSUx2PQCtZp5H6PEuTKENrMn23vFxHmFkPW/xINZHyLkR2LkS9JX9Ol
         ks6qBE0rIb88GBQuAshS2gudlxVJ9GNMJFom+1/pHigBldb8VN0QmZdlJa+rLpYD4mPZ
         0NdA==
X-Gm-Message-State: AOAM531nFzNPOmBYcXRA+uo4vVHhLQYGIzt6xHrHj/Yqa7HIB2+uCrml
        /9tblRiLISmfn6jkSxS/eGcfVFy4Mkb+s2iOU0ih8Q==
X-Google-Smtp-Source: ABdhPJwd+kAe35CZLHtw169OJYbx0Gkc+euSQp8Y4f8jmkoFFLXtjrglf4FogQewYcDbj62rm0/pOPYEOMajh2OZ5FQ=
X-Received: by 2002:adf:f289:: with SMTP id k9mr17129637wro.203.1596495550006;
 Mon, 03 Aug 2020 15:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200801070924.1786166-1-davidgow@google.com> <20200801070924.1786166-4-davidgow@google.com>
In-Reply-To: <20200801070924.1786166-4-davidgow@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 4 Aug 2020 06:58:58 +0800
Message-ID: <CABVgOSnpsnYw=0mAks4Xr2rGe07ER1041TKCCY1izeCfT8TcBQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KASAN: Port KASAN Tests to KUnit
To:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 1, 2020 at 3:10 PM David Gow <davidgow@google.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Transfer all previous tests for KASAN to KUnit so they can be run
> more easily. Using kunit_tool, developers can run these tests with their
> other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> report instead of needing to parse each KASAN report to test KASAN
> functionalities. All KASAN reports are still printed to dmesg.
>
> Stack tests do not work properly when KASAN_STACK is enabled so
> those tests use a check for "if IS_ENABLED(CONFIG_KASAN_STACK)" so they
> only run if stack instrumentation is enabled. If KASAN_STACK is not
> enabled, KUnit will print a statement to let the user know this test
> was not run with KASAN_STACK enabled.
>
> copy_user_test and kasan_rcu_uaf cannot be run in KUnit so there is a
> separate test file for those tests, which can be run as before as a
> module.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/Kconfig.kasan       |  22 +-
>  lib/Makefile            |   7 +-
>  lib/kasan_kunit.c       | 770 ++++++++++++++++++++++++++++++++
>  lib/test_kasan.c        | 946 ----------------------------------------
>  lib/test_kasan_module.c | 111 +++++
>  5 files changed, 902 insertions(+), 954 deletions(-)
>  create mode 100644 lib/kasan_kunit.c
>  delete mode 100644 lib/test_kasan.c
>  create mode 100644 lib/test_kasan_module.c

Whoops -- this patch had a few nasty whitespace issues make it
through. I'll send out a new version with those fixed.

I'm pondering splitting it up to do the file rename
(test_kasan.c->kasan_kunit.c) separately as well, as git's rename
detection is not particularly happy with it.

Sorry,
-- David
