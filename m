Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF22123BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 22:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfEBU5r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 16:57:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43264 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBU5r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 16:57:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id t1so3470825lje.10
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eWa5vFKZPEJ8DW2XaC7JXAPKdGCG2IN2Y9wVvZv45s=;
        b=Cx3zQ0UKjjMz51LsOvr1ic+6VE8tQ4HPzkevgcUly/S86/MNpxZqSG4o20EQv0So+W
         xHmowGihlJAYSjpRF77/Gi8EjbFtkwBPUA5dnvni2jvpBKK7LKBaOoNVRF0Hc3/Mrf0r
         AikJgVeOLVaZ2oVA0t3qkDKimhPFDbi9a26ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eWa5vFKZPEJ8DW2XaC7JXAPKdGCG2IN2Y9wVvZv45s=;
        b=TtvXZufYglvYe4yaGX10OH+7IPOc9GU9xr0vIT57FhTgLuhg/ouF3wPDAx5C1E7bFk
         DHyUyqtzFlmRiQIrKNNFpxxB8pOP5JFPjs7XFGlV/NhEqH3sT9KXXJID7xbE3Bd1Loy0
         2as1AzdUhk688vPpzzbK9KRpW2LCxMpnz+x3O1Wyhp6SBMVNZtd6mY274Q4J2VXLm+D5
         AAdr4tZ2LlajO0vdzAj1fe3qDtcDdWGsO+8trRBeLhqIJlzTV1ECpqI0K07YzomZrpKD
         ENNMW78ooY6SR1iU/zo6iqWPqebfXrAZ+AfgLCqrmIMipU0jmSSMdqYSK8cPC7kQ4tVs
         0PCA==
X-Gm-Message-State: APjAAAXVhG6WC0Y3dtDlPtX6zOBkEPZH9usfOql9TpqmaoUbGFb9L/+8
        4VjsE6PsudzLbcm/DO1pg4Uath5TR98=
X-Google-Smtp-Source: APXvYqxzg3kX35lxgzW/ajD/UlKJsJXc10B6+TZp6OEobPU8WEZ5E1peLhZvc4xy4kr3XHFoRDZlaw==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr3019161lja.68.1556830665163;
        Thu, 02 May 2019 13:57:45 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id s26sm14159ljj.52.2019.05.02.13.57.44
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:57:44 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d8so2910816lfb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 13:57:44 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr3275555lfn.62.1556830185843;
 Thu, 02 May 2019 13:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
 <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190502202146.GZ2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 May 2019 13:49:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
Message-ID: <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 2, 2019 at 1:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like so; it boots; but I could've made some horrible mistake
> (again).

This actually looks much better to me.

Maybe it's more lines (I didn't check), but it's a lot simpler in that
now the magic of the int3 stack doesn't get exposed to anything else.

We *could* also make this kernel-mode-only do_int3() be a special
function, and do something like

        # args: pt_regs pointer (no error code for int3)
        movl %esp,%eax
        # allocate a bit of extra room on the stack, so that
'kernel_int3' can move the pt_regs
        subl $8,%esp
        call kernel_int3
        movl %eax,%esp

and not do any stack switching magic in the asm code AT ALL. We'd do

    struct pt_regs *kernel_int3(struct pt_regs *regs)
    {
        ..
        return regs;
    }

and now you the rule for call emulation ends up being that you need to
"memmove()" the ptregs up and down properly, and return the new
pt_regs pointer.

Hmm? That would simplify the asm code further, but some people might
find it objectionable?

                  Linus
