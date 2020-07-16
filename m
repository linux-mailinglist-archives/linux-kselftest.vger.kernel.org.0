Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCBA2218FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 02:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGPAhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jul 2020 20:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPAhS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jul 2020 20:37:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15EC061755
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jul 2020 17:37:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so3947959pgc.8
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jul 2020 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVodWiEHQkq0E0nBn3v+yTDqfSzN287V6yNqrTXAono=;
        b=DFRDIY5fVPO+tRVNaoPThKmwQLGgQrirP047p4B4mIhpL3deqJvaKcI6gRIHq2khNf
         F2HBJTLyaJ0AOeUJMrdPmoZXu1MX6JIUNyHpWyKuJmvM4f/vwPug1KfLEUZ9EumRKA8+
         BDV3AXymAZFVYqoNfq8/LWIfCLKe5k65NnSlI0GlLgzpaZG5zzpqmG/4uDVihsjMcOeU
         RRYscvBpSrSYR2qq/IoM2yj8IHgx7LEJk22IysJ1llJHOVowsOCwtN28MeycXUYHEswY
         ai80mqr23WL40hFdEbfuHRotDCTONfWYWb3obD3Hmh1+8qpd3YxhafkepdkyH2YmY3R0
         59FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVodWiEHQkq0E0nBn3v+yTDqfSzN287V6yNqrTXAono=;
        b=Zz8OXvPJp+CD4v5Z9SHaZiAKOrutmhqKYdPYNW88oINfJvyb/MEUI0rDLorrATLnzD
         lgcC24QmqLFWFcInjnXfmSJMbb9/YjhqwJo/2CjsdJLMoiRHH2fMXi92UwSzxKg2ix8t
         yk/HkMZNuoImrpm/hMjEC0BcDczEHDpgCQ4GgkBfqhL7qg2jVIz1P3wA/TcHHeN2isEO
         qzCMOw7bSMKeAzJkp+1LNZwFvDr/hiFxyIOpoXWi9gc4rrhYqXK2phoDwrBzRRd0yLlV
         2RzRT4018rGhKES/mrWn+3fRv6iRzmSQUAH1ZREjPxSBkXy6GUJo9LjQothBy5n8mcnd
         kYMA==
X-Gm-Message-State: AOAM532RLf/1zoFPI+O86Ph5RlocPzUkxHsmwcz1uCYQk4Kg2dm0UBVz
        pgnjgOPZtWgJhpRAj7uHyYsnlwsySGD3VoC7yVeMiA==
X-Google-Smtp-Source: ABdhPJxGnJt4lUyRPW/VpEnwG2xIOd8fevL53BtMpqCJAdDEXJ8OmXXg7qkQPjBLGYmVPWNYLNSVgaXlhqhI5V1KDoQ=
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr1944707pgc.384.1594859837823;
 Wed, 15 Jul 2020 17:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200715031120.1002016-1-vitor@massaru.org> <20200715031120.1002016-3-vitor@massaru.org>
In-Reply-To: <20200715031120.1002016-3-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 15 Jul 2020 17:37:06 -0700
Message-ID: <CAFd5g47HPGjX4AYuBCjH8DqSUMNO+yqjudWH+ZNovStM+aXExA@mail.gmail.com>
Subject: Re: [RFC 2/3] lib: Allows to borrow mm in userspace on KUnit
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 14, 2020 at 8:11 PM Vitor Massaru Iha <vitor@massaru.org> wrote:

Probably want to add more of a description here as what you are doing
is not entirely trivial to someone not familiar with mm contexts.

>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  include/kunit/test.h  |  1 +
>  lib/kunit/try-catch.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 59f3144f009a..49c38bdcb93e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -222,6 +222,7 @@ struct kunit {
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +       struct mm_struct *mm;

Part of me thinks we should put a better name here, part of me thinks
it is fine because it matches the convention.

Either way, this DEFINITELY deserves a comment explaining what it is,
why it exists, and how it should/shouldn't be used.

>  };
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 0dd434e40487..f677c2f2a51a 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -11,7 +11,8 @@
>  #include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> -
> +#include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
>  #include "try-catch-impl.h"
>
>  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
> @@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
>  static int kunit_generic_run_threadfn_adapter(void *data)
>  {
>         struct kunit_try_catch *try_catch = data;
> +       struct kunit *test = try_catch->test;
> +
> +       if (test->mm != NULL)
> +               kthread_use_mm(try_catch->test->mm);
>
>         try_catch->try(try_catch->context);
> +       if (try_catch->test->mm) {

Here and below: You already have a pointer to test. You should use it.

> +               if (test->mm != NULL)
> +                       kthread_unuse_mm(try_catch->test->mm);
> +               try_catch->test->mm = NULL;
> +       }
>
>         complete_and_exit(try_catch->try_completion, 0);
>  }
> @@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
>         try_catch->context = context;
>         try_catch->try_completion = &try_completion;
>         try_catch->try_result = 0;
> +
> +       test->mm = get_task_mm(current);
> +
>         task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
>                                   try_catch,
>                                   "kunit_try_catch_thread");
> --
> 2.26.2
>
