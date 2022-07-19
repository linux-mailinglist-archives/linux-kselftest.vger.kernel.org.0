Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE5357A29E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiGSPHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiGSPHH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 11:07:07 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C450055;
        Tue, 19 Jul 2022 08:07:05 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 26JF6laN011624;
        Wed, 20 Jul 2022 00:06:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 26JF6laN011624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658243208;
        bh=47Thq0tgoItC66wL0kCGaGxa+Gw0qIdlUWgCm8wFWDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2jSEeW9OQvykyuUbv4OfGKJFsNdkZKz5+kgXu1FfVdhvwlagUXrGu+YA0GYVIgkS2
         /HFjy3KXMqZImJ2hK6SWvEslUGdxrmDgwS8vjyC7HtCLq4Bx4vQh1yXKcKDLxZgzIN
         ZmoZVomebxCZwToX9mZDzO+h9sBO6OSr3ZoMY6J0kOxjppWHfdo3M2vVYn+XKeSvP7
         nQyhz85GiSgI/k0Ev5H2Ot/1ylyIjn+StzeENKuigH0DVkykLNgYjBU6KENML51OBy
         8ApSQtjA0PWpxkwa3kNa1h+S5Lu3XX3zTmU9R84hnE4iZayGfLWuIlv70qLd5Zmq3s
         w03wn5qmlfBSQ==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id bu1so22024199wrb.9;
        Tue, 19 Jul 2022 08:06:48 -0700 (PDT)
X-Gm-Message-State: AJIora9TiICojDdCtnNN5DpMs1afzrznJLXJajQPQfguo9f66L4ypfqR
        EfrFXqsSuhsQiojhX0qeQ+ygzqNUWI+YmVfcVPM=
X-Google-Smtp-Source: AGRyM1vjG/h+aEXj/cQ+xfWWMuq+d9ijKdhDJytxZETjtAPWYNlpmIypTlQXi0YCwTUeNbUteC+Extr7GsGkEtVrJUQ=
X-Received: by 2002:a5d:4e08:0:b0:21d:a689:7dd1 with SMTP id
 p8-20020a5d4e08000000b0021da6897dd1mr27148089wrt.477.1658243206520; Tue, 19
 Jul 2022 08:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <a7af58feaa6ae6d3b0c8c55972a470cec62341e5.1657693952.git.guillaume.tucker@collabora.com>
 <f35a71d6-bd96-7aa9-c143-39ae88bc85d5@linuxfoundation.org> <8fc9d169-78ff-0fe4-67c0-784097861f12@collabora.com>
In-Reply-To: <8fc9d169-78ff-0fe4-67c0-784097861f12@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 20 Jul 2022 00:06:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4iMBwu4bOmmOrMudNH49ruz-7AK_H3-ceTixd=G+brQ@mail.gmail.com>
Message-ID: <CAK7LNAQ4iMBwu4bOmmOrMudNH49ruz-7AK_H3-ceTixd=G+brQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: replace headers_install with headers for kselftest
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Tim Bird <Tim.Bird@sony.com>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 9:37 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 14/07/2022 22:45, Shuah Khan wrote:
> > On 7/13/22 12:33 AM, Guillaume Tucker wrote:
> >> Replace headers_install with headers as kselftest uses the header
> >> files from within the kernel tree rather than from a system-wide
> >> installation.
> >>
> >> We can still run this directly:
> >>
> >>    $ make O=build kselftest-all
> >>
> >> and when building from the selftests directory:
> >>
> >>    $ make O=build headers
> >>    $ make O=build -C tools/testing/selftests all
> >>
> >> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> >> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> >> ---
> >>   Makefile | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index fb2f3bb53a6b..5c934d16664c 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1347,10 +1347,10 @@ tools/%: FORCE
> >>   # Kernel selftest
> >>     PHONY += kselftest
> >> -kselftest: headers_install
> >> +kselftest: headers
> >>       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> >>   -kselftest-%: headers_install FORCE
> >> +kselftest-%: headers FORCE
> >>       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> >>     PHONY += kselftest-merge
> >>
> >
> > Thank you for taking care of this. This will go through kbuild?
>
> You're welcome.
>
> Masahiro-san,
>
> A you OK with applying this in the kbuild tree ahead of the
> upcoming merge window?


No.

This is a fix-up patch on top of the previous one [1],
which  was applied to the kselftest tree.

This cannot apply to the kbuild tree.

[1]: https://lore.kernel.org/linux-kbuild/168ede35-12e0-c535-9d94-23b65a1beb28@collabora.com/T/#mb8ec7004f7c9b89fbb50c19022760e19701af7f6






> Best wishes,
> Guillaume
>
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> >
> > thanks,
> > -- Shuah
> >



-- 
Best Regards
Masahiro Yamada
