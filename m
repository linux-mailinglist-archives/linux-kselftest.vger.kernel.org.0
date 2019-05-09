Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3453118ECE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEIRTC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 13:19:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIRTC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 13:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h9oK3RsLQP7A0Z8d5uEJwqxM0kwLaT657qEgfdThiz0=; b=ZmDFKam/fMA79ssTdityQOLPmr
        IksuipOforKZi0mU4GnsCvS63QktfJcCEqwLiBqsvQObZ8YTIzQ/diRiczfU6MMxVoRdkKLvIaLzZ
        26CrOAvas1A6QpLFWO+4ipn/jQk4ShpkE2YvdG0JU//CoZbWiUClosxmP3AkKbAKz25OTkXcjOBNS
        GKDFSYEVgy6DWEizZvJ9OFlq5Mg4qpRDcVStqjVqsU4xC43zdMAMwmBbIOb/L1vVjl6feijiY5tr/
        lcIA42F9qSapoW0//LhPr+tc+qk0Q+aAhuAgzw7rDgnzhm8yZO634in7uWey3LbQ+h6W+qjrRK6Lk
        y/cyfYVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOmgs-0006Dd-Jr; Thu, 09 May 2019 17:18:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 981EF2019FECA; Thu,  9 May 2019 19:18:40 +0200 (CEST)
Date:   Thu, 9 May 2019 19:18:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Joerg Roedel <jroedel@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190509171840.GZ2623@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
 <81170F0B-A2BB-4CD6-A1B5-5E7E0DDBC282@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81170F0B-A2BB-4CD6-A1B5-5E7E0DDBC282@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 09, 2019 at 09:20:06AM -0700, Andy Lutomirski wrote:
> > +ENTRY(call_to_exception_trampoline)
> > +    /*
> > +     * On entry the stack looks like:
> > +     *
> > +     *   2*4(%esp) <previous context>
> > +     *   1*4(%esp) RET-IP
> > +     *   0*4(%esp) func
> > +     *
> > +     * transform this into:
> > +     *
> > +     *  19*4(%esp) <previous context>
> > +     *  18*4(%esp) gap / RET-IP
> > +     *  17*4(%esp) gap / func
> > +     *  16*4(%esp) ss
> > +     *  15*4(%esp) sp / <previous context>
> > +     *  14*4(%esp) flags
> > +     *  13*4(%esp) cs
> > +     *  12*4(%esp) ip / RET-IP
> > +     *  11*4(%esp) orig_eax
> > +     *  10*4(%esp) gs
> > +     *   9*4(%esp) fs
> > +     *   8*4(%esp) es
> > +     *   7*4(%esp) ds
> > +     *   6*4(%esp) eax
> > +     *   5*4(%esp) ebp
> > +     *   4*4(%esp) edi
> > +     *   3*4(%esp) esi
> > +     *   2*4(%esp) edx
> > +     *   1*4(%esp) ecx
> > +     *   0*4(%esp) ebx
> > +     */
> > +    pushl    %ss
> > +    pushl    %esp        # points at ss
> > +    addl    $3*4, (%esp)    #   point it at <previous context>
> > +    pushfl
> > +    pushl    %cs
> > +    pushl    5*4(%esp)    # RET-IP
> > +    subl    5, (%esp)    #   point at CALL instruction
> > +    pushl    $-1
> > +    pushl    %gs
> > +    pushl    %fs
> > +    pushl    %es
> > +    pushl    %ds
> > +    pushl    %eax
> > +    pushl    %ebp
> > +    pushl    %edi
> > +    pushl    %esi
> > +    pushl    %edx
> > +    pushl    %ecx
> > +    pushl    %ebx
> > +
> > +    ENCODE_FRAME_POINTER
> > +
> > +    movl    %esp, %eax    # 1st argument: pt_regs
> > +
> > +    movl    17*4(%esp), %ebx    # func
> > +    CALL_NOSPEC %ebx
> > +
> > +    movl    PT_OLDESP(%esp), %eax
> > +
> > +    movl    PT_EIP(%esp), %ecx
> > +    movl    %ecx, -1*4(%eax)
> > +
> > +    movl    PT_EFLAGS(%esp), %ecx
> > +    movl    %ecx, -2*4(%eax)
> > +
> > +    movl    PT_EAX(%esp), %ecx
> > +    movl    %ecx, -3*4(%eax)
> > +
> > +    popl    %ebx
> > +    popl    %ecx
> > +    popl    %edx
> > +    popl    %esi
> > +    popl    %edi
> > +    popl    %ebp
> > +
> > +    lea    -3*4(%eax), %esp
> > +    popl    %eax
> > +    popfl
> > +    ret
> > +END(call_to_exception_trampoline)

> Potentially minor nit: you’re doing popfl, but you’re not doing
> TRACE_IRQ_whatever.  This makes me think that you should either add
> the tracing (ugh!) or you should maybe just skip the popfl.

Yeah, so we really should not change flags I suppose. If this lives I'll
remove the popfl.
