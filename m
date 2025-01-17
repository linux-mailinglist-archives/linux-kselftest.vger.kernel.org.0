Return-Path: <linux-kselftest+bounces-24715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB511A14E85
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47E1168959
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC751FCFFC;
	Fri, 17 Jan 2025 11:34:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2941D8E12;
	Fri, 17 Jan 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113663; cv=none; b=T48bTB/BrpMPJY3BX05QDBcXgGkG9t9JqvV3JV59s9WB/8xysnVZLl7TF87nuU96++5gqRMZXzLmbJNDnwasL1+jXcrsccRVBZU3UG4DJth2Q1shjiqbp265Y7a84CfmT1knn1ycUbwgtysm2gLULW+Qkn0eDxafPNJBfAnV+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113663; c=relaxed/simple;
	bh=LAUrUrC3uCCxizrAG4Vg1PHnwSUsUPhIm+o7hM2izr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2FqMhqWXJALlbOT5X0pGz9AxXhCpGfeMlZetEcLTAfLuvScpnwKvhno1kQQXppRQjdqq6+slIJ6OwSiw7kmmQVgdyweQ2AZeME1WtIOa/kfYgrmm3eHbQAWhayabqcWMDkRaQnXHuixoIlFHl3sXBDnbn2I9b4TKJ0E1DFgbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4919C1476;
	Fri, 17 Jan 2025 03:34:48 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82BEA3F73F;
	Fri, 17 Jan 2025 03:34:16 -0800 (PST)
Date: Fri, 17 Jan 2025 11:34:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 09/27] KVM: arm64: Factor SVE guest exit handling
 out into a function
Message-ID: <Z4pAMaEYvdLpmbg2@J2N7QTR9R3>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
 <20241220-kvm-arm64-sme-v3-9-05b018c1ffeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220-kvm-arm64-sme-v3-9-05b018c1ffeb@kernel.org>

On Fri, Dec 20, 2024 at 04:46:34PM +0000, Mark Brown wrote:
> The SVE portion of kvm_vcpu_put() is quite large, especially given the
> comments required.  When we add similar handling for SME the function
> will get even larger, in order to keep things managable factor the SVE
> portion out of the main kvm_vcpu_put().

