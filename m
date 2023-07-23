Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE075E047
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 09:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGWHcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWHcm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 03:32:42 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55B10FA;
        Sun, 23 Jul 2023 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690097558; bh=k+/+Feq5kfznOnI8ewNV2LrrnmVnHryXrUwEYYXKhp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGsk/0N7xiDU9AKY00uyoj8y81JciVvxMhdbcJ8BjCJt4t5z3UiK6gu39kSNukDAw
         TwNSKm9UuuB5MrlsvqJIZ51iabAkSp+H0aTGY+m6Tic5uIha6UgNMfv1ZM1+JbtKfs
         aqILReUcQ8EPZDvGYH2aYBLy/Y1HlWaLTJCuz6ak=
Date:   Sun, 23 Jul 2023 09:32:37 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Message-ID: <64a95595-9716-4276-a747-0c985997c1ab@t-8ch.de>
References: <cover.1689713175.git.falcon@tinylab.org>
 <f733876f6e711c37afc3c34a71b241c9f734d62e.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f733876f6e711c37afc3c34a71b241c9f734d62e.1689713175.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-19 05:10:48+0800, Zhangjin Wu wrote:
> Both syscall declarations and _start code definition are added for
> powerpc to nolibc.
> 
> Like mips, powerpc uses a register (exactly, the summary overflow bit)
> to record the error occurred, and uses another register to return the
> value [1]. So, the return value of every syscall declaration must be
> normalized to easier the __sysret helper, return -value when there is an
> error, otheriwse, return value directly.
> 
> Glibc and musl use different methods to check the summary overflow bit,
> glibc (sysdeps/unix/sysv/linux/powerpc/sysdep.h) saves the cr register
> to r0 at first, and then check the summary overflow bit in cr0:
> 
>     mfcr r0
>     r0 & (1 << 28) ? -r3 : r3
> 
>     -->
> 
>     10003c14:       7c 00 00 26     mfcr    r0
>     10003c18:       74 09 10 00     andis.  r9,r0,4096
>     10003c1c:       41 82 00 08     beq     0x10003c24
>     10003c20:       7c 63 00 d0     neg     r3,r3
> 
> Musl (arch/powerpc/syscall_arch.h) directly checks the summary overflow
> bit with the 'bns' instruction:
> 
>     /* no summary overflow bit means no error, return value directly */
>     bns+ 1f
>     /* otherwise, return negated value */
>     neg r3, r3
>     1:
> 
>     -->
> 
>     10000418:       40 a3 00 08     bns     0x10000420
>     1000041c:       7c 63 00 d0     neg     r3,r3
> 
> The later one is smaller, here applies it.
> 
> arch/powerpc/include/asm/vdso/gettimeofday.h file uses the smaller
> method for do_syscall_2() too.
> 
> [1]: https://man7.org/linux/man-pages/man2/syscall.2.html
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/arch-powerpc.h | 156 ++++++++++++++++++++++++++++

This also should be added to nolibc/arch.h.

>  1 file changed, 156 insertions(+)
>  create mode 100644 tools/include/nolibc/arch-powerpc.h
> 
> diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
> new file mode 100644
> index 000000000000..100ec0f412dc
> --- /dev/null
> +++ b/tools/include/nolibc/arch-powerpc.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * PowerPC specific definitions for NOLIBC
> + * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>

If it is taken from musl, shouldn't there also be a musl copyright?

> [..]
