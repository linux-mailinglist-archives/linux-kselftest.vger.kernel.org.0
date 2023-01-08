Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7C661853
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 19:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAHStr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 13:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjAHStn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 13:49:43 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E1A1EE23;
        Sun,  8 Jan 2023 10:49:40 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 308InU0f021062;
        Sun, 8 Jan 2023 19:49:30 +0100
Date:   Sun, 8 Jan 2023 19:49:30 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] nolibc signal handling support
Message-ID: <20230108184930.GC18859@1wt.eu>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
 <20230108175842.GB18859@1wt.eu>
 <Y7sL9U1dYkuWJ8rS@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7sL9U1dYkuWJ8rS@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 09, 2023 at 01:31:17AM +0700, Ammar Faizi wrote:
> >   - riscv and mips build are now broken:
> >       sysroot/riscv/include/sys.h:1110:18: error: 'struct sigaction' has no member named 'sa_restorer'
> >        1110 |         if (!act2.sa_restorer) {
> >             |                  ^
> >       sysroot/riscv/include/sys.h:1111:34: error: 'SA_RESTORER' undeclared (first use in this function); did you mean 'SA_RESTART'?
> >        1111 |                 act2.sa_flags |= SA_RESTORER;
> >             |                                  ^~~~~~~~~~~
> >             |                                  SA_RESTART
> 
> Just a speculation:
> This is probably because not all architectures have a SA_RESTORER. I'll
> need to figure out how Linux handles signal on those architectures.

Yes that's the case, there's even some ifdef around it in the generic
code. I have no idea how it works there, at least it seems worth having
a look to make sure we don't miss something easy.

> >   - s390 segfaults:
> >       58 select_fault = -1 EFAULT              [OK]
> >       59 sigactionqemu: uncaught target signal 11 (Segmentation fault) - core dumped
> >       Segmentation fault
> > 
> >     It dies in __restore_rt at 1006ba4 while performing the syscall,
> >     I don't know why, maybe this arch requires an alt stack or whatever :
> > 
> >       0000000001006ba0 <__restore_rt>:
> >        1006ba0:       a7 19 00 ad             lghi    %r1,173
> >        1006ba4:       0a 00                   svc     0
> >        1006ba6:       07 07                   nopr    %r7
> 
> Bah, no clue on this. I'll CC s390 people in the next version and ask
> them to shed some light.

OK.

> I'll be pondering this code this week (to follow what actually the
> rt_sigaction wants on i386 and arm):
> 
>   https://github.com/torvalds/linux/blob/v6.2-rc3/kernel/signal.c#L4404-L4434

Seems like it could simply be a matter of sigsetsize, which is the
first one returning -EINVAL.

> Hopefully, I can get it sorted before the weekend.

OK!

> > I also think that the printf() in test_sigaction_sig() are not welcome
> > as they corrupt the output. Maybe one thing you could do to preserve the
> > info would be to prepend a space in front of the message and remove the
> > LF. For example the simple patch below:
> [...]
> > Which is way more readable and still grep-friendly.
> 
> Yeah, that looks much better. Applied to my local git tree with
> attribution.

Don't worry with attribution for such patches from me. I'd rather see
the first patch looking good at once than having an extra one change
the output just for the sake of attribution! It was just a suggestion
anyway and whatever solution you find that improves the output will be
fine.

Thank you!
Willy
