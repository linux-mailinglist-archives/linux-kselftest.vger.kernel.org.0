Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3208FF45B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfD3KlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 06:41:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3KlN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 06:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IZiM2+o2VGvA+DVuI0MctarcitXRLfQyhwp7WYOEROw=; b=GIZF5F8jcoqODBnIvbMHAj3ti
        B04LUwrtMM0GdJpQuH4cIkyXlCrWnR29XIyYwpbEMg7lkYdu9oGCt9rSOsFFWA9sp1bkLWxLphy40
        yerH08i1+0n6avdbFU6l3zmY5Vbfrqh2d6Y3Gxf0euML+yMujdUJIBazip9paHl00uj/QhTuIQVI5
        Sw8YAPVFc47hOmowJOsOov6JHCtlM1oT7GGCNBjsnP5NhlqZVBHk0bL/SK73qE8R2+8FJfccpZCA6
        9rlKqZhoOL1z+9fxo+36GqXUhWHId00VM1xtOWYmVwLG84RRTtJQyMnaN/lWBDQETXpCFPv3ziUA7
        uki7q1mKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQBZ-0008Ac-Hl; Tue, 30 Apr 2019 10:40:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02C8A203E886A; Tue, 30 Apr 2019 12:40:26 +0200 (CEST)
Date:   Tue, 30 Apr 2019 12:40:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
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
Message-ID: <20190430104026.GQ2623@hirez.programming.kicks-ass.net>
References: <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com>
 <20190429220814.GF31379@linux.intel.com>
 <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
 <20190430000846.GG31379@linux.intel.com>
 <20190430004504.GH31379@linux.intel.com>
 <CAHk-=wjXHfVkrO6ftk9FGtAbpCsaEBa+tGrC8qjV6RUJHu+pCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXHfVkrO6ftk9FGtAbpCsaEBa+tGrC8qjV6RUJHu+pCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 07:26:02PM -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019 at 5:45 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Mon, Apr 29, 2019 at 05:08:46PM -0700, Sean Christopherson wrote:
> > >
> > > It's 486 based, but either way I suspect the answer is "yes".  IIRC,
> > > Knights Corner, a.k.a. Larrabee, also had funkiness around SMM and that
> > > was based on P54C, though I'm struggling to recall exactly what the
> > > Larrabee weirdness was.
> >
> > Aha!  Found an ancient comment that explicitly states P5 does not block
> > NMI/SMI in the STI shadow, while P6 does block NMI/SMI.
> 
> Ok, so the STI shadow really wouldn't be reliable on those machines. Scary.
> 
> Of course, the good news is that hopefully nobody has them any more,
> and if they do, they presumably don't use fancy NMI profiling etc, so
> any actual NMI's are probably relegated purely to largely rare and
> effectively fatal errors anyway (ie memory parity errors).

We do have KNC perf support, if that chip has 'issues'...

Outside of that, we only do perf from P6 onwards. With P4 support being
in dubious shape, because it's massively weird and 'nobody' still has
those machines.
