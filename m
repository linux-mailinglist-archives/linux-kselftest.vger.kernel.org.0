Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B01A7EF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbgDNN4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbgDNN4f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 09:56:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5BBC061A0C
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 06:56:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w11so6018806pga.12
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdHyZcZTKwMKKbebErAZluDvkJ+zw3eiekp5EmZ8JSo=;
        b=Zw93CQ7wOZ3McTNaPwuf6hI7oUALi0jDipv4W5+8meIGHKOv6zhJa7ef1dzCO1gctm
         Vf6vR3bu8iNhOXXPY/QnqZy2vG575rok+gHfAqTYnvTfN/GbmdSidRGo72R8Puh7BBUE
         OlLG8OW0daGhG3hs0ZuztxzEunclUCVwwF2OjWO8pY7litWk4ZvZd46acetx6R6feJnl
         zW8W7ZPv15W3Porkw2fmV1gx+8Sc0drP5tBc7CBovy/JA5QInpTwcJnI/AeWTDsra4hq
         AKa7kLGQoS9pmlcutFjOc9P+qcoBhOfkBD/OyWP8NoqDQlmmdQZ/C7K6qALq51NcOyxh
         vehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdHyZcZTKwMKKbebErAZluDvkJ+zw3eiekp5EmZ8JSo=;
        b=c2tlkfPrD7zm3qEG9krk9RmLvAwRlz9JNg/JlyVSLqYHLKjdmZxogO7KNz8soeyJnZ
         zGXy4sT1nilkaXnmkD14bWT4hVpXZoD3vxJ9bpMmzyVzfbWn4ZPPpRKLxCB0mUxceoci
         hyXUJ59YQ0/+iBwQBVhdFtwH3H1x5c3gMV5NFeEhuZb2eZLv/ev6eTuXrus/gerpXtX1
         1XtC8BvajviBvHiV7N5Nf9bFsI05ZgGu6tE5aktWJunduiMKm+vhVFZaOJhMyYy5jHq3
         dpwSsrX0VN6Y74u22ODpDV4xG6jKI+9PaPPx4S0AeLWvLNbchN5SngxE2lTdgFbkwaVM
         WTYw==
X-Gm-Message-State: AGi0PuaMxFHIuObmpO/h6t4YnSgjwHQCOl5+tMv47qWkCzo8vhV+AKcZ
        fQSL6rmcoZ6K3Cq0hVEo3dLhd1DBrKIGSrbCRkR5PQ==
X-Google-Smtp-Source: APiQypKlsuUX1HqHCpP70HS1dzTDYYtVqkKt3nzRqE4zRnxSY/3xVzZvo6uNtIT8nTK6myEKApKcQahV9cZL5ZPerY0=
X-Received: by 2002:a63:cf02:: with SMTP id j2mr22289788pgg.130.1586872594761;
 Tue, 14 Apr 2020 06:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200414031647.124664-1-davidgow@google.com> <20200414031647.124664-5-davidgow@google.com>
In-Reply-To: <20200414031647.124664-5-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 14 Apr 2020 15:56:23 +0200
Message-ID: <CAAeHK+wq9VTjqCu6dqjn+UyrEWbuW8fFSZObmnN1X6mR4Pzo2w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] KASAN: Testing Documentation
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

On Tue, Apr 14, 2020 at 5:17 AM 'David Gow' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Include documentation on how to test KASAN using CONFIG_TEST_KASAN and
> CONFIG_TEST_KASAN_USER.

This patch needs to be updated to use the new naming, TEST_KASAN_KUNIT
and TEST_KASAN_MODULE.

>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c652d740735d..287ba063d9f6 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
>
>  This allows ``VMAP_STACK`` support on x86, and can simplify support of
>  architectures that do not have a fixed module region.
> +
> +CONFIG_TEST_KASAN & CONFIG_TEST_KASAN_USER
> +-------------------------------------------
> +
> +``CONFIG_TEST_KASAN`` utilizes the KUnit Test Framework for testing.
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
> +With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built as
> +a loadable module and run on any architecture that supports KASAN
> +using something like insmod or modprobe.
> +
> +(2) Built-In
> +~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built-in
> +on any architecure that supports KASAN. These and any other KUnit
> +tests enabled will run and print the results at boot as a late-init
> +call.
> +
> +(3) Using kunit_tool
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN`` built-in, we can also
> +use kunit_tool to see the results of these along with other KUnit
> +tests in a more readable way. This will not print the KASAN reports
> +of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
> +information on kunit_tool.
> +
> +.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> +
> +``CONFIG_TEST_KASAN_USER`` is a set of KASAN tests that could not be
> +converted to KUnit. These tests can be run only as a module with
> +``CONFIG_TEST_KASAN_USER`` built as a loadable module and
> +``CONFIG_KASAN`` built-in. The type of error expected and the
> +function being run is printed before the expression expected to give
> +an error. Then the error is printed, if found, and that test
> +should be interpretted to pass only if the error was the one expected
> +by the test.
> --
> 2.26.0.110.g2183baf09c-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200414031647.124664-5-davidgow%40google.com.
