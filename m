Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90A460D6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 04:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359721AbhK2DqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Nov 2021 22:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347304AbhK2DoG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Nov 2021 22:44:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15017C061574
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Nov 2021 19:40:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so15717670wme.0
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Nov 2021 19:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHoWN3qsrC9PjO8f+fhaJ1a87+hWxCOTLw3EtpXfuKo=;
        b=6BnctyDHGkdqp5PF0QNSAgoJ6HrlI6ALPrdjxjj1/Vtv+HDCN4xmasn1GbjHiMyKMc
         u4eG4kh9FSX1wmSF0EoprhkiNL7NWt3n3lU16XjzsWj5Yfh3aiwtpCW6orLBtvkimPzH
         518o2kfAe3MpRwu5scQ8v9mEGxqbJExhSO5OVtg3Fv6noQYr4MDDmjU0EPtCaEBuTMpJ
         NyeTwgVy5p+nJAAVh1qh6iDgGeBpLMKH+YN8NankGfnvOaqMI8q2ZEpUQlOJFoQ78VXU
         AErhlh4vPQF826DPhb+4BsKM+xWnQdkrFHDiUhqzEZpcmHtj6uDVhSwHOKEPwAxiyY4D
         Eh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHoWN3qsrC9PjO8f+fhaJ1a87+hWxCOTLw3EtpXfuKo=;
        b=dhjvMxJC+/tFt4SStm2QXh/LGb8xdHYhOuvRImAtImSn5+SIfZ9Mqit91/kHIUzaDU
         idBgLdZKEVPsDKlqiNLqV1b9EXQ6H49O1l+NbbdqHIiU6EXKauOShkL1mNhsqE9bDfAc
         24kapxruxfsc880y3UuYzmqWTTxzmAeJynJuT0BONQ1+UZKZ98q7bmnzoA4XgnHcjqE4
         +WjuWJHy5J+htMGvOWzPpcuw9BCBSweuTWDwCq37Wttfhu197VjHBwVl9B14BHMdGImQ
         PIrf4tuSNGwHkvVo7ZQTFUVyC8Wa/SfvPFcvbU0ANp4gOSH7IMPtA1fXxRw93/iY8STo
         QMZg==
X-Gm-Message-State: AOAM532Rsp8oscVbt+CXPPwH0a0Ec2zMFhyhRgtbudYwuidG2HECyzoF
        O8neWOs0eEI0sOOhRrr6Fg95knbP7xIealign0DEEA==
X-Google-Smtp-Source: ABdhPJye1t6ElsPCeS1s6UZ/CRrpaWYJ5xKmqKZNSpbvlCjLK9dQjMtOM2OpdagX1S7Yl7xZiLvXmuXsti1liEKcAA8=
X-Received: by 2002:a7b:c017:: with SMTP id c23mr33597189wmb.137.1638157247562;
 Sun, 28 Nov 2021 19:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20211126154020.342924-1-anup.patel@wdc.com> <20211126154020.342924-3-anup.patel@wdc.com>
 <4fcb162a-738b-64e7-6326-9f9967d1b8a8@redhat.com>
In-Reply-To: <4fcb162a-738b-64e7-6326-9f9967d1b8a8@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Nov 2021 09:10:36 +0530
Message-ID: <CAAhSdy0EVLVjbD9XdM_-DyjRjH4C3Bo9=WUbm6HUJ8NmPpeH_g@mail.gmail.com>
Subject: Re: [PATCH 2/4] RISC-V: KVM: Add VM capability to allow userspace get
 GPA size
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 26, 2021 at 9:43 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/26/21 16:40, Anup Patel wrote:
> > The GPA size supported for a RISC-V Guest/VM is based on the MMU mode
> > used by G-stage translation. The KVM RISC-V will detect and use the
> > best possible MMU mode for the G-stage in kvm_arch_init().
> >
> > We add a RISC-V specific VM capability KVM_CAP_RISCV_VM_GPA_SIZE which
>
> You can make it just KVM_CAP_VM_GPA_BITS instead - it's useful on other
> architectures as well.

Sure, I will update.

Regards,
Anup

>
> Paolo
>
> > can be used by KVM userspace to get guest physical address (GPA) size
> > (i.e. number of GPA bits) supported for a Guest/VM.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >   arch/riscv/include/asm/kvm_host.h | 1 +
> >   arch/riscv/kvm/mmu.c              | 5 +++++
> >   arch/riscv/kvm/vm.c               | 3 +++
> >   include/uapi/linux/kvm.h          | 1 +
> >   4 files changed, 10 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> > index 37589b953bcb..ae5d238607fe 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -221,6 +221,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
> >   void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
> >   void kvm_riscv_stage2_mode_detect(void);
> >   unsigned long kvm_riscv_stage2_mode(void);
> > +int kvm_riscv_stage2_gpa_size(void);
> >
> >   void kvm_riscv_stage2_vmid_detect(void);
> >   unsigned long kvm_riscv_stage2_vmid_bits(void);
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index 9ffd0255af43..9b6d6465094f 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -760,3 +760,8 @@ unsigned long kvm_riscv_stage2_mode(void)
> >   {
> >       return stage2_mode >> HGATP_MODE_SHIFT;
> >   }
> > +
> > +int kvm_riscv_stage2_gpa_size(void)
> > +{
> > +     return stage2_gpa_bits;
> > +}
> > diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> > index fb18af34a4b5..ae97f6929897 100644
> > --- a/arch/riscv/kvm/vm.c
> > +++ b/arch/riscv/kvm/vm.c
> > @@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >       case KVM_CAP_NR_MEMSLOTS:
> >               r = KVM_USER_MEM_SLOTS;
> >               break;
> > +     case KVM_CAP_RISCV_VM_GPA_SIZE:
> > +             r = kvm_riscv_stage2_gpa_size();
> > +             break;
> >       default:
> >               r = 0;
> >               break;
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 1daa45268de2..dac98df3101d 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
> >   #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
> >   #define KVM_CAP_ARM_MTE 205
> >   #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
> > +#define KVM_CAP_RISCV_VM_GPA_SIZE 207
> >
> >   #ifdef KVM_CAP_IRQ_ROUTING
> >
> >
>
