Return-Path: <linux-kselftest+bounces-32772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39709AB1CA6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 20:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714AA5079E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353523FC74;
	Fri,  9 May 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uLqyyUS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0923F409
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816588; cv=none; b=Z23Xa/nsA5wghOgxEAbJDeR/NqT1bDDtdo10lzDjAtPUbQls9CJ0H8L80Mw3+hc3PliRBIoB53huSvLIG93CFdvhqq7cN5gqpAFUi3uFvDRG/8reCl+twJs/wWN9iNum3yjfGztzlarYEJzTQqIWuTrrcXxRGGcvUdGU6XNq/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816588; c=relaxed/simple;
	bh=qffBJkvqeUNO/und6Qh2RkE/6kc4df+T6b36gSTk63Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkfyrbA30AsNUi4oRg+DYef/sEvO/c8Hko8ZslbuPhbPfhR/8jp1oZLMDbJnMLNZdL8aDX1UiM+JIUOXFNZ1d8OBVdP+7qfI4G6q4CC9QzR/kJ5gS/B8ieXUvf5s4dr7Dy4cmA4nYm5zsOG/LvEwfqlAs6jaGokvWHsgJcrx94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLqyyUS4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f24ee7d-df01-4386-b0c2-f68463519940@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746816574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+xTVNz/AWuQaww+Av/gvPGG3Ux3gd4hrwHisXmdbVY=;
	b=uLqyyUS4mIQdPlYV7BSaILMetdyUkWxvIzHUMEOjSkHuGCm8a+Fy92UlKRYZaI5kWt5UQv
	mx/LC1tQC1sGXBA+pYOVjeP48ZSFr3n6iJpJkJ32cHD0sYy8qI7TmLvtrA6M6VMTydMeev
	wBorqTZBxwlM+8HVuZqqoSfXhImvhLc=
Date: Fri, 9 May 2025 11:49:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 13/14] RISC-V: KVM: add support for FWFT SBI extension
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
 <20250424173204.1948385-14-cleger@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250424173204.1948385-14-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 10:32 AM, ClÃ©ment LÃ©ger wrote:
