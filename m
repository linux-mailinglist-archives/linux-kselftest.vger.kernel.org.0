Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E642478B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJFTze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhJFTze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 15:55:34 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00400C061753
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 12:53:41 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l20so4064884ilk.2
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke7yEH2hK5KBpYKWsUTNu4WMWbcJmQ9TH0O3bOJ/VYY=;
        b=dzKYbeud7sCM0spGW62HJMMmtxBf0MQfKr3Tyoz4yKGuesPabkWla81xfS9BSUGzhY
         hBHgBbX1C7LASi+dSrbGWnOb42WKA291fAUYIL+OlFJvqAWWIE5JRyPS3+npng1aQr+n
         oS+HDuI1XExDXGbIgaXimJQFUSC//7AjUoMl4Wm6hPsVxKBWNqRva6r8W6OlY2qhBGkR
         GThXFaFIw2kch3ZScb5tSvlgGKOLvNgjIwbdl2D0XZnIu+fPT9GXyYmKUjK0E5VuMPev
         rr34ymFeD3acwAyif3H7GRN357K2Iz1/WuG51zO7XzrKzVF6TxbjlDpMkva9nSKhNWyu
         Lv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke7yEH2hK5KBpYKWsUTNu4WMWbcJmQ9TH0O3bOJ/VYY=;
        b=7PJE3/pqDqkaASisWwWd3nY8D01h+9kRTh7cAVEAVdPYkKcmkQUAJPS2buj2Ulo5kO
         xjw2bfGISLs+30QPO5hJEnxdPyaOlzQY5TkWTlAf7WztzB5Khu/P/EVFj3fN4nu6fUjp
         zn+x4UDgF+66V6W3ow3TegXLgoy5S9j+3UTzUQWSrXOUKzs9bbcriU/gZl8/8Bt7tfkJ
         +LebuzrkqUj7jnGqKZD/VtOhxMwx+IIafnNgNrjGVMxDPSGi16XEb1TAEcPvcG9MOtqH
         nDR9fIvugNmTo6djW10FV850nV57a4PWpQDi9Nf1ZojU3b/ixm5ThS9Vf0kNY3K+kKL2
         MQmw==
X-Gm-Message-State: AOAM533FZMxWuZtce7S6eWMDWDiotm4p7lGBo3SPm067BgHsCiv5F21z
        rvPErzI55lQi/4G1xLaWGXAYO57C8z8b1W6QmRW9LQ==
X-Google-Smtp-Source: ABdhPJxj7YM6zAhj3AQS4Q/zgfQhrgo26Y9VqawaYzjMzEgFaAJKMhiYKDICb4tFIkvfF/WUJrUGvUG4TP28XNINk9w=
X-Received: by 2002:a05:6e02:1c4e:: with SMTP id d14mr34205ilg.121.1633550021310;
 Wed, 06 Oct 2021 12:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211006044111.2147359-1-davidgow@google.com>
In-Reply-To: <20211006044111.2147359-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 6 Oct 2021 12:53:29 -0700
Message-ID: <CAGS_qxqFULDPy65kk9=H23RJk+BWr+dsUD9fBnm3pQn2zU9KcQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Reset suite count after running tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 5, 2021 at 9:41 PM David Gow <davidgow@google.com> wrote:
>
> There are some KUnit tests (KFENCE, Thunderbolt) which, for various
> reasons, do not use the kunit_test_suite() macro and end up running
> before the KUnit executor runs its tests. This means that their results
> are printed separately, and they aren't included in the suite count used
> by the executor.
>
> This causes the executor output to be invalid TAP, however, as the suite
> numbers used are no-longer 1-based, and don't match the test plan.
> kunit_tool, therefore, prints a large number of warnings.
>
> While it'd be nice to fix the tests to run in the executor, in the
> meantime, reset the suite counter to 1 in __kunit_test_suites_exit.
> Not only does this fix the executor, it means that if there are multiple
> calls to __kunit_test_suites_init() across different tests, they'll each
> get their own numbering.
>
> kunit_tool likes this better: even if it's lacking the results for those
> tests which don't use the executor (due to the lack of TAP header), the
> output for the other tests is valid.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

I had been hoping we could pass in a kunit_context object of sorts to
__kunit_test_suites_init() and exit.
That feels like that would be the right place to store this counter in
the future.

But that's currently blocked on the aforementioned tests going outside
the executor and using these funcs directly.
So for now, this seems like the simplest and most sensible fix.

I wonder if we should add a TODO about the counter...
But eh, it was already a static variable before, so this isn't really
increasing the hackiness too much.

> ---
>  lib/kunit/test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f246b847024e..3bd741e50a2d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -190,10 +190,10 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
>
> +static size_t kunit_suite_counter = 1;
> +
>  static void kunit_print_subtest_end(struct kunit_suite *suite)
>  {
> -       static size_t kunit_suite_counter = 1;
> -
>         kunit_print_ok_not_ok((void *)suite, false,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
> @@ -583,6 +583,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
>
>         for (i = 0; suites[i] != NULL; i++)
>                 kunit_exit_suite(suites[i]);
> +
> +       kunit_suite_counter = 1;
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>
> --
> 2.33.0.800.g4c38ced690-goog
>
