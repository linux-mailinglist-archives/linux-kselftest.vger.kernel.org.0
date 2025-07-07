Return-Path: <linux-kselftest+bounces-36716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612CAFB956
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E2D560616
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A385288CB7;
	Mon,  7 Jul 2025 16:57:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493C2882AD;
	Mon,  7 Jul 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907446; cv=none; b=j5VyKHVvL7Prd681y7RLBO9aBDvMVc1wxyuDS2y3qC+JX9mJ3sx6hEciKUFbca6xc+R+C8rbjmpY+EfXINTfGMD37Nkdgahs0zfKe+8eT8+bwMxSC0d78fpur+S+yxmo6KWoCs/fqwlaJ/sNn/+6McVcX3VUL5eb2BtA8w+lBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907446; c=relaxed/simple;
	bh=j2khcFUinkH1uYfmMyEuGFke8NnTBnK52CLLmomduwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZFOGUTA/WF9oDvx8SLXD0Ui34I4suYwclwfSx51BFzX9qKhFqpK2Tyk9C4HJGo1i/tJ4WxJ6tkxHoAVPLutm9TO+C1qSlbdjZe0qpCaZL/XvH5Lc/npOzKTYs0yI6CU11HL7mBSMP8QzGEDORJzkAFK8KufjAA3eOLSadIeXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D9BB168F;
	Mon,  7 Jul 2025 09:57:11 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4EDF3F66E;
	Mon,  7 Jul 2025 09:57:19 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:57:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 06/22] perf: arm_pmuv3: Introduce method to partition
 the PMU
Message-ID: <aGv8arq8NgaRCu7h@J2N7QTR9R3>
References: <20250626200459.1153955-1-coltonlewis@google.com>
 <20250626200459.1153955-7-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200459.1153955-7-coltonlewis@google.com>

On Thu, Jun 26, 2025 at 08:04:42PM +0000, Colton Lewis wrote:
> For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
> counters into two ranges where counters 0..HPMN-1 are accessible by
> EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
> EL2.
> 
> Create module parameter reserved_host_counters to reserve a number of
> counters for the host. This number is set at boot because the perf
> subsystem assumes the number of counters will not change after the PMU
> is probed.
> 
> Introduce the function armv8pmu_partition() to modify the PMU driver's
> cntr_mask of available counters to exclude the counters being reserved
> for the guest and record reserved_guest_counters as the maximum
> allowable value for HPMN.
> 
> Due to the difficulty this feature would create for the driver running
> at EL1 on the host, partitioning is only allowed in VHE mode. Working
> on nVHE mode would require a hypercall for every counter access in the
> driver because the counters reserved for the host by HPMN are only
> accessible to EL2.

It would be good if we could elaborate on this last point. When exactly
do we intend to configure HPMN (e.g. is that static, dynamic at
load/put, or dynamic at finer granularity)?

I ask becuase it's not immediately clear to me how this would break nVHE
without also breaking direct userspace access on VHE, unless we flip
HPMN dynamically at load/put, and this is only broken in some transient
windows on nVHE.

> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm/include/asm/arm_pmuv3.h   | 14 ++++++
>  arch/arm64/include/asm/arm_pmuv3.h |  5 ++
>  arch/arm64/include/asm/kvm_pmu.h   |  6 +++
>  arch/arm64/kvm/Makefile            |  2 +-
>  arch/arm64/kvm/pmu-part.c          | 23 ++++++++++

Maybe I'll contradict Oliver and Marc here (and whatever they say
rules), but IMO it'd be nice to spell out "partition" rather than "part"
here for clarity.

Mark.

