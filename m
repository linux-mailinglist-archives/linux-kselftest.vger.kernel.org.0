Return-Path: <linux-kselftest+bounces-30935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD826A8B019
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 08:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C440D7A72BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 06:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63766228CB0;
	Wed, 16 Apr 2025 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eujBp9rq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE13597A;
	Wed, 16 Apr 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784086; cv=none; b=WUgm4vYB8llqNU4EQjdYbHfNkti2aBcqh37D/lGeqprfo4G+W72jH/gwhA6dftKlHn+XXpd3wQa9oquJvydl2cDlI3+l7DpLzA1m6frEqh4f3YPFQklRfxWeCUeie8fKvldnp3nZ/ZiVm5xtMcSqBJWbgKWbBSs8fEUSyB3pq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784086; c=relaxed/simple;
	bh=ahgfbY/XFvutx4yIjSm3pu32rAZiF6vDzwoBmJnFFDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVmBLO/f98aSinds0eUEQv6B89T5AIJ4WlIC37sZkwG7xzWTrvcPmuRtuCqAQUUXicG7U/GiPP+mtDs6lK8mWHLHPMav8UXGOpGE/4c0uVXu8b+PqC54mJG/iyPR3va/R3tge/wRK6+1AE+kH5roMQBz8NxHZvwu1SIxn0km9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eujBp9rq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744784084; x=1776320084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ahgfbY/XFvutx4yIjSm3pu32rAZiF6vDzwoBmJnFFDI=;
  b=eujBp9rqhHt12JSu+WAcHGxGngFZcbFBdYPa02BSovBsCr6HB3m6NWYM
   A14ABfbM9T4EHxIZXTg403z2+6jLBrn/bfpGrK3xy4GhiW865W6LHmqpS
   wEHmu5Xm6UdQangT80o1A1IVXAR5FCwSJ0o1GJwutN53AZ3UQyHmKgURL
   5OGEUYxm4uJ+9/8lKUXGys4DtQcUhxJBoxyk9C4zdXppbNrJMOqOL7nuf
   Nf4aNUJG7qcUghnJ+XAsr0cu2v4LdNw8DA10/+dxn9PLF0rNsEeffUFn7
   AkyfBDTlSSf3VRg/65WzObqtPKELuM/bllfIN1Exa+SbmsVrGWtoURfOx
   Q==;
X-CSE-ConnectionGUID: IYk4oho4QTyfHl40HQjVXg==
X-CSE-MsgGUID: 7H8n75R6TmWetlxLciHq0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="68806460"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="68806460"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:14:43 -0700
X-CSE-ConnectionGUID: NoEJcen6RLSOvwa5s4NA+A==
X-CSE-MsgGUID: +IFZaShjRzmPyStPcZ1M5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130108682"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1]) ([10.124.247.1])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:14:38 -0700
Message-ID: <5fb4f5f8-55d2-44a7-808e-76c8a452cd2f@intel.com>
Date: Wed, 16 Apr 2025 14:14:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] KVM: SVM: Add support for
 KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
To: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, nikunj@amd.com,
 thomas.lendacky@amd.com, bp@alien8.de
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-5-manali.shukla@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250324130248.126036-5-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/2025 9:02 PM, Manali Shukla wrote:
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5fe84f2427b5..f7c925aa0c4f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7909,6 +7909,25 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
>   KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
>   to KVM_EXIT_X86_BUS_LOCK.
>   
> +Note! KVM_CAP_X86_BUS_LOCK_EXIT on AMD CPUs with the Bus Lock Threshold is close
> +enough  to INTEL's Bus Lock Detection VM-Exit to allow using
> +KVM_CAP_X86_BUS_LOCK_EXIT for AMD CPUs.
> +
> +The biggest difference between the two features is that Threshold (AMD CPUs) is
> +fault-like i.e. the bus lock exit to user space occurs with RIP pointing at the
> +offending instruction, whereas Detection (Intel CPUs) is trap-like i.e. the bus
> +lock exit to user space occurs with RIP pointing at the instruction right after
> +the guilty one.
>


> +The bus lock threshold on AMD CPUs provides a per-VMCB counter which is
> +decremented every time a bus lock occurs, and a VM-Exit is triggered if and only
> +if the bus lock counter is '0'.
> +
> +To provide Detection-like semantics for AMD CPUs, the bus lock counter has been
> +initialized to '0', i.e. exit on every bus lock, and when re-executing the
> +guilty instruction, the bus lock counter has been set to '1' to effectively step
> +past the instruction.

 From the perspective of API, I don't think the last two paragraphs 
matter much to userspace.

It should describe what userspace can/should do. E.g., when exit to 
userspace due to bus lock on AMD platform, the RIP points at the 
instruction which causes the bus lock. Userspace can advance the RIP 
itself before re-enter the guest to make progress. If userspace doesn't 
change the RIP, KVM internal can handle it by making the re-execution of 
the instruction doesn't trigger bus lock VM exit to allow progress.

