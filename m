Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F328A711D18
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjEZBuq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 21:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZBuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 21:50:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E5194;
        Thu, 25 May 2023 18:50:43 -0700 (PDT)
X-QQ-mid: bizesmtp78t1685065838tfibdc44
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 26 May 2023 09:50:37 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: eSZ1CZgv+JCfU+Q/Ek/ByeU4a4AcvGPfBDxLuzVFFnBqpvoCh57Xxdo1gHof2
        DKr4mZ4kV32WaG5tW5yVOn0mzE2srmKCy20Wly4IDPnhzsNIFzH8Ag5oMY2wbxji9SEJrIc
        xvZ1OFXmdBbzmpsBzEhyTlrbTbAbTKbbKsQJuXoqqjwGsiKWOwV54KwCJ+GwOmWBSWxIqvX
        TdyIfspVyKxfH/7TPKd/GL+n2HqFsSJ0wVBV5B+mE2RgJg6H5I9Qfk4fbp4GZNJDwC5iSGb
        401ADIKHmUHRf0C55yg65WZ3Qde3Eqh2HXjK0SQixho7yC3iCwEd6oL4fZI1Maez5Dq55Ca
        21pxKHG+TjqEZX04sB4RVmaRnlK+A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17809865514302005706
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH 11/13] tools/nolibc: sys_select: riscv: use __NR_pselect6_time64 for rv32
Date:   Fri, 26 May 2023 09:50:37 +0800
Message-Id: <20230526015037.6455-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <76a5f9a0-eec4-415a-9c5d-ac3bca4d4b0e@t-8ch.de>
References: <76a5f9a0-eec4-415a-9c5d-ac3bca4d4b0e@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-05-25 15:10:21+0800, Zhangjin Wu wrote:
> > Hi, Thomas
> > 
> > > On 2023-05-25 01:59:55+0800, Zhangjin Wu wrote:
> > > > rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
> > > > __NR_pselect6 after kernel commit d4c08b9776b3 ("riscv: Use latest
> > > > system call ABI"), use __NR_pselect6_time64 instead.
> > > > 
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/include/nolibc/sys.h | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > > > index c0335a84f880..00c7197dcd50 100644
> > > > --- a/tools/include/nolibc/sys.h
> > > > +++ b/tools/include/nolibc/sys.h
> > > > @@ -1041,8 +1041,13 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
> > > >  		struct timeval *t;
> > > >  	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
> > > >  	return my_syscall1(__NR_select, &arg);
> > > > -#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
> > > > +#elif defined(__ARCH_WANT_SYS_PSELECT6) && (defined(__NR_pselect6) || defined(__NR_pselect6_time64))
> > > > +#ifdef __NR_pselect6
> > > >  	struct timespec t;
> > > > +#else
> > > > +	struct timespec64 t;
> > > > +#define __NR_pselect6 __NR_pselect6_time64
> > > 
> > > Wouldn't this #define leak to the users of nolibc and lead to calls to
> > > pselect6_time64 with the ABI of the __NR_pselect6 if userspace is doing
> > > its own raw syscalls?
> > >
> > 
> > Yeah, it would break the user-side raw __NR_pselect6 syscall for nolibc is a
> > header-only libc, so, it is not safe to use such method like glibc.
> > 
> > Something like this will let the syscall call to pselect6_time64 instead of the
> > user-required __NR_pselect6 and pass the wrong type of argument.
> > 
> >     #include "nolibc.h"  // If no __NR_pselect6 defined, __NR_pselect6 = __NR_pselect6_time64
> > 
> >     #ifdef __NR_pselect6
> >         struct timespec t;  // come here for __NR_pselect6_time64, but t is not timespec64, broken
> >         syscall(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
> >     #else
> >         struct timespec64 t;
> >         syscall(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
> >     #endif
> > 
> > I have used something like __NR_pselect6_time3264 locally, before
> > sending the patchset, I found a cleaner method already used in sys.h:
> > 
> >     #ifndef __NR__newselect
> >     #define __NR__newselect __NR_select
> >     #endif
> > 
> > But I forgot the arguments mixing issue, __NR__newselect and __NR_select
> > share the same type of arguments, but __NR_pselect6 and
> > __NR_pselect6_time64 not, so, I will use back the old method but still
> > need to find a better string, just like __NR__newselect, __NR__pselect6
> > may be used in kernel space in the future, and __NR_pselect6_time3264 is
> > too long, what about this?
> > 
> >     #ifdef __NR_pselect6
> >             struct timespec t;
> >     #define __NR_pselect6__ __NR_pselect6
> >     #else
> >             struct timespec64 t;
> >     #define __NR_pselect6__ __NR_pselect6_time64
> >     #endif
> > 
> > Or even ___NR_pselect6?
> 
> What about:
> 
> #ifdef __NR_pselect6
>         struct timespec t;
>         const long nr_pselect = __NR_pselect6;
> #else
>         struct timespec64 t;
>         const long nr_pselect = __NR_pselect6_time64;
> #endif
>

It looks better and cleaner, will apply this method, thanks!

> > 
> > The same issue is in this patch:
> > 
> >     [PATCH 13/13] tools/nolibc: sys_gettimeofday: riscv: use __NR_clock_gettime64
> > 
> > will solve it with the same method.
>

And also this one:

    [PATCH 09/13] tools/nolibc: sys_poll: riscv: use __NR_ppoll_time64

Have tested all of them, will send a v2 later.

Best regards,
Zhangjin

> Thanks!
