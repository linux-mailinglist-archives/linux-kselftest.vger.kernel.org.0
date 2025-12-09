Return-Path: <linux-kselftest+bounces-47345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A7CB155B
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 23:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E86D3022888
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 22:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6652F5320;
	Tue,  9 Dec 2025 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuTSPZND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248A2EF65C;
	Tue,  9 Dec 2025 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765320360; cv=none; b=XVn7uVubEa2/dy7/5APDYKmT1B+7LW/+pqg95H6SU6cKImHOTxb1Pw/ohgCXi8rhIDQA0Z+GcAGHtH6AXrcgDIaLj7k4UBOZW6y+17d7Z/YVOgM0vZDSJwd5PTnvqhl3+2rYtlmgkS4zpjJJAv5/cxuq23+2AStGaio4LkVdwnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765320360; c=relaxed/simple;
	bh=iHHcKj6J+hLbVPepNR0eVCr57chERxeAokcMcG6B2iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikSNzSvcuvObJVT9wn+505UI9mAJuhzvzmphaGi9/TzML+T6tX0ezmhs+S2Xc4C6FhBIAIL8dT85YsWBTkFQ7sxRY54cFRtD0WC0ugmMOenEVMMZJI4qCyZWLeD3IVjWvfAqBvTQ0mAsaPjWldO4D7J+dKrapOlMa3bxf49/rPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuTSPZND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE76C4CEF5;
	Tue,  9 Dec 2025 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765320358;
	bh=iHHcKj6J+hLbVPepNR0eVCr57chERxeAokcMcG6B2iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuTSPZNDN+0w+NDKNfvTF3iYbREiPDKKWuY6awdIf/3WojH3IKSQhYqT4IC8BHzx0
	 Y2+khZrBnXpw+v7qoCHmJg/vcGwkgol6jFF/GUmqTsir6XJ74sCfHx957taQd7HBi7
	 o6GKm0aGPNMOloQaQo1ERi+QvkEngEBFNYf4qfhKTuIFTsqnw+yj2ykHaN5dXgxNYm
	 gmeqZdx4GBBlzNjdGFe58TT+mGvzKPYalbu38R+EYnWp/Um5GYGOqk0uOI2sstY0qH
	 zBK44d+p2faai+9JS550B/UjAAxNkZ67Yd10z3SbotFhtt8/Ln3TLLtne00gRjuioJ
	 1w4mA/R4bRs6w==
Date: Tue, 9 Dec 2025 14:45:57 -0800
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
Subject: Re: [PATCH v5 20/24] perf: arm_pmuv3: Handle IRQs for Partitioned
 PMU guest counters
Message-ID: <aTimpRFfr9wI9Hw5@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-21-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-21-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:17PM +0000, Colton Lewis wrote:
> Because ARM hardware is not yet capable of direct interrupt injection

PPI injection, it can do LPIs just fine.

> @@ -961,6 +964,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  		 */
>  		perf_event_overflow(event, &data, regs);
>  	}
> +
> +	govf = pmovsr & kvm_pmu_guest_counter_mask(cpu_pmu);
> +
> +	if (kvm_pmu_is_partitioned(cpu_pmu) && govf)
> +		kvm_pmu_handle_guest_irq(govf);
> +

The state ownership of this whole interaction is very odd. I would much
rather that KVM have full ownership of the range of counters while the
guest is loaded. By that I mean the PMUv3 driver only clears overflows
on PMCs that it owns and KVM will do the same on the back of the IRQ.

Similarly, KVM should be leaving the "guest" range of counters in a
non-overflow condition at vcpu_put().

Thanks,
Oliver

