Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1E1800B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEHStB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 14:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHStB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 14:49:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 535FA34CF;
        Wed,  8 May 2019 18:49:00 +0000 (UTC)
Received: from treble (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C15166266F;
        Wed,  8 May 2019 18:48:50 +0000 (UTC)
Date:   Wed, 8 May 2019 13:48:48 -0500
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
Message-ID: <20190508184848.qerg3flv3ej3xsev@treble>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508153907.GM2589@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 08 May 2019 18:49:01 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 08, 2019 at 05:39:07PM +0200, Peter Zijlstra wrote:
> On Wed, May 08, 2019 at 07:42:48AM -0500, Josh Poimboeuf wrote:
> > On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:
> 
> > > Do the x86_64 variants also want some ORC annotation?
> > 
> > Maybe so.  Though it looks like regs->ip isn't saved.  The saved
> > registers might need to be tweaked.  I'll need to look into it.
> 
> What all these sites do (and maybe we should look at unifying them
> somehow) is turn a CALL frame (aka RET-IP) into an exception frame (aka
> pt_regs).
> 
> So regs->ip will be the return address (which is fixed up to be the CALL
> address in the handler).

But from what I can tell, trampoline_handler() hard-codes regs->ip to
point to kretprobe_trampoline(), and the original return address is
placed in regs->sp.

Masami, is there a reason why regs->ip doesn't have the original return
address and regs->sp doesn't have the original SP?  I think that would
help the unwinder understand things.

-- 
Josh
