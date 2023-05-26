Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8271971252A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbjEZLAV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjEZLAT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 07:00:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3483E101;
        Fri, 26 May 2023 04:00:17 -0700 (PDT)
X-QQ-mid: bizesmtp73t1685098803tuh3o3nn
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 26 May 2023 19:00:02 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: UMQM+3VOEYubwFG4eTf0xraKgpRd5gWS2yEiy7v3gdEJXjTVfMxvBDdt0o0aW
        1MynBUjeWTGOOWpwfoHYEsUSf+xKPkA8TDsfcf0ZksxHbLMy1tZtGdGz3AnUOAPZzNmsIwH
        Pd5MxhuYRwOgOueKlRBcpnGzeOQeM+4LiFIM+NLXOsv1F4T5T8sCPnCqIT99yNWDSwt7qFh
        stJKJknwKPMHOePk0uTLVgAedqcqgQ6lmWDJKJkjDKohGvMYHoJEUsi8A15+fM3D5/7dmbH
        TfKPnKjCmO9Ge3phYQi4v6PvvbJpUJxAShi8n5IDd0lxB6s4xHOukhq+d4YO1jr3UFzwLYA
        XAa1E/0DiGdVqtStxOwkb43pskkqtTVoqOAXkkWTp22wG5vqQg6/iOx1ZLkYw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8105341843970772384
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de,
        w@1wt.eu
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Date:   Fri, 26 May 2023 19:00:01 +0800
Message-Id: <20230526110001.150368-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <bf3e07c1-75f5-425b-9124-f3f2b230e63a@app.fastmail.com>
References: <bf3e07c1-75f5-425b-9124-f3f2b230e63a@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Arnd

> On Wed, May 24, 2023, at 19:59, Zhangjin Wu wrote:
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index c0335a84f880..00c7197dcd50 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -1041,8 +1041,13 @@ int sys_select(int nfds, fd_set *rfds, fd_set 
> > *wfds, fd_set *efds, struct timeva
> >  		struct timeval *t;
> >  	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
> >  	return my_syscall1(__NR_select, &arg);
> > -#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
> > +#elif defined(__ARCH_WANT_SYS_PSELECT6) && (defined(__NR_pselect6) || 
> > defined(__NR_pselect6_time64))
> > +#ifdef __NR_pselect6
> >  	struct timespec t;
> > +#else
> > +	struct timespec64 t;
> > +#define __NR_pselect6 __NR_pselect6_time64
> > +#endif
> 
> Overriding the __NR_pselect6 constant seems wrong here, this can
> easily lead to more bugs, as pselect6 and pselect6_time64 are
> not compatible because of the different arguments, so anything
> using the constant after including sys.h will be broken.
>

Yes, thanks, Thomas also pointed out this issue in another reply of this
message thread, it has been fixed locally with his suggestion, it looks
like this:

    #ifdef __NR_pselect6
    	struct timespec t;
    	const long nr_pselect = __NR_pselect6;
    #else
    	struct timespec64 t;
    	const long nr_pselect = __NR_pselect6_time64;
    #endif
    
    	if (timeout) {
    		t.tv_sec  = timeout->tv_sec;
    		t.tv_nsec = timeout->tv_usec * 1000;
    	}
    	return my_syscall6(nr_pselect, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);

I have applied this method for ppoll_time64 and clock_gettime64 too,
this method can save several duplicated lines for us, I have prepared v2
patches locally for them. 

> I would just use __kernel_timespec64 unconditionally and then
> use __NR_pselect6_time64 on all 32-bit architectures here,
> but use __NR_pselect6 on 32-bit architectures.
>

The 2nd 32-bit you mean is 64-bit?

This is related to the timespec64/time64_t definitions as you commented
in another reply. I will learn how to use the one from
<linux/time_types.h>, it may require to clean up the existing files in
tools/include/nolibc/ at first.

> I think we can also kill off the oldselect and newselect 
> cases, using pselect6/pselect6_time64 unconditionally here,
> and no longer care about building against pre-5.1 kernel
> headers, at least for the copy of nolibc that ships with the
> kernel.

As Willy commented in another reply, users may want to copy the recent
one and use them with an old kernel, even if want to drop them, a
standalone patch may be preferable.

Thanks very much,
Zhangjin

> 
>      Arnd
