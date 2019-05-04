Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF613C14
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2019 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEDUeR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 May 2019 16:34:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38711 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfEDUeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 May 2019 16:34:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id e18so7977714lja.5
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2019 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SaUefhj41Vo9ICd62i3E2YPs3qFZSdkbgRUMEL66AdI=;
        b=YWFWemqJ0JLsacxwcohY3H1Ru+7m68bmnSG7LYrodNEBsa1vqFIe7N+Z7/ib2SOef8
         WWNNvU+E2HH25gh9czdMXSA1W+PtOHyDLxhTntgAp0nZMXOMd6zYnlK0dQqvtzAQo8bz
         LSBMlFzIL2Q2R5LmuSDspX30nFFTSIPoTZtwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SaUefhj41Vo9ICd62i3E2YPs3qFZSdkbgRUMEL66AdI=;
        b=P0OAtMMpm42+eCY9gbqcy0Si4WmhSK9eVMIXHXhyXpMIAIjZliB+o6gK1OzbCoceWR
         9c8wWQ67z3Q/SXZoZNd0ow1eElMRfWg9C0nlFIXPWm3pn/5gGMuq+jTwFCvfowMGwfPQ
         fguNtBQGbgFNvWMnT7pt00UKoUCS7X4voZLVqoF0RtPAnnChZIP6rtnsBv/PBB8zDtCy
         nzTuNWtrholh1g+onPyyJQLX+9YLpY2glGGtxb7km4VQHSdGkrYIJ8qrOZ1nr6IfAjaC
         CbvuItUqxVkV+0bLqHB9tzeBin2diePoRl0iD53ZnwJWfHZuaPsMv3HdJ4bnij4CPsKK
         y9vA==
X-Gm-Message-State: APjAAAWyWQOnev2UXr9nab1xcx03gwefaeQaVU/8jjrytAJo9FRf/bSl
        xVL85z6hYARod5UuykSrxBibXoLotoo=
X-Google-Smtp-Source: APXvYqx2L61QL2VolKeD1LaypjwDy75LHhwyT+a5DuFO7grOvIwbu2ICjt+RgMnyvEXxX1ziYpEKSw==
X-Received: by 2002:a2e:9703:: with SMTP id r3mr8725034lji.37.1557002055007;
        Sat, 04 May 2019 13:34:15 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id o17sm1079118lji.23.2019.05.04.13.34.14
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 13:34:14 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id e18so7977700lja.5
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2019 13:34:14 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr8970707lja.125.1557001696580;
 Sat, 04 May 2019 13:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202830.347656894@goodmis.org> <20190501203152.397154664@goodmis.org>
 <20190501232412.1196ef18@oasis.local.home> <20190502162133.GX2623@hirez.programming.kicks-ass.net>
 <CAHk-=wijZ-MD4g3zMJ9W2r=h8LUWneiu29OWuxZEoSfAF=0bhQ@mail.gmail.com>
 <20190502181811.GY2623@hirez.programming.kicks-ass.net> <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <CAHk-=wh8bi5c_GkyjPtDAiaXaZRqtmhWs30usUvs4qK_F+c9tg@mail.gmail.com>
 <20190503152405.2d741af8@gandalf.local.home> <CAHk-=wiA-WbrFrDs-kOfJZMXy4zMo9-SZfk=7B-GfmBJ866naw@mail.gmail.com>
 <20190503184919.2b7ef242@gandalf.local.home> <CAHk-=wh2vPLvsGBi6JtmEYeqHxB5UpTzHDjY5JsWG=YR0Lypzw@mail.gmail.com>
 <20190504001756.17fad840@oasis.local.home> <CAHk-=wiuSFbv_rELND-BLWcP0GSZ0yF=xOAEcf61GE3bU9d=yg@mail.gmail.com>
 <CAHk-=wjGNx8xcwg=7nE_0-nLQ_d4UALHvJ8O+TurbA25n8MyNg@mail.gmail.com> <2BF1AE4B-8105-49F0-8B6A-AA3B11FD66FD@amacapital.net>
In-Reply-To: <2BF1AE4B-8105-49F0-8B6A-AA3B11FD66FD@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 May 2019 13:28:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwc8NDahj455iBWmYyvDDS+sN1TObFsxxS51gNbtZ9iw@mail.gmail.com>
Message-ID: <CAHk-=wiwc8NDahj455iBWmYyvDDS+sN1TObFsxxS51gNbtZ9iw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 4, 2019 at 1:12 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> As an aside, is it even *possible* to get #BP from v8086 mode?  On a quic=
k SDM read, the INT3 instruction causes #GP if VM=3D1 and IOPL<3.  And, if =
we allow vm86() to have IOPL=3D3, we should just remove that ability. It=E2=
=80=99s nuts.

We've definitely historically allowed IOPL=3D3 with the whole "iopl()"
system call. And yes, afaik it works together with the vm86 system
call too. I think we copy the unsafe bits from the original eflags, so
if you do iopl(3) followed by vm86(), you will be running in vm86 mode
with iopl 3.

> (We should maybe consider a config option for iopl() that defaults off. W=
e=E2=80=99ve supported ioperm() for a long, long time.)

It's entirely possible that nobody uses iopl() and we should make it a
config option that defaults to off.

But we've already done that with the VM86 support entirely, and I'm
not sure modern distros even enable it.

And obviously vm86 mode isn't available at all with a 64-bit kernel,
so this is all slowly becoming more or less moot.

                  Linus
