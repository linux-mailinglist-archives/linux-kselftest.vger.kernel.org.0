Return-Path: <linux-kselftest+bounces-18761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83798C1BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB1F1C2195A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA31CB32A;
	Tue,  1 Oct 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FR5sHTrm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB801C9EDE
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796971; cv=none; b=S6g0jTI+LmcouSf1F4knay1VcSujruEyomgBOpxtlX0q/yKnPcWwqB9ajgVMPdEDl8wsYEagh717HZy86+/FjBSkg0TxVX75fK/H3xtiGfYPfYNP7Chw40QmvZYpL7oRFMuZa66QBbc4iFLV8IFOy3kd9tF4BzNlHMhydhcMA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796971; c=relaxed/simple;
	bh=kN1p3bVPBmWTODx3fCU3W9xMzs9MpIS/egm2ExIsaZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cal0DyQjFW308z5j1zS8MSNXMMb+smogHRUiUL+B4vYxZSkm/1JTy7FAqPalq4g+xRSuz3v2gIGLXukBjxL2r5btkkhuAfMpyds8Dky09jzB+DBnmXzM8nR6+BIlaAIwxSngijYZ4o1JJaYPRmmQxP4tuf/mnvkn7I4JKExokAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FR5sHTrm; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 1 Oct 2024 08:35:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727796967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32Q5lzmZrkJ5L4hpQaXBrF/A6/szWXXqzVVtbQ1nd7E=;
	b=FR5sHTrmIz5pif3i2vsHSSam8/HnX26X81OIgTcwQTF1+8b1qzHuS1Uqm82hOXM1VmJrTB
	Wm4vMkgTbsYpUIJZSEX2UwsnjjQu6FEdEokcLlunUrZFfHMDYEeQG/HpVO6sVUH/SEB8+t
	3Dy9ZPsJwINeQoLOZhUt1OTywf6nu7o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH v5 3/5] KVM: arm64: Add support for PSCI v1.2 and v1.3
Message-ID: <ZvwW1y1pWln5l99M@linux.dev>
References: <20240926184546.833516-1-dwmw2@infradead.org>
 <20240926184546.833516-4-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926184546.833516-4-dwmw2@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 26, 2024 at 07:37:58PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>

Please, add changelogs to your patches.

What we really need here is the detail on *why* we can just bump the
PSCI version like this, i.e. no new required ABI. On top of that, you
could mention that KVM has made the implementation choice to provide
SYSTEM_OFF2 unconditionally in its PSCIv1.3 implementation.

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/arm64/kvm/hypercalls.c | 2 ++
>  arch/arm64/kvm/psci.c       | 6 +++++-
>  include/kvm/arm_psci.h      | 4 +++-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index 5763d979d8ca..9c6267ca2b82 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -575,6 +575,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  		case KVM_ARM_PSCI_0_2:
>  		case KVM_ARM_PSCI_1_0:
>  		case KVM_ARM_PSCI_1_1:
> +		case KVM_ARM_PSCI_1_2:
> +		case KVM_ARM_PSCI_1_3:
>  			if (!wants_02)
>  				return -EINVAL;
>  			vcpu->kvm->arch.psci_version = val;
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index fd0f82464f7d..5177dda5a411 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -328,7 +328,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
>  
>  	switch(psci_fn) {
>  	case PSCI_0_2_FN_PSCI_VERSION:
> -		val = minor == 0 ? KVM_ARM_PSCI_1_0 : KVM_ARM_PSCI_1_1;
> +		val = PSCI_VERSION(1, minor);
>  		break;
>  	case PSCI_1_0_FN_PSCI_FEATURES:
>  		arg = smccc_get_arg1(vcpu);
> @@ -486,6 +486,10 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
>  	}
>  
>  	switch (version) {
> +	case KVM_ARM_PSCI_1_3:
> +		return kvm_psci_1_x_call(vcpu, 3);
> +	case KVM_ARM_PSCI_1_2:
> +		return kvm_psci_1_x_call(vcpu, 2);
>  	case KVM_ARM_PSCI_1_1:
>  		return kvm_psci_1_x_call(vcpu, 1);
>  	case KVM_ARM_PSCI_1_0:
> diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
> index e8fb624013d1..cbaec804eb83 100644
> --- a/include/kvm/arm_psci.h
> +++ b/include/kvm/arm_psci.h
> @@ -14,8 +14,10 @@
>  #define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
>  #define KVM_ARM_PSCI_1_0	PSCI_VERSION(1, 0)
>  #define KVM_ARM_PSCI_1_1	PSCI_VERSION(1, 1)
> +#define KVM_ARM_PSCI_1_2	PSCI_VERSION(1, 2)
> +#define KVM_ARM_PSCI_1_3	PSCI_VERSION(1, 3)
>  
> -#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_1
> +#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_3
>  
>  static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
>  {
> -- 
> 2.44.0
> 

-- 
Thanks,
Oliver

