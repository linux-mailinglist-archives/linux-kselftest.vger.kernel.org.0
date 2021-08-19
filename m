Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B992E3F0F80
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 02:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhHSAfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 20:35:14 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:20081 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhHSAfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 20:35:13 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 20:35:13 EDT
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-09.nifty.com with ESMTP id 17J0PJUK024005;
        Thu, 19 Aug 2021 09:25:19 +0900
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 17J0P0f1032108;
        Thu, 19 Aug 2021 09:25:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 17J0P0f1032108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629332701;
        bh=PF53kQPV3ZMQ1IqBpnzqJejKPfOrn59+hm0ztTTG2rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N9WJQSvGetK7IX3nXyVZDUEVRRQIaWMxCKvnH8S4AW6s6ALnTS7u000Cz4XTD2EOh
         PyRfTomhxspXVNFhUVM/TTXMADH5Std/HkRMtLue3L6vsn57d9dprw7KnVDWurbxOe
         T+UoNoVpxIN2I6S+WGHhDOgJdVigAYqURBX9l6/P5H2qe8m2c4kIzwWUkr4cot4xJz
         8MwmcTksICp2B+ef+8bwuRM3ztuoOGD/jMlpVpGhbcFfR3cISKOhluzcKhPOk6XpDx
         w+Dn0kxYImvWlaTUikoDWpwvLqXMyvXSmCbzYhaBTR1ZmJ3+9t5oL2Q8LfvyQM50cj
         gOIDMaADXI56A==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id m26so3854800pff.3;
        Wed, 18 Aug 2021 17:25:01 -0700 (PDT)
X-Gm-Message-State: AOAM5322Ar5nIgMMzOjJB6txHAsuIlR9v0zcaMZQIkCVjFeQ1qH0bCTr
        IZLEWPWQC2wjXqzIenYToIzYdd4pU2odgN/J75Y=
X-Google-Smtp-Source: ABdhPJyI48U6UoIuNg/t0/Wmc0kyshBQu8l/PGLPbEpDRALt1hRHHdvzrQwxGK0TmPPg7RKq3ivTo+X4kEATHr7Yk/w=
X-Received: by 2002:a63:dd51:: with SMTP id g17mr11336425pgj.47.1629332700384;
 Wed, 18 Aug 2021 17:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210818154646.925351-1-efremov@linux.com> <20210818154646.925351-3-efremov@linux.com>
In-Reply-To: <20210818154646.925351-3-efremov@linux.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 19 Aug 2021 09:24:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASTa+_d17wF6NW6GHC7Y+_RrXYZuo0MzzbsNnaRn8KJuQ@mail.gmail.com>
Message-ID: <CAK7LNASTa+_d17wF6NW6GHC7Y+_RrXYZuo0MzzbsNnaRn8KJuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] gen_initramfs.sh: use absolute path for gen_init_cpio
To:     Denis Efremov <efremov@linux.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 19, 2021 at 12:47 AM Denis Efremov <efremov@linux.com> wrote:
>
> Use absolute path to call gen_init_cpio. This allows one
> to use gen_initramfs.sh from any directory.

I do not mind this, but $(dirname "$0")
is not necessarily an absolute path, is it?


I added test code:

   echo dirname is $(dirname $0)

in this script, and I saw

   dirname is usr




>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  usr/gen_initramfs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
> index 63476bb70b41..2e4a86181c79 100755
> --- a/usr/gen_initramfs.sh
> +++ b/usr/gen_initramfs.sh
> @@ -244,4 +244,4 @@ if test -n "$KBUILD_BUILD_TIMESTAMP"; then
>                 timestamp="-t $timestamp"
>         fi
>  fi
> -usr/gen_init_cpio $timestamp $cpio_list > $output
> +"$(dirname "$0")"/gen_init_cpio $timestamp $cpio_list > $output
> --
> 2.31.1
>


--
Best Regards
Masahiro Yamada
