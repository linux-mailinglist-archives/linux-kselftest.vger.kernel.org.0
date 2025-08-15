Return-Path: <linux-kselftest+bounces-39122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210EAB28778
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBADDAE0D85
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12124887E;
	Fri, 15 Aug 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Dn5doeXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB228635B
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291642; cv=none; b=ftZcCVduoe+Ox0iyM0V5LbzVgqwOe6CvTkkqXl6yNSdfz1fUSafusXnDoJoEqlTvFB9MgnEb5vSMMmT/NhEEfFQRA1+SJNOPbJm1toP3v4U0J6hgjS2UlEgJ2aHKbMoaPBG9SUaiefOvvOS9V/dDX4lJ0RlnsywyEHKjL+vEr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291642; c=relaxed/simple;
	bh=k7+O/2w4uLnBbp/ovEtpzLToKsErgAZHvM5jUsoyHuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5yaL/B4Fex+o/wWscUcCa+qhVZgboZOCPtwCIBFoEE+W6e0a8bgjzLvUtFhxOAMeVANZXKAgitZib9tHAqm7ANjMO0aln+WvmpQVQPs6HPU16oLODo8tJhSaBgy2wdJF4s2OVnwfnL9KcS4u/HPWvOmCmMVuEg/BbwL0uD9SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Dn5doeXJ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e570045e05so17844245ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755291638; x=1755896438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0oY/0eKfeCLhES28zKC/33PzkgcGvkJ90ZgWYAFPNE=;
        b=Dn5doeXJsD28EqOu5QxntEMJ7/5qF4gxXwnSoQEItvxjIL3BzeeR7lB1D8ja5lUdvx
         FV1Co1vrJtKhyFhydZx0mkm/4QSIivCyz9+ux8gtnfhqfZ7Fe6qtR6n76jyTDm85KEH1
         hpm6gXMdYOFhMTr31w7XjAW5Q2wEteMUop2fMPPoAbn7mzLyiFU9Rv+y0Ae7BV09tmpG
         xcxeKgd5fGZQDG4H51oth1Rvi1yoO5y/QunRYjngywfewsaDYvjRG+01xkj8zGiOdvuf
         gK+OEXk8Z/mZaEsthWf95++PcxxYHV7ALnYuX9ei+rCn8ahxG2CbGrF1vkSke/y/Veor
         mHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755291638; x=1755896438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0oY/0eKfeCLhES28zKC/33PzkgcGvkJ90ZgWYAFPNE=;
        b=izfE0tM/Ni/mkB1bNQLFeAmBKkC7lvsjJjHUZPrRrZwm/dHWT77pHDkbcjFK9LAPZA
         MkiLaNhMDSmOt6PJ7xi1Rmi2vw9BTeYP8QFpgN4xKN+kCcxWpQet8VcYEjOTRx5sbN4A
         ncEgcDEiNBLOGLpPzDCNwcqDmQ43HMDgjJPIvyDr3rsyjiDiP0I+aWORsiSHzaWvPxb/
         6BUK7RHcIHH6Qqrhy6X8TEgYhAWVGoro4EviA5wwb7r8oUr3gKl2uoZkG8nA417vu0gm
         3v6YBTH36C0NFcKJbtUBHVZvGCr9qf/UZG/2uCWJTH24RqmBIk2ipPBXGOP9A0Q0uJSv
         ZPgw==
X-Forwarded-Encrypted: i=1; AJvYcCVbZmRok5OXFm7OAI53I7RWns+kNrPT9pz7OPAo6GiLXxObmJ9/uxrBLTCu/XjdVv9m9HQ+U6kTmFKcAVQRIbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUQiAx2iydFk4ez/HCWKYdR4v3OeegQ1vbgcRSFatT7pch5np
	9rfIsDn5aCDtwB35+nxwc91GKaJvGPJ9wwqxVBGjWuHbMHZToh/Te+UQXgcqVQD0O3E=
