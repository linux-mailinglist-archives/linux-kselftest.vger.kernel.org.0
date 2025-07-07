Return-Path: <linux-kselftest+bounces-36725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A1AFBB78
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 21:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2293B42033C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A6265CAA;
	Mon,  7 Jul 2025 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aobMN78g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347426560A
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915252; cv=none; b=fM4ahzVsqU8fV45Vqtsnt1eDo95PBm0SXhQsqXUFOa5GlRpvRZm9XEN02qs5VK3NZl/RCeAQ30sJmknsrm1TtWaYc/wBHuoCYhIQpUKFSFtnNYEUp4cwjzpIx0PH3sir6jkahlYk3XSL/XV+bTRz/XLqyMbRlgrRoT7p+QTp+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915252; c=relaxed/simple;
	bh=o1GC53yhWVrQvbtmbbwlkB9GbrHErAq0L3SeVcu/GvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIlqhzZGEfnGS12vlMeMU8tyKAeuY/5htGqP/Ns8ebisU9rvfeHRawLmZjOORhP7iKxik/gnu9kiBntKbQxTJ72hwXvfv+fUeaL/wLbBm90wsKEllblAnF1Dp9lN9mX53u0u6qORjTBW7AUPEgPfzc6yw3AgGGF+NkZSYp9Eu7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aobMN78g; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 7 Jul 2025 12:07:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751915238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jGaD8c3ubRcJrs9E7PPKpi1NHgV8be7gu6+Mc5pNTw=;
	b=aobMN78gUyxXzBZrku/l0hi14PBGY/TRhvSw5ZW677kY73Urv0Jo6skIl8SFHlE1+v7WLh
	HWODbBjgI3VI0Sd7XDIPDmZpD9eRkDhHBjm19CQeBICmRcbomFiKQW7gQFBIXMIZFDW2Ir
	oJoOWO0Vob31Jguq+jObCoOe5w83Kb0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 06/22] perf: arm_pmuv3: Introduce method to partition
 the PMU
Message-ID: <aGwa2DGJq3FyxyEK@linux.dev>
References: <20250626200459.1153955-1-coltonlewis@google.com>
 <20250626200459.1153955-7-coltonlewis@google.com>
 <aGv8arq8NgaRCu7h@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGv8arq8NgaRCu7h@J2N7QTR9R3>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 07, 2025 at 05:57:14PM +0100, Mark Rutland wrote:
> On Thu, Jun 26, 2025 at 08:04:42PM +0000, Colton Lewis wrote:
> > For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
> > counters into two ranges where counters 0..HPMN-1 are accessible by
> > EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
> > EL2.
> > 
> > Create module parameter reserved_host_counters to reserve a number of
> > counters for the host. This number is set at boot because the perf
> > subsystem assumes the number of counters will not change after the PMU
> > is probed.
> > 
> > Introduce the function armv8pmu_partition() to modify the PMU driver's
> > cntr_mask of available counters to exclude the counters being reserved
> > for the guest and record reserved_guest_counters as the maximum
> > allowable value for HPMN.
> > 
> > Due to the difficulty this feature would create for the driver running
> > at EL1 on the host, partitioning is only allowed in VHE mode. Working
> > on nVHE mode would require a hypercall for every counter access in the
> > driver because the counters reserved for the host by HPMN are only
> > accessible to EL2.
> 
> It would be good if we could elaborate on this last point. When exactly
> do we intend to configure HPMN (e.g. is that static, dynamic at
> load/put, or dynamic at finer granularity)?
> 
> I ask becuase it's not immediately clear to me how this would break nVHE
> without also breaking direct userspace access on VHE, unless we flip
> HPMN dynamically at load/put, and this is only broken in some transient
> windows on nVHE.

Agree that KVM's HPMN can only take effect between vcpu_load() /
vcpu_put().

The changelog isn't correct regarding the complications of nVHE, though.
In order to support a 'partitioned' PMU on nVHE we'd need to explicitly
disable guest counters on every exit and reset HPMN to place all
counters in the 'first range'. Unless someone has a use case for this
stuff on nVHE I'm not too bothered by the VHE-only limitation.

> > 
> > Signed-off-by: Colton Lewis <coltonlewis@google.com>
> > ---
> >  arch/arm/include/asm/arm_pmuv3.h   | 14 ++++++
> >  arch/arm64/include/asm/arm_pmuv3.h |  5 ++
> >  arch/arm64/include/asm/kvm_pmu.h   |  6 +++
> >  arch/arm64/kvm/Makefile            |  2 +-
> >  arch/arm64/kvm/pmu-part.c          | 23 ++++++++++
> 
> Maybe I'll contradict Oliver and Marc here (and whatever they say
> rules), but IMO it'd be nice to spell out "partition" rather than "part"
> here for clarity.

I'm not too big of a fan of the naming here either. I'd prefer something
like "pmu-direct". Partitioning is just a side effect of how we're
allocating counters currently and most of this implementation could be
reused if we pass the entire PMU to the guest in the future.

With that being said -- Colton I'd focus on getting these patches in
shape while we figure out what color we want it ;-)

Thanks,
Oliver