While investigating some problems with SVE I spotted a latent bug in
this area where I suspect the fix will conflict with / supersede this
rework. Details below; IIUC the bug was introduced in commit:

  8c8010d69c132273 ("KVM: arm64: Save/restore SVE state for nVHE")

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/fpsimd.c | 67 +++++++++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 09b65abaf9db60cc57dbc554ad2108a80c2dc46b..3c2e0b96877ac5b4f3b9d8dfa38975f11b74b60d 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -151,6 +151,41 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static void kvm_vcpu_put_sve(struct kvm_vcpu *vcpu)
> +{
> +	u64 zcr;
> +
> +	if (!vcpu_has_sve(vcpu))
> +		return;
> +
> +	zcr = read_sysreg_el1(SYS_ZCR);
> +
> +	/*
> +	 * If the vCPU is in the hyp context then ZCR_EL1 is loaded
> +	 * with its vEL2 counterpart.
> +	 */
> +	__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr;
> +
> +	/*
> +	 * Restore the VL that was saved when bound to the CPU, which
> +	 * is the maximum VL for the guest. Because the layout of the
> +	 * data when saving the sve state depends on the VL, we need
> +	 * to use a consistent (i.e., the maximum) VL.  Note that this
> +	 * means that at guest exit ZCR_EL1 is not necessarily the
> +	 * same as on guest entry.
> +	 *
> +	 * ZCR_EL2 holds the guest hypervisor's VL when running a
> +	 * nested guest, which could be smaller than the max for the
> +	 * vCPU. Similar to above, we first need to switch to a VL
> +	 * consistent with the layout of the vCPU's SVE state. KVM
> +	 * support for NV implies VHE, so using the ZCR_EL1 alias is
> +	 * safe.
> +	 */
> +	if (!has_vhe() || (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
> +		sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
> +				       SYS_ZCR_EL1);
> +}
> +
>  /*
>   * Write back the vcpu FPSIMD regs if they are dirty, and invalidate the
>   * cpu FPSIMD regs so that they can't be spuriously reused if this vcpu
> @@ -179,38 +214,10 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
>  	}

A little before this context, kvm_arch_vcpu_put_fp() calls
local_irq_save(), which indicates that IRQs can be taken before this
point, which is deeply suspicious.

If IRQs are enabled, then it's possible to take an IRQ and potentially
run a softirq handler which uses kernel-mode NEON. That means
kernel_neon_begin() will try to save the live FPSIMD/SVE/SME state via
fpsimd_save_user_state(), using the live value of ZCR_ELx.LEN, which would not
be correct per the comment.

Looking at kvm_arch_vcpu_ioctl_run(), the relevant logic is:

	vcpu_load(vcpu); // calls kvm_arch_vcpu_load_fp()

	while (ret > 0) {
		preempt_disable();
		local_irq_disable();

		kvm_arch_vcpu_ctxflush_fp();
		ret = kvm_arm_vcpu_enter_exit(vcpu);
		kvm_arch_vcpu_ctxsync_fp(vcpu);

		local_irq_enable();
		preempt_enable();
	}

	vcpu_put(vcpu); // calls kvm_arch_vcpu_put_fp()

... and the problem can occur at any point after the vCPU has run where IRQs
are enabled, i.e, between local_irq_enable() and either local_irq_disable() or
vcpu_put()'s call to kvm_arch_vcpu_put_fp().

Note that kernel_neon_begin() calls:

	fpsimd_save_user_state();
	...
	fpsimd_flush_cpu_state();

... and fpsimd_save_user_state() will see that the SVE VL is wrong:

	if (WARN_ON(sve_get_vl() != vl)) {
		force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
		return;
	}

... pending a SIGKILL for the VMM thread without saving the vCPU's state
before unbinding the live state via fpsimd_flush_cpu_state(), which'll
set TIF_FOREIGN_FPSTATE.

AFAICT it's possible to re-enter the vCPU after that happens, whereupon
stale vCPU FPSIMD/SVE state will be restored. Upon return to userspace
the SIGKILL will be delivered, killing the VMM.

As above, it looks like that's been broken since the nVHE SVE
save/restore was introduced in commit:

  8c8010d69c132273 ("KVM: arm64: Save/restore SVE state for nVHE")

The TL;DR summary is that it's not sufficient for kvm_arch_vcpu_put_fp()
to fix up ZCR_ELx. Either:

* That needs to be fixed up while IRQs are masked, e.g. by
  saving/restoring the host and guest ZCR_EL1 and/or ZCR_ELx values in
  kvm_arch_vcpu_ctxflush_fp() and kvm_arch_vcpu_ctxsync_fp()

* The lazy save logic in fpsimd_save_user_state() needs to handle KVM
  explicitly, saving the guest's ZCR_EL1 and restoring the host's
  ZCR_ELx.

I think we need to fix that before we extend this logic for SME.

Mark.

>  
>  	if (guest_owns_fp_regs()) {
> -		if (vcpu_has_sve(vcpu)) {
> -			u64 zcr = read_sysreg_el1(SYS_ZCR);
> -
> -			/*
> -			 * If the vCPU is in the hyp context then ZCR_EL1 is
> -			 * loaded with its vEL2 counterpart.
> -			 */
> -			__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr;
> -
> -			/*
> -			 * Restore the VL that was saved when bound to the CPU,
> -			 * which is the maximum VL for the guest. Because the
> -			 * layout of the data when saving the sve state depends
> -			 * on the VL, we need to use a consistent (i.e., the
> -			 * maximum) VL.
> -			 * Note that this means that at guest exit ZCR_EL1 is
> -			 * not necessarily the same as on guest entry.
> -			 *
> -			 * ZCR_EL2 holds the guest hypervisor's VL when running
> -			 * a nested guest, which could be smaller than the
> -			 * max for the vCPU. Similar to above, we first need to
> -			 * switch to a VL consistent with the layout of the
> -			 * vCPU's SVE state. KVM support for NV implies VHE, so
> -			 * using the ZCR_EL1 alias is safe.
> -			 */
> -			if (!has_vhe() || (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
> -				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
> -						       SYS_ZCR_EL1);
> -		}
> +		kvm_vcpu_put_sve(vcpu);
>  
>  		/*
> -		 * Flush (save and invalidate) the fpsimd/sve state so that if
> +		 * Flush (save and invalidate) the FP state so that if
>  		 * the host tries to use fpsimd/sve, it's not using stale data
>  		 * from the guest.
>  		 *
> 
> -- 
> 2.39.5
> 
> 

