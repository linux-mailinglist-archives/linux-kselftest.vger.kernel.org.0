Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158CC199B59
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgCaQXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 12:23:18 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:47299 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQXS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 12:23:18 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 12:23:16 EDT
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-06.nifty.com with ESMTP id 02VGCXno004557
        for <linux-kselftest@vger.kernel.org>; Wed, 1 Apr 2020 01:12:33 +0900
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 02VGCHpj023073;
        Wed, 1 Apr 2020 01:12:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 02VGCHpj023073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585671138;
        bh=OjjE9E+FBmI6rjfGxW9oLfbJtU1jLW6j7wjg8xrOEgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J2zXtLVECqLeUArifH7kDCzdqIULnHZ0pFVKLs2Z5Szpg5xVVEULqwSz1OIKWAVyQ
         1vjzqg0BQTufXgYn8ReL6b9+r/36y25yEjpp7LVNDAwIumz9zaXEmRc8k5Awi8N8By
         1mjsphq45isrhCBkun4q8gG9cwdmy/IxFT46SZO4H8vt0xcH0ogm79+BkwOFgUwH7/
         mHhKCSDy/sreq961xOcEdfNjaiR3wNSJ0+x1sUySiSamrgQkzh9X2mIaV1hpRXt6s5
         maKDECDXjpOA6zDn5jQscQiu9jVkWmsNdctmlCosABBeEs5lTtlSHgCx9qgHVGXeJx
         NP/j3VKgpk6qg==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id v24so7906567uak.0;
        Tue, 31 Mar 2020 09:12:17 -0700 (PDT)
X-Gm-Message-State: AGi0PuYvevsDFd4QlHuzTeQtP+9EiHQSXf7JWxXUs4+NDvGPGg0bwEnN
        k4qlSY3ZGTH2Z3HlZyd1MTc7nX9LZW7FahnsrIw=
X-Google-Smtp-Source: APiQypIl3Ae1UY77vkChuVqugoDHzbGIGnbGHV1y+1vSWEkKpgKXcTiK55DowgXg22KgHqQv6o5shqXmm2G4lcTRjLk=
X-Received: by 2002:ab0:28d8:: with SMTP id g24mr12123717uaq.121.1585671136346;
 Tue, 31 Mar 2020 09:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200330180711.14393-1-skhan@linuxfoundation.org>
In-Reply-To: <20200330180711.14393-1-skhan@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Apr 2020 01:11:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyVVNo8Ck4=s_bkwfxuFXj7MUFr2E_f-oOZEkjgm5Bmg@mail.gmail.com>
Message-ID: <CAK7LNARyVVNo8Ck4=s_bkwfxuFXj7MUFr2E_f-oOZEkjgm5Bmg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Update kselftest help information
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 31, 2020 at 3:07 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Update kselftest help information.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Makefile | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e56bf7ef182d..5e5c770423c7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1470,12 +1470,15 @@ help:
>         @echo  '  nsdeps          - Generate missing symbol namespace dependencies'
>         @echo  ''
>         @echo  'Kernel selftest:'
> -       @echo  '  kselftest       - Build and run kernel selftest (run as root)'
> -       @echo  '                    Build, install, and boot kernel before'
> -       @echo  '                    running kselftest on it'
> -       @echo  '  kselftest-clean - Remove all generated kselftest files'
> -       @echo  '  kselftest-merge - Merge all the config dependencies of kselftest to existing'
> -       @echo  '                    .config.'
> +       @echo  '  kselftest         - Build and run kernel selftest'
> +       @echo  '                      Build, install, and boot kernel before'
> +       @echo  '                      running kselftest on it'
> +       @echo  '                      Run as root for full coverage'
> +       @echo  '  kselftest-all     - Build kernel selftest'
> +       @echo  '  kselftest-install - Build and install kernel selftest'
> +       @echo  '  kselftest-clean   - Remove all generated kselftest files'
> +       @echo  '  kselftest-merge   - Merge all the config dependencies of'
> +       @echo  '                      kselftest to existing .config.'
>         @echo  ''
>         @$(if $(dtstree), \
>                 echo 'Devicetree:'; \
> --
> 2.20.1
>


Applied to linux-kbuild. Thanks.

But, if we have more entries in the future,
we might want to consider to move these
to tools/testing/selftests/Makefile.



-- 
Best Regards
Masahiro Yamada
