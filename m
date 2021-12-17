Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883F74784A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 06:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhLQFr2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 00:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhLQFr1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 00:47:27 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2974C06173E
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 21:47:27 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g17so3169244ybe.13
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 21:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwdXAZqwcOgfTzbPvhOiD7YDfbOTo8m/P9qk7qvdRbg=;
        b=TbJ8b6Q1XadCQi/ETXO7KnR0eVyxVPo6CYumNoLxIIHHsWte48o341tqjtH/OZIKz1
         D+yS5qpJMo9NJYArpISYebQHEghellf1QZRJq/vkFJfRf8fIv8WO2io3c2Az6JqJXRFZ
         oH7HEaBC/awQW4WTz17249wf3AtN3MwJMqYso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwdXAZqwcOgfTzbPvhOiD7YDfbOTo8m/P9qk7qvdRbg=;
        b=fjo+0DUk/Yzj1XWU4wB5XGXBQyYtlogeur70EP2aPXqB/SiRA1BAQw4zpPmFTVRN4b
         O/8ZBBC9LwuWYSnC+q/nPcwJXFta8LpuynJTnKwGkuo+IlCnJxUU7EaMw/YOark7j6jv
         jVrWnJ+uyCfplZfmXiRaYVO/6lbkWi3Vo01QPXg4kT5HsDDX8wZURpbmX8Ud7upxo9FT
         Gx93pZ4YK8eUObLLbpL1IvHZVlC6R0q3yi7HZc9ZTf9MvDpCdUFP9yq/dltjkUjataKx
         QCXTh4uQNMnW/KVL69ZpzNm7fsNG/WepHeNWaf3+jqRFaNjW33gVil4X0rG++38DtdRn
         d3pQ==
X-Gm-Message-State: AOAM532gDdqn+39bOztOLS/DAiQz1KT+IIACq/YLzfHpa8rtle+5FQLj
        4vmha37K8/GIVvQkq1taY8h2kM3n4LJKsIuhDA6w
X-Google-Smtp-Source: ABdhPJym0ejx2zDX2ah9KB9aFnBYNo3/Jeu0eMo9QzZYrU+lCsv59ObD5++THmdkCuYRNxANRZg8W5NhsjmGjXossFA=
X-Received: by 2002:a25:2450:: with SMTP id k77mr2228286ybk.121.1639720046870;
 Thu, 16 Dec 2021 21:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20211129075451.418122-1-anup.patel@wdc.com> <20211129075451.418122-3-anup.patel@wdc.com>
In-Reply-To: <20211129075451.418122-3-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 16 Dec 2021 21:47:16 -0800
Message-ID: <CAOnJCU+Yft5EjgUUCi=nW79pYSGYPWB1ew5iyTjViFvGGQxQCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] RISC-V: KVM: Add VM capability to allow userspace
 get GPA bits
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 29, 2021 at 12:10 AM Anup Patel <anup.patel@wdc.com> wrote:
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
> ---
>  arch/riscv/include/asm/kvm_host.h | 1 +
>  arch/riscv/kvm/mmu.c              | 5 +++++
>  arch/riscv/kvm/vm.c               | 3 +++
>  include/uapi/linux/kvm.h          | 1 +
>  4 files changed, 10 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 37589b953bcb..ae5d238607fe 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -221,6 +221,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
>  void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
>  void kvm_riscv_stage2_mode_detect(void);
>  unsigned long kvm_riscv_stage2_mode(void);
> +int kvm_riscv_stage2_gpa_size(void);
>
>  void kvm_riscv_stage2_vmid_detect(void);
>  unsigned long kvm_riscv_stage2_vmid_bits(void);
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 9ffd0255af43..9b6d6465094f 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -760,3 +760,8 @@ unsigned long kvm_riscv_stage2_mode(void)
>  {
>         return stage2_mode >> HGATP_MODE_SHIFT;
>  }
> +
> +int kvm_riscv_stage2_gpa_size(void)
> +{
> +       return stage2_gpa_bits;
> +}

The ioctl & the underlying stage2_gpa_bits has bits.
Maybe rename the function to kvm_riscv_stage2_gpa_bits as well ?

> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index fb18af34a4b5..6f959639ec45 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>         case KVM_CAP_NR_MEMSLOTS:
>                 r = KVM_USER_MEM_SLOTS;
>                 break;
> +       case KVM_CAP_VM_GPA_BITS:
> +               r = kvm_riscv_stage2_gpa_size();
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

Other than that, it looks good to me.

Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
