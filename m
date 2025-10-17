Return-Path: <linux-kselftest+bounces-43391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 752BABEAA55
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95DEB5A409F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F39284884;
	Fri, 17 Oct 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N9ZoNCVH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C228B4FE
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717666; cv=none; b=IWRyB04ukO1eTvUdLSyDQOOE0X6QuueMTWl2UFauzf0G4bNDvHdP/UscWT3MeKj2a38xpw/B3itQUHuQu9KmIDqdW97STlFVA5e5DgGYLgaQtn/l525iniBsgEEPhOhBjG0AMRrTIOhfGphzM9sTiKG1wQ4LpQ1/nzAMRcdL6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717666; c=relaxed/simple;
	bh=QwO/GQIB5TFceUxQ6cipVkamdhm/GpF7xHuLsZZzLwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKgeeNeyNaAolPDQn932qyihsz9Gxbcs5RyGImbKzgv/kXNCzdOleP/WMDDRcnYSb5AXFN2XiYKtKfPJfzLGtHAVb4UrgZgjPOkYZrPr2a1G4xHwFnliP0i6WPuSgMV6gASirOcRh7oaIBpyvw5dBNBzAbHtoApEYj8/cdyo3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N9ZoNCVH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42d7ef9a402so15973445ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760717664; x=1761322464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcRYGr52a4tOVgKtqMlXN+kBqCdQJvh2IsOMcMv7JGg=;
        b=N9ZoNCVHC2qpY7HfuaoMyHNiBbjchaffvgPDkXUtMDrTvQ2JLDrGhqpaQqKt9WdmSZ
         2J+LUNB8StClrR2aLrfN6iPFZqkUdvRWE9UI6WL3q3ZIRAn6M7/prN5PeTXlm1mnSyYS
         uywcFkInZMBf5dYBqP0jV2H8i6D5mhBBA1ab9V1Ys+g5E28lY9R9WX95qDpzkUeDCFbG
         LwYrscFCLjYjN7IJov1HstbD7yqieFX0IhBnrHJ7b8jGCHlBIueLvOB/B9LKnXsIvhjd
         h31jx7dIXzu8ZVCIchBfEwCghsgSBb/R6nHwVvbzS1jD9/LiDOlUzpFPi1tJf39z/OeC
         Niiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717664; x=1761322464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcRYGr52a4tOVgKtqMlXN+kBqCdQJvh2IsOMcMv7JGg=;
        b=jaA4kJuBZstrklbNdsLzlYfgZJGXHeQAdyP+a26FE+1C9bML6AJvUy3xy9aVstFmPI
         554i/rTfEZ4LFTXHKpCC1c3W4Yvl3ewkwDoTxpGIcMFZk1hjJhugy4hGvMCsSmpMuKvs
         0WYf/O+3CKg8+ko1Bdx7TnfHLgVnigVJY+F3uM2eixNaXJAK4Tw7zXt+Jbr+db3/FLeN
         NbWg1uFnfQZP0hVQ8qAvu4oxB9YfqcMS2NslJW6Wr7f4tJs5vp1fAUY1n5KdndMhvH+q
         TQ9cF6YJeTrT+1k1A5LY7oo+1NAmnWKOnoRB7FQzLQSHUsRJiGGm8vGj1gubeNxs7p5K
         S1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXs/Mi6IU1wPKp43udNo71MW8yxUh6pqZGpl2S25WR4cxPPWqGNQ/D/dDiE/XIFYR8NROx7gmQINV12JYm+iEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVPGNe3rhmZKvZdp8W+edC64vm5+xCTZt92cp8VmlVrG34x2E
	50AiHYi5pXUNBhxfE7FrrT/dDlBpC47z8wBMsr71cm2N3SnRYZtly8WLkXPI3d+ZP9o=
