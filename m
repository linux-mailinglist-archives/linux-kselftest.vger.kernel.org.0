Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4F2D6D9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 02:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbgLKBhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 20:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389770AbgLKBhJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 20:37:09 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F564C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:36:29 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d8so6868008otq.6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hvf7b4dKf+eaX9x0LeZSdfZqwxXapo10+V/RbGVg1d8=;
        b=hieJvDGfGzHXBN0+XFaUY0a1Q62sZNDRZuIV+TYQMa31Njf4+DeOVoUPoxFwzZgCCf
         q+HtOd5FWmOGACZPe2PTSNI5Pg4GMEugbGqHTohCeUpSvxf675IFHy7vqMBa51sKhmKc
         R5AMityNmE10mba11ca/YWDz0YpriMJCmItf9OLdsA2uHZ5mplpQjQuku4YiZN7m6c+v
         ivlUDJm7EOxGfmCP9DYawfN3zABRDiExthYXDKV130DCIF8yQXk1RDvtr0r66ML16Ioa
         xA5TIM6+JmUt3xwlV5vt/882aTjz1p9b4BtBP/b0hecWECp/pjVQX3PMMxGF3O4rqEa4
         bD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hvf7b4dKf+eaX9x0LeZSdfZqwxXapo10+V/RbGVg1d8=;
        b=jK85ejV0XRrBeIdvu8ECQ/PVKWYoMG8QjkSXg4Z8MuYNb5LwrN5WStFNj5AGZuV38I
         5yWxtPQzjHL+kAHnyQDD4MKfNlNWsC5LM9oL7v3Gd0fcc8UsmCxIQk/IpnmH2A31HvUt
         8YX2myO6MYuvfWwgBHYtdVm9Auk9qbDDza+DQr0JcqJhTT9/H3Fw6sUUi/s18YXhhQg8
         1Qrxc1ysrW4GT4CQrQYDEVJKH7QIUw4a/eDiB6tXUQJnEk6EbvYhTKk879nn2RV5cLte
         H477s6T5I4bIA9+QfyLF+4KUQ5ApRDSA0e3y6uTglojG9uifoSQqzZe8VctXJE3qyABM
         hNfg==
X-Gm-Message-State: AOAM530+83Wfp+OaqSj4YT/f7X0dP8ntsF/8ScVWQ7CnGEAn5C73dXX7
        6eMpu1tymOU3PGtWh2G5D5BYPOol9+kejHxwv9WcRA==
X-Google-Smtp-Source: ABdhPJx5ZyVP4fWOYqn6s2bcodI3YyMmRFI4i1//63CQtcVdqWVLq9WIoGdgVV0yHzvf6fIRJ3cudGmTk+EtEgvL0hk=
X-Received: by 2002:a05:6830:1ae4:: with SMTP id c4mr6946148otd.295.1607650588143;
 Thu, 10 Dec 2020 17:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20201210043611.3156624-1-morbo@google.com> <X9LCQYB2yqMaUqkj@google.com>
 <CAGG=3QW4cQ958DfQBg18qxwGg7s6A6Uxjv=WfVQjWD4HW32LRA@mail.gmail.com>
In-Reply-To: <CAGG=3QW4cQ958DfQBg18qxwGg7s6A6Uxjv=WfVQjWD4HW32LRA@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 10 Dec 2020 17:36:16 -0800
Message-ID: <CALMp9eTLwh0cSLv0f0U1A_wKP-T99yN9dLOrsUWTv4yokwiOHA@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: remove reassignment of non-absolute variables
To:     Bill Wendling <morbo@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Shuah Khan <shuah@kernel.org>, Jian Cai <caij2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

By non-zero, I think Sean means something like:

666:
.pushsection .rodata
.quad 666b


On Thu, Dec 10, 2020 at 5:34 PM Bill Wendling <morbo@google.com> wrote:
>
> On Thu, Dec 10, 2020 at 4:50 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Wed, Dec 09, 2020, Bill Wendling wrote:
> > > Clang's integrated assembler does not allow symbols with non-absolute
> > > values to be reassigned. Modify the interrupt entry loop macro to be
> > > compatible with IAS by using a label and an offset.
> > >
> > > Cc: Jian Cai <caij2003@gmail.com>
> > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > References: https://lore.kernel.org/lkml/20200714233024.1789985-1-caij2003@gmail.com/
> > > ---
> > >  tools/testing/selftests/kvm/lib/x86_64/handlers.S | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/x86_64/handlers.S b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > index aaf7bc7d2ce1..3f9181e9a0a7 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > +++ b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > @@ -54,9 +54,9 @@ idt_handlers:
> > >       .align 8
> > >
> > >       /* Fetch current address and append it to idt_handlers. */
> > > -     current_handler = .
> > > +0 :
> > >  .pushsection .rodata
> > > -.quad current_handler
> > > +     .quad 0b
> >
> > Bit of a silly nit: can we use a named label, or at least a non-zero shorthand?
> > It's really easy to misread "0b" as zeroing out the value, at least for me.
> >
> I don't believe that will work. If I rename "0 :" to something more
> concrete, like ".Lcurrent :", then the label's redefined because of
> the ".rept". If I assign the "0b" to something, we're back with the
> unmodified code, which clang issues an error for:
>
> <instantiation>:3500:6: error: invalid reassignment of non-absolute variable 'x'
>  x = 0b
>      ^
> <instantiation>:2:2: note: while in macro instantiation
>  .rept 255 - 18 + 1
>  ^
>
> > >  .popsection
> > >
> > >       .if ! \has_error
> > > --
> > > 2.29.2.576.ga3fc446d84-goog
> > >
