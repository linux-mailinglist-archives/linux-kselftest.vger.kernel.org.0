Return-Path: <linux-kselftest+bounces-30184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C830A7D399
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DED188C7E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 05:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B612C224246;
	Mon,  7 Apr 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ho0knh0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1F224241
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744004152; cv=none; b=BZShlNZFSfPW1+C3O+liN+YGJ4UxH5crTUbwXsD/a5uC32a3WnWGKTmRHdEVIFEiUIYK1b1pwWz5Q88PnNwgglG9REM6l1GrYV0i6LjQfZ+DlRNGQL+XC7rBUjWmSVhX93S/iDnPP4OZ3zCdewMbxE6uEKxUxMi4DV+QAXwfG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744004152; c=relaxed/simple;
	bh=GdhxnSjy0DInCZdHnnjNeLTcrqCu8hav/hskR37tAW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd+SGGUkXMoR9PMwkoyahVPCxglw7aNAr8j9nbQQC3SZscQeP3anl9o5mVVtj0MQDfnNREFnhnz2y/0ZeK6slSTb3HrzdM8b2ZfWuig09cumdrcY4fK0zAIhD77oW4/2ZH0q5NCugDlhMqihUOfLlXP4Leo7GUAaMJ4zo+92btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ho0knh0x; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 6 Apr 2025 22:35:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744004138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNfyjJ36NwMo27wB3yA4lOZ9U2Fsk9+3dltOkC7RDUE=;
	b=Ho0knh0xTy/U6S07jKpiwc1tvurITGV4mcne2YhLXL2Rn6cx3FnLTTNaMt27AwnJgeBq6H
	+TzMKPCaBi/Ke6MgVhhKc9uyOD2BPbMMn3jOQSa5bxoveD0Tb0fYKCBa4KW7K9ohcrUd6O
	D3h0nI+wvSMyFHJP3zSreSgpZecBsKA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	shuah@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH v2 6/6] KVM: arm64: Handle DABT caused by LS64*
 instructions on unsupported memory
Message-ID: <Z_NkHWStDJLo0cmY@linux.dev>
References: <20250331094320.35226-1-yangyicong@huawei.com>
 <20250331094320.35226-7-yangyicong@huawei.com>
 <Z-wQuJAefT3xNipl@linux.dev>
 <e9674079-9a22-c3cd-3b00-5989f6926303@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9674079-9a22-c3cd-3b00-5989f6926303@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 07, 2025 at 11:33:01AM +0800, Yicong Yang wrote:
> On 2025/4/2 0:13, Oliver Upton wrote:
> > On Mon, Mar 31, 2025 at 05:43:20PM +0800, Yicong Yang wrote:
> >> @@ -1658,6 +1658,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > Keep in mind that data aborts with DFSC == 0x35 can happen for a lot
> > more than LS64 instructions, e.g. an atomic on a Device-* mapping.
> > 
> 
> got it. 0x35 should be caused by LS64* or IMPLEMENTATION DEFINED fault, but no
> further hint to distinguish between these two faults. hope it's also the right
> behaviour to inject a DABT back for the latter case.

There isn't exactly a 'right' behavior here. The abort could either be
due to a bug in the guest (doing an access on something knows it can't)
or the VMM creating / describing the IPA memory map incorrectly.

Since KVM can't really work out who's to blame in this situation we should
probably exit to userspace + provide a way to reinject the abort.

> >> @@ -1919,6 +1939,21 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
> >>  			goto out_unlock;
> >>  		}
> >>  
> >> +		/*
> >> +		 * If instructions of FEAT_{LS64, LS64_V} operated on
> >> +		 * unsupported memory regions, a DABT for unsupported
> >> +		 * Exclusive or atomic access is generated. It's
> >> +		 * implementation defined whether the exception will
> >> +		 * be taken to, a stage-1 DABT or the final enabled
> >> +		 * stage of translation (stage-2 in this case as we
> >> +		 * hit here). Inject a DABT to the guest to handle it
> >> +		 * if it's implemented as a stage-2 DABT.
> >> +		 */
> >> +		if (esr_fsc_is_excl_atomic_fault(esr)) {
> >> +			kvm_inject_dabt_excl_atomic(vcpu, kvm_vcpu_get_hfar(vcpu));
> >> +			return 1;
> >> +		}
> >> +
> > 
> > A precondition of taking such a data abort is having a valid mapping at
> > stage-2. If KVM can't resolve the HVA of the fault then there couldn't
> > have been a stage-2 mapping.
> > 
> 
> Here's handling the case for emulated mmio, I thought there's no valid stage-2 mapping
> for the emulated MMIO? so this check is put just before entering io_mem_abort(). should
> it be put into io_mem_abort() or we just don't handle the emulated case?

Right -- there's no valid stage-2 translation for _most_ MMIO. If KVM
cannot find an HVA for the fault (look at the condition that gets us
here) then we know there isn't a stage-2 mapping. How would we know what
to map?

In that case I would expect to take a Translation fault with instruction
syndrome that can can be used to construct an exit to the VMM. Marc had
some patches on list to do exactly that [*].

However, after reading this again there's a rather ugly catch. The KVM
ABI has it that writes to a RO memlot generate an MMIO exit, so it *is*
possible to get here w/ a stage-2 mapping. Unfortunately there's no
instruction syndrome with DFSC = 0x35 so no way to decode the access.

This is starting to sound similar an nISV MMIO abort...

[*]: https://lore.kernel.org/kvmarm/20240815125959.2097734-1-maz@kernel.org/

Thanks,
Oliver

