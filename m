Return-Path: <linux-kselftest+bounces-34180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B79ACBD65
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 00:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFC63A2111
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FC8253350;
	Mon,  2 Jun 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DRGlTg2l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31B24DD0F;
	Mon,  2 Jun 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904031; cv=none; b=dJR+UlgOQ1xgO0d4YRsHHl7/pT/wZxezYzFZlzSZKtXRu/UCCkdWVtge+eXsQ7MX8wD/cKEC2UVSGoxLmPI1SQ60VIL+qyJoyif4H+dyKLYrezGuaZiI+f5sqFC2GplNls7Oy15C+Rhgl9sAOnakKCvebfNeKJtaiWVZ/vyb2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904031; c=relaxed/simple;
	bh=Raej5S0fr0owynKaFtp+ssLwlG8DLE+hbQHXsl4GgeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWkEZodEXNRxApuRWPMiZEELJWLEtpT/joPVA0cX6y2Ei5uD4ZtUrYExEh35L5jgH8IVd23BJlBv+6zlajwTxAq96QP3wmpOjFaBcs3HNSXMBt2RSZVStMt58tR8hbt/lj2ONWifc8/5HMEjYV5bWBKiAVJbPz8v4kpPmESMe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DRGlTg2l; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Jun 2025 15:40:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748904017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pVDqG7Qru3dfMpTwDZ3dCGAw70KwMy1IAEgL6+IAtD0=;
	b=DRGlTg2l6dj3mx3YU+Hkrx8unn1zTLt40R3DTpki2p/KXrAfQdCsBTXlNY3/1LiA5NL/C3
	AKu5HQu4fMzKoqvysZOOGOi+dS5HDBNebnMVbg8Q3KTQ3HS+lmWRWnqZ0S7Jx7EQrbL9cC
	j1ccMBNvsr0LPvKUOue0qfpmAfPYP1w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 16/17] KVM: arm64: Add ioctl to partition the PMU when
 supported
Message-ID: <aD4oS1_tnMPlgDJ6@linux.dev>
References: <20250602192702.2125115-1-coltonlewis@google.com>
 <20250602192702.2125115-17-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602192702.2125115-17-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 07:27:01PM +0000, Colton Lewis wrote:
> +	case KVM_ARM_PARTITION_PMU: {

This should be a vCPU attribute similar to the other PMUv3 controls we
already have. Ideally a single attribute where userspace tells us it
wants paritioning and specifies the PMU ID to use. None of this can be
changed after INIT'ing the PMU.

> +		struct arm_pmu *pmu;
> +		u8 host_counters;
> +
> +		if (unlikely(!kvm_vcpu_initialized(vcpu)))
> +			return -ENOEXEC;
> +
> +		if (!kvm_pmu_partition_supported())
> +			return -EPERM;
> +
> +		if (copy_from_user(&host_counters, argp, sizeof(host_counters)))
> +			return -EFAULT;
> +
> +		pmu = vcpu->kvm->arch.arm_pmu;
> +		return kvm_pmu_partition(pmu, host_counters);

Yeah, we really can't be changing the counters available to the ARM PMU
driver at this point. What happens to host events already scheduled on
the CPU?

Either the partition of host / KVM-owned counters needs to be computed
up front (prior to scheduling events) or KVM needs a way to direct perf
to reschedule events on the PMU based on the new operating constraints.

Thanks,
Oliver

