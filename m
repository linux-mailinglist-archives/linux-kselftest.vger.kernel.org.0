Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC916ECA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEHCAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 May 2019 22:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfEHCAD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 May 2019 22:00:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5519920656;
        Wed,  8 May 2019 02:00:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOBsG-0005qV-Bq; Tue, 07 May 2019 22:00:00 -0400
Message-Id: <20190508015559.767152678@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 07 May 2019 21:55:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] x86_64/ftrace: Emulate calls from int3 when patching functions
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


[
  This is the non-RFC version.

  It went through and passed all my tests. If there's no objections
  I'm going to include this in my pull request. I still have patches
  in my INBOX that may still be included, so I need to run those through
  my tests as well, so a pull request wont be immediate.
]

Nicolai Stange discovered that Live Kernel Patching can have unforseen
consequences if tracing is enabled when there are functions that are
patched. The reason being, is that Live Kernel patching is built on top
of ftrace, which will have the patched functions call the live kernel
trampoline directly, and that trampoline will modify the regs->ip address
to return to the patched function.

But in the transition between changing the call to the customized
trampoline, the tracing code is needed to have its handler called
an well, so the function fentry location must be changed from calling
the live kernel patching trampoline, to the ftrace_reg_caller trampoline
which will iterate through all the registered ftrace handlers for
that function.

During this transition, a break point is added to do the live code
modifications. But if that break point is hit, it just skips calling
any handler, and makes the call site act as a nop. For tracing, the
worse that can happen is that you miss a function being traced, but
for live kernel patching the affects are more severe, as the old buggy
function is now called.

To solve this, an int3_emulate_call() is created for x86_64 to allow
ftrace on x86_64 to emulate the call to ftrace_regs_caller() which will
make sure all the registered handlers to that function are still called.
And this keeps live kernel patching happy!

To mimimize the changes, and to avoid controversial patches, this
only changes x86_64. Due to the way x86_32 implements the regs->sp
the complexity of emulating calls on that platform is too much for
stable patches, and live kernel patching does not support x86_32 anyway.


Josh Poimboeuf (1):
      x86_64: Add gap to int3 to allow for call emulation

Peter Zijlstra (2):
      x86_64: Allow breakpoints to emulate call instructions
      ftrace/x86_64: Emulate call function while updating in breakpoint handler

----
 arch/x86/entry/entry_64.S            | 18 ++++++++++++++++--
 arch/x86/include/asm/text-patching.h | 28 ++++++++++++++++++++++++++++
 arch/x86/kernel/ftrace.c             | 32 +++++++++++++++++++++++++++-----
 3 files changed, 71 insertions(+), 7 deletions(-)
