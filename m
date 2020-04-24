Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0011B76E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDXNXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDXNXx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 09:23:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E0C09B045
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 06:23:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so3867727pje.5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dprDbD5oVepTVxkb47166PR8KYatnNe9atjI73cFB4=;
        b=PNp4FkGyzsrOe+6gzJqVhk7Qwi6o4dAOE2nLGuCwd7TCb+aUUU0EopB1AeoRhvxdFl
         SVWdgSnfi2glpmvM/4qZ/GyhzCmtlWpZAsMZhtjKtATTLsxmDs2zjtlLjsH04Ol67az5
         X4cLHyjzNH6BMTXZ8VjELCV8WZIAUltlgloeCUrbRgjS2v+o66TgnJtlYKR6TlBe41u/
         HttCzKZESgA2XZGGt1zN7XUPmHtcZCWTtbiVzVJJKlGKeFE5FfFPP2hNBG3g3Ncp/64V
         l7in6gAvC/R8YXqKhzfGYD/fZC9HV0JrbgAlXTbxrikJOcXam+Y5hiEqJ/MUtYaFgnVk
         nyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dprDbD5oVepTVxkb47166PR8KYatnNe9atjI73cFB4=;
        b=l5ZGRT/nT609oGWHlFUzcIBsgs3vN3BzFtwXI7oSQU4wgd76xhImU08wtO62Gl1AjX
         DIWNhoN5qQHNfOkqpM75QRUaBpXq+Xhtnj9j/zNAaeCg8q2f+wI4IsXtqsQuo7kKJz3A
         b1eRCG122sPhwpM1+DY4K7prK0YCnnl0qMRm5n/jiapxG6VAXCyGuJSAtMbkPqUDUFVJ
         v27ILbrWm1oqVI8zgpj0mq+EN6jtSvSLbA6g1tXWZQnY/eKmYOV3ULGv9Ip5o6AZkHwT
         oRKSmDmU8PjbPU3sNB7ugvpy3uDdZK5/WEqUqiGSzoiF+50mfa9plct5NyWeQ1IdUTC/
         Fn+w==
X-Gm-Message-State: AGi0PuYGiJC/hdyrfc6/xJffqe8AOG9uy789597nQxhZWkLl9T8y1qGQ
        /Z5z9QLEOXldbr+c2V5KMjBAPOLeCnkw7IHg9rm2DQ==
X-Google-Smtp-Source: APiQypKimQ/omHE4oUSqoEIFzaqala6PyK4BY9vN6FsETr1AxD/dVM8F/9tBeLsoZTX9Xjd9pmUA1MU0VtU2L9FUWvs=
X-Received: by 2002:a17:90b:198e:: with SMTP id mv14mr6180426pjb.69.1587734632657;
 Fri, 24 Apr 2020 06:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com> <20200424061342.212535-5-davidgow@google.com>
In-Reply-To: <20200424061342.212535-5-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 24 Apr 2020 15:23:41 +0200
Message-ID: <CAAeHK+w+y2zAQzmm-uXyFhWBm0VunB7wKPekhjBxajZCD=xEng@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] KASAN: Testing Documentation
To:     David Gow <davidgow@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 24, 2020 at 8:14 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Include documentation on how to test KASAN using CONFIG_TEST_KASAN_KUNIT
> and CONFIG_TEST_KASAN_MODULE.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c652d740735d..b4b109d88f9e 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
>
>  This allows ``VMAP_STACK`` support on x86, and can simplify support of
>  architectures that do not have a fixed module region.
> +
> +CONFIG_TEST_KASAN_KUNIT & CONFIG_TEST_KASAN_MODULE
> +--------------------------------------------------
> +
> +``CONFIG_TEST_KASAN_KUNIT`` utilizes the KUnit Test Framework for testing.
> +This means each test focuses on a small unit of functionality and
> +there are a few ways these tests can be run.
> +
> +Each test will print the KASAN report if an error is detected and then
> +print the number of the test and the status of the test:
> +
> +pass::
> +
> +        ok 28 - kmalloc_double_kzfree
> +or, if kmalloc failed::
> +
> +        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
> +        Expected ptr is not null, but is
> +        not ok 4 - kmalloc_large_oob_right
> +or, if a KASAN report was expected, but not found::
> +
> +        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
> +        Expected kasan_data->report_expected == kasan_data->report_found, but
> +        kasan_data->report_expected == 1
> +        kasan_data->report_found == 0
> +        not ok 28 - kmalloc_double_kzfree
> +
> +All test statuses are tracked as they run and an overall status will
> +be printed at the end::
> +
> +        ok 1 - kasan_kunit_test
> +
> +or::
> +
> +        not ok 1 - kasan_kunit_test
> +
> +(1) Loadable Module
> +~~~~~~~~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` enabled, ``CONFIG_TEST_KASAN_KUNIT`` can be built as
> +a loadable module and run on any architecture that supports KASAN
> +using something like insmod or modprobe.
> +
> +(2) Built-In
> +~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN_KUNIT`` can be built-in
> +on any architecure that supports KASAN. These and any other KUnit
> +tests enabled will run and print the results at boot as a late-init
> +call.
> +
> +(3) Using kunit_tool
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN_KUNIT`` built-in, we can also
> +use kunit_tool to see the results of these along with other KUnit
> +tests in a more readable way. This will not print the KASAN reports
> +of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
> +information on kunit_tool.
> +
> +.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> +
> +``CONFIG_TEST_KASAN_MODULE`` is a set of KASAN tests that could not be
> +converted to KUnit. These tests can be run only as a module with
> +``CONFIG_TEST_KASAN_MODULE`` built as a loadable module and
> +``CONFIG_KASAN`` built-in. The type of error expected and the
> +function being run is printed before the expression expected to give
> +an error. Then the error is printed, if found, and that test
> +should be interpretted to pass only if the error was the one expected
> +by the test.
> --
> 2.26.2.303.gf8c07b1a785-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200424061342.212535-5-davidgow%40google.com.
