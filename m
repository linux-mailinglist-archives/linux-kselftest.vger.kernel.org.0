Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266ADC9AB7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 11:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfJCJ1i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Oct 2019 05:27:38 -0400
Received: from condef-01.nifty.com ([202.248.20.66]:27790 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfJCJ1i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Oct 2019 05:27:38 -0400
X-Greylist: delayed 687 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Oct 2019 05:27:35 EDT
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-01.nifty.com with ESMTP id x9399i2r013973
        for <linux-kselftest@vger.kernel.org>; Thu, 3 Oct 2019 18:09:44 +0900
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x9399S8L014758;
        Thu, 3 Oct 2019 18:09:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x9399S8L014758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570093769;
        bh=0n5cPsF5haYRPkr2VgOQDasD7KbvcEkObY/W1AYYxoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GuSlTaVFdcOm8THyLoUFPJnfg+ogQL59HMlirt/bBWqEw/zNFDYvaQ2ZIEdY64AjF
         /aDBMeHvuIt/w59QaX2bvM24qqRDs9k86wVvVZ7Aaw9IKAj8QvgzOOjP9Sily3oEfQ
         7Wuf2/+c/JOIugBUHL+NepI7WG/G9aVlpmSdGsxuo6PorzwoGOLZx6DznQaEDBqkN6
         0qS5Y1Ktcmt2vu3B1T99VBKlarbs/g2HExixnBjqDYOsHFcEaDUG4euQ15bzvnnijW
         kJo3hRHSUj6nZfTK1d1vwyeSly2P9aQSZGo5ATW6HfP5p8jVbhG55q3F2eK7w8mCyM
         gLTkT0WeCNsGg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id l13so644170uap.8;
        Thu, 03 Oct 2019 02:09:29 -0700 (PDT)
X-Gm-Message-State: APjAAAX1pNLQ6SH4g+LeDIjXrOTAGIjxShMFPZ18sSRyqxPeaL6hFTiK
        doZt8eHVL2OlMwdgWb2BA/dTEU6Z0rl6vDeo7ig=
X-Google-Smtp-Source: APXvYqzaRxwD3DovY3SLF0jFPnex4EWJSi1FdvFEvcljAurmm9CUYLadWL/Tqls0CAy/5bUcYvaJJeSOLZCyUN3Tq/0=
X-Received: by 2002:a9f:21f6:: with SMTP id 109mr2062792uac.109.1570093768250;
 Thu, 03 Oct 2019 02:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com> <20190922112555.GB122003@gmail.com>
In-Reply-To: <20190922112555.GB122003@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Oct 2019 18:08:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASr7e7Hc2_CBanfN06-WP3mFn9qByuTbyzZ+HTrEwUXkA@mail.gmail.com>
Message-ID: <CAK7LNASr7e7Hc2_CBanfN06-WP3mFn9qByuTbyzZ+HTrEwUXkA@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 22, 2019 at 8:26 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Sorry about that. I am surprised that none of the other reviewers
> > > brought this up.
> >
> > I think I'm "special".
> >
> > There was some other similar change a few years ago, which I
> > absolutely hated because of how it broke autocomplete for me. Very few
> > other people seemed to react to it.
>
> FWIW, I am obsessively sensitive to autocomplete and overall source code
> file hieararchy and nomenclature details as well, so it's not just you.
>
> Beyond the muscle memory aspect, nonsensical naming and inanely flat file
> hierarchies annoy kernel developers and makes it harder for newbies to
> understand the kernel source as well.
>
> The less clutter, the more organization, the better - and there's very
> few valid technical reasons to add any new files or directories to the
> top level directory - we should probably *remove* quite a few.
>
> For example 'firmware/' was recently moved to drivers/firmware/, and in a
> similar fashion about a third of the remaining 22 directories should
> probably be moved too:
>
>   drwxr-xr-x    arch
>   drwxr-xr-x    block
>   drwxr-xr-x    certs           # move to build/certs/ dir
>   drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/
>   drwxr-xr-x    Documentation
>   drwxr-xr-x    drivers
>   drwxr-xr-x    fs
>   drwxr-xr-x    include
>   drwxr-xr-x    init
>   drwxr-xr-x    ipc             # move to kernel/ipc/
>   drwxr-xr-x    kernel
>   drwxr-xr-x    lib
>   drwxr-xr-x    LICENSES
>   drwxr-xr-x    mm
>   drwxr-xr-x    net
>   drwxr-xr-x    samples         # move to Documentation/samples/
>   drwxr-xr-x    scripts         # move to build/scripts/
>   drwxr-xr-x    security
>   drwxr-xr-x    sound           # move to drivers/sound/
>   drwxr-xr-x    tools
>   drwxr-xr-x    usr             # move to build/usr/
>   drwxr-xr-x    virt            # move to the already existing drivers/virt/
>
>   -rw-r--r--    COPYING
>   -rw-r--r--    CREDITS
>   -rw-r--r--    Kbuild
>   -rw-r--r--    Kconfig
>   -rw-r--r--    MAINTAINERS
>   -rw-r--r--    Makefile
>   -rw-r--r--    README
>
> There's a few borderline ones:
>
>  - 'block' could in principle move to drivers/block/core/ but it's fine
>    at the top level too I think.
>
>  - 'init' could in principle be moved to kernel/init/ - but it's not
>    wrong at the top level either.
>
> The remaining top level hierarchy would look pretty sweet and short:
>
>   drwxr-xr-x    arch
>   drwxr-xr-x    block
>   drwxr-xr-x    build             # new

I am opposed to the "build".

The build tools will go too deep, like build/scripts/kconfig ?

I often use checkpatch.pl, get_maintainer.pl etc.

Do I have to type build/scripts/checkpatch.pl ?






>   drwxr-xr-x    Documentation
>   drwxr-xr-x    drivers
>   drwxr-xr-x    fs
>   drwxr-xr-x    include
>   drwxr-xr-x    init
>   drwxr-xr-x    kernel
>   drwxr-xr-x    lib
>   drwxr-xr-x    LICENSES
>   drwxr-xr-x    mm
>   drwxr-xr-x    net
>   drwxr-xr-x    security
>   drwxr-xr-x    tools
>
>   -rw-r--r--    COPYING
>   -rw-r--r--    CREDITS
>   -rw-r--r--    Kbuild
>   -rw-r--r--    Kconfig
>   -rw-r--r--    MAINTAINERS
>   -rw-r--r--    Makefile
>   -rw-r--r--    README
>
> I'm volunteering to do this (in a scripted, repeatable, reviewable,
> tweakable and "easy to execute in a quiet moment" fashion), although
> I also expect you to balk at the churn. :-)
>
> Thanks,
>
>         Ingo



-- 
Best Regards
Masahiro Yamada
