Return-Path: <linux-kselftest+bounces-38616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BCCB1F13A
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 01:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED56E17C297
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA752741D0;
	Fri,  8 Aug 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uh8iDmv7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E925CC5B
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754694522; cv=none; b=qEJcbeie+9Xg2eHkvEqLtX8mKQuhrja9VxlKqSz1p2r4JBtn0lOxTPxHMdnEtfC1UUlFavXtrVELSSyeoZGTpYxgX1js2EWqudKMLNZ9TnaI1/mpDlGX9+w0GvQ7j0uV+F8pDMAyANPCR6EOOFMskmf16yUMXWwIT11L7VQAV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754694522; c=relaxed/simple;
	bh=kbsQ31aSNCemwZhBnbzsJeSuRfAVPY2j5geuXdv6z8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD7ROzoQPtIoFlN43hiJ5IIBrQo3ap1cFj030MH1l+5zdck32Dv9ne1c4CW+PwZEe/S/hl4opdxPAooIH0w3mtKF7EjhuXi5yT3PsztOGtlCw+NMCk4SHdpzMy1KVSyNG9tdskmPgyfmqYWqTSQ7oS5L9Z/bVADcwENW0wM4eSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uh8iDmv7; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Aug 2025 16:08:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754694507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dKxQUSmpTCdRhHeB+mUzyq09Je0k79BxYRE2H27YH/E=;
	b=uh8iDmv79ewEgnftriRVVLaUf8NnoGiKpNpDcqs/ZBuvIoGlELbgtdqdFDYNIIl66czDB2
	ounj7qjpP4ivL4I5uV6iItD2v9UdS/JHTEAoVVhAFztQ0ArM3UnQkhb34cFPXj+J6QH7y7
	918JoUjZXL5FuLYycMvc4LkU3Y1Gz2Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] KVM: arm64: PMU: Introduce
 KVM_ARM_VCPU_PMU_V3_COMPOSITION
Message-ID: <aJaDYhme_St2b2sM@linux.dev>
References: <20250806-hybrid-v2-0-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
 <20250806-hybrid-v2-1-0661aec3af8c@rsg.ci.i.u-tokyo.ac.jp>
 <aJOO99xUrhsrvLwl@linux.dev>
 <276fdfb8-f1ca-44ad-b310-a811684b265a@rsg.ci.i.u-tokyo.ac.jp>
 <aJQJdElbZJ6KzQxD@linux.dev>
 <62494f54-13c6-4b9f-86a1-9a19ce58e91f@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62494f54-13c6-4b9f-86a1-9a19ce58e91f@rsg.ci.i.u-tokyo.ac.jp>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 07, 2025 at 11:06:21PM +0900, Akihiko Odaki wrote:
> > The only cross-PMU events we will support are the fixed counters, my
> > strong preference is that we do not reverse-map architectural events to
> > generic perf events for all counters.
> 
> I wonder if there is a benefit to special case PERF_COUNT_HW_CPU_CYCLES
> then; the current logic of kvm_map_pmu_event() looks sufficient for me.

I'd rather we just use the generic perf events and let the driver remap
things on our behalf. These are fixed counters, using constant events
feels like the right way to go about that.

kvm_map_pmu_event() is trying to solve a slightly different problem
where we need to map programmable PMUv3 events into a non-PMUv3 event
space, like on the M1 PMU.

> > This isn't what I meant. What I mean is that userspace either can use
> > the SET_PMU ioctl or the COMPOSITION ioctl. Once one of them has been
> > used the other ioctl returns an error.
> > 
> > We're really bad at getting ioctl ordering / interleaving right and
> > syzkaller has a habit of finding these mistakes. There's zero practical
> > value in using both of these ioctls on the same VM, let's prevent it.
> 
> The corresponding RFC series for QEMU uses KVM_ARM_VCPU_PMU_V3_SET_PMU to
> probe host PMUs, and falls back to KVM_ARM_VCPU_PMU_V3_COMPOSITION if none
> covers all CPUs. Switching between SET_PMU and COMPOSITION is useful during
> such probing.
> 
> COMPOSITION is designed to behave like just another host PMU that is set
> with SET_PMU. SET_PMU allows setting a different host PMU even if SET_PMU
> has already been invoked so it is also allowed to set a host PMU even if
> COMPOSITION has already been invoked, maintaining consistency with
> non-composed PMUs.
> 
> You can find the QEMU patch at:
> https://lore.kernel.org/qemu-devel/20250806-kvmq-v1-1-d1d50b7058cd@rsg.ci.i.u-tokyo.ac.jp/
> 
> (look up KVM_ARM_VCPU_PMU_V3_SET_PMU for the probing code)

Having both of these attributes return success when probed with
KVM_HAS_DEVICE_ATTR is fine; what I mean is that once KVM_SET_DEVICE_ATTR
has been called on an attribute the other fails.

> > On a system that has FEAT_PMUv3_ICNTR, userspace can still use this
> > ioctl and explicitly de-feature ICNTR by writing to the ID register
> > after initialization.
> 
> Now I understand better.
> 
> Currently, KVM_ARM_VCPU_PMU_V3_COMPOSITION sets supported_cpus to ones that
> have cycle counters compatible with PMU emulation.
> 
> If FEAT_PMUv3_ICNTR is set to the ID register, I guess
> KVM_ARM_VCPU_PMU_V3_COMPOSITION will set supported_cpus to ones that have
> compatible cycle and instruction counters. If so, the naming
> KVM_ARM_VCPU_PMU_V3_FIXED_COUNTERS_ONLY indeed makes sense.

Perfect. Ideally SOC vendors do the sensible thing and ensure that
FEAT_PMUv3_ICNTR is consistent on all implementations in a machine. We
will hide the feature in KVM if it is not.

Thanks,
Oliver

