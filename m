Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCABE6727F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjARTPi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 14:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjARTPh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 14:15:37 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A453571
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 11:15:30 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4e4a6af2d99so163085807b3.4
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 11:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4nxEfvy0yR+uYwlDacsNF7fMODlHY3V+SjqESb1lqw=;
        b=EBYkaCxSMcu6NXRtxflfK6t4E5pspFWCU7gpNx4h2acnuxtLjyJpm4wPxZvJIQ8tyB
         ZbPhQQWQUlqUomGV0S6xPRZWUhLluH9fSdN8/fhItGT17wDkzJEqAN7j+MplhW7B1wdC
         Xj/yDIW1+fgVLpwEBz6IJvx2GLHv+hqkSupk87dRGJhdyxAEMA/vl5YP9I19wjuMJSyI
         CtlLxZrsQuyKPzdUcA1nBmcKh5tu62Fx78sR78GpwJeVC0jWDvBdYrnmeXS1eA3zTGJ7
         d8iBPvPDP77cOirQRgtiwC9pE2Nri9aCriCCqtjvP5dRRVHMZ8limoM1h/fiahACQZn0
         qs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4nxEfvy0yR+uYwlDacsNF7fMODlHY3V+SjqESb1lqw=;
        b=voRxonBgW8XinItjC4L/BR9OSwq2FlZ3PhIVSOuDBYgpD1U+jgsALna1GJ6h4Ebs6C
         +pgiJ826TGu1MgrPlXmcz8BREpEs4jgD8qWQhR7N2NNJD9keXeL1SjKwrQ6Bc1xmizS+
         AKEAmekalC0gta8zdwRdc8xxrSKk3qUad97R0JgwXVpxlMEEpIzX9DsNmU4Uj/dEycGS
         sy0jDvOG1lmJh5DIIPQoA67EPYHpQ5mdSHOnsMgEIFvkJMTWlBfjzv9eTjoc3z4NhUJm
         J3WCr6FCItN6qe116E4cM2GI6E5cpWbkEfY+6s4xxNuVmJ8yTqpCW+bdKS8PmGNU2LIH
         9OsQ==
X-Gm-Message-State: AFqh2kpT5yA2uHE4ofGfNNAoHm2357otT9sVFM7P8vnyofIwca46tfgm
        rXgEgfXU8GFKQvKo8XLXCZug8KHs4LKRYnO7eaxqRg==
X-Google-Smtp-Source: AMrXdXs3XFCx6PYY75OhOG6UTYpH/2Cu5tA4Ot5bQ+gvnqaNagCVMyRT9wNtrB8CCCQbj89RytpbL9dSFUY8vXg4yx0=
X-Received: by 2002:a81:1c42:0:b0:475:b232:7a17 with SMTP id
 c63-20020a811c42000000b00475b2327a17mr1083969ywc.111.1674069329399; Wed, 18
 Jan 2023 11:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20230114161557.499685-1-ackerleytng@google.com>
 <20230114161557.499685-3-ackerleytng@google.com> <Y8hCBOndYMD9zsDL@google.com>
In-Reply-To: <Y8hCBOndYMD9zsDL@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Wed, 18 Jan 2023 11:15:02 -0800
Message-ID: <CALzav=cBxddw=CsC4T-43+mT7W7jgROj2m_YodWp7bDpdQx-qA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Reuse kvm_setup_gdt in vcpu_init_descriptor_tables
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Wei Wang <wei.w.wang@intel.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 18, 2023 at 11:01 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sat, Jan 14, 2023, Ackerley Tng wrote:
> > Refactor vcpu_init_descriptor_tables to use kvm_setup_gdt
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/x86_64/processor.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index 33ca7f5232a4..8d544e9237aa 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -1119,8 +1119,7 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
> >       vcpu_sregs_get(vcpu, &sregs);
> >       sregs.idt.base = vm->idt;
> >       sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> > -     sregs.gdt.base = vm->gdt;
> > -     sregs.gdt.limit = getpagesize() - 1;
> > +     kvm_setup_gdt(vcpu->vm, &sregs.gdt);
>
> *sigh*
>
> The selftests infrastructure is so misguided.  Forcing tests to opt-in to
> installing an IDT just to avoid allocating two pages is such an awful tradeoff.
>
> Now that we have kvm_arch_vm_post_create(), I think we should always allocate
> the GDT, IDT, and handlers, and then vCPU setup/creation can simply grab the
> already-allocated values and stuff them into KVM.  That would then eliminate
> kvm_setup_gdt() entirely.

+1

I actually started going through the process of making the same clean
up last year, but never got around to posting it. My motivation at the
time was to provide better debuggability for test failures that were
due to unexpected exceptions in guest mode.

One thing to be aware of: vmx_pmu_caps_test and platform_info_test
both relied on *not* having an IDT installed (as of Sep 2022).
Specifically they relied on exception generating KVM_EXIT_SHUTDOWN.
Installing an IDT causes these tests instead to hit the unhandled
exception TEST_ASSERT(). Just a heads up when you do this clean up :)

>
> And much of the setup code is also backwards and unnecessarily thread-unsafe, e.g.
> vCPU initialization shouldn't need to fill GDT entries.
>
> So, while I agree that using kvm_setup_gdt() is a good change on its own, I'd
> rather go the more aggressive route and clean up the underlying mess.
>
> I'll send patches sometime this week, unfortunately typing up what I have in mind
> is harder than just reworking the code :-/

I would offer to post my patches but it doesn't cover any of the GDT
stuff so I'll let you post yours.
