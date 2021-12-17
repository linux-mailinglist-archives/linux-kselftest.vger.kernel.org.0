Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6724784CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 07:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhLQGJN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 01:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhLQGJN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 01:09:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260CEC06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 22:09:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s1so2048595wrg.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 22:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QH2bkz/dvyar0Slq99MmeQR+6WQT9L3G9+6vCacYMo=;
        b=waZfM5crmwh+YUwgryZwAjwMKciDhj6hG65pBTNwrjBM1A46dmd2m6KpjWRAhkl7wd
         JS5DVW8eO8Uimxc6CRvZGASqDGLGtIxT4pSS0Q2yP0/cxQFGmnbL+M26OJP39exU97n0
         ETsBk5MuDSbC3hzEQ70IMoZ4xcLGze2MiNSUmzKUo7GcPuIT1FE30tKffUNi1PngZwEz
         lUWM2lZNQcNejkV4FWNaW92ubDzXPPfkhSVPEav86ScTugM5bW0DnVYgUtNU/mGHdZve
         pdei1icgv91nuiO75ZrsV1uhdHx38sMaqJ68d4EfYlXeJWiU/6kGGxyhzSsxq/sH6LyP
         ojqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QH2bkz/dvyar0Slq99MmeQR+6WQT9L3G9+6vCacYMo=;
        b=jdzTIioPiJU1a7wpc01RoE+aZgTOiCOeXfzlP/s/u6jVFau1RIaXykzIPDKEh3dLZC
         r8fE3ZzxHfTfBjI0YV2Nmcj5J/trqqwud1aW+K9heBxjniM7fLrtPY0WSEfuibx6r9DZ
         Sv3F4wBurmWawCx55YpvRI6SdvRdTz2bXgiwJBH4JHge6kCYwEA31IDBXzyojvEus9CI
         K4VWFZfcsoyohqJZvyy65/1ZT22ioU6fvP5kNd/qzRMCA4MrAGk74xD+AbeBfzzf6lth
         ceczgH/cyHpBiCBvnN8W2ZfFOTqvs/aSWp7v+uxjeOe+QRiqomz3yewP/qrNd3FLBuCO
         ykPw==
X-Gm-Message-State: AOAM531hn08l8oOXcquV2pfLh9IrsoiHzODDiXoahbLQ+N13UYuPjEJZ
        rleUseMhGtkrZQKVkrzyFtHh3GKNLQnka05UAicqmA==
X-Google-Smtp-Source: ABdhPJwEquvnLOderDNKIdJ1HekDsTALy8TIENkzMKo1N7N3wuyG5X3zylXVjua0nOnoW8rY/7T9uIm++VL6JFu35Vw=
X-Received: by 2002:a5d:56c2:: with SMTP id m2mr1095151wrw.313.1639721351448;
 Thu, 16 Dec 2021 22:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20211129075451.418122-1-anup.patel@wdc.com> <20211129075451.418122-3-anup.patel@wdc.com>
 <CAOnJCU+Yft5EjgUUCi=nW79pYSGYPWB1ew5iyTjViFvGGQxQCA@mail.gmail.com>
In-Reply-To: <CAOnJCU+Yft5EjgUUCi=nW79pYSGYPWB1ew5iyTjViFvGGQxQCA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Dec 2021 11:38:59 +0530
Message-ID: <CAAhSdy1WXnoFw2_o+6E1zjx5bP96FeW3ijMuOp3R794Yxasskg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] RISC-V: KVM: Add VM capability to allow userspace
 get GPA bits
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
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

On Fri, Dec 17, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Mon, Nov 29, 2021 at 12:10 AM Anup Patel <anup.patel@wdc.com> wrote:
> >
> > The number of GPA bits supported for a RISC-V Guest/VM is based on the
> > MMU mode used by the G-stage translation. The KVM RISC-V will detect and
> > use the best possible MMU mode for the G-stage in kvm_arch_init().
> >
> > We add a generic VM capability KVM_CAP_VM_GPA_BITS which can be used by
> > the KVM userspace to get the number of GPA (guest physical address) bits
> > supported for a Guest/VM.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/include/asm/kvm_host.h | 1 +
> >  arch/riscv/kvm/mmu.c              | 5 +++++
> >  arch/riscv/kvm/vm.c               | 3 +++
> >  include/uapi/linux/kvm.h          | 1 +
> >  4 files changed, 10 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> > index 37589b953bcb..ae5d238607fe 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -221,6 +221,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
> >  void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
> >  void kvm_riscv_stage2_mode_detect(void);
> >  unsigned long kvm_riscv_stage2_mode(void);
> > +int kvm_riscv_stage2_gpa_size(void);
> >
> >  void kvm_riscv_stage2_vmid_detect(void);
> >  unsigned long kvm_riscv_stage2_vmid_bits(void);
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index 9ffd0255af43..9b6d6465094f 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -760,3 +760,8 @@ unsigned long kvm_riscv_stage2_mode(void)
> >  {
> >         return stage2_mode >> HGATP_MODE_SHIFT;
> >  }
> > +
> > +int kvm_riscv_stage2_gpa_size(void)
> > +{
> > +       return stage2_gpa_bits;
> > +}
>
> The ioctl & the underlying stage2_gpa_bits has bits.
> Maybe rename the function to kvm_riscv_stage2_gpa_bits as well ?

Okay, I will rename in the next revision.

Thanks,
Anup

>
> > diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> > index fb18af34a4b5..6f959639ec45 100644
> > --- a/arch/riscv/kvm/vm.c
> > +++ b/arch/riscv/kvm/vm.c
> > @@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >         case KVM_CAP_NR_MEMSLOTS:
> >                 r = KVM_USER_MEM_SLOTS;
> >                 break;
> > +       case KVM_CAP_VM_GPA_BITS:
> > +               r = kvm_riscv_stage2_gpa_size();
> > +               break;
> >         default:
> >                 r = 0;
> >                 break;
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 1daa45268de2..469f05d69c8d 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
> >  #define KVM_CAP_ARM_MTE 205
> >  #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
> > +#define KVM_CAP_VM_GPA_BITS 207
> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> > --
> > 2.25.1
> >
>
> Other than that, it looks good to me.
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>
>
> --
> Regards,
> Atish
