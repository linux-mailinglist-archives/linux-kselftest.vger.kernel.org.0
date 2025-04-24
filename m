Return-Path: <linux-kselftest+bounces-31537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE2A9AC2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F241B6603C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96B22F778;
	Thu, 24 Apr 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FGyyfJ3z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8B225776
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494465; cv=none; b=BFnTWolYrKGrSuP3P6r2V5QkgP3u6cDMw2heevL0DXy88JH4VwwEUS4TQv0nR0ffyZW34gVHg1m7zpK3R7E4drZ108RDdAfSt31Ak+aMaQXfCk2MdbxvJMVc5bNSoRhY55zh4Xm81u2+f0AzDQhvUGHYc1YUteOcMHuk+nnZJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494465; c=relaxed/simple;
	bh=IXZ8njn3lHnMF+wZnne8sz6AGB4un/zdAulPyviKX2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9o2MOUhXejpuJU0uQhgb4pn1Yx6vSs5Ne5Ce/ZgZq/5tTLiZ3IBiG/B2EoM7ft65CuF67GtyR3DwHTI1Z6G5i4dmCBqAv+5lcEK4ArRw9tVyqW3r/RtPXOAas+hs84H7gFLsFGjw6rsXCSW3ZLNdsGNd2S0xnGp+ztxqQbzJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FGyyfJ3z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso582389f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745494462; x=1746099262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kNEaxbnoW9g1fYmJXQwSNKTdFbvmREbcFtvdLnT5Xc=;
        b=FGyyfJ3zg9bv6mloDJ2FkB2yKg3eCFZBZzb60PEmUrgTOvN+NHVnzs/bxebUlVPYr4
         L9IB4We2faZXga9kaduTRsNiDGFaMFnOFvA8kJgTvo1qdhniaZvBIH4EvtY/hD8SCSzX
         gVF5JMFsSTetIM9xznaCFyoaUljkjGVD7fUR6gp7t4nt80FdPBm5Hq+AV0qcMi6RqNao
         mz/WXQkm+4axtum9KMbIByJJ+Cyd3pIz+cJMOYSFMOHLVAy/KlgrHEuPob3Jx3K9dpVY
         fojQl77MQQwRfLguAdJ89kmk5UP/6ISH0HCRqnL/fqKgUGLrbgs9iHXudcdVLBczXbMW
         KZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745494462; x=1746099262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kNEaxbnoW9g1fYmJXQwSNKTdFbvmREbcFtvdLnT5Xc=;
        b=OOxpA3V6NoaephpKafgIwTA1brLVAA8r06eHxvLhRPkJw7Tzf1Cvync0jtub07LZn6
         3CYc4Z3/AW9Nsf3UOW3qj4v1khanF1N/g6/y1KIgEq1X0lFSB69Sk5cTkO3a3fr1UTVT
         fRe/DiChbNLLpsotZiPN2KeRWoq2v/WlbFAPRIz6ycJWsQJF3/bb6L93ve75u1tOThu2
         NgyXUCHTVetU9kvlYashOkKkx5CfEN7wKwAzxxg9W/i21vFcX5MUWg9otQNGSTvohuin
         l3Jl4Cc0ey3JitzVKTMbFGp9Cb4MT/8FtOutb0akx+5/fOE1bR+WudOtQeDgHOSxSwtd
         qnqg==
X-Forwarded-Encrypted: i=1; AJvYcCUIsYftGfpuofcp2V7q0cgVYsV8LLlilp348TxuXs889068MhD+o3EmF2dchq4737BvUkNMCw36vkYtT2xH43w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rAYauwljwTSZIwwnbBV8k+bkuMbpATYR18G/+y+V2vdTW0gW
	TocKJydx8WKRNUiUnj8tlM0ZmOjezH4xDRDSv72Vecj67xk8UsbmsEyg4D7/ZkI=
X-Gm-Gg: ASbGncsztCCF2faNmxhQcsZaKjSlZWa7Q6i8pFnz6PhAbhDQX44sMphEbdDOgKF3TnZ
	GCuvs0gGctYDYE7E8PXoMnrI2qPpC5AX/06NzLjXkWitOKbzFO7sYYEerjrhNr58K3zIQEl4dey
	XlG4CPYMgDG1fUgbpCUeDNKLs9RGvfYO5KAWQQwc+uBizkMTCc1VLxfpXeP4MhnjOKE7dIc1hi6
	qDgPSwIicfqmRj+/nyaDrfiHOHdicl6X1E3CjKDYZp7qYpE64RAMvgcf+RQiSHjgnMABvIz9TvS
	ebci5q1iG4g7Kyrxa7sxEhCEpTwg
