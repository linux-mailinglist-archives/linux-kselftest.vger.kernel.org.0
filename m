Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F4790926
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 20:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjIBS27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIBS26 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 14:28:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE4DE54
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Sep 2023 11:28:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so1502731fa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Sep 2023 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693679333; x=1694284133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06p62t6o9hfHUen6wuw+drhS9gztrUu2prO6a60vonk=;
        b=GIlaWzOp+WT00/AM/F2bAFNawLfA4aaQbaBfSoLLefcayuKRnG3P/RB8IPWIHrkB1a
         QgfKAqEFzbu4qfiX9hqnEmQOER+N7kokD0eDZassYFpr0cQJXEmjQv+2Bl8VlbWt6TN1
         NEQGxax/BATpPg3QAo4HQ85xuNOuGUZbqtxZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693679333; x=1694284133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06p62t6o9hfHUen6wuw+drhS9gztrUu2prO6a60vonk=;
        b=axhT/icSJY0SPrjUowlbbue/avozx2fzEaqltibZQ0s6Y1krdLBcfIh5Ae6f0R2/ny
         vQOhaK0/FKkd/ouAtXWAsHXO4STZOilHAtxefPnd3Tq8fCp2Xty07GLI/eMWhB3J8Cc+
         tQb7mNJIOKzlvHJ17Vv4Kufhq2mH7Z3AMTIanevXDrZKv1x2+2R5fvBI6R1gnnkrDbGD
         MDoS/24cv7TtK//JX8QGy6cMRY34PcjW1QXhrphh12MJbXQ9oxDSKRQOySF66zfklKY3
         pDPK3jwu+gJZbkRLehu+uo5/jrDCn6HTidr17JXKwYivUktWQlEJWM/irIL4yE7UckDN
         uQow==
X-Gm-Message-State: AOJu0YyYjc9Qs85aLwzZNAivDzovjSkvk6vmVaLTS/SXzPo8Mtue+KsA
        SztL6OzuSKZi9AYA8hKJrZbZgZz/gfUV1owMJs4/hA==
X-Google-Smtp-Source: AGHT+IEgMf52dbVI4u5JSa+pu7/zksdzK14ddOYJl1O2eloPm60PB2BwX4QSCPm/t6xSIsggFRuXCsazD0/WVjjeIq4=
X-Received: by 2002:a2e:7304:0:b0:2bc:d6a8:1efd with SMTP id
 o4-20020a2e7304000000b002bcd6a81efdmr4170974ljc.39.1693679332575; Sat, 02 Sep
 2023 11:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230831012257.1189964-1-joel@joelfernandes.org>
 <b292cca4-d451-4371-ae2e-9417e0079e84@paulmck-laptop> <CAEXW_YRa0Gd2Gt8LagAyOp_8VwT+ra3N4+DBquUNn_Xmo8o7eg@mail.gmail.com>
 <7bd77573-ded1-432e-8008-4c1cbe1b9eb9@paulmck-laptop>
