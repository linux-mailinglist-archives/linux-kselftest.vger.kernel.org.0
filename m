Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9C178F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfEHL6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 07:58:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfEHL6I (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 07:58:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 620AF3087948;
        Wed,  8 May 2019 11:58:08 +0000 (UTC)
Received: from treble (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFBA4123;
        Wed,  8 May 2019 11:58:01 +0000 (UTC)
Date:   Wed, 8 May 2019 06:57:59 -0500
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
Subject: Re: [RFC][PATCH 4/4] x86_32: Provide consistent pt_regs
Message-ID: <20190508115759.yvxjgsqriez4z22l@treble>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.832694080@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508080612.832694080@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 08 May 2019 11:58:08 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 08, 2019 at 09:49:05AM +0200, Peter Zijlstra wrote:
> Currently pt_regs on x86_32 has an oddity in that kernel regs
> (!user_mode(regs)) are short two entries (esp/ss). This means that any
> code trying to use them (typically: regs->sp) needs to jump through
> some unfortunate hoops.
> 
> Change the entry code to fix this up and create a full pt_regs frame.
> 
> This then simplifies:
> 
>   - ftrace
>   - kprobes
>   - stack unwinder
>   - ptrace
>   - kdump
>   - kgdb
> 
> Hated-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_32.S         |  105 ++++++++++++++++++++++++++++++++++----
>  arch/x86/include/asm/kexec.h      |   17 ------
>  arch/x86/include/asm/ptrace.h     |   17 ------
>  arch/x86/include/asm/stacktrace.h |    2 
>  arch/x86/kernel/crash.c           |    8 --
>  arch/x86/kernel/ftrace_32.S       |   81 ++++++++++++++++-------------
>  arch/x86/kernel/kgdb.c            |    8 --
>  arch/x86/kernel/kprobes/common.h  |    4 -
>  arch/x86/kernel/kprobes/core.c    |   29 ++++------
>  arch/x86/kernel/kprobes/opt.c     |   20 ++++---
>  arch/x86/kernel/process_32.c      |   16 +----
>  arch/x86/kernel/ptrace.c          |   29 ----------
>  arch/x86/kernel/time.c            |    3 -
>  arch/x86/kernel/unwind_frame.c    |   32 +----------
>  arch/x86/kernel/unwind_orc.c      |    2 
>  15 files changed, 181 insertions(+), 192 deletions(-)

Very nice diffstat.  This moves all the pain to the 32-bit entry code
where it belongs.

-- 
Josh
