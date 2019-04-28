Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59B0D9F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 01:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfD1X1Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Apr 2019 19:27:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39419 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfD1X1Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Apr 2019 19:27:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id e92so4189515plb.6
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Apr 2019 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LYH/XS8nnf6efHlZx0B2St65dcm+60nIA8GvtyVKA2g=;
        b=DmRdpcQePn9pu6FxDsh1mK99BocSEh/feEMjXNQT5ibFOMXKxk7jGGikNVgPkQ/pOI
         UGmJYe/+bLddvlC3J8DvQsu56bjSCusqMfu8ME8NvlSzxN714OngT/6dh+33YkAcZv8i
         iM0dTbQx4WNLm2r5XvkUR/9p+AGYVJWQd1S1XltOigmfclHaDVEekiM8glCNctsFjsqe
         EjtGySHRM/yMeakMd4wY4/K6M7MwH6uRGoUakpsQfA1l/NMDHEwrki80UgpRapYjx/2A
         8wv773Mjddy3w1YG0r8YpnUtenCQDHKuuF0sSQvKZb4Ba5u8UD1UTfrCsbCTdunO3Zef
         bgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LYH/XS8nnf6efHlZx0B2St65dcm+60nIA8GvtyVKA2g=;
        b=JkzTxqZNcdWSyN3C4YHtcXmm+ePeJ3O6fBagW+Fxdpu2FuYbOZNxJet2mia+u7DBFD
         qThNtpJWgbxAd9NcfBG3M3u9r9ehGNiV8Pn2HRAIERrIb7pAZZDc3dG3qZDQ0UooGM4f
         RnzdZ//uIz7nIcyoRgy3hJ6X3R+bBjHBa8Y3GPls/lnRx0LpJUK0tz6SKO1b9hHYRnQF
         MLZjKPDhPettVyCi8U2JWpEAkHDXjrbMafyBi6jzjNQa4lEMIzmYM5gX5QiWmLQ5Hcb9
         UoasdZtZCILCro0d+s0QD0ZWkxP3GNJWosOKF8G4DsZQCQGDepmBQKYusL8rfs1FfBNU
         EbcA==
X-Gm-Message-State: APjAAAXHpoADuFOn2+TqXpfUuSouT9PTcgRhzajWsTT+P3i0CjmkRqfl
        PcDhogWks94fVVcgUkECtImcKw==
X-Google-Smtp-Source: APXvYqx9Yjda2C1O0PTiHPRxwDgIBXUPJI1Ken8qeQkI2h0Dmc7D+Nw/tJ+dGR8X07wI+YtMGa9FdA==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr60249446plb.203.1556494043721;
        Sun, 28 Apr 2019 16:27:23 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:68a6:ac0c:7713:add7? ([2601:646:c200:1ef2:68a6:ac0c:7713:add7])
        by smtp.gmail.com with ESMTPSA id s21sm41771309pfm.3.2019.04.28.16.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 16:27:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] x86/thread_info: introduce ->ftrace_int3_stack member
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <87k1fdygcx.fsf@suse.de>
Date:   Sun, 28 Apr 2019 16:27:21 -0700
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C55DED25-C60D-4731-9A6B-92BDA8771766@amacapital.net>
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-2-nstange@suse.de> <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net> <20190428135143.09d35bb6@oasis.local.home> <87k1fdygcx.fsf@suse.de>
To:     Nicolai Stange <nstange@suse.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Apr 28, 2019, at 2:22 PM, Nicolai Stange <nstange@suse.de> wrote:
>=20
> Steven Rostedt <rostedt@goodmis.org> writes:
>=20
>> On Sun, 28 Apr 2019 10:41:10 -0700
>> Andy Lutomirski <luto@amacapital.net> wrote:
>>=20
>>=20
>>>> Note that at any given point
>>>> in time, there can be at most four such call insn emulations pending:
>>>> namely at most one per "process", "irq", "softirq" and "nmi" context.
>>>>=20
>>>=20
>>> That=E2=80=99s quite an assumption. I think your list should also contai=
n
>>> exception, exceptions nested inside that exception, and machine
>>> check, at the very least.  I=E2=80=99m also wondering why irq and softir=
q are
>>> treated separately.
>=20
> You're right, I missed the machine check case.
>=20
>=20
>> 4 has usually been the context count we choose. But I guess in theory,
>> if we get exceptions then I could potentially be more.
>=20
> After having seen the static_call discussion, I'm in no way defending
> this limited approach here, but out of curiosity: can the code between
> the push onto the stack from ftrace_int3_handler() and the subsequent
> pop from the stub actually trigger an (non-#MC) exception? There's an
> iret inbetween, but that can fault only when returning to user space,
> correct?

IRET doesn=E2=80=99t do any fancy masking, so #DB, NMI and regular IRQs shou=
ld all be possible.

>=20
>=20
>> As for irq vs softirq, an interrupt can preempt a softirq. Interrupts
>> are enabled while softirqs are running. When sofirqs run, softirqs are
>> disabled to prevent nested softirqs. But interrupts are enabled again,
>> and another interrupt may come in while a softirq is executing.
>>=20
>=20
> Thanks,
>=20
> Nicolai
>=20
>=20
> --=20
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton,=

> HRB 21284 (AG N=C3=BCrnberg)