X-Gm-Gg: ASbGncvqhCPOnnYsyTVMvm/sgufm+++BXCwCUROP24jcQ6EBL0ejplad5unKcbdx7S2
	vzNOeOaxGVWYZWFR5sQ5lZVPWeDA6LMd3hOv3VjgMF3/jPqE5Tx9eYOWFhbQehd8Lf+8C1L++1f
	z5BwRvT5aH+KSnYMzQbYQkXYy4h03Devg4NphL9up/3cdwAQBQO5tca32UAXmXj0mzxen4kQW7d
	lIEEb329+a5mZRYHIjPbEkfyFFl1BAGa/EqRK7f0JTD8axHsyXbLUsWJng3nOAHlfWgVhrTr9kh
	SBAvV8w+XUtIDNVq19NdQl5eFLdRNFIV8DMZhAJ1dc9QfTWr2beRo0DpJGmTM+KY0NNu3gI6de8
	DTwwQCeW56htLKAI3OArUmWNs
X-Google-Smtp-Source: AGHT+IGt3yd4/7kkwlBNcbkqJ/RCR15gXtigPTEqvc5rOWbxgq9Aiogz1JM+m2KoAxw4fTFhb648xQ==
X-Received: by 2002:a05:6e02:3c83:b0:3e5:7e56:db43 with SMTP id e9e14a558f8ab-3e57e809ed6mr61873795ab.4.1755291635821;
        Fri, 15 Aug 2025 14:00:35 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c947b4150sm637811173.29.2025.08.15.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:00:35 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:00:33 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] RISC-V: KVM: Introduce optional ONE_REG callbacks
 for SBI extensions
Message-ID: <20250815-4414a697ab004422374f4d56@orel>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <20250814155548.457172-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814155548.457172-4-apatel@ventanamicro.com>

