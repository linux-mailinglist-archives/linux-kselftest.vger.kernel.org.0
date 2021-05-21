Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06ED38CDE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 May 2021 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhEUTFu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 May 2021 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhEUTFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 May 2021 15:05:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770EC0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 21 May 2021 12:04:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s25so25140611ljo.11
        for <linux-kselftest@vger.kernel.org>; Fri, 21 May 2021 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4c0xpiDdquziT96yZl3BHBXwubR9WKTGBWbOrT+AaXw=;
        b=pECMVQG59uyASUJzijmFgULjtz0WeSXtfGqwCTJG2j+ImfbbJ7Idt9TYYFm4tIh5IH
         R9tWzg69i+hjy158g1MjSB7Mz7DEsW7oz5U8qy+v+8wWvW0wYfkBXTh5OX/GlD2LFPMi
         C8LAEMY7I+MRLp0N9IWZ0Vp4vhgE7loV0bxxYgzxSyXWT8/fH8aU2msbrP6jIKVQO7tf
         xM4kXdA4GPVanJXhvwhALX5tp1GxBbFsrxjmcutTR7FTNKSIP95t7AcRXZNV/25kLVNM
         OkzP7/ynTJ2xK6k9rq0UpyN6X3sUm8d+2LuQmwcc24FjbjaIDkK4azYIJ8RtyTmDymNU
         Ktnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4c0xpiDdquziT96yZl3BHBXwubR9WKTGBWbOrT+AaXw=;
        b=hWpuqVO0xRNzjp+hhJE+/KkAHGLiwCccpvfmu5NowJKurzzH8hrWb+OS4Qdd8fglvT
         do/KosCNTkre7bVdHS8GfTFCnbGMKFQOsW1AS5ceCbgk9G64VMm0LqBd1wCytPmIxJdZ
         0GMZ8c3SkaZ8phylcKOuyKbXv7EuFFgYAP1hOhuqsvA3bDp5EfqCk0Bi7NqvD03tAcPx
         Ry30BXknzyDpq1Q5L09ghn6vb4joxz+QoQAefq2fdYthW9csc9uvU+n7KrWiuDwPQyvT
         bDGjSfdlGSKlH8QkLoKZq/OpoJ8cvJSYsSvUAxeJoybcXY3qT9qpwc9xvRXsYYaGcr/u
         imLA==
X-Gm-Message-State: AOAM530YGcRJG/zEFWYy1WqbvudCN0gMC3B2m4VLRcF+/uPHTuFRqkAS
        tv2pU9d72cunIgpY8JHHKKd6THwbk4caA0E5hRVSkA==
X-Google-Smtp-Source: ABdhPJwOfE4Z7GOUzAJmeJCq4dABeShpU2xSSiKXlcHwytE83fbH1JNzJEVwiDFuyyhMC72fGkxyFOTVjHXM1e9tnqs=
X-Received: by 2002:a2e:a7c9:: with SMTP id x9mr7858164ljp.216.1621623862953;
 Fri, 21 May 2021 12:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-2-jingzhangos@google.com> <CALzav=dGT7B7FWw_d5v3QaJxgfp6TZv7E4fdchG_7LKh+C17gg@mail.gmail.com>
 <CAAdAUtjyFhuh4iFJJOkkO20XXKqbcRO-S0ziFfUW1rHL-bkeZw@mail.gmail.com>
 <CALzav=dHjy8wnLckxifrjVDfVNBmqHcJgeS7PK6BnAp6UCyO5A@mail.gmail.com>
 <CAAdAUtiXE=CXU_LWG9SpnHsnqUBMC327jC2AvXAFX7-vwwoBog@mail.gmail.com> <24061be4-e1e1-e59b-d701-ea8723915e36@oracle.com>
In-Reply-To: <24061be4-e1e1-e59b-d701-ea8723915e36@oracle.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Fri, 21 May 2021 14:04:10 -0500
Message-ID: <CAAdAUtjDZGcmnubDw3x7tdNG=AFdu6sOG_4Z+AM63cmhQF3B8g@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] KVM: stats: Separate common stats from
 architecture specific ones
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     David Matlack <dmatlack@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 18, 2021 at 1:40 PM Krish Sadhukhan
<krish.sadhukhan@oracle.com> wrote:
>
>
> On 5/18/21 10:25 AM, Jing Zhang wrote:
> > Hi David,
> >
> > On Tue, May 18, 2021 at 11:27 AM David Matlack <dmatlack@google.com> wrote:
> >> On Mon, May 17, 2021 at 5:10 PM Jing Zhang <jingzhangos@google.com> wrote:
> >> <snip>
> >>> Actually the definition of kvm_{vcpu,vm}_stat are arch specific. There is
> >>> no real structure for arch agnostic stats. Most of the stats in common
> >>> structures are arch agnostic, but not all of them.
> >>> There are some benefits to put all common stats in a separate structure.
> >>> e.g. if we want to add a stat in kvm_main.c, we only need to add this stat
> >>> in the common structure, don't have to update all kvm_{vcpu,vm}_stat
> >>> definition for all architectures.
> >> I meant rename the existing arch-specific struct kvm_{vcpu,vm}_stat to
> >> kvm_{vcpu,vm}_stat_arch and rename struct kvm_{vcpu,vm}_stat_common to
> >> kvm_{vcpu,vm}_stat.
> >>
> >> So in  include/linux/kvm_types.h you'd have:
> >>
> >> struct kvm_vm_stat {
> >>    ulong remote_tlb_flush;
> >>    struct kvm_vm_stat_arch arch;
> >> };
> >>
> >> struct kvm_vcpu_stat {
> >>    u64 halt_successful_poll;
> >>    u64 halt_attempted_poll;
> >>    u64 halt_poll_invalid;
> >>    u64 halt_wakeup;
> >>    u64 halt_poll_success_ns;
> >>    u64 halt_poll_fail_ns;
> >>    struct kvm_vcpu_stat_arch arch;
> >> };
> >>
> >> And in arch/x86/include/asm/kvm_host.h you'd have:
> >>
> >> struct kvm_vm_stat_arch {
> >>    ulong mmu_shadow_zapped;
> >>    ...
> >> };
> >>
> >> struct kvm_vcpu_stat_arch {
> >>    u64 pf_fixed;
> >>    u64 pf_guest;
> >>    u64 tlb_flush;
> >>    ...
> >> };
> >>
> >> You still have the same benefits of having an arch-neutral place to
> >> store stats but the struct layout more closely resembles struct
> >> kvm_vcpu and struct kvm.
> > You are right. This is a more reasonable way to layout the structures.
> > I remember that I didn't choose this way is only because that it needs
> > touching every arch specific stats in all architectures (stat.name ->
> > stat.arch.name) instead of only touching arch neutral stats.
> > Let's see if there is any vote from others about this.
>
>
> +1
>
> >
> > Thanks,
> > Jing
It is still not fun to change hundreds of stats update code in every
architectures.
Let's keep it as it is for now and see how it is going.

Thanks,
Jing
