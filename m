Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F55391FCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhEZS7v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbhEZS7v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 14:59:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F006C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 11:58:19 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k132so2153017iof.4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SDJrdOBe6ySfeILDdQr6VPuIr0LmlxVhGD8mArU7LU=;
        b=p9yXbqGk0cvod+zrx+1bSBAhif3+gKbuRHcUglongDOLMz4EimhMJsF8bpCYgx7H5r
         sniXu1Ax7gMidqlYWmqYj/wkA2NVqUy/QIq7M9knO8QALo8AjVfCCYagSI0qzOk3r2FE
         3b2g9aE0xg/qBBkcYowKhwqkubXpjWTLDWN+3NRFpC8mXr7jGNUXGSYgWxC9xUKvJYwO
         UOEyrgBbQvP/0HaMV0Vt+LRFWEqL5x7PgdL4cIiwlFlukiVXNn2tWIXzO5SNe67Il2/r
         eN6BVW5gfxFqJ+g1Cd9r4VYx8A5SrGYqeqKlWg3sM0xXk91iFVoWgp+c14TVC9NJPWAp
         G1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SDJrdOBe6ySfeILDdQr6VPuIr0LmlxVhGD8mArU7LU=;
        b=gjm0oSG+99CVNfztueKjgD+njdUfP5hiUbpfvawD3onE9WxU1VQFJy5WLLlvf9q0M/
         lT1FJEXcYjO7kur/e+cIw9lH4G4n8hoDoRxvWmwMY9c5wR9nqBdr+c+cDQ2bIZwJGnHc
         AWSp08TRFCoApcEg7ndWHHN4nd1FkKV0i+Yck0DUECEnAY6ECUnans8Zaq+j6/rnzFYC
         NgMFixOzd3rCWaszEPlUBPedWY0I9x0ZaMB8/btG4zoQZmfrDYx7ncAvGNqmotETY4OW
         jAoXvDbTEi+4lwJ/fMt07rTSOVH7BB66RTDK0qQRUv6+XCi4ytq62lBlkBCfSMHHrOQb
         wICA==
X-Gm-Message-State: AOAM532RZNDijEWyaEfoVo1ZN6V8bQ5AzpF/YWGwcDAKo0poMmdKC+MR
        x4Bj67ggq2oHyp+fpwZ44QEeEAFc3lZi005OADWr3g==
X-Google-Smtp-Source: ABdhPJwmChVDWgXo3Tj7mlUabezrYgoCfq+vfWtJuuc6bdJKjfkMTfaYpE6qGFzk6hRHxgyDwVAfKRiW7vVdMH44Zsg=
X-Received: by 2002:a02:aa85:: with SMTP id u5mr4725019jai.75.1622055498359;
 Wed, 26 May 2021 11:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com> <20210526081112.3652290-3-davidgow@google.com>
In-Reply-To: <20210526081112.3652290-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 May 2021 11:58:07 -0700
Message-ID: <CAGS_qxpEJMM5kAMn=+5Y+c2YvOEw_aBEkTW98ncv36gu4L84tQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: test: Add example_skip test suite which is
 always skipped
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 26, 2021 at 1:11 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add a new KUnit test suite which contains tests which are always
> skipped. This is used as an example for how to write tests which are
> skipped, and to demonstrate the difference between kunit_skip() and
> kunit_mark_skipped().
>
> Because these tests do not pass (they're skipped), they are not enabled
> by default, or by the KUNIT_ALL_TESTS config option: they must be
> enabled explicitly by setting CONFIG_KUNIT_EXAMPLE_SKIP_TEST=y in either
> a .config or .kunitconfig file.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

LGTM, two minor nits, and as noted elsewhere, I'd like it if we could
have this be in the normal example test.
But even if that doesn't happen, this seems fine to me.

> ---
>  lib/kunit/Kconfig                   | 15 +++++++++
>  lib/kunit/Makefile                  |  2 ++
>  lib/kunit/kunit-example-skip-test.c | 52 +++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 lib/kunit/kunit-example-skip-test.c
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 0b5dfb001bac..399fe5f789f7 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -45,6 +45,21 @@ config KUNIT_EXAMPLE_TEST
>           is intended for curious hackers who would like to understand how to
>           use KUnit for kernel development.
>
> +config KUNIT_EXAMPLE_SKIP_TEST
> +       tristate "Skipped test example for KUnit"
> +       default n
> +       help
> +         Enables an example unit test that is always skipped.
> +
> +         This test only exists to help new users understand what KUnit is and
> +         how it is used. Please refer to the example test itself,
> +         lib/kunit/example-test.c, for more information. This option is
> +         intended for curious hackers who would like to understand how to use
> +         KUnit for kernel development.
> +
> +         Because this test does not pass, it is not enabled by
> +         CONFIG_KUNIT_ALL_TESTS
> +
>  config KUNIT_ALL_TESTS
>         tristate "All KUnit tests with satisfied dependencies"
>         help
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index c49f4ffb6273..8a99ff2f83bd 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -18,3 +18,5 @@ obj-$(CONFIG_KUNIT_TEST) +=           string-stream-test.o
>  endif
>
>  obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=    kunit-example-test.o
> +
> +obj-$(CONFIG_KUNIT_EXAMPLE_SKIP_TEST) +=       kunit-example-skip-test.o
> diff --git a/lib/kunit/kunit-example-skip-test.c b/lib/kunit/kunit-example-skip-test.c
> new file mode 100644
> index 000000000000..5395ee0be485
> --- /dev/null
> +++ b/lib/kunit/kunit-example-skip-test.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Example KUnit test which is always skipped.
> + *
> + * Copyright (C) 2021, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +#include <kunit/test.h>
> +
> +/*
> + * This test should always be skipped.
> + */
> +
> +static void example_skip_test(struct kunit *test)
> +{
> +       /* This line should run */
> +       kunit_log(KERN_INFO, test, "You should not see a line below.");

Btw, why not "kunit_info(test, ...)" ?

> +
> +       /* Skip (and abort) the test */
> +       kunit_skip(test, "this test should be skipped");
> +
> +       /* This line should not execute */
> +       kunit_log(KERN_INFO, test, "You should not see this line.");

Would it be more or less confusing to have

KUNIT_FAIL(test, "We should not get to this line")

maybe in addition or instead of this log?

> +}
> +
> +static void example_mark_skipped_test(struct kunit *test)
> +{
> +       /* This line should run */
> +       kunit_log(KERN_INFO, test, "You should see a line below.");
> +
> +       /* Skip (but do not abort) the test */
> +       kunit_mark_skipped(test, "this test should be skipped");
> +
> +       /* This line should run */
> +       kunit_log(KERN_INFO, test, "You should see this line.");
> +}
> +
> +static struct kunit_case example_skip_test_cases[] = {
> +       KUNIT_CASE(example_skip_test),
> +       KUNIT_CASE(example_mark_skipped_test),
> +       {}
> +};
> +
> +static struct kunit_suite example_skip_test_suite = {
> +       .name = "example_skip",
> +       .test_cases = example_skip_test_cases,
> +};
> +
> +kunit_test_suites(&example_skip_test_suite);
> +
> +MODULE_LICENSE("GPL v2");
> --
> 2.31.1.818.g46aad6cb9e-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210526081112.3652290-3-davidgow%40google.com.
