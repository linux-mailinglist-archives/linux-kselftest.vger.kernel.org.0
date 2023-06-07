Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247C727287
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 00:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFGW6F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFGW6E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 18:58:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0630172E;
        Wed,  7 Jun 2023 15:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B8C96155F;
        Wed,  7 Jun 2023 22:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0E3C433D2;
        Wed,  7 Jun 2023 22:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686178681;
        bh=A0HX1RU1GSuXaRTz85AGqKCyQ3aEmW4bTVShh6uh+us=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u654hnPOwu3yv0r5oPOC05geLIuaqYHTSGEfNn+S98AuqAiF41Xfeu1NNbTjrMMBz
         T9zh8zKmyAaxcyDFD+xyvW1vHp2jNsupflM5zNzcPuf5x0e0tC6AeMNud7lHnvvwQf
         FP614UxphJJSbQGRac5rJPG0cN2+WJ7sIMbn4A8CqZ9JKUGB7TMjZsqKRlQSQOUcsw
         W0yYDnBXbNwG1EhR/gok8UJz0jSLlnKw2cF1TRatrRgr8SPmzC8Yyt+6x4qt3h9BG+
         3VkxUJ+CBDI81ucXlo6BUT9h7XU+Y5TZhulPYrifH3kammVfyobhl5E2okvzP3s2J0
         n05Yll5tCp+MQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 44B77CE3A6C; Wed,  7 Jun 2023 15:58:01 -0700 (PDT)
Date:   Wed, 7 Jun 2023 15:58:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <66c0e446-846c-47a6-ab60-948dc0118cec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
 <5494ac68-b4b9-434f-92c1-7e197c92a4ab@paulmck-laptop>
 <ZID0b+nIcypMjV0y@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZID0b+nIcypMjV0y@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 07, 2023 at 11:19:43PM +0200, Willy Tarreau wrote:
> Hello Paul,
> 
> On Sun, Jun 04, 2023 at 03:57:54PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 04, 2023 at 03:20:11PM +0200, Willy Tarreau wrote:
> > > Hello Paul,
> > > 
> > > Thomas and Zhangjin have provided significant nolibc cleanups, and
> > > fixes, as well as preparation work to later support riscv32.
> > > 
> > > These consist in the following main series:
> > >   - generalization of stackprotector to other archs that were not
> > >     previously supported (riscv, mips, loongarch, arm, arm64)
> > > 
> > >   - general cleanups of the makefile, test report output, deduplication
> > >     of certain tests
> > > 
> > >   - slightly better compliance of some tests performed on certain syscalls
> > >     (e.g. no longer pass (void*)1 to gettimeofday() since glibc hates it).
> > > 
> > >   - add support for nanoseconds in stat() and statx()
> > > 
> > >   - fixes for some syscalls (e.g. ppoll() has 5 arguments not 4)
> > > 
> > >   - fixes around limits.h and  INT_MAX / INT_FAST64_MAX
> > > 
> > > I rebased the whole series on top of your latest dev branch (d19a9ca3d5)
> > > and it works fine for all archs.
> > > 
> > > I don't know if you're still planning on merging new stuff in this area
> > > for 6.5 or not (since I know that it involves new series of tests on your
> > > side as well), but given that Zhangjin will engage into deeper changes
> > > later for riscv32 that will likely imply to update more syscalls to use
> > > the time64 ones, I would prefer to split the cleanups from the hard stuff,
> > > but I'll let you judge based on the current state of what's pending for
> > > 6.5.
> > > 
> > > In any case I'm putting all this here for now (not for merge yet):
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git 20230604-nolibc-rv32+stkp6
> > > 
> > > I'd like Thomas and Zhangjin to perform a last check to confirm they're
> > > OK with this final integration.
> > 
> > Given that the testing converges by the end of this week, I can't see
> > any reason why these cannot make v6.5.  (There were some kernel test
> > robot complaints as well, valid or not I am not sure.)
> 
> After Thomas' and Zhangjin's reviews and checks, I could run a mostly
> complete check:
>   - arm64, i386, x86_64 show 100% success
>   - arm, mips: 100% success, stackprotector skipped
>   - s390x, riscv64: run-user OK, kernel build fails (see below)
>   - loongarch: build OK, just not executed (need to upgrade my qemu
>     and I hate doing it late when some tests results are needed)

Very good!

> Regarding the build failure affecting s390x and riscv64, it's a regular
> kernel resulting from "make defconfig". For both archs, I'm getting this
> failure:
> 
>   In file included from kernel/rcu/update.c:649:
>   kernel/rcu/tasks.h: In function 'get_rcu_tasks_gp_kthread':
>     CC      fs/kernfs/dir.o
>     CC      security/bpf/hooks.o
>   kernel/rcu/tasks.h:1939:16: error: 'rcu_tasks' undeclared (first use in this function)
>    1939 |         return rcu_tasks.kthread_ptr;
>         |                ^~~~~~~~~
>   kernel/rcu/tasks.h:1939:16: note: each undeclared identifier is reported only once for each function it appears in
>   kernel/rcu/tasks.h:1940:1: error: control reaches end of non-void function [-Werror=return-type]
>    1940 | }
>         | ^
>   cc1: some warnings being treated as errors
> 
> I rebased the branch on top of 6.4-rc5 and got the same. I'm building
> with gcc-11.3.0 from kernel.org. I'm not sure whether this comes from
> my build environment or recent changes to the kernel, but I'm sure I
> haven't seen that error during 6.3-rc cycle. However, given that
> Zhangjin seems to have successfully built it for riscv, there might
> be something odd on my side.

That line of code is in rcu/dev but not in mainline yet.  In fact, it
is not yet in -next.

But it is a bug.  One that my Kconfig laziness hid from me.  Easy fix,
but it is clearly time for me to stop being lazy about that part of the
Kconfig setup.  :-/

So thank you for reporting it!

> Given that this build issue is not dependent on the selftest, I'm fine
> with the branch getting merged as-is, and can provide feedback on this
> build error if needed:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git 20230606-nolibc-rv32+stkp7a
> 
> Just let me know if you prefer that I resend the whole series or need
> more info etc, as usual.

I will pull it from your tree, test it, and if all goes well, rebase it
on my existing nolibc stack.

Longer term, both to avoid you having to deal with RCU bugs and to make
it easier to have multiple administrative nolibc maintainers, it might
work better for you to base your stack on vX.y-rc1.  That way, I could
just pull directly from your tree.

This works because you buffer up the commits and test them, which
makes it completely reasonable for me to simply pull your new stack
and merge them in.  Which also means that if there are multiple nolibc
administrative maintainers, we have exactly the same set of nolibc
commits in our respective trees, right down to the SHA-1 hashes.

This approach is used a lot, for example, back when my RCU patches
went through Ingo Molnar, he pulled from my tree so that mainline's RCU
patches were identical to mine, again, right down to the SHA-1 hashes.

This is something to think about for some upcoming cycle, given that
we are already pretty much set up for the upcoming merge window.

Your choice, either way works for me.

							Thanx, Paul
