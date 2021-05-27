Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7064039296D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhE0IXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 May 2021 04:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhE0IXn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 May 2021 04:23:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB9C061760
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:22:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so3753552wrj.11
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AhqvpsgmWy2utZlqk5NzWiQ2z3M3gpksG7TnXtqeGI=;
        b=luW6ubII76vBnT2s6nkHUfGzZJWQrjTCwJ5KYrMuaTV9rpuj7v1ybUL2SylCnFcIpb
         //Gw6xZ3ys9MsL907hsknXI/N5rYDjmwpa3r6fLy8auZCoJFLQiIYVKrGHHVGKg8q5Xg
         tl/MKTR59m6QGA/pY4SnvtHu9QXUPaEhC+PmeUyzHmRUezJF5j1IRwe9aFJ9wnSpUx0H
         IogYsSDK+vO7mLvGPL1i1la00sgwWp1KNW5W/1iqgvC1uF5zZhh+g8yPBPyY7hYm0gDZ
         LpIQE2oGSObRBHBNqEEjieGKSwk0lNKJXvhrIHe9VOaBZ46cv32/Asd0r3MX6GZNjm/o
         qQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AhqvpsgmWy2utZlqk5NzWiQ2z3M3gpksG7TnXtqeGI=;
        b=iZrDWYEVWojGMhrj+eJMIX+xCmSjsI+oQUfR2fRlzUXNqv2N8tzFMeG9r8SY87RwTs
         8fK58SCMrEhUtLiiCTYwpQXd14V/uGpQotbsQSf8Vxumyr6Y/6ws0Ijj5aHh4fmPtoYP
         tdbsjCPvkXOP3rD5Ce4Z8iinKqG9nPydynQzOlrV+UwOnhB9aRGmSMDo75VOoNXO+yTy
         i+RYEt8Zz4wzMs0OEdA6R+ATB7TgtIUtNAKD5zX0ucuI6fskybNCTWkM9I+zztY1TyxF
         P4WVis3121pHyIM4YPt6OI1S21BgGiUFvCJgpuyNLLu5u7PVudQHYjDCTeGWz+1UMNN3
         9TuA==
X-Gm-Message-State: AOAM530c80mvcWpMFoPuKVEGIMYPNZZP6ukOfzs0llenYaUuqfrL5CXM
        1mjiMpUoqg1OzHNtJQ4I+G2CRn1hKIOQuMM9dw3ehQ==
X-Google-Smtp-Source: ABdhPJxPCQalwyeBkXjY/Yb/DJyH/zBayTrgJ3+jS7bW8/5z88RmZqOeU6CNi0ikb2rBvRbsuE4Q+xDChb4Du7thstk=
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr2067742wrx.302.1622103727662;
 Thu, 27 May 2021 01:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <YK4O1DkP1/DKzVU5@elver.google.com>
In-Reply-To: <YK4O1DkP1/DKzVU5@elver.google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 May 2021 16:21:56 +0800
Message-ID: <CABVgOS=Tw1NkUfh1pDfo-3stAKqg_Pt0EtM7+rH2Qk6EUw2+Vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: Support skipped tests
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 26, 2021 at 5:03 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> > The kunit_mark_skipped() macro marks the current test as "skipped", with
> > the provided reason. The kunit_skip() macro will mark the test as
> > skipped, and abort the test.
> >
> > The TAP specification supports this "SKIP directive" as a comment after
> > the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> > spec for details:
> > https://testanything.org/tap-specification.html#directives
> >
> > The 'success' field for KUnit tests is replaced with a kunit_status
> > enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
> > 'status_comment' containing information on why a test was skipped.
> >
> > A new 'kunit_status' test suite is added to test this.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> [...]
> >  include/kunit/test.h   | 68 ++++++++++++++++++++++++++++++++++++++----
> >  lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++-
> >  lib/kunit/test.c       | 51 ++++++++++++++++++-------------
> >  3 files changed, 134 insertions(+), 27 deletions(-)
>
> Very nice, thank you.
>
>         Tested-by: Marco Elver <elver@google.com>
>
> , with the below changes to test_kasan.c. If you would like an immediate
> user of kunit_skip(), please feel free to add the below patch to your
> series.
>
> Thanks,
> -- Marco
>

Thanks! I'll add this to the next version.

Cheers,
-- David

> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Wed, 26 May 2021 10:43:12 +0200
> Subject: [PATCH] kasan: test: make use of kunit_skip()
>
> Make use of the recently added kunit_skip() to skip tests, as it permits
> TAP parsers to recognize if a test was deliberately skipped.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/test_kasan.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index cacbbbdef768..0a2029d14c91 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> -       if (!IS_ENABLED(config)) {                                      \
> -               kunit_info((test), "skipping, " #config " required");   \
> -               return;                                                 \
> -       }                                                               \
> +       if (!IS_ENABLED(config))                                        \
> +               kunit_skip((test), "Test requires " #config "=y");      \
>  } while (0)
>
>  #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {                 \
> -       if (IS_ENABLED(config)) {                                       \
> -               kunit_info((test), "skipping, " #config " enabled");    \
> -               return;                                                 \
> -       }                                                               \
> +       if (IS_ENABLED(config))                                         \
> +               kunit_skip((test), "Test requires " #config "=n");      \
>  } while (0)
>
>  static void kmalloc_oob_right(struct kunit *test)
> --
> 2.31.1.818.g46aad6cb9e-goog
>
