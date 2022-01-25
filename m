Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8249B376
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 13:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382793AbiAYMBO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 07:01:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52880 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383938AbiAYL7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 06:59:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42BEF60FDD
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 11:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B72CC340E0;
        Tue, 25 Jan 2022 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643111944;
        bh=IPg/qMr3iQiCiOJxRRr9W47jGFe/BMY4StWDKsf7YfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6Zr0CU3Tdi/PxVqxfBq27R/ISizNCf26fIMHFR5mjMF4dMnUn1dKDM6iweVCXeQp
         OYUUfT49Sa2y33oiHV9W50c/ioa6pOZnS619pXa7B+rWUW3+OMjd2gDSAZuWQtxfeU
         FsGpd377PLuVKPFYpBRIqxgnBOO3QHwHifDRzwiz9OZy7v1U3SwARyZ5yea/8lhOB5
         nrrmJisow0yNRtVSfOANJiBQI40hFy0fv/pwM6mt+ic6ZS3ltaBOYAygaZXAsCoeAp
         DkqjRX1gFPXa0W05Gj4m6EL65UX4oHvZxIHqIImJjLEzOmd4qyAYlNQ8YAt+Gom3OU
         Wi34LLrcoguGw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nCKTW-002tXh-KF; Tue, 25 Jan 2022 11:59:02 +0000
Date:   Tue, 25 Jan 2022 11:59:02 +0000
Message-ID: <87wnio6n7d.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v8 26/38] KVM: arm64: Handle SME host state when running guests
In-Reply-To: <20220125001114.193425-27-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
        <20220125001114.193425-27-broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, skhan@linuxfoundation.org, shuah@kernel.org, alan.hayward@arm.com, luis.machado@arm.com, Salil.Akerkar@arm.com, Basant.KumarDwivedi@arm.com, szabolcs.nagy@arm.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 25 Jan 2022 00:11:02 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> While we don't currently support SME in guests we do currently support it
> for the host system so we need to take care of SME's impact, including
> the floating point register state, when running guests. Simiarly to SVE
> we need to manage the traps in CPACR_RL1, what is new is the handling of
> streaming mode and ZA.
> 
> Normally we defer any handling of the floating point register state until
> the guest first uses it however if the system is in streaming mode FPSIMD
> and SVE operations may generate SME traps which we would need to distinguish
> from actual attempts by the guest to use SME. Rather than do this for the
> time being if we are in streaming mode when entering the guest we force
> the floating point state to be saved immediately and exit streaming mode,
> meaning that the guest won't generate SME traps for supported operations.
> 
> We could handle ZA in the access trap similarly to the FPSIMD/SVE state
> without the disruption caused by streaming mode but for simplicity
> handle it the same way as streaming mode for now.
> 
> This will be revisited when we support SME for guests (hopefully before SME
> hardware becomes available), for now it will only incur additional cost on
> systems with SME and even there only if streaming mode or ZA are enabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h |  1 +
>  arch/arm64/kvm/fpsimd.c           | 38 +++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 7dc85d5a6552..404b7358ba96 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -438,6 +438,7 @@ struct kvm_vcpu_arch {
>  #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
>  #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
>  #define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
> +#define KVM_ARM64_HOST_SME_ENABLED	(1 << 15) /* SME enabled for EL0 */
>  
>  #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
>  				 KVM_GUESTDBG_USE_SW_BP | \
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 338733ac63f8..cecaddb644ce 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -82,6 +82,26 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
>  
>  	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
>  		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
> +
> +	/*
> +	 * We don't currently support SME guests but if we leave
> +	 * things in streaming mode then when the guest starts running
> +	 * FPSIMD or SVE code it may generate SME traps so as a
> +	 * special case if we are in streaming mode we force the host
> +	 * state to be saved now and exit streaming mode so that we
> +	 * don't have to handle any SME traps for valid guest
> +	 * operations. Do this for ZA as well for now for simplicity.
> +	 */
> +	if (system_supports_sme()) {
> +		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
> +			vcpu->arch.flags |= KVM_ARM64_HOST_SME_ENABLED;
> +
> +		if (read_sysreg_s(SYS_SVCR_EL0) &
> +		    (SYS_SVCR_EL0_SM_MASK | SYS_SVCR_EL0_ZA_MASK)) {
> +			vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
> +			fpsimd_save_and_flush_cpu_state();
> +		}
> +	}
>  }
>  
>  void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
> @@ -129,6 +149,24 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
>  
>  	local_irq_save(flags);
>  
> +	/*
> +	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
> +	 * CPACR_EL1_DEFAULT and we need to reenable SME.
> +	 */
> +	if (has_vhe()) {
> +		if (system_supports_sme()) {

nit:	if (has_vhe() && system_supports_sme()) {

saves you one level of indentation.

> +			/* Also restore EL0 state seen on entry */
> +			if (vcpu->arch.flags & KVM_ARM64_HOST_SME_ENABLED)
> +				sysreg_clear_set(CPACR_EL1, 0,
> +						 CPACR_EL1_SMEN_EL0EN |
> +						 CPACR_EL1_SMEN_EL1EN);
> +			else
> +				sysreg_clear_set(CPACR_EL1,
> +						 CPACR_EL1_SMEN_EL0EN,
> +						 CPACR_EL1_SMEN_EL1EN);

I find the use of CPACR_EL1_SMEN in some cases and its individual bits
in some others pretty confusing. I understand that you have modelled
it after the SVE code, but maybe this is a mistake we don't need to
repeat. I'd be in favour of directly exposing the individual bits in
all cases.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
