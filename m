Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610367DC512
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 05:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjJaEAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 00:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaEAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 00:00:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315DB4;
        Mon, 30 Oct 2023 21:00:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE65C433C8;
        Tue, 31 Oct 2023 04:00:33 +0000 (UTC)
Date:   Tue, 31 Oct 2023 00:00:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        Mark Brown <broonie@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: selftests: user_events: ftrace_test - RIP:
 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
Message-ID: <20231031000031.1e705592@gandalf.local.home>
In-Reply-To: <20231031002707.GA107-beaub@linux.microsoft.com>
References: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
        <20231027192011.GA436-beaub@linux.microsoft.com>
        <20231027183640.2529ab68@gandalf.local.home>
        <20231027223344.3854ac1f@rorschach.local.home>
        <20231030163102.GA1853-beaub@linux.microsoft.com>
        <20231030124223.4e4ddeb8@gandalf.local.home>
        <20231030173151.0631169b@gandalf.local.home>
        <20231031002707.GA107-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ Adding Masami and stable ]

On Tue, 31 Oct 2023 00:27:07 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Mon, Oct 30, 2023 at 05:31:51PM -0400, Steven Rostedt wrote:
> > On Mon, 30 Oct 2023 12:42:23 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > > I still get the splat about the trace_array_put when running
> > > > user_event's ftrace selftest:
> > > > 
> > > > [   26.665931] ------------[ cut here ]------------
> > > > [   26.666663] WARNING: CPU: 12 PID: 291 at kernel/trace/trace.c:516 tracing_release_file_tr+0x46/0x50
> > > > [   26.667470] Modules linked in:
> > > > [   26.667808] CPU: 12 PID: 291 Comm: ftrace_test Not tainted 6.6.0-rc7-next-20231026 #3
> > > > [   26.668665] RIP: 0010:tracing_release_file_tr+0x46/0x50
> > > > [   26.669093] Code: d1 03 01 8b 83 c0 1e 00 00 85 c0 74 1d 83 e8 01 48 c7 c7 80 5b ef bc 89 83 c0 1e 00 00 e8 f2 b5 03 01 31 c0 5b e9 75 ee 27 01 <0f> 0b eb df 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
> > > > [   26.670580] RSP: 0018:ffffb6ef858ffee8 EFLAGS: 00010246
> > > > [   26.671128] RAX: 0000000000000000 RBX: ffff9d7ae2364058 RCX: 0000000000000000
> > > > [   26.671793] RDX: 0000000000000000 RSI: ffffffffbcb6b38b RDI: 00000000ffffffff
> > > > [   26.672444] RBP: ffff9d7ac3e72200 R08: 0000000000000000 R09: 0000000000000000
> > > > [   26.673072] R10: ffffb6ef858ffee8 R11: ffffffffbb28526f R12: 00000000000f801f
> > > > [   26.673705] R13: ffff9d7b661a2020 R14: ffff9d7ac6057728 R15: 0000000000000000
> > > > [   26.674339] FS:  00007fa852fa6740(0000) GS:ffff9d81a6300000(0000) knlGS:0000000000000000
> > > > [   26.674978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   26.675506] CR2: 00007fa852c2a250 CR3: 0000000105d92001 CR4: 0000000000370eb0
> > > > [   26.676142] Call Trace:
> > > > [   26.676357]  <TASK>
> > > > [   26.676572]  ? __warn+0x7f/0x160
> > > > [   26.677092]  ? tracing_release_file_tr+0x46/0x50
> > > > [   26.677540]  ? report_bug+0x1c3/0x1d0
> > > > [   26.677871]  ? handle_bug+0x3c/0x70
> > > > [   26.678196]  ? exc_invalid_op+0x14/0x70
> > > > [   26.678520]  ? asm_exc_invalid_op+0x16/0x20
> > > > [   26.678845]  ? tracing_release_file_tr+0x1f/0x50
> > > > [   26.679268]  ? tracing_release_file_tr+0x46/0x50
> > > > [   26.679691]  ? tracing_release_file_tr+0x1f/0x50
> > > > [   26.680105]  __fput+0xab/0x300
> > > > [   26.680437]  __x64_sys_close+0x38/0x80    
> > > 
> > > Hmm, this doesn't tell me much. Let me go play with the user_event self
> > > tests.  
> > 
> > I added a bunch of printk()s and I'm thinking there's a race in user event
> > (or dynamic event) code.
> >   
> 
> I did as well, however, I don't see how user events would be involved
> other than allowing a trace_remove_event_call() with open enable fds?
> 
> I believe the scenario is open the enable file and keep the fd open.
> 
> While the fd is open to the enable file, call trace_remove_event_call().
> 
> If trace_remove_event_call() is called for an event with a tr->ref > 0,
> should it fail or work? (It currently works without issue.)
> 
> Should writes to the fd still work after the event it is related to has
> been removed?
> 
> I don't see how user_events could prevent this, it seems
> trace_remove_event_call() should fail if files for it are still open?
> 

