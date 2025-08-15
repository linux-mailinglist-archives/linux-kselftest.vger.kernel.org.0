Return-Path: <linux-kselftest+bounces-39120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B61B286E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 22:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0AA601466
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23C298CD5;
	Fri, 15 Aug 2025 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bdION+ee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5E275846
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288282; cv=none; b=uH0H5Ix/N6ISeqVG34EiOoJacXSlNqwXGMtHFcQXGSj55FMCqNDLpHmfDkXj7/PWZUA84BgraE17b2lh8MN1/F78kNRsX0sDF7k3vI8K8e42gb188XMcq+d3INgkeJhrsXEC5cj4ZNjrPwABxvAPZNS4537EYGIRaIPZ2j5B7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288282; c=relaxed/simple;
	bh=YnJazGOGZYJN/dBOZtTqRX6QsQM8mR8auk3uz2DqgeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McnRmrCwKuzJ5EpBxB5AvWOcCWOQdBTMaeTaGCqK3i122pO3kpwS45whx9Fkns4vVNvWtNRRPQfeArpSEf5sBNMuxNJFwNNbUWZ69uMfZ0Bu6NWj/v34FPMmSPZNvKZ8ZZlk3XXRe/iX/IPDMwdfQMrL+4I7cvKtnmLaOevkwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bdION+ee; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88432daa703so65026939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755288280; x=1755893080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjJzR6BitUGV64diaMvb3KSO/e3Gi7ex2M4rjIRjOr4=;
        b=bdION+eejFvdPEWkEbuMrOJ3+gSdkiYpkxnSXMWsRmBATp6dxZ3jndTZjFN2l7rLrJ
         Wg0MvpyfdW2ATIMfUJomXxy0Mqm/tqGaIQIIr/iKmpQ61rYgzTElr91VQ5GfMPkBU8gd
         +YnJHz+kGMF3kJbMEV7HMFCFu8echSEeWkbVwtJFTO3XUfEfngxnWyltILOoSd8mQ+xH
         nX8MPluR3DzvdNhMr4TJ9CmUpSecA0Tx0nTptZxDrrOoW3nD3b/+uM6GHAxNBEgkjNMX
         MYu452K4mmJn9pooUruBDq82NCy7uHAM2hKvs6BOHecoRXDahyykkLelYYe+TRq5GX2a
         dsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288280; x=1755893080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjJzR6BitUGV64diaMvb3KSO/e3Gi7ex2M4rjIRjOr4=;
        b=ncSKaIdvqlGDK2xH8Nv27Z6If0iKPLMmCEqE5uj/hiy2uuE3YSYcJpqaKB4LNvvikU
         rasCo5+5GZuoP0ggLluWLPe/Mrs2rnAcMez7xyg7iRaHPN7UWFH0nsnjv6RWPENPkaoH
         Q6GKNdaRaxErvlW6rSkCB9LCpTw7f/T7VRWYHKEr0Eqv5RF3IIVDeasR4mFYvdiQQZEi
         7+6Rdr98LpP5gzn0C3ZRLhxxXSE1W0ccQr2ek/mqifUDQBzJPzabIrf4O7Ci5CsoUpdm
         oO7tRYOLIcZn8JWlLIKiSK96SFR1vPE5K8kQlSrqt3ahGQJCUKV6DCfkkXcyCCQP7Z3M
         0fZA==
X-Forwarded-Encrypted: i=1; AJvYcCWh7aCzK8GD3yE8MQhjx4kJ170StPv3pZln09PIxKUsR7dcICo2GALfvjU+NRgmREla7wT/TYwsA3K8rBSFpQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gJiivznBgGFcgHkxrKEdXa3BSX/4k/Dac39wJCnXrTcZFn3E
	6axAd24tqWkKnA4qzmhMeYLgzhwSD2GImnS91P8PGmcJzsl6aglBBMmjc3XP/RKvsMg=
X-Gm-Gg: ASbGnctv43VPFBN9sA/XQ0WXM0/WUYSLorta6a0VDC7cFMkBqONY6994nEcIvg2ZuW1
	20zkWWJpLb40EymLD0q6OfdGXD6bp9+SggRlAmVJ3SyJkCXZSKGXmXnf4WISpegogKJZ+0uL5mZ
	xQtiom4YbhP+Jlfc8kn36ID+ZQKwf+Hp6cf+arBtXcnnQx4KaqOy5wOBnMY7CeqCnLJXaGsiDRz
	oWCTthc0wUy4grTeZ3cISjdt/0rW+077Z7SOp3ZS0TFe18Z2zGX6K9YgwjRMcvuz2Vyiv1vduEf
	guYtsctufUY0uVPaD2Pizx3MaWfLRN3Ir3vb8hVu+rHfBB8iqWY1ey1goJE+OHu72UaGaPBhFWw
	UsKiNjhB7LQQrtcTthEG74Mqj
X-Google-Smtp-Source: AGHT+IFVAKt30ibqWuDesYE4Rq4i7q7q9OchtpkO5B6rE/MAYha/hplJL5lUKwJN5zK9vnb+lDVkPA==
X-Received: by 2002:a05:6602:3410:b0:86c:e686:ca29 with SMTP id ca18e2360f4ac-8843e34cd35mr730781139f.2.1755288280204;
        Fri, 15 Aug 2025 13:04:40 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9f6d8dsm77814839f.24.2025.08.15.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:04:39 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:04:38 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/6] RISC-V: KVM: Set initial value of hedeleg in
 kvm_arch_vcpu_create()
Message-ID: <20250815-5b8056af445fb30be7c387a7@orel>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <20250814155548.457172-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814155548.457172-2-apatel@ventanamicro.com>

On Thu, Aug 14, 2025 at 09:25:43PM +0530, Anup Patel wrote:
> The hedeleg may be updated by ONE_REG interface before the VCPU
> is run at least once hence set the initial value of hedeleg in
> kvm_arch_vcpu_create() instead of kvm_riscv_vcpu_setup_config().
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index f001e56403f9..86025f68c374 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -133,6 +133,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  
>  	/* Mark this VCPU never ran */
>  	vcpu->arch.ran_atleast_once = false;
> +
> +	vcpu->arch.cfg.hedeleg = KVM_HEDELEG_DEFAULT;
>  	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
>  	bitmap_zero(vcpu->arch.isa, RISCV_ISA_EXT_MAX);
>  
> @@ -570,7 +572,6 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
>  			cfg->hstateen0 |= SMSTATEEN0_SSTATEEN0;
>  	}
>  
> -	cfg->hedeleg = KVM_HEDELEG_DEFAULT;
>  	if (vcpu->guest_debug)
>  		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
>  }
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

