Return-Path: <linux-kselftest+bounces-5783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CD86F016
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 11:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31341C210EA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3376566A;
	Sat,  2 Mar 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LJp/2Ft2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692A1C2E
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Mar 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709376727; cv=none; b=EHDvg8JhMlbNiKQataLWZwVhGJAL9nufWVpa5gjTFRTfagZQTSkgUaERRljG67+r5fGG6CVe8yURA2AilhDV7bu0BE1vcwNy5CjWMFjphloS5YuPXMSbUTIbmNKzSuZjrOl15zWLWBBt4wV86QLCAHs+R0r73gYo8s31Je5p0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709376727; c=relaxed/simple;
	bh=XBSHM22vHMNsyJdf8IF+rdpTefstfNWgsuzTwp/4C0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q05hjYdFnRXS37SE3p25dU9CceaskrMsHcg4LKOMYL04zo+rzYRKBr/r3sdUg2/4eCnu045TGL/tem01f8uCgKVeYQHyp98CXgFXGG3yQxF14cvEJnHiwCYgqT7otraGNlMGrz7eEe6oMyxt3gFEcIhDk1BhubEBcQ04ZX1RJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LJp/2Ft2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44e69f2088so25465766b.3
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Mar 2024 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709376724; x=1709981524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EpHJ3vXoVYx3z3WiPBm0nq7L3LHn09T6f5KhziK9jw=;
        b=LJp/2Ft2wrjc6pY7V8n0DwCDVqTBg6ZL5hln7mvzDB/xNaSBFO3xtmqvdyPlyY2B1X
         CZk0UhIL4BaCpILz1PGdsFC4Uogn0LwDaLnED5uy2qsft0tlMNwmoeb+Edy82kGORv3A
         exx9Hc/Aqz6sIqXyxc+zqAaPZY1KSjqZzjOaSUkzvrm7BSWLtTSHYshY2MDGtxjZv8/s
         n1SOr/PEzH1WIPkKa2SBIeh3Gkz4CtiUF1qPRll+t40nYYC5M5tJYU2JhSxR+cJwhSTz
         ueBLuFyRy2tZcWKd+6GD66g6DnegorWnrDw/N6AN1dhuP3/HdYmDASwtOFweRv2MrtGm
         pDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709376724; x=1709981524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EpHJ3vXoVYx3z3WiPBm0nq7L3LHn09T6f5KhziK9jw=;
        b=CV192vJBkn+il/hg3HE7NGwx30BF81vP/SACQraUgUrym48VOdfTtrIY/P+HpIj7Rl
         znveMDCoO3zD5lZVb9OAf8FuUe9ccGsZSFp48hIM698QlKLL+jv45AeiSkkNbcSMzs8d
         QQMXYorodVY3liDThyEBt2FUx8Sx/LqxhOr1JPxYuTwyRVCDkrXdpxMP32X3YryYD7TL
         sbwuu9nAUrOFOJltr+t0q87E+Tgz+xe/8TK/nSnwZzWbnAMFpb4wo9CAopuoQ/PUfxiV
         Dq76q8g8u6vH8ZGPH8aW/V1kWGYU7S/T/1h+9rHsErvZGJDmeMb6s9TFqLKuwCy0OW1Y
         Qx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdXbqn50XuMO0E9o6GjUAuohqAvEQaO2l3FOmfm6WSRfiuGYyu0Jgl97DrfzYE29hylI8Kvhl8dJspCGs9pmi9AW/LheQfEobyPfqXjinM
X-Gm-Message-State: AOJu0YzzcSYDPpnn88Kyx8vfpw4WbDV85S3BCJG2vgnAbl+Lia/olxYi
	DV1dYQlHAjm+RwAAL760HO1WR1q0puV/JJI3OnecUoPYWLevx6MO3MKaCCOzFPo=
X-Google-Smtp-Source: AGHT+IHCev5tUtcI53kDoYHkl5lWdh3t/37ee1Ru+I9oZgloBvL0ICNc3Zq0ypsxSf+vVr5Y6SFE0Q==
X-Received: by 2002:a17:906:e211:b0:a3e:3a1d:f4b5 with SMTP id gf17-20020a170906e21100b00a3e3a1df4b5mr3140237ejb.65.1709376723783;
        Sat, 02 Mar 2024 02:52:03 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709063c1100b00a42da3b6518sm2609577ejg.18.2024.03.02.02.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 02:52:03 -0800 (PST)
Date: Sat, 2 Mar 2024 11:52:02 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 10/15] RISC-V: KVM: Support 64 bit firmware counters
 on RV32
Message-ID: <20240302-7679c8f67984ccae734926ba@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-11-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229010130.1380926-11-atishp@rivosinc.com>

On Wed, Feb 28, 2024 at 05:01:25PM -0800, Atish Patra wrote:
> The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
> counters for RV32 based systems.
> 
> Add infrastructure to support that.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |  4 ++-
>  arch/riscv/kvm/vcpu_pmu.c             | 37 ++++++++++++++++++++++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         |  6 +++++
>  3 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> index 8cb21a4f862c..e0ad27dea46c 100644
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
>  int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned long saddr_low,
>  				      unsigned long saddr_high, unsigned long flags,
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index a02f7b981005..469bb430cf97 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -196,6 +196,29 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, unsigned long eidx,
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
> +	if (!IS_ENABLED(CONFIG_32BIT))

Let's remove the CONFIG_32BIT check in kvm_sbi_ext_pmu_handler() and then
set *out_val to zero here and return success. Either that, or we should
WARN or something here since it's a KVM bug to get here with
!CONFIG_32BIT.

> +		return -EINVAL;
> +
> +	pmc = &kvpmu->pmc[cidx];

Uh oh! We're missing range validation of cidx! And I see we're missing it
in pmu_ctr_read() too. We need the same check we have in
kvm_riscv_vcpu_pmu_ctr_info(). I think the other SBI functions are OK,
but it's worth a triple check.

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
> @@ -702,6 +725,18 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
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

I see this follows the pattern we have with kvm_riscv_vcpu_pmu_ctr_read
and pmu_ctr_read, but I wonder if we really need the
kvm_riscv_vcpu_pmu_ctr_read() and kvm_riscv_vcpu_pmu_fw_ctr_read_hi()
wrapper functions?

> +}
> +
>  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>  				struct kvm_vcpu_sbi_return *retdata)
>  {
> @@ -775,7 +810,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
>  			pmc->cinfo.csr = CSR_CYCLE + i;
>  		} else {
>  			pmc->cinfo.type = SBI_PMU_CTR_TYPE_FW;
> -			pmc->cinfo.width = BITS_PER_LONG - 1;
> +			pmc->cinfo.width = 63;
>  		}
>  	}
>  
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
> index 9f61136e4bb1..58a0e5587e2a 100644
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
>  		ret = kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, cp->a1, cp->a2, retdata);
>  		break;
> -- 
> 2.34.1
> 

Thanks,
drew

