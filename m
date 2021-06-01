Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4E3976FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jun 2021 17:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhFAPqY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Jun 2021 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAPqX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Jun 2021 11:46:23 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED71C06174A
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Jun 2021 08:44:42 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b25so15820012iot.5
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jun 2021 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvfBq2aXtJ08TGHS8dCWxvUmTewAGJbPcj6f0TWlUiY=;
        b=kRP9RlunMLDQfqS8+ys+DPhZExy23ZacwK6tldf29WDZpUF9gMrU53snMNzxbOK8Xx
         mFBKUUhUjw2mJKRMdKO8xXTbdkbju+jNtMPX3uGyompBImAvdoPQ9hKtelQZjwaJk/1m
         W729w4nS3IOnXZ45i+J7UUP3+yzQMn0TRsaCJ5BV2EK08w30jsd+Rui/r6Bs6fZoH05W
         XqYJuQxTiBtHsFk3+hJU64fLX0dUYqHWwwAmkY/KYdCEMxWvmSXwgfDq4ViCFGNMFw85
         txmnvZvHyvN2N0+mfIJfIfQYcXxhFqyWEg0EQ65Z4gTejqVYbCU5YV5a5HK8sjfwpCJm
         Vleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvfBq2aXtJ08TGHS8dCWxvUmTewAGJbPcj6f0TWlUiY=;
        b=rlN1iUHerHtrKpaPFbei03CYdmEl7J1gCpvepaSHFaql1/vbP8fRW6GoBN2IwVcSOU
         zA8n926yUrjO7jByS3ysGcmatdjSGW9W4XrcmcNuhxrCUTgF4MjfxQy3HNHh2PRX+3Jc
         n5LxV0n73A3Wn5jyKYl9GMmUjC3dU5yWG/lwm72PdCGizFpEyEA93WIFMiIVi2Iu50gp
         oHR4wL83OuctgkwkHRAKXl6eebbKAOsXaP/jI4opPVr8yss6GatzulLRtawciOS/yZps
         V472x08nzzKJULlR0r8XvZff7NP4TfR6pkUbyTDOPvdzjjTaocKIdBahcaXzx2KLfeW+
         oY/Q==
X-Gm-Message-State: AOAM533iQaH4By2DoJRYlHKblCtiv/EmPzYB1/pVcSFK2RFxBXqpXAqw
        SIhnJcV4RmwOP9HAsUbLIP2dL2IEu7kztJ128Jqtng==
X-Google-Smtp-Source: ABdhPJx/UMblI0JBFNQGhmSUwzNnzmzVmDXqPuPba6tlXA1wNfGoVEasufKEZ/1btEqVM+yw8XDTXVMNqCEn91SVNFA=
X-Received: by 2002:a02:5b45:: with SMTP id g66mr11315101jab.62.1622562281646;
 Tue, 01 Jun 2021 08:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com> <20210528075932.347154-4-davidgow@google.com>
In-Reply-To: <20210528075932.347154-4-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 1 Jun 2021 08:44:27 -0700
Message-ID: <CAGS_qxr+nOBoL86GzX3o+CUvp0FFGv7qJh70ALUxe-Hr6X7+xA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kasan: test: make use of kunit_skip()
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 28, 2021 at 12:59 AM David Gow <davidgow@google.com> wrote:
>
> From: Marco Elver <elver@google.com>
>
> Make use of the recently added kunit_skip() to skip tests, as it permits
> TAP parsers to recognize if a test was deliberately skipped.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>


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
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
