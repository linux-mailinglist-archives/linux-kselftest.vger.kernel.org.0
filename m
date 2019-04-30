Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5885F549
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfD3LRt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 07:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfD3LRt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 07:17:49 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2480D20835;
        Tue, 30 Apr 2019 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556623067;
        bh=PtfulNUaJLLywP5xlpcAi2iOzN+sMQGoYXae126xyEw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UJu/qALr2X37S4uSnhUW2YPTSJGbDsV0ehhgOoNB0/7P4D/qpnZCF8zNn7TkwcW4G
         Z9E0U4pz6pFJ3VyNAleHSgmj5LGoVQ3G7RyZzF1Hsc19X7p/SjB3s2JLrDCM3z+V+Y
         b/MfW1beOXMcCaxTcr5uW75TzV5lbwzhE6pt2AQU=
Date:   Tue, 30 Apr 2019 13:17:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
In-Reply-To: <CAHk-=wjXHfVkrO6ftk9FGtAbpCsaEBa+tGrC8qjV6RUJHu+pCg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1904301312080.9803@cbobk.fhfr.pm>
References: <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com> <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com> <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com> <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com> <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com> <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com> <20190429220814.GF31379@linux.intel.com>
 <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com> <20190430000846.GG31379@linux.intel.com> <20190430004504.GH31379@linux.intel.com> <CAHk-=wjXHfVkrO6ftk9FGtAbpCsaEBa+tGrC8qjV6RUJHu+pCg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 Apr 2019, Linus Torvalds wrote:

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
> Of course, the good news is that hopefully nobody has them any more, and 
> if they do, they presumably don't use fancy NMI profiling etc, so any 
> actual NMI's are probably relegated purely to largely rare and 
> effectively fatal errors anyway (ie memory parity errors).

FWIW, if that thing has local apic (I have no idea, I've never seen Quark 
myself), then NMIs are used to trigger all-cpu backtrace as well. Which 
still can be done in situations where the kernel is then expected to 
continue running undisrupted (softlockup, sysrq, hung task detector, ...).

Nothing to really worry about in the particular case of this HW perhaps, 
sure.

-- 
Jiri Kosina
SUSE Labs

