Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541AB190C8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 12:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCXLdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 07:33:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37989 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgCXLdE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 07:33:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id z12so14598915qtq.5
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Mar 2020 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Qc7uvYUanhBTdoYQFCXEMtsiSU/KMpNbflyVVa/k/0=;
        b=OK1kyUrgihIZSOJwUiTfwpiYANyW7kApVKmQ41+ImaXUd6xpIUQzC/fBdhJd6QlCtU
         oOV6vfncP1EW6DCy1bY6KN0oboppZMXnPmlHIxSXvSjDYvnMCxWsYKraHjE4r3DB09UP
         gnznbW1v5LROUTwb7VS6nbQV/KRcAggzMV/C8CjqHpB9EOCkL7Ft4sV/wD2JgEGuIbwI
         r94f3QvSrxCo5tRNA+an9IsKvURFkSrk5MibFzg2LP2VY098kj2C1tFT54atLiAOlmph
         bPR+xlaSuzrnjSslsaH3muNhf39gJfUab7DI9TQtbD4FQuJBwzPeJUr4NAs449zLrAY6
         A3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Qc7uvYUanhBTdoYQFCXEMtsiSU/KMpNbflyVVa/k/0=;
        b=hGQjs2IXTRUPKuZTTL/Ohixe8YUR/BMr1LWMQvGBVxgitjhfTVXnU0bwc3BrcHfBaS
         qgPpgAY5q+94xNiXyoYOcfTD3YyH5+5uyO/1JsUJEAci54SclokkdzfgwUMhSvzcKMlG
         UzG64ou0PLBQO6uGXKUmfWg+6HAWUMyr2hPRHDpe+ZNjML23g4/2QkvILU27rUdQeQj9
         9MGNSD6PsXkh8TbKZ9DkRkGSC35jkelAJIEYoHh0jjifTz9Iu5olfnd9jr7OFzvd+YDd
         xlRdt1NtMy4XgnfP1w5kDT864ZdlOSBb2CfTEJYeCnqynoTA3ErBEelkcoN+ese/Ikeb
         PlUQ==
X-Gm-Message-State: ANhLgQ0dy95ZVLntL4TnmRYODbUJWSgjI4RTIISHMNGmVkjLUMvAZR9Y
        5csC/8uQVShN9K5At3a2dKiMdHB2/6B1T/5awqP/mg==
X-Google-Smtp-Source: ADFU+vtaIDlqEcDPnyVkLDfdein5xnF5prNYs7DXLAe+TaWYWAbSb1st0hXaOIvklJ7ZZ2BZWnsEnu+l8Up+lD0Zfkw=
X-Received: by 2002:ac8:719a:: with SMTP id w26mr25506964qto.257.1585049581891;
 Tue, 24 Mar 2020 04:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-2-trishalfonso@google.com>
In-Reply-To: <20200319164227.87419-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 24 Mar 2020 12:32:50 +0100
Message-ID: <CACT4Y+bbVtwfYUC_v3V0ZBh2kVwp=PHKq6Jyqiz6BVbLTtL3bQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Thu, Mar 19, 2020 at 5:42 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> In order to integrate debugging tools like KASAN into the KUnit
> framework, add KUnit struct to the current task to keep track of the
> current KUnit test.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
>  include/linux/sched.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..1fbfa0634776 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1180,6 +1180,10 @@ struct task_struct {
>         unsigned int                    kasan_depth;
>  #endif
>
> +#if IS_BUILTIN(CONFIG_KUNIT)
> +       struct kunit                    *kunit_test;
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +

Why can't this be used if KUNIT is built as a module?
