Return-Path: <linux-kselftest+bounces-47341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B9CB1369
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B35C30213FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7393B31AAA6;
	Tue,  9 Dec 2025 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM8UojGj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857431AA98;
	Tue,  9 Dec 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316274; cv=none; b=t62BmCvqeg6IT1EK5nfHxEvHl/mOA4/YAR0sRWlwMl1GwqBY1rb1gDbDp/oPE4zaWfRUW1thaUS13eWyjuEF0tyUMokeCgogU/W4XbiJ+TBHgyS8x1Gs7h5xX6igLsKAdO3gm3vW6G7rbmnOd7m+0n6mB+ZdW9dnw0qEszGR3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316274; c=relaxed/simple;
	bh=XR5vtOZeRkf01d/Ct5rjvNJD3R18U5Yi718NBSanjc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCk7LH778/KmmnVMtbBk01dacceEx5hn8KQHvE0hlvfOghnrzgvTkx97+qBICOkcybAH/OP38AKGTc/6Q5mwGZyPvQmaN3plYMw71SFjnO5muPkx8piYaLKypqklrb6auOkdofrcNhI2O5guKEG2By9PN8oPU91cwRThBM/7430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM8UojGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F8C4CEF5;
	Tue,  9 Dec 2025 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765316273;
	bh=XR5vtOZeRkf01d/Ct5rjvNJD3R18U5Yi718NBSanjc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM8UojGjllf3TBTDAJ88lf1uWoTb4CAWsA2qO0WoLsjOJLDUCQcGOdBp6LpWZ/MtE
	 GAptIFSFYRqbNnqlbw8M/rPdHN1t+UuB4x2Chs6yBAwtC1k4Dg0gk1EzWR8NxrUx0o
	 MXEgBFNivOHwxdUn5qe4HXzdwCj0cA85pfrxUdis9PpjwANGpSKxfMv8gfZqbrwtyg
	 ER4ORjxaiZD+PYVjmFy+y6oqBC8mQ2lggjftYiW8UZlIABkPLdRarQD+oZ3NLYb41O
	 hfPKsUZH0c1xPijUuhtcP1hCcxcFwb6UpoRZsOrJIr9Eyi//DtUJkRoR/QZXO275Ke
	 X9f3W4lQVQcBg==
Date: Tue, 9 Dec 2025 13:37:52 -0800
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
Subject: Re: [PATCH v5 16/24] KVM: arm64: Account for partitioning in
 PMCR_EL0 access
Message-ID: <aTiWsAvK9krnEw7V@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-17-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-17-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:13PM +0000, Colton Lewis wrote:
> Make sure reads and writes to PMCR_EL0 conform to additional
> constraints imposed when the PMU is partitioned.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/kvm/pmu.c      | 2 +-
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index 1fd012f8ff4a9..48b39f096fa12 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -877,7 +877,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
>  u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
>  {
>  	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
> -	u64 n = vcpu->kvm->arch.nr_pmu_counters;
> +	u64 n = kvm_pmu_guest_num_counters(vcpu);

Why can't the value of vcpu->kvm->arch.nr_pmu_counters be trusted?

> @@ -1360,7 +1360,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
>  	 */
>  	if (!kvm_vm_has_ran_once(kvm) &&
>  	    !vcpu_has_nv(vcpu)	      &&
> -	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
> +	    new_n <= kvm_pmu_hpmn(vcpu))
>  		kvm->arch.nr_pmu_counters = new_n;

This is the legacy UAPI for setting the number of PMU counters by
writing to PMCR_EL0.N.

The 'partitioned' implementation should take a dependency on the
SET_NR_COUNTERS attribute and reject attempts to change the value of
PMCR_EL0.N. Just like nested.

Thanks,
Oliver

