Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC42D6D16
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 02:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgLKBLV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 20:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394516AbgLKBLG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 20:11:06 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB249C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:10:25 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id w1so5424450ejf.11
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=646OzB5NaxLotAW2wuBBMy4eA4rLBcbcCYPaqyjZw4o=;
        b=EeBfnXfo/vkqM8v+PTu/PiWhrNc+wjQb0y/YNfEHcr687E+PF8okm0mtbvlk4BZPoP
         3oUfM1tUZtpozPRL8J1V1/1gQt4ndgZh2nsroPH5zDVdCm9Sc7IXgvyJiUYKVZFcYQz4
         SEbiQgOPb0XyDr1wWxfppeFljFxWFczmmlgzUWQWZD8AVBGxkWvAly5JH6MSLisXiGpH
         aRJjHxnMxMGb7GG7oEapLvdWiDEXAbRV9Ks/D9jlP3k5wcXzS5CnPpLIt+LPNdSOCnh1
         pdnEgfUNAlrMp2i4lVSCK0xODTeJSr8nFQ13uUwcbUwt2DfAObdbgaMYVreaWP4Kt9CL
         IvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=646OzB5NaxLotAW2wuBBMy4eA4rLBcbcCYPaqyjZw4o=;
        b=Km4y4OhkARH+e3cIab71zFqd9GWLKdege24jTlXyerQHMGOzLR2v6LsDy20Dt7K71f
         6QKW4JrMGY7blDKRT7nC9Eg3GvSO646ALGdzNFP6tdnPxkXpzKmrKDL+n1P2Qtm1zz+g
         1T+2cNeGXaW+gI3tZoxRKKpyPqazuTlEiDrIDc2XzZzdzWgpqgEWUjFLZX/BHFfSQvM4
         euQYc+QpYpx0C8iDbu676hBkNIHdfUTWIg9cHI4A0WOd5ZIHM1nmo1EOHi0UQwTFKgo6
         64MymCQBT8mjnus/3KJH7hjiivIkImeLFjDOslBx9b9Jyl7iLokQOTkfgLc6QeJGcVBQ
         g2Bg==
X-Gm-Message-State: AOAM532OU4xtHNc0FkGyfHLbYbWRDyGeRpeujD4TRiI7Gmc5uDRNTug1
        YSSO2gs2KpblZtyyWMP51PMYvHy0MgpEFvEJcpsb+Vy9tvU1
X-Google-Smtp-Source: ABdhPJz/ogcHT1TsUzDks1gPw0pLitH78u4D0hvgPmJ/5OY23ZylstlMLWHDjQVSWjESZ7bTjTFXLaKlBc2Bm4I1YTE=
X-Received: by 2002:a17:906:578e:: with SMTP id k14mr9027864ejq.90.1607649024104;
 Thu, 10 Dec 2020 17:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20201210043611.3156624-1-morbo@google.com> <X9LCQYB2yqMaUqkj@google.com>
 <CAGG=3QW4cQ958DfQBg18qxwGg7s6A6Uxjv=WfVQjWD4HW32LRA@mail.gmail.com> <X9LGPwstuFU1HzRT@google.com>
In-Reply-To: <X9LGPwstuFU1HzRT@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 10 Dec 2020 17:10:13 -0800
Message-ID: <CAGG=3QVccFAmc_dRHhMxM5cRLpeTLDxAbc_QKdL=aaTntdeVkQ@mail.gmail.com>
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

On Thu, Dec 10, 2020 at 5:07 PM Sean Christopherson <seanjc@google.com> wrote:
> On Thu, Dec 10, 2020, Bill Wendling wrote:
> > On Thu, Dec 10, 2020 at 4:50 PM Sean Christopherson <seanjc@google.com> wrote:
> > > On Wed, Dec 09, 2020, Bill Wendling wrote:
> > > > Clang's integrated assembler does not allow symbols with non-absolute
> > > > values to be reassigned. Modify the interrupt entry loop macro to be
> > > > compatible with IAS by using a label and an offset.
> > > >
> > > > Cc: Jian Cai <caij2003@gmail.com>
> > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > References: https://lore.kernel.org/lkml/20200714233024.1789985-1-caij2003@gmail.com/
> > > > ---
> > > >  tools/testing/selftests/kvm/lib/x86_64/handlers.S | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/lib/x86_64/handlers.S b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > > index aaf7bc7d2ce1..3f9181e9a0a7 100644
> > > > --- a/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > > +++ b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > > @@ -54,9 +54,9 @@ idt_handlers:
> > > >       .align 8
> > > >
> > > >       /* Fetch current address and append it to idt_handlers. */
> > > > -     current_handler = .
> > > > +0 :
> > > >  .pushsection .rodata
> > > > -.quad current_handler
> > > > +     .quad 0b
> > >
> > > Bit of a silly nit: can we use a named label, or at least a non-zero shorthand?
> > > It's really easy to misread "0b" as zeroing out the value, at least for me.
> > >
> > I don't believe that will work. If I rename "0 :" to something more
> > concrete, like ".Lcurrent :", then the label's redefined because of
> > the ".rept". If I assign the "0b" to something, we're back with the
> > unmodified code, which clang issues an error for:
> >
> > <instantiation>:3500:6: error: invalid reassignment of non-absolute variable 'x'
> >  x = 0b
> >      ^
> > <instantiation>:2:2: note: while in macro instantiation
> >  .rept 255 - 18 + 1
>
> Boo.  I assume 1: and 1b work?  Or my KVM favorite "666:" :-)  That's enough to
> at least make me pause and actually read the code.
>
Ah! I missed the second part of your message (about the non-zero
shorthand). That should work. Sorry about that. :-) Should I submit a
new version of this patch?

-bw
