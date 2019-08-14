Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269028CABA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 07:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHNFvK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 01:51:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54554 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfHNFvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 01:51:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7E5mpIe062503;
        Wed, 14 Aug 2019 05:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=Cptp77h6SIWaOvz4askUueIxJmMTrJXjaT7ObIOf3wU=;
 b=GX19XCmZzVcDXK8yEfa0abnaUNeVMokbhpknbfpO5glNTU45xXLJfB9FpVWAgA0JVrd6
 fXqyk3K0LaPCUb5Y8fOHFVDkEi7jwoUlcjHuqpzDAkj4+WhGgyDovB4I/cD27akjSe9M
 PUOcIlSfDEg6kz2L36Eqi+pI22ODUmGPwwnmniQ0vWXVMReS/3cEp3LqANclvJLsCMZo
 1/Xd63hTFKLk/2dUlAvffuFgjOwc2R2B4fZu+kU5hufny4d+QNdnsoDPO+XMmKC8r5sH
 Bxgcmq7nn1/Yb8802zA+neK6Domh1/QpVeE5Wf5flHdM2nMmwLsym9PTpRi/za1GojJZ aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u9nvpaj2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 05:50:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7E5mm9T187666;
        Wed, 14 Aug 2019 05:50:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ubwcxkrm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 05:50:43 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7E5oc50025565;
        Wed, 14 Aug 2019 05:50:38 GMT
Received: from abi.no.oracle.com (/141.143.213.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 22:50:37 -0700
Message-ID: <aba3a1457087b281a82c09c3e382c932e750194f.camel@oracle.com>
Subject: Re: [RFC 01/19] kbuild: Fixes to rules for host-cshlib and
 host-cxxshlib
From:   Knut Omang <knut.omang@oracle.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
Date:   Wed, 14 Aug 2019 07:50:33 +0200
In-Reply-To: <CAK7LNASgfd6KPRQ=hcqKkpZ6EVhFmbBjCXa30bvEqscu_5dwbQ@mail.gmail.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
         <be2c361eac49ded2848b2a555b75e30cc3c24e71.1565676440.git-series.knut.omang@oracle.com>
         <CAK7LNASX4jPRxRxD+JafAfKqjck=x27HuHZgPV1VFfW8MzcwZA@mail.gmail.com>
         <14b99d26a4cff1c813c92818dc1234007fa06fc9.camel@oracle.com>
         <CAK7LNASgfd6KPRQ=hcqKkpZ6EVhFmbBjCXa30bvEqscu_5dwbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140056
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2019-08-14 at 11:02 +0900, Masahiro Yamada wrote:
> Hi Knut,
> 
> On Wed, Aug 14, 2019 at 1:19 AM Knut Omang <knut.omang@oracle.com> wrote:
> > On Tue, 2019-08-13 at 23:01 +0900, Masahiro Yamada wrote:
> > > On Tue, Aug 13, 2019 at 3:13 PM Knut Omang <knut.omang@oracle.com> wrote:
> > > > C++ libraries interfacing to C APIs might sometimes need some glue
> > > > logic more easily written in C.
> > > > Allow a C++ library to also contain 0 or more C objects.
> > > > 
> > > > Also fix rules for both C and C++ shared libraries:
> > > > - C++ shared libraries depended on .c instead of .cc files
> > > > - Rules were referenced as -objs instead of the intended
> > > >   -cobjs and -cxxobjs following the pattern from hostprogs*.
> > > > 
> > > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > 
> > > How is this patch related to the rest of this series?
> > 
> > This is just my (likely naive) way I to get what I had working
> > using autotools in the Github version of KTF) translated into something
> > comparable using kbuild only. We need to build a shared library consisting
> > of a few C++ files and a very simple C file, and a couple of simple binaries,
> > and the rule in there does seem to take .c files and subject them to the
> > C++ compiler, which makes this difficult to achieve?
> 
> Looking at the diff stat of the cover-letter,
> the rest of this patch series is touching only
> Documentation/ and tools/testing/kselftests/.
> 
> So, this one is unused by the rest of the changes, isn't it?
> Am I missing something?