On Thu, Aug 14, 2025 at 09:25:45PM +0530, Anup Patel wrote:
> SBI extensions can have per-VCPU state which needs to be saved/restored
> through ONE_REG interface for Guest/VM migration. Introduce optional
> ONE_REG callbacks for SBI extensions so that ONE_REG implementation
> for an SBI extenion is part of the extension sources.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  21 ++--
>  arch/riscv/kvm/vcpu_onereg.c          |  31 +-----
>  arch/riscv/kvm/vcpu_sbi.c             | 145 ++++++++++++++++++++++----
>  arch/riscv/kvm/vcpu_sbi_sta.c         |  64 ++++++++----
>  4 files changed, 178 insertions(+), 83 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index 766031e80960..144c3f6d5eb9 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -59,6 +59,15 @@ struct kvm_vcpu_sbi_extension {
>  	void (*deinit)(struct kvm_vcpu *vcpu);
>  
>  	void (*reset)(struct kvm_vcpu *vcpu);
> +
> +	bool have_state;
> +	unsigned long state_reg_subtype;
> +	unsigned long (*get_state_reg_count)(struct kvm_vcpu *vcpu);

I think we can drop 'have_state'. When 'get_state_reg_count' is NULL, then
the state reg count must be zero (i.e. have_state == false).

> +	int (*get_state_reg_id)(struct kvm_vcpu *vcpu, int index, u64 *reg_id);
> +	int (*get_state_reg)(struct kvm_vcpu *vcpu, unsigned long reg_num,
> +			     unsigned long reg_size, void *reg_val);
> +	int (*set_state_reg)(struct kvm_vcpu *vcpu, unsigned long reg_num,
> +			     unsigned long reg_size, const void *reg_val);
>  };
>  
>  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
> @@ -73,10 +82,9 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
>  				   const struct kvm_one_reg *reg);
>  int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
>  				   const struct kvm_one_reg *reg);
> -int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> -			       const struct kvm_one_reg *reg);
> -int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> -			       const struct kvm_one_reg *reg);
> +int kvm_riscv_vcpu_reg_indices_sbi(struct kvm_vcpu *vcpu, u64 __user *uindices);
> +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>  				struct kvm_vcpu *vcpu, unsigned long extid);
>  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
> @@ -85,11 +93,6 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu);
>  
> -int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
> -				   unsigned long *reg_val);
> -int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
> -				   unsigned long reg_val);
> -
>  #ifdef CONFIG_RISCV_SBI_V01
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01;
>  #endif
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index b77748a56a59..5843b0519224 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -1090,36 +1090,9 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
>  	return copy_sbi_ext_reg_indices(vcpu, NULL);
>  }
>  
> -static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> -{
> -	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
> -	int total = 0;
> -
> -	if (scontext->ext_status[KVM_RISCV_SBI_EXT_STA] == KVM_RISCV_SBI_EXT_STATUS_ENABLED) {
> -		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
> -		int n = sizeof(struct kvm_riscv_sbi_sta) / sizeof(unsigned long);
> -
> -		for (int i = 0; i < n; i++) {
> -			u64 reg = KVM_REG_RISCV | size |
> -				  KVM_REG_RISCV_SBI_STATE |
> -				  KVM_REG_RISCV_SBI_STA | i;
> -
> -			if (uindices) {
> -				if (put_user(reg, uindices))
> -					return -EFAULT;
> -				uindices++;
> -			}
> -		}
> -
> -		total += n;
> -	}
> -
> -	return total;
> -}
> -
>  static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
>  {
> -	return copy_sbi_reg_indices(vcpu, NULL);
> +	return kvm_riscv_vcpu_reg_indices_sbi(vcpu, NULL);
>  }
>  
>  static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
> @@ -1247,7 +1220,7 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
>  		return ret;
>  	uindices += ret;
>  
> -	ret = copy_sbi_reg_indices(vcpu, uindices);
> +	ret = kvm_riscv_vcpu_reg_indices_sbi(vcpu, uindices);
>  	if (ret < 0)
>  		return ret;
>  	uindices += ret;
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 01a93f4fdb16..8b3c393e0c83 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -364,64 +364,163 @@ int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
>  
> -int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
> -			       const struct kvm_one_reg *reg)
> +int kvm_riscv_vcpu_reg_indices_sbi(struct kvm_vcpu *vcpu, u64 __user *uindices)
> +{
> +	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
> +	const struct kvm_riscv_sbi_extension_entry *entry;
> +	const struct kvm_vcpu_sbi_extension *ext;
> +	unsigned long state_reg_count;
> +	int i, j, rc, count = 0;
> +	u64 reg;
> +
> +	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
> +		entry = &sbi_ext[i];
> +		ext = entry->ext_ptr;
> +
> +		if (!ext->have_state ||
> +		    scontext->ext_status[entry->ext_idx] != KVM_RISCV_SBI_EXT_STATUS_ENABLED)
> +			continue;
> +
> +		state_reg_count = ext->get_state_reg_count(vcpu);
> +		if (!uindices)
> +			goto skip_put_user;
> +
> +		for (j = 0; j < state_reg_count; j++) {
> +			if (ext->get_state_reg_id) {
> +				rc = ext->get_state_reg_id(vcpu, j, &reg);
> +				if (rc)
> +					return rc;
> +			} else {
> +				reg = KVM_REG_RISCV |
> +				      (IS_ENABLED(CONFIG_32BIT) ?
> +				       KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64) |
> +				      KVM_REG_RISCV_SBI_STATE |
> +				      ext->state_reg_subtype | j;
> +			}
> +
> +			if (put_user(reg, uindices))
> +				return -EFAULT;
> +			uindices++;
> +		}
> +
> +skip_put_user:
> +		count += state_reg_count;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext_withstate(struct kvm_vcpu *vcpu,
> +									    unsigned long subtype)
> +{
> +	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
> +	const struct kvm_riscv_sbi_extension_entry *entry;
> +	const struct kvm_vcpu_sbi_extension *ext;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
> +		entry = &sbi_ext[i];
> +		ext = entry->ext_ptr;
> +
> +		if (ext->have_state &&
> +		    ext->state_reg_subtype == subtype &&
> +		    scontext->ext_status[entry->ext_idx] == KVM_RISCV_SBI_EXT_STATUS_ENABLED)
> +			return ext;
> +	}
> +
> +	return NULL;
> +}
> +
> +int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>  	unsigned long __user *uaddr =
>  			(unsigned long __user *)(unsigned long)reg->addr;
>  	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
>  					    KVM_REG_SIZE_MASK |
>  					    KVM_REG_RISCV_SBI_STATE);
> -	unsigned long reg_subtype, reg_val;
> -
> -	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
> +	const struct kvm_vcpu_sbi_extension *ext;
> +	unsigned long reg_subtype;
> +	void *reg_val;
> +	u64 data64;
> +	u32 data32;
> +	u16 data16;
> +	u8 data8;
> +
> +	switch (KVM_REG_SIZE(reg->id)) {
> +	case 1:
> +		reg_val = &data8;
> +		break;
> +	case 2:
> +		reg_val = &data16;
> +		break;
> +	case 4:
> +		reg_val = &data32;
> +		break;
> +	case 8:
> +		reg_val = &data64;
> +		break;
> +	default:
>  		return -EINVAL;
> +	};

