Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA274DD423
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 06:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiCRFTc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 01:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiCRFTc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 01:19:32 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190CB1903CF;
        Thu, 17 Mar 2022 22:18:13 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 22I5HhMI003378;
        Fri, 18 Mar 2022 14:17:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 22I5HhMI003378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647580664;
        bh=YcnKTgYW/nH97duZQDWdMClL6EBoKEP/ujVYgGk4kBk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jNNysrZl6TapPon0a/Bb3aIBWau5bhANk5Tmnz+wPJ7XmCGVD/PyEK6yCGmH2Wdvs
         hFrJ+m8juG2+L7UtIe7NuybdYXM39nkmmOtqyVR6asarVH+KFexwL62aB293QBbc1i
         Kn2m91Jrs/RjC5icdFi2iYOz4SvvWG19pxfsvBiQOak4KJMRSLZYQqVyP7SjmqKtr7
         jGiLIMsVGYQrc6bbFPzxiPc9hjoVWp6dnQd7WcPfhPdWaEw/+6UnkqoPC55Zqx9nMe
         bSB/rFWigrlNR+kcjbYcSI55z2opS9ipYAE1c1dKZFFpDYHtUIPaiOkhBb5oV5k4R9
         EaBqOwy/eA40g==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id p17so6177848plo.9;
        Thu, 17 Mar 2022 22:17:43 -0700 (PDT)
X-Gm-Message-State: AOAM531TyCL996l48JrMOlf8cf4Fl5EK4sE9znuz4kPOa5ZAVXSoBVEb
        anfGA2jQ1zgp0fty8n21b9EzAdMSOcKSCSWFa1Y=
X-Google-Smtp-Source: ABdhPJxLZbFAH9OT/iNJbXmWsB2aranEIGxuC8FF2oQTeJKBU1pgEwYGe18Vkiv5IFm4wNugBTteiAPHZDjlEzdi99I=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr8462129plp.162.1647580662904; Thu, 17
 Mar 2022 22:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220304170813.1689186-1-nathan@kernel.org> <CAKwvOd=Q-7vPaRPj1wQagFsY3txcAKzrqU_D2UAX3h4ym91uUA@mail.gmail.com>
 <Yid6eS7YV4Oxj+hx@dev-arch.thelio-3990X> <CAK7LNAThknb0=-XhfB6zspke-sNHMEmTbGy8WVeg20ntT72wqA@mail.gmail.com>
 <Yio3K4bgdyFEBy7J@dev-arch.thelio-3990X>
In-Reply-To: <Yio3K4bgdyFEBy7J@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 18 Mar 2022 14:16:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8u++6Z9WWtuZ_1QNZ66wiqrRTBzpsiOra7nToJ55Suw@mail.gmail.com>
Message-ID: <CAK7LNAS8u++6Z9WWtuZ_1QNZ66wiqrRTBzpsiOra7nToJ55Suw@mail.gmail.com>
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

On Fri, Mar 11, 2022 at 2:36 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Mar 09, 2022 at 06:33:40PM +0900, Masahiro Yamada wrote:
> > On Wed, Mar 9, 2022 at 12:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Mon, Mar 07, 2022 at 11:08:29AM -0800, Nick Desaulniers wrote:
> > > > On Fri, Mar 4, 2022 at 9:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> > > > > index d32616891dcf..68b74416ec48 100644
> > > > > --- a/Documentation/kbuild/llvm.rst
> > > > > +++ b/Documentation/kbuild/llvm.rst
> > > > > @@ -49,17 +49,36 @@ example: ::
> > > > >  LLVM Utilities
> > > > >  --------------
> > > > >
> > > > > -LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
> > > > > -to enable them. ::
> > > > > -
> > > > > -       make LLVM=1
> > > > > -
> > > > > -They can be enabled individually. The full list of the parameters: ::
> > > > > +LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
> > > > > +The full list of supported make variables: ::
> > > > >
> > > > >         make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
> > > > >           OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
> > > > >           HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
> > > > >
> > > > > +To simplify the above command, Kbuild supports the ``LLVM`` variable: ::
> > > > > +
> > > > > +       make LLVM=1
> > > > > +
> > > > > +If your LLVM tools are not available in your PATH, you can supply their
> > > > > +location using the LLVM variable with a trailing slash: ::
> > > > > +
> > > > > +       make LLVM=/path/to/llvm/
> > > > > +
> > > > > +which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
> > > >
> > > > I don't think we should do this; `PATH=/path/to/llvm/ make LLVM=1`
> > > > works and (my interpretation of what) Masahiro said "if anyone asks
> > > > for this, here's how we could do that."  I don't think I've seen an
> > > > explicit ask for that. I'd rather LLVM= have 2 behaviors than 3, but I
> > > > won't hold this patch up over that.  Either way:
> > >
> > > Right, there has not been an explicit ask for the prefix support yet,
> > > although I know I personally would use it, but I think that it is worth
> > > doing now instead of later for a few reasons:
> > >
> > > 1. It makes path goofs easier to spot. If you do
> > >
> > >      $ PATH=/path/to/llvm:$PATH make LLVM=1 ...
> > >
> > >    with a path to LLVM that does not exist (maybe you are bisecting an
> > >    issue and using a temporary build of LLVM and you forgot the path it
> > >    was in), you fall back to the LLVM tools that are in other places in
> > >    your PATH, which is not what the developer intended. I know that I
> > >    have messed up bisects that way. If you did
> > >
> > >      $ make LLVM=/path/to/llvm/
> > >
> > >    with a path that does not exist, there will be an error much earlier:
> > >
> > >      $ make LLVM=/this/path/does/not/exist/ defconfig
> > >      /bin/sh: line 1: /this/path/does/not/exist/clang: No such file or directory
> > >
> > > 2. It does not take that much more code or documentation to support. It
> > >    is the same amount of code as the suffix and the documentation is
> > >    roughly the same amount of lines as well.
> > >
> > > 3. If we wait to implement the path-based use of $(LLVM), we have three
> > >    "sequence" points: the initial support of $(LLVM), the suffix
> > >    support, and the prefix support. As we are constantly working with
> > >    various trees, it would make it harder to know what to use when. If
> > >    we just do it in the same patch, we know 5.18+ can use both of these
> > >    methods.
> > >
> > > However, at the end of the day, we are a team and if you feel like we
> > > should only have suffix support, I am more than happy to push a v3 that
> > > does just that and we can revist prefix support in the future. Just let
> > > me know!
> >
> >
> > I do not have a strong opinion about this.
> > (I just mentioned the LLVM=/path/to/llvm/ form because I guessed
> > somebody would request this sooner or later.)
> >
> >
> > If you want me to pick up this version, I will apply it with fixing up
> > a nit pointed out by Kees   (": ::" -> "::")
> >
> > If you want to send v3, that is fine with me as well.
> >
> > Please let me know your thoughts.
>
> Given Nick's response, please pick up this revision with Kees' nit.
> Thank you!


I fixed up ": ::" to "::",
and applied to linux-kbuild.  Thanks.






-- 
Best Regards
Masahiro Yamada
