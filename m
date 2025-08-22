Return-Path: <linux-kselftest+bounces-39656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121BB30F8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3793A81DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304682E5428;
	Fri, 22 Aug 2025 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j17RBcsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADC15E90;
	Fri, 22 Aug 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845473; cv=none; b=LsoRSjLzEZLXrJRQZIaqCM0BIPwF1HyHIX98x2Tmk/hGeG0iJ/vpwBPkmi4ujAKiE5qyCi74sai0KgGgLz2uo6CVKKazaav3ZeoB/BSZxcH6NuAA3L31otDorGP0QQadlJQUDlp2cvhxFNLjjoS2+IeGaGWITAqWGun2vci2vGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845473; c=relaxed/simple;
	bh=JCJe22NBnh/Ohku/c/jURhYMPWhOcCrL/i6Ia6jiF3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpN0xA4zEg4CpMkbGI/HOvMaiHfHeE8ImFiAcNUPv+nYboozqpABuID7686LcvtkVc8ZQkhSPuTlrFiGcFryVZiyDBAEeU5alXKN9xLrzneAJ9HwhJvc6xFdYSLrPyz9FLUcaiWf0MVaDtkuzErUUGuvbwNoKSqK3Nr/Zx6grNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j17RBcsD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IrjTn5lxjgH6PT63JNA+B4QI+udrzjtftEznNof8LA0=; b=j17RBcsD4qSuOv6w/CU/WxHpFF
	IUY594dwVhdfBDbQGOv/tKSfMsm0NAXG1Md63nkJNodbRDDk8nW85G6B2OB7xQTA4CYrfAHA3MtQJ
	6fR1Ko1vfc8+DXbMEJWnMc+JPvB3m9SyDhWLFY94FS9FNO+CVHBVhJfjMdLlt2k5wPS3ZmXInAlMo
	Yd/DMzJdv4+lN7VYpp0Kveb9yEnELMp1djT3fv3kLMnXUFlH6Ba9vdZOXO0xIvUuhyD3CJDAY0+1R
	bC6jGsswDCYcR+XRRagP4v+i5j6hl4KC1BjvFwfFUO80GQLv5SLQ6ntdvHQ7Lrjwoa8/ZmJMX1pTo
	lADwTdoA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upLc4-00000001kK4-2FVr;
	Fri, 22 Aug 2025 06:51:00 +0000
Message-ID: <f87145e5-5a86-4ccf-96ac-61e16e894b81@infradead.org>
Date: Thu, 21 Aug 2025 23:50:58 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/29] KVM: arm64: Document the KVM ABI for SME
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
 <20250822-kvm-arm64-sme-v7-11-7a65d82b8b10@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-11-7a65d82b8b10@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 6:53 PM, Mark Brown wrote:
> SME, the Scalable Matrix Extension, is an arm64 extension which adds
> support for matrix operations, with core concepts patterned after SVE.
> 
> SVE introduced some complication in the ABI since it adds new vector
> floating point registers with runtime configurable size, the size being
> controlled by a prameter called the vector length (VL). To provide control

                  parameter

> of this to VMMs we offer two phase configuration of SVE, SVE must first be
> enabled for the vCPU with KVM_ARM_VCPU_INIT(KVM_ARM_VCPU_SVE), after which
> vector length may then be configured but the configurably sized floating
> point registers are inaccessible until finalized with a call to
> KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE) after which the configurably sized
> registers can be accessed.
> 
...
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/virt/kvm/api.rst | 117 +++++++++++++++++++++++++++++------------
>  1 file changed, 82 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 6aa40ee05a4a..71f46b342641 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst

> @@ -2600,12 +2600,12 @@ Specifically:
>    0x6020 0000 0010 00d5 FPCR        32  fp_regs.fpcr
>  ======================= ========= ===== =======================================
>  
> -.. [1] These encodings are not accepted for SVE-enabled vcpus.  See
> -       :ref:`KVM_ARM_VCPU_INIT`.
> +.. [1] These encodings are not accepted for SVE enabled vcpus.  See

                                               SVE-enabled
was good.

> +       :ref:`KVM_ARM_VCPU_INIT`.  They are also not accepted when SME is
> +       enabled without SVE and the vcpu is in streaming mode.
>  

> @@ -2665,19 +2675,25 @@ follows::
>  	/* Vector length vq * 16 bytes not supported */
>  
>  .. [2] The maximum value vq for which the above condition is true is
> -       max_vq.  This is the maximum vector length available to the guest on
> -       this vcpu, and determines which register slices are visible through
> -       this ioctl interface.
> +       max_vq.  This is the maximum vector length currently available to
> +       the guest on this vcpu, and determines which register slices are
> +       visible through this ioctl interface.
> +
> +       If SME is supported then the max_vq used for the Z and P registers
> +       then while SVCR.SM is 1 this vector length will be the maximum SME

I'm having trouble parsing the 2 lines above.

> +       vector length available for the guest, otherwise it will be the
> +       maximum SVE vector length available.
>  
>  (See Documentation/arch/arm64/sve.rst for an explanation of the "vq"
>  nomenclature.)
>  

> @@ -3520,7 +3537,7 @@ Possible features:
>  	        initial value of this pseudo-register indicates the best set of
>  	        vector lengths possible for a vcpu on this host.
>  
> -	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
> +	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC}):

		Why the inserted '}', please?

>  
>  	      - KVM_RUN and KVM_GET_REG_LIST are not available;
>  
> @@ -3533,11 +3550,40 @@ Possible features:
>  	        KVM_SET_ONE_REG, to modify the set of vector lengths available
>  	        for the vcpu.
>  
> -	   * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_SVE):
> +	   * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
>  
>  	      - the KVM_REG_ARM64_SVE_VLS pseudo-register is immutable, and can
>  	        no longer be written using KVM_SET_ONE_REG.
>  
> +	- KVM_ARM_VCPU_SME: Enables SME for the CPU (arm64 only).
> +	  Depends on KVM_CAP_ARM_SME.
> +	  Requires KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):
> +
> +	   * After KVM_ARM_VCPU_INIT:
> +
> +	      - KVM_REG_ARM64_SME_VLS may be read using KVM_GET_ONE_REG: the
> +	        initial value of this pseudo-register indicates the best set of
> +	        vector lengths possible for a vcpu on this host.
> +
> +	   * Before KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC}):

	ditto: inserted '}'

> +
> +	      - KVM_RUN and KVM_GET_REG_LIST are not available;
> +
> +	      - KVM_GET_ONE_REG and KVM_SET_ONE_REG cannot be used to access
> +	        the scalable architectural SVE registers
> +	        KVM_REG_ARM64_SVE_ZREG(), KVM_REG_ARM64_SVE_PREG() or
> +	        KVM_REG_ARM64_SVE_FFR, the matrix register
> +		KVM_REG_ARM64_SME_ZA() or the LUT register KVM_REG_ARM64_ZT();
> +
> +	      - KVM_REG_ARM64_SME_VLS may optionally be written using
> +	        KVM_SET_ONE_REG, to modify the set of vector lengths available
> +	        for the vcpu.
> +
> +	   * After KVM_ARM_VCPU_FINALIZE(KVM_ARM_VCPU_VEC):

-- 
~Randy


