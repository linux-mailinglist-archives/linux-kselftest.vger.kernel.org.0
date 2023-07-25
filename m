Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3776099D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 07:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGYFpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 01:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYFpV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 01:45:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC21FCC;
        Mon, 24 Jul 2023 22:44:54 -0700 (PDT)
X-QQ-mid: bizesmtp78t1690263859tdcrm94y
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 13:44:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: dKvkn8qoLrHzKNEaeuHi1ESJuzl2btKeC/hNKaYrVC0TiCoNiC4/d3bBmF5dY
        ccfltpJNOW2OW888NOdGqG7+WfJVRo80Z2aWBcpjAgtACVkYrn3lGpQw8MgUqiKs0HnRzVQ
        PNBt7ofCsa70N5sLl1Lm56jfLUil0QU5WCNLRJEfvUaTkEd57113aJy2SOmyQ9mW1Uo7w1r
        yfJLSicRwuoV34TWkmR1zFKM+TL7dudiPIk7I2pxr1c31LVUP2sctm6rVA8KNeQVMN2P24c
        3yE/XnII5Yw+ucd8VUeyOx3DaLiFuwpKT0q4W9sefA+6RV+B96S3bR4vztn17M+d2thZ/eP
        J81g4HRJ1MW+ctrtZ9VnXjOs36DLA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5121908991366495097
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Date:   Tue, 25 Jul 2023 13:44:14 +0800
Message-Id: <20230725054414.15055-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723081520.GA19768@1wt.eu>
References: <20230723081520.GA19768@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas, Willy

> On Sun, Jul 23, 2023 at 09:32:37AM +0200, Thomas Weißschuh wrote:
> > On 2023-07-19 05:10:48+0800, Zhangjin Wu wrote:
> > > diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
> > > new file mode 100644
> > > index 000000000000..100ec0f412dc
> > > --- /dev/null
> > > +++ b/tools/include/nolibc/arch-powerpc.h
> > > @@ -0,0 +1,156 @@
> > > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > > +/*
> > > + * PowerPC specific definitions for NOLIBC
> > > + * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
> > 
> > If it is taken from musl, shouldn't there also be a musl copyright?
> 
> In fact it depends. If code was taken there, not only the copyright is
> needed, but the license' compatibility must be verified. If, however,
> the code was only disassembled to be understood and reimplemented (as
> it seems to me), then no code was taken there and it's not needed.
>

This discussion does inspire me a lot to shrink the whole architecture
specific nolibc my_syscall<N>() macros, like crt.h, a common syscall.h
is added to do so. I have finished most of them except the ones passing
arguments via stack, still trying to merge these ones.

With this new syscall.h, to support my_syscall<N>, the arch-<ARCH>.h
will only require to add ~10 lines to define their own syscall
instructions, registers and clobberlist, which looks like this (for
powerpc):

    #define _NOLIBC_SYSCALL_CALL "sc; bns+ 1f; neg  %0, %0; 1:"

    /* PowerPC doesn't always restore r3-r12 for us */
    #define _NOLIBC_SYSCALL_CLOBBERLIST 
    	"memory", "cr0", "r12", "r11", "r10", "r9", "r8", "r7", "r6", "r5", "r4"

    /* PowerPC write GPRS in kernel side but not restore them */
    #define _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
    
    #define _NOLIBC_REG_NUM  "r0"
    #define _NOLIBC_REG_RET  "r3"
    #define _NOLIBC_REG_arg1 "r3"
    #define _NOLIBC_REG_arg2 "r4"
    #define _NOLIBC_REG_arg3 "r5"
    #define _NOLIBC_REG_arg4 "r6"
    #define _NOLIBC_REG_arg5 "r7"
    #define _NOLIBC_REG_arg6 "r8"

Before:

    $ ls tools/include/nolibc/arch-*.h | while read f; do git show dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf:$f 2>/dev/null | wc -l | tr -d '\n'; echo " $f"; done
    157 tools/include/nolibc/arch-aarch64.h
    199 tools/include/nolibc/arch-arm.h
    178 tools/include/nolibc/arch-i386.h
    164 tools/include/nolibc/arch-loongarch.h
    195 tools/include/nolibc/arch-mips.h
    0 tools/include/nolibc/arch-powerpc.h
    160 tools/include/nolibc/arch-riscv.h
    186 tools/include/nolibc/arch-s390.h
    176 tools/include/nolibc/arch-x86_64.h

After:

    $ wc -l tools/include/nolibc/arch-*.h
       54 tools/include/nolibc/arch-aarch64.h
       84 tools/include/nolibc/arch-arm.h
       90 tools/include/nolibc/arch-i386.h                        /* the last one use stack to pass arguments, reserve as-is */
       59 tools/include/nolibc/arch-loongarch.h
      120 tools/include/nolibc/arch-mips.h                        /* the last two use stack to pass arguments, reserve as-is */
       73 tools/include/nolibc/arch-powerpc.h
       58 tools/include/nolibc/arch-riscv.h
       87 tools/include/nolibc/arch-s390.h
       67 tools/include/nolibc/arch-x86_64.h

syscall.h itself:

    $ wc -l tools/include/nolibc/syscall.h
    112 tools/include/nolibc/syscall.h 

Willy, do we need to rename my_syscall<N> to _nolibc_syscall<N> to limit
these macros nolibc internally? I plan to rename all of the new adding
macros with _nolibc_ (for funcs) or _NOLIBC_ (for variables).

Thomas, do we need to merge the syscall macros from unistd.h to this new
syscall.h? we do reuse the macros between them, like the _syscall_narg* ones.

Since this new syscall.h does help a lot to shrink the arch-powerpc.h, I plan
to send this syscall.h at first and then renew our powerpc patchset, what's
your idea? 

Thanks,
Zhangjin

> Thanks,
> Willy