X-Gm-Gg: ASbGncs2z8xGT1r4cfmObYtwdUzfIJnIiMQW5rhUW1kyHKCWqkxo5saKmaG8hGScIot
	hy3k+8e3FWzSYbKvK5Hob1iBkJWv7Z3Vdw2TpWEDx+cmgRnCw54CHC0e/y+kitC6UqrXx40VDGD
	67wPzqu8GsmjHsJnhza4pF+jL0rbnC0Rj9Pq3HYvvhFdJ8kpkVhqCBq9UVyLKy0PkVKok8M7nSG
	hPqcJE14RPB7JBqVCXio54YlQuGj8IlB22BNBNFSTfE837OlM/3pem6N7lfZCNjV6pN8fBPDPoC
	bGdWf3GX9wnugzMRrpYudHVBryvJ9mVRl5WVyNSCP1L6PuvAUcf9UdxH+4/9x8xqdS9Cx0/Jipj
	d8mnYAza+TIiELIXjLneexUGuyJARSzkLu75fZv0KLsxJRgzhH+tT6fbnKRuEoQEFcVixvPjpYl
	fYGg==
X-Google-Smtp-Source: AGHT+IG8NcfyQvR4Ib9EQoaH4QfobDX+a05XY4rSJHsCAlxEkbmXVJHbo70zGFdtD5RzLgfxV/T+lw==
X-Received: by 2002:a05:6e02:178b:b0:430:9918:e69f with SMTP id e9e14a558f8ab-430b41eb013mr122131225ab.4.1760717663752;
        Fri, 17 Oct 2025 09:14:23 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9768bfbsm8636173.48.2025.10.17.09.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:14:23 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:14:22 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] RISC-V: KVM: Convert kvm_riscv_vcpu_sbi_forward()
 into extension handler
Message-ID: <20251017-161e4ec373e5f7c41364a4d3@orel>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
 <20251017155925.361560-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017155925.361560-2-apatel@ventanamicro.com>

