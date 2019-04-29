Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6BAEC81
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 00:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfD2WIR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 18:08:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:37256 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbfD2WIR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 18:08:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 15:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,411,1549958400"; 
   d="scan'208";a="166186098"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2019 15:08:15 -0700
Date:   Mon, 29 Apr 2019 15:08:15 -0700
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
Message-ID: <20190429220814.GF31379@linux.intel.com>
References: <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net>
 <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 01:16:10PM -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019 at 12:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > If nmi were to break it, it would be a cpu bug. I'm pretty sure I've
> > seen the "shadow stops even nmi" documented for some uarch, but as
> > mentioned it's not necessarily the only way to guarantee the shadow.
> 
> In fact, the documentation is simply the official Intel instruction
> docs for "STI":
> 
>     The IF flag and the STI and CLI instructions do not prohibit the
>     generation of exceptions and NMI interrupts. NMI interrupts (and
>     SMIs) may be blocked for one macroinstruction following an STI.
> 
> note the "may be blocked". As mentioned, that's just one option for
> not having NMI break the STI shadow guarantee, but it's clearly one
> that Intel has done at times, and clearly even documents as having
> done so.
> 
> There is absolutely no question that the sti shadow is real, and that
> people have depended on it for _decades_. It would be a horrible
> errata if the shadow can just be made to go away by randomly getting
> an NMI or SMI.

FWIW, Lakemont (Quark) doesn't block NMI/SMI in the STI shadow, but I'm
not sure that counters the "horrible errata" statement ;-).  SMI+RSM saves
and restores STI blocking in that case, but AFAICT NMI has no such
protection and will effectively break the shadow on its IRET.

All other (modern) Intel uArchs block NMI in the shadow and also enforce
STI_BLOCKING==0 when injecting an NMI via VM-Enter, i.e. prevent a VMM
from breaking the shadow so long as the VMM preserves the shadow info.

KVM is generally ok with respect to STI blocking, but ancient versions
didn't migrate STI blocking and there's currently a hole where
single-stepping a guest (from host userspace) could drop STI_BLOCKING
if a different VM-Exit occurs between the single-step #DB VM-Exit and the
instruction in the shadow.  Though "don't do that" may be a reasonable
answer in that case.
