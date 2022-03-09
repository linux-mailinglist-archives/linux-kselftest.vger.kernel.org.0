Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE84D2C25
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 10:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiCIJfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 04:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiCIJfy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 04:35:54 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557356AA7D;
        Wed,  9 Mar 2022 01:34:54 -0800 (PST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2299YNeB029111;
        Wed, 9 Mar 2022 18:34:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2299YNeB029111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646818464;
        bh=ecQr6qIvWdbKOOftT0P5bw/2I4nX2mhfpun9h1TgUeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T3m02rMsnkG8ueOBQKJ+9EZUCgrBL0yxlqORHIdYbLJmwC+kyR+foPAE2CDaC9fTH
         Lg33gby+NPDwlEIRnu63aMCybVu2qSFerzNxmInEjbacq05fo39qwIVZjKUsGkVlKT
         +FUwzBplWXwfFKYGV2qr8r97p0IdzPUf2SPv6a9f02uNS0prdIIC9J85QugH99UKcl
         V1hbPHDYwzlaZpsfmnAWEstKvWRGVnv2l6Cx6xSXc+bjt2YH1v0BGwQsLVd6L3Gj4+
         /rBrYlfcxcr8sNWuVV2u1XsX24PdeAa9+Q3ZWgSFsusRfqUpl+tx9HZiEnpfNayTLE
         QMOI2sSbr/1/Q==
X-Nifty-SrcIP: [209.85.214.172]
Received: by mail-pl1-f172.google.com with SMTP id p17so1443074plo.9;
        Wed, 09 Mar 2022 01:34:23 -0800 (PST)
X-Gm-Message-State: AOAM533yO7hA7wHcDBhTBG0MVOfueSiqLdRD5wbdzE4EWRV3mYPYDova
        Cu2DS3fuIYIhz3HdP6stg9MVpxNhQVu65idsalw=
X-Google-Smtp-Source: ABdhPJz2CczPHj/qvuG++hUUJmOu8k6TahMuAauT21WWVlzprNBuAo3FW0eZmY/eannNxGvP75auJcjlLg4O/GXMSf4=
X-Received: by 2002:a17:90a:1108:b0:1be:e1bd:e2f0 with SMTP id
 d8-20020a17090a110800b001bee1bde2f0mr9463553pja.144.1646818462899; Wed, 09
 Mar 2022 01:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20220304170813.1689186-1-nathan@kernel.org> <CAKwvOd=Q-7vPaRPj1wQagFsY3txcAKzrqU_D2UAX3h4ym91uUA@mail.gmail.com>
 <Yid6eS7YV4Oxj+hx@dev-arch.thelio-3990X>
In-Reply-To: <Yid6eS7YV4Oxj+hx@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 9 Mar 2022 18:33:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThknb0=-XhfB6zspke-sNHMEmTbGy8WVeg20ntT72wqA@mail.gmail.com>
Message-ID: <CAK7LNAThknb0=-XhfB6zspke-sNHMEmTbGy8WVeg20ntT72wqA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 9, 2022 at 12:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Mar 07, 2022 at 11:08:29AM -0800, Nick Desaulniers wrote:
> > On Fri, Mar 4, 2022 at 9:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> > > index d32616891dcf..68b74416ec48 100644
> > > --- a/Documentation/kbuild/llvm.rst
> > > +++ b/Documentation/kbuild/llvm.rst
> > > @@ -49,17 +49,36 @@ example: ::
> > >  LLVM Utilities
> > >  --------------
> > >
> > > -LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
> > > -to enable them. ::
> > > -
> > > -       make LLVM=1
> > > -
> > > -They can be enabled individually. The full list of the parameters: ::
> > > +LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
> > > +The full list of supported make variables: ::
> > >
> > >         make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
> > >           OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
> > >           HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
> > >
> > > +To simplify the above command, Kbuild supports the ``LLVM`` variable: ::
> > > +
> > > +       make LLVM=1
> > > +
> > > +If your LLVM tools are not available in your PATH, you can supply their
> > > +location using the LLVM variable with a trailing slash: ::
> > > +
> > > +       make LLVM=/path/to/llvm/
> > > +
> > > +which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
> >
> > I don't think we should do this; `PATH=/path/to/llvm/ make LLVM=1`
> > works and (my interpretation of what) Masahiro said "if anyone asks
> > for this, here's how we could do that."  I don't think I've seen an
> > explicit ask for that. I'd rather LLVM= have 2 behaviors than 3, but I
> > won't hold this patch up over that.  Either way:
>
> Right, there has not been an explicit ask for the prefix support yet,
> although I know I personally would use it, but I think that it is worth
> doing now instead of later for a few reasons:
>
> 1. It makes path goofs easier to spot. If you do
>
>      $ PATH=/path/to/llvm:$PATH make LLVM=1 ...
>
>    with a path to LLVM that does not exist (maybe you are bisecting an
>    issue and using a temporary build of LLVM and you forgot the path it
>    was in), you fall back to the LLVM tools that are in other places in
>    your PATH, which is not what the developer intended. I know that I
>    have messed up bisects that way. If you did
>
>      $ make LLVM=/path/to/llvm/
>
>    with a path that does not exist, there will be an error much earlier:
>
>      $ make LLVM=/this/path/does/not/exist/ defconfig
>      /bin/sh: line 1: /this/path/does/not/exist/clang: No such file or directory
>
> 2. It does not take that much more code or documentation to support. It
>    is the same amount of code as the suffix and the documentation is
>    roughly the same amount of lines as well.
>
> 3. If we wait to implement the path-based use of $(LLVM), we have three
>    "sequence" points: the initial support of $(LLVM), the suffix
>    support, and the prefix support. As we are constantly working with
>    various trees, it would make it harder to know what to use when. If
>    we just do it in the same patch, we know 5.18+ can use both of these
>    methods.
>
> However, at the end of the day, we are a team and if you feel like we
> should only have suffix support, I am more than happy to push a v3 that
> does just that and we can revist prefix support in the future. Just let
> me know!


I do not have a strong opinion about this.
(I just mentioned the LLVM=/path/to/llvm/ form because I guessed
somebody would request this sooner or later.)


If you want me to pick up this version, I will apply it with fixing up
a nit pointed out by Kees   (": ::" -> "::")

If you want to send v3, that is fine with me as well.

Please let me know your thoughts.








>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > > +
> > > +If your LLVM tools have a version suffix and you want to test with that
> > > +explicit version rather than the unsuffixed executables like ``LLVM=1``, you
> > > +can pass the suffix using the ``LLVM`` variable: ::
> > > +
> > > +       make LLVM=-14
> > > +
> > > +which will use ``clang-14``, ``ld.lld-14``, etc.
> > > +
> > > +``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
> > > +``LLVM=1``.
> >
> > Hmm... I can see someone's build wrappers setting LLVM=1, then them
> > being surprised that appending LLVM=0 doesn't disable LLVM=1 as they
> > might expect.  But Masahiro says let's fix this later which is fine.
>
> Sure, I guess that is a reasonable case to support. I'll see if I can
> come up with something that makes sense after this change lands.
>
> Cheers,
> Nathan



-- 
Best Regards
Masahiro Yamada
