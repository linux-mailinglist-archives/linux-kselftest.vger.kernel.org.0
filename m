Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C62657732
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiL1Nfj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Dec 2022 08:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiL1Nfi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Dec 2022 08:35:38 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1EB6F5B9;
        Wed, 28 Dec 2022 05:35:33 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BSDZEBE007517;
        Wed, 28 Dec 2022 14:35:14 +0100
Date:   Wed, 28 Dec 2022 14:35:14 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
Message-ID: <20221228133513.GA7457@1wt.eu>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu>
 <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu>
 <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
 <20221227184902.GA6287@1wt.eu>
 <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 28, 2022 at 07:01:36PM +0700, Ammar Faizi wrote:
> On 12/28/22 1:49 AM, Willy Tarreau wrote:
> > I'll try to do it but do not want to make you wait too long in case it
> > gets delayed. In the worst case we should only postpone the getauxval()
> > patch and not the other ones.
> 
> I will split it into 2 patchset then.

OK thanks!

I've pushed for you an update which starts to do what I proposed. Errno
and environ are now marked weak for all archs, and _auxv is set for i386,
x86_64, arm64 and arm for now:

   https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/log/?h=20221227-nolibc-weak-2

You can already use it to implement getauxval(), it will normally work
for these archs.

> > BTW, do you think your arch-specific changes for sigaction() will be
> > easily portable to other architectures ? I feel a bit wary of starting
> > to have different features per architecture given the purpose of the
> > lib, so the more uniform the coverage the better.
> 
> The 'rt_sigaction()' itself doesn't seem to be an arch specific, but
> the way it resumes the execution needs to call 'rt_sigreturn()' which
> is arch specific. I took a look at the kernel source code, most
> architectures read 'struct rt_sigframe' from the stack pointer.
> 
> https://github.com/torvalds/linux/blob/631aa744423173bf921191ba695bbc7c1aabd9e0/arch/x86/kernel/signal_32.c#L145
> https://github.com/torvalds/linux/blob/631aa744423173bf921191ba695bbc7c1aabd9e0/arch/x86/kernel/signal_64.c#L243-L271
> https://github.com/torvalds/linux/blob/a6b450573b912316ad36262bfc70e7c3870c56d1/arch/arm64/kernel/signal.c#L668-L699
> https://github.com/torvalds/linux/blob/a6b450573b912316ad36262bfc70e7c3870c56d1/arch/arm64/kernel/signal32.c#L259
> https://github.com/torvalds/linux/blob/eb67d239f3aa1711afb0a42eab50459d9f3d672e/arch/riscv/kernel/signal.c#L101
> 
> On the x86-64 arch, the implementation is just like this:
> 
>    __arch_restore_rt:
>        #
>        # ((%rsp - sizeof(long)) must point to 'struct rt_sigframe')
>        #
>        # 'struct rt_sigframe' is automatically constructed by
>        # the kernel when a signal is caught.
>        #
>        movl       $0xf, %eax // __NR_rt_sigreturn == 0xf
>        syscall

I think we could avoid the asm specific stuff is we get rid of the frame
pointer. Please look below:

  __attribute__((weak,unused,noreturn,optimize("omit-frame-pointer"),section(".text.nolibc_rt_sigreturn")))
  void sys_rt_sigreturn()
  {
        my_syscall0(__NR_rt_sigreturn);
        __builtin_unreachable();
  }

It gives me the correct code for x86_64 and i586. I don't know if other
architectures will want to add a prologue. I tried with "naked" but it's
ignored by the compiler since the function is not purely asm. Not very
important but given that we already have everything to perform our calls
it would make sense to stay on this. By the way, for the sake of
consistency with other syscalls, I do think the function (or label if
we can't do otherwise) should be called "sys_rt_sigreturn" as it just
performs a syscall.

> I believe aarch64 and RISCV don't behave differently, but different
> registers.
> 
> Not sure what PowerPC does here, it seems a bit different:
> https://github.com/torvalds/linux/blob/1612c382ffbdf1f673caec76502b1c00e6d35363/arch/powerpc/kernel/signal_64.c#L744

It looks similar to me, it's just that the kernel side differs but I
think it's the same.

> I haven't taken a look at other archs.
> 
> What do you think? Is it affordable for nolibc to implement all of
> these?

Yes I think so. I suspect that we might need to have a few arch-specific
implementations, but we've already had this case a few times and we could
easily use a pair of #define/#ifdef to skip the generic version.

Best regards,
Willy
