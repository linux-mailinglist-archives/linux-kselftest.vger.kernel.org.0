Return-Path: <linux-kselftest+bounces-29836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D3A72012
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 21:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02648188C66D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E396125D8FB;
	Wed, 26 Mar 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tiut/nE5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CF1EA7F3
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021627; cv=none; b=rKVWXckOxdpZnGtTLM5hnUf/YKod5ecgBZpUw721m2VNsRmckycRsPA1+J2LXXWjcFHou+JhqdHC+wK2woc5EvojjRt5yOO6qhnuM8HAri295cPYkj/OcO7kUZiIBUT31cMw6wNtR81/TO9CRaP3lsBENtDLMP+kM/SrXZw/Vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021627; c=relaxed/simple;
	bh=vsDzlSImn7SIlQBYWw98T4RqAX3WL8B/3H0BPKPwr7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1f/uiP6P5NYcEFVufuMARi8rFerQkiuaQvhTh5j4G4PLSJIhj9urTiKWu74r0/FJMtFuxzhp/u1Bz3KluBqZ2gu94VYtcbtWjaArEqfT9r2u/UBeczwM5cPzl3DyBhUMd6cX3X5kHfOUvT9jmG/P2gycsblgWzC6OidyvASq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tiut/nE5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Mar 2025 13:40:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743021623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wg2P5N/lgAa+Pjwmt6Xv30iT0//GYcryM47I3itLJEs=;
	b=tiut/nE5Sd50+xXN1DOthjMja5xf6A769EkXEIuON8c27ybVj1FLwM/UIPbk4rdmXybG84
	MMf9m+ycBH8XC+mocUwwkhYuTmxb62uNkK5Q8sdlZMjJf2WeVJy1t7AgzpI1pZFHYMrCT/
	k9ZPVoxbEfJk42i66cO5qQ4rwyy9WmI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: James Clark <james.clark@linaro.org>
Cc: Colton Lewis <coltonlewis@google.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>, kvm@vger.kernel.org,
	robh@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com,
	will@kernel.org, maz@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com,
	pbonzini@redhat.com, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 5/8] KVM: arm64: Introduce module param to
 partition the PMU
Message-ID: <Z-RmMLkTuwsea7Uk@linux.dev>
References: <gsnt1pulnepv.fsf@coltonlewis-kvm.c.googlers.com>
 <f7d543f6-2660-460f-88ac-741dd47ed440@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d543f6-2660-460f-88ac-741dd47ed440@linaro.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 26, 2025 at 05:38:34PM +0000, James Clark wrote:
> On 25/03/2025 6:32 pm, Colton Lewis wrote:
> > > I don't know if this is a stupid idea, but instead of having a fixed
> > > number for the partition, wouldn't it be nice if we could trap and
> > > increment HPMN on the first guest use of a counter, then decrement it on
> > > guest exit depending on what's still in use? The host would always
> > > assign its counters from the top down, and guests go bottom up if they
> > > want PMU passthrough. Maybe it's too complicated or won't work for
> > > various reasons, but because of BRBE the counter partitioning changes go
> > > from an optimization to almost a necessity.
> > 
> > This is a cool idea that would enable useful things. I can think of a
> > few potential problems.
> > 
> > 1. Partitioning will give guests direct access to some PMU counter
> > registers. There is no reliable way for KVM to determine what is in use
> > from that state. A counter that is disabled guest at exit might only be
> > so temporarily, which could lead to a lot of thrashing allocating and
> > deallocating counters.

KVM must always have a reliable way to determine if the PMU is in use.
If there's any counter in the vPMU for which kvm_pmu_counter_is_enabled()
is true would do the trick...

Generally speaking, I would like to see the guest/host context switch in
KVM modeled in a way similar to the debug registers, where the vPMU
registers are loaded onto hardware lazily if either:

  1) The above definition of an in-use PMU is satisfied

  2) The guest accessed a PMU register since the last vcpu_load()

> > 2. HPMN affects reads of PMCR_EL0.N, which is the standard way to
> > determine how many counters there are. If HPMN starts as a low number,
> > guests have no way of knowing there are more counters
> > available. Dynamically changing the counters available could be
> > confusing for guests.
> > 
> 
> Yes I was expecting that PMCR would have to be trapped and N reported to be
> the number of physical counters rather than how many are in the guest
> partition.

I'm not sure this is aligned with the spirit of the feature.

Colton's aim is to minimize the overheads of trapping the PMU *and*
relying on the perf subsystem for event scheduling. To do dynamic
partitioning as you've described, KVM would need to unconditionally trap
the PMU registers so it can pack the guest counters into the guest
partition. We cannot assume the VM will allocate counters sequentially.

Dynamic counter allocation can be had with the existing PMU
implementation. The partitioned PMU is an alternative userspace can
select, not a replacement for what we already have.

Thanks,
Oliver

