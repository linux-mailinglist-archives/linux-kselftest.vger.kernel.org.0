Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA75387E56
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351116AbhERR06 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351108AbhERR06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 13:26:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD56C061763
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 10:25:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w4so12481749ljw.9
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSnQ4LBK1uIXV07PEAq0LLHlwweU24rztLmKUUxmtEw=;
        b=cVzaFjUacrAERsYDIZbRfiVBm3UJe9PfiIi7VMEBI4+mneYhTfREF32Ug/H7xsKLXF
         xipKw744Y+OPokHmPOwiIilZlVMYtdOjIl5i+xzJy7TSKI5AdyAp62xAFFvkz5aGK7IR
         rcFwa6FW0Zd3WOBHc48RIIAD4Evo4cCVo4dzA/EBc5YwUsnO0+ec80kxrOAFwBSHfz24
         4e/5s/iwhO092+JJCHv/Mly7vK5p7eUvyheKOSI7fXe24zmHVEHwIeyudrmdfiXjw4AW
         BgKIuFcumclXiaD/TAOYs9fp/I9XvbqU76xLXdbQq1MXVo7j4RToAD81UGguuU1ez9aX
         XYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSnQ4LBK1uIXV07PEAq0LLHlwweU24rztLmKUUxmtEw=;
        b=smrJn65J6Oo/mNAA+SQA2r3kETHLFKqH+3XEycJCdTeSeT+G0pi7BY/oovcYYqb9Iy
         8sdjJtZGe4vM84me1gJdJe17v1SlJ+nnMYn2cqMN12toosSQZJuc/VktSfoxs0hZ6LF4
         2tNZyqNnnFSiFcbue1Z0EwY5Ei7R01iezAdpAecDVyFAip6EQP/+X88z12LlScfZk4FM
         5MQozXgJvr3tp7uIdLC/V4aiYhWjstwAGXi4nGLQZ2DI75oV2n/fs7nR6vUoxYurxBfo
         ptY8/5VXd1DRcoiZLh+q5QXMgyn8BEzz1cLT4r/agPHblW+gU6FxAxVa4unbYHQTWdf3
         4A5Q==
X-Gm-Message-State: AOAM533FNAQREgymJHIN/ketzzmDRsHHQE1Zu3gOMRjAeLsIZXmH52wW
        lWlwS5OjUV1hb9uyQhLZ38a7Dc3W+XY/KtvN7fEYxw==
X-Google-Smtp-Source: ABdhPJwmvfrKFgUyKP/HRH4nFuJ9B6kEhZAEG5g+dr6hELyJdzM7GIR8aVIZG1uUChl8DfU1otU2kJaVQc2bMkV5kGM=
X-Received: by 2002:a2e:87ce:: with SMTP id v14mr4952952ljj.28.1621358736766;
 Tue, 18 May 2021 10:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-2-jingzhangos@google.com> <CALzav=dGT7B7FWw_d5v3QaJxgfp6TZv7E4fdchG_7LKh+C17gg@mail.gmail.com>
 <CAAdAUtjyFhuh4iFJJOkkO20XXKqbcRO-S0ziFfUW1rHL-bkeZw@mail.gmail.com> <CALzav=dHjy8wnLckxifrjVDfVNBmqHcJgeS7PK6BnAp6UCyO5A@mail.gmail.com>
In-Reply-To: <CALzav=dHjy8wnLckxifrjVDfVNBmqHcJgeS7PK6BnAp6UCyO5A@mail.gmail.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Tue, 18 May 2021 12:25:24 -0500
Message-ID: <CAAdAUtiXE=CXU_LWG9SpnHsnqUBMC327jC2AvXAFX7-vwwoBog@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] KVM: stats: Separate common stats from
 architecture specific ones
To:     David Matlack <dmatlack@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
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

Hi David,

On Tue, May 18, 2021 at 11:27 AM David Matlack <dmatlack@google.com> wrote:
>
> On Mon, May 17, 2021 at 5:10 PM Jing Zhang <jingzhangos@google.com> wrote:
> <snip>
> > Actually the definition of kvm_{vcpu,vm}_stat are arch specific. There is
> > no real structure for arch agnostic stats. Most of the stats in common
> > structures are arch agnostic, but not all of them.
> > There are some benefits to put all common stats in a separate structure.
> > e.g. if we want to add a stat in kvm_main.c, we only need to add this stat
> > in the common structure, don't have to update all kvm_{vcpu,vm}_stat
> > definition for all architectures.
>
> I meant rename the existing arch-specific struct kvm_{vcpu,vm}_stat to
> kvm_{vcpu,vm}_stat_arch and rename struct kvm_{vcpu,vm}_stat_common to
> kvm_{vcpu,vm}_stat.
>
> So in  include/linux/kvm_types.h you'd have:
>
> struct kvm_vm_stat {
>   ulong remote_tlb_flush;
>   struct kvm_vm_stat_arch arch;
> };
>
> struct kvm_vcpu_stat {
>   u64 halt_successful_poll;
>   u64 halt_attempted_poll;
>   u64 halt_poll_invalid;
>   u64 halt_wakeup;
>   u64 halt_poll_success_ns;
>   u64 halt_poll_fail_ns;
>   struct kvm_vcpu_stat_arch arch;
> };
>
> And in arch/x86/include/asm/kvm_host.h you'd have:
>
> struct kvm_vm_stat_arch {
>   ulong mmu_shadow_zapped;
>   ...
> };
>
> struct kvm_vcpu_stat_arch {
>   u64 pf_fixed;
>   u64 pf_guest;
>   u64 tlb_flush;
>   ...
> };
>
> You still have the same benefits of having an arch-neutral place to
> store stats but the struct layout more closely resembles struct
> kvm_vcpu and struct kvm.
You are right. This is a more reasonable way to layout the structures.
I remember that I didn't choose this way is only because that it needs
touching every arch specific stats in all architectures (stat.name ->
stat.arch.name) instead of only touching arch neutral stats.
Let's see if there is any vote from others about this.

Thanks,
Jing
