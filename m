Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB60610D1C
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 21:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEATRk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 15:17:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47770 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfEATRj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 15:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+gSyYjZ0CwmIbD+YmCAZE4zrdyoc/i5bD93o1EN4L80=; b=KQvdmwVHilv+bxpOq/seGyHad
        tQ0SRr3bxpB90tmiYqSJbtSkK6pqddKpXZ32ibe4RtPDFQ2g8jMkIpQV754ck4ah1VA1rZ9z3DY2U
        uvgb0Bkdcwsju6e6K0LYl3JH1BG/Xko4HfwxSiTuN3BonXUK9EwUad4jUwgh3j+Pkd33LK3/W+EGe
        RoM2/reFIFUPLuwfvs7O84VXvqJW9WfI6fnQzWaRVKKrSuii+0UMuDZZDkCt/zgEGeXPrcJ6orE3r
        UOu8jRm7W6lvVtD+x8blkVRWdK7RR8SnXIC2wRiR/S8ytsB712yA4Yk8sH/3J6KCmqCqluHZdVmYz
        J0dcN5JUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLujG-0002tD-T7; Wed, 01 May 2019 19:17:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A283984EB4; Wed,  1 May 2019 21:17:16 +0200 (CEST)
Date:   Wed, 1 May 2019 21:17:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
Message-ID: <20190501191716.GV7905@worktop.programming.kicks-ass.net>
References: <20190501113238.0ab3f9dd@gandalf.local.home>
 <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
 <20190501145200.6c095d7f@oasis.local.home>
 <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 01, 2019 at 11:59:05AM -0700, Linus Torvalds wrote:
> On Wed, May 1, 2019 at 11:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I got Peter's patch working. Here it is. What do you think?
> 
> I can tell from just looking at it for five seconds that at least the
> 32-bit case is buggy.
> 
> You can't look at CS(%rsp) without first also checking that you're not
> coming from vm86 mode.

Something like so then?

Index: linux-2.6/arch/x86/entry/entry_32.S
===================================================================
--- linux-2.6.orig/arch/x86/entry/entry_32.S
+++ linux-2.6/arch/x86/entry/entry_32.S
@@ -1479,6 +1479,10 @@ ENTRY(int3)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int

+#ifdef CONFIG_VM86
+	testl	$X86_EFLAGS_VM, PT_EFLAGS(%esp)
+	jnz	.Lfrom_usermode_no_gap
+#endif
 	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
 	jnz	.Lfrom_usermode_no_gap
 	.rept 6

