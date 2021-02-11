Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66C318689
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 09:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBKIy3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 03:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhBKIy1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 03:54:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA95C0613D6
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 00:55:12 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x7so4632297ljc.5
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 00:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INpI2grpc39RPI1/uGmN/swUxZd9s7IImMKnJJk5cp4=;
        b=MKwqC2I/GRbddB3AUH+OcSDsUNhzA4P3u3q/nC+WxRHdmZAvm3ML7H1oRtcVEtO0Rv
         r9s10LKh/2MORlzerm19Dvia0+Kdb9YYzHqrej/s8C1nzns3wMSNHe5Y2sENj1FwvUt+
         N5C+P1rbaeZRfeby7Q8o7wfOXU35hbC/q90WWGBaJWEXSkjM/ozuszciWmcKGHzCW77O
         cuUf08qebgIzSFFMPOSGGm31V9Flj5uZi/Pier3UeuHVehz2S8KGdaAtuuEyiUvphf5e
         FyG737ngsk3mD89lTxgnzWW3y6s2++N3aXNBWxTFk8Y82ZYCSvCYuJT1xZUwWKf7FH0a
         /OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INpI2grpc39RPI1/uGmN/swUxZd9s7IImMKnJJk5cp4=;
        b=htPO7fobBoJveDERh7hwOrFD6ZtC8cjbjq7C93AtJ8S9sv6vO2Xxm40ueY1LZOFSHh
         cxwZ7/DC9pzoyhIFyux6IlxvQLH8CQv0TE4MwpFtD6shwj1Pzi60T2vMmQS0omLTSsty
         pCzopE2CQCnFhPUdEfCNFR48BBu0UkhjoRTGerNcA1whUSOsa/MdxnCuXqaR0xK3WNQs
         gyxWoXL5KZXfemje+5rQLIqnJrEzpRJ2rowm8/yNfZb+wsLq6cTfG269vIVw5jDRDOeQ
         vE0EBEbiBrsS2Bpd6nTmhc1gbkbzX7n1nu3oyjiC7sjljewUT1lGhVJSX7HmjU6XHxuH
         W8Ig==
X-Gm-Message-State: AOAM532icUq8TutDnMvdyL6dQFPBvd5eWYjvsis6CoqX7EkIh8s3DhBA
        PYv2Odn2LuKc9hQPFvszp6ONtmg/eSnIAzL278rP6A==
X-Google-Smtp-Source: ABdhPJxHeBxriJutHMkUrHfyvMpoSrnKx0sjaHNL4noWCB1D1Oiic0z9Wa/KbGa8K9opHFmXE1fKL/utmVS1PrzsJ/Y=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr4437278ljh.89.1613033710765;
 Thu, 11 Feb 2021 00:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20210209221443.78812-1-dlatypov@google.com> <20210209221443.78812-2-dlatypov@google.com>
In-Reply-To: <20210209221443.78812-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 11 Feb 2021 16:54:59 +0800
Message-ID: <CABVgOS=j=23J55jqT=84AhzvBxwZSR-POMOndZxAo1JCyvBLtA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: support failure from dynamic analysis tools
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 10, 2021 at 6:14 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> Add a kunit_fail_current_test() function to fail the currently running
> test, if any, with an error message.
>
> This is largely intended for dynamic analysis tools like UBSAN and for
> fakes.
> E.g. say I had a fake ops struct for testing and I wanted my `free`
> function to complain if it was called with an invalid argument, or
> caught a double-free. Most return void and have no normal means of
> signalling failure (e.g. super_operations, iommu_ops, etc.).
>
> Key points:
> * Always update current->kunit_test so anyone can use it.
>   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
>   CONFIG_KASAN=y
>
> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
>
> * Forward the file and line number to make it easier to track down
> failures
>
> * Declare the helper function for nice __printf() warnings about mismatched
> format strings even when KUnit is not enabled.
>
> Example output from kunit_fail_current_test("message"):
> [15:19:34] [FAILED] example_simple_test
> [15:19:34]     # example_simple_test: initializing
> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> [15:19:34]     not ok 1 - example_simple_test
>
> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>  include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
>  lib/kunit/test.c         | 37 +++++++++++++++++++++++++++++++++----
>  2 files changed, 63 insertions(+), 4 deletions(-)
>  create mode 100644 include/kunit/test-bug.h
>
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> new file mode 100644
> index 000000000000..18b1034ec43a
> --- /dev/null
> +++ b/include/kunit/test-bug.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> + *
> + * Copyright (C) 2020, Google LLC.
> + * Author: Uriel Guajardo <urielguajardo@google.com>
> + */
> +
> +#ifndef _KUNIT_TEST_BUG_H
> +#define _KUNIT_TEST_BUG_H
> +
> +#define kunit_fail_current_test(fmt, ...) \
> +       __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> +
> +#if IS_ENABLED(CONFIG_KUNIT)

As the kernel test robot has pointed out on the second patch, this
probably should be IS_BUILTIN(), otherwise this won't build if KUnit
is a module, and the code calling it isn't.

This does mean that things like UBSAN integration won't work if KUnit
is a module, which is a shame.

(It's worth noting that the KASAN integration worked around this by
only calling inline functions, which would therefore be built-in even
if the rest of KUnit was built as a module. I don't think it's quite
as convenient to do that here, though.)

> +
> +extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> +                                                   const char *fmt, ...);
> +
> +#else
> +
> +static __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> +                                                   const char *fmt, ...)
> +{
> +}
> +
> +#endif
> +
> +
> +#endif /* _KUNIT_TEST_BUG_H */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index ec9494e914ef..5794059505cf 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
> @@ -16,6 +17,38 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> +/*
> + * Fail the current test and print an error message to the log.
> + */
> +void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> +{
> +       va_list args;
> +       int len;
> +       char *buffer;
> +
> +       if (!current->kunit_test)
> +               return;
> +
> +       kunit_set_failure(current->kunit_test);
> +
> +       /* kunit_err() only accepts literals, so evaluate the args first. */
> +       va_start(args, fmt);
> +       len = vsnprintf(NULL, 0, fmt, args) + 1;
> +       va_end(args);
> +
> +       buffer = kunit_kmalloc(current->kunit_test, len, GFP_KERNEL);
> +       if (!buffer)
> +               return;
> +
> +       va_start(args, fmt);
> +       vsnprintf(buffer, len, fmt, args);
> +       va_end(args);
> +
> +       kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
> +       kunit_kfree(current->kunit_test, buffer);
> +}
> +EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> +
>  /*
>   * Append formatted message to log, size of which is limited to
>   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> @@ -273,9 +306,7 @@ static void kunit_try_run_case(void *data)
>         struct kunit_suite *suite = ctx->suite;
>         struct kunit_case *test_case = ctx->test_case;
>
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>         current->kunit_test = test;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
>
>         /*
>          * kunit_run_case_internal may encounter a fatal error; if it does,
> @@ -624,9 +655,7 @@ void kunit_cleanup(struct kunit *test)
>                 spin_unlock(&test->lock);
>                 kunit_remove_resource(test, res);
>         }
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>         current->kunit_test = NULL;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
>
> --
> 2.30.0.478.g8a0d178c01-goog
>
