Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1A8FAE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfD3N4e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 09:56:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3N4e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 09:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NS87uwDQqCa5ycxzBLjKsw5By0nZC4LG/TYFnxCupVk=; b=H8XTc5j2ZI2Vzp8lcHgyTWodr
        mwzl5LQi5LGfHTMv1K3gjDJxbBwKoNDshvjXn8jdOx/xQ7Yuq+UkY0po0Jlxv8EVlFQ8E1eY/3Db8
        MPKfIuYD3O2UisrYjZ/S5sQBaKs5MtFOK3X2sHwLEmur/IyAGe8Lm0+I3RV2nOJlAzRG1TVFYWT2h
        FUFPC3mnB7yh5aFabW6f7AkR28Qp2qMdPzb2leUPJ6Rc9OvX4LtNnU1tSzN1nwkY59fny3YqvU+wl
        EvOwqe01uzxNZOZVYguRNTgUT1QVxdggMAwU6kjk2bmwqwtC3vtmOD1kN5iusaETy5+He6OVsw0KK
        V1QKStQSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLTEq-00059H-1m; Tue, 30 Apr 2019 13:56:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A4A529B2FDBD; Tue, 30 Apr 2019 15:56:02 +0200 (CEST)
Date:   Tue, 30 Apr 2019 15:56:02 +0200
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
Message-ID: <20190430135602.GD2589@hirez.programming.kicks-ass.net>
References: <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 01:07:33PM -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019 at 12:24 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > Side note: we *already* depend on sti shadow working in other parts of the kernel, namely sti->iret.
> >
> > Where?  STI; IRET would be nuts.
> 
> Sorry, not 'sti;iret' but 'sti;sysexit'
> 
> > before commit 4214a16b02971c60960afd675d03544e109e0d75
> >     x86/asm/entry/64/compat: Use SYSRETL to return from compat mode SYSENTER
> >
> > we did sti; sysxit, but, when we discussed this, I don't recall anyone
> > speaking up in favor of the safely of the old code.
> 
> We still have that sti sysexit in the 32-bit code.

We also have both: "STI; HLT" and "STI; MWAIT" where we rely on the STI
shadow. Getting an NMI in between shouldn't hurt too much, but if that
in turn can lead to an actual interrupt happening, we're up some creek
without no paddle.

Most moden systems don't use either anymore though. As
mwait_idle_with_hints() relies on MWAIT ECX[0]=1 to allow MWAIT to wake
from pending interrupts.
