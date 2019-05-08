Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2E179AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEHMqv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 08:46:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51848 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEHMqv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 08:46:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id o189so3147386wmb.1;
        Wed, 08 May 2019 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bm1cOOnpCkh2FlDqhwYvU0/AEyKSRffy/xUjCrLDeZ8=;
        b=nuMdcRX6WR7VhmoHMpuxcaTYW1dmox9Kge7s+s8Zh+5rBMmSymZlctQ5NZkKzFT8iu
         xF35GgZfVb6Oo3fA8I8Kaf04a5nqtVkTMyub31HP1pwFnbFlGRSERsZ9nrT+HZQYMgZf
         /gzWUGfeqIs8YxFQsEQIabRBuBFvcV5S8EMXckkWRAWoH2uj+vssikcFu4od859QUffx
         kHhvxtQUx4vp+TeZqeJ1Z8nUg9PQPIj+lDkjwSPZaTiPT3fUTxl796POe4kr4yx2tHFI
         rLa3zJTbQpYFBD9Ev+eC02s19os/xeRYbi09ALvOoRZhupOsuJLv49ot78vZj5EQXGtv
         6Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bm1cOOnpCkh2FlDqhwYvU0/AEyKSRffy/xUjCrLDeZ8=;
        b=pKIrm5UkjCexM6CNI/TlymbBClCKz4Wrh+DvM5wUB/Me9RHgs67+CrkLzoytHVQjuA
         +MR/XfupAncIsSRJZlgOYPy1BxUBTLFaZFxOc0WFmqArXvoU0pccfE4AM8KFB5QQdKWx
         VNPP1D+oHUCSorzbWq+9yDKDAjcDYdkC8dT5i2kNNAQM30+296xYxllAy1b255IkuqVY
         mgGRhkDEM6Xb1ZnvChsv0tzLdyykszsgbVmqXFSvtigAV2fLpeTTEVLyb5XZ/rc83rtc
         IFkGyhHPZ2MPHvqMkH3BwwVkng/O/G4xUKhXT9TjL2lVXF8PFyS4g9BjCDPQRg9R+pPM
         lXUg==
X-Gm-Message-State: APjAAAV5cu+7AsYYzhieNhbaa/3tCdhOX/HTCqslLDnT90PVTuTYrSUd
        kXPclHjQtghCdODSa1WVXTI=
X-Google-Smtp-Source: APXvYqwUU1y1pe4s72bwQcNoxCebumtEv6ZDDo306mjX8AQjvF5HwCY+MM0cy+C369LDLTUR9c5YzA==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr3180470wmg.30.1557319609169;
        Wed, 08 May 2019 05:46:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o13sm30605972wrg.40.2019.05.08.05.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 05:46:48 -0700 (PDT)
Date:   Wed, 8 May 2019 14:46:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20190508124645.GA76848@gmail.com>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.832694080@infradead.org>
 <20190508115759.yvxjgsqriez4z22l@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508115759.yvxjgsqriez4z22l@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, May 08, 2019 at 09:49:05AM +0200, Peter Zijlstra wrote:
> > Currently pt_regs on x86_32 has an oddity in that kernel regs
> > (!user_mode(regs)) are short two entries (esp/ss). This means that any
> > code trying to use them (typically: regs->sp) needs to jump through
> > some unfortunate hoops.
> > 
> > Change the entry code to fix this up and create a full pt_regs frame.
> > 
> > This then simplifies:
> > 
> >   - ftrace
> >   - kprobes
> >   - stack unwinder
> >   - ptrace
> >   - kdump
> >   - kgdb
> > 
> > Hated-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/entry/entry_32.S         |  105 ++++++++++++++++++++++++++++++++++----
> >  arch/x86/include/asm/kexec.h      |   17 ------
> >  arch/x86/include/asm/ptrace.h     |   17 ------
> >  arch/x86/include/asm/stacktrace.h |    2 
> >  arch/x86/kernel/crash.c           |    8 --
> >  arch/x86/kernel/ftrace_32.S       |   81 ++++++++++++++++-------------
> >  arch/x86/kernel/kgdb.c            |    8 --
> >  arch/x86/kernel/kprobes/common.h  |    4 -
> >  arch/x86/kernel/kprobes/core.c    |   29 ++++------
> >  arch/x86/kernel/kprobes/opt.c     |   20 ++++---
> >  arch/x86/kernel/process_32.c      |   16 +----
> >  arch/x86/kernel/ptrace.c          |   29 ----------
> >  arch/x86/kernel/time.c            |    3 -
> >  arch/x86/kernel/unwind_frame.c    |   32 +----------
> >  arch/x86/kernel/unwind_orc.c      |    2 
> >  15 files changed, 181 insertions(+), 192 deletions(-)
> 
> Very nice diffstat.  This moves all the pain to the 32-bit entry code
> where it belongs.

Yes, that's very convincing and looks like a nice simplification of 
32-bit x86 entry concepts overall.

Assuming it's correct, the question is whether Linus still hates it? :-)

Thanks,

	Ingo
