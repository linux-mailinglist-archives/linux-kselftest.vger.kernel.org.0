Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3802F2D6D07
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 02:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbgLKBGB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 20:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394196AbgLKBFW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 20:05:22 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CD0C0617A6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:04:33 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b2so7620657edm.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+bMJOpE2Xceze4jY4aTXdsaOCnN+PVyjbM2jXZf4YM=;
        b=kFQTzxaNEnrF8foIYSUrXAxSu0XdSUDcEnoDS05bb6QfCnopjxrImqntZPFxTM70XE
         CNSSTW7K+FAHwjBSYxxlACsZHKCG73EHwTG1f/Il3Ckzj54hB2ltFMQtzS8Dp33P7LCU
         aIHRI2Hy4eKvQ0b0VHMS07E8XPH9fTrruxNJ16Qwee3fNHb816ko2bq3dnf4SsWM/ulb
         J1IK9zQc+7/1E/D9wxAcL1XK12wVKGS7Sxghds+ZjZkaypwpzfA/kT3GrBZROpF/fB1j
         mr23tz9a0MSli6QBK6Ecl82UcAIAlTeeshrjsTI+EcFAA01QhkwY8RR/tR2A1BlaNZD9
         IIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+bMJOpE2Xceze4jY4aTXdsaOCnN+PVyjbM2jXZf4YM=;
        b=hO/PLDptuGuwZ6pfNkOav02hx6oC2nlotjzDntVg+C3Eax0cAcQsEHKsP2UBMjDywt
         QwfAtnO/fs1dretHBrduVQfQioRnC0vePVTGC3zEXQAQcnuPx5H/co8zwMQaogu8UWN/
         8875k/a66vpKIpzW8+CPOY5613p/G5bI+jKmdh4U0YDg+DlFeO1IrqmAs2GCXneukrWu
         lIYsV7iPCjzvHn+NDUSGbWH/FTU1dRUb0GB6WsIBCRND6ANmBzK5YHlLn8x5ydkJwMR/
         FlYzGKIzgjNHXxRDU7oTeRF3U6mBsOSGvIN5oKpVie4UAWzOCHm0hKk/esPO61xMSh+7
         wrPA==
X-Gm-Message-State: AOAM531dfZj30yN7nxHwOQZQ8bBGiwNI5NichPBOgWybPmKQ4NkYwFDt
        qKlBvqyNyWE7hEmdi5CL3Z+VqVlzo5WhaSOq/kk6HuZomeRlnUU=
X-Google-Smtp-Source: ABdhPJw+oSIEWuLcin91lB29MxN/esgQv75pWaAA/7ehVB1Z1fRLAxP+Wrptd+Zur+q8BtivgvZIQEUQw2PB+PsulFA=
X-Received: by 2002:a50:8744:: with SMTP id 4mr9365502edv.362.1607648672329;
 Thu, 10 Dec 2020 17:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20201210043611.3156624-1-morbo@google.com> <X9LCQYB2yqMaUqkj@google.com>
In-Reply-To: <X9LCQYB2yqMaUqkj@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 10 Dec 2020 17:04:20 -0800
Message-ID: <CAGG=3QW4cQ958DfQBg18qxwGg7s6A6Uxjv=WfVQjWD4HW32LRA@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: remove reassignment of non-absolute variables
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Shuah Khan <shuah@kernel.org>, Jian Cai <caij2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 4:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Dec 09, 2020, Bill Wendling wrote:
> > Clang's integrated assembler does not allow symbols with non-absolute
> > values to be reassigned. Modify the interrupt entry loop macro to be
> > compatible with IAS by using a label and an offset.
> >
> > Cc: Jian Cai <caij2003@gmail.com>
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > References: https://lore.kernel.org/lkml/20200714233024.1789985-1-caij2003@gmail.com/
> > ---
> >  tools/testing/selftests/kvm/lib/x86_64/handlers.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/handlers.S b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > index aaf7bc7d2ce1..3f9181e9a0a7 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > @@ -54,9 +54,9 @@ idt_handlers:
> >       .align 8
> >
> >       /* Fetch current address and append it to idt_handlers. */
> > -     current_handler = .
> > +0 :
> >  .pushsection .rodata
> > -.quad current_handler
> > +     .quad 0b
>
> Bit of a silly nit: can we use a named label, or at least a non-zero shorthand?
> It's really easy to misread "0b" as zeroing out the value, at least for me.
>
I don't believe that will work. If I rename "0 :" to something more
concrete, like ".Lcurrent :", then the label's redefined because of
the ".rept". If I assign the "0b" to something, we're back with the
unmodified code, which clang issues an error for:

<instantiation>:3500:6: error: invalid reassignment of non-absolute variable 'x'
 x = 0b
     ^
<instantiation>:2:2: note: while in macro instantiation
 .rept 255 - 18 + 1
 ^

> >  .popsection
> >
> >       .if ! \has_error
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
