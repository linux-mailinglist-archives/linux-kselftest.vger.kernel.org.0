Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA38C5CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 04:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHNCDp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 22:03:45 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:44716 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHNCDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 22:03:45 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x7E23L5g029484;
        Wed, 14 Aug 2019 11:03:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7E23L5g029484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565748202;
        bh=gg/aXfWoj1dr/iQJNgz6p/0wrctSN5GJ08iIhhlqIHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LYR09X6NkgDT7yZadd1KwV6UdmZQdkHcmevmz1kYVgM7IRpW8m2ty4KkMUt9OiLTP
         LDCwbVSXHQOidRWyWa/4obYsDJnX+u/v6b/uZDjHW/Av0Xwke1IlCJbO6RZfBpS7J0
         sLpDUnGdv9S3IGvrM5kepqaJs9eNULIzfuZmiBm9K/OmYcRF1rEo6I8izp7orGyFsl
         +QaImjQUlAzgxCiVrwzEFUPj4A5la3t91WYCKQnyJ6Z+r4kE5J8KvVbM0QSSOHILXb
         QhjKkd/ZShxTCZE8NFPDNz8nDU7ieFBSzpEz1uVf4iyp8yKDT4CSyAQZ5ZRDVxIbES
         IQHLtGL6cF/Gw==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id u3so73515988vsh.6;
        Tue, 13 Aug 2019 19:03:22 -0700 (PDT)
X-Gm-Message-State: APjAAAXrh117WL2CovHMwdRm5km7NRTCeWBSnrJuFabGIY8xh0cq0WUk
        bg4GcgfpDJyojVXNkrQGwJS0aW64LaAGJzmfvPA=
X-Google-Smtp-Source: APXvYqzqNBqm+hwNLTOEci/lspPuPMkY9zOEYB7EyM/q2ufzPas85GtjdbUpizxOvvLyJqnSy4EsbPJ3kQPFBvoIe60=
X-Received: by 2002:a67:b916:: with SMTP id q22mr242654vsn.54.1565748201144;
 Tue, 13 Aug 2019 19:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <be2c361eac49ded2848b2a555b75e30cc3c24e71.1565676440.git-series.knut.omang@oracle.com>
 <CAK7LNASX4jPRxRxD+JafAfKqjck=x27HuHZgPV1VFfW8MzcwZA@mail.gmail.com> <14b99d26a4cff1c813c92818dc1234007fa06fc9.camel@oracle.com>
In-Reply-To: <14b99d26a4cff1c813c92818dc1234007fa06fc9.camel@oracle.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Aug 2019 11:02:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgfd6KPRQ=hcqKkpZ6EVhFmbBjCXa30bvEqscu_5dwbQ@mail.gmail.com>
Message-ID: <CAK7LNASgfd6KPRQ=hcqKkpZ6EVhFmbBjCXa30bvEqscu_5dwbQ@mail.gmail.com>
Subject: Re: [RFC 01/19] kbuild: Fixes to rules for host-cshlib and host-cxxshlib
To:     Knut Omang <knut.omang@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Knut,

On Wed, Aug 14, 2019 at 1:19 AM Knut Omang <knut.omang@oracle.com> wrote:
>
> On Tue, 2019-08-13 at 23:01 +0900, Masahiro Yamada wrote:
> > On Tue, Aug 13, 2019 at 3:13 PM Knut Omang <knut.omang@oracle.com> wrote:
> > >
> > > C++ libraries interfacing to C APIs might sometimes need some glue
> > > logic more easily written in C.
> > > Allow a C++ library to also contain 0 or more C objects.
> > >
> > > Also fix rules for both C and C++ shared libraries:
> > > - C++ shared libraries depended on .c instead of .cc files
> > > - Rules were referenced as -objs instead of the intended
> > >   -cobjs and -cxxobjs following the pattern from hostprogs*.
> > >
> > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> >
> >
> > How is this patch related to the rest of this series?
>
> This is just my (likely naive) way I to get what I had working
> using autotools in the Github version of KTF) translated into something
> comparable using kbuild only. We need to build a shared library consisting
> of a few C++ files and a very simple C file, and a couple of simple binaries,
> and the rule in there does seem to take .c files and subject them to the
> C++ compiler, which makes this difficult to achieve?


Looking at the diff stat of the cover-letter,
the rest of this patch series is touching only
Documentation/ and tools/testing/kselftests/.

So, this one is unused by the rest of the changes, isn't it?
Am I missing something?



> > This patch breaks GCC-plugins.
> > Did you really compile-test this patch before the submission?
>
> Sorry for my ignorance here:
> I ran through the kernel build and installed the resulting kernel
> on a VM that I used to test this, if that's what you are asking
> about?
>
> Do I need some unusual .config options or run a special make target
> to trigger the problem you see?
>
> I used a recent Fedora config with default values for new options,
> and ran the normal default make target (also with O=) and make selftests
> to test the patch itself.


I just built allmodconfig for arm.

(The 0-day bot tests allmodconfig for most of architectures,
so you may receive error reports anyway.)


With your patch, I got the following:


masahiro@grover:~/ref/linux$ make  ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf-  allmodconfig all
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.h
  HOSTCC  scripts/kconfig/lexer.lex.o
  YACC    scripts/kconfig/parser.tab.c
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --allmodconfig Kconfig
#
# configuration written to .config
#
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  YACC    scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/dtc/yamltree.o
  HOSTLD  scripts/dtc/dtc
  CC      scripts/gcc-plugins/latent_entropy_plugin.o
cc1: error: cannot load plugin ./scripts/gcc-plugins/arm_ssp_per_task_plugin.so
   ./scripts/gcc-plugins/arm_ssp_per_task_plugin.so: cannot open
shared object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so
   ./scripts/gcc-plugins/structleak_plugin.so: cannot open shared
object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so
   ./scripts/gcc-plugins/latent_entropy_plugin.so: cannot open shared
object file: No such file or directory
cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
   ./scripts/gcc-plugins/randomize_layout_plugin.so: cannot open
shared object file: No such file or directory
make[3]: *** [scripts/Makefile.build;281:
scripts/gcc-plugins/latent_entropy_plugin.o] Error 1
make[2]: *** [scripts/Makefile.build;497: scripts/gcc-plugins] Error 2
make[1]: *** [Makefile;1097: scripts] Error 2
make: *** [Makefile;330: __build_one_by_one] Error 2







-- 
Best Regards
Masahiro Yamada
