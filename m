Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009ED1902D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEIS0z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 14:26:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEIS0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 14:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M+ac/UzOhEovku6TvaL3m7ed0JPo1/Dl8jj2JnZY/7E=; b=iTJ9LIl7aeRopKzTZ3VOE/mYf
        Gvc+rqcVgiuiuD6oJoIBfLtkF/IFiFLEJUWw6tUjPF8TQYE9ri2m1SECKM835zcl43lCNC06mQv4O
        UnU06gmyVgEJoAcmklK/KhHWR+y1uhidZOLNrFdr+Gy9NG+hzWkdVPNXbLENCMnSncVqlvrCrjr0j
        ijYd+J5FWgqMruK6JzUY+/Dc0tfC00zOEBQeUCxNC9OGFQX9reneb8HFrDSZYa6SRVHm7bdLfrKcw
        T635XepFYxxMJWDMdfy7RGCO2B2SgLmdxK7kXFbj/4PqQMfTZQ8vygSFpoG3kAtWn1/RAjm80f9dy
        joEYtlD9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOnkN-0004KF-Ja; Thu, 09 May 2019 18:26:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FF2B2143093D; Thu,  9 May 2019 20:26:22 +0200 (CEST)
Date:   Thu, 9 May 2019 20:26:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20190509182622.GB2623@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
 <20190509081431.GO2589@hirez.programming.kicks-ass.net>
 <20190509173741.pfvecznqdndihxzg@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509173741.pfvecznqdndihxzg@home.goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 09, 2019 at 01:37:42PM -0400, Steven Rostedt wrote:
> On Thu, May 09, 2019 at 10:14:31AM +0200, Peter Zijlstra wrote:
> > 
> > Right; I already fixed that in my patch changing i386's pt_regs.
> > 
> > But what I'd love to do is something like the belwo patch, and make all
> > the trampolines (very much including ftrace) use that. Such that we then
> > only have 1 copy of this magic (well, 2 because x86_64 also needs an
> > implementation of this of course).
> > 
> > Changing ftrace over to this would be a little more work but it can
> > easily chain things a little to get its original context back:
> > 
> > ENTRY(ftrace_regs_caller)
> > GLOBAL(ftrace_regs_func)
> > 	push ftrace_stub
> > 	push ftrace_regs_handler
> 
> Note, ftrace_stub is dynamically modified to remove any indirect calls.

Yeah, I realized that a few hours after I send this out; as you might
have seen by the IRC chatter on this.

Still, maybe we can wrap the thing in a .macro and reuse things that
way. Because I really hate there are at least 3 (x2 for x86_64) copies
of this around.
