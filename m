Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932B019D4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfEJMcJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 08:32:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfEJMcJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 08:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CJ/RgzG6/23EoFY4Hg/6HnLzf+zlaDTQsjadNt+mqsc=; b=u0ZEekF/39iPW4i1B4OoREnhB
        LveLsEtgqTkR9onnpN5dQph4/uGjda6xOD3siFjtuQ0ZUfcu5UfEY2Q0HXj9HR4LpDNBk/BX3CJDA
        VJPgJy6qpCwNNmS2gLm8FF9EK6/OS/pcMyp8BFP88usSnY95qgJAsig6MAXoKkW3dJE+HYn9GsZwI
        48fuuMh+m7gCMgD8pCO2shRAhQsW0eG2uNQ+8VC+4di2fbbIGXsVpwemHS/YVwv1jR+jswrFG9+D7
        NT7mPNgSsHRy4C3MG3nsUoeAsfxunqeetUYvtJiBPNUr08JsKhhGjOFq6s7377MT4uvyPFWrPfOVc
        /eoDUpefg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP4gW-0005dv-Uw; Fri, 10 May 2019 12:31:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94E2D2029F1F3; Fri, 10 May 2019 14:31:31 +0200 (CEST)
Date:   Fri, 10 May 2019 14:31:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
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
        Joerg Roedel <jroedel@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190510123131.GU2589@hirez.programming.kicks-ass.net>
References: <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
 <20190509230106.3551b08553440d125e437f66@kernel.org>
 <20190509171416.GY2623@hirez.programming.kicks-ass.net>
 <20190510135831.c4ad309c68fc254f819194fc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510135831.c4ad309c68fc254f819194fc@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 10, 2019 at 01:58:31PM +0900, Masami Hiramatsu wrote:
> On Thu, 9 May 2019 19:14:16 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Ideally also the optimized kprobe trampoline, but I've not managed to
> > fully comprehend that one.
> 
> As you pointed in other reply, save/restore can be a macro, but
> each trampoline code is slightly different. Optprobe template has
> below parts
> 
> (jumped from probed address)
> [store regs]
> [setup function arguments (pt_regs and probed address)]
> [handler call]
> [restore regs]
> [execute copied instruction]

 instruction_s_ ?

The JMP to this trampoline is likely 5 bytes and could have clobbered
multiple instructions, we'd then have to place them all here, and

> [jump back to probed address]

jump to after whatever instructions were clobbered by the JMP.

> Note that there is a limitation that if it is optiomized probe, user
> handler can not change regs->ip. (we can not use "ret" after executed
> a copied instruction, which must run on same stack)

Changing regs->ip in this case is going to be massively dodgy indeed :-)
But so would changing much else; changing stack layout would also be
somewhat tricky.
