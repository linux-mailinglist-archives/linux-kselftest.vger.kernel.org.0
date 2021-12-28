Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162984806AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Dec 2021 07:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhL1GUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Dec 2021 01:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhL1GUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Dec 2021 01:20:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71CC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Dec 2021 22:20:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t26so36327096wrb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Dec 2021 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxMuslxDg2S3RmGiAouREuoen21s3vRjxpPLCKGYDOs=;
        b=U5bV+uGyfh50ndVDYNS4v8SIYAIV7TP4jb4JRs/qKkRb363U8GOEwqMIaXYWHnWQHY
         hzgYFZYX1N5JjkSd/rNXhDJIZhcBE13FCjLdQjkLfjljxYubVQ0PcOKltArbh4Qn8kjy
         DV1nNXhwAsVtLducS7lQBaXgVBJiAYLhM9oWbhofkvbQBGM076NOf5sRcvVlaQ5xidkk
         zn1JXUg13XN4J2WyZlFBXJ1U7LuaD8n56DfQz3Wlj0LYreGacNOrBoZ5VGLIQorNTZsm
         ps3iYeyLMvSPCSZQPVP3b2e4aGZwvAB/Jh5/optZ+eMaFXydOlP9qV3RWN5QT7aK5I8f
         cXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxMuslxDg2S3RmGiAouREuoen21s3vRjxpPLCKGYDOs=;
        b=tp4fhcKBTc+6tzyePMeXEUBvzTJQRmINhzEuz+xduAsa44iZP2HhsGy7rguwxTGFrq
         Wma0NiEKkZQVQaCq7wj02RD+xVqLJA7kvfGnBiG4QT0WoWUQleBeF2tlRpZRhHPwWfmR
         s0suPET2XiRkDCgsC14AtrnC3i9dlqewWqG5xNEA46yEq0O2cswpgMUWnvoX0lmC7WJy
         f6nd+i5rMx91cfcOVRS/SzXIqU8wFx5YknhtuL1aHZVdkfklYyf1VrktfqyNJM/LD8mz
         vT02VGaK1jWbINymnXoWbxyXJNur8jlYeUxFwfyhl3jRDvaohaQjX8MJkeSkvM6OG842
         NagA==
X-Gm-Message-State: AOAM532kkfaqDXQ8x6SEkcAuryCsHCtHzPTy1G9rFNnEzIL2Ste8EHn7
        E+Ld1+x9wqCRt2rUtEcI4Vn/R27hPe8/pz6wD4WHvQ==
X-Google-Smtp-Source: ABdhPJxPxIuKiLfECI1gIGeabM+airz3qfDP8dU5RAgK/IaKfx4bJkcGaOV3uUbgjVxC8g8TAdk41Ao3iLE07aQeNos=
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr14860743wrd.346.1640672447584;
 Mon, 27 Dec 2021 22:20:47 -0800 (PST)
MIME-Version: 1.0
References: <20211224073604.1085464-1-anup.patel@wdc.com> <20211224073604.1085464-3-anup.patel@wdc.com>
In-Reply-To: <20211224073604.1085464-3-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 28 Dec 2021 11:50:35 +0530
Message-ID: <CAAhSdy1NE1LhwpU=TE8LnES6c7AQiq04zNJkSv2nLk=BOnYLsQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] RISC-V: KVM: Add VM capability to allow userspace
 get GPA bits
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 24, 2021 at 1:06 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The number of GPA bits supported for a RISC-V Guest/VM is based on the
> MMU mode used by the G-stage translation. The KVM RISC-V will detect and
> use the best possible MMU mode for the G-stage in kvm_arch_init().
>
> We add a generic VM capability KVM_CAP_VM_GPA_BITS which can be used by
> the KVM userspace to get the number of GPA (guest physical address) bits
> supported for a Guest/VM.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-and-tested-by: Atish Patra <atishp@rivosinc.com>

Queued this patch for 5.17

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_host.h | 1 +
>  arch/riscv/kvm/mmu.c              | 5 +++++
>  arch/riscv/kvm/vm.c               | 3 +++
>  include/uapi/linux/kvm.h          | 1 +
>  4 files changed, 10 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 247b761c72fd..ac38696abedf 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -219,6 +219,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
>  void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
>  void kvm_riscv_stage2_mode_detect(void);
>  unsigned long kvm_riscv_stage2_mode(void);
> +int kvm_riscv_stage2_gpa_bits(void);
>
>  void kvm_riscv_stage2_vmid_detect(void);
>  unsigned long kvm_riscv_stage2_vmid_bits(void);
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index d0efdc2259dc..58a47c93e5f9 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -766,3 +766,8 @@ unsigned long kvm_riscv_stage2_mode(void)
>  {
>         return stage2_mode >> HGATP_MODE_SHIFT;
>  }
> +
> +int kvm_riscv_stage2_gpa_bits(void)
> +{
> +       return stage2_gpa_bits;
> +}
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index fb18af34a4b5..1e12c19a7c6a 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>         case KVM_CAP_NR_MEMSLOTS:
>                 r = KVM_USER_MEM_SLOTS;
>                 break;
> +       case KVM_CAP_VM_GPA_BITS:
> +               r = kvm_riscv_stage2_gpa_bits();
> +               break;
>         default:
>                 r = 0;
>                 break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1daa45268de2..469f05d69c8d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>  #define KVM_CAP_ARM_MTE 205
>  #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
> +#define KVM_CAP_VM_GPA_BITS 207
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> --
> 2.25.1
>
