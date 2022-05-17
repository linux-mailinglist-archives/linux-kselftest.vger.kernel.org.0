Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27452ACDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiEQUjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353022AbiEQUjK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 16:39:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DCB52E5C
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 13:39:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i9so402341edr.8
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFAZEBFOY9SmpYWcYe+bNPVMfKhT4EeYmR3/AEfOrRQ=;
        b=qIiIfGP9SJn0HMWqwfthodh2jdAShSFM+ARfk4Nkfuuq8BK7um/fiyvlR1vEIcas9+
         HVS/vce71sLHrnBlACXe1owCUDxTy/QUgnYmAjoyVtlBnBeQpXJiOvVUne0noESMRvn9
         f0XGtGuocAgpHYwyvUuCA/Vno1McJGfiyo1+NWyAG+Ubj6kqD1bZ0CZ5eH22dpX20Swc
         DyZbbhelV8FPN6fi1AxTXfmvhPR0k3toUWTZNx08pJbUVyo7MqDzQQcg+m2b5ykQq+uL
         5cswuWypGHzD8OM0v20Ka0e4Yc1grf9HfaGIe2imIMbicrz/2au6ocz1v1vTnPFFHeSU
         D2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFAZEBFOY9SmpYWcYe+bNPVMfKhT4EeYmR3/AEfOrRQ=;
        b=serXLVfd0Qqf0cWiNfFDP/pEZwhdnh2QROZGtlHrlzSYHpuQFewXemn44QGFOp+jYf
         JJCnJXEBqCE5OOHCB8xeyb4ZLTnQjF3DwmH7/OeLSjHA/Znuc60sI7YQKBSi0aPWMIvD
         ne2KfHqhh3RWtJzU3JHtWyZP/c89grT44fEeCCBjEGUa0jvf0X/euU/ZqZJKOp3aULcs
         zfC4EfJL8d9yLqK/25h7to96lzBST1Vf6zaH35GcdD4Y2PF8M/9vRtOcHB2nXWJAK5pE
         s2G8KS9ws14gBAFxyErmAUy/1/A/TcHr1p8+kDROP1cSERLxkKUuvWJ/SSqe8bQe9hMf
         TqXw==
X-Gm-Message-State: AOAM532hKGhnqQecnWl7XiV7wkISqvER9JoVbP74VfMFS8Z3TzfuRc5H
        X6Scc3yb+zwnaR9FPsGi3PI7nQC8AnbpeiQP6OzwYg==
X-Google-Smtp-Source: ABdhPJxeRR3pFJJ2Mj54dRvGTD1BK3KI9tP1xr/8Cxp2b/FUFIwyROHJj8wRMRSi8RBvS0sEGWkbtxTYO+wZnLyvh/w=
X-Received: by 2002:a05:6402:51c8:b0:427:b374:6af4 with SMTP id
 r8-20020a05640251c800b00427b3746af4mr21002593edd.349.1652819946747; Tue, 17
 May 2022 13:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220513085108.3567310-1-davidgow@google.com>
In-Reply-To: <20220513085108.3567310-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 17 May 2022 16:38:55 -0400
Message-ID: <CAFd5g47zzgs8eWU44aboYcUVtiQAoFFioNuTvRTMwGgOg0a8ng@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Use qemu-system-i386 for i386 runs
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 13, 2022 at 4:51 AM David Gow <davidgow@google.com> wrote:
>
> We're currently using the x86_64 qemu for i386 builds. While this is not
> incorrect, it's probably more sensible to use the i386 one, which will
> at least fail properly if we accidentally were to build a 64-bit kernel.
>
> Signed-off-by: David Gow <davidgow@google.com>

A very sensible thing to do! When I was writing this, I probably
copied and pasted the x64_64 qemu config and then forgot to change
everything to i386 - whoops.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
