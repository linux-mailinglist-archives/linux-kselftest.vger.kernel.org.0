Return-Path: <linux-kselftest+bounces-35669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5BAE5D64
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3AB1B6746E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE6255F53;
	Tue, 24 Jun 2025 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YdCNEjXQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B40239567
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748725; cv=none; b=LsCwCZhSEtA0YRgi0xT8ZxCP+v8xTID/5bnWnBDnx1f82+qW4XpZYM9RyAXyD0DLr3z9UfNN++yFuSb0N5G8AITn5AJWe1re9WyeCOl0T24rM2MCS0En1/nWO/d7EY93Je6L4Wvcg6IQrHBVHFrIq5lDcjluNw7AY364gy6TBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748725; c=relaxed/simple;
	bh=uCj01wXJRSXVsrZB3o811ZhTorLLjK4lSt9J6v1K598=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9YG/4uLSzyn+74iGQRg5e+lI3MFw/xRz4X9ZIaKZR9UXHe+Tg6mt1iUIwh+kOxrILr3XsMNE/x+x74xRI54u52dOq55akpcs56cnE1B4e175MEjnfquc+vSVDd1Ck1U4PorCGiat34QSjqX6Kloo0EnML+jjZvoVn9eKIv2zHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YdCNEjXQ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Jun 2025 00:05:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750748720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rvl+LfkUxz42F+u2AhuU0DC7MpN+KcVkghfyXMKrAJU=;
	b=YdCNEjXQf9Nhf5KzU5i8ggHBOyIXgK50+X3MqptwbGqKbrP84GlAPmVg79d0ScGVzHNWqI
	9KAlGO56nfnuIB3W0BcRK3X5GneOcZB9c6cWMPJsMsmV7O7M5uCWupxxC81piynZV/OZ4M
	jVC45rQOrDmJbnTY2tgEni5IU6Cvt4M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, mark.rutland@arm.com, shuah@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 07/23] perf: arm_pmuv3: Introduce method to partition
 the PMU
Message-ID: <aFpOI7cWTOAIjNjV@linux.dev>
References: <aFYFqrYRsmCi6oii@linux.dev>
 <gsntpleu9uvx.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsntpleu9uvx.fsf@coltonlewis-kvm.c.googlers.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 23, 2025 at 06:26:42PM +0000, Colton Lewis wrote:
> Oliver Upton <oliver.upton@linux.dev> writes:
> 
> > On Fri, Jun 20, 2025 at 10:13:07PM +0000, Colton Lewis wrote:
> > > For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
> > > counters into two ranges where counters 0..HPMN-1 are accessible by
> > > EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
> > > EL2.
> 
> > > Create module parameters partition_pmu and reserved_guest_counters to
> > > reserve a number of counters for the guest. These numbers are set at
> > > boot because the perf subsystem assumes the number of counters will
> > > not change after the PMU is probed.
> 
> > > Introduce the function armv8pmu_partition() to modify the PMU driver's
> > > cntr_mask of available counters to exclude the counters being reserved
> > > for the guest and record reserved_guest_counters as the maximum
> > > allowable value for HPMN.
> 
> > > Due to the difficulty this feature would create for the driver running
> > > at EL1 on the host, partitioning is only allowed in VHE mode. Working
> > > on nVHE mode would require a hypercall for every counter access in the
> > > driver because the counters reserved for the host by HPMN are only
> > > accessible to EL2.
> 
> > > Signed-off-by: Colton Lewis <coltonlewis@google.com>
> > > ---
> > >   arch/arm/include/asm/arm_pmuv3.h   | 10 ++++
> > >   arch/arm64/include/asm/arm_pmuv3.h |  5 ++
> > >   drivers/perf/arm_pmuv3.c           | 95 +++++++++++++++++++++++++++++-
> > >   include/linux/perf/arm_pmu.h       |  1 +
> > >   4 files changed, 109 insertions(+), 2 deletions(-)
> 
> > > diff --git a/arch/arm/include/asm/arm_pmuv3.h
> > > b/arch/arm/include/asm/arm_pmuv3.h
> > > index 2ec0e5e83fc9..9dc43242538c 100644
> > > --- a/arch/arm/include/asm/arm_pmuv3.h
> > > +++ b/arch/arm/include/asm/arm_pmuv3.h
> > > @@ -228,6 +228,11 @@ static inline bool kvm_set_pmuserenr(u64 val)
> 
> > >   static inline void kvm_vcpu_pmu_resync_el0(void) {}
> 
> > > +static inline bool has_vhe(void)
> > > +{
> > > +	return false;
> > > +}
> > > +
> 
> > This has nothing to do with PMUv3, I'm a bit surprised to see you're
> > touching 32-bit ARM. Can you just gate the whole partitioning thing on
> > arm64?
> 
> The PMUv3 driver also has to compile on 32-bit ARM.

Quite aware.

> My first series had the partitioning code in arch/arm64 but you asked me
> to move it to the PMUv3 driver.
> 
> How are you suggesting I square those two requirements?

You should try to structure your predicates in such a way that the
partitioning stuff all resolves to false for 32 bit arm, generally. That
way we can avoid stubbing out silly things like has_vhe() which doesn't
make sense in the context of 32 bit.

> > > +static bool partition_pmu __read_mostly;
> > > +static u8 reserved_guest_counters __read_mostly;
> > > +
> > > +module_param(partition_pmu, bool, 0);
> > > +MODULE_PARM_DESC(partition_pmu,
> > > +		 "Partition the PMU into host and guest VM counters [y/n]");
> > > +
> > > +module_param(reserved_guest_counters, byte, 0);
> > > +MODULE_PARM_DESC(reserved_guest_counters,
> > > +		 "How many counters to reserve for guest VMs [0-$NR_COUNTERS]");
> > > +
> 
> > This is confusing and not what we discussed offline.
> 
> > Please use a single parameter that describes the number of counters used
> > by the *host*. This affects the *host* PMU driver, KVM can discover (and
> > use) the leftovers.
> 
> > If the single module parameter goes unspecified the user did not ask for
> > PMU partitioning.
> 
> I understand what we discussed offline, but I had a dilemma.
> 
> If we do a single module parameter for number of counters used by the
> host, then it defaults to 0 if unset and there is no way to distinguish
> between no partitioning and a request for partitioning reserving 0
> counters to the host which I also thought you requested. Would you be
> happy leaving no way to specify that?

You can make the command line use a signed integer for storage and a
reset value of -1.

-1 would imply default behavior (no partitioning) and a non-negative
value would imply partitioning.

> In any case, I think the usage is more self explainatory if
> partitition=[y/n] is a separate bit.

What would be the user's intent of "partition_pmu=n reserved_guest_counters=$X"?

Thanks,
Oliver