superfluous ';'

>  
> -	if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
> +	if (copy_from_user(reg_val, uaddr, KVM_REG_SIZE(reg->id)))
>  		return -EFAULT;
>  
>  	reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
>  	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
>  
> -	switch (reg_subtype) {
> -	case KVM_REG_RISCV_SBI_STA:
> -		return kvm_riscv_vcpu_set_reg_sbi_sta(vcpu, reg_num, reg_val);
> -	default:
> +	ext = kvm_vcpu_sbi_find_ext_withstate(vcpu, reg_subtype);
> +	if (!ext || !ext->set_state_reg)
>  		return -EINVAL;
> -	}
>  
> -	return 0;
> +	return ext->set_state_reg(vcpu, reg_num, KVM_REG_SIZE(reg->id), reg_val);
>  }
>  
> -int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
> -			       const struct kvm_one_reg *reg)
> +int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>  	unsigned long __user *uaddr =
>  			(unsigned long __user *)(unsigned long)reg->addr;
>  	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
>  					    KVM_REG_SIZE_MASK |
>  					    KVM_REG_RISCV_SBI_STATE);
> -	unsigned long reg_subtype, reg_val;
> +	const struct kvm_vcpu_sbi_extension *ext;
> +	unsigned long reg_subtype;
> +	void *reg_val;
> +	u64 data64;
> +	u32 data32;
> +	u16 data16;
> +	u8 data8;
>  	int ret;
>  
> -	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
> +	switch (KVM_REG_SIZE(reg->id)) {
> +	case 1:
> +		reg_val = &data8;
> +		break;
> +	case 2:
> +		reg_val = &data16;
> +		break;
> +	case 4:
> +		reg_val = &data32;
> +		break;
> +	case 8:
> +		reg_val = &data64;
> +		break;
> +	default:
>  		return -EINVAL;
> +	};

superfluous ';'

