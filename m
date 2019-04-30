Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8CDF552
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfD3LTT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 07:19:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LTS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L6RbtbALsHZdEB1dBgFqPR0csu0ISaHiL/UV6U5cQuY=; b=AflxWRnRKui1Arz8Gz8hqwfhh
        hSyqQce0AL36oM5bSHSDDxAPOC8yZA3631xf2pNjInQQ+Un7XTJd4TFbRvjYkKdS3Cu0PFCRV6e+Q
        Y5TK909VdvuD3W/E6upJEwVk8emMg+3FounrP4GB2EoELK7eMWRUArlQDxgsVSw9ze+j8UVAk6+Yh
        T4zq2UaKM1xNBten2qYt3fKJYCCViKMEc6VmjxIQLPpEfv51twOcnPtNNjvhWz5ewQBFWXLA/A3d+
        agzaOR9Yg6Ev9i/pHuyzq+Rq5k5T/zTbmaF1WvwmdS9DvY5cvsNYqrVnrbOLTQnjYFJ4I3pMttUFz
        3zN9KWVBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQme-00086p-P4; Tue, 30 Apr 2019 11:18:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A84129B1115A; Tue, 30 Apr 2019 13:18:46 +0200 (CEST)
Date:   Tue, 30 Apr 2019 13:18:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
Message-ID: <20190430111846.GS2623@hirez.programming.kicks-ass.net>
References: <20190427100639.15074-1-nstange@suse.de>
 <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net>
 <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wjAQaowLHBrXs1M5K-Nr-eVQMt0K8oyCuWxKTvP9k=qqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjAQaowLHBrXs1M5K-Nr-eVQMt0K8oyCuWxKTvP9k=qqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 03:06:30PM -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019 at 11:57 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > Otherwise you could never trust the whole sti shadow thing - and it very much is part of the architecture.
> >
> > Is this documented somewhere?
> 
> Btw, if you really don't trust the sti shadow despite it going all the
> way back to the 8086, then you could instead make the irqoff code do
> 
>         push %gs:bp_call_return
>         push %gs:bp_call_target
>         sti
>         ret

This variant cures the RETPOLINE complaint; due to there not actually
being an indirect jump anymore. And it cures the sibling call complaint,
but trades it for "return with modified stack frame".

Something like so is clean:

+extern asmlinkage void emulate_call_irqon(void);
+extern asmlinkage void emulate_call_irqoff(void);
+
+asm(
+	".text\n"
+	".global emulate_call_irqoff\n"
+	".type emulate_call_irqoff, @function\n"
+	"emulate_call_irqoff:\n\t"
+		"push %gs:bp_call_return\n\t"
+		"push %gs:bp_call_target\n\t"
+		"sti\n\t"
+		"ret\n"
+	".size emulate_call_irqoff, .-emulate_call_irqoff\n"
+
+	".global emulate_call_irqon\n"
+	".type emulate_call_irqon, @function\n"
+	"emulate_call_irqon:\n\t"
+		"push %gs:bp_call_return\n\t"
+		"push %gs:bp_call_target\n\t"
+		"ret\n"
+	".size emulate_call_irqon, .-emulate_call_irqon\n"
+	".previous\n");
+
+STACK_FRAME_NON_STANDARD(emulate_call_irqoff);
+STACK_FRAME_NON_STANDARD(emulate_call_irqon);
