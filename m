Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4602A18330
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 03:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfEIBUk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 21:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBUk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 21:20:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034DC2173E;
        Thu,  9 May 2019 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557364838;
        bh=oPvPuQ74RU1mLepyoEpxjH/yNzo+8P7yFE0PP+o30Oo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qY45YTDqXQdybXAQAMPwVnrkEhhduuYyYkgZFawIL7jWuKNHik7uqDaNUS3XVNRj8
         AAQqoQ2qMYdJRnT+93TWVWISLbHNk7va1yNGo0Pn8rb9yfZQqhAbAJ5krp21kfGlqw
         +6NfvKyNEYNLW1ddu9dBVyeqRDyn61IFvUHXciZM=
Date:   Thu, 9 May 2019 10:20:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-Id: <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
In-Reply-To: <20190508184848.qerg3flv3ej3xsev@treble>
References: <20190508074901.982470324@infradead.org>
        <20190508080612.721269814@infradead.org>
        <20190508115416.nblx7c2kocidpytm@treble>
        <20190508120416.GL2589@hirez.programming.kicks-ass.net>
        <20190508124248.u5ukpbhnh4wpiccq@treble>
        <20190508153907.GM2589@hirez.programming.kicks-ass.net>
        <20190508184848.qerg3flv3ej3xsev@treble>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Josh,

On Wed, 8 May 2019 13:48:48 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, May 08, 2019 at 05:39:07PM +0200, Peter Zijlstra wrote:
> > On Wed, May 08, 2019 at 07:42:48AM -0500, Josh Poimboeuf wrote:
> > > On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:
> > 
> > > > Do the x86_64 variants also want some ORC annotation?
> > > 
> > > Maybe so.  Though it looks like regs->ip isn't saved.  The saved
> > > registers might need to be tweaked.  I'll need to look into it.
> > 
> > What all these sites do (and maybe we should look at unifying them
> > somehow) is turn a CALL frame (aka RET-IP) into an exception frame (aka
> > pt_regs).
> > 
> > So regs->ip will be the return address (which is fixed up to be the CALL
> > address in the handler).
> 
> But from what I can tell, trampoline_handler() hard-codes regs->ip to
> point to kretprobe_trampoline(), and the original return address is
> placed in regs->sp.
> 
> Masami, is there a reason why regs->ip doesn't have the original return
> address and regs->sp doesn't have the original SP?  I think that would
> help the unwinder understand things.

Yes, for regs->ip, there is a histrical reason. Since previously, we had
an int3 at trampoline, so the user (kretprobe) handler expects that
regs->ip is trampoline address and ri->ret_addr is original return address.
It is better to check the other archs, but I think it is possible to
change the regs->ip to original return address, since no one cares such
"fixed address". :)

For the regs->sp, there are 2 reasons.

For x86-64, it's just for over-optimizing (reduce stack usage).
I think we can make a gap for putting return address, something like

	"kretprobe_trampoline:\n"
#ifdef CONFIG_X86_64
	"	pushq %rsp\n"	/* Make a gap for return address */
	"	pushq 0(%rsp)\n"	/* Copy original stack pointer */
	"	pushfq\n"
	SAVE_REGS_STRING
	"	movq %rsp, %rdi\n"
	"	call trampoline_handler\n"
	/* Push the true return address to the bottom */
	"	movq %rax, 20*8(%rsp)\n"
	RESTORE_REGS_STRING
	"	popfq\n"
	"	addq $8, %rsp\n"	/* Skip original stack pointer */

For i386 (x86-32), there is no other way to keep &regs->sp as
the original stack pointer. It has to be changed with this series,
maybe as same as x86-64.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