On Fri, Oct 17, 2025 at 09:29:22PM +0530, Anup Patel wrote:
> All uses of kvm_riscv_vcpu_sbi_forward() also updates retdata->uexit so
> to further reduce code duplication move retdata->uexit assignment to
> kvm_riscv_vcpu_sbi_forward() and convert it into SBI extension handler.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 +++-
>  arch/riscv/kvm/vcpu_sbi.c             |  6 +++++-
>  arch/riscv/kvm/vcpu_sbi_base.c        | 20 +++-----------------
>  arch/riscv/kvm/vcpu_sbi_replace.c     | 27 +--------------------------
>  arch/riscv/kvm/vcpu_sbi_system.c      |  4 +---
>  arch/riscv/kvm/vcpu_sbi_v01.c         |  3 +--
>  6 files changed, 14 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> index 3497489e04db..446f4a8eb3cd 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -69,7 +69,9 @@ struct kvm_vcpu_sbi_extension {
>  			     unsigned long reg_size, const void *reg_val);
>  };
>  
> -void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
> +int kvm_riscv_vcpu_sbi_forward_handler(struct kvm_vcpu *vcpu,
> +				       struct kvm_run *run,
> +				       struct kvm_vcpu_sbi_return *retdata);
>  void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
>  				     struct kvm_run *run,
>  				     u32 type, u64 flags);
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 1b13623380e1..fd4106c276d8 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -120,7 +120,9 @@ static bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx)
>  	return sext && scontext->ext_status[sext->ext_idx] != KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
>  }
>  
> -void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +int kvm_riscv_vcpu_sbi_forward_handler(struct kvm_vcpu *vcpu,
> +				       struct kvm_run *run,
> +				       struct kvm_vcpu_sbi_return *retdata)
>  {
>  	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
>  
> @@ -137,6 +139,8 @@ void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	run->riscv_sbi.args[5] = cp->a5;
>  	run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
>  	run->riscv_sbi.ret[1] = 0;
> +	retdata->uexit = true;
> +	return 0;
>  }
>  
>  void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
> diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
> index 5bc570b984f4..ca489f2dfbdf 100644
> --- a/arch/riscv/kvm/vcpu_sbi_base.c
> +++ b/arch/riscv/kvm/vcpu_sbi_base.c
> @@ -41,8 +41,7 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  			 * For experimental/vendor extensions
>  			 * forward it to the userspace
>  			 */
> -			kvm_riscv_vcpu_sbi_forward(vcpu, run);
> -			retdata->uexit = true;
> +			return kvm_riscv_vcpu_sbi_forward_handler(vcpu, run, retdata);
>  		} else {
>  			sbi_ext = kvm_vcpu_sbi_find_ext(vcpu, cp->a0);
>  			*out_val = sbi_ext && sbi_ext->probe ?
> @@ -72,27 +71,14 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
>  	.handler = kvm_sbi_ext_base_handler,
>  };
>  
> -static int kvm_sbi_ext_forward_handler(struct kvm_vcpu *vcpu,
> -				       struct kvm_run *run,
> -				       struct kvm_vcpu_sbi_return *retdata)
> -{
> -	/*
> -	 * Both SBI experimental and vendor extensions are
> -	 * unconditionally forwarded to userspace.
> -	 */
> -	kvm_riscv_vcpu_sbi_forward(vcpu, run);
> -	retdata->uexit = true;
> -	return 0;
> -}
> -
>  const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
>  	.extid_start = SBI_EXT_EXPERIMENTAL_START,
>  	.extid_end = SBI_EXT_EXPERIMENTAL_END,
> -	.handler = kvm_sbi_ext_forward_handler,
> +	.handler = kvm_riscv_vcpu_sbi_forward_handler,
>  };
>  
>  const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
>  	.extid_start = SBI_EXT_VENDOR_START,
>  	.extid_end = SBI_EXT_VENDOR_END,
> -	.handler = kvm_sbi_ext_forward_handler,
> +	.handler = kvm_riscv_vcpu_sbi_forward_handler,
>  };
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
> index b490ed1428a6..2c456e26f6ca 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -186,34 +186,9 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst = {
>  	.handler = kvm_sbi_ext_srst_handler,
>  };
>  
> -static int kvm_sbi_ext_dbcn_handler(struct kvm_vcpu *vcpu,
> -				    struct kvm_run *run,
> -				    struct kvm_vcpu_sbi_return *retdata)
> -{
> -	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> -	unsigned long funcid = cp->a6;
> -
> -	switch (funcid) {
> -	case SBI_EXT_DBCN_CONSOLE_WRITE:
> -	case SBI_EXT_DBCN_CONSOLE_READ:
> -	case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
> -		/*
> -		 * The SBI debug console functions are unconditionally
> -		 * forwarded to the userspace.
> -		 */
> -		kvm_riscv_vcpu_sbi_forward(vcpu, run);
> -		retdata->uexit = true;
> -		break;
> -	default:
> -		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
> -	}
> -
> -	return 0;
> -}
> -
>  const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
>  	.extid_start = SBI_EXT_DBCN,
>  	.extid_end = SBI_EXT_DBCN,
>  	.default_disabled = true,
> -	.handler = kvm_sbi_ext_dbcn_handler,
> +	.handler = kvm_riscv_vcpu_sbi_forward_handler,
>  };
> diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_system.c
> index 359be90b0fc5..c6f7e609ac79 100644
> --- a/arch/riscv/kvm/vcpu_sbi_system.c
> +++ b/arch/riscv/kvm/vcpu_sbi_system.c
> @@ -47,9 +47,7 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		kvm_riscv_vcpu_sbi_request_reset(vcpu, cp->a1, cp->a2);
>  
>  		/* userspace provides the suspend implementation */
> -		kvm_riscv_vcpu_sbi_forward(vcpu, run);
> -		retdata->uexit = true;
> -		break;
> +		return kvm_riscv_vcpu_sbi_forward_handler(vcpu, run, retdata);
>  	default:
>  		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
>  		break;
> diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
> index 368dfddd23d9..188d5ea5b3b8 100644
> --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> @@ -32,8 +32,7 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		 * The CONSOLE_GETCHAR/CONSOLE_PUTCHAR SBI calls cannot be
>  		 * handled in kernel so we forward these to user-space
>  		 */
> -		kvm_riscv_vcpu_sbi_forward(vcpu, run);
> -		retdata->uexit = true;
> +		ret = kvm_riscv_vcpu_sbi_forward_handler(vcpu, run, retdata);
>  		break;
>  	case SBI_EXT_0_1_SET_TIMER:
>  #if __riscv_xlen == 32
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

