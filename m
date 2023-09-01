Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBB87901E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjIASEk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjIASEk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 14:04:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B645A1
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Sep 2023 11:04:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so39330241fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Sep 2023 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693591475; x=1694196275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPCcILmodCmzC81NrNUpk7d58EIaTYj4JLqeve+5bUk=;
        b=lJMacV3GqclRhFpdmUHUre4+MRSgXHzmvcJlHeiFVOJXVJFoXqqdlYauIa123FJsL5
         UEZ3Vh36LH1bgvQwQVykQbjpWR3cwNAm2daOt1COC9YKGBVr0lsnQaYYmpObLvBd/lcP
         By+/lJ/DoxvZGPvu6BSDZESPPYn64o03iP9NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693591475; x=1694196275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPCcILmodCmzC81NrNUpk7d58EIaTYj4JLqeve+5bUk=;
        b=Q/Hk8L5m1IxBzdqvsREcslflO+uqq9QFUwd3Ys2nR9lUIlX+zxyceGTQGsY87EDy0M
         Tk/ROEKN/vKWbTxz8a7aY7nRltkAtFwFzR6+W0FkxJn9FEVIZxJ3zpEkzIA5p4PpEbsV
         c6voRsLRT7/r9mfqKVI6ygRzjyNnKQPVyn2QYLG3W5DDDvcfeXHvJDCNp7fUyI0HyNZI
         mQi3z5svo5QiNL1EeQTcOGB+UATo1j2vy7L3He5Wiow8jAcDb+My3M0cUBsAEzj4DaN1
         LBuQft1lbYMbL8mEl4gtrUSoeG/fXHeCyFbeGQXZsPaB2ZJXBo10/mcPZ3i0yyziWqFP
         KYkw==
X-Gm-Message-State: AOJu0YwH8WFYpvmZeoW9uGZrmeOevzO9Uh5R1RB/h2AaNoSs/izqvCcF
        Rrt1AFvIsvU6FiKEl8fzs6a9S9rcoRSYcRb7EmaVCg==
X-Google-Smtp-Source: AGHT+IFwRCHJ6DpziLroGX7BYGQM91nXpYJdQnwQc2XdCGhIrJUUGmBA2jbVvYa1IPP/d7BLbmSz1fwFmloldyiDbKs=
X-Received: by 2002:a05:651c:102d:b0:2bb:9fcf:6f56 with SMTP id
 w13-20020a05651c102d00b002bb9fcf6f56mr2191334ljm.22.1693591475082; Fri, 01
 Sep 2023 11:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230831012257.1189964-1-joel@joelfernandes.org> <b292cca4-d451-4371-ae2e-9417e0079e84@paulmck-laptop>
