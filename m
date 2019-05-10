Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41CA19D17
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfEJMR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 08:17:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38110 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 08:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zhu4heSzSl0zciCgHpqHGoWkGn39CgR6C2tptsMuYBM=; b=NGB6qFBt2V87eP39aFFQk44sG
        a1MQSCehHjm4bl0/c9oF9zFoQVP5qo5An72Q+stfXEUeRP6B1tX+JW20CZDdPUSSJXvNKhvjfvAGM
        gKxwWvJggOF/QrQllumc6FPxSjgDRLT1JeZFF+ECEKD2gfBADPwKAtRDXmsBqu8Xmj2a2nDbBe7Zw
        C7QAPemxyDPP9US4Vb+ObnU37O2j/yZT2ZfNwpFOz7r2UBZTccJ70hCMz77IvmRmew+FvQQ7Kjiob
        gPxPNEvdQtPXzJ6M72/5UmG5eeZ3cXboeJXR7q1CNNUKVoHNlv3TSnALh2+6C28w/yemcF/v2SZzi
        X8RLN0Img==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP4Sn-0005Xp-Rz; Fri, 10 May 2019 12:17:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 544722029F1F3; Fri, 10 May 2019 14:17:20 +0200 (CEST)
Date:   Fri, 10 May 2019 14:17:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20190510121720.GT2589@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510122103.5a7bc5416b7af96b27d4fab4@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 10, 2019 at 12:21:03PM +0900, Masami Hiramatsu wrote:
> Yes, optprobe also has to save and restore the flags.
> Above trampline is for kretprobe, which is placed at the function return, so
> we don't have to care about flags.

Sure, optprobe is actually special here, because it branches out at
'random' places and does indeed need to preserve flags.

But both ftrace and retprobes are at C function call boundaries.
Preserving flags doesn't make sense.
