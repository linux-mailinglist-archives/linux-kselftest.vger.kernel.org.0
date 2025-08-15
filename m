Return-Path: <linux-kselftest+bounces-39123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E2DB2877F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6116AE0E60
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6220459A;
	Fri, 15 Aug 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K5ovvOPE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB828635B
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291846; cv=none; b=DJv9zcElbetasO7RmPqRwqtX65GSdRyZIzXU2l0eZatrQ9p6jyeiPf4GxcH7Z7Y+Rtq3CKZIQECv2x22erzRrqyoa7U7HWa+E4KFvfBwxgY8dLpTTGwdavIeHrmUKwrbMXZQAFaUG1/a/5l6+bOr/ajqhW1GNDk38SjB6p0cA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291846; c=relaxed/simple;
	bh=6+p+fjCuAoQ5IAm8jpXHZ66S5TM6H6hQ6gYaG/bJ6jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzQ+gZc74o49gn3pSGnZPckfLxFLK6lyl8S9PyZNehctbnpIC3xn4UB3rA6vRh3UnoACA0bHY62G4JmDLfCTyWC7lJqh3vRFCa8WNVQxiMaWHXUzA70ID68Bo+fRRMxtNH3omKARDqqe2ZH7TYb9f162Y7AU6xqEa8r+wvP8/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K5ovvOPE; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e57376f5abso18722855ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755291843; x=1755896643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ft04JZ672lT2q0D5QFWz6789EtIMwIQ1qPNZYM3WBFM=;
        b=K5ovvOPEMkcmtGWvE+LX45tKyy0xLRuX6zgsq9X0HxDZf8FT8AvhQg8HgjU2JL3EQx
         DflT/12dsYhdrzNhWgJ5ah76NzQfVQjyOfGgBRmT1gh9eOOmnSZUSaLhMPISCEGNTbhC
         0/C+nDIimHRXApZMvukOa5xRQicSpWZyUFk8YyBvXfXSWVDKMr5+pr6io1veytW9Cka5
         qjeTY8ac5sXRBj3mfih1jpM9vcuOwUfgXTByVfJ4zSGXjtcJgY1KdUH2UDqbMT7MkD6D
         IBQEB/Kaj/xVMM52s1TiqwnHPRUO2c27wtNYMOjRi7wvZwNbJXOW3yQkTFvPJPUYB+ja
         4akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755291843; x=1755896643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft04JZ672lT2q0D5QFWz6789EtIMwIQ1qPNZYM3WBFM=;
        b=m7Xz9mwkcivdW5w40B5jQuKo94cJCdZvWYFulaggqM8+4P8g1lFjf+RczM4BkzU0SH
         e/lMpS7K7LHbtluyXw/5nb9lAsbke/oE29erKM4FKM0JdPUnvN4TEWgrsfGDcDNpT6dZ
         uSN59AsJpzrjQoRDQJq/DyuxoEPvj4BoxSNe20HlG6HbHkNnlDW0mtbHBupLBnykW3M2
         ubw/FSG3W8qg75Tx5LM/VWeRJeOzAb4nM6lP7CG6UfnBrmBiJLMt8hB2rmERzsV2eSmp
         X1EP+xUV9amX/qvOxaITy28Ljo7XGHEoDHcy6nNMBEGZ8Ek6BEDkfiqxMAQNS9P2y5pq
         xHjA==
X-Forwarded-Encrypted: i=1; AJvYcCWmn28bLYYDObmhz2nc+WI0nys/FETddh2gUYQQh3WtTOLeSQP2IePttuMipVWQaPdlZ4IJM6BuvMS/NA2u6d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDas+cLXlCh6+gc7V5vPn3mIa0wjNuC7uRP+3Xr5kqSOnPW1MU
	obVQmEhHtRD8OyJZczcKg4pY3AhswNtgM3iaLAA44KX/uXJ+6bnNcu1A1DTKtTHEt5g=
X-Gm-Gg: ASbGncvh2F5CKkKmhNeuVn9pN2YyOXc0L9EsrSPq4RlaEmNDYEa11K8QNUfDxxkot8O
	E7Ueu/3t9pJJ56Aih0+bnSRq5RUn7i4HBE7bBuNc6UYoRzRXr6GDMu48ovciEbwlB6YCD5Sk8eq
	FEAEdryJ+mLCkgbZzjTFkFu2NxorIKf9c8BsBmPQpwbf0NDljQcaoPsJw/0oM98Vi2dh3OZXbP6
	YBAaQuKGMkBleZehFcwBueQO1zanLXu9Q7SWGeZFyrX8vDvSvsx4f7ozspSK/ZChRHV8kOmOtQ3
	UquWj/fKx3HnaZ3DQKTqgszFXoF/4Mbz5tCYbcwZue0W3XmPKVtHWcSKW/XjWFGRW+bu+kezGmO
	a7boXMyJPeF2WnCswLxtYNWFr
