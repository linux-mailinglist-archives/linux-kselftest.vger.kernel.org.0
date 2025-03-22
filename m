Return-Path: <linux-kselftest+bounces-29608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D76A6CA22
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8878B7A5486
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F2221550;
	Sat, 22 Mar 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YyJtbzao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CBC1F3BA2
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742646221; cv=none; b=tan0kDDwaTc4u0kgYamJIM8BDrwjO1amyuIXxhJVvdOrqXsH97bXiqeWJUAL1KJP7EJVZX9R21tH9Bi0timLGNTLFwC/FJ0EUo+UiijMHI7GupHYJregnKu4wHT8Fv1iZBPof9tI02OWW4F5Bskc+Y6rNcCT8v3zUrtDEppMSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742646221; c=relaxed/simple;
	bh=JGkkKKzAxa4ZMpAR8zJFpRuqjYnoAHWm22u5I3jTZTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwPxa7CL8565pSS0CPq6yy6r6mfA3zIu5XOaLhFRqQMxUNjh+trFxii6KMK7QoJ4r4eigyvnqKnzVO3tGUens+y8p7gavkWc5TFaMBzsoi0t1M1oV5zwUAdJy51XTYfCgA/sPmCxz1zbKnECraJf3mAeS28M3Vs0MSqrOAtqg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YyJtbzao; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39133f709f5so1486923f8f.0
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742646217; x=1743251017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTzyaulL1cxveyrERlwqgSXFqrJfmGbcSuyVzNJ2WH4=;
        b=YyJtbzaoe6ctVGSUzIRnUBgVJa2zt6p1TKepjQBtKVrfD7scbWaZM0W6Ntinxemkxr
         ew3YqRPlRxgPBLDMnXJioX7wrg5oKfD+nLqoyGha83SsofWi7XRtnVKoBfXlMm7aK+AU
         +rF+EzM6YPMLBmndAzf8i5MPqr00HbGuTiYAYZxlULyBwXLr3mryBRgovjoILazbHC7P
         9lE2Gf2UJo6z7vxmpLEe65FcG0s01kW5zxhjVK6pJfFoVEPWdD2Mnb1UCAz5GKo2pxGv
         e+euxaGbUHk/1l2GB8WrZGpWgz/PjhjbspQ4mnQBVLOZK7didHgrNrTrgF/qNSB01ssE
         vXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742646217; x=1743251017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTzyaulL1cxveyrERlwqgSXFqrJfmGbcSuyVzNJ2WH4=;
        b=TizwryDK/6+gS8VkJGwP7NJEDQRRbYtOXtiZX69p0gzx/xPpaio2qBaukhZI+/oYvM
         gdVWumoqFPe9nHAyC0VDDNarMSCC5RiofEj0e7XyUvt03+R5bVofXVnjN/uqaBN0KHkR
         4Wa9IDOsccDb3bwAXYaK63byttTOx1NjtzMLNn0xKWASs43P/YQ5M+/IX03vQA5STk/C
         TjnufHfBI8oDwQQ7TJMvJTGhEP3HCFC+3ElbhEqbxo/2uSdsH3/FtUnUiVZY58j1THqN
         4I3BgQf/0c5QVjdoPM0dUb27j9msUvDUN2mcjqY+rU1zLp6rqZc/1DSZjV9UNOyxEf1E
         9mXg==
X-Forwarded-Encrypted: i=1; AJvYcCXy+YSlCeLQ5pe2NIVe2Qk+miiCx1FJCRTD/d64cU0D+HrJyIsZ/BBSuZ9VSjJxAgJdH0lW85DoNiBRXPCfyXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMIItllawRTwzwSBUJ0g3bYX+6TOAyM7lsYBZqOSPiUDlPxYn
	eBPxPlnva7+/XIC1zaAqi7d7oRIq6o1CNulprgcnCa/9iW5c+577hdPV9TitOM8=
X-Gm-Gg: ASbGncuoUur/BcqtLqmZVrMZWVtVxuFoRlNkHtX8b6Bz+Fs59Wu6UP7cWzA7XbZnd8i
	DPbmo8c/wqDwhMdJf5/qYLGf9u0b2oLT9bw+F8ODXrZen8S95vIdxof0cNVLL1tLqc0mYSrnhFb
	4A5YvqzktlP4AoXPW8PNz37p1axH0Ur+06x12jlpZOcF5gpfyJSM4d9yH5Xph00Z9QST+wzyrD1
	mlF/QV01u5l+jN9fCGCV64f+ms36vxu8oN36I051KGzwhVQ89E1qpEWp1xVhv6kz1PZIVJnugjd
	MQpXRDU0I253QxbyK1wYjL6Aq+BYANd9BWOIOENF3yWO6bbhRUDIi2xlzjF98qPXc4Sq0CJpgJw
	qI6a1GiGU
X-Google-Smtp-Source: AGHT+IE52/go+hfWqaafAsUjbEtclhpDIHNnMSaVERxClIrOt/FGAA02DZDghiLFtwTeL9nKBPSrqg==
X-Received: by 2002:a5d:6da1:0:b0:38d:dd52:1b5d with SMTP id ffacd0b85a97d-3997f8ef06dmr5373282f8f.4.1742646216874;
        Sat, 22 Mar 2025 05:23:36 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e66a7sm5001809f8f.76.2025.03.22.05.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:23:36 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:23:35 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 15/18] RISC-V: KVM: add SBI extension init()/deinit()
 functions
Message-ID: <20250322-79de477d27a2a75eb89616d1@orel>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-16-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317170625.1142870-16-cleger@rivosinc.com>

On Mon, Mar 17, 2025 at 06:06:21PM +0100, Clément Léger wrote:
> The FWFT SBI extension will need to dynamically allocate memory and do
> init time specific initialization. Add an init/deinit callbacks that
> allows to do so.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
>  arch/riscv/kvm/vcpu.c                 |  2 ++
>  arch/riscv/kvm/vcpu_sbi.c             | 26 ++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index 4ed6203cdd30..bcb90757b149 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
>  
>  	/* Extension specific probe function */
>  	unsigned long (*probe)(struct kvm_vcpu *vcpu);
> +
> +	/*
> +	 * Init/deinit function called once during VCPU init/destroy. These
> +	 * might be use if the SBI extensions need to allocate or do specific
> +	 * init time only configuration.
> +	 */
> +	int (*init)(struct kvm_vcpu *vcpu);
> +	void (*deinit)(struct kvm_vcpu *vcpu);
>  };
>  
>  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
> @@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
>  int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
>  
>  int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
>  				   unsigned long *reg_val);
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 60d684c76c58..877bcc85c067 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -185,6 +185,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
> +	kvm_riscv_vcpu_sbi_deinit(vcpu);
> +
>  	/* Cleanup VCPU AIA context */
>  	kvm_riscv_vcpu_aia_deinit(vcpu);
>  
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index d1c83a77735e..3139f171c20f 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -508,5 +508,31 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
>  		scontext->ext_status[idx] = ext->default_disabled ?
>  					KVM_RISCV_SBI_EXT_STATUS_DISABLED :
>  					KVM_RISCV_SBI_EXT_STATUS_ENABLED;
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
>  	}
>  }
> -- 
> 2.47.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

