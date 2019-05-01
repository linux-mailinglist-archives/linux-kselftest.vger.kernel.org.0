Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24610C96
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfEASID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 14:08:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43251 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEASID (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 14:08:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id i68so13504980lfi.10
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1/pQlD+UKjcy9BQef1uO7G8NLgF3ClUu5utleWV5U8=;
        b=SD+L1zZxq3h7DQlOdVxAz8bLmC20f34sU3I1jlvMvjehPVfqTcXtJ+Hwy0wlTmDIe5
         ZLaHqL3C8OOgHUXO6bwxpGoSuwoZz3oAEkyG+sz7yDMhvcRmvy06STay7znm1I1QvhVO
         zhHdFU/CRi9/1FtAUFa9dZP2Hcbq7SwkLVz84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1/pQlD+UKjcy9BQef1uO7G8NLgF3ClUu5utleWV5U8=;
        b=ht2Z2KBBYl67ZEqTWjGkv0mMpnJeigZSGpXv/TBUG/f1+nm6Tlf1tLLmFxddQ73w2H
         3sSAXxpDREPUPOBI0NbU/fxWp2jP7Wd/QnAIs7RcoyIqcM94TrLmxMxkWzmqiRIg12oq
         1RRQnt8u7Rw/KMYR4Drgn+zhBbEu6yhJ9MjnX8qJlsWFcG+3b1pTcC13227qwWzcTvd1
         mG8Iv1lbpD0i0DHbFDkWjnIQw1566ef/550p7sC+drPV27GJNSqFw5BWem0xDtemZgh4
         mFUj4kj5fmOxMX/4FIGlJJAp+ebf9e3UYNA27aflErKAYBuJt5i4sPUY6n+GBTsv9QaN
         Gj/Q==
X-Gm-Message-State: APjAAAVRSyhjEuJeOClCso4ovgjgnGArMcxV4Y6Sw8CScaQlU/Uxssx2
        s7uR623+dAjr/y+fx4WQVFJ4vFiVxic=
X-Google-Smtp-Source: APXvYqxvXyJp6mtaUYi0RKjcWVFCzCLuJsvtJeoxyblWL2lUJjC7emB3cIScuX496Z47wbipa6yZLw==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr39196755lfm.32.1556734081282;
        Wed, 01 May 2019 11:08:01 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t4sm2716198ljd.22.2019.05.01.11.08.00
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:08:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b12so14955950lji.4
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2019 11:08:00 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr39363092lja.125.1556733683510;
 Wed, 01 May 2019 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190501113238.0ab3f9dd@gandalf.local.home>
In-Reply-To: <20190501113238.0ab3f9dd@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 11:01:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
Message-ID: <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

This looks sane to me, although I'm surprised that we didn't already
have an annotation for the nonstandard stack frame for asm files. That
probably would be cleaner in a separate commit, but I guess it doesn't
matter.

Anyway, I'm willing to consider the entry code version if it looks a
_lot_ simpler than this (so I'd like to see them side-by-side), but
it's not like this looks all that complicated to me either.

               Linus
