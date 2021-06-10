Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44BF3A375D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 00:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJWuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFJWuH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 18:50:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1595CC0617A6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 15:47:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m21so5632188lfg.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NB6oruf2NY8GhkThmLRjR9OK5AwQwpQtqUKMMQIim6Q=;
        b=RlAcwFqFOmgURmrxCa/W36B7QDS48JsLtq3ukyvETwbEWY9n6kYR15OJLR1+m/Ayoa
         IFOPgRn+MWHaHRxfzFfw8YKkIIgs2ZCGs14vP+ZHoxKKjXRv9KyIxggliDfqvjBIjYCq
         V94EObt9JIV8pROJEKleOqvY3Lp4pDZx/7FjYYuWinqlm2/1Nytb+dPDD+hsW55nAX2C
         NGH7VQWOTOBEWWcYPh7P7p/+0rXPvWK0nt69u5R3R8eLlCTBAmYqdMr2C3ARulRpzg4R
         8Q+QNXpBn09jeaY6tlsnVHADHx9NQbdhTP8oD+yYICZdPO5DY7zVDUU7MeMZbXvDgcyf
         zO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NB6oruf2NY8GhkThmLRjR9OK5AwQwpQtqUKMMQIim6Q=;
        b=OXMU05a2pvSnBKD8/M2MDSLqk2LsgmTDU5SyLW6LvcU5nQgdMv2sMqQUrEA606fucZ
         7LQpy42vHY6XhKzkmYy1lgSoZEnmrYnXYI/lCMPEIRf5+VRGZvRa/S/vGxS/W1k8nn74
         12lvPG4gLXERMFWQcuIDOA5Adyj0+pXBDVEqD/phoiJQsKb/S1E1KOwemV84kDM2SCTY
         I0xNH5Qkmn5rQBkJ4amRh3CcVeOOmiFSQA5jyKyvFi1kb3UYCg81Q0UKlgN0UvFKnAhf
         DcIxavLtODb6JDZFFvGl0EnOvePsRYMxy+V6y80z9hPOzzxGp8rERTIxcwKW5qmKtIuy
         7hyA==
X-Gm-Message-State: AOAM532oU4zoF8AqxiBhz+XXV/Di340ChloNsk+4R8ng4lF9a/9lC2wy
        CmUEBJN3VCuKyweSR+xlRZ72+PAX1Hmbwc4A/LbHyg==
X-Google-Smtp-Source: ABdhPJwpq8QDGCaA9l+lT37FAjCpuN+L2RrV3HuGV2JBb0AyojuY/TbuPJ2PuprqJ9F9pWJFYjBYz3jwM7wdjjpecmI=
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr657852lfu.473.1623365274281;
 Thu, 10 Jun 2021 15:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-3-jingzhangos@google.com> <e3b2b3ab-88a2-827c-7775-10be63158ff3@redhat.com>
In-Reply-To: <e3b2b3ab-88a2-827c-7775-10be63158ff3@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 10 Jun 2021 17:47:41 -0500
Message-ID: <CAAdAUtjAuDdyBz7qd7UE0WuY77US-bhY1-jA9E11ddhZ0=gw6g@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] KVM: stats: Add fd-based API to read binary stats data
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

On Thu, Jun 10, 2021 at 11:23 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/06/21 23:14, Jing Zhang wrote:
> > +#define DEFINE_VM_STATS_DESC(...) {                                         \
> > +     STATS_DESC_COUNTER("remote_tlb_flush"),                                \
> > +     ## __VA_ARGS__                                                         \
> > +}
> > +
> > +#define DEFINE_VCPU_STATS_DESC(...) {                                               \
> > +     STATS_DESC_COUNTER("halt_successful_poll"),                            \
> > +     STATS_DESC_COUNTER("halt_attempted_poll"),                             \
> > +     STATS_DESC_COUNTER("halt_poll_invalid"),                               \
> > +     STATS_DESC_COUNTER("halt_wakeup"),                                     \
> > +     STATS_DESC_TIME_NSEC("halt_poll_success_ns"),                          \
> > +     STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),                             \
> > +     ## __VA_ARGS__                                                         \
>
> Let's instead put this (note it's without braces) in macros like these
>
> #define KVM_GENERIC_VM_STATS()                                                  \
>         STATS_DESC_COUNTER("remote_tlb_flush"),
>
> #define KVM_GENERIC_VCPU_STATS(...)                                             \
>         STATS_DESC_COUNTER("halt_successful_poll"),                             \
>         STATS_DESC_COUNTER("halt_attempted_poll"),                              \
>         STATS_DESC_COUNTER("halt_poll_invalid"),                                \
>         STATS_DESC_COUNTER("halt_wakeup"),                                      \
>         STATS_DESC_TIME_NSEC("halt_poll_success_ns"),                           \
>         STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),
>
> and it can be used in the arch files.  In fact it can even be added in patch 1 and
> switched to STATS_DESC_* here.
>
> Paolo
>
I just remember that the reason I used braces is due to following
error from checkpatch.pl:
ERROR: Macros with complex values should be enclosed in parentheses

So, just keep it as it is?

Thanks,
Jing
