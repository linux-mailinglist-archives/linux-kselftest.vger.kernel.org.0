Return-Path: <linux-kselftest+bounces-32693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B6AB070E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 02:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37709C856A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 00:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464C4685;
	Fri,  9 May 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AIoIe5iL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449829444
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746750503; cv=none; b=K//wnRlCNphqijrRgqzKhkR5Dhvi+aoMnr1DOqJsP+ZRFYScQ5U4hewah3ZQ3FPbY30cOVD3BaJmfs4aUyJGECr2tEutc36GEAj59bApS38dtL3WpJiYAOJvcNBl3Al85oYYDoR5ZNS/aotoie1z+hH6jKSzr/w1jshG7bcUs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746750503; c=relaxed/simple;
	bh=qvaw1+bpkz9e/S+v0MFjOEMz7rE+X3NJg6ZLCOtv09g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFLh0g0XVT8TE6Fj11hNoqizxcvtIFf+h3EmVtELjzq2gsj9ZfXnfezYa/mKwrya5XAgyywhDqSgEiWC+8pxIh19RfNNjejU/7glD6gzlJGLZWSu1NTBDKNg5oP8dVwnG0L28YW+gcVjQdugah6qBzM4EOpjsO3Uvl1R5U7470A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AIoIe5iL; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <736362de-d7b8-43f7-bffc-ccc65b1502ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746750496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpDyd9m4f0VTtTwqCI5FJLDJbDxqQDx4DRnCSO33TkU=;
	b=AIoIe5iLR0x6PodTEqjsX7siYT6h8X8eIyrcgi4FEeAW38xa0HOvnxgJgYH85Rqo6C8VcG
	NhdmPGJ6BgEuo973WzHrbciKCCY5dVAodsfj97nSf+buOLWOegwZSYutB9mGCg3xmSavCf
	+lKwl7t/GeIDVFsYsFg8gsSuq+AyP4c=
Date: Thu, 8 May 2025 17:28:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 12/14] RISC-V: KVM: add SBI extension reset callback
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-13-cleger@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250424173204.1948385-13-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 10:31 AM, ClÃ©ment LÃ©ger wrote:
> Currently, only the STA extension needed a reset function but that's
> going to be the case for FWFT as well. Add a reset callback that can be
> implemented by SBI extensions.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/include/asm/kvm_host.h     |  1 -
>   arch/riscv/include/asm/kvm_vcpu_sbi.h |  2 ++
>   arch/riscv/kvm/vcpu.c                 |  2 +-
>   arch/riscv/kvm/vcpu_sbi.c             | 24 ++++++++++++++++++++++++
>   arch/riscv/kvm/vcpu_sbi_sta.c         |  3 ++-
>   5 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 0e9c2fab6378..4fa02e082142 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -407,7 +407,6 @@ void __kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
>   void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
>   bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
>   
> -void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu);
>   void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
>   
>   #endif /* __RISCV_KVM_HOST_H__ */
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index bcb90757b149..cb68b3a57c8f 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -57,6 +57,7 @@ struct kvm_vcpu_sbi_extension {
>   	 */
>   	int (*init)(struct kvm_vcpu *vcpu);
>   	void (*deinit)(struct kvm_vcpu *vcpu);
> +	void (*reset)(struct kvm_vcpu *vcpu);
>   };
>   
>   void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
> @@ -78,6 +79,7 @@ bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
>   int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>   void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
>   void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu);
>   
>   int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
>   				   unsigned long *reg_val);
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 877bcc85c067..542747e2c7f5 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -94,7 +94,7 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>   	vcpu->arch.hfence_tail = 0;
>   	memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue));
>   
> -	kvm_riscv_vcpu_sbi_sta_reset(vcpu);
> +	kvm_riscv_vcpu_sbi_reset(vcpu);
>   
>   	/* Reset the guest CSRs for hotplug usecase */
>   	if (loaded)
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 3139f171c20f..50be079b5528 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -536,3 +536,27 @@ void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
>   		ext->deinit(vcpu);
>   	}
>   }
> +
> +void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
> +	const struct kvm_riscv_sbi_extension_entry *entry;
> +	const struct kvm_vcpu_sbi_extension *ext;
> +	int idx, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
> +		entry = &sbi_ext[i];
> +		ext = entry->ext_ptr;
> +		idx = entry->ext_idx;
> +
> +		if (idx < 0 || idx >= ARRAY_SIZE(scontext->ext_status))
> +			continue;
> +
> +		if (scontext->ext_status[idx] != KVM_RISCV_SBI_EXT_STATUS_ENABLED ||
> +		    !ext->reset)
> +			continue;
> +
> +		ext->reset(vcpu);
> +	}
> +}
> +
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> index 5f35427114c1..cc6cb7c8f0e4 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -16,7 +16,7 @@
>   #include <asm/sbi.h>
>   #include <asm/uaccess.h>
>   
> -void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
> +static void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
>   {
>   	vcpu->arch.sta.shmem = INVALID_GPA;
>   	vcpu->arch.sta.last_steal = 0;
> @@ -156,6 +156,7 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
>   	.extid_end = SBI_EXT_STA,
>   	.handler = kvm_sbi_ext_sta_handler,
>   	.probe = kvm_sbi_ext_sta_probe,
> +	.reset = kvm_riscv_vcpu_sbi_sta_reset,
>   };
>   
>   int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu,

LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>

