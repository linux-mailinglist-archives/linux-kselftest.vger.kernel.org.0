Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73150EACE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfD2TYo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 15:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbfD2TYk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 15:24:40 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FBD217F9
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556565878;
        bh=Fu/hOYIZwVfzmJTjU83cB5kYU+/G8jx9tdKv57qTrFw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DXjxbd2Lmoo7ZhT4rQRWlNx5tEMhMkUhhz6oNcEqKJmks+85LbaOlYELmHhzWnmXw
         t1P35R8xDyDyVPx7mebki/bK7xMFQYVF//VBvJS31jfq0Z83F3sRF6+kJgN2WhRHD1
         1yPl5zKEp0fXgsgRq3kEdoNEfBSDGCCwrnFjQTJw=
Received: by mail-wm1-f50.google.com with SMTP id h11so700886wmb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 12:24:38 -0700 (PDT)
X-Gm-Message-State: APjAAAXfQN8ibnLoGmi9yA2uH4kFhYfVYzDfwxgH2grFNBhbhNlttHgv
        V+TkVQa8Qy09uYNToUV/nAo3cc3pl6t3hXXuic92+w==
X-Google-Smtp-Source: APXvYqyjZBsIOAF7hRXJ3H5ln2FIgXx47NTYjflr71BzIx+w9pLCUNqgqyvcXcorJunBRFnUslFSeqIvc4RKDh2gXiQ=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr415036wmj.83.1556565875080;
 Mon, 29 Apr 2019 12:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com> <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
In-Reply-To: <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Apr 2019 12:24:23 -0700
X-Gmail-Original-Message-ID: <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
Message-ID: <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, Apr 29, 2019 at 12:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>
> On Mon, Apr 29, 2019, 12:02 Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>
>>
>> If nmi were to break it, it would be a cpu bug.
>
>
> Side note: we *already* depend on sti shadow working in other parts of the kernel, namely sti->iret.
>

Where?  STI; IRET would be nuts.

Before:

commit 4214a16b02971c60960afd675d03544e109e0d75
Author: Andy Lutomirski <luto@kernel.org>
Date:   Thu Apr 2 17:12:12 2015 -0700

    x86/asm/entry/64/compat: Use SYSRETL to return from compat mode SYSENTER

we did sti; sysxit, but, when we discussed this, I don't recall anyone
speaking up in favor of the safely of the old code.

Not to mention that the crash we'll get if we get an NMI and a
rescheduling interrupt in this path will be very, very hard to debug.
