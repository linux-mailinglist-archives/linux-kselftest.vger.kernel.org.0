Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE46229FE60
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 08:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgJ3HXO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 03:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJ3HXI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 03:23:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27489C0613D3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 00:23:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id p15so5829263ljj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+0+hcPw9hiA2N8VeGNQmNaGhTeQiMRTQ38kHTPj/A4=;
        b=hRdtNuEm07hzyAkZDjHciqako2c3MS3efQ83LmgSSHeMGo4rLC9IoAvnQDaD3oQdcj
         iIyiZAXsz4HtnNdK0NPgm+GuhsYl8WOeUcfh7OOElaj5r9+vkpXDVKJtP9PZm6bHhTQj
         m1OZcy2oYAKEUizydv/JuHt8UUbr9AgnouOgx84QzDl5pzRklFfQ40SiV6tEtjVk/sWK
         bLAJb/V+kyppNSuMRhTruFMou0gScpXBvG4s0CFLZWHdq8olBcpsi56UyB+yBbgigxen
         DZ9/SbmR3oyFprrpBQkqZMQLS+XQm0AAcZv3/vcorICXW3vow2sd3anoRkXgjMbUz1rU
         qA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+0+hcPw9hiA2N8VeGNQmNaGhTeQiMRTQ38kHTPj/A4=;
        b=U60mHnc496hH1R8XFtaZz91iOip29rhkMtpExynIquI0w8BGE8blYP/EC+7mtxwkNU
         K5hc7OWhz7KG9hdTEQM2m2cy5k5dNjBll5ed9xVRXwbv76WP9nlrOYbO/IH3gPURfafK
         7MSpZG+lOrQUfTQJLv74plnmz/RGCgWXTI6bg6+Twedxb4AY6NFQVHJnl/vCcapJseYU
         Cji6rKS5RunuS5sWkpri/pRkIPKa5JvDMTYN2VX3eZvHK053fUejZP30RSqMEZ7Lk3CM
         Ro2D5sMRXKap09eISd4pGu+b2RDNQWt7pvrd6RDfROT8NJwx9CueKru1zBcWIkDcpuhO
         NMvw==
X-Gm-Message-State: AOAM530H9GjMNMx9mctM0IyLq9MEBwvTnRjAAhcFdv7k+nu4mA6acw7R
        /O6vb2sgpxZViIK5re/zDCbt89DKEKRD4OmLv6HWqQ==
X-Google-Smtp-Source: ABdhPJwh3QNHZg7opOMZVBdwLRjUA3pBcah/ZGhVI1TBFzhvygkq1Eno3AvWYaQ8ff+n7XpgNUjxjw06fWBwoFI7Ung=
X-Received: by 2002:a2e:9789:: with SMTP id y9mr437932lji.456.1604042584493;
 Fri, 30 Oct 2020 00:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201030061655.162839-1-dlatypov@google.com>
In-Reply-To: <20201030061655.162839-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Oct 2020 15:22:53 +0800
Message-ID: <CABVgOSkn1n-N50YZr7aNTgAGxkj7zkZO31B16Ji88OxM8m2WPQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix --raw_output to actually show output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 30, 2020 at 2:17 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently --raw_output means nothing gets shown.
> Why?
> Because `raw_output()` has a `yield` and therefore is a generator, which
> means it only executes when you ask it for a value.
>
> Given no one actually is using it as a generator (checked via the added
> type annotation), drop the yield so we actually print the output.
>
> Also strip off the trailing \n (and any other whitespace) to avoid
>   [<601d6d3a>] ? printk+0x0/0x9b
>
>   [<601e5058>] ? kernel_init+0x23/0x14b
>
>   [<600170d2>] ? new_thread_handler+0x82/0xc0
> making the output unreadable.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

The bug where --raw_output doesn't show anything is already fixed[1],
but it does still show the extra newlines.

Maybe it's worth making just the newline fix, and rolling it into the
other patch[2] handling newlines?

Cheers,
-- David

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=3023d8ff3fc60e5d32dc1d05f99ad6ffa12b0033
[2]: https://lore.kernel.org/linux-kselftest/20201020233219.4146059-1-dlatypov@google.com/
