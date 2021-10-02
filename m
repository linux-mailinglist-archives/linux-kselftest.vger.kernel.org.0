Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF65D41F978
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 05:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhJBDMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Oct 2021 23:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhJBDMi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Oct 2021 23:12:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC0C061775
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Oct 2021 20:10:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so2827038wrc.10
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Oct 2021 20:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tfz8zmQgeO1eggWVGFY1FGxn/XYdmF/KfNMWX/AEGxQ=;
        b=GTqZL9MOhbBTOD0ec9QBdNPCu79/gtZOF+SKRjFS2ZlYTTyPffJJOMMNW+ePcHAg6f
         wyd3K9Yxfo0daM/xzvQny+MuugYDL+32Qcr8+6Zff+rHgl0bspub1NibX10/UsjMYYme
         4iWAYqt2TsiQD2uge5E9yTTrPbyjgtK7LlMCPWXAWm0TKf3nahvuXLI1zSYjMp58X3oP
         LDVI0TzX0kIMMALqBB8VzDnoo3PUCKFPviBg2EvM1BdHVNpXHskpuTR/0oEdbIJ6soNg
         1DEXrkdbeB4dfwOCeXpwtkk4dZYpzmqxCHyN0bpiDwALOgE7RbdPrT8Y6tXOKT7cwsBO
         otBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tfz8zmQgeO1eggWVGFY1FGxn/XYdmF/KfNMWX/AEGxQ=;
        b=8NTHTjf5n4TUurElCcKKJ6/EA1WipDETSaeupIP+9p8zncdpEYIQz6UJzdUaq3mKIt
         /KiKwAndVAH3Z3JDe4HA/7HSHzRGCvHVBSaoXZNazfoJuWwz3XfNIAxRnOqbG/OG6ofC
         WGqDHXN4IvSdEZmnLdN1RfszTeeSe/mY11jcDFD3qiouhApuog2g9UDhnvAgMdz80rHO
         Bo2wNeJuhbdJrOH1ZfcIVKVXmoPLL6sh92ZpHFuGNs/AHoE1SbZOwE7gw/ki0EoSR8zS
         PY/Sl0FqTzMnJ3D15p5TTq2Y+29wOxHrdqqlPL4HNwTpg7MFaxPxW+HU+ibz8F36AtkI
         baBg==
X-Gm-Message-State: AOAM530rnjMNSK9i5OhCyHS2gXiBS1lFNaqbVryjmTQ/7NZs6XfPBsWC
        kByr15bCEQ69pPPKtO1MPXaPnwuUwB6aAbLPNER8kQ==
X-Google-Smtp-Source: ABdhPJyaIkAOm3BnAWyosEiZJMwTdQYdQp9/7bq81nO8G/hxv8QddOqP70ufQI/iVglTD+4bAxm828ZPARQ0IQXMq1s=
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr1301103wrp.44.1633144251572;
 Fri, 01 Oct 2021 20:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
In-Reply-To: <20211002022656.1681956-1-jk@codeconstruct.com.au>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 11:10:40 +0800
Message-ID: <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 2, 2021 at 10:27 AM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> The current kunit infrastructure defines its own module_init() when
> built as a module, which conflicts with the mctp core's own.
>
> So, only allow MCTP_TEST when both MCTP and KUNIT are built-in.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---

This looks good to me. I don't think you'll be the only person to hit
this issue, so -- while it's probably overall nicer if tests can sit
in their own module -- we'll look into finding a way of supporting
this with KUnit at some point. In the meantime, though, this is a
reasonable workaround.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  net/mctp/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mctp/Kconfig b/net/mctp/Kconfig
> index 15267a5043d9..868c92272cbd 100644
> --- a/net/mctp/Kconfig
> +++ b/net/mctp/Kconfig
> @@ -13,6 +13,6 @@ menuconfig MCTP
>           channel.
>
>  config MCTP_TEST
> -        tristate "MCTP core tests" if !KUNIT_ALL_TESTS
> -        depends on MCTP && KUNIT
> +        bool "MCTP core tests" if !KUNIT_ALL_TESTS
> +        depends on MCTP=y && KUNIT=y
>          default KUNIT_ALL_TESTS
> --
> 2.30.2
>