What I am trying to do is to build kernel **and** user mode components 
under tools/testing/selftests/ktf and to keep the kernel test code out 
of the tree. The only way I was able to do this was by means of the module build,
eg. 'make TARGETS="ktf" kselftest' will cause a toplevel 'make M=tools/testing/selftests/ktf'
which is what builds the lot. One can argue that this is a misuse of that mechanism,
but as I argue in the cover letter, I think there is a need to make it possible 
to have kernel code that is not going to be part of the installed kernel 
somewhere else than in the normal build path of the kernel, which is what 
I am trying to achieve.

The toplevel Makefile logic for this is in patch 17 of the series in 
tools/testing/selftests/ktf/Makefile
and for ktf/kernel/Makefile and ktf/lib/Makefile and ktf/user/Makefile 
in patches 2, 12 and 16 respectively.

It is a bit of a hack still, since the hostcxxprogs-y and hostcxxlib-y
targets in ktf/user and ktf/lib do not get invoked "automatically" 
from __build like the obj-m targets. I haven't been able to figure out 
yet how to achieve that, and was hoping I could get help on it :-)

Thanks!
Knut

> > > This patch breaks GCC-plugins.
> > > Did you really compile-test this patch before the submission?
> > 
> > Sorry for my ignorance here:
> > I ran through the kernel build and installed the resulting kernel
> > on a VM that I used to test this, if that's what you are asking
> > about?
> > 
> > Do I need some unusual .config options or run a special make target
> > to trigger the problem you see?
> > 
> > I used a recent Fedora config with default values for new options,
> > and ran the normal default make target (also with O=) and make selftests
> > to test the patch itself.
> 
> I just built allmodconfig for arm.
> 
> (The 0-day bot tests allmodconfig for most of architectures,
> so you may receive error reports anyway.)
> 
> 
> With your patch, I got the following:
> 
> 
> masahiro@grover:~/ref/linux$ make  ARCH=arm
> CROSS_COMPILE=arm-linux-gnueabihf-  allmodconfig all
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.h
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   YACC    scripts/kconfig/parser.tab.c
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --allmodconfig Kconfig
> #
> # configuration written to .config
> #
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
>   SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
>   HOSTCC  scripts/dtc/dtc.o
>   HOSTCC  scripts/dtc/flattree.o
>   HOSTCC  scripts/dtc/fstree.o
>   HOSTCC  scripts/dtc/data.o
>   HOSTCC  scripts/dtc/livetree.o
>   HOSTCC  scripts/dtc/treesource.o
>   HOSTCC  scripts/dtc/srcpos.o
>   HOSTCC  scripts/dtc/checks.o
>   HOSTCC  scripts/dtc/util.o
>   LEX     scripts/dtc/dtc-lexer.lex.c
>   YACC    scripts/dtc/dtc-parser.tab.h
>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>   YACC    scripts/dtc/dtc-parser.tab.c
>   HOSTCC  scripts/dtc/dtc-parser.tab.o
>   HOSTCC  scripts/dtc/yamltree.o
>   HOSTLD  scripts/dtc/dtc
>   CC      scripts/gcc-plugins/latent_entropy_plugin.o
> cc1: error: cannot load plugin ./scripts/gcc-plugins/arm_ssp_per_task_plugin.so
>    ./scripts/gcc-plugins/arm_ssp_per_task_plugin.so: cannot open
> shared object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so
>    ./scripts/gcc-plugins/structleak_plugin.so: cannot open shared
> object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so
>    ./scripts/gcc-plugins/latent_entropy_plugin.so: cannot open shared
> object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
>    ./scripts/gcc-plugins/randomize_layout_plugin.so: cannot open
> shared object file: No such file or directory
> make[3]: *** [scripts/Makefile.build;281:
> scripts/gcc-plugins/latent_entropy_plugin.o] Error 1
> make[2]: *** [scripts/Makefile.build;497: scripts/gcc-plugins] Error 2
> make[1]: *** [Makefile;1097: scripts] Error 2
> make: *** [Makefile;330: __build_one_by_one] Error 2
> 
> 
> 
> 
> 
> 
> 

