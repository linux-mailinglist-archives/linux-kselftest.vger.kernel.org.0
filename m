Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86E7187BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfEIJ1z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 05:27:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfEIJ1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 05:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mh9wv/1YPcHFRafECtG9vJbg2xftnq1zTlCLnERm8MU=; b=WcNQDklEwzguV0Z8pENKDWZGy
        q0ZhOFX23ffs/Z0ITznG7dFVyKrFXBU1mzR0rEH9ph2nFYgCZgEoCJ8NYQ8PiM/HXqGsgzPAN/t2N
        hOf8xuAdOAgu3dZ/mA1bKacT3QmaI64yJcgDYx5eKV17UA8zIVQ2/DraLKQGFyAC2SYX3GzBp5L5P
        B/25wkTsE2uUU6lYGClvMLTLCup3Jp7aN28XJ1dnTFAC+LMBIe6SRJ78XHXCppfLNkn32F2FEJbh1
        72aI8gkU0C2UZxwH7dZ9qVXTFo6XheLrzDxnH03Wv3NafxemGD8/KGKZ2+JNxgaFYSZ9/2w15WaPk
        /8Im51tRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOfL2-0004y6-SB; Thu, 09 May 2019 09:27:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2EF029CD4D51; Thu,  9 May 2019 11:27:38 +0200 (CEST)
Date:   Thu, 9 May 2019 11:27:38 +0200
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
Message-ID: <20190509092738.GK2650@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509081431.GO2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 09, 2019 at 10:14:31AM +0200, Peter Zijlstra wrote:
> struct ftrace_regs_stack {
> 	ftrace_func_t func;
> 	unsigned long parent_ip;
> };
> 
> void ftrace_regs_handler(struct pr_regs *regs)
> {
> 	struct ftrace_regs_stack *st = (void *)regs->sp;
> 	ftrace_func_t func = st->func;
> 
> 	regs->sp += sizeof(long); /* pop func */
> 
> 	func(regs->ip, st->parent_ip, function_trace_op, regs);
> }

Alternatively we can add things like:

static inline unsigned long int3_emulate_pop(struct pt_regs *regs)
{
	unsigned long val = *(unsigned long *)regs->sp;
	regs->sp += sizeof(unsigned long);
	return val;
}

And do:

	ftrace_func_t func = (void *)int3_emulate_pop(regs);
