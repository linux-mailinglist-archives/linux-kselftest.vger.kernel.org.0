Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3187A455203
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 02:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbhKRBOf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 20:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbhKRBOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 20:14:33 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE1C061570
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 17:11:33 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so19218815edb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 17:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n59JA5vpAiFzqymIZR9NoTDmE0/JzGU9uabXY31m74I=;
        b=TgbadRECWp9oKG6JDdvRokOmyyN+GN0KMTnE2W0YX4/fid4SCJaU1J56VwkRFzLenC
         aPit+3iAGdT6f+MxXOqWupGW+vI58N7aCqgED7muqJwin6ZugaYYI0OrOYph+wiTNVoY
         u++A2iFFJw776IR8URCgDpOww/+MnT+NlmuFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n59JA5vpAiFzqymIZR9NoTDmE0/JzGU9uabXY31m74I=;
        b=z9BBkX44AH5Zuj3NVGgdqE7uo3Tg9IeK5ikjvgiOcQG7bx/vbNSCnZ5VaiUWDiSE3L
         9Uk2nDJIyzwrNTPSaHcpEQSY11L29mcFRGR2bMKxfQTO05AymbLnCIpk7UDJ8qDMogNk
         8t6RKulaie391UvuB1V5/cdMxDMFOlwnXVfabPAFbwHHojMEwlwSDKd1KL/9L8qjsewV
         7hnoAaz9Hvoejnt+AIJ7bBOxemdWfBzmtAAqA2TeqsjWfEUl7GPHCysSo1jXBMDzdpf8
         vkHs9o3vylEv/M5iQYI1lsvNTNyKvlIpiQbTMSamt0cDAs/P8dNaYiJFkUU7gzEKuYK7
         9iIg==
X-Gm-Message-State: AOAM53072I9qmGLIf5sXNV+Cq7SnqFAgALvmrSyTGeEoLEAHEMT+d9EN
        u34sUhatfbA+OUPGLPSCehrSiQfnHFmvmqZt
X-Google-Smtp-Source: ABdhPJyzYb4zl2r0qVLQC5BkHvcOnhDRBUYI77I5GuM58RCjEr1AEqb6hGXBccWbj4RQY31RTLcw4w==
X-Received: by 2002:a05:6402:22a5:: with SMTP id cx5mr4980141edb.334.1637197892003;
        Wed, 17 Nov 2021 17:11:32 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id n16sm749813edt.67.2021.11.17.17.11.30
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 17:11:31 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso6251638wmr.4
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 17:11:30 -0800 (PST)
X-Received: by 2002:a7b:c005:: with SMTP id c5mr5081792wmb.155.1637197890742;
 Wed, 17 Nov 2021 17:11:30 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com> <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
In-Reply-To: <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 17:11:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
Message-ID: <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 17, 2021 at 4:37 PM Kyle Huey <me@kylehuey.com> wrote:
>
> This fixes most of the issues with rr, but it still changes the ptrace
> behavior for the double-SIGSEGV case

Hmm. I think that's because of how "force_sigsgv()" works.

I absolutely detest that function.

So we have signal_setup_done() doing that

        if (failed)
                force_sigsegv(ksig->sig);

and then force_sigsegv() has that completely insane

        if (sig == SIGSEGV)
                force_fatal_sig(SIGSEGV);
        else
                force_sig(SIGSEGV);

behavior.

And I think I know the _reason_ for that complete insanity: when
SIGSEGV takes a SIGSEGV, and there is a handler, we need to stop
trying to send more SIGSEGV's.

But it does mean that with my change, that second SIGSEGV now ends up
being that SA_IMMUTABLE kind, so yeah, it broke the debugger test -
where catching the second SIGSEGV is actually somewhat sensible (ok,
not really, but at least understandable)

End result: I think we want not a boolean, but a three-way choice for
that force_sig_info_to_task() thing:

 - unconditionally fatal (for things that just want to force an exit
and used to do do_exit())

 - ignore valid and unblocked handler (for that SIGSEGV recursion
case, aka force "sigdfl")

 - catching signal ok

So my one-liner isn't sufficient. It wants some kind of nasty enum.

At least the enum can be entirely internal to kernel/signal.c, I
think. No need to expose this all to anything else.

            Linus
