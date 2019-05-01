Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C710CEA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 20:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfEAS6D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 14:58:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEAS6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 14:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3CoCMxRNI5B81hO4bBNVrThAA9Fq27JtsrjXALFMYvM=; b=fm9qS77Vw7+9yE2lMBrpxLtZj
        oEyoU6pcvTlYigA8B7sutWVGYJzn0tgwf8z0dXBIxzgiXLy/voa4x7O0lTiK0X6XJFbhSLcE+2t0D
        h+MELCRu7dNUdXyKI0+zXNcV2FYVRW5O3qBsZOk+fuuCnFO+ayo9NB2QwATFkn9bzoEgzHrzhmOIX
        /4dWzIkIdBFz5R/3/HGFzb24EOnhAmtUOUqfUff8ugc6lCuM5UZQTPztHV5w0aegeWLSBY5iYrzZU
        v3kdgMt5rme6EAHc1qA6v0Cd233xRrBjV5jhbrS16kNy3pyrVYylNabEjFF0a+YsW3enmcTuULWOI
        Gs9fHE7rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLuQ6-0007pZ-C0; Wed, 01 May 2019 18:57:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC946984EB4; Wed,  1 May 2019 20:57:26 +0200 (CEST)
Date:   Wed, 1 May 2019 20:57:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
Message-ID: <20190501185726.GR7905@worktop.programming.kicks-ass.net>
References: <20190501113238.0ab3f9dd@gandalf.local.home>
 <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 01, 2019 at 11:01:07AM -0700, Linus Torvalds wrote:
> This looks sane to me, although I'm surprised that we didn't already
> have an annotation for the nonstandard stack frame for asm files. That
> probably would be cleaner in a separate commit, but I guess it doesn't
> matter.
> 
> Anyway, I'm willing to consider the entry code version if it looks a
> _lot_ simpler than this (so I'd like to see them side-by-side), but
> it's not like this looks all that complicated to me either.

So I posted one earlier today:

  https://lkml.kernel.org/r/20190501131117.GW2623@hirez.programming.kicks-ass.net

it's about a 1/3rd the number of lines and has 32bit support. It also
provides all the bits required to implement static_call().

That is; I think I'm firmly in favour of the entry variant -- provided
it actually works of course.
