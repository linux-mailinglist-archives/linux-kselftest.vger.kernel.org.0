Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16BA72858B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 18:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjFHQmK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 12:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbjFHQly (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 12:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F830D0;
        Thu,  8 Jun 2023 09:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A64B612F4;
        Thu,  8 Jun 2023 16:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF64C433D2;
        Thu,  8 Jun 2023 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242411;
        bh=8WKaDmccBhu8ZjiDPcthCAQVXl+33lL4IOokkU0hov4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I+XHR4yUJ+GYdTxl3M5ZwWSkS6No+pdrYnW2LYKZ2PG7M73J6+TE8MhEMvfBk54II
         AOnuy+nHqgfMEKqz09U4yG1buKaLaKIB1ie6BBZUeKbDqmspMtFgpzc3VTyTXypjIX
         oswWHWYH1omdOc0+Wp7yX1FdcvTWlPHcIp9XgAGbdKNQvPEl7Sb2vb0Ljl71nfXdPG
         W0Q/4sH/4CuUWhgXKq1q7ze3SfDzHKIuuhBL4xRmY9YEwHSzzAvN94enBGte2p1Hap
         TpLHkZlSpqck4qrSalxfEyGoIo2DvCW1OC8GvYTRm+ohTeeyKSlS31uOIM+NWNXYhR
         vkmCbYNnzqIAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A241CE14DD; Thu,  8 Jun 2023 09:40:11 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:40:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <59affcbb-94e0-49ee-bd53-7aa69fbe3929@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZID0b+nIcypMjV0y@1wt.eu>
 <20230608081337.7546-1-falcon@tinylab.org>
 <ZIGPpYSDQAHaDZP0@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIGPpYSDQAHaDZP0@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 10:21:57AM +0200, Willy Tarreau wrote:
> Hi Zhangjin,
> 
> On Thu, Jun 08, 2023 at 04:13:37PM +0800, Zhangjin Wu wrote:
> > > I rebased the branch on top of 6.4-rc5 and got the same. I'm building
> > > with gcc-11.3.0 from kernel.org. I'm not sure whether this comes from
> > > my build environment or recent changes to the kernel, but I'm sure I
> > > haven't seen that error during 6.3-rc cycle. However, given that
> > > Zhangjin seems to have successfully built it for riscv, there might
> > > be something odd on my side.
> > >
> > 
> > Sorry, The reason is that to speed up the kernel build+nolibc tests, a
> > local small config was customized for the first report,
> 
> You don't have to be sorry for this! The more diversity in configs, the
> more bugs are discovered before they hit users.

And I couldn't agree more!  Again, thank you both!

							Thanx, Paul

> > it may not
> > trigger the above issue, in the later report about the v4 rv32 compile
> > support [1], I did test 'run' target with the default defconfig and
> > reported the same failure as bove, this is the note I pasted there:
> > 
> >   ---
> >   Did compile test for aarch64, rv32 and rv64, include run-user and run.
> > 
> >   Note, this is required with the default config from the
> >   20230606-nolibc-rv32+stkp7a branch of [5]:
> > 
> >     diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >     index ce02bb09651b..72bd8fe0cad6 100644
> >     --- a/kernel/rcu/tasks.h
> >     +++ b/kernel/rcu/tasks.h
> >     @@ -1934,11 +1934,13 @@ void show_rcu_tasks_gp_kthreads(void)
> >      }
> >      #endif /* #ifndef CONFIG_TINY_RCU */
> > 
> >     +#ifdef CONFIG_TASKS_RCU
> >      struct task_struct *get_rcu_tasks_gp_kthread(void)
> >      {
> >             return rcu_tasks.kthread_ptr;
> >      }
> >      EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
> >     +#endif
> > 
> >      #ifdef CONFIG_PROVE_RCU
> >      struct rcu_tasks_test_desc {
> >   ---
> 
> Indeed, I initially didn't make the connection regarding this, because
> you mentioned the fix but not the problem, so I didn't remember to take
> any particular care about this.
> 
> > I have seen Paul have known the cause of the above issue in your later
> > discussion and you found a better solution to avoid such failures,
> > congrats!
> 
> Yes apparently Paul is aware of it so that's all what I wanted to make
> sure of.
> 
> Thanks!
> Willy
> 
> PS: I'll hopefully check your other series later today
