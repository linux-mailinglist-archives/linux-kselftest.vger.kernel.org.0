Return-Path: <linux-kselftest+bounces-26149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9EA2E554
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 08:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF221886CE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF21B3927;
	Mon, 10 Feb 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXBzap/g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE48F49
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172335; cv=none; b=aim/j0q7bvsn0nB/dz1p1S861Zru4yYp23iKHRYQiycV9CU3FmXZYrO6GzB9u2hLISlbNLlMoHkb6lq5jil/cq6kDIxaaMolkARgJm9qWKgFp/LdfJ6jec/vdHlZFBOSg2GuU7ImjPcHp8UudVIKRFbEknHxTT2AXzTVhRG4cps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172335; c=relaxed/simple;
	bh=WEi94AOxFT0BGKWJYlk93RgBEivYtkgEu7vcoa48KDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox5al1iCDLHiaVm9X8UgjoT+DuFMIHFCDh5ZXHRflbapFFDVeqt3pD0vy6d1pjYhT4fFi0Pd/RnYcJbSIaDgiTOWGKJaDDudWWqiA4KbIMdFQdwVoGbPMdFDSB/jF06Zj89sPCOxrWAmr0Z9S1SFCOzfK6uVDbunBBcGFH7Vdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXBzap/g; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 9 Feb 2025 23:25:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739172327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hwD1lIdtcJvdTFhSGkZrNjpxJv3lx+G0x/gy4Oqkqlg=;
	b=kXBzap/gTr4HWJcRXQDm7DOBGfeTNHMzoNaXlGUNiV7By6TX5/ld3/RKw3r36+uzamfZRI
	9kgaxEmEWNycuEOd4PYpqoSR5TDvsEOojoBeDhe2bivBUMSPju67z9EPUaf4pn2VbQBK1g
	p83LqS1ZQhg3kef6BQ6B20f6CBvi5hs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] perf: arm_pmuv3: Introduce module param to
 partition the PMU
Message-ID: <Z6mp4NeklzORJg5y@linux.dev>
References: <20250208020111.2068239-1-coltonlewis@google.com>
 <20250208020111.2068239-3-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208020111.2068239-3-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Colton,

On Sat, Feb 08, 2025 at 02:01:09AM +0000, Colton Lewis wrote:
> For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
> into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
> allowed, EL0 while counters HPMN..N are only accessible by EL2.
> 
> Introduce a module parameter in the PMUv3 driver to set this
> register. The name reserved_host_counters reflects the intent to
> reserve some counters for the host so the guest may eventually be
> allowed direct access to a subset of PMU functionality for increased
> performance.
> 
> Track HPMN and whether the pmu is partitioned in struct arm_pmu
> because KVM will need to know that to handle guests correctly.
> 
> While FEAT_HPMN0 does allow HPMN to be set to 0, this patch
> specifically disallows that case because it's not useful given the
> intention to allow guests access to their own counters.

Quite the contrary.

FEAT_HPMN0 is useful if userspace wants to provide a vPMU that has a
fixed cycle counter w/o event counters. Certain OSes refuse to boot
without it...

> static inline u32 read_mdcr(void)
> {
> 	return read_sysreg(HDCR);
> }
> 
> static inline void write_mdcr(u32 val)
> {
> 	write_sysreg(val, HDCR);
> }
> 

Hmm... While this fixes the 32bit compilation issues, it opens a new can
of worms.

VHE is a 64bit only feature, so you're *guaranteed* that these accessors
will undef (running at EL1).

> +static void armv8pmu_partition(u8 hpmn)
> +{
> +	u64 mdcr = armv8pmu_mdcr_read();
> +
> +	mdcr &= ~ARMV8_PMU_MDCR_HPMN;
> +	mdcr |= FIELD_PREP(ARMV8_PMU_MDCR_HPMN, hpmn);
> +	/* Prevent guest counters counting at EL2 */
> +	mdcr |= ARMV8_PMU_MDCR_HPMD;
> +
> +	armv8pmu_mdcr_write(mdcr);
> +}
> +

After giving this a read, I don't think the host PMU driver should care
about MDCR_EL2 at all. The only time that 'guest' events are loaded into
the PMU is between vcpu_load() / vcpu_put(), at which point *KVM* has
reconfigured MDCR_EL2.

I'm not sure if there's much involvement with the host PMU driver beyond
it pinky-swearing to only use the specified counters. KVM is what
actually will program HPMN.

That'd alleviate the PMU driver from having VHE awareness or caring
about MDCR_EL2.

-- 
Thanks,
Oliver

