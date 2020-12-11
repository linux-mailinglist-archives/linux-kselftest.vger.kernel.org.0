Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E062D6D36
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 02:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404755AbgLKBUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 20:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404583AbgLKBUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C66C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:19:22 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e2so6019570pgi.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 17:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2kojcO++iJq06r+YVSnXDa0yZkR14JLiDo772gcB14=;
        b=jgMzD3pDhfE1MDKUcEOgtOj9zlPKVC2zWw1VMEvFIRbA23KBxCaom3B6vQfFQNoX7V
         8dH27A3fzdO6OUlZ1qKRn28/6x43Gg1D6mRfPNv0eC4VqPI7DsQjwnHysHnBP0l9PEL+
         EPQ0ytqNkWUSmyDYLxromDxaqhwc6xAjWbl9w04nRm9BTFVOHaDI1M+czmcyB2DXp+fz
         RcAEqWal38IJKMCWqNddcVHY1Jl6CytLtzegSgoYV/QI0C5HIzZoN0yhD0ooqtYK4GC/
         BEgqIDTv17bSabNoMTNgBhRen33CPvgwhwNHqlkxWVEfQwTNWEGATac5nt/Q7nXZC44W
         CoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2kojcO++iJq06r+YVSnXDa0yZkR14JLiDo772gcB14=;
        b=EYfXqzuCLUF2744pziMYs0BboubLso7pkKMVjIblohzZbETVf82B/qaa8hF3B9uqSZ
         kmObWnNpk7xp45k/v9OxrJ0oJch74JKR+3a15we6/dzpoGL5d8ayRIZl7ToqBY+tDcsm
         VU8SfaIMzAfKydFfRwdIImQrA6QwBU+gd87sAeBbKzJCU081j5tUZg9vXoUpAiXlPRVc
         5vvsV8UY4XYNG1lGvARWHR5qYRnmJS+jT84TDWHaF2o4iySh4O3Ub5jczQ8EhEMYeFEI
         l0Pd7BlAPZ/53/Dr3ED0MIn+8gwmPnd1wcryE5Z3SIRz8l1js6kcFkx8AQkWIQZfEgf7
         hoAA==
X-Gm-Message-State: AOAM532d8Mg6OqBVoaOO6teXmTJcYa6pe2PD4+9YO2LNxbforRZU/MZO
        46qMmlJBrkfB446XyeQvCJ9x8c2kJqhOaA==
X-Google-Smtp-Source: ABdhPJyJXeRUkSSFgRsbCVN7yaQ0Pk42bHO5ECiWOns0irmWjs/RMdfBMy6dYaH5Vvms07lj5HMURA==
X-Received: by 2002:a63:ea14:: with SMTP id c20mr1780271pgi.416.1607649562406;
        Thu, 10 Dec 2020 17:19:22 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id i37sm4532599pgi.46.2020.12.10.17.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 17:19:21 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:19:15 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Bill Wendling <morbo@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Shuah Khan <shuah@kernel.org>, Jian Cai <caij2003@gmail.com>
Subject: Re: [PATCH] selftests: kvm: remove reassignment of non-absolute
 variables
Message-ID: <X9LJE6ElVfKECnno@google.com>
References: <20201210043611.3156624-1-morbo@google.com>
 <X9LCQYB2yqMaUqkj@google.com>
 <CAGG=3QW4cQ958DfQBg18qxwGg7s6A6Uxjv=WfVQjWD4HW32LRA@mail.gmail.com>
 <X9LGPwstuFU1HzRT@google.com>
 <CAGG=3QVccFAmc_dRHhMxM5cRLpeTLDxAbc_QKdL=aaTntdeVkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QVccFAmc_dRHhMxM5cRLpeTLDxAbc_QKdL=aaTntdeVkQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020, Bill Wendling wrote:
> On Thu, Dec 10, 2020 at 5:07 PM Sean Christopherson <seanjc@google.com> wrote:
> > On Thu, Dec 10, 2020, Bill Wendling wrote:
> > > On Thu, Dec 10, 2020 at 4:50 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > On Wed, Dec 09, 2020, Bill Wendling wrote:
> > > > > Clang's integrated assembler does not allow symbols with non-absolute
> > > > > values to be reassigned. Modify the interrupt entry loop macro to be
> > > > > compatible with IAS by using a label and an offset.
> > > > >
> > > > > Cc: Jian Cai <caij2003@gmail.com>
> > > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > > References: https://lore.kernel.org/lkml/20200714233024.1789985-1-caij2003@gmail.com/
> > > > > ---
> > > > >  tools/testing/selftests/kvm/lib/x86_64/handlers.S | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/kvm/lib/x86_64/handlers.S b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > > > index aaf7bc7d2ce1..3f9181e9a0a7 100644
> > > > > --- a/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > > > +++ b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
> > > > > @@ -54,9 +54,9 @@ idt_handlers:
> > > > >       .align 8
> > > > >
> > > > >       /* Fetch current address and append it to idt_handlers. */
> > > > > -     current_handler = .
> > > > > +0 :
> > > > >  .pushsection .rodata
> > > > > -.quad current_handler
> > > > > +     .quad 0b
> > > >
> > > > Bit of a silly nit: can we use a named label, or at least a non-zero shorthand?
> > > > It's really easy to misread "0b" as zeroing out the value, at least for me.
> > > >
> > > I don't believe that will work. If I rename "0 :" to something more
> > > concrete, like ".Lcurrent :", then the label's redefined because of
> > > the ".rept". If I assign the "0b" to something, we're back with the
> > > unmodified code, which clang issues an error for:
> > >
> > > <instantiation>:3500:6: error: invalid reassignment of non-absolute variable 'x'
> > >  x = 0b
> > >      ^
> > > <instantiation>:2:2: note: while in macro instantiation
> > >  .rept 255 - 18 + 1
> >
> > Boo.  I assume 1: and 1b work?  Or my KVM favorite "666:" :-)  That's enough to
> > at least make me pause and actually read the code.
> >
> Ah! I missed the second part of your message (about the non-zero
> shorthand). That should work. Sorry about that. :-) Should I submit a
> new version of this patch?

That'd probably be easiest.  This is trivial enought to fixup when applying, but
we might as well save a few of Paolo's cycles for other things.

Thanks!
