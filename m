Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47C596F08
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2019 03:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHUBsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Aug 2019 21:48:07 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:40347 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHUBsH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Aug 2019 21:48:07 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x7L1lta0032487;
        Wed, 21 Aug 2019 10:47:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7L1lta0032487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566352076;
        bh=giKdvy1r2KBFxH+dzEulYjNlRCBVX+d+KwVowA4QUPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=whKufMx8VP2uTA+00+41CybU90/+FDK4caJJpJsIQsFwzl9JoaO9dInP1KWdtfnbG
         giPXRlNmkqhgjHXGzLrNdyDjosqn1322oIxl6rlT5KKBSRDZ/1UmTLg75+UtvyoMce
         1MNvC45OAbtSPiA7cpayU5czoP50KZqkAgSjt2ey6sfm/6BtUwgGrme1jbCvHxn1Ni
         Jt8ID/ndNiTi0R1MYw7qVVaJYZSUzhAAiZ7lLfneepVxRjnis0xkzQFJGp1zg+WicN
         uViJRgIg2BHdRLiBN6XK7lE87o1uZB+u6LzBzSsfx/llsR8vABL/rng+fUisOED4L9
         DEpm7oUliaaeA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id g13so287253uap.5;
        Tue, 20 Aug 2019 18:47:56 -0700 (PDT)
X-Gm-Message-State: APjAAAU5MeNN02nwwJCOGwRcqRcT3ivYd5DJRUNfm906hi6SG2c56jkY
        S8p/M9RYD1aU9OHky3kVbo6g3DI4df4+KpgiZNk=
X-Google-Smtp-Source: APXvYqzDwvI4/KCbDbrari2BsYo2iKHzAaMTCEsEraUQlUlQtDNnkJa3RbVPXukTjINjUwvsZXmKSUUbv7nhxODVPd4=
X-Received: by 2002:ab0:6608:: with SMTP id r8mr896930uam.25.1566352074932;
 Tue, 20 Aug 2019 18:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
 <be2c361eac49ded2848b2a555b75e30cc3c24e71.1565676440.git-series.knut.omang@oracle.com>
 <CAK7LNASX4jPRxRxD+JafAfKqjck=x27HuHZgPV1VFfW8MzcwZA@mail.gmail.com>
 <14b99d26a4cff1c813c92818dc1234007fa06fc9.camel@oracle.com>
 <CAK7LNASgfd6KPRQ=hcqKkpZ6EVhFmbBjCXa30bvEqscu_5dwbQ@mail.gmail.com>
 <167a0b0c90a1ecc65da7bfc109f6d8ff860b70da.camel@oracle.com> <1c4760f43313488786ca867acc2835f9c9acef1f.camel@oracle.com>
In-Reply-To: <1c4760f43313488786ca867acc2835f9c9acef1f.camel@oracle.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Aug 2019 10:47:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATp2tNSUakQ1j81AC40QVJUoDaA6hJ7duLwqCOgkXObJg@mail.gmail.com>
Message-ID: <CAK7LNATp2tNSUakQ1j81AC40QVJUoDaA6hJ7duLwqCOgkXObJg@mail.gmail.com>
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

