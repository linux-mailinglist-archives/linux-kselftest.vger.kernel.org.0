Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4C790824
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 15:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjIBNxs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjIBNxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 09:53:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22910DE;
        Sat,  2 Sep 2023 06:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 084BAB8275D;
        Sat,  2 Sep 2023 13:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95819C433C8;
        Sat,  2 Sep 2023 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693662821;
        bh=qqFgbQ3SMEkjcNm/Y0rocyIb2NeiYRNTRs0zV0CRaoU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fdvKnvJfY08nuDvHG/3+oGFYgrHQscD9cg3O5jZHeNq0A0rKf7/Tt3njHaVrseklX
         //qDEGYuYUqrWhtISd7AcliVqutRKQt0kKmO2K5NHVIOhViAS4ZN6uUjQio/eLWH5K
         5LA9mWmM5vbaDj1rijYI16uvEReLAPQUwhIp0Kq1mnOAAGZ/FE4vLbsrJwhQNRQWS6
         2Gq1fvW5clFecPOKBpI2Vn49XA4wbrGseBdtMt+XfZ7yMgVnku/yi3fyNSUSlrqotn
         jvlLsL63R+WdPc/BTthhG57XFhdZR7caoR/3anDQFijXqj7zKX30NxtR6kO4l7rdHe
         KuoNGOJU8nuug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2E142CE0F74; Sat,  2 Sep 2023 06:53:41 -0700 (PDT)
Date:   Sat, 2 Sep 2023 06:53:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] rcu/torture: Improve badness extraction from console logs
Message-ID: <7bd77573-ded1-432e-8008-4c1cbe1b9eb9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230831012257.1189964-1-joel@joelfernandes.org>
 <b292cca4-d451-4371-ae2e-9417e0079e84@paulmck-laptop>
 <CAEXW_YRa0Gd2Gt8LagAyOp_8VwT+ra3N4+DBquUNn_Xmo8o7eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRa0Gd2Gt8LagAyOp_8VwT+ra3N4+DBquUNn_Xmo8o7eg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 01, 2023 at 02:04:24PM -0400, Joel Fernandes wrote:
