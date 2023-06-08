Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A5F7279DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjFHIWh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjFHIWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 04:22:34 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B64D42D50;
        Thu,  8 Jun 2023 01:22:20 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3588Lvgt017749;
        Thu, 8 Jun 2023 10:21:57 +0200
Date:   Thu, 8 Jun 2023 10:21:57 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        paulmck@kernel.org, thomas@t-8ch.de
Subject: Re: nolibc patches, still possible for 6.5 ?
Message-ID: <ZIGPpYSDQAHaDZP0@1wt.eu>
References: <ZID0b+nIcypMjV0y@1wt.eu>
 <20230608081337.7546-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608081337.7546-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Thu, Jun 08, 2023 at 04:13:37PM +0800, Zhangjin Wu wrote:
> > I rebased the branch on top of 6.4-rc5 and got the same. I'm building
> > with gcc-11.3.0 from kernel.org. I'm not sure whether this comes from
> > my build environment or recent changes to the kernel, but I'm sure I
> > haven't seen that error during 6.3-rc cycle. However, given that
> > Zhangjin seems to have successfully built it for riscv, there might
> > be something odd on my side.
> >
> 
> Sorry, The reason is that to speed up the kernel build+nolibc tests, a
> local small config was customized for the first report,

You don't have to be sorry for this! The more diversity in configs, the
more bugs are discovered before they hit users.

> it may not
> trigger the above issue, in the later report about the v4 rv32 compile
> support [1], I did test 'run' target with the default defconfig and
> reported the same failure as bove, this is the note I pasted there:
> 
>   ---
>   Did compile test for aarch64, rv32 and rv64, include run-user and run.
> 
>   Note, this is required with the default config from the
>   20230606-nolibc-rv32+stkp7a branch of [5]:
> 
>     diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>     index ce02bb09651b..72bd8fe0cad6 100644
>     --- a/kernel/rcu/tasks.h
>     +++ b/kernel/rcu/tasks.h
>     @@ -1934,11 +1934,13 @@ void show_rcu_tasks_gp_kthreads(void)
>      }
>      #endif /* #ifndef CONFIG_TINY_RCU */
> 
>     +#ifdef CONFIG_TASKS_RCU
>      struct task_struct *get_rcu_tasks_gp_kthread(void)
>      {
>             return rcu_tasks.kthread_ptr;
>      }
>      EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
>     +#endif
> 
>      #ifdef CONFIG_PROVE_RCU
>      struct rcu_tasks_test_desc {
>   ---

Indeed, I initially didn't make the connection regarding this, because
you mentioned the fix but not the problem, so I didn't remember to take
any particular care about this.

> I have seen Paul have known the cause of the above issue in your later
> discussion and you found a better solution to avoid such failures,
> congrats!

Yes apparently Paul is aware of it so that's all what I wanted to make
sure of.

Thanks!
Willy

PS: I'll hopefully check your other series later today
