Return-Path: <linux-kselftest+bounces-7275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC6899C71
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E03A1C208EC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03A16C84C;
	Fri,  5 Apr 2024 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aBtPzcQ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9A16C847
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319037; cv=none; b=geBBaFbKdnp9t9uB8Lk8elukzmZTUUx+Pntc2Vh4EIKOV7uJxJl93Y6EiQ4tgW1GJGJ3nGNiQL8N2zk7bZzDR9sxkSBF/EIBpqq80pdiiXh1qjZmp6R8tuO8kBEZSLL93WLLDATIKzAjyIrZMx95RdgM6G4QuRxN5Osae6n6TF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319037; c=relaxed/simple;
	bh=3Z9ZBDg8byD1z+Fk/GQuEQBsa+swzZyx2Lz/7j+AnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT3/85mGvUDxtOGCEmsaGjgKrxO7BSJ8soakXGUjdfzVlYBee261MOTuSGcgd6pv5LeISGDA9oB6AoMO7Vx6Cd6c64pi2TqCtEZVHI/9SXcjnx2qZXnSgZTZL0ACBS+hMhukW0wuDcqtB8Z9i6sBcdeqCifAQxay1dL4tYHWrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aBtPzcQ5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d485886545so37279011fa.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712319034; x=1712923834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=en++ou90w+echMP7REhkEA6fNREBrRLo/x86xMpLdGE=;
        b=aBtPzcQ5nDiI6mcGK4NEfJafUA4rZ/Gichz9jqKmZ7pM+gYE416N6xVjIHwTm/uflD
         tYXbSRgCA4b+SmB5wo6BHUqVYfA8uKhzzLKZf7yiLr4r74QVeHzmvKlMxgSHvAglTFOy
         VF+Tj7l5seCHU47Kp6v5NJAQShIhZV3sHvU9u1LMYbF3a39JxtRWfuBjLFEQYHOyJZtp
         LwWSPqzP/LUvgibt6QK1aT9xYAnnF8M8fT1/UFrcYOEZ/I744M1BRJp9/Jhi9PkgYLTo
         eM7iHd3LfI4p36JPr9vkp5DYddmBXsGpGra0TJN7JBMdwsXCLkMc/XcPtiJKAOexOkVW
         kZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319034; x=1712923834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en++ou90w+echMP7REhkEA6fNREBrRLo/x86xMpLdGE=;
        b=lDI0L/2nkdWQaYnHf0WFdncQyrigwzdSsTPXYHxDn7UHkfPU1mHE5ur+6+ZuKeCnbk
         wWJljWaspEjo9QoiHqVMI7YtcVL9QYUd/mZO3tlGEohu2i/k4m3jSr//8O9I6vGYcfOT
         O1PI2RgnJtPUJy93/UfW3wJbeJg7w7Qn7imBS1kiZ0g1j84YwX4+f/FLePQB0ml8d6D9
         VkIiFizOv9TDNiffQbPMq3ZfA4OnQiQXHie5gCjOziPi9U6hOkaYc6ttczqzECYLTp41
         XcRxu1WMKEGxtT/SsbfgaSHHJa/Xsg6kc04moYYLAEGGRr+8OVZzbUJFqtoLlfPUsw9g
         FtBw==
X-Forwarded-Encrypted: i=1; AJvYcCVb9ZmnlhJX0IF7R7AttqKVwMhH1GRyqB1Uk4nQ72X/eSCiGqG79QWINF36f553G6j9dGenv2dvcLJBP6RAhoAa6hDCCISYsDOqvjYGi/af
X-Gm-Message-State: AOJu0YzwohoOM+GxnGZt8uX2dG90MiTRsfG2aQDUpZ1MbM43JZ4Bx4Ea
	wffsUov6jWeax9JutWCELkwcbWnR4dKAxcmffpe22SFov3XBf0+aG7d81L9SmGc=
