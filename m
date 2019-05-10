Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3124F19F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfEJOyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 10:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfEJOyF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 10:54:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A202175B;
        Fri, 10 May 2019 14:54:02 +0000 (UTC)
Date:   Fri, 10 May 2019 10:54:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <20190510105400.0d267e9f@gandalf.local.home>
In-Reply-To: <20190510121720.GT2589@hirez.programming.kicks-ass.net>
References: <20190508115416.nblx7c2kocidpytm@treble>
        <20190508120416.GL2589@hirez.programming.kicks-ass.net>
        <20190508124248.u5ukpbhnh4wpiccq@treble>
        <20190508153907.GM2589@hirez.programming.kicks-ass.net>
        <20190508184848.qerg3flv3ej3xsev@treble>
        <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
        <20190509081431.GO2589@hirez.programming.kicks-ass.net>
        <81170F0B-A2BB-4CD6-A1B5-5E7E0DDBC282@amacapital.net>
        <20190509174316.pzuakeu657g3fnlm@home.goodmis.org>
        <20190510122103.5a7bc5416b7af96b27d4fab4@kernel.org>
        <20190510121720.GT2589@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 10 May 2019 14:17:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> But both ftrace and retprobes are at C function call boundaries.
> Preserving flags doesn't make sense.

I agree, but I did it just because of my OCD and being complete in
"emulating an int3" for ftrace_regs_caller ;-)

Yeah, we can remove the popfl from the ftrace trampoline.

-- Steve
