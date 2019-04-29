Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F434EC3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 23:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfD2VqL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 17:46:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36555 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbfD2VqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 17:46:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id y8so4409996ljd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSiV79NBIztMusWk2QP2VKKhKOlea+n31l0AFUl2Bg8=;
        b=ZMLzPqHi9lETwhRL66Ic7OfH6fw2vR3J8CHiKq3pfDQQ78NgprQyY154J6Rqvkqc7s
         C42c14gHHilvBkmQFjpiBuapTUcRjDejOz3oZMhlsRfav1CrKiKeXa5cwy+w5bWoRtOe
         i2ztzqxJfLNJSPQmCXpPj6ttEC4mfbjCWUHRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSiV79NBIztMusWk2QP2VKKhKOlea+n31l0AFUl2Bg8=;
        b=CDcfdrjEiEqiVsilmSCRTznHyJ/oFCSf1FShFUaqnpJSRkb59YjUM3Np15zjqUTy+p
         IgYZb9eHsX7Ig0xhtzw08C1L51RVxl2HhjwINdbYCUGao7u2iiR93ZeHgSqCDJ/VTZn0
         LzFFEl9RQYEuE3qoMx9UIEjrvDaezvxIllNORXNKJDlcL1DfG6oDwfeTzq9+iJ3X4kCe
         kMWxQ/htZ5+9zbk2pmH2gZb4SBiY8bimssGhmING7FE38xVBU8nvQD6NCuc5FB4Y3Ym6
         BIWc3UB8LKJri2SETfmWaDb18kkD49mNxJXzJvkbyJ5hyL8HGijQDIMgNi6jEPSvwzTu
         M5WQ==
X-Gm-Message-State: APjAAAVZ9DDm9w27coAbsz9jLfo6vP0ppwan4Gk0DBV7qBHjSJx55L2k
        +u0PA23fvDg2yNUvszG5xIY68Tp6oq4=
X-Google-Smtp-Source: APXvYqywI9eR5JLtGLDimGzCHuJaiQENPBWYT2BtBrrWH49kBTLGgwpJtJzm9v6OQZB1vKAW8HzogQ==
X-Received: by 2002:a2e:1311:: with SMTP id 17mr33366099ljt.75.1556574369430;
        Mon, 29 Apr 2019 14:46:09 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o3sm7595646lfn.41.2019.04.29.14.46.09
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:46:09 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id s7so8101682ljh.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 14:46:09 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr30631636ljj.79.1556573932539;
 Mon, 29 Apr 2019 14:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <20190429145250.1a5da6ed@gandalf.local.home> <CAHk-=wjm93jLtVxTX4HZs6K4k1Wqh3ujjmapqaYtcibVk_YnzQ@mail.gmail.com>
 <20190429150724.6e501d27@gandalf.local.home> <CAHk-=wgbC-wiSrdDYAh1ORF4EKmecY+MkNsJBF=BWf4W1bXXgA@mail.gmail.com>
 <20190429163043.535f4272@gandalf.local.home>
In-Reply-To: <20190429163043.535f4272@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 14:38:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGquN7-kQCoa+LHCuiVTjefkk38qwaysd4wLLtoSZhpg@mail.gmail.com>
Message-ID: <CAHk-=wjGquN7-kQCoa+LHCuiVTjefkk38qwaysd4wLLtoSZhpg@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 1:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The update from "call custom_trampoline" to "call iterator_trampoline"
> is where we have an issue.

So it has never worked. Just tell people that they have two chocies:

 - you do the careful rewriting, which takes more time

 - you do it by rewriting as nop and then back, which is what
historically has been done, and that is fast and simple, because
there's no need to be careful.

Really. I find your complaints completely incomprehensible. You've
never rewritten call instructions atomically before, and now you
complain about it being slightly more expensive to do it when I give
you the code? Yes it damn well will be slightly more expensive. Deal
with it.

Btw, once again - I several months ago also gave a suggestion on how
it could be done batch-mode by having lots of those small stubs and
just generating them dynamically.

You never wrote that code *EITHER*. It's been *months*.

So now I've written the non-batch-mode code for you, and you just
*complain* about it?

I'm done with this discussion. I'm totally fed up.

                 Linus
