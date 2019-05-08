Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7BB17998
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 14:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEHMm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 08:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfEHMm5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 08:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6C90307E04C;
        Wed,  8 May 2019 12:42:56 +0000 (UTC)
Received: from treble (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12FFE19729;
        Wed,  8 May 2019 12:42:50 +0000 (UTC)
Date:   Wed, 8 May 2019 07:42:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20190508124248.u5ukpbhnh4wpiccq@treble>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508120416.GL2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 08 May 2019 12:42:57 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 06:54:16AM -0500, Josh Poimboeuf wrote:
> > On Wed, May 08, 2019 at 09:49:03AM +0200, Peter Zijlstra wrote:
> > > The kprobe trampolines have a FRAME_POINTER annotation that makes no
> > > sense. It marks the frame in the middle of pt_regs, at the place of
> > > saving BP.
> > > 
> > > Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
> > > from the respective entry_*.S.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/kernel/kprobes/common.h |   32 +++++++++++++++++++++++---------
> > >  1 file changed, 23 insertions(+), 9 deletions(-)
> > > 
> > > --- a/arch/x86/kernel/kprobes/common.h
> > > +++ b/arch/x86/kernel/kprobes/common.h
> > > @@ -6,14 +6,15 @@
> > >  
> > >  #include <asm/asm.h>
> > >  
> > > +#ifdef CONFIG_X86_64
> > > +
> > >  #ifdef CONFIG_FRAME_POINTER
> > > -# define SAVE_RBP_STRING "	push %" _ASM_BP "\n" \
> > > -			 "	mov  %" _ASM_SP ", %" _ASM_BP "\n"
> > > +#define ENCODE_FRAME_POINTER			\
> > > +	"	leaq 1(%rsp), %rbp\n"
> > >  #else
> > > -# define SAVE_RBP_STRING "	push %" _ASM_BP "\n"
> > > +#define ENCODE_FRAME_POINTER
> > >  #endif
> > 
> > > +#ifdef CONFIG_FRAME_POINTER
> > > +#define ENCODE_FRAME_POINTER			\
> > > +	"	movl %esp, %ebp\n"		\
> > > +	"	andl $0x7fffffff, %ebp\n"
> > > +#else
> > > +#define ENCODE_FRAME_POINTER
> > > +#endif
> > 
> > We should put these macros in a header file somewhere (including
> > stringified versions).
> 
> Probably a good idea. I'll frob them into asm/frame.h.
> 
> Do the x86_64 variants also want some ORC annotation?

Maybe so.  Though it looks like regs->ip isn't saved.  The saved
registers might need to be tweaked.  I'll need to look into it.

-- 
Josh
