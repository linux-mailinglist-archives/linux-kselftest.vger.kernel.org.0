Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89C972857E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjFHQl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjFHQko (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1630930E8;
        Thu,  8 Jun 2023 09:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25B5264F38;
        Thu,  8 Jun 2023 16:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B420C4339B;
        Thu,  8 Jun 2023 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242370;
        bh=Cf3z+nnUaW3W8zmLq/SrMFZhb/6KU25y6zFdgoiD08c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cegBkSvL0OG4VmYS2DkPbih7pnNhDyzJ/f3xab3ysTxVpdgndRfBNpG4cG5wvS7FK
         erZMiCxFySVANo+w1HHTA7AqRn+alVmIPf1mWS15ypnF9sm61N9NvweI/9HyTdnJTE
         4Y5x4b7RoUCv3j35z9vqzINmLqsj4IK6yQzHq3U7cdV9KmCRyLuo7YG+/5oq0fz7qz
         OqQ+YonasyOFalTRRUz+UbF8ePCQWEwmhHiEBW1aPtCVteZMcN3M3KOGB4lQz0pzOR
         vrCqvxjJEAuLftJha/5XSE82kPz6ZfupAa3KtewwRnuDamkvvoy8XbT2LmPzAwYjaQ
         wsAGb/waic7pQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 297E9CE14DD; Thu,  8 Jun 2023 09:39:30 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:39:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <9dab59c7-a562-446d-94cf-39e4d40423c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZHyPi29q3MKiNAQZ@1wt.eu>
 <5494ac68-b4b9-434f-92c1-7e197c92a4ab@paulmck-laptop>
 <ZID0b+nIcypMjV0y@1wt.eu>
 <66c0e446-846c-47a6-ab60-948dc0118cec@paulmck-laptop>
 <ZIFa0Y7GIN0S/T6q@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFa0Y7GIN0S/T6q@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 06:36:33AM +0200, Willy Tarreau wrote:
> On Wed, Jun 07, 2023 at 03:58:01PM -0700, Paul E. McKenney wrote:
> > > Regarding the build failure affecting s390x and riscv64, it's a regular
> > > kernel resulting from "make defconfig". For both archs, I'm getting this
> > > failure:
> > > 
> > >   In file included from kernel/rcu/update.c:649:
> > >   kernel/rcu/tasks.h: In function 'get_rcu_tasks_gp_kthread':
> > >     CC      fs/kernfs/dir.o
> > >     CC      security/bpf/hooks.o
> > >   kernel/rcu/tasks.h:1939:16: error: 'rcu_tasks' undeclared (first use in this function)
> > >    1939 |         return rcu_tasks.kthread_ptr;
> > >         |                ^~~~~~~~~
> > >   kernel/rcu/tasks.h:1939:16: note: each undeclared identifier is reported only once for each function it appears in
> > >   kernel/rcu/tasks.h:1940:1: error: control reaches end of non-void function [-Werror=return-type]
> > >    1940 | }
> > >         | ^
> > >   cc1: some warnings being treated as errors
> > > 
> > > I rebased the branch on top of 6.4-rc5 and got the same. I'm building
> > > with gcc-11.3.0 from kernel.org. I'm not sure whether this comes from
> > > my build environment or recent changes to the kernel, but I'm sure I
> > > haven't seen that error during 6.3-rc cycle. However, given that
> > > Zhangjin seems to have successfully built it for riscv, there might
> > > be something odd on my side.
> > 
> > That line of code is in rcu/dev but not in mainline yet.  In fact, it
> > is not yet in -next.
> > 
> > But it is a bug.  One that my Kconfig laziness hid from me.  Easy fix,
> > but it is clearly time for me to stop being lazy about that part of the
> > Kconfig setup.  :-/
> > 
> > So thank you for reporting it!
> 
> Great, I'm happy that it cuold be used to spot a real bug ;-)
> 
> > Longer term, both to avoid you having to deal with RCU bugs and to make
> > it easier to have multiple administrative nolibc maintainers, it might
> > work better for you to base your stack on vX.y-rc1.  That way, I could
> > just pull directly from your tree.
> (...)
> > This is something to think about for some upcoming cycle, given that
> > we are already pretty much set up for the upcoming merge window.
> 
> Yes I think it makes sense now. Initially tiny changes had implications
> on rcutorture and needed to be properly sequenced but that's no longer
> the case and we can indeed simplify this. And it will force us to gather
> all patches in one single series, which is also easier to review/discuss.
> 
> So that works for me.

Very good!

Actually, in theory, I could replace my current stack with a direct
pull of your stack and get a head start on this process.  Let me see
how I feel about making this switch on Monday.  ;-)

							Thanx, Paul
