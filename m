Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD36EB7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfD2UQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 16:16:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46641 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfD2UQD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 16:16:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so8868699lfj.13
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klpGGVlaux40qrg5TuBwipJksiZuTXXgkF+MhiSRIlA=;
        b=TcY9IXe9CfLqn42qUjL9P1ySMDeddDODCyvYowl1cSTLiBSIL5Qts+yxj2tJATyscS
         VuMBIQMZJ9FcZ/bxb46xlQLqbBowZnvy4pBLmtOnwzxLeSB2LeNEj9ycOUiKVGex0PQ0
         7w5rqat134L6eKheTJLzUXWSjYZJq/e/a7oNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klpGGVlaux40qrg5TuBwipJksiZuTXXgkF+MhiSRIlA=;
        b=eiUHNI6Ro3AFBUKQOqt5q99DbhN+6g1J0Q1UPJ5Tzuw0DXf8IVKyvsJYf4KCOWz3lJ
         It1qa5YaB/D9rTZod/C3zqbG0hKJAEIVbmcETK/wBd+Rv8NcIJNVlfZ8d8Mp0ActiFWt
         aet1e7hFz/V7vDd7JmVqoFEJzHt0RYxnCayP23j1WinXVkhaTdBkqusyDcoCzoaXCnTm
         LJqI4Nqg1L333RLRAYY/n/Kp63vg//+jll0DjBKiC1dzxBws3GZPK/55DFyAk3TXWH+O
         DIn7VMxQjEMvWIREdN0FrnfupwYcGeeUGe1x3XMJip0MQC/F2JXEt5R833L4j1VYETgy
         D+MQ==
X-Gm-Message-State: APjAAAVckkftz0khSlcH35iRNqEZl0YL94aE7nCUnRsKS7wTxcBSsbP9
        mTKJbapOhwUqvq5oOr/kqOeeqNpROr8=
X-Google-Smtp-Source: APXvYqxe8M7DwO1qfWngLWmGRaPAmVjFR0Fzmm0UphXh6vcktlMtNgaS5RKvo/jUmw67e9Mv3/J5RQ==
X-Received: by 2002:a19:f705:: with SMTP id z5mr12688791lfe.93.1556568960730;
        Mon, 29 Apr 2019 13:16:00 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 28sm127637ljw.82.2019.04.29.13.15.59
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:16:00 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f23so10649898ljc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 13:15:59 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr33222307lji.94.1556568469873;
 Mon, 29 Apr 2019 13:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com> <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
In-Reply-To: <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:07:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
Message-ID: <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 12:24 PM Andy Lutomirski <luto@kernel.org> wrote:
> > Side note: we *already* depend on sti shadow working in other parts of the kernel, namely sti->iret.
>
> Where?  STI; IRET would be nuts.

Sorry, not 'sti;iret' but 'sti;sysexit'

> before commit 4214a16b02971c60960afd675d03544e109e0d75
>     x86/asm/entry/64/compat: Use SYSRETL to return from compat mode SYSENTER
>
> we did sti; sysxit, but, when we discussed this, I don't recall anyone
> speaking up in favor of the safely of the old code.

We still have that sti sysexit in the 32-bit code.

                     Linus
