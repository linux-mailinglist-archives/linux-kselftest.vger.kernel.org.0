Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DE15509
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEFUpQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 16:45:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39719 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEFUpP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 16:45:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id z124so4015205lfd.6
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tr1nwcY+Mo7JIjJHKVLKIn3srZa+DVPkvnBKBRzf9s=;
        b=Wx0wBv+MylrKm2tMM2EjzWS61fm9xNahf5H0jqXMieHoP7JIkuDeMOtkWoWb3N/RXa
         zTBuN8pbi5tRyMSpWlaexirS081WZT8udlBXEwXx+fqFNsgl6F0LP8y/LHZSEjMdt26D
         KO9SQD+Phs5cXpErrLaOl8w3aKdvsA9v+duGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tr1nwcY+Mo7JIjJHKVLKIn3srZa+DVPkvnBKBRzf9s=;
        b=lWCfIp78Gjm6YWsxGAci6SAZx8m+mQ/xoq3YLeGut4dedmJL9saCgPZknlc/XgyOeD
         LXl+zJCs1MglPDlDO0AMkfGR6e+EiVucArMIu7fiEMQRpRJhFLyDvNqqD9IYpnaHp969
         e8ZX7A9cmsK0bQ2elixRA5bHydqQobghK+XCUcknLasNex9cOZY/IhpKBedR3qZI5Fsr
         /C63kCZfByol+2Zxtk3GLqs1Bbp4D9jdZM5LXa4X9RnvFIcGy39CtbfbnjBDYD3Szcwx
         Wwa0CKIXP8chSAkQ+SVPA3T725Ek3XoIE3Aptz0YW7nDZfVs/JU49CMr7jDgXIzYosi8
         gxyw==
X-Gm-Message-State: APjAAAUxBDgztgcN2GHFq5vNEEySHkKqe8qBUh38Y+Q+B1mw1oU9vRl+
        Djau3iQs87Imyg29J6CJimcKYuNzBP0=
X-Google-Smtp-Source: APXvYqzs0eiwhbXuzEW4icTekJ00zYaGEMAyC4kxucaUZraQZrRszcphos6Eiamcf84LZITZSFEQow==
X-Received: by 2002:ac2:51a9:: with SMTP id f9mr5814760lfk.56.1557175513229;
        Mon, 06 May 2019 13:45:13 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l15sm2622698ljh.62.2019.05.06.13.45.10
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 13:45:12 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f23so12337245ljc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 13:45:10 -0700 (PDT)
X-Received: by 2002:a2e:801a:: with SMTP id j26mr5517472ljg.2.1557175508545;
 Mon, 06 May 2019 13:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 13:44:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsi+FQN6bnued8K4KQ2fF53k0JW4TUY+q0XOJyiULXmw@mail.gmail.com>
Message-ID: <CAHk-=wgsi+FQN6bnued8K4KQ2fF53k0JW4TUY+q0XOJyiULXmw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Mon, May 6, 2019 at 1:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What *can* make sense is "Oh, I'm emulating a call, but I know that
> call will be rewritten, so let me emulate the call and then
> short-circuit the emulation immediately".

That made no sense. The end should have been "and then short-circuit
the _rewriting_ immediately" of course.

The "emulate a call" is just to make the "struct pt_regs" state look
like it would have after the call. The "short circuit the rewriting"
part is the thing that then rewrites the actual instruction based on
that pt_regs state.

                 Linus
