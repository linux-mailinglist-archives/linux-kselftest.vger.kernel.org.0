Return-Path: <linux-kselftest+bounces-19108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E59916CA
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 14:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02340B218DB
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB44145FEB;
	Sat,  5 Oct 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksZ99L75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569B231C81;
	Sat,  5 Oct 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131772; cv=none; b=qmLsb/IbKZZ8xSoUk7B7cclEsmBU2YeOe2/wJ+VzgyCsjXKb53Ly5IfxRMUPvO+qADssej0NUDr2UnX4jeVySl8nPFf5Xiw9D1a97rl0YgZro8pENmhVNQsqpNobJHvLiXok+d/DZNj2GHEFAzRS3ezVR2UjuYaLcVkrSGjR0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131772; c=relaxed/simple;
	bh=anOh4F7gNSzxko+OyM2NPOf1gcoYvFAGA4IXXYgPM9I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyvvL1XaMBa5gpRlzqP6FaDM7wWBTlNr9mffZdX7+vsY1liMFadZ6KOjhvEco4D+wwHOt9wp2XqILQxjJ7bh/ZMu2uzHsmuyT8iFvcpWKb9eDVoaGYy1oItpzdVK6ldA+uP6EVBx5wExGMT93jMjsHdpWIDy4DfEZQAVQu18yBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksZ99L75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9FAC4CEC2;
	Sat,  5 Oct 2024 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728131772;
	bh=anOh4F7gNSzxko+OyM2NPOf1gcoYvFAGA4IXXYgPM9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ksZ99L7558xn1xd5cBUQFIK78d80OfgwZn+FQ9j0/XgNJqScS72Va7VGSAzZ0pJRB
	 /RI6dBgMx9lQqdItsJph2P5tj+Y21mwu+IZZ4uG0clSeI6EzIGSCt/Dv4A+/hH4mnH
	 pDvUe70RrhWE8Fns1GyXQE8cuC0a2nlKhod7vJeC7ZVpK7p1n+po5RIVch2RqbVQJW
	 6QaAv8Dfl1QwTCcTkRCvhFPlKlDT+17/NDTu62O8/VmpDufTSVrNzBJPc0eo3b1per
	 qemu9ky9ul5sXHul+VdFWA7h1sHo7Kj+Kn1myE1JyBpNjN22gBLQop9B0ps937NVwv
	 fgYC1CI3th14Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sx414-000bEl-8D;
	Sat, 05 Oct 2024 13:36:10 +0100
Date: Sat, 05 Oct 2024 13:36:09 +0100
Message-ID: <87h69qvi9y.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 4/5] KVM: arm64: Set PSTATE.EXLOCK when entering an exception
In-Reply-To: <20241005-arm64-gcs-v14-4-59060cd6092b@kernel.org>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
	<20241005-arm64-gcs-v14-4-59060cd6092b@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 05 Oct 2024 11:37:31 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> As per DDI 0487 RWTXBY we need to manage PSTATE.EXLOCK when entering an
> exception, when the exception is entered from a lower EL the bit is cleared
> while if entering from the same EL it is set to GCSCR_ELx.EXLOCKEN.
> Implement this behaviour in enter_exception64().
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/uapi/asm/ptrace.h |  2 ++
>  arch/arm64/kvm/hyp/exception.c       | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 0f39ba4f3efd4a8760f0fca0fbf1a2563b191c7d..9987957f4f7137bf107653b817885bb976853a83 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -37,6 +37,7 @@
>  #define PSR_MODE_EL3t	0x0000000c
>  #define PSR_MODE_EL3h	0x0000000d
>  #define PSR_MODE_MASK	0x0000000f
> +#define PSR_EL_MASK	0x0000000c
>  
>  /* AArch32 CPSR bits */
>  #define PSR_MODE32_BIT		0x00000010
> @@ -56,6 +57,7 @@
>  #define PSR_C_BIT	0x20000000
>  #define PSR_Z_BIT	0x40000000
>  #define PSR_N_BIT	0x80000000
> +#define PSR_EXLOCK_BIT 0x400000000
>  
>  #define PSR_BTYPE_SHIFT		10
>  
> diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
> index 424a5107cddb5e1cdd75ef3581adef03aaadabb7..0d41b9b75cf83250b2c0d20cd82c153869efb0e4 100644
> --- a/arch/arm64/kvm/hyp/exception.c
> +++ b/arch/arm64/kvm/hyp/exception.c
> @@ -160,6 +160,16 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
>  	// PSTATE.BTYPE is set to zero upon any exception to AArch64
>  	// See ARM DDI 0487E.a, pages D1-2293 to D1-2294.
>  
> +	// PSTATE.EXLOCK is set to 0 upon any exception to a higher
> +	// EL, or to GCSCR_ELx.EXLOCKEN for an exception to the same
> +	// exception level.  See ARM DDI 0487 RWTXBY, D.1.3.2 in K.a.
> +	if (kvm_has_gcs(vcpu->kvm) &&
> +	    (target_mode & PSR_EL_MASK) == (mode & PSR_EL_MASK)) {
> +		u64 gcscr = __vcpu_read_sys_reg(vcpu, GCSCR_EL1);

No, please. This only works by luck when a guest has AArch32 EL0, and
creates more havoc on a NV guest. In general, this PSR_EL_MASK creates
more problem than anything else, and doesn't fit the rest of the code.

So this needs to:
- explicitly only apply to exceptions from AArch64
- handle exception from EL2, since this helper already deals with that

The latter point of course means introducing GCSCR_EL2 (and everything
that depends on it, such as the trap handling).

	M.

-- 
Without deviation from the norm, progress is not possible.