X-Google-Smtp-Source: AGHT+IEzRjdEz2L9eamcBiZkSH+r98MqC6ceGdW87UNyauZWh7IXa+iMGl1AT9EDPHKQSSfTKTG4Sg==
X-Received: by 2002:a05:651c:49d:b0:2d6:f793:3434 with SMTP id s29-20020a05651c049d00b002d6f7933434mr1296826ljc.2.1712319034264;
        Fri, 05 Apr 2024 05:10:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j31-20020a5d6e5f000000b0033fc06f2d84sm1872775wrz.109.2024.04.05.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:10:33 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:10:32 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 14/22] RISC-V: KVM: Support 64 bit firmware counters
 on RV32
Message-ID: <20240405-6ef7f32d45deb5edd2d54ecb@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-15-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-15-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:43AM -0700, Atish Patra wrote:
> The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
> counters for RV32 based systems.
> 
> Add infrastructure to support that.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |  4 ++-
>  arch/riscv/kvm/vcpu_pmu.c             | 44 ++++++++++++++++++++++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         |  6 ++++
>  3 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> index 257f17641e00..55861b5d3382 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> @@ -20,7 +20,7 @@ static_assert(RISCV_KVM_MAX_COUNTERS <= 64);
>  
>  struct kvm_fw_event {
>  	/* Current value of the event */
> -	unsigned long value;
> +	u64 value;
>  
>  	/* Event monitoring status */
>  	bool started;
> @@ -91,6 +91,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  				     struct kvm_vcpu_sbi_return *retdata);
>  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>  				struct kvm_vcpu_sbi_return *retdata);
> +int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
> +				      struct kvm_vcpu_sbi_return *retdata);
>  void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
>  int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
>  				      unsigned long saddr_high, unsigned long flags,
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 9fedf9dc498b..ff326152eeff 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -197,6 +197,36 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, unsigned long eidx,
>  	return kvm_pmu_get_programmable_pmc_index(pmu, eidx, cbase, cmask);
>  }
>  
> +static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
> +			      unsigned long *out_val)
> +{
> +	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> +	struct kvm_pmc *pmc;
> +	int fevent_code;
> +
> +	if (!IS_ENABLED(CONFIG_32BIT)) {
> +		pr_warn("%s: should be invoked for only RV32\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (cidx >= kvm_pmu_num_counters(kvpmu) || cidx == 1) {
> +		pr_warn("Invalid counter id [%ld]during read\n", cidx);
> +		return -EINVAL;
> +	}
> +
> +	pmc = &kvpmu->pmc[cidx];
> +
> +	if (pmc->cinfo.type != SBI_PMU_CTR_TYPE_FW)
> +		return -EINVAL;
> +
> +	fevent_code = get_event_code(pmc->event_idx);
> +	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
> +
> +	*out_val = pmc->counter_val >> 32;
> +
> +	return 0;
> +}
> +
>  static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>  			unsigned long *out_val)
>  {
> @@ -705,6 +735,18 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
>  	return 0;
>  }
>  
> +int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
> +				      struct kvm_vcpu_sbi_return *retdata)
> +{
> +	int ret;
> +
> +	ret = pmu_fw_ctr_read_hi(vcpu, cidx, &retdata->out_val);
> +	if (ret == -EINVAL)
> +		retdata->err_val = SBI_ERR_INVALID_PARAM;
> +
> +	return 0;
> +}
> +
>  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>  				struct kvm_vcpu_sbi_return *retdata)
>  {
> @@ -778,7 +820,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
>  			pmc->cinfo.csr = CSR_CYCLE + i;
>  		} else {
>  			pmc->cinfo.type = SBI_PMU_CTR_TYPE_FW;
> -			pmc->cinfo.width = BITS_PER_LONG - 1;
> +			pmc->cinfo.width = 63;
>  		}
>  	}
>  
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
> index d3e7625fb2d2..cf111de51bdb 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -64,6 +64,12 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	case SBI_EXT_PMU_COUNTER_FW_READ:
>  		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
>  		break;
> +	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			ret = kvm_riscv_vcpu_pmu_fw_ctr_read_hi(vcpu, cp->a0, retdata);
> +		else
> +			retdata->out_val = 0;
> +		break;
>  	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
>  		ret = kvm_riscv_vcpu_pmu_snapshot_set_shmem(vcpu, cp->a0, cp->a1, cp->a2, retdata);
>  		break;
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

