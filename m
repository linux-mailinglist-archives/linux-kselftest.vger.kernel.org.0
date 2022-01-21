Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148294967B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 23:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiAUWK3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 17:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAUWK2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 17:10:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67652C06173B
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:10:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g2so9222944pgo.9
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 14:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nvi/m8Z51+IsA+58fLvPnNjbPxqiTKdoUBValJp5m4c=;
        b=EKRWhVtlouYzx2kI0sEHPR3CATxXCmiBipRKWQjcr/7dt60wNDtgGJ5PsGRODT9xO3
         MvhX9vsmJR3BziDWHcJ9WzwOH3ilHqRzxPfnAXiOfAqhz0jzpX6H3puRELeFvimGGdKR
         XOUAf+s+dnji+YCi/7jcyeLnkwW2R28a6Gv8yH00zgXK0Y85ybUTtOXcoM1Dm/5K/vpx
         TUQtY9GJjY1CwA4rL/uNVEEj7J3rqHzfDoJgsqVOHu+vzFjVYxfKzd8Fr/vk/6J3FSlN
         yvMxas/i5RxxhmY+Ox7gTSClptuJKy56qyEwIPSM0dQaBoQ/iaCUEuh7LbFnP/zWM+t5
         mZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nvi/m8Z51+IsA+58fLvPnNjbPxqiTKdoUBValJp5m4c=;
        b=7iLN/zlwsvrX9mlTWhCNy7PHwm7GY5w4GfBwD/0NgmTB37JkaXdQwk1570+2OVrA8Z
         ue55WZMTwQSVjmTdB4h36+ucirPcKqNftauIHBI99QYHzAAvBqS5/IYvtW9Nu/Ymwiw9
         4cspCbAtV2OSL/jal9Aysju3MjWXXlJ+mGoUDtEC5fXtIVBIdMM6hVstsqFfTDTlfJH3
         gEbWW/G88wRojr0MWw+hdjliL4KokThkdghxckN7IWjT7Z32Dtkt3Aqf29z4CvbH8j1P
         8yj3PxlLL1rnc7TdTkWoYdk6OGcuaoDTLTBpR+0WJtIwaYOfxeE8qOyNpIDTvWLVDt8C
         JrrQ==
X-Gm-Message-State: AOAM5336pZBhA5oZzarnS+Ut7hPibxRX3zEfyw1Hx+antiaedF1lRYDZ
        v0Or1Hu2r30r3GPk9NXXHaH5HAQqiJdojj7GlXo9Ng==
X-Google-Smtp-Source: ABdhPJx+us5qeFmknw1fISfwSBlzD/rpiEsPMRtg7Hx7gRL/W0hSjD2WQ1d1cGP1bLNDl2zXx/8qVK2mX1cWRVAm1Uo=
X-Received: by 2002:a65:63c2:: with SMTP id n2mr4189241pgv.609.1642803027684;
 Fri, 21 Jan 2022 14:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-2-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 17:10:16 -0500
Message-ID: <CAFd5g4728mSzJXhFFRLrUcprTW52-1ECOJT8FvH3gyQWxktZwg@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: make KUNIT_EXPECT_EQ() use KUNIT_EXPECT_EQ_MSG(),
 etc.
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 18, 2022 at 5:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> There's quite a few macros in play for KUnit assertions.
>
> The current macro chain looks like:
>   KUNIT_EXPECT_EQ => KUNIT_BINARY_EQ_ASSERTION => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_ASSERT_EQ => KUNIT_BINARY_EQ_ASSERTION => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_ASSERT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
>
> After this change:
>   KUNIT_EXPECT_EQ => KUNIT_EXPECT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
>   KUNIT_ASSERT_EQ => KUNIT_ASSERT_EQ_MSG => KUNIT_BINARY_EQ_MSG_ASSERTION
> and we can drop the intermediate KUNIT_BINARY_EQ_ASSERTION.
>
> This change does this for all the other macros as well.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
