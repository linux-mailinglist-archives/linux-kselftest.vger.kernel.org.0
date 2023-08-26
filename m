Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5FC7893D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Aug 2023 06:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjHZEbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Aug 2023 00:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjHZEbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Aug 2023 00:31:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55326B8;
        Fri, 25 Aug 2023 21:31:02 -0700 (PDT)
X-QQ-mid: bizesmtp69t1693024250t8x1szhz
Received: from linux-lab-host.localdomain ( [116.30.128.222])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 26 Aug 2023 12:30:48 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: CR3LFp2JE4lYYSpivJlI2SuOuzPRWJJc0IWzbiEGnrcKe7FBJFh6wZ6s+PQ2F
        37o20e7zvbK+67J0O+P7OT4mCfHmX3LySQKEgqzwX26Gr8zpzUHM3ZMUDgjRjHiDKGWpD3P
        RakL14KHqxla/2WvULqNpYU7G+If8ywK4/UZofvWrn9k1XNJmh4gwyt+Dsnjl8w1dCwHmRg
        tRRAgHzmHB24F0GBYVTHa6c/87WASvShOI+Yu+6CTgAFAsgwUb6TOlgfKwugUNFelUI4qmh
        xGo8vC+ioADDnRaCE8B8AndYhPD6Gs0ukpg6f3VSjUqV/5fdQzfLuTfTtBZPC+0/fH4pE4I
        5dZGfDHZorEkgf/I41Y/HvOk68z58F8EfJZq5j7
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 558064754395152056
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de, Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH v2 3/3] selftests/nolibc: fix up O= option support
Date:   Sat, 26 Aug 2023 12:30:46 +0800
Message-Id: <20230826043046.53692-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230806121721.30774-1-falcon@tinylab.org>
References: <20230806121721.30774-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> > On Sat, Aug 05, 2023 at 02:13:11PM +0800, Zhangjin Wu wrote:
> > > To avoid pollute the source code tree and avoid mrproper for every
> > > architecture switch, the O= argument must be supported.
> > > 
> > > Both IMAGE and .config are from the building directory, let's use
> > > objtree instead of srctree for them.
> > > 
> > > If no O= option specified, means building kernel in source code tree,
> > > objtree should be srctree in such case.
> > > 
> > > To support relative path, as suggested by Thomas, $(COMMAND_O) is used
> > > to pass the O=$(ABSOLUTE_O) to the $(MAKE) commands.
> > 
> > Zhangjin, I cannot get this one to work, regardless of what I try:
> > 
> >    $ make -j8 O=$PWD/output-i386 nolibc-test XARCH=i386 CROSS_COMPILE=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux- CC=/f/tc/nolibc/gcc-12.3.0-nolibc/i386-linux/bin/i386-linux-gcc
> >    (...)
> >    CC      nolibc-test
> >    In file included from sysroot/i386/include/stdio.h:14,
> >                     from nolibc-test.c:13:
> >    sysroot/i386/include/errno.h:10:10: fatal error: asm/errno.h: No such file or directory
> >       10 | #include <asm/errno.h>
> >          |          ^~~~~~~~~~~~~
> >    compilation terminated.
> >
> 
> Willy, I also just reproduced the issue, seems only i386 sysroot has no
> asm/errno.h, will check why it is no rightly installed later.
> 
>     $ find sysroot/ -name "errno.h"
>     sysroot/arm/include/errno.h
>     sysroot/arm/include/asm-generic/errno.h
>     sysroot/arm/include/asm/errno.h
>     sysroot/arm/include/linux/errno.h
>     sysroot/riscv/include/errno.h
>     sysroot/riscv/include/asm-generic/errno.h
>     sysroot/riscv/include/asm/errno.h
>     sysroot/riscv/include/linux/errno.h
>     sysroot/s390/include/errno.h
>     sysroot/s390/include/asm-generic/errno.h
>     sysroot/s390/include/asm/errno.h
>     sysroot/s390/include/linux/errno.h
>     sysroot/arm64/include/errno.h
>     sysroot/arm64/include/asm-generic/errno.h
>     sysroot/arm64/include/asm/errno.h
>     sysroot/arm64/include/linux/errno.h
>     sysroot/mips/include/errno.h
>     sysroot/mips/include/asm-generic/errno.h
>     sysroot/mips/include/asm/errno.h
>     sysroot/mips/include/linux/errno.h
>     sysroot/x86_64/include/errno.h
>     sysroot/x86_64/include/asm-generic/errno.h
>     sysroot/x86_64/include/asm/errno.h
>     sysroot/x86_64/include/linux/errno.h
>     sysroot/i386/include/errno.h
>     sysroot/i386/include/asm-generic/errno.h
>     sysroot/i386/include/linux/errno.h
>     sysroot/powerpc/include/errno.h
>     sysroot/powerpc/include/asm-generic/errno.h
>     sysroot/powerpc/include/asm/errno.h
>     sysroot/powerpc/include/linux/errno.h
> 
> > I'll leave it aside for now as I've spent way longer than I hoped on
> > these series. I could take the previous two patches however.
> >
> 
> Ok, let's ignore this one, I will find why sysroot not install well for i386.
>

Thanks to Yuan, he have done some testing and have found the root cause, that
is mrproper on top-level source code tree is required before installing
sysroot, otherwise, the 'generated' headers will not be installed (removed by
scripts/Makefile.asm-generic).

After mrproper (not with O=out, must on top-level source code tree), the
asm/errno.h will be there:

    ubuntu@linux-lab:/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc$ find sysroot/ -name "errno.h"
    sysroot/i386/include/errno.h
    sysroot/i386/include/asm-generic/errno.h
    sysroot/i386/include/asm/errno.h             --> here it is
    sysroot/i386/include/linux/errno.h
    sysroot/x86/include/errno.h
    sysroot/x86/include/asm-generic/errno.h
    sysroot/x86/include/asm/errno.h              --> here it is
    sysroot/x86/include/linux/errno.h

That also means, to use O=out for run-user, we also need to use O=out for
defconfig (and kernel ...) too, otherwise, the top-level source code tree will
be polluated.

Seems a manual mrproper on top-level source code tree is always required for a
new iteration, so, it may be ok to pick this patch with a note on the potential
error.

Best Regards,
Zhangjin

> Thanks,
> Zhangjin
> 
> > Thanks,
> > Willy