> Add basic infrastructure to support the FWFT extension in KVM.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/include/asm/kvm_host.h          |   4 +
>   arch/riscv/include/asm/kvm_vcpu_sbi.h      |   1 +
>   arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  29 +++
>   arch/riscv/include/uapi/asm/kvm.h          |   1 +
>   arch/riscv/kvm/Makefile                    |   1 +
>   arch/riscv/kvm/vcpu_sbi.c                  |   4 +
>   arch/riscv/kvm/vcpu_sbi_fwft.c             | 216 +++++++++++++++++++++
>   7 files changed, 256 insertions(+)
>   create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>   create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 4fa02e082142..c3f880763b9a 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -19,6 +19,7 @@
>   #include <asm/kvm_vcpu_fp.h>
>   #include <asm/kvm_vcpu_insn.h>
>   #include <asm/kvm_vcpu_sbi.h>
> +#include <asm/kvm_vcpu_sbi_fwft.h>
>   #include <asm/kvm_vcpu_timer.h>
>   #include <asm/kvm_vcpu_pmu.h>
>   
> @@ -281,6 +282,9 @@ struct kvm_vcpu_arch {
>   	/* Performance monitoring context */
>   	struct kvm_pmu pmu_context;
>   
> +	/* Firmware feature SBI extension context */
> +	struct kvm_sbi_fwft fwft_context;
> +
>   	/* 'static' configurations which are set only once */
>   	struct kvm_vcpu_config cfg;
>   
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index cb68b3a57c8f..ffd03fed0c06 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -98,6 +98,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
>   extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
>   extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
>   extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
>   extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>   extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>   
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
> new file mode 100644
> index 000000000000..9ba841355758
> --- /dev/null
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Rivos Inc.
> + *
> + * Authors:
> + *     Clément Léger <cleger@rivosinc.com>
> + */
> +
> +#ifndef __KVM_VCPU_RISCV_FWFT_H
> +#define __KVM_VCPU_RISCV_FWFT_H
> +
> +#include <asm/sbi.h>
> +
> +struct kvm_sbi_fwft_feature;
> +
> +struct kvm_sbi_fwft_config {
> +	const struct kvm_sbi_fwft_feature *feature;
> +	bool supported;
> +	unsigned long flags;
> +};
> +
> +/* FWFT data structure per vcpu */
> +struct kvm_sbi_fwft {
> +	struct kvm_sbi_fwft_config *configs;
> +};
> +
> +#define vcpu_to_fwft(vcpu) (&(vcpu)->arch.fwft_context)
> +
> +#endif /* !__KVM_VCPU_RISCV_FWFT_H */
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 5f59fd226cc5..5ba77a3d9f6e 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -204,6 +204,7 @@ enum KVM_RISCV_SBI_EXT_ID {
>   	KVM_RISCV_SBI_EXT_DBCN,
>   	KVM_RISCV_SBI_EXT_STA,
>   	KVM_RISCV_SBI_EXT_SUSP,
> +	KVM_RISCV_SBI_EXT_FWFT,
>   	KVM_RISCV_SBI_EXT_MAX,
>   };
>   
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 4e0bba91d284..06e2d52a9b88 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -26,6 +26,7 @@ kvm-y += vcpu_onereg.o
>   kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
>   kvm-y += vcpu_sbi.o
>   kvm-y += vcpu_sbi_base.o
> +kvm-y += vcpu_sbi_fwft.o
>   kvm-y += vcpu_sbi_hsm.o
>   kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o
>   kvm-y += vcpu_sbi_replace.o
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 50be079b5528..0748810c0252 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -78,6 +78,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
>   		.ext_idx = KVM_RISCV_SBI_EXT_STA,
>   		.ext_ptr = &vcpu_sbi_ext_sta,
>   	},
> +	{
> +		.ext_idx = KVM_RISCV_SBI_EXT_FWFT,
> +		.ext_ptr = &vcpu_sbi_ext_fwft,
> +	},
>   	{
>   		.ext_idx = KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>   		.ext_ptr = &vcpu_sbi_ext_experimental,
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> new file mode 100644
> index 000000000000..b0f66c7bf010
> --- /dev/null
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Rivos Inc.
> + *
> + * Authors:
> + *     Clément Léger <cleger@rivosinc.com>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/kvm_host.h>
> +#include <asm/cpufeature.h>
> +#include <asm/sbi.h>
> +#include <asm/kvm_vcpu_sbi.h>
> +#include <asm/kvm_vcpu_sbi_fwft.h>
> +
> +struct kvm_sbi_fwft_feature {
> +	/**
> +	 * @id: Feature ID
> +	 */
> +	enum sbi_fwft_feature_t id;
> +
> +	/**
> +	 * @supported: Check if the feature is supported on the vcpu
> +	 *
> +	 * This callback is optional, if not provided the feature is assumed to
> +	 * be supported
> +	 */
> +	bool (*supported)(struct kvm_vcpu *vcpu);
> +
> +	/**
> +	 * @set: Set the feature value
> +	 *
> +	 * Return SBI_SUCCESS on success or an SBI error (SBI_ERR_*)
> +	 *
> +	 * This callback is mandatory
> +	 */
> +	long (*set)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *conf, unsigned long value);
> +
> +	/**
> +	 * @get: Get the feature current value
> +	 *
> +	 * Return SBI_SUCCESS on success or an SBI error (SBI_ERR_*)
> +	 *
> +	 * This callback is mandatory
> +	 */
> +	long (*get)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *conf, unsigned long *value);
> +};
> +
> +static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] = {
> +	SBI_FWFT_MISALIGNED_EXC_DELEG,
> +	SBI_FWFT_LANDING_PAD,
> +	SBI_FWFT_SHADOW_STACK,
> +	SBI_FWFT_DOUBLE_TRAP,
> +	SBI_FWFT_PTE_AD_HW_UPDATING,
> +	SBI_FWFT_POINTER_MASKING_PMLEN,
> +};
> +
> +static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(kvm_fwft_defined_features); i++) {
> +		if (kvm_fwft_defined_features[i] == feature)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct kvm_sbi_fwft_feature features[] = {
> +};
> +
> +static struct kvm_sbi_fwft_config *
> +kvm_sbi_fwft_get_config(struct kvm_vcpu *vcpu, enum sbi_fwft_feature_t feature)
> +{
> +	int i;
> +	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
> +
> +	for (i = 0; i < ARRAY_SIZE(features); i++) {
> +		if (fwft->configs[i].feature->id == feature)
> +			return &fwft->configs[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu, u32 feature,
> +				struct kvm_sbi_fwft_config **conf)
> +{
> +	struct kvm_sbi_fwft_config *tconf;
> +
> +	tconf = kvm_sbi_fwft_get_config(vcpu, feature);
> +	if (!tconf) {
> +		if (kvm_fwft_is_defined_feature(feature))
> +			return SBI_ERR_NOT_SUPPORTED;
> +
> +		return SBI_ERR_DENIED;
> +	}
> +
> +	if (!tconf->supported)
> +		return SBI_ERR_NOT_SUPPORTED;
> +
> +	*conf = tconf;
> +
> +	return SBI_SUCCESS;
> +}
> +
> +static int kvm_sbi_fwft_set(struct kvm_vcpu *vcpu, u32 feature,
> +			    unsigned long value, unsigned long flags)
> +{
> +	int ret;
> +	struct kvm_sbi_fwft_config *conf;
> +
> +	ret = kvm_fwft_get_feature(vcpu, feature, &conf);
> +	if (ret)
> +		return ret;
> +
> +	if ((flags & ~SBI_FWFT_SET_FLAG_LOCK) != 0)
> +		return SBI_ERR_INVALID_PARAM;
> +
> +	if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
> +		return SBI_ERR_DENIED_LOCKED;
> +
> +	conf->flags = flags;
> +
> +	return conf->feature->set(vcpu, conf, value);
> +}
> +
> +static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long feature,
> +			    unsigned long *value)
> +{
> +	int ret;
> +	struct kvm_sbi_fwft_config *conf;
> +
> +	ret = kvm_fwft_get_feature(vcpu, feature, &conf);
> +	if (ret)
> +		return ret;
> +
> +	return conf->feature->get(vcpu, conf, value);
> +}
> +
> +static int kvm_sbi_ext_fwft_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +				    struct kvm_vcpu_sbi_return *retdata)
> +{
> +	int ret;
> +	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> +	unsigned long funcid = cp->a6;
> +
> +	switch (funcid) {
> +	case SBI_EXT_FWFT_SET:
> +		ret = kvm_sbi_fwft_set(vcpu, cp->a0, cp->a1, cp->a2);
> +		break;
> +	case SBI_EXT_FWFT_GET:
> +		ret = kvm_sbi_fwft_get(vcpu, cp->a0, &retdata->out_val);
> +		break;
> +	default:
> +		ret = SBI_ERR_NOT_SUPPORTED;
> +		break;
> +	}
> +
> +	retdata->err_val = ret;
> +
> +	return 0;
> +}
> +
> +static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
> +	const struct kvm_sbi_fwft_feature *feature;
> +	struct kvm_sbi_fwft_config *conf;
> +	int i;
> +
> +	fwft->configs = kcalloc(ARRAY_SIZE(features), sizeof(struct kvm_sbi_fwft_config),
> +				GFP_KERNEL);
> +	if (!fwft->configs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(features); i++) {
> +		feature = &features[i];
> +		conf = &fwft->configs[i];
> +		if (feature->supported)
> +			conf->supported = feature->supported(vcpu);
> +		else
> +			conf->supported = true;
> +
> +		conf->feature = feature;
> +	}
> +
> +	return 0;
> +}
> +
> +static void kvm_sbi_ext_fwft_deinit(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
> +
> +	kfree(fwft->configs);
> +}
> +
> +static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
> +{
> +	int i;
> +	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
> +
> +	for (i = 0; i < ARRAY_SIZE(features); i++)
> +		fwft->configs[i].flags = 0;
> +}
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft = {
> +	.extid_start = SBI_EXT_FWFT,
> +	.extid_end = SBI_EXT_FWFT,
> +	.handler = kvm_sbi_ext_fwft_handler,
> +	.init = kvm_sbi_ext_fwft_init,
> +	.deinit = kvm_sbi_ext_fwft_deinit,
> +	.reset = kvm_sbi_ext_fwft_reset,
> +};

LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>

