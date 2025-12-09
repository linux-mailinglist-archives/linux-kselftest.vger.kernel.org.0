Return-Path: <linux-kselftest+bounces-47346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB39CB15A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 23:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0055330122E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 22:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DC92F691D;
	Tue,  9 Dec 2025 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK65ZiVL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1A2DE6FA;
	Tue,  9 Dec 2025 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765320723; cv=none; b=M0oAmm7osRWG7XIzViKYhNxc3CxWuyRhC6hk2mRdv4D9XBMmWOEQcTGNw1MBMcLg2dIBtvNEoAe2nPrqg8n/5kW6eJzWdYBbDlxRathvdlWOX20WwRYh65N3woL3S/ZiIxD6v6WBEeFwQB/WBPahojw1kbRs4b0CFqmnZxJHXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765320723; c=relaxed/simple;
	bh=rH4jIugTLj/MmCntl4IsivPRYzz2+X9BI1dkt+tZUAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDdM+fz3x6L1a4xfLILudvGghOWgjALqLXwpaZrOEidMdJtQlqVXUAoVSGpqtIXQ5CfbnQk/ZzUiL//J42YnLAIlWjyZYqqQvUqcgN4u163kQkckO7EG7eQt6FVAa3Lb3BruqswBBlRbd23F6xrxtcHiLMxsCkG2j1YABxm4n2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK65ZiVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7621FC4CEF5;
	Tue,  9 Dec 2025 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765320722;
	bh=rH4jIugTLj/MmCntl4IsivPRYzz2+X9BI1dkt+tZUAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gK65ZiVLcISjQpaWlozvWZ/pB9Rf8c/OBAmSq5WFPeLuhkNPfGcZ49r6ridSEvAdE
	 rsprjey86yb+rAP/iGqpUfqxIw+yB/WdgcEZDIc+EOh2tyi2vgZMrIct++Bkn3zCi+
	 3KaaCqCRS+H6v7E3PZEbkdfjMmzut0GL9P4cYsiyOB3xYSKA908I32jqPur/CMLGEP
	 WAHCW48J+RNnzQAHbv6QmFw+wzfPco2ATYN69Ip3r+Fu9wjPmRodlDjYIN2+vH3qX4
	 2sfYtr+rtP2yniLQJhVtUe3bf8VDM1rFkByxdFzEgGMRF3fJAMjL2Zqq/sX+vC+ltX
	 h55APJ6d8k38A==
Date: Tue, 9 Dec 2025 14:52:01 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 21/24] KVM: arm64: Inject recorded guest interrupts
Message-ID: <aTioEWHu0ZbFCjR6@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-22-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-22-coltonlewis@google.com>

In no situation should KVM be injecting a "recorded" IRQ. The overflow
condition of the PMU is well defined in the architecture and we should
implement *exactly* that.

On Tue, Dec 09, 2025 at 08:51:18PM +0000, Colton Lewis wrote:
> +/**
> + * kvm_pmu_part_overflow_status() - Determine if any guest counters have overflowed
> + * @vcpu: Ponter to struct kvm_vcpu
> + *
> + * Determine if any guest counters have overflowed and therefore an
> + * IRQ needs to be injected into the guest.
> + *
> + * Return: True if there was an overflow, false otherwise
> + */
> +bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
> +	u64 mask = kvm_pmu_guest_counter_mask(pmu);
> +	u64 pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
> +	u64 pmint = read_pmintenset();
> +	u64 pmcr = read_pmcr();

How do we know that the vPMU has been loaded on the CPU at this point?

> +
> +	return (pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint);
> +}

I'd rather reuse kvm_pmu_overflow_status(), relying on the accessors to
abstract away the implementation / location of the guest PMU context.

Thanks,
Oliver

