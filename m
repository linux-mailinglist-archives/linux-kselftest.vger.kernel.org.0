Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57B54A029B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiA1VVZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 16:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiA1VVZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 16:21:25 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6DC06173B
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 13:21:24 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f8so6284935pgf.8
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 13:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYog/BqFDWNUevncRZPSz/7DuXyTbwEtBR6tVJ1Z7ec=;
        b=JTdfELdG5DjgJJA5MLvURWVhN3HOJkymfEO2b46OC3Y9DCLTR6HA/ak2T1AKpLMJEK
         BBCMnl4VT84crQCyuMVSXFfEmkYn2VQLHTBx+75VvEOc7YYXynUoDx60pxBZf8yLhHvh
         h8LMUUEUVhEXePjKNBWe5pnc4GiMoYODg+kshlC5MZ1Ciu/lNtdovB+f3W5eIVwRjADR
         dNO3Z0U2posO7lwRWqMjZnMKPa4ZZNIRovwFsdGUEq5fxPB1Jyn/6I8EVYBuoaWM1MN9
         PLbcagmWKrOnbobyfj+HCzVJ0tGwygqcBZYyPsUMhOm7cxyAp0PqQbw+7F1qPa8e0HdI
         VSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYog/BqFDWNUevncRZPSz/7DuXyTbwEtBR6tVJ1Z7ec=;
        b=OUvYc3Os3+raSw0/AHMXfgoSEa56a6Zw6bZHvdZ+2M9vFFpkZI5IrWdZ0aNl+A10Gq
         U1Xhb8d91rQ98RXNQ3uSsj/Vwk13M7VufgcP5D6b/UnLSoWBqqQQb0vYCWGsSomSiNYN
         HtOm+WiViT/I2SgKu5a9bGqGiS4C9/yV8/KtCoISlTdKYnMR50zVlhxgb+epyszVkJOS
         A9l2KLgYDzK/fTB0Mm4pkJaeq5554hPqoft4u0we9viJWtu4eGfcZg34+paQl8C/YZ/V
         dHUmBx1CyOJKXyu/kX4JquBkjAI7x9QWxyx/jPBA6P0KIY4B/HLHGxpmtsF41yK6X+MJ
         ZKZw==
X-Gm-Message-State: AOAM530dbyO5162XzZEB4CE73D5lSINYCxJiig015LtmRRNUInwsCexg
        TDakvZ5CEFSWgOvXy2OeUlppLxbx34Uwh8y0Gm31+Q==
X-Google-Smtp-Source: ABdhPJzbpNIre/OilPR86TNoXJzaHM5vK9Oqem5lcugnKToTZ8sd15K4YCPa4UhDD+gJ4UfSvBoXLn8/ATvLduhboJQ=
X-Received: by 2002:a63:184a:: with SMTP id 10mr7861393pgy.609.1643404884224;
 Fri, 28 Jan 2022 13:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20220127215222.159049-1-dlatypov@google.com>
In-Reply-To: <20220127215222.159049-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 28 Jan 2022 16:21:13 -0500
Message-ID: <CAFd5g47imcBAPNqrX+ZpmVzw8mgaPiBX_ip0euFAgmTA3cxitA@mail.gmail.com>
Subject: Re: [PATCH] kunit: cleanup assertion macro internal variables
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 4:52 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> All the operands should be tagged `const`.
> We're only assigning them to variables so that we can compare them (e.g.
> check if left == right, etc.) and avoid evaluating expressions multiple
> times.
>
> There's no need for them to be mutable.

Agreed.

> Also rename the helper variable `loc` to `__loc` like we do with
> `__assertion` and `__strs` to avoid potential name collisions with user
> code.

Probably not necessary since we create a new code block (we are inside
of an if-statement, do-while-loop, etc), but I don't really care
either way.

> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
