Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB2F17360
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEHIMz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 04:12:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEHIMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 04:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tvP/6NuFlFM89pXE/PuYGYzrB1plsvWPob9WkJA9B2Q=; b=mqZ5E0l90NUp+w1nYgpdRsdq9
        CyRcegZTrwBH9+BgwX6fByfyCCTL8aM7JRdhqK6ehkdpe2mfoSlJV+S2LI8hBUQsm2s/kk8y179iw
        UPeQopLSFpMAbQcRYzxBe831tEtkmk2vCAROU+atYxkhmUMZolsxny/yUta8R2MMlP0fMaC0OpWA5
        /bIS/gvqVSFB/RcNFF7tcQ2A7YLXpw+XgS49JUzVrhD2Lq15u9ZLxU/kvFSryjsVY5+WJjFwFNE9F
        uERBebXSfb+PJabv1qMzznPuU7sD3ocZvZhVDqP5lR3bF/zoLIfU5GOTTv7nIIxaZ4E5vjgCl/Ysy
        q67qwyK3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOHgM-000453-L9; Wed, 08 May 2019 08:12:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 26E552029F87A; Wed,  8 May 2019 10:12:05 +0200 (CEST)
Message-Id: <20190508074901.982470324@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 09:49:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/4] x86: int3 fallout
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

So the first 3 patches are cleanups and fixes and should probably just go in.

The last patch however is the one Linus hates, it converts i386 to always have
a complete pt_regs. Both Josh and me did a bunch of cleanups and the patch is
now a net reduction in lines.

I still think it is the right thing to do; it removes a whole lot of magic from
the C code (and avoids future surprises), but if this cannot convince Linus,
I'll not pursue this further.