X-Google-Smtp-Source: AGHT+IH+Hg3/PqfVx4rNvlrTeNa+fBCY/aumfjJWzS9tER7WilSZAHlxfjRytvmLaoteiiEk+m6uJg==
X-Received: by 2002:a5d:4a8e:0:b0:39a:c9d9:877b with SMTP id ffacd0b85a97d-3a06cf5f4fcmr1401332f8f.27.1745494461931;
        Thu, 24 Apr 2025 04:34:21 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4bf781sm1830579f8f.37.2025.04.24.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:34:21 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:34:20 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v5 13/13] RISC-V: KVM: add support for
 SBI_FWFT_MISALIGNED_DELEG
Message-ID: <20250424-ae24464169f7143c509cbab5@orel>
References: <20250417122337.547969-1-cleger@rivosinc.com>
 <20250417122337.547969-14-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417122337.547969-14-cleger@rivosinc.com>

On Thu, Apr 17, 2025 at 02:20:00PM +0200, Clément Léger wrote:
> SBI_FWFT_MISALIGNED_DELEG needs hedeleg to be modified to delegate
> misaligned load/store exceptions. Save and restore it during CPU
> load/put.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu.c          |  3 +++
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 36 ++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 542747e2c7f5..d98e379945c3 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -646,6 +646,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  {
>  	void *nsh;
>  	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
> +	struct kvm_vcpu_config *cfg = &vcpu->arch.cfg;
>  
>  	vcpu->cpu = -1;
>  
> @@ -671,6 +672,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  		csr->vstval = nacl_csr_read(nsh, CSR_VSTVAL);
>  		csr->hvip = nacl_csr_read(nsh, CSR_HVIP);
>  		csr->vsatp = nacl_csr_read(nsh, CSR_VSATP);
> +		cfg->hedeleg = nacl_csr_read(nsh, CSR_HEDELEG);
>  	} else {
>  		csr->vsstatus = csr_read(CSR_VSSTATUS);
>  		csr->vsie = csr_read(CSR_VSIE);
> @@ -681,6 +683,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  		csr->vstval = csr_read(CSR_VSTVAL);
>  		csr->hvip = csr_read(CSR_HVIP);
>  		csr->vsatp = csr_read(CSR_VSATP);
> +		cfg->hedeleg = csr_read(CSR_HEDELEG);
>  	}
>  }
>  
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> index b0f66c7bf010..237edaefa267 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -14,6 +14,8 @@
>  #include <asm/kvm_vcpu_sbi.h>
>  #include <asm/kvm_vcpu_sbi_fwft.h>
>  
> +#define MIS_DELEG (BIT_ULL(EXC_LOAD_MISALIGNED) | BIT_ULL(EXC_STORE_MISALIGNED))
> +
>  struct kvm_sbi_fwft_feature {
>  	/**
>  	 * @id: Feature ID
> @@ -68,7 +70,41 @@ static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
>  	return false;
>  }
>  
> +static bool kvm_sbi_fwft_misaligned_delegation_supported(struct kvm_vcpu *vcpu)
> +{
> +	return misaligned_traps_can_delegate();
> +}
> +
> +static long kvm_sbi_fwft_set_misaligned_delegation(struct kvm_vcpu *vcpu,
> +					struct kvm_sbi_fwft_config *conf,
> +					unsigned long value)
> +{
> +	if (value == 1)
> +		csr_set(CSR_HEDELEG, MIS_DELEG);
> +	else if (value == 0)
> +		csr_clear(CSR_HEDELEG, MIS_DELEG);
> +	else
> +		return SBI_ERR_INVALID_PARAM;
> +
> +	return SBI_SUCCESS;
> +}
> +
> +static long kvm_sbi_fwft_get_misaligned_delegation(struct kvm_vcpu *vcpu,
> +					struct kvm_sbi_fwft_config *conf,
> +					unsigned long *value)
> +{
> +	*value = (csr_read(CSR_HEDELEG) & MIS_DELEG) != 0;

This should be

  (csr_read(CSR_HEDELEG) & MIS_DELEG) == MIS_DELEG;

> +
> +	return SBI_SUCCESS;
> +}
> +
>  static const struct kvm_sbi_fwft_feature features[] = {
> +	{
> +		.id = SBI_FWFT_MISALIGNED_EXC_DELEG,
> +		.supported = kvm_sbi_fwft_misaligned_delegation_supported,
> +		.set = kvm_sbi_fwft_set_misaligned_delegation,
> +		.get = kvm_sbi_fwft_get_misaligned_delegation,
> +	},
>  };
>  
>  static struct kvm_sbi_fwft_config *
> -- 
> 2.49.0
>

Thanks,
drew

