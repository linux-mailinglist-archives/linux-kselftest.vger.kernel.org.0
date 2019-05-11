Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D11A5F1
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2019 02:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfEKAxD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 20:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfEKAxD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 20:53:03 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D3D217D7;
        Sat, 11 May 2019 00:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557535982;
        bh=wZT6T6pxRmvr1rf3n5N69GLgbT/00pNeSBk069QWzGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ynMC7nnjo4P6R7MipQQ4TY/YSN/JZPBwWVQFsM0vdH9KInM7eXWQ8lHj8NeysRgYL
         qOllqmIVO53C9WJjSa4fCgw05JDRJUBFpuK6K3/nNvrK7gRa3pUSM0bS/MJxzj1jPn
         cep1uc4w5Ip3pxZPHfnMH6YiPQFeKzJcfr+pH2cg=
Date:   Sat, 11 May 2019 09:52:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-Id: <20190511095254.21d41a8db0d66669d51144cc@kernel.org>
In-Reply-To: <20190510123131.GU2589@hirez.programming.kicks-ass.net>
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
        <20190510123131.GU2589@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 10 May 2019 14:31:31 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, May 10, 2019 at 01:58:31PM +0900, Masami Hiramatsu wrote:
> > On Thu, 9 May 2019 19:14:16 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Ideally also the optimized kprobe trampoline, but I've not managed to
> > > fully comprehend that one.
> > 
> > As you pointed in other reply, save/restore can be a macro, but
> > each trampoline code is slightly different. Optprobe template has
> > below parts
> > 
> > (jumped from probed address)
> > [store regs]
> > [setup function arguments (pt_regs and probed address)]
> > [handler call]
> > [restore regs]
> > [execute copied instruction]
> 
>  instruction_s_ ?

Yes.

> 
> The JMP to this trampoline is likely 5 bytes and could have clobbered
> multiple instructions, we'd then have to place them all here, and
> 
> > [jump back to probed address]
> 
> jump to after whatever instructions were clobbered by the JMP.

Right!

> > Note that there is a limitation that if it is optiomized probe, user
> > handler can not change regs->ip. (we can not use "ret" after executed
> > a copied instruction, which must run on same stack)
> 
> Changing regs->ip in this case is going to be massively dodgy indeed :-)
> But so would changing much else; changing stack layout would also be
> somewhat tricky.

Yes, so the stack must be same after [restore regs].

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
