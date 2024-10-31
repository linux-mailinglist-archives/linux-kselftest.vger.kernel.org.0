Return-Path: <linux-kselftest+bounces-21240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01269B81DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E17B22A4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251781C579D;
	Thu, 31 Oct 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxtrIMd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFB1C2307;
	Thu, 31 Oct 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397352; cv=none; b=WMs6QDiELYJmBs9zb7HqpC/kP0gJFXySOzYKxb00OD37dQCdJoA6TQLRpOTaeWTWrcT4x6i7GuwQtXV7VW+vAOSFKGveSMjaYNOzR8hLzT8S4K1Ut4Ghe/bhTqkJ0FrIxxfR75mQZl2M6ldzJX9w3rWY+EQCGi+CPx++lCGe2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397352; c=relaxed/simple;
	bh=8V6WjMhYQJzxJvg3MLaPnkfaVd6CgTlD3ZztDnYEu9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKN6rq1PtQsLWiUR/vwbHXhwr6fu6c0GkD5hK/QAu7dxqzx75AT1csfzScZKhNTZk5c7aH6ebzbZ8TggL2kRkrnqhZwwxNUkWK2geaRprqM29MS6pcyeizd6iXa673AsWI6kU8GlCzc/cuZ1pkhSyNYglv2Kp5AcKH5ff4sJAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxtrIMd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44559C4CECF;
	Thu, 31 Oct 2024 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730397351;
	bh=8V6WjMhYQJzxJvg3MLaPnkfaVd6CgTlD3ZztDnYEu9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxtrIMd6GFd5JCnKFrOG0o96UCIqyBOjIWTKEsP07bxOm6iGUOD2J9FTAMRqzbhX2
	 3DfjU6PUIr7BmaiNIjuAXM7vpuKhyCUUaRoP+hcKy147qnuAgh9OQhj3ehKNJAQlXh
	 6mioUzvUYm+O56TEaHCP8kq+RlC9kvL1Hf3mpDNE5rjwlw6Ex4kRhhuH34GBvsBri9
	 OdROmHap8VNYG9QHigfFciOFzgse+iy54UOlv0CeUOVawSbEtshyAEmTb3FH2VvDAR
	 uvP+RacWFQbU0av2qHBrNXjtiVEqtzxGEtyqR/mcR6rLNyap7ehYSNj331qUWj5iiq
	 r2qaA9ni5LMfQ==
Date: Thu, 31 Oct 2024 18:55:43 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for
 hibernate
Message-ID: <ZyPEn4qhaYyYqrzk@lpieralisi>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019172459.2241939-7-dwmw2@infradead.org>

On Sat, Oct 19, 2024 at 06:15:47PM +0100, David Woodhouse wrote:

[...]

> +#ifdef CONFIG_HIBERNATION
> +static int psci_sys_hibernate(struct sys_off_data *data)
> +{
> +	/*
> +	 * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
> +	 * and is supported by hypervisors implementing an earlier version
> +	 * of the pSCI v1.3 spec.
> +	 */

It is obvious but with this patch applied a host kernel would start executing
SYSTEM_OFF2 too if supported in firmware to hibernate, it is not a hypervisor
only code path.

Related to that: is it now always safe to override

commit 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and poweroff")

for hibernation ? It is not very clear to me why overriding PSCI for
poweroff was the right thing to do - tried to follow that patch history but
the question remains (it is related to UpdateCapsule() but I don't know
how that applies to the hibernation use case).

As far as type == 0 is concerned:

I don't think the issue here is really PSCI 1.3 ALP1 vs PSCI 1.3 Issue
F.b, by reading the PSCI 1.3 Issue F.b specs (note (e) page 96) it looks
like there was a (superseded) PSCI 1.3 Issue F (september 2024 -
superseded in October 2024 - just reading the specs timeline) that allowed an
implementation to return INVALID_PARAMETERS if type == 0 - there should
be no firwmare out there that followed it - it was short lived.

Lorenzo

> +	if (system_entering_hibernation())
> +		invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2),
> +			       0 /*PSCI_1_3_OFF_TYPE_HIBERNATE_OFF*/, 0, 0);
> +	return NOTIFY_DONE;
> +}
> +
> +static int __init psci_hibernate_init(void)
> +{
> +	if (psci_system_off2_hibernate_supported) {
> +		/* Higher priority than EFI shutdown, but only for hibernate */
> +		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +					 SYS_OFF_PRIO_FIRMWARE + 2,
> +					 psci_sys_hibernate, NULL);
> +	}
> +	return 0;
> +}
> +subsys_initcall(psci_hibernate_init);
> +#endif
> +
>  static int psci_features(u32 psci_func_id)
>  {
>  	return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
> @@ -364,6 +392,7 @@ static const struct {
>  	PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
>  	PSCI_ID(1_1, MEM_PROTECT),
>  	PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
> +	PSCI_ID_NATIVE(1_3, SYSTEM_OFF2),
>  };
>  
>  static int psci_debugfs_read(struct seq_file *s, void *data)
> @@ -525,6 +554,18 @@ static void __init psci_init_system_reset2(void)
>  		psci_system_reset2_supported = true;
>  }
>  
> +static void __init psci_init_system_off2(void)
> +{
> +	int ret;
> +
> +	ret = psci_features(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2));
> +	if (ret < 0)
> +		return;
> +
> +	if (ret & PSCI_1_3_OFF_TYPE_HIBERNATE_OFF)
> +		psci_system_off2_hibernate_supported = true;
> +}
> +
>  static void __init psci_init_system_suspend(void)
>  {
>  	int ret;
> @@ -655,6 +696,7 @@ static int __init psci_probe(void)
>  		psci_init_cpu_suspend();
>  		psci_init_system_suspend();
>  		psci_init_system_reset2();
> +		psci_init_system_off2();
>  		kvm_init_hyp_services();
>  	}
>  
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e35829d36039..1f87aa01ba44 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -685,8 +685,11 @@ static void power_down(void)
>  		}
>  		fallthrough;
>  	case HIBERNATION_SHUTDOWN:
> -		if (kernel_can_power_off())
> +		if (kernel_can_power_off()) {
> +			entering_platform_hibernation = true;
>  			kernel_power_off();
> +			entering_platform_hibernation = false;
> +		}
>  		break;
>  	}
>  	kernel_halt();
> -- 
> 2.44.0
> 

