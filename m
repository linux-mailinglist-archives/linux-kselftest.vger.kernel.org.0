Return-Path: <linux-kselftest+bounces-32692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54FAB0709
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 02:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000E09C841D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5991CD15;
	Fri,  9 May 2025 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S/yhTzFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F6D53C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746750473; cv=none; b=lIliFWU7+b433ZbpBvj8ZRRlbTZWcC/a3YIf/hRlvfAKpG67kTu1Z/aSpOSzTJriiHrfyyJuY7jlxZycuFoNARXGor/DHOXu2OFnCBa3LZGcqan4iDwS0nK6MJefYdkpZ/2Lv7a0PTY8nx5Sd2cUyBoDjM5o4hnSJQ7p95W9Ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746750473; c=relaxed/simple;
	bh=4U0PtOTgyWwUYIgRnQyiflVPdeK7IJmEHyq/L90BZ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTWW7mEM6iinH7nCsvSRFuGUOJEG1L00RM1T4m5FSGsKqV52VO/HdJYwk43nEYJ8hwPElhVMbtHkFK8lXdMkInIswiBbBw+07e6s96emDDjH6eoy5yPGGWxYQxBQMkydKJ/MWNnZUMabusGGjuh9qErSmJbuax7lQDbGyocT070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S/yhTzFa; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a34e5893-0b7e-47e7-a655-a49e3472e0e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746750469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=focIGU9K6baIuUHoMWczpC1FYpctMA9LpP3THjX0tv8=;
	b=S/yhTzFakjdfMXIvQjosSdkUsGCK+8PEHBvMHiTyVuN7hXwQ0YNKGjTbLAvgLRrcw3avQY
	pduZN1V4KocO2xdemEmx1q1Huf/v1qISawu5FABFATS3F53m1xBxyHSFTO2wCmRWTZQBnq
	23VctDWhLqEMU7OCy3cyW5hPtb9dUTQ=
Date: Thu, 8 May 2025 17:26:52 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 11/14] RISC-V: KVM: add SBI extension init()/deinit()
 functions
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
 <20250424173204.1948385-12-cleger@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250424173204.1948385-12-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 10:31 AM, ClÃ©ment LÃ©ger wrote:
> The FWFT SBI extension will need to dynamically allocate memory and do
> init time specific initialization. Add an init/deinit callbacks that
> allows to do so.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
>   arch/riscv/kvm/vcpu.c                 |  2 ++
>   arch/riscv/kvm/vcpu_sbi.c             | 26 ++++++++++++++++++++++++++
>   3 files changed, 37 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index 4ed6203cdd30..bcb90757b149 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
>   
>   	/* Extension specific probe function */
>   	unsigned long (*probe)(struct kvm_vcpu *vcpu);
> +
> +	/*
> +	 * Init/deinit function called once during VCPU init/destroy. These
> +	 * might be use if the SBI extensions need to allocate or do specific
> +	 * init time only configuration.
> +	 */
> +	int (*init)(struct kvm_vcpu *vcpu);
> +	void (*deinit)(struct kvm_vcpu *vcpu);
>   };
>   
>   void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
> @@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>   bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
>   int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>   void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
>   
>   int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
>   				   unsigned long *reg_val);
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 60d684c76c58..877bcc85c067 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -185,6 +185,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>   
>   void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>   {
> +	kvm_riscv_vcpu_sbi_deinit(vcpu);
> +
>   	/* Cleanup VCPU AIA context */
>   	kvm_riscv_vcpu_aia_deinit(vcpu);
>   
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index d1c83a77735e..3139f171c20f 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -508,5 +508,31 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
>   		scontext->ext_status[idx] = ext->default_disabled ?
>   					KVM_RISCV_SBI_EXT_STATUS_DISABLED :
>   					KVM_RISCV_SBI_EXT_STATUS_ENABLED;
> +
> +		if (ext->init && ext->init(vcpu) != 0)
> +			scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
> +	}
> +}
> +
> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
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
> +		if (scontext->ext_status[idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE ||
> +		    !ext->deinit)
> +			continue;
> +
> +		ext->deinit(vcpu);
>   	}
>   }

LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>

