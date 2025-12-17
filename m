Return-Path: <linux-kselftest+bounces-47625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A3CC5A5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 01:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EB363002D38
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 00:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7562236FD;
	Wed, 17 Dec 2025 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRrc1Bgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580341D5CF2;
	Wed, 17 Dec 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765933042; cv=none; b=UPxtd6O2ZfkzflmiHVCWDahmWx7tNa8TmROSjbPByocYrTm4CqiKyTTTui35EK5AEitFFrOPBqtG7udNBWb7kZrPfSk/4V/X+A+7ZfQzALLtxuk60rT2/G582aLX9d9myy/Md5VszMe+SnBvWg78dZmNGj/1ZCbIKVqWgIFXPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765933042; c=relaxed/simple;
	bh=z/6R4VG7TSlEesI3ViMverTeFsRJZ0O4JC2zjpfP2Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpcXxrjWhpdLJigrMsiKeEDcT+PU4Xhrx734YDay95Vi3SuBTRYDNyK67B0wxiAb/tj0tc5u8lXfe0p7dL1edGNyA154CkMK0P4y4Ss7WGqrEnAiAjh+T4W9y2IZUEw5+MnzhuWEror/NTlSSxLsNq7/aN6DTsbMfM2WO8FAN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRrc1Bgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E8BC4CEF1;
	Wed, 17 Dec 2025 00:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765933041;
	bh=z/6R4VG7TSlEesI3ViMverTeFsRJZ0O4JC2zjpfP2Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRrc1Bgy2SxAbkikgt/whkMk/lJo1AAfKhN2dGFMCLOJ3YBkBoz4vh5jprB7HPVhh
	 k3rgpO5yQu48UDdQFC6U+yUh1g1eDYQpMDVqIahRxzZn7W3Dn388xnfFvvvqgeeXQL
	 36Dl/4m5zU/b36HkromCRw+KNtP/7MRpLe6HbO3smygG3aAbShDZLRGUHmRURzge4N
	 LWD/8M0g+HPPzo7ok5wbyTPiBOKp8QrB1kjaaDMjuIlUDSudc9rZU4A39wMrIz2euG
	 Z5oJUkxEKac3d6wMFieFYAsyWkzVWhRTDF+7HeMhA9zuCdByVavMEOp5Q2NnLwK5bH
	 ybv1b3lbSRRnA==
Date: Tue, 16 Dec 2025 16:57:19 -0800
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
Subject: Re: [PATCH v5 18/24] KVM: arm64: Enforce PMU event filter at
 vcpu_load()
Message-ID: <aUH_7yYZsmFlRvEc@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-19-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-19-coltonlewis@google.com>

Re-reading this patch...

On Tue, Dec 09, 2025 at 08:51:15PM +0000, Colton Lewis wrote:
> The KVM API for event filtering says that counters do not count when
> blocked by the event filter. To enforce that, the event filter must be
> rechecked on every load since it might have changed since the last
> time the guest wrote a value.

Just directly state that this is guarding against userspace programming
an unsupported event ID.

> +static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
> +{
> +	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
> +	u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
> +		ARMV8_PMU_EXCLUDE_EL1;
> +	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
> +	u8 i;
> +	u64 val;
> +	u64 evsel;
> +
> +	if (!pmu)
> +		return;
> +
> +	for (i = 0; i < pmu->hpmn_max; i++) {

Iterate the bitmask of counters and you'll handle the cycle counter 'for
free'.

<snip>

> +		val = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
> +		evsel = val & kvm_pmu_event_mask(vcpu->kvm);
> +
> +		if (vcpu->kvm->arch.pmu_filter &&
> +		    !test_bit(evsel, vcpu->kvm->arch.pmu_filter))
> +			val |= evtyper_set;
> +
> +		val &= ~evtyper_clr;
> +		write_pmevtypern(i, val);

</snip>

This all needs to be shared with writethrough_pmevtyper() instead of
open-coding the same thing.

Thanks,
Oliver