This is a separate issue from eventfs (good, because I think I have solved
all the known bugs for that one - phew!).

Anyway, I checkout the code just before adding the eventfs, and did the following:

 # echo 'p:sched schedule' > /sys/kernel/tracing/kprobe_events
 # exec 5>>/sys/kernel/tracing/events/kprobes/sched/enable
 # > /sys/kernel/tracing/kprobe_events
 # exec 5>&-

And it worked fine. The above creates a kprobe event, opens the enable file
of that event with the bash file descriptor #5, removes the kprobe event,
and then closes the file descriptor #5.

But the I applied:

  f5ca233e2e66d ("tracing: Increase trace array ref count on enable and filter files")

And do the above commands again and BOOM! it crashes with:

[  217.879087] BUG: kernel NULL pointer dereference, address: 0000000000000028
[  217.881121] #PF: supervisor read access in kernel mode
[  217.882532] #PF: error_code(0x0000) - not-present page
[  217.883932] PGD 0 P4D 0 
[  217.884672] Oops: 0000 [#1] PREEMPT SMP PTI
[  217.885821] CPU: 6 PID: 877 Comm: bash Not tainted 6.5.0-rc4-test-00008-g2c6b6b1029d4-dirty #186
[  217.888178] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  217.890684] RIP: 0010:tracing_release_file_tr+0xc/0x50
[  217.892097] Code: 5d 41 5c c3 cc cc cc cc 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 53 48 8b 87 80 04 00 00 <48> 8b 58 28 48 85 db 74 2d 31 f6 48 c7 c7 c0 b3 1e 93 e8 2d 48 ca
[  217.897102] RSP: 0018:ffffa5d400587eb0 EFLAGS: 00010282
[  217.898531] RAX: 0000000000000000 RBX: ffff907d06aa6c00 RCX: 0000000000000000
[  217.900471] RDX: 0000000000000000 RSI: ffff907d06aa6c00 RDI: ffff907d0bf21bd0
[  217.902403] RBP: 00000000000d801e R08: 0000000000000001 R09: ffff907d0bf21bd0
[  217.904350] R10: 0000000000000001 R11: 0000000000000001 R12: ffff907d0bf21bd0
[  217.906282] R13: ffff907d103708e0 R14: ffff907d0a178c30 R15: 0000000000000000
[  217.908215] FS:  00007ff49c150740(0000) GS:ffff907e77d00000(0000) knlGS:0000000000000000
[  217.910405] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  217.911970] CR2: 0000000000000028 CR3: 00000001051ec005 CR4: 0000000000170ee0
[  217.913924] Call Trace:
[  217.914624]  <TASK>
[  217.915232]  ? __die+0x23/0x70
[  217.916105]  ? page_fault_oops+0x17d/0x4d0
[  217.917262]  ? exc_page_fault+0x7f/0x200
[  217.918350]  ? asm_exc_page_fault+0x26/0x30
[  217.919513]  ? tracing_release_file_tr+0xc/0x50
[  217.920780]  __fput+0xfb/0x2a0
[  217.921651]  task_work_run+0x5d/0x90
[  217.922652]  exit_to_user_mode_prepare+0x231/0x240
[  217.923981]  syscall_exit_to_user_mode+0x1a/0x50
[  217.925248]  do_syscall_64+0x4b/0xc0
[  217.926176]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Look familiar?

It's now midnight and I've been at this all day. I'm going to look more at
this tomorrow. It's not going to be easy :-( I'm not sure what exactly to
do. We may need to prevent dynamic events from being deleted if there's any
of its files opened (enable, format, etc).

That is, if you try to delete the event, it will give you an -EBUSY, just
like having them enabled would.

More good news, that commit is in 6.6 *and* marked for stable :-p

-- Steve
