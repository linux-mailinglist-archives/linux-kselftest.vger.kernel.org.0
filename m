Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590ADEB9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 22:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfD2U21 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 16:28:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35065 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfD2U21 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 16:28:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so10665063ljj.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w50mZSoHkn4YcdVSRzxMDCW63EO0vPkQ2Zrko7ZDpHk=;
        b=AoO6Qi9m5Ef2LQWrXsqnatYGBHOrBL3A+gnuAsmezQFUMAvvmPyPcegTT9th39HlUb
         s0behpUfbgVFRk/qomTxJbvucaUEQ+T1StzlVKWLMf0QmKqLJwshHyUYFwvc5w4cct+e
         ULknvqmm/IVR0Nk7kkerKDJNE3EHy3hhGQff4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w50mZSoHkn4YcdVSRzxMDCW63EO0vPkQ2Zrko7ZDpHk=;
        b=NHw0A6yOu/0+PdTFYLmevjWTXpmMdxNT3DGX+5Vx8+ryZgUNc2rZxufTXOczWIlQjn
         CEYCbYj5WAQA+xOyNoJzxYI2LvQlI0LpOV3Azl1EGBReVDUc8d6HUDISHu5s07xTbL/G
         /MtvnTn1a3uq94JVsBTTnDgbVgmr4O8lipkdm2Vsz27PX+C5zmzzr0yMViMU+MWnRjDg
         KNmXnDVyRrkUOPulhf0Zqp2DWNuyiF7D+Wu0HtUb59aWpl8oI99EwzVoVM3824wliCdP
         DHVGE5lmlarqIGySdTX+dIe98VJ0GqnlptdnigoMmJbCDtxZwzgftWl4pMRGHms110eI
         qx2A==
X-Gm-Message-State: APjAAAWeSA/13LRmrCANUEVWaTjMYf1iiTLXcTcqxBNa5HHqju8FMmv8
        2oWejcf8c8AzDCt8uFw9fkIKzxtXT7s=
X-Google-Smtp-Source: APXvYqyaPZMPxV1itqYOB6aIVU0wxDOISnBEAMLoc+S4+H0boRdn8r4XNdtZJr8Xxx0c/VQzCiFNcw==
X-Received: by 2002:a2e:9c57:: with SMTP id t23mr9014501ljj.152.1556569704630;
        Mon, 29 Apr 2019 13:28:24 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v23sm2162872ljk.14.2019.04.29.13.28.24
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:28:24 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id f23so10682638ljc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 13:28:24 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr8383998ljg.135.1556569221934;
 Mon, 29 Apr 2019 13:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <20190429145250.1a5da6ed@gandalf.local.home> <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
 <20190429150724.6e501d27@gandalf.local.home> <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
In-Reply-To: <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:20:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMG95TmkMm5AK7w73=mn+is8qnNztS7iJVfz23-A44Yg@mail.gmail.com>
Message-ID: <CAHk-=wiMG95TmkMm5AK7w73=mn+is8qnNztS7iJVfz23-A44Yg@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Andy Lutomirski <luto@kernel.org>,
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

On Mon, Apr 29, 2019 at 1:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Only do the 'call' instructions one at a time. Why would you change
> _existing_ code?

Side note: if you want to, you can easily batch up rewriting 'call'
instructions to the same target using the exact same code. You just
need to change the int3 handler case to calculate the
bp_int3_call_return from the fixed one-time address to use sopmething
like

     this_cpu_write(bp_call_return, int3_address-1+bp_int3_call_size);

instead (and you'd need to also teach the function that there's not
just a single int3 live at a time)

                Linus
