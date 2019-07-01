Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9F157EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 05:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEGDOD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 23:14:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42395 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfEGDOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 23:14:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so10647456lfc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 20:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vPH9I5PWr2TI7X5PE+d7W4anLeW7LWz/OE4YpqPd8k=;
        b=eMRYbWYFmPHyc8hLoVhhlUEKgGTDjH5U4y4GUjFL0QRJ8UTmZq4UYf25wlrtMiMJOo
         aZaKmEpFAHwSky6xN0UwF6xEVDQDS7lUnQRo2Ewz4hbjzvKaF1XxCm25cBfHKnpnn8L1
         SHmoa9QAiN9pzOrwoTZhfnY5bu9mini6zfThg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vPH9I5PWr2TI7X5PE+d7W4anLeW7LWz/OE4YpqPd8k=;
        b=Sy7TcQ7fQ6PU0foIIfqanxzPFB943A2Rjg/GzxXU3q/H9fZU7lbYRg2MJN2YTi12zU
         vfEhEUYC/2Z0jneRKLeLFbYmijDkvYhAphlHim2EVPkPxnuRzZ3GnV4083sMg2xZCdlQ
         6lNHCkkyIXiy6nG8pf0pk9m+JX4Km3ZUkl/5i6M57gjVDs+VsM5+QE/Dzn09SWpPVEwZ
         uoSeUoz9Xi4yYsq7H84RCwRug27kARYRR5/3ARL8NIrMOYrp1jHXz+doGnIfmKjNUEtE
         mznY9X0wKqMJa/HGXOIHQbL8Nt4CaslaMfV+VmzX1Dzl0Xw8qW/vcFWqDuJV+8lFoazo
         yjwA==
X-Gm-Message-State: APjAAAUIHwJKPZuqvPVEbeVnqzFt3kLGXy6UiByciEHdNR8lJAlux584
        rTxY5z1JBvylLLIQBzCC7VGq1Jx5GME=
X-Google-Smtp-Source: APXvYqwuEmjM0SG/+8QzjCVp2xA5Z2Ibbki1cevledFBD+VccQkjy0/75Zhm8X+AXwR5BHXo38K0fg==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr14899495lfm.32.1557198840427;
        Mon, 06 May 2019 20:14:00 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p25sm3292583ljg.9.2019.05.06.20.14.00
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 20:14:00 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h21so12857265ljk.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 20:14:00 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr14197859ljj.79.1557198341113;
 Mon, 06 May 2019 20:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <20190506210416.2489a659@oasis.local.home> <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
 <20190506215353.14a8ef78@oasis.local.home> <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
 <20190506225819.11756974@oasis.local.home>
In-Reply-To: <20190506225819.11756974@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 20:05:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4FCNBLe8OyDZt2Tr+k9JhhTsg3H8R4b55peKcf0b6eQ@mail.gmail.com>
Message-ID: <CAHk-=wh4FCNBLe8OyDZt2Tr+k9JhhTsg3H8R4b55peKcf0b6eQ@mail.gmail.com>
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
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 6, 2019 at 7:58 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Notice? We'd not even have to look up any values.  We'd literally just
> > do something like
> >
> >         int offset = locked_atomic_read(ip+1);
> >         return int3_emulate_call(ip, ip+5+offset);
> >
> > and it would be *atomic* with respect to whatever other user that
> > updates the instruction, as long as they update the offset with a
> > "xchg" instruction.
>
> Honestly, I'm not really sure what you are trying to do here.
>
> Are you talking about making the update to the code in the int3
> handler?

No. The above would be pretty much the entirely of the the ftrace_int3_handler.

It would emulate the call that has had its first byte overwritten by
'int3'. Without doing any lookups of what it was supposed to change
the call to, because it simply depends on what the rewriting code is
doing on another CPU (or on the same CPU - it wouldn't care).

So no need to look up anything, not at int3 time, and not at return
time. It would just emulate the instruction atomically, with no state,
and no need to look up what the 'ip' instruction is at the time.

It could literally just use a single flag: "is ftrace updating call
instructions". Add another flag for the "I'm nop'ing out call
instructions" so that it knows to emulate a jump-over instead. That's
it.

Because all the actual *values* would be entirely be determined by the
actual rewriting that is going on independently of the 'int3'
exception.

                   Linus