X-Google-Smtp-Source: AGHT+IEZ228tEu96gQYjWXKJgevodnNBi1s4R3eESGEOgX3ctS1gUzzAVoE7y2cbjS0nf97wxrlKjw==
X-Received: by 2002:a05:6e02:2583:b0:3e5:66a8:3ebf with SMTP id e9e14a558f8ab-3e57e825485mr67051065ab.5.1755291843294;
        Fri, 15 Aug 2025 14:04:03 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949a0167sm643861173.53.2025.08.15.14.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:04:02 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:04:02 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/6] RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI
 implementation
Message-ID: <20250815-ba0f0a816fc5281383a2b988@orel>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <20250814155548.457172-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814155548.457172-5-apatel@ventanamicro.com>

On Thu, Aug 14, 2025 at 09:25:46PM +0530, Anup Patel wrote:
> The ONE_REG handling of SBI extension enable/disable registers and
> SBI extension state registers is already under SBI implementation.
> On similar lines, let's move copy_sbi_ext_reg_indices() under SBI
> implementation.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  2 +-
>  arch/riscv/kvm/vcpu_onereg.c          | 29 ++-------------------------
>  arch/riscv/kvm/vcpu_sbi.c             | 27 ++++++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index 144c3f6d5eb9..212c31629bc8 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -78,6 +78,7 @@ void kvm_riscv_vcpu_sbi_request_reset(struct kvm_vcpu *vcpu,
>  				      unsigned long pc, unsigned long a1);
>  void kvm_riscv_vcpu_sbi_load_reset_state(struct kvm_vcpu *vcpu);
>  int kvm_riscv_vcpu_sbi_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
> +int kvm_riscv_vcpu_reg_indices_sbi_ext(struct kvm_vcpu *vcpu, u64 __user *uindices);
>  int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
>  				   const struct kvm_one_reg *reg);
>  int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
> @@ -87,7 +88,6 @@ int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *
>  int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>  				struct kvm_vcpu *vcpu, unsigned long extid);
> -bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
>  int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 5843b0519224..0894ab517525 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -1060,34 +1060,9 @@ static inline unsigned long num_isa_ext_regs(const struct kvm_vcpu *vcpu)
>  	return copy_isa_ext_reg_indices(vcpu, NULL);
>  }
>  
> -static int copy_sbi_ext_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> -{
> -	unsigned int n = 0;
> -
> -	for (int i = 0; i < KVM_RISCV_SBI_EXT_MAX; i++) {
> -		u64 size = IS_ENABLED(CONFIG_32BIT) ?
> -			   KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
> -		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_SBI_EXT |
> -			  KVM_REG_RISCV_SBI_SINGLE | i;
> -
> -		if (!riscv_vcpu_supports_sbi_ext(vcpu, i))
> -			continue;
> -
> -		if (uindices) {
> -			if (put_user(reg, uindices))
> -				return -EFAULT;
> -			uindices++;
> -		}
> -
> -		n++;
> -	}
> -
> -	return n;
> -}
> -
>  static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
>  {
> -	return copy_sbi_ext_reg_indices(vcpu, NULL);
> +	return kvm_riscv_vcpu_reg_indices_sbi_ext(vcpu, NULL);
>  }
>  
>  static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
> @@ -1215,7 +1190,7 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
>  		return ret;
>  	uindices += ret;
>  
> -	ret = copy_sbi_ext_reg_indices(vcpu, uindices);
> +	ret = kvm_riscv_vcpu_reg_indices_sbi_ext(vcpu, uindices);
>  	if (ret < 0)
>  		return ret;
>  	uindices += ret;
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 8b3c393e0c83..19e0e3d7b598 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -110,7 +110,7 @@ riscv_vcpu_get_sbi_ext(struct kvm_vcpu *vcpu, unsigned long idx)
>  	return sext;
>  }
>  
> -bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx)
> +static bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx)
>  {
>  	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
>  	const struct kvm_riscv_sbi_extension_entry *sext;
> @@ -288,6 +288,31 @@ static int riscv_vcpu_get_sbi_ext_multi(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
>  
> +int kvm_riscv_vcpu_reg_indices_sbi_ext(struct kvm_vcpu *vcpu, u64 __user *uindices)
> +{
> +	unsigned int n = 0;
> +
> +	for (int i = 0; i < KVM_RISCV_SBI_EXT_MAX; i++) {
> +		u64 size = IS_ENABLED(CONFIG_32BIT) ?
> +			   KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
> +		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_SBI_EXT |
> +			  KVM_REG_RISCV_SBI_SINGLE | i;
> +
> +		if (!riscv_vcpu_supports_sbi_ext(vcpu, i))
> +			continue;
> +
> +		if (uindices) {
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +
> +		n++;
> +	}
> +
> +	return n;
> +}
> +
>  int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
>  				   const struct kvm_one_reg *reg)
>  {
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

