Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EEE45F18A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhKZQS7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 11:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378492AbhKZQQ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 11:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637943225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TivTs0wWKeTxFbwRk84lL1Qj0tiDczM43dDBlfnrKZ0=;
        b=d0xfJjNCjRQL6gMsvkuEvdVnbDwWhpl8vsSZy/AKzD8IJGGYb3JENQ6IaBx2gTSmuQjSSg
        kELnMlgPNCiai4bIZf2DvJfItJYsiRS/QToseVJL9xWAbx4xlQi6NBRxfQjYigg1HVdb7B
        jT4MkoXeuut/lWUOtrtDTdZG35VTOxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-c8l_yIgkMAufgYBwubM3zQ-1; Fri, 26 Nov 2021 11:13:42 -0500
X-MC-Unique: c8l_yIgkMAufgYBwubM3zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9ED1023F4D;
        Fri, 26 Nov 2021 16:13:40 +0000 (UTC)
Received: from [10.39.195.16] (unknown [10.39.195.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7EE76606;
        Fri, 26 Nov 2021 16:13:37 +0000 (UTC)
Message-ID: <4fcb162a-738b-64e7-6326-9f9967d1b8a8@redhat.com>
Date:   Fri, 26 Nov 2021 17:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/4] RISC-V: KVM: Add VM capability to allow userspace get
 GPA size
Content-Language: en-US
To:     Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211126154020.342924-1-anup.patel@wdc.com>
 <20211126154020.342924-3-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211126154020.342924-3-anup.patel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/26/21 16:40, Anup Patel wrote:
> The GPA size supported for a RISC-V Guest/VM is based on the MMU mode
> used by G-stage translation. The KVM RISC-V will detect and use the
> best possible MMU mode for the G-stage in kvm_arch_init().
> 
> We add a RISC-V specific VM capability KVM_CAP_RISCV_VM_GPA_SIZE which

You can make it just KVM_CAP_VM_GPA_BITS instead - it's useful on other 
architectures as well.

Paolo

> can be used by KVM userspace to get guest physical address (GPA) size
> (i.e. number of GPA bits) supported for a Guest/VM.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>   arch/riscv/include/asm/kvm_host.h | 1 +
>   arch/riscv/kvm/mmu.c              | 5 +++++
>   arch/riscv/kvm/vm.c               | 3 +++
>   include/uapi/linux/kvm.h          | 1 +
>   4 files changed, 10 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 37589b953bcb..ae5d238607fe 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -221,6 +221,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
>   void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
>   void kvm_riscv_stage2_mode_detect(void);
>   unsigned long kvm_riscv_stage2_mode(void);
> +int kvm_riscv_stage2_gpa_size(void);
>   
>   void kvm_riscv_stage2_vmid_detect(void);
>   unsigned long kvm_riscv_stage2_vmid_bits(void);
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 9ffd0255af43..9b6d6465094f 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -760,3 +760,8 @@ unsigned long kvm_riscv_stage2_mode(void)
>   {
>   	return stage2_mode >> HGATP_MODE_SHIFT;
>   }
> +
> +int kvm_riscv_stage2_gpa_size(void)
> +{
> +	return stage2_gpa_bits;
> +}
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index fb18af34a4b5..ae97f6929897 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_NR_MEMSLOTS:
>   		r = KVM_USER_MEM_SLOTS;
>   		break;
> +	case KVM_CAP_RISCV_VM_GPA_SIZE:
> +		r = kvm_riscv_stage2_gpa_size();
> +		break;
>   	default:
>   		r = 0;
>   		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1daa45268de2..dac98df3101d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>   #define KVM_CAP_ARM_MTE 205
>   #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
> +#define KVM_CAP_RISCV_VM_GPA_SIZE 207
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> 