In-Reply-To: <b292cca4-d451-4371-ae2e-9417e0079e84@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 1 Sep 2023 14:04:24 -0400
Message-ID: <CAEXW_YRa0Gd2Gt8LagAyOp_8VwT+ra3N4+DBquUNn_Xmo8o7eg@mail.gmail.com>
Subject: Re: [PATCH] rcu/torture: Improve badness extraction from console logs
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 1, 2023 at 10:49=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Aug 31, 2023 at 01:22:56AM +0000, Joel Fernandes (Google) wrote:
> > Currently console.log.diags contains an output like follows:
> > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_t=
asks_trace_pregp_step+0x4a/0x50
> > [ 2457.542385] Call Trace:
> >
> > This is not very useful and the Call trace is desired. Improve the
> > script by Extracting more lines after each grep match.
> >
> > With this the above becomes:
> >
> > Issue 1:
> > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 rcu_t=
asks_trace_pregp_step+0x4a/0x50
> > [ 2457.326661] Modules linked in:
> > [ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.12=
8+ #381
> > [ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 2457.373309] RIP: 0010:rcu_tasks_trace_pregp_step+0x4a/0x50
> > [ 2457.386691] Code: 48 63 c7 48 8b 0
> > [ 2457.421803] RSP: 0018:ffffa80fc0073e40 EFLAGS: 00010202
> > [ 2457.431940] RAX: ffff8db91f580000 RBX: 000000000001b900 RCX: 0000000=
000000003
> > [ 2457.443206] RDX: 0000000000000008 RSI: ffffffffac6bebd8 RDI: 0000000=
000000003
> > [ 2457.454428] RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000=
000000001
> > [ 2457.465668] R10: 0000000000000000 R11: 00000000ffffffff R12: ffff8db=
902d87f40
> > [ 2457.476971] R13: ffffffffac556620 R14: ffffffffac556630 R15: ffff8db=
9011a3200
> > [ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000) kn=
lGS:0000000000000000
> > [ 2457.500834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 2457.509602] CR2: 0000000000000000 CR3: 0000000002cbc000 CR4: 0000000=
0000006e0
> > [ 2457.520378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 2457.531440] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 2457.542385] Call Trace:
> > [ 2457.546756]  <TASK>
> > [ 2457.550349]  ? __warn+0x7b/0x100
> > [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > -------------------------------------
> > Issue 2:
> > [ 2457.542385] Call Trace:
> > [ 2457.546756]  <TASK>
> > [ 2457.550349]  ? __warn+0x7b/0x100
> > [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > [ 2457.574948]  ? report_bug+0x99/0xc0
> > [ 2457.593824]  ? handle_bug+0x3c/0x70
> > [ 2457.599534]  ? exc_invalid_op+0x13/0x60
> > [ 2457.625729]  ? asm_exc_invalid_op+0x16/0x20
> > [ 2457.632249]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > [ 2457.660010]  rcu_tasks_wait_gp+0x54/0x360
> > [ 2457.677761]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
> > [ 2457.705658]  rcu_tasks_kthread+0x114/0x200
> > [ 2457.712450]  ? wait_woken+0x70/0x70
> > [ 2457.727283]  ? synchronize_rcu_tasks_rude+0x10/0x10
> > [ 2457.746221]  kthread+0x130/0x160
> > [ 2457.751487]  ? set_kthread_struct+0x40/0x40
> > [ 2457.758178]  ret_from_fork+0x22/0x30
> > [ 2457.763909]  </TASK>
> > [ 2457.767546] irq event stamp: 29544441
> > [ 2457.773344] hardirqs last  enabled at (29544451): [<ffffffffaace6cbd=
>] __up_console_sem+0x4d/0x60
> > [ 2457.786967] hardirqs last disabled at (29544460): [<ffffffffaace6ca2=
>] __up_console_sem+0x32/0x60
> > -------------------------------------
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Nice!!!
>
> One request, though.  If I am reading this correctly, if a console.log
> file is filled with splats, then console.log.diags will replicate most
> of console.log.  Could you please limit something, perhaps the number
> of lines, the number of splats, or some such?
>
> Just for context, my use case for the current setup is to run
> kvm-find-errors.sh, which puts each console.log.diags/console.log pair
> into my editor.  I copy an appropriate string from the console.log.diags,
> and then paste that string to search for it in the corresponding
> console.log file, which is what is edited next.

I could add a summary on the top for your usecase (which keeps the
original output), and then the more detailed splats below it. Would
that work?

So the whole file would look something like:
=3D=3D=3D=3D=3Dx8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary of console.log lines showing issues:
Line 300: [ 2457.293734] WARNING: CPU: 2 PID: 13 at
kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
Line 400:[ 2457.542385] Call Trace:

Detailed list of issues:
1. Issue on line 300:
[ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061
rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.326661] Modules linked in:
[ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.128+ #=
381
[ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2457.373309] RIP: 0010:rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.386691] Code: 48 63 c7 48 8b 0
[ 2457.421803] RSP: 0018:ffffa80fc0073e40 EFLAGS: 00010202
[ 2457.431940] RAX: ffff8db91f580000 RBX: 000000000001b900 RCX: 00000000000=
00003
[ 2457.443206] RDX: 0000000000000008 RSI: ffffffffac6bebd8 RDI: 00000000000=
00003
[ 2457.454428] RBP: 0000000000000004 R08: 0000000000000001 R09: 00000000000=
00001
[ 2457.465668] R10: 0000000000000000 R11: 00000000ffffffff R12: ffff8db902d=
87f40
[ 2457.476971] R13: ffffffffac556620 R14: ffffffffac556630 R15: ffff8db9011=
a3200
[ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000)
knlGS:0000000000000000
[ 2457.500834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2457.509602] CR2: 0000000000000000 CR3: 0000000002cbc000 CR4: 00000000000=
006e0
[ 2457.520378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2457.531440] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2457.542385] Call Trace:
[ 2457.546756]  <TASK>
[ 2457.550349]  ? __warn+0x7b/0x100
[ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
-------------------------------------
2. Issue on Line 500:
[ 2457.542385] Call Trace:
[ 2457.546756]  <TASK>
[ 2457.550349]  ? __warn+0x7b/0x100
[ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.574948]  ? report_bug+0x99/0xc0
[ 2457.593824]  ? handle_bug+0x3c/0x70
[ 2457.599534]  ? exc_invalid_op+0x13/0x60
[ 2457.625729]  ? asm_exc_invalid_op+0x16/0x20
[ 2457.632249]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
[ 2457.660010]  rcu_tasks_wait_gp+0x54/0x360
[ 2457.677761]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
[ 2457.705658]  rcu_tasks_kthread+0x114/0x200
[ 2457.712450]  ? wait_woken+0x70/0x70
[ 2457.727283]  ? synchronize_rcu_tasks_rude+0x10/0x10
[ 2457.746221]  kthread+0x130/0x160
[ 2457.751487]  ? set_kthread_struct+0x40/0x40
[ 2457.758178]  ret_from_fork+0x22/0x30
[ 2457.763909]  </TASK>
[ 2457.767546] irq event stamp: 29544441
[ 2457.773344] hardirqs last  enabled at (29544451):
[<ffffffffaace6cbd>] __up_console_sem+0x4d/0x60
[ 2457.786967] hardirqs last disabled at (29544460):
[<ffffffffaace6ca2>] __up_console_sem+0x32/0x60
-------------------------------------
=3D=3D=3D=3D=3Dx8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