>  
>  	reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
>  	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
>  
> -	switch (reg_subtype) {
> -	case KVM_REG_RISCV_SBI_STA:
> -		ret = kvm_riscv_vcpu_get_reg_sbi_sta(vcpu, reg_num, &reg_val);
> -		break;
> -	default:
> +	ext = kvm_vcpu_sbi_find_ext_withstate(vcpu, reg_subtype);
> +	if (!ext || !ext->get_state_reg)
>  		return -EINVAL;
> -	}
>  
> +	ret = ext->get_state_reg(vcpu, reg_num, KVM_REG_SIZE(reg->id), reg_val);
>  	if (ret)
>  		return ret;
>  
> -	if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
> +	if (copy_to_user(uaddr, reg_val, KVM_REG_SIZE(reg->id)))
>  		return -EFAULT;
>  
>  	return 0;
> diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
> index cc6cb7c8f0e4..d14cf6255d83 100644
> --- a/arch/riscv/kvm/vcpu_sbi_sta.c
> +++ b/arch/riscv/kvm/vcpu_sbi_sta.c
> @@ -151,63 +151,83 @@ static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
>  	return !!sched_info_on();
>  }
>  
> -const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
> -	.extid_start = SBI_EXT_STA,
> -	.extid_end = SBI_EXT_STA,
> -	.handler = kvm_sbi_ext_sta_handler,
> -	.probe = kvm_sbi_ext_sta_probe,
> -	.reset = kvm_riscv_vcpu_sbi_sta_reset,
> -};
> +static unsigned long kvm_sbi_ext_sta_get_state_reg_count(struct kvm_vcpu *vcpu)
> +{
> +	return sizeof(struct kvm_riscv_sbi_sta) / sizeof(unsigned long);
> +}
>  
> -int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu,
> -				   unsigned long reg_num,
> -				   unsigned long *reg_val)
> +static int kvm_sbi_ext_sta_get_reg(struct kvm_vcpu *vcpu, unsigned long reg_num,
> +				   unsigned long reg_size, void *reg_val)
>  {
> +	unsigned long *value;
> +
> +	if (reg_size != sizeof(unsigned long))
> +		return -EINVAL;
> +	value = reg_val;
> +
>  	switch (reg_num) {
>  	case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
> -		*reg_val = (unsigned long)vcpu->arch.sta.shmem;
> +		*value = (unsigned long)vcpu->arch.sta.shmem;
>  		break;
>  	case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
>  		if (IS_ENABLED(CONFIG_32BIT))
> -			*reg_val = upper_32_bits(vcpu->arch.sta.shmem);
> +			*value = upper_32_bits(vcpu->arch.sta.shmem);
>  		else
> -			*reg_val = 0;
> +			*value = 0;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return -ENOENT;
>  	}
>  
>  	return 0;
>  }
>  
> -int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu,
> -				   unsigned long reg_num,
> -				   unsigned long reg_val)
> +static int kvm_sbi_ext_sta_set_reg(struct kvm_vcpu *vcpu, unsigned long reg_num,
> +				   unsigned long reg_size, const void *reg_val)
>  {
> +	unsigned long value;
> +
> +	if (reg_size != sizeof(unsigned long))
> +		return -EINVAL;
> +	value = *(const unsigned long *)reg_val;
> +
>  	switch (reg_num) {
>  	case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
>  		if (IS_ENABLED(CONFIG_32BIT)) {
>  			gpa_t hi = upper_32_bits(vcpu->arch.sta.shmem);
>  
> -			vcpu->arch.sta.shmem = reg_val;
> +			vcpu->arch.sta.shmem = value;
>  			vcpu->arch.sta.shmem |= hi << 32;
>  		} else {
> -			vcpu->arch.sta.shmem = reg_val;
> +			vcpu->arch.sta.shmem = value;
>  		}
>  		break;
>  	case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
>  		if (IS_ENABLED(CONFIG_32BIT)) {
>  			gpa_t lo = lower_32_bits(vcpu->arch.sta.shmem);
>  
> -			vcpu->arch.sta.shmem = ((gpa_t)reg_val << 32);
> +			vcpu->arch.sta.shmem = ((gpa_t)value << 32);
>  			vcpu->arch.sta.shmem |= lo;
> -		} else if (reg_val != 0) {
> +		} else if (value != 0) {
>  			return -EINVAL;
>  		}
>  		break;
>  	default:
> -		return -EINVAL;
> +		return -ENOENT;
>  	}
>  
>  	return 0;
>  }
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
> +	.extid_start = SBI_EXT_STA,
> +	.extid_end = SBI_EXT_STA,
> +	.handler = kvm_sbi_ext_sta_handler,
> +	.probe = kvm_sbi_ext_sta_probe,
> +	.reset = kvm_riscv_vcpu_sbi_sta_reset,
> +	.have_state = true,
> +	.state_reg_subtype = KVM_REG_RISCV_SBI_STA,
> +	.get_state_reg_count = kvm_sbi_ext_sta_get_state_reg_count,
> +	.get_state_reg = kvm_sbi_ext_sta_get_reg,
> +	.set_state_reg = kvm_sbi_ext_sta_set_reg,
> +};
> -- 
> 2.43.0
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

