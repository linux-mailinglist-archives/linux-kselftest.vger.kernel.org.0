Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9124A839
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgHSVKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSVKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 17:10:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32CCC061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:10:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so13140pjb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISHsgRR5gl1O/B06PdWuntMjm3+ExqlO30Mr+J1G2xE=;
        b=PQ/fSMj0XrmkoZzKZR0CPMZehNvw/44Weg4jc42HK+CIyf5qjE1PYJfGFJVOPM81+V
         XdTT7clkmFaPSu7YXUD0ZrfauGexDDFjQjV2cRtF26zDONqog/mxRakacI8dVVzSozhX
         xMfKADktTXL/7dktq6oytc9ioxlRzGZozrNUm+Ay1xRnBee+78WPtV2QzQFd2S4DmN31
         gPNqhIeFbPzbxsn9voCo03tsh1ZQl3mke4fF6i4t4CS62rSxrpLOZ/1RG4KnCAGFd0vG
         tkMLJgOofjISqXRv3MvFCFM48r5gZP80UDhEtmIk1N8a+SFWyIxnGU2SKV7aOrJW3+HL
         lPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISHsgRR5gl1O/B06PdWuntMjm3+ExqlO30Mr+J1G2xE=;
        b=rAxoKV1/i5wtngDRbEDIb32rsyykgrY0c2vnG9B+4/AaODT2/BAfYBV04iDXIoZw5c
         AYG5+BvBO9YK+pAfmj3hm9QHSWsmYTgqRdCj3PhPQqV3cUrJd9C9d/rbYGwV3kG6RlHY
         Wt9suqYECO0YihBPekzxr9rZq0Pm2F4tpKtUPEFUBX4j9qnGluCtjFv8kuFe4OZItq0z
         wbn1Ir4QL/KfDNNmKmcc+GbQr+xHBDfPcCN/JqBnVQv69BV4ny5eDEqDpjrQVbz00TTG
         t7VAce9KdTYtOSIuF0srfGAbz0EBZSzo6BhLhMpB1uNsV0DvGKZ+OM2sB4dLVhw6m3tN
         nxjg==
X-Gm-Message-State: AOAM530KGvF8qQZYNvYLFmKpAaZNFL9zxIBkDP1hqRBz+XsHMpUMH+ZX
        4KkTzPgVMsLgvPhFNeVWN8Jwn0BafpF8prUGxdyYkA==
X-Google-Smtp-Source: ABdhPJw3rds3hFHXZBmb2t1NM0mWnTXuiGc2v5dZ5hD8649AwV9NTlXL0gWQVpT+9K7Iz9ak0hBsrTEyeAh4Vu5T6LI=
X-Received: by 2002:a17:90a:d317:: with SMTP id p23mr3682356pju.217.1597871423161;
 Wed, 19 Aug 2020 14:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200729175849.148332-1-vitor@massaru.org>
In-Reply-To: <20200729175849.148332-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:10:11 -0700
Message-ID: <CAFd5g47s09BfsqNx2RY1Zdp-TC4KbKgsMgr9-SHv1Nf6P9vAMQ@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add bitfield test conversion to KUnit
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, kvalo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 10:58 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_bitfield,
> from `lib/test_bitfield.c` to KUnit tests.
>
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> Code Style Documentation: [0]
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Probably still want a review from Johannes though.
