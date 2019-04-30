Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E95ED7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 02:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfD3AIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 20:08:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:63094 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbfD3AIs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 20:08:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 17:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="166213404"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2019 17:08:46 -0700
Date:   Mon, 29 Apr 2019 17:08:46 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190430000846.GG31379@linux.intel.com>
References: <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com>
 <20190429220814.GF31379@linux.intel.com>
 <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 03:22:09PM -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019 at 3:08 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > FWIW, Lakemont (Quark) doesn't block NMI/SMI in the STI shadow, but I'm
> > not sure that counters the "horrible errata" statement ;-).  SMI+RSM saves
> > and restores STI blocking in that case, but AFAICT NMI has no such
> > protection and will effectively break the shadow on its IRET.
> 
> Ugh. I can't say I care deeply about Quark (ie never seemed to go
> anywhere), but it's odd. I thought it was based on a Pentium core (or
> i486+?). Are you saying those didn't do it either?

It's 486 based, but either way I suspect the answer is "yes".  IIRC,
Knights Corner, a.k.a. Larrabee, also had funkiness around SMM and that
was based on P54C, though I'm struggling to recall exactly what the
Larrabee weirdness was.

> I have this dim memory about talking about this with some (AMD?)
> engineer, and having an alternative approach for the sti shadow wrt
> NMI - basically not checking interrupts in the instruction you return
> to with 'iret'. I don't think it was even conditional on the "iret
> from NMI", I think it was basically any iret also did the sti shadow
> thing.
> 
> But I can find no actual paper to back that up, so this may be me just
> making sh*t up.

If Intel CPUs ever did anything like that on IRET it's long gone.

> > KVM is generally ok with respect to STI blocking, but ancient versions
> > didn't migrate STI blocking and there's currently a hole where
> > single-stepping a guest (from host userspace) could drop STI_BLOCKING
> > if a different VM-Exit occurs between the single-step #DB VM-Exit and the
> > instruction in the shadow.  Though "don't do that" may be a reasonable
> > answer in that case.
> 
> I thought the sti shadow blocked the single-step exception too? I know
> "mov->ss" does block debug interrupts too.

{MOV,POP}SS blocks #DBs, STI does not.

> Or are you saying that it's some "single step by emulation" that just
> miss setting the STI_BLOCKING flag?

This is the case I was talking about for KVM.  KVM supports single-stepping
the guest from userpace and uses EFLAGS.TF to do so (since it works on both
Intel and AMD).  VMX has a consistency check that fails VM-Entry if
STI_BLOCKING=1, EFLAGS.TF==1, IA32_DEBUGCTL.BTF=0 and there isn't a pending
single-step #DB, and so KVM clears STI_BLOCKING immediately before entering
the guest when single-stepping the guest.  If a VM-Exit occurs immediately
after VM-Entry, e.g. due to hardware interrupt, then KVM will see
STI_BLOCKING=0 when processing guest events in its run loop and will inject
any pending interrupts.

I *think* the KVM behavior can be fixed, e.g. I'm not entirely sure why KVM
takes this approach instead of setting PENDING_DBG.BS, but that's probably
a moot point.
