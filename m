Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD88ECC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfD2W3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 18:29:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44822 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfD2W3I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 18:29:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id h18so9109264lfj.11
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zppnOAypDVs0+r50a/pgPPi939wuWm5h1LCIlM9HNjM=;
        b=QGBVwSJZ+kKUqIc42rXPpG7fGPox/UQOJvcW9dOTrKQfMY8buV4dJTLpAAWokmELmK
         1QZP7Kjs19NM9LlDsb1C2eVy/w/POK2OPqqQq5iTLBCRv0p0etTN59O7wWkp7HYo9QnX
         W/o3H6va7lHP1PpJd24/V6e9rjLzYhqt6DdjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zppnOAypDVs0+r50a/pgPPi939wuWm5h1LCIlM9HNjM=;
        b=M9UmS05KDE3bs6TN6bzHczZNQ0AtCF+7R+4chqiKzxtMpctL2xFIHnND6LgukzEj4n
         2Ya+2mxUH2hCZUbHrkgCsXZ7o23v6dPamWnZVMUYX9AQRe0mWkQrvhvnv+CDlBxjjN3p
         EXZdtAt1AMSpr70EI0tqV5G7zparDrCWFg2tIlPLQiATUEtbRzKfiaa5y9LRcfb1k38+
         UtpH0SgOVWB0X7ElVg5cnyFUO3jXUgskBoUD+OvX+L47loteUhls52l5BMadIpxBkTDT
         g++HZ8+E8zHnAmDiZYOXAaavbM63a44/l+a9jIgCeCCk9KsJNpavMCna5otlmFKVzO7/
         wWYg==
X-Gm-Message-State: APjAAAX2gQOts51f3Mv+sAPGP0SsXZA3kP9FVbNzF1IPQSdgIpTWPVRX
        ZhCl4WMcrfUbrhZR1RigZgTOxFxn8JQ=
X-Google-Smtp-Source: APXvYqwSK2R0q59o1rxUJEKhTn1Mv/XK+4Stp7SSL+G4PN0QWV7ncfHD7zGMhc+diw+jnfpMcLAKMg==
X-Received: by 2002:a19:a417:: with SMTP id q23mr33453205lfc.110.1556576945205;
        Mon, 29 Apr 2019 15:29:05 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 12sm606145ljj.79.2019.04.29.15.29.04
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:29:04 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j11so9292178lfm.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 15:29:04 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr33003752lfa.136.1556576545296;
 Mon, 29 Apr 2019 15:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-4-nstange@suse.de> <20190427102657.GF2623@hirez.programming.kicks-ass.net>
 <20190428133826.3e142cfd@oasis.local.home> <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com> <20190429220814.GF31379@linux.intel.com>
In-Reply-To: <20190429220814.GF31379@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 15:22:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
Message-ID: <CAHk-=whpq2=f2LdB-nc52Rd=iZkUH-N-r8OTqEfo+4UaJc7piA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Mon, Apr 29, 2019 at 3:08 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> FWIW, Lakemont (Quark) doesn't block NMI/SMI in the STI shadow, but I'm
> not sure that counters the "horrible errata" statement ;-).  SMI+RSM saves
> and restores STI blocking in that case, but AFAICT NMI has no such
> protection and will effectively break the shadow on its IRET.

Ugh. I can't say I care deeply about Quark (ie never seemed to go
anywhere), but it's odd. I thought it was based on a Pentium core (or
i486+?). Are you saying those didn't do it either?

I have this dim memory about talking about this with some (AMD?)
engineer, and having an alternative approach for the sti shadow wrt
NMI - basically not checking interrupts in the instruction you return
to with 'iret'. I don't think it was even conditional on the "iret
from NMI", I think it was basically any iret also did the sti shadow
thing.

But I can find no actual paper to back that up, so this may be me just
making sh*t up.

> KVM is generally ok with respect to STI blocking, but ancient versions
> didn't migrate STI blocking and there's currently a hole where
> single-stepping a guest (from host userspace) could drop STI_BLOCKING
> if a different VM-Exit occurs between the single-step #DB VM-Exit and the
> instruction in the shadow.  Though "don't do that" may be a reasonable
> answer in that case.

I thought the sti shadow blocked the single-step exception too? I know
"mov->ss" does block debug interrupts too.

Or are you saying that it's some "single step by emulation" that just
miss setting the STI_BLOCKING flag?

                   Linus
