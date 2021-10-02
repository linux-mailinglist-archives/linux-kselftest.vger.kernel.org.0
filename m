Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B937041FA42
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 09:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhJBHYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Oct 2021 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhJBHYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Oct 2021 03:24:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C7C0613E9
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Oct 2021 00:22:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o20so1038015wro.3
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Oct 2021 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVE5mCzreyEWGRuGyfDzHoON1VOHz9px/MQbnjXolqk=;
        b=PE76Mrd4XLkHhLo7gm5RN08TMW3EumkhFgrjcbHDo+BybVsqV//xg+Tt1lxRiD/W+V
         bjvyW6sGdoMYthMrCaO4ZgH2B7lNX4jEwrpYBppQ/2A3bwuLvQQZXsXOOfaBjKgyq3MM
         5CRTFr8xM+5lWU6+AMjk2y0naDUlUZII3VAr3r1wRtbY93SiBs6ALjek22O/JD6vhmYe
         W7COvN0/JYYOPC1WHRUc+XxGNWK5vEieJ76maYRqMbF2D3U02lgn2AmADZn6l5hPUTRq
         H8/n7SMjPK+IRYLIWhlpYoWJbgm9MVx9JwhLmb2YNocLJsy17XJp9PIKQ48P3UX7/a6c
         8m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVE5mCzreyEWGRuGyfDzHoON1VOHz9px/MQbnjXolqk=;
        b=5Qvh3VmZdtULrhWiTp1gv9N4sNR/vMiELtu76HKg/Knvv9Z+xm/tCpxiSnchMarx95
         TlEYc0EFE4o86fROTdWuqiZT0FwQeQnGVqmyefT2L6XAJM9hdkrwuKXGcu6v3HlQPoOU
         DFm92SE7pHtEaNg6FD9Y+aIfdOCGxp9Ml4n3TWrQW/Bfa/qusMrZ8k1Doo4yrJlcr5Yv
         jcWmCkMpC4uXEr84lujqxWMbY7XyZoynGIOqM2g/+UFLVTMFKOpWVHdwSvvMBDjm70J1
         oLpEPKbeWkW3Xn4+iXark1BFcDJxtHzqtAflb3wa9ksqRR2RXSIUD9RQrHM2iCdf+cC8
         dJ2A==
X-Gm-Message-State: AOAM5305gA+RxTrFMagANUCBdjBNDlmI2I6YzWu2eIpNV6eiqgYALU1R
        jednqmC8iGNdaIvRZlNQO27lqC0eRON0kDHxZqtpxw==
X-Google-Smtp-Source: ABdhPJzm1M1y5goVEFr2WvSjSx5rvNaTb4WJaKuthySOx6HGOvwiydmh/QveKlaJJqFM/fPhcQ0S1xdP1UX3ndrbCe4=
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr2089772wrp.44.1633159333231;
 Sat, 02 Oct 2021 00:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br> <20210926223322.848641-5-isabellabdoamaral@usp.br>
In-Reply-To: <20210926223322.848641-5-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 15:22:02 +0800
Message-ID: <CABVgOSmu-wLhqHNKwNG4Tvv=N+P+wzF1tp0g4Af3Yv0bTcjvwg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] lib/Kconfig.debug: properly split hash test kernel entries
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, ferreiraenzoa@gmail.com,
        augusto.duraes33@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
>
> Split TEST_HASH so that each entry only has one file.
>
> Note that there's no stringhash test file, but actually
> <linux/stringhash.h> tests are performed in lib/test_hash.c.
>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---

Looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/Kconfig.debug | 14 +++++++++++---
>  lib/Makefile      |  3 ++-
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2a9b6dcdac4f..eb6c4daf5fcb 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2207,9 +2207,17 @@ config TEST_RHASHTABLE
>  config TEST_HASH
>         tristate "Perform selftest on hash functions"
>         help
> -         Enable this option to test the kernel's integer (<linux/hash.h>),
> -         string (<linux/stringhash.h>), and siphash (<linux/siphash.h>)
> -         hash functions on boot (or module load).
> +         Enable this option to test the kernel's integer (<linux/hash.h>), and
> +         string (<linux/stringhash.h>) hash functions on boot (or module load).
> +
> +         This is intended to help people writing architecture-specific
> +         optimized versions.  If unsure, say N.
> +
> +config TEST_SIPHASH
> +       tristate "Perform selftest on siphash functions"
> +       help
> +         Enable this option to test the kernel's siphash (<linux/siphash.h>) hash
> +         functions on boot (or module load).
>
>           This is intended to help people writing architecture-specific
>           optimized versions.  If unsure, say N.
> diff --git a/lib/Makefile b/lib/Makefile
> index 5efd1b435a37..c2e81d0eb31c 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -61,7 +61,8 @@ obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
>  obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
>  CFLAGS_test_bitops.o += -Werror
>  obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
> -obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
> +obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
> +obj-$(CONFIG_TEST_HASH) += test_hash.o
>  obj-$(CONFIG_TEST_IDA) += test_ida.o
>  obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
>  CFLAGS_test_kasan.o += -fno-builtin
> --
> 2.33.0
>
