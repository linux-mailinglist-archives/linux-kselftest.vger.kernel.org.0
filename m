Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6A121B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 20:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEBSKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 14:10:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41812 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEBSKn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 14:10:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so2569424lfb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XO+Zlh5OfgsxKPXw6nrLGh0MdRFOFwIafTJLR0kldnk=;
        b=e6CwPUpEdJ9HB9TpIWcHmbxuXkXB0tjXiE9LQCN7gSHPP80yow7acWCfXNiqcj8IHi
         4gl44pCGLrAB/tvwbllzaa4dl64fl7TnbOotFQ668wqUF0cSxM3+zN1q72KaCH9jZUiQ
         fus4OOganySkp4Rhyvc2a1f3it518rB/oX8hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XO+Zlh5OfgsxKPXw6nrLGh0MdRFOFwIafTJLR0kldnk=;
        b=AqfIOU4it83S7fPqivSdXoAxlUAQED15wwS5WzVdTk7kRk3S37qXy/xH/x7Eh1dXg1
         TGk640QEshbAtFq+H3ipMK2Mg6U5Ut8kiWnje7B0BqCWIPki7GOUq38vTLCDOPT6lrTL
         QsWzBxk6kgLzyHJEHBqxLuLhL7BrRnqATByCVRXt0+8AwtBfjI6ESn8aayZqMBMMpUrn
         cELmwsfRr0hGN3rXyd8RE6yjrPkaXBdaoT4zXFSFtWIwmM+gcUDAPr656EkgqEXg1bLj
         7Cb1XHYl4ud0PSgYJe8Rbw/4bq1zjklIomCg+9JMk7TBnWwkq3ZUclZ+BbshQscR6Ms7
         u4Aw==
X-Gm-Message-State: APjAAAUuAnktDY8wSUayqImcHZwbd8QHwRMfUel2JTTvLeraxBYUrH1A
        MS3pFCDsyywv9kpnYENVFbo/8k2nI5Q=
X-Google-Smtp-Source: APXvYqxpucHr3XQGA0+3YLKqkMIwFiFoWfNWoUiKuod4ckGQ3NhlJ1N60hTlhBeddf0Re5hPnlkePg==
X-Received: by 2002:a19:cc95:: with SMTP id c143mr2720647lfg.138.1556820641057;
        Thu, 02 May 2019 11:10:41 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q125sm4809845ljb.76.2019.05.02.11.10.40
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:10:40 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d8so2569373lfb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 11:10:40 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr2692667lfb.11.1556820176647;
 Thu, 02 May 2019 11:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190502162133.GX2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 May 2019 11:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
Message-ID: <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
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

On Thu, May 2, 2019 at 9:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> TL;DR, on x86_32 kernel->kernel IRET frames are only 3 entries and do
> not include ESP/SS, so not only wasn't regs->sp setup, if you changed it
> it wouldn't be effective and corrupt random stack state.

Indeed, the 32-bit case for same-RPL exceptions/iret is entirely
different, and I'd forgotten about that.

And honestly, this makes the 32-bit case much worse. Now the entry
stack modifications of int3 suddenly affect not just the entry, but
every exit too.

This is _exactly_ the kind of subtle kernel entry/exit code I wanted
us to avoid.

And while your code looks kind of ok, it's subtly buggy. This sequence:

+       pushl   %eax
+       movl    %esp, %eax
+
+       movl    4*4(%eax), %esp         # restore (modified) regs->sp
+
+       /* rebuild IRET frame */
+       pushl   3*4(%eax)               # flags
+       pushl   2*4(%eax)               # cs
+       pushl   1*4(%eax)               # ip
+
+       andl    $0x0000ffff, 4(%esp)    # clear high CS bits
+
+       movl    (%eax), %eax            # restore eax

looks very wrong to me. When you do that "restore (modified)
regs->sp", isn't that now resetting %esp to the point where %eax now
points below the stack? So if we get an NMI in this sequence, that
will overwrite the parts you are trying to copy from?

Am I missing something? doesn't it need to be done something like

  pushl %eax
  pushl %ecx
  movl 20(%esp),%eax   # possibly modified regs->sp
  movl 16(%esp),%ecx   # flags
  movl %ecx,-4(%eax)
  movl 12(%esp),%ecx   # cs
  movl %ecx,-8(%eax)
  movl 8(%esp),%ecx   # ip
  movl %ecx, -12(%eax)
  movl 4(%esp),%ecx   # eax
  movl %ecx, -16(%eax)
  popl %ecx
  lea -16(%eax),%esp
  popl %eax

(NOTE NOTE NOTE I might have gotten the offsets and the direction of
the moves *completely* wrong, this is not a serious patch, it's meant
as a "something like this" thing!!)

But now I confused myself, and maybe I'm wrong.

                   Linus