In-Reply-To: <7bd77573-ded1-432e-8008-4c1cbe1b9eb9@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 2 Sep 2023 14:28:41 -0400
Message-ID: <CAEXW_YTzP90zs8z4UFC52fd_KMkpBba6ujBNnDM5Z6exskJ6tg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 2, 2023 at 9:53=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Sep 01, 2023 at 02:04:24PM -0400, Joel Fernandes wrote:
> > On Fri, Sep 1, 2023 at 10:49=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Thu, Aug 31, 2023 at 01:22:56AM +0000, Joel Fernandes (Google) wro=
te:
> > > > Currently console.log.diags contains an output like follows:
> > > > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 r=
cu_tasks_trace_pregp_step+0x4a/0x50
> > > > [ 2457.542385] Call Trace:
> > > >
> > > > This is not very useful and the Call trace is desired. Improve the
> > > > script by Extracting more lines after each grep match.
> > > >
> > > > With this the above becomes:
> > > >
> > > > Issue 1:
> > > > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061 r=
cu_tasks_trace_pregp_step+0x4a/0x50
> > > > [ 2457.326661] Modules linked in:
> > > > [ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.1=
5.128+ #381
> > > > [ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > [ 2457.373309] RIP: 0010:rcu_tasks_trace_pregp_step+0x4a/0x50
> > > > [ 2457.386691] Code: 48 63 c7 48 8b 0
> > > > [ 2457.421803] RSP: 0018:ffffa80fc0073e40 EFLAGS: 00010202
> > > > [ 2457.431940] RAX: ffff8db91f580000 RBX: 000000000001b900 RCX: 000=
0000000000003
> > > > [ 2457.443206] RDX: 0000000000000008 RSI: ffffffffac6bebd8 RDI: 000=
0000000000003
> > > > [ 2457.454428] RBP: 0000000000000004 R08: 0000000000000001 R09: 000=
0000000000001
> > > > [ 2457.465668] R10: 0000000000000000 R11: 00000000ffffffff R12: fff=
f8db902d87f40
> > > > [ 2457.476971] R13: ffffffffac556620 R14: ffffffffac556630 R15: fff=
f8db9011a3200
> > > > [ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000=
) knlGS:0000000000000000
> > > > [ 2457.500834] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [ 2457.509602] CR2: 0000000000000000 CR3: 0000000002cbc000 CR4: 000=
00000000006e0
> > > > [ 2457.520378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > > [ 2457.531440] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
> > > > [ 2457.542385] Call Trace:
> > > > [ 2457.546756]  <TASK>
> > > > [ 2457.550349]  ? __warn+0x7b/0x100
> > > > [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > > > -------------------------------------
> > > > Issue 2:
> > > > [ 2457.542385] Call Trace:
> > > > [ 2457.546756]  <TASK>
> > > > [ 2457.550349]  ? __warn+0x7b/0x100
> > > > [ 2457.567214]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > > > [ 2457.574948]  ? report_bug+0x99/0xc0
> > > > [ 2457.593824]  ? handle_bug+0x3c/0x70
> > > > [ 2457.599534]  ? exc_invalid_op+0x13/0x60
> > > > [ 2457.625729]  ? asm_exc_invalid_op+0x16/0x20
> > > > [ 2457.632249]  ? rcu_tasks_trace_pregp_step+0x4a/0x50
> > > > [ 2457.660010]  rcu_tasks_wait_gp+0x54/0x360
> > > > [ 2457.677761]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
> > > > [ 2457.705658]  rcu_tasks_kthread+0x114/0x200
> > > > [ 2457.712450]  ? wait_woken+0x70/0x70
> > > > [ 2457.727283]  ? synchronize_rcu_tasks_rude+0x10/0x10
> > > > [ 2457.746221]  kthread+0x130/0x160
> > > > [ 2457.751487]  ? set_kthread_struct+0x40/0x40
> > > > [ 2457.758178]  ret_from_fork+0x22/0x30
> > > > [ 2457.763909]  </TASK>
> > > > [ 2457.767546] irq event stamp: 29544441
> > > > [ 2457.773344] hardirqs last  enabled at (29544451): [<ffffffffaace=
6cbd>] __up_console_sem+0x4d/0x60
> > > > [ 2457.786967] hardirqs last disabled at (29544460): [<ffffffffaace=
6ca2>] __up_console_sem+0x32/0x60
> > > > -------------------------------------
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > Nice!!!
> > >
> > > One request, though.  If I am reading this correctly, if a console.lo=
g
> > > file is filled with splats, then console.log.diags will replicate mos=
t
> > > of console.log.  Could you please limit something, perhaps the number
> > > of lines, the number of splats, or some such?
> > >
> > > Just for context, my use case for the current setup is to run
> > > kvm-find-errors.sh, which puts each console.log.diags/console.log pai=
r
> > > into my editor.  I copy an appropriate string from the console.log.di=
ags,
> > > and then paste that string to search for it in the corresponding
> > > console.log file, which is what is edited next.
> >
> > I could add a summary on the top for your usecase (which keeps the
> > original output), and then the more detailed splats below it. Would
> > that work?
>
> That summary would normally be at the top of the file anyway, right?

Not after this patch. I removed the summary in my patch from the
console .diags in favor of the detailed ones. I can add it back.

> Either way, what I don't want is many megabytes of splats from console.lo=
g
> duplicated into console.log.diags, especially in those (admittedly sad)
> cases where the console.log file is the largest file in the results
> directory.  Are you really going to be reading carefully after (say)
> the fifth splat?  ;-)

I could limit it to just the first 5, with the existing unlimited
summary at the top.

Let me know if that works or does not work for you. :-)

thanks,

 - Joel


>
>                                                         Thanx, Paul
>
> > So the whole file would look something like:
> > =3D=3D=3D=3D=3Dx8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Summary of console.log lines showing issues:
> > Line 300: [ 2457.293734] WARNING: CPU: 2 PID: 13 at
> > kernel/rcu/tasks.h:1061 rcu_tasks_trace_pregp_step+0x4a/0x50
> > Line 400:[ 2457.542385] Call Trace:
> >
> > Detailed list of issues:
> > 1. Issue on line 300:
> > [ 2457.293734] WARNING: CPU: 2 PID: 13 at kernel/rcu/tasks.h:1061
> > rcu_tasks_trace_pregp_step+0x4a/0x50
> > [ 2457.326661] Modules linked in:
> > [ 2457.334818] CPU: 2 PID: 13 Comm: rcu_tasks_trace Not tainted 5.15.12=
8+ #381
> > [ 2457.349782] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.2-debian-1.16.2-1 04/01/2014
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
> > [ 2457.488251] FS:  0000000000000000(0000) GS:ffff8db91f500000(0000)
> > knlGS:0000000000000000
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
> > 2. Issue on Line 500:
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
> > [ 2457.773344] hardirqs last  enabled at (29544451):
> > [<ffffffffaace6cbd>] __up_console_sem+0x4d/0x60
> > [ 2457.786967] hardirqs last disabled at (29544460):
> > [<ffffffffaace6ca2>] __up_console_sem+0x32/0x60
> > -------------------------------------
> > =3D=3D=3D=3D=3Dx8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
