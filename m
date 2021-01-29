Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F4308E30
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 21:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhA2ULR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jan 2021 15:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhA2UIt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jan 2021 15:08:49 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACAFC061788
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jan 2021 12:08:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so6921848pfk.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jan 2021 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZplRB5Tg2q+M4+quDwz0eaDBOJ49cnkS/1+zENpun0=;
        b=cYB8/12zS1BJtO20+Y1r1Fdo7iI/xRvjCckA5Is6Syvhd0KnoTgQm1gRoL4TJ84xHE
         BDcV1jRprMQb/zKJYxlcCEIxpJ7DXqX/D0I/A11QJ3l2w/2ijTRB0DALmsI1K4u4ZUj6
         m88M9j8n4HfBBmp/o/UENK1J42wkPK2gJ9dp+kdoyG/nP7sLMG/6SIs9l+TCg61ACW6D
         Ln+kRUgv0G22y7QhkcRSa8Wu2IVWHVkjc/n5iaXnB1lqOu+9hE3288BTim2dAsI36H3k
         eRxTrunTp1j6UpD5w6Wb/4ZyDijEOYmCevEsauxiC486JFpREXUck+G6xfFpOYlZibYm
         2GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZplRB5Tg2q+M4+quDwz0eaDBOJ49cnkS/1+zENpun0=;
        b=IJXb1ckGKKNqbBVVii7lm/hhAPZo48Z/1M1pTGdpumrCMGt1Ud4l9skliQd0lVAeNk
         lo5ThfrFg9T6E6ajIUBzPnCfJmearnzU0QvsOspmkBV8XkOzEn1l7ySm1b3Nbepu4g3m
         LOzOGniYX8HCkuNx9EPI5KSAl7lijxHHmh7ukY6BCQRIsqhAWZK95kB2P0HUuCsLz/ZU
         y7bCIEsShi6gm7WEsO79PHpzcroi8vBfWcCQtZZFUBrQpW4ZwAgpKwJ2GxJaFGAcK+Tu
         FpDD8rGLYxrSW+2sdu3F2BGU8dB/QVISXp4ZddJjMRy/eIJQEo3jt3C6Jm/GRERouy4w
         8YBw==
X-Gm-Message-State: AOAM531a0G37VMJbUBvkAvd0rSSwM0/A7zKsgzRPTlie2JeD1ikK/jAj
        CaicsIP1CxRShaX8d4NYbp8UrkIPdj2rKxm1AFBOlQ==
X-Google-Smtp-Source: ABdhPJyL1WHwunX/u0+Q/xOKqwiTA6zHsySWAjUUgYE9BA8k8r8MySwCQAbPorHv5HZcD4S60LV17SpSF78YeSabwM4=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr6382452pgi.159.1611950888032;
 Fri, 29 Jan 2021 12:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20210129022555.2411999-1-dlatypov@google.com>
In-Reply-To: <20210129022555.2411999-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 29 Jan 2021 12:07:56 -0800
Message-ID: <CAFd5g44DrzNdDZnaHYAHt48c6+gNPpGwULYxaF=ENGWmMUomLg@mail.gmail.com>
Subject: Re: [PATCH] kunit: don't show `1 == 1` in failed assertion messages
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 28, 2021 at 6:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, given something (fairly dystopian) like
> > KUNIT_EXPECT_EQ(test, 2 + 2, 5)
>
> KUnit will prints a failure message like this.
> >  Expected 2 + 2 == 5, but
> >      2 + 2 == 4
> >      5 == 5
>
> With this patch, the output just becomes
> >  Expected 2 + 2 == 5, but
> >      2 + 2 == 4
>
> This patch is slightly hacky, but it's quite common* to compare an
> expression to a literal integer value, so this can make KUnit less
> chatty in many cases. (This patch also fixes variants like
> KUNIT_EXPECT_GT, LE, et al.).
>
> It also allocates an additional string briefly, but given this only
> happens on test failures, it doesn't seem too bad a tradeoff.
> Also, in most cases it'll realize the lengths are unequal and bail out
> before the allocation.
>
> We could save the result of the formatted string to avoid wasting this
> extra work, but it felt cleaner to leave it as-is.
>
> Edge case: for something silly and unrealistic like
> > KUNIT_EXPECT_EQ(test, 4, 5);
>
> It'll generate this message with a trailing "but"
> >  Expected 2 + 2 == 5, but
> >  <next line of normal output>
>
> It didn't feel worth adding a check up-front to see if both sides are
> literals to handle this better.
>
> *A quick grep suggests 100+ comparisons to an integer literal as the
> right hand side.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I don't feel very strongly about this either way. In any case:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
