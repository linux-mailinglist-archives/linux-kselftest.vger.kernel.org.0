Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55776475A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiLHSem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 13:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiLHSeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 13:34:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6A8F0B3
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 10:33:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d7so2337258pll.9
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3HMnEdvlSF5TjjjrupZOysPGDweIaS3qD4bjjLotW48=;
        b=KE7SYRHqlqq8QkfVRH+aj5xt+UojUw/LjLkt04Mk33NpQt8FmxscR/m0rESsgU7iou
         hs3k530a6Nlc5wvphwXX/GwbcNynh5tBwKPHYG6Dlo5aonRwQc9tJkPnqX0uZUTIBOhp
         pQRoJWNjCM2NdrntCc241rXSsNInrTt1YhDAjfI2mtja0Rtb2C07/tj/ggrh90NhIsKc
         SuKzAZ0WEZDAjyM34QsXXFMsc99zHfeEmg+5qutqLe5DWCGdPy2WFJyLMQ1z9QH7YFGj
         f981OOSr1zCwl+I1ISonvF5sdNwUdDkYP6BPM7pP7mVl9FkQqHOP03wWry0uJP/Y5DEr
         426g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HMnEdvlSF5TjjjrupZOysPGDweIaS3qD4bjjLotW48=;
        b=JOHzAu02Ieut16fZH+ilM9BEB4S1h9sYIcbrYpx1Z8ZzNU4IVmak08nYNuEN1hWwgA
         INa8PBOPgD//rtQgZhEhkT9/CMRZ2XSDlwD3yoB/8eeX2s8HDIiRBTWeTLrt1jPj6V5U
         UdEzrXtrXHO19K/YeIaTewu/8mvNsy1f2E7rVR8oW6/IGSxuxfAGQxy91YWxHUM4U5Bd
         FgNwBypdo6Mf2cnn50UuQCS4NHnALl06xJ5nSL1acfJTFs4JqZJ3CnNAD2KPCJBdq2lX
         ngKJTTKa0h++U+KRNVaZlUM+8Dzd8gAPFqBedwmB94G1VAiws9aJee2WdkChdH/gD9WP
         cmUA==
X-Gm-Message-State: ANoB5pmBvRMmjk9CpBOsygISumZJuseTxTl9G9OzYgOVmn7nh5eghcZr
        5wDOOLgGTrBMDZUjxqXVeZ3n5qfJdPlZScxPaEGgCw==
X-Google-Smtp-Source: AA0mqf7v9g7E7bWC/SwAnZzMQJjPNqcL7NCSx9bBhwK1qoxmDIDfQ2miJHi8NJFOjjeloV1lv0mzWXlBlxmWDysMHCU=
X-Received: by 2002:a17:903:3052:b0:189:63ef:ef3b with SMTP id
 u18-20020a170903305200b0018963efef3bmr64459851pla.112.1670524436153; Thu, 08
 Dec 2022 10:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20221207154939.2532830-1-jeffxu@google.com> <202212080809.687CC8BC23@keescook>
In-Reply-To: <202212080809.687CC8BC23@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 8 Dec 2022 10:33:19 -0800
Message-ID: <CALmYWFukzdw4e3RHWRsdXvYr1RZs7Bx6NZ3AK91hoArgVy-RxQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 8, 2022 at 8:13 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Dec 07, 2022 at 03:49:33PM +0000, jeffxu@chromium.org wrote:
> > This is V6 version of patch: see [4] [5] [6] [7] for previous versions.
>
> When sending a new version, can you include an overview of what changed
> between this version and the prior version? This helps reviewers who are
> following along, so it's easier to focus our attention on the
> differences. Also, it's helpful to version the links:
>
> > [4] https://lwn.net/Articles/890096/
> > [5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
> > [6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> > [7] https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
>
> e.g.:
>
> v6:
> - moved foo to bar
> - improve comments for baz
> v5: https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
> v3: https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> v2: ...etc
>
Will do!
Much appreciated for helping me  through the process of my first patch
in the kernel.

Jeff

> -Kees
>
> --
> Kees Cook