> On Fri, Sep 1, 2023 at 10:49 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Aug 31, 2023 at 01:22:56AM +0000, Joel Fernandes (Google) wrote:
> > > Currently console.log.diags contains an output like follows:
> > > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> > > [ 2457.542385] Call Trace:
> > >
> > > This is not very useful and the Call trace is desired. Improve the
> > > script by Extracting more lines after each grep match.
> > >
> > > With this the above becomes:
> > >
> > > Issue 1:
> > > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> > > [ 2457.326661] Modules linked in:
> > > [ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.128+ #381
> > > [ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [ 2457.373309] RIP: 0010:rcu_tasks_trace_pregp_step+0x4a/0x50
> > > [ 2457.386691] Code: 48 63 c7 48 8b 0
> > > [ 2457.421803] RSP: 0018:ffffa80fc0073e40 EFLAGS: 00010202
> > > [ 2457.431940] RAX: ffff8db91f580000 RBX: 000000000001b900 RCX: 0000000000000003
> > > [ 2457.443206] RDX: 0000000000000008 RSI: ffffffffac6bebd8 RDI: 0000000000000003
> > > [ 2457.454428] RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000001
> > > [ 2457.465668] R10: 0000000000000000 R11: 00000000ffffffff R12: ffff8db902d87f40
> > > [ 2457.476971] R13: ffffffffac556620 R14: ffffffffac556630 R15: ffff8db9011a3200
> > > [ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000) knlGS:0000000000000000
> > > [ 2457.500834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 2457.509602] CR2: 0000000000000000 CR3: 0000000002cbc000 CR4: 00000000000006e0
> > > [ 2457.520378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [ 2457.531440] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [ 2457.542385] Call Trace:
> > > [ 2457.546756]  <TASK>
> > > [ 2457.550349]  ? __warn+0x7b/0x100
> > > [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > > -------------------------------------
> > > Issue 2:
> > > [ 2457.542385] Call Trace:
> > > [ 2457.546756]  <TASK>
> > > [ 2457.550349]  ? __warn+0x7b/0x100
> > > [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > > [ 2457.574948]  ? report_bug+0x99/0xc0
> > > [ 2457.593824]  ? handle_bug+0x3c/0x70
> > > [ 2457.599534]  ? exc_invalid_op+0x13/0x60
> > > [ 2457.625729]  ? asm_exc_invalid_op+0x16/0x20
> > > [ 2457.632249]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > > [ 2457.660010]  rcu_tasks_wait_gp+0x54/0x360
> > > [ 2457.677761]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
> > > [ 2457.705658]  rcu_tasks_kthread+0x114/0x200
> > > [ 2457.712450]  ? wait_woken+0x70/0x70
> > > [ 2457.727283]  ? synchronize_rcu_tasks_rude+0x10/0x10
> > > [ 2457.746221]  kthread+0x130/0x160
> > > [ 2457.751487]  ? set_kthread_struct+0x40/0x40
> > > [ 2457.758178]  ret_from_fork+0x22/0x30
> > > [ 2457.763909]  </TASK>
> > > [ 2457.767546] irq event stamp: 29544441
> > > [ 2457.773344] hardirqs last  enabled at (29544451): [<ffffffffaace6cbd>] __up_console_sem+0x4d/0x60
> > > [ 2457.786967] hardirqs last disabled at (29544460): [<ffffffffaace6ca2>] __up_console_sem+0x32/0x60
> > > -------------------------------------
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Nice!!!
> >
> > One request, though.  If I am reading this correctly, if a console.log
> > file is filled with splats, then console.log.diags will replicate most
> > of console.log.  Could you please limit something, perhaps the number
> > of lines, the number of splats, or some such?
> >
> > Just for context, my use case for the current setup is to run
> > kvm-find-errors.sh, which puts each console.log.diags/console.log pair
> > into my editor.  I copy an appropriate string from the console.log.diags,
> > and then paste that string to search for it in the corresponding
> > console.log file, which is what is edited next.
> 
> I could add a summary on the top for your usecase (which keeps the
> original output), and then the more detailed splats below it. Would
> that work?

That summary would normally be at the top of the file anyway, right?
Either way, what I don't want is many megabytes of splats from console.log
duplicated into console.log.diags, especially in those (admittedly sad)
cases where the console.log file is the largest file in the results
directory.  Are you really going to be reading carefully after (say)
the fifth splat?  ;-)

							Thanx, Paul

> So the whole file would look something like:
> =====x8==========
> Summary of console.log lines showing issues:
> Line 300: [ 2457.293734] WARNING: CPU: 2 PID: 13 at
> kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> Line 400:[ 2457.542385] Call Trace:
> 
> Detailed list of issues:
> 1. Issue on line 300:
> [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061
> rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.326661] Modules linked in:
> [ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.128+ #381
> [ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 2457.373309] RIP: 0010:rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.386691] Code: 48 63 c7 48 8b 0
> [ 2457.421803] RSP: 0018:ffffa80fc0073e40 EFLAGS: 00010202
> [ 2457.431940] RAX: ffff8db91f580000 RBX: 000000000001b900 RCX: 0000000000000003
> [ 2457.443206] RDX: 0000000000000008 RSI: ffffffffac6bebd8 RDI: 0000000000000003
> [ 2457.454428] RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000001
> [ 2457.465668] R10: 0000000000000000 R11: 00000000ffffffff R12: ffff8db902d87f40
> [ 2457.476971] R13: ffffffffac556620 R14: ffffffffac556630 R15: ffff8db9011a3200
> [ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000)
> knlGS:0000000000000000
> [ 2457.500834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2457.509602] CR2: 0000000000000000 CR3: 0000000002cbc000 CR4: 00000000000006e0
> [ 2457.520378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2457.531440] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2457.542385] Call Trace:
> [ 2457.546756]  <TASK>
> [ 2457.550349]  ? __warn+0x7b/0x100
> [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> -------------------------------------
> 2. Issue on Line 500:
> [ 2457.542385] Call Trace:
> [ 2457.546756]  <TASK>
> [ 2457.550349]  ? __warn+0x7b/0x100
> [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.574948]  ? report_bug+0x99/0xc0
> [ 2457.593824]  ? handle_bug+0x3c/0x70
> [ 2457.599534]  ? exc_invalid_op+0x13/0x60
> [ 2457.625729]  ? asm_exc_invalid_op+0x16/0x20
> [ 2457.632249]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> [ 2457.660010]  rcu_tasks_wait_gp+0x54/0x360
> [ 2457.677761]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
> [ 2457.705658]  rcu_tasks_kthread+0x114/0x200
> [ 2457.712450]  ? wait_woken+0x70/0x70
> [ 2457.727283]  ? synchronize_rcu_tasks_rude+0x10/0x10
> [ 2457.746221]  kthread+0x130/0x160
> [ 2457.751487]  ? set_kthread_struct+0x40/0x40
> [ 2457.758178]  ret_from_fork+0x22/0x30
> [ 2457.763909]  </TASK>
> [ 2457.767546] irq event stamp: 29544441
> [ 2457.773344] hardirqs last  enabled at (29544451):
> [<ffffffffaace6cbd>] __up_console_sem+0x4d/0x60
> [ 2457.786967] hardirqs last disabled at (29544460):
> [<ffffffffaace6ca2>] __up_console_sem+0x32/0x60
> -------------------------------------
> =====x8==========>
