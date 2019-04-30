Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B010169
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 23:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfD3VIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 17:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfD3VIM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 17:08:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C252087B;
        Tue, 30 Apr 2019 21:08:09 +0000 (UTC)
Date:   Tue, 30 Apr 2019 17:08:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating
 in breakpoint handler
Message-ID: <20190430170808.1053b3e2@gandalf.local.home>
In-Reply-To: <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
References: <20190428133826.3e142cfd@oasis.local.home>
        <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
        <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
        <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
        <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
        <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
        <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
        <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
        <20190430135602.GD2589@hirez.programming.kicks-ass.net>
        <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
        <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
        <20190430130359.330e895b@gandalf.local.home>
        <20190430132024.0f03f5b8@gandalf.local.home>
        <20190430134913.4e29ce72@gandalf.local.home>
        <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 30 Apr 2019 11:33:21 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > +       "ftrace_emulate_call_update_irqoff:\n\t"
> > +               "push %gs:ftrace_bp_call_return\n\t"
> > +               "sti\n\t"
> > +               "jmp *ftrace_update_func_call\n"  
> 
> .. and this should then use the "push push sti ret" model instead.
> 
> Plus get updated for objtool complaints.

And unfortunately, this blows up on lockdep. Lockdep notices that the
return from the breakpoint handler has interrupts enabled, and will not
enable them in its shadow irqs disabled variable. But then we enabled
them in the trampoline, without telling lockdep and we trigger
something likes this:

------------[ cut here ]------------
IRQs not enabled as expected
WARNING: CPU: 2 PID: 0 at kernel/time/tick-sched.c:979 tick_nohz_idle_enter+0x44/0x8c
Modules linked in:
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.1.0-rc3-test+ #123
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
EIP: tick_nohz_idle_enter+0x44/0x8c
Code: f0 05 00 00 00 75 26 83 b8 c4 05 00 00 00 75 1d 80 3d 5f 0f 43 c1 00 75 14 68 72 74 16 c1 c6 05 5f 0f 43 c1 01 e8 33 d7 f8 ff <0f> 0b 58 fa e8 4e 2c 04 00 bb e0 36 6b c1 64 03 1d 28 81 56 c1 8b
EAX: 0000001c EBX: ee769f84 ECX: 00000000 EDX: 00000006
ESI: 00000000 EDI: 00000002 EBP: ee769f50 ESP: ee769f48
DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210292
CR0: 80050033 CR2: 00000000 CR3: 016c4000 CR4: 001406f0
Call Trace:
 do_idle+0x2a/0x1fc
 cpu_startup_entry+0x1e/0x20
 start_secondary+0x1d3/0x1ec
 startup_32_smp+0x164/0x168


I have to fool lockdep with the following:

		if (regs->flags & X86_EFLAGS_IF) {
			regs->flags &= ~X86_EFLAGS_IF;
			regs->ip = (unsigned long) ftrace_emulate_call_irqoff;
			/* Tell lockdep here we are enabling interrupts */
			trace_hardirqs_on();
		} else {
			regs->ip = (unsigned long) ftrace_emulate_call_irqon;
		}

-- Steve
