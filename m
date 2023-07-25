Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703677623F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGYUw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjGYUw0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 16:52:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB6B6;
        Tue, 25 Jul 2023 13:52:23 -0700 (PDT)
X-QQ-mid: bizesmtp63t1690318323thbmfm5x
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 04:52:02 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: dKvkn8qoLrEfuiEGb04Gt0hhYl6ZZfsg2nQWwpGYNORZ45+H0KEVkeSopkUAr
        wFohsahUk0FwqtjhVwPdRLh1GgccUmJE1fNAdswGJruLN9G7y9qPe9JOJXhOcRuACwDEC9X
        S/3DFqSBWU64voxitA7DMRmEdLJc+UzzPDxECC/RvXFpVa6lAAq0TgetDizqfLtrvjLXckq
        bMGlw7X/Z2euP09rhfbh3W2WyyekjFJWDjm9hTyXGT7LW/yAioqOivdP9DhL7bpmw5k2uhx
        sMnz97qf7sIH15yMkMiyI3+bhNYyXEB9Tu8xEesMpPi/Cg2XOkV4EfYGNkzhP1lOF7N0o8x
        8AOAuQfPOzxLyExmEeSBPoQsbI8oCRx7OqxWrASTQbSNXiQAlZLEUlWv4e8b1bb15VxmHJZ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11414832214700930819
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     ammarfaizi2@gnuweeb.org, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        svens@linux.ibm.com, thomas@t-8ch.de
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Date:   Wed, 26 Jul 2023 04:52:02 +0800
Message-Id: <20230725205202.36788-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725182736.GA24943@1wt.eu>
References: <20230725182736.GA24943@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy,

> On Tue, Jul 25, 2023 at 07:02:55PM +0800, Zhangjin Wu wrote:
> > > > With this new syscall.h, to support my_syscall<N>, the arch-<ARCH>.h
> > > > will only require to add ~10 lines to define their own syscall
> > > > instructions, registers and clobberlist, which looks like this (for
> > > > powerpc):
> > > > 
> > > >     #define _NOLIBC_SYSCALL_CALL "sc; bns+ 1f; neg  %0, %0; 1:"
> > > > 
> > > >     /* PowerPC doesn't always restore r3-r12 for us */
> > > >     #define _NOLIBC_SYSCALL_CLOBBERLIST 
> > > >     	"memory", "cr0", "r12", "r11", "r10", "r9", "r8", "r7", "r6", "r5", "r4"
> > > > 
> > > >     /* PowerPC write GPRS in kernel side but not restore them */
> > > >     #define _NOLIBC_GPRS_AS_OUTPUT_OPERANDS
> > > >     
> > > >     #define _NOLIBC_REG_NUM  "r0"
> > > >     #define _NOLIBC_REG_RET  "r3"
> > > >     #define _NOLIBC_REG_arg1 "r3"
> > > >     #define _NOLIBC_REG_arg2 "r4"
> > > >     #define _NOLIBC_REG_arg3 "r5"
> > > >     #define _NOLIBC_REG_arg4 "r6"
> > > >     #define _NOLIBC_REG_arg5 "r7"
> > > >     #define _NOLIBC_REG_arg6 "r8"
> > > > 
> > > > Before:
> > > > 
> > > >     $ ls tools/include/nolibc/arch-*.h | while read f; do git show dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf:$f 2>/dev/null | wc -l | tr -d '\n'; echo " $f"; done
> > > >     157 tools/include/nolibc/arch-aarch64.h
> > > >     199 tools/include/nolibc/arch-arm.h
> > > >     178 tools/include/nolibc/arch-i386.h
> > > >     164 tools/include/nolibc/arch-loongarch.h
> > > >     195 tools/include/nolibc/arch-mips.h
> > > >     0 tools/include/nolibc/arch-powerpc.h
> > > >     160 tools/include/nolibc/arch-riscv.h
> > > >     186 tools/include/nolibc/arch-s390.h
> > > >     176 tools/include/nolibc/arch-x86_64.h
> > > > 
> > > > After:
> > > > 
> > > >     $ wc -l tools/include/nolibc/arch-*.h
> > > >        54 tools/include/nolibc/arch-aarch64.h
> > > >        84 tools/include/nolibc/arch-arm.h
> > > >        90 tools/include/nolibc/arch-i386.h                        /* the last one use stack to pass arguments, reserve as-is */
> > > >        59 tools/include/nolibc/arch-loongarch.h
> > > >       120 tools/include/nolibc/arch-mips.h                        /* the last two use stack to pass arguments, reserve as-is */
> > > >        73 tools/include/nolibc/arch-powerpc.h
> > > >        58 tools/include/nolibc/arch-riscv.h
> > > >        87 tools/include/nolibc/arch-s390.h
> > > >        67 tools/include/nolibc/arch-x86_64.h
> > > > 
> > > > syscall.h itself:
> > > > 
> > > >     $ wc -l tools/include/nolibc/syscall.h
> > > >     112 tools/include/nolibc/syscall.h 
> > > 
>
> [...]
>
> Hoping this clarifies my position on this.
>

Willy, Thanks very much for your detailed reply, based on your reply, I
plan to renew the powerpc patchset itself at first since both you and
Thomas have already reviewed it carefully.

After that, I will come back to read your reply again and discuss more
about our new syscall.h, I still think it is something valuable to take
a look at, although something about it still need more attention,
perhaps a RFC patchset is better for more discuss, it may show us the
profile easily.

Best regards,
Zhangjin

> Thanks,
> Willy
