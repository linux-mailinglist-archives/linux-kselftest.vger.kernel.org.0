Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6371271062D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 09:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbjEYHWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbjEYHW3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 03:22:29 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C941B4;
        Thu, 25 May 2023 00:22:26 -0700 (PDT)
Date:   Thu, 25 May 2023 09:22:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684999344; bh=WqUc/D7b6J+dZZ3k3J04dIED1dcPikypQw79086aY+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4qui0d6SFgquCtdZyX+rdW4NmFRU+MwSYXoz+NIOgAxuOFHJkA+W16BNaGXrAxwi
         d0tM4EyEQIRvkweDgiY07CEo3ZiJ5+1TnmhDDmOUYoqcsDtOdLbibs2POpPS07pecY
         KPcXGq5T2pYQ6SKBHWVTX7h02Mhr5OLA1nQx/nO4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, w@1wt.eu
Subject: Re: [PATCH 11/13] tools/nolibc: sys_select: riscv: use
 __NR_pselect6_time64 for rv32
Message-ID: <76a5f9a0-eec4-415a-9c5d-ac3bca4d4b0e@t-8ch.de>
References: <83339ea6-6653-41fe-af75-e0d51a4fa920@t-8ch.de>
 <20230525071021.77223-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525071021.77223-1-falcon@tinylab.org>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-25 15:10:21+0800, Zhangjin Wu wrote:
> Hi, Thomas
> 
> > On 2023-05-25 01:59:55+0800, Zhangjin Wu wrote:
> > > rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
> > > __NR_pselect6 after kernel commit d4c08b9776b3 ("riscv: Use latest
> > > system call ABI"), use __NR_pselect6_time64 instead.
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/include/nolibc/sys.h | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > index c0335a84f880..00c7197dcd50 100644
> > > --- a/tools/include/nolibc/sys.h
> > > +++ b/tools/include/nolibc/sys.h
> > > @@ -1041,8 +1041,13 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
> > >  		struct timeval *t;
> > >  	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
> > >  	return my_syscall1(__NR_select, &arg);
> > > -#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
> > > +#elif defined(__ARCH_WANT_SYS_PSELECT6) && (defined(__NR_pselect6) || defined(__NR_pselect6_time64))
> > > +#ifdef __NR_pselect6
> > >  	struct timespec t;
> > > +#else
> > > +	struct timespec64 t;
> > > +#define __NR_pselect6 __NR_pselect6_time64
> > 
> > Wouldn't this #define leak to the users of nolibc and lead to calls to
> > pselect6_time64 with the ABI of the __NR_pselect6 if userspace is doing
> > its own raw syscalls?
> >
> 
> Yeah, it would break the user-side raw __NR_pselect6 syscall for nolibc is a
> header-only libc, so, it is not safe to use such method like glibc.
> 
> Something like this will let the syscall call to pselect6_time64 instead of the
> user-required __NR_pselect6 and pass the wrong type of argument.
> 
>     #include "nolibc.h"  // If no __NR_pselect6 defined, __NR_pselect6 = __NR_pselect6_time64
> 
>     #ifdef __NR_pselect6
>         struct timespec t;  // come here for __NR_pselect6_time64, but t is not timespec64, broken
>         syscall(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
>     #else
>         struct timespec64 t;
>         syscall(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
>     #endif
> 
> I have used something like __NR_pselect6_time3264 locally, before
> sending the patchset, I found a cleaner method already used in sys.h:
> 
>     #ifndef __NR__newselect
>     #define __NR__newselect __NR_select
>     #endif
> 
> But I forgot the arguments mixing issue, __NR__newselect and __NR_select
> share the same type of arguments, but __NR_pselect6 and
> __NR_pselect6_time64 not, so, I will use back the old method but still
> need to find a better string, just like __NR__newselect, __NR__pselect6
> may be used in kernel space in the future, and __NR_pselect6_time3264 is
> too long, what about this?
> 
>     #ifdef __NR_pselect6
>             struct timespec t;
>     #define __NR_pselect6__ __NR_pselect6
>     #else
>             struct timespec64 t;
>     #define __NR_pselect6__ __NR_pselect6_time64
>     #endif
> 
> Or even ___NR_pselect6?

What about:

#ifdef __NR_pselect6
        struct timespec t;
        const long nr_pselect = __NR_pselect6;
#else
        struct timespec64 t;
        const long nr_pselect = __NR_pselect6_time64;
#endif

> 
> The same issue is in this patch:
> 
>     [PATCH 13/13] tools/nolibc: sys_gettimeofday: riscv: use __NR_clock_gettime64
> 
> will solve it with the same method.

Thanks!