On Wed, Aug 14, 2019 at 9:53 PM Knut Omang <knut.omang@oracle.com> wrote:
>
> On Wed, 2019-08-14 at 07:52 +0200, Knut Omang wrote:
> > On Wed, 2019-08-14 at 11:02 +0900, Masahiro Yamada wrote:
> > > Hi Knut,
> > >
> > > On Wed, Aug 14, 2019 at 1:19 AM Knut Omang <knut.omang@oracle.com> wrote:
> > > > On Tue, 2019-08-13 at 23:01 +0900, Masahiro Yamada wrote:
> > > > > On Tue, Aug 13, 2019 at 3:13 PM Knut Omang <knut.omang@oracle.com> wrote:
> > > > > > C++ libraries interfacing to C APIs might sometimes need some glue
> > > > > > logic more easily written in C.
> > > > > > Allow a C++ library to also contain 0 or more C objects.
> > > > > >
> > > > > > Also fix rules for both C and C++ shared libraries:
> > > > > > - C++ shared libraries depended on .c instead of .cc files
> > > > > > - Rules were referenced as -objs instead of the intended
> > > > > >   -cobjs and -cxxobjs following the pattern from hostprogs*.
> > > > > >
> > > > > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > > >
> > > > > How is this patch related to the rest of this series?
> > > >
> > > > This is just my (likely naive) way I to get what I had working
> > > > using autotools in the Github version of KTF) translated into something
> > > > comparable using kbuild only. We need to build a shared library consisting
> > > > of a few C++ files and a very simple C file, and a couple of simple binaries,
> > > > and the rule in there does seem to take .c files and subject them to the
> > > > C++ compiler, which makes this difficult to achieve?
> > >
> > > Looking at the diff stat of the cover-letter,
> > > the rest of this patch series is touching only
> > > Documentation/ and tools/testing/kselftests/.
> > >
> > > So, this one is unused by the rest of the changes, isn't it?
> > > Am I missing something?
> > >
> > >
> > >
> > > > > This patch breaks GCC-plugins.
> > > > > Did you really compile-test this patch before the submission?
> > > >
> > > > Sorry for my ignorance here:
> > > > I ran through the kernel build and installed the resulting kernel
> > > > on a VM that I used to test this, if that's what you are asking
> > > > about?
> > > >
> > > > Do I need some unusual .config options or run a special make target
> > > > to trigger the problem you see?
> > > >
> > > > I used a recent Fedora config with default values for new options,
> > > > and ran the normal default make target (also with O=) and make selftests
> > > > to test the patch itself.
> > >
> > > I just built allmodconfig for arm.
> > >
> > > (The 0-day bot tests allmodconfig for most of architectures,
> > > so you may receive error reports anyway.)
> > >
> > >
> > > With your patch, I got the following:
> > >
> > >
> > > masahiro@grover:~/ref/linux$ make  ARCH=arm
> > > CROSS_COMPILE=-  allmodconfig all
> > >   HOSTCC  scripts/basic/fixdep
> > >   HOSTCC  scripts/kconfig/conf.o
> > >   HOSTCC  scripts/kconfig/confdata.o
> > >   HOSTCC  scripts/kconfig/expr.o
> > >   LEX     scripts/kconfig/lexer.lex.c
> > >   YACC    scripts/kconfig/parser.tab.h
> > >   HOSTCC  scripts/kconfig/lexer.lex.o
> > >   YACC    scripts/kconfig/parser.tab.c
> > >   HOSTCC  scripts/kconfig/parser.tab.o
> > >   HOSTCC  scripts/kconfig/preprocess.o
> > >   HOSTCC  scripts/kconfig/symbol.o
> > >   HOSTLD  scripts/kconfig/conf
> > > scripts/kconfig/conf  --allmodconfig Kconfig
> > > #
> > > # configuration written to .config
> > > #
> > >   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
> > >   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
> > >   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
> > >   HOSTCC  scripts/dtc/dtc.o
> > >   HOSTCC  scripts/dtc/flattree.o
> > >   HOSTCC  scripts/dtc/fstree.o
> > >   HOSTCC  scripts/dtc/data.o
> > >   HOSTCC  scripts/dtc/livetree.o
> > >   HOSTCC  scripts/dtc/treesource.o
> > >   HOSTCC  scripts/dtc/srcpos.o
> > >   HOSTCC  scripts/dtc/checks.o
> > >   HOSTCC  scripts/dtc/util.o
> > >   LEX     scripts/dtc/dtc-lexer.lex.c
> > >   YACC    scripts/dtc/dtc-parser.tab.h
> > >   HOSTCC  scripts/dtc/dtc-lexer.lex.o
> > >   YACC    scripts/dtc/dtc-parser.tab.c
> > >   HOSTCC  scripts/dtc/dtc-parser.tab.o
> > >   HOSTCC  scripts/dtc/yamltree.o
> > >   HOSTLD  scripts/dtc/dtc
> > >   CC      scripts/gcc-plugins/latent_entropy_plugin.o
> > > cc1: error: cannot load plugin ./scripts/gcc-plugins/arm_ssp_per_task_plugin.so
> > >    ./scripts/gcc-plugins/arm_ssp_per_task_plugin.so: cannot open
> > > shared object file: No such file or directory
> > > cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so
> > >    ./scripts/gcc-plugins/structleak_plugin.so: cannot open shared
> > > object file: No such file or directory
> > > cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so
> > >    ./scripts/gcc-plugins/latent_entropy_plugin.so: cannot open shared
> > > object file: No such file or directory
> > > cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
> > >    ./scripts/gcc-plugins/randomize_layout_plugin.so: cannot open
> > > shared object file: No such file or directory
> > > make[3]: *** [scripts/Makefile.build;281:
> > > scripts/gcc-plugins/latent_entropy_plugin.o] Error 1
> > > make[2]: *** [scripts/Makefile.build;497: scripts/gcc-plugins] Error 2
> > > make[1]: *** [Makefile;1097: scripts] Error 2
> > > make: *** [Makefile;330: __build_one_by_one] Error 2
> >
> > Ok, I see!
> >
> > I'll recall this target and look into it!
>
> Ok, so I have tried installing the arm-linux-gnueabihf cross compiler and compiled the kernel for arm,
> but allmodconfig does not seem to enable any GCC plugins per default even on ARM and I haven't been able
> to figure out how to enable any.


Linaro toolchain supports gcc plugins.

https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabihf/


kernel.org one supports it as well.

https://mirrors.edge.kernel.org/pub/tools/crosstool/





> A plain allmodconfig generated config compiles perfectly for me both native x86 and w/arm cross compile,
> but it doesn't seem to enable any gcc plugins.
>
> Anyway, maybe I am getting this wrong anyway:
> Having played with cross compile, it starts to become clear to me that HOSTCC rules
> might not be the right rules to use, as it will generate host user land binaries as opposed to
> target user land binaries (in a cross compile world obviously these differ)
>
> Now, I started off with using the rules in the selftests makefiles for this, but they do not play that well with
> kernel module building. My goal is to be able to do both user land and kernel module **target** compiles
> from the same subtree. Any hints on how to accomplish this appreciated :-)


tools/ is out of scope of kbuild because it adopted a different (more
adhoc) build system.
I have no idea. Please talk to the kselftest maintainer.



>
> Thanks,
> Knut
>


-- 
Best Regards
Masahiro Yamada
